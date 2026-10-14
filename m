Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1948CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F30D10FEAD;
	Wed, 14 Oct 2026 16:21:57 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6379310FEAD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfZWkJEZr40WvpZfSURIwtDoEkTSiD+aG5R2BYOv4Pj+W3fMPDj466Rcd8yfsTBGlXXbhNQpbd0vK4T3vsNR8tBORGp3n7TsgS5Jzc2hiacnuW1rYoptol2wXdlBOKMbztIAfi+ESZ3TB7DsEwuZTDMleRVRUl3Gxir8/uR5smtTwywGtnCyXxF1HlZ7GwjMPiUk2unnCCqxr3xrcojb36uJQvlD5S2KVHL8vYcs38k8VeY0j61fM6uyKtG49kLmfGBDPF8xX+TK2XKbUkdRBLKeAFSIXjuf6o2ZaKdV/HUgTS6vEoQitN1/AlVjow7sGccxU4/V+VrbtJhgLZQfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wSJax2ctsrw3KbRdfRDCslswzMPto97cAColEUQg+I=;
 b=qypJqfhsK7+LWwFd3tUUGMTEZN4RCmsOtkaSKvHRx0beh/cGflX9ClSjYZphLTYrEX6XIIZoj0gypl7HWuKPY5gkLqOPv0nOXUttxtOcOjDpMQI760qX7Nj7NXHMdv/WIleK6RtFd9DKhJX8akmE+lxPbb7kh8J7Y87mmobc4n4JsIrSRIZz54UjLBIH16eRGNj/Uoy3basUhkiafhxN+qGbe6TvZleBWz03qe68/ev58mCKTLDps+aLrUFgEpQsFmb7O4WTxegalEhP9qFe1J+35NcBs/cu23jqB1c7pyogAv+Pst8skHHJWkUiCdkD7JMVm0F9Zb+tBcN8XhZUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wSJax2ctsrw3KbRdfRDCslswzMPto97cAColEUQg+I=;
 b=MhT+s2xnVDWJUShPwIbRnKXaGp8vNGuq9m1PU0r434SpqZ0HiTOxxfDHx5JxJYfaU8YQbV8T1Gs7jg6DplHqy0uDXU5bDO4GpRFKd7aZXgReGJM/vxmeJdY9HN6YNqqqULcwBNNj2SkUZvUxLTONcpggv9V4hAdqSNGs7OQ/UlI=
