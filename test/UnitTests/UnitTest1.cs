using Device.Simulator;
using Microsoft.Extensions.Logging.Abstractions;
using System.Threading;
using System.Threading.Tasks;
using Xunit;

namespace UnitTests
{
    public class UnitTest1
    {
        [Fact]
        public async Task Test1()
        {
            var worker = new Worker(NullLogger<Worker>.Instance);
            var cancellation = new CancellationTokenSource();

            await worker.StartAsync(cancellation.Token);

            await Task.Delay(2000);
            cancellation.Cancel();
        }
    }
}