Received: from CH2PR18CA0051.namprd18.prod.outlook.com (2603:10b6:610:55::31)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 16:21:44 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:610:55:cafe::a9) by CH2PR18CA0051.outlook.office365.com
 (2603:10b6:610:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 16:21:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 16:21:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 11:21:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 11:21:37 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 11:21:36 -0500
Message-ID: <6df59031-1f6a-ab1d-16a3-4525727ba644@amd.com>
Date: Wed, 14 Oct 2026 09:21:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Expose NPU device busy time via DRM
 fdinfo
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261012180808.2548697-1-max.zhen@amd.com>
 <9a73a766-55f6-386f-0ec2-2ca3f4a987db@amd.com>
In-Reply-To: <9a73a766-55f6-386f-0ec2-2ca3f4a987db@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c25422-be35-4ffd-fbb3-08df2a0f3cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 0Wk1A5YfOeemVbN5SwCs6Q0xkf462WpPo7ZH52dqbEf+HwH+PPuz7SsLLPgyBAEM/SjLRribG4kGDx4S2nDcSzeMTB3H9ui+mASND1R/BHOd01OaQ368NoycF7tRGXeN0R5+b8QW2uR3mN4HijYxQ7U30+HykOY1BQjcx0eH1mXEtCj00/hSXaOJ4PLOBCbU1FwsBkP9Vsm5gYQ44YgD7bL7KH400dvsEKonTTlXfaoJnCYxreKaQDfhlJyllKIsKOsIzMpc4mrPwjjqZujib3vHP5KL7kcWtC/JSxt9GT4rl+fjrOwodpb2brC3y83RcSG4Fz0dh5UUEv3CmOp9RqJMbocy57aaVv3iEOtsbi7s4XlRwvaFJ5CdKnqgn5tzySjMQl1Z/6FxtMij1WlxG8ZaI85mMH61iLkmsxu0vHEM8zzm0sbPg0pQV5MoMfoHI1GNauA0h7A6y7y+Pi8QkeIwsiAGX8m/x9cDvzxkHpfYUbUivwwZwldh0GQ1RJtHhlNUR2afxdzAYH2chgGiYy7k4ffEvcCCKnoD4rO8M1WgQLqlP7sw2rDhMPNUyjI3pygVcyBjC9tqW5aUud5ygUyuoaECK7CsuzNPMoSGko2h0xQHN+uzw/UG2SD/RlKx83csx9GnQNW+i9IBT3ZINP6FexVs5Qq2HmKaMLFca6vMYC8aphBY43e8OhQQWHvzR08W+II8jKkQM3azPHK2Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mCWyQG6XYg3jzTkEYVJDuSEGifncfcZFagqx4ra+vP3q/B7ZHX5z7qefgbcFW377HI9gtYyIhye6u2j+8HN75TNoWrsPOmwS4Gf3oo8MLlFiR/If07G4hD/UAH1G1A8Cl2ieuyk5RAGWWGxiCHpDrZC4hMgrU/jVJpDU8T/IcU/CflBIlhD2Zts1QGbdvXq050SWd8V0MjqD0/m0ew2E1EAV8WdmOQyUOFrFTDjwObZTM7D9yvGPB3ZB4IJFPGmOdOL/Pb5pkU7gzj+08HoHz6tBvSMvw9hQLog1Kug9ugtPRwIIf9EM3QrYFCA/hv7eOmcUOXFljxn3alOUNrJhYfuUg/mZs+ypajXiCHXeaLDBsIFPDLL683VDQJNKhkjgaVRVrtV5RtdnHVVNFE0ZR71MdOH9QPUrWsZxK3MHWLWF/d4B+nevjFnRIeu6q2d0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:21:44.0224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c25422-be35-4ffd-fbb3-08df2a0f3cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Applied to drm-misc-next

On 10/13/26 10:02, Lizhi Hou wrote:
>
> On 10/12/26 11:08, Max Zhen wrote:
>> Expose NPU device engine busy time through DRM fdinfo to enable
>> standardized userspace monitoring and profiling.
>>
>> Add support for reporting per-engine busy time in nanoseconds
>> via fdinfo using the "drm-engine-<driver-name>" key. The value
>
> It should be "drm-engine-npu" key here. I will change it when I merge.
>
> Lizhi
>
>> reflects the accumulated NPU device execution time for a given
>> process, allowing userspace tools to observe NPU device
>> utilization without driver-specific ioctls.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   Documentation/accel/amdxdna/amdnpu.rst  |  1 +
>>   drivers/accel/amdxdna/aie.c             | 39 +++++++++++++++++++++++++
>>   drivers/accel/amdxdna/aie.h             |  4 +++
>>   drivers/accel/amdxdna/aie2_ctx.c        |  6 ++++
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  6 ++++
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  9 ++++++
>>   6 files changed, 65 insertions(+)
>>
>> diff --git a/Documentation/accel/amdxdna/amdnpu.rst 
>> b/Documentation/accel/amdxdna/amdnpu.rst
>> index 064973bf4893..d72af1b51ccf 100644
>> --- a/Documentation/accel/amdxdna/amdnpu.rst
>> +++ b/Documentation/accel/amdxdna/amdnpu.rst
>> @@ -289,6 +289,7 @@ Example of the output showing the implemented key 
>> value pairs:
>>           drm-driver:    amdxdna_accel_driver
>>           drm-client-id:    3219
>>           drm-pdev:    0000:c5:00.1
>> +        drm-engine-npu: 14003870 ns
>>           amdxdna_accel_driver-heap-alloc:    60 KiB
>>           amdxdna_accel_driver-internal-alloc:    67588 KiB
>>           amdxdna_accel_driver-external-alloc:    0
>> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
>> index dd6f36f222c7..bf8eb66baab8 100644
>> --- a/drivers/accel/amdxdna/aie.c
>> +++ b/drivers/accel/amdxdna/aie.c
>> @@ -118,6 +118,45 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>>       amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
>>   }
>>   +void amdxdna_io_stats_job_start(struct amdxdna_client *client)
>> +{
>> +    int depth;
>> +
>> +    guard(spinlock)(&client->io_stats.lock);
>> +
>> +    depth = client->io_stats.job_depth++;
>> +    if (!depth)
>> +        client->io_stats.start_time = ktime_get_ns();
>> +}
>> +
>> +void amdxdna_io_stats_job_done(struct amdxdna_client *client)
>> +{
>> +    u64 busy_ns;
>> +    int depth;
>> +
>> +    guard(spinlock)(&client->io_stats.lock);
>> +
>> +    depth = --client->io_stats.job_depth;
>> +    if (!depth) {
>> +        busy_ns = ktime_get_ns() - client->io_stats.start_time;
>> +        client->io_stats.start_time = 0;
>> +        client->io_stats.busy_time += busy_ns;
>> +    }
>> +}
>> +
>> +u64 amdxdna_io_stats_busy_time_ns(struct amdxdna_client *client)
>> +{
>> +    u64 busy_ns;
>> +
>> +    guard(spinlock)(&client->io_stats.lock);
>> +
>> +    busy_ns = client->io_stats.busy_time;
>> +    if (client->io_stats.job_depth)
>> +        busy_ns += ktime_get_ns() - client->io_stats.start_time;
>> +
>> +    return busy_ns;
>> +}
>> +
>>   int amdxdna_get_metadata(struct aie_device *aie,
>>                struct amdxdna_client *client,
>>                struct amdxdna_drm_get_info *args)
>> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
>> index 0483d582b7f8..1fc5ddfe696a 100644
>> --- a/drivers/accel/amdxdna/aie.h
>> +++ b/drivers/accel/amdxdna/aie.h
>> @@ -117,4 +117,8 @@ void aie_smu_fini(struct smu_device *smu);
>>   int aie_smu_set_clocks(struct smu_device *smu, u32 *npuclk, u32 
>> *hclk);
>>   int aie_smu_set_dpm(struct smu_device *smu, u32 dpm_level);
>>   +void amdxdna_io_stats_job_start(struct amdxdna_client *client);
>> +void amdxdna_io_stats_job_done(struct amdxdna_client *client);
>> +u64 amdxdna_io_stats_busy_time_ns(struct amdxdna_client *client);
>> +
>>   #endif /* _AIE_H_ */
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index d927c8c9d557..9c6b7353cbe9 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -290,6 +290,7 @@ aie2_sched_resp_handler(void *handle, void 
>> __iomem *data, size_t size)
>>       int ret = 0;
>>       u32 status;
>>   +    amdxdna_io_stats_job_done(job->hwctx->client);
>>       cmd_abo = job->cmd_bo;
>>         if (unlikely(job->job_timeout)) {
>> @@ -322,6 +323,8 @@ aie2_sched_drvcmd_resp_handler(void *handle, void 
>> __iomem *data, size_t size)
>>       struct amdxdna_sched_job *job = handle;
>>       int ret = 0;
>>   +    amdxdna_io_stats_job_done(job->hwctx->client);
>> +
>>       if (unlikely(!data || size != sizeof(u32))) {
>>           job->drv_cmd->result = U32_MAX;
>>           ret = -EINVAL;
>> @@ -344,6 +347,7 @@ aie2_sched_cmdlist_resp_handler(void *handle, 
>> void __iomem *data, size_t size)
>>       u32 cmd_status;
>>       int ret = 0;
>>   +    amdxdna_io_stats_job_done(job->hwctx->client);
>>       cmd_abo = job->cmd_bo;
>>         if (unlikely(job->job_timeout)) {
>> @@ -405,6 +409,7 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>>       kref_get(&job->refcnt);
>>       fence = dma_fence_get(job->fence);
>>   +    amdxdna_io_stats_job_start(job->hwctx->client);
>>       if (job->drv_cmd) {
>>           switch (job->drv_cmd->opcode) {
>>           case SYNC_DEBUG_BO:
>> @@ -432,6 +437,7 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>>     out:
>>       if (ret) {
>> +        amdxdna_io_stats_job_done(job->hwctx->client);
>>           dma_fence_put(job->fence);
>>           aie2_job_put(job);
>>           mmput(job->mm);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index bb339e641416..67a02d6b7f97 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/iommu.h>
>>   #include <linux/pci.h>
>>   +#include "aie.h"
>>   #include "amdxdna_cbuf.h"
>>   #include "amdxdna_ctx.h"
>>   #include "amdxdna_debugfs.h"
>> @@ -151,6 +152,8 @@ static int amdxdna_drm_open(struct drm_device 
>> *ddev, struct drm_file *filp)
>>       filp->driver_priv = client;
>>       client->filp = filp;
>>   +    spin_lock_init(&client->io_stats.lock);
>> +
>>       XDNA_DBG(xdna, "pid %d opened", client->pid);
>>       return 0;
>>   @@ -287,6 +290,9 @@ static void amdxdna_show_fdinfo(struct 
>> drm_printer *p, struct drm_file *filp)
>>       size_t heap_usage, external_usage, internal_usage;
>>       char *drv_name = filp->minor->dev->driver->name;
>>   +    drm_printf(p, "drm-engine-npu:\t%llu ns\n",
>> +           amdxdna_io_stats_busy_time_ns(client));
>> +
>>       mutex_lock(&client->mm_lock);
>>         heap_usage = client->heap_usage;
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index a997d27a504d..510356a31532 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -143,6 +143,13 @@ struct amdxdna_device_id {
>>       const struct amdxdna_dev_info *dev_info;
>>   };
>>   +struct amdxdna_io_stats {
>> +    spinlock_t            lock; /* protect io stats */
>> +    int                job_depth;
>> +    u64                start_time;
>> +    u64                busy_time;
>> +};
>> +
>>   /*
>>    * struct amdxdna_client - amdxdna client
>>    * A per fd data structure for managing context and other user 
>> process stuffs.
>> @@ -169,6 +176,8 @@ struct amdxdna_client {
>>       size_t                heap_usage;
>>       size_t                total_bo_usage;
>>       size_t                total_int_bo_usage;
>> +
>> +    struct amdxdna_io_stats        io_stats;
>>   };
>>     #define amdxdna_for_each_hwctx(client, hwctx_id, entry)        \
