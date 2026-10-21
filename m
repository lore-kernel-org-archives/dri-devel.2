Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B2606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RBhOYNvP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EFB10E144;
	Wed, 21 Oct 2026 17:00:37 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD6B10E144
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btoWnv5z254KD6YXP8Z/OHfVvF8Rzb5qsvmdEAjmSSJKQjnVXjYGQLz+t9DfYpTifhXMbJke6gfCp95/tWkzm2BwV92BN/JNgQK8YXsEkyeiX4/q/UU3DsWDvepoVgyg2ue0P16s+ZXSQEEgBEbxKeUZ7a+BcZvP1XtcTCB8/2N+uamMfiBedo/iXqdRD0FFE+RTEA5CisVmo8YIVy/d91eGlc2qulMkdoNKWcgtfmkjAa9tJngfoVlB46dkChI8T5d2pLWGs56NIlt4QrXh45dIgQ19kn6chT/soCRcy4f0gU0SBJDFZnE5shwr7ep96X0H80oddL610FTjR/rQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFrUkvbRvnB6rIu2tGpx0aWfwrMMnuSOBXSVnZMAPDQ=;
 b=XxMC7GEl/rcW73A28Hp6kY5qQ/mrOjqMU0md3qYLaaSPzPykl80qk6mqVoBofh8opIBARIf7fInglVvHWuqZ8Oma2cxiTa0bmIcv/9yby3+yOsJmXu7PMVW5YRvlRZR4ivxAkVLX/CpMCq7eosa6vj1kT2Qw2jJ9rV06qsDbAkMGwNitgUUsjeVz3MmGY9Q7URsV8c6you5N1SM2//e3KF6muGkkZWiMauU646kOCBaEIAtP4V9uHzAbcmV/+Knkhfo+PprRVFhpfFaBCmItdD2jAHh/Xni96grs47JFDj4IchmxodI+1YTLZKOn4mF5q/uj9hJHvt9kbafwIS7ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFrUkvbRvnB6rIu2tGpx0aWfwrMMnuSOBXSVnZMAPDQ=;
 b=RBhOYNvPsSkdYYjaKLh+GoIRB2gXPrhKP8wJJFeLyeeUr+f+Ay1tKtGsttfGinV6gMcBjdaEcUJ263277eRZb0df0fYrUvXPyyNVMMN98QmtY2OQjtqNl4Qu0Xy3OfIKuV3d911iMNj0xGQ6oX/GsSDBP9IdnAiOaG5HzMyqfKc=
Received: from BN9PR03CA0699.namprd03.prod.outlook.com (2603:10b6:408:ef::14)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 17:00:18 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::74) by BN9PR03CA0699.outlook.office365.com
 (2603:10b6:408:ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 17:00:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 17:00:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 12:00:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 12:00:17 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 12:00:17 -0500
Message-ID: <4f71bb02-b9d0-2058-b6ff-6c9d915e1d24@amd.com>
Date: Wed, 21 Oct 2026 10:00:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 00/19] accel/amdxdna: Kernel submission and PM for AIE4
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b0801a-d1f3-425c-f686-08df2f94c901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|261021123027099002|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|261021121427099002|3023799007;
X-Microsoft-Antispam-Message-Info: T7aBZRBdD9r06TSKXVi1chH0nohGSWd00jR3msjuDyrmTXJBIIKU2kZBqNBSdWCFQBs80xfJtXHuordyhpFChaDSRiqKgn8ZPP5ZdjtaOzes24CIeEkUkjC7Bt/jLYXvt/TEuh6kLYuwPVIn3NwFH4FmWyrz/6JF9iXIb8lzv9vdXFMvsHU0umVB7/0b+1pdsU2qmt2agtX4znxOn6FyZqdiYY0oJz+2NH3DPXilcRXK14F8ASRmmgnbu9iR55oWkMtutx+Oiq0OIIYszLkDwePk9WzHGv4L/THwvbDDUv6tAPD698fnVdG+wEilhk6OIfuKBmR2yft9GFNIXyIHHPrsJJFF+3AFfoUMm61noe7Y0jeFq/O31vv0ApLeRZHW+R+ChPdrV68+tNDNUix0P++VzLkVRLWGZxV4kPuFB1Ksdbyu3899D2ZC4N2OiGvYyILO3JdqJXmTmCr3pSbCOV0oY6b4s6sKTc7gtxUbHd9sJBHCqaZx+A44qVJaTDP8Gfdlov3RUXbAovjcSy/nOAtSUnrm50a/MbeUgaeTirC/JPf6iX3tzf3s2jE374Q6mgpZDK+HVGlmIZpekBXBnFrVn/eIMKunzN976lGXAHznY43SdIvlQmKHPvdJ5da7o3KO8Q1UhGXBGFKNjdTvX1DsKE/sSXrB8YoysPLka0tW4Atd7fkzvwFP0aWJKW2J8J4Wb427Sa4n992tJtPwQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(261021123027099002)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261021121427099002)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gHw9g4kNctSeDgaSq6zjU8BeY93GWsHhtzz2ImuJ03KKfnBEGGHj4r4bmjfrEmls042Rmq2EWRSr0mMx0P/LV7bugFfq9vmQhXW7t2hWXfnRh2d3eA86/m3mlir7X4pbQGAT+juXWVgsjatVRsxMJZE2QXiDLHMqwxdGVJbydsHCva3uhe46wil8aePtSM3gd4nXbA0tOcId0Q8Xq1ChJYv5mjQxCgfEbS8KYpIs7ME3o/8Y3z41Rw2GDNX7M0GVNTDuOviHsX38QWF+LJstGHRNtZ1zor5iWzab5DRw8+zAyv3/lBNfwDdxJkcLqTJpLRUuF8N1ItLK+/Ml4FcpCd1vcg1Q/7iFiqX9ux7+h+N8l7oUYR77dpHlrPLAHqPTR32Q+AtUsLsU2tpywAM2PEkLt2+L5jY0exGvc+G6d7pZvbTWZqdystBall5bR0rp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:00:18.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b0801a-d1f3-425c-f686-08df2f94c901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied patches to drm-misc-next

On 10/19/26 09:47, David Zhang wrote:
> This patch series extends the amdxdna accelerator driver to support
> AMD AIE4 (NPU3) platforms, including classic and PF/VF for SR-IOV with
> kernel-mode command submission (KMQ), system power management, and
> runtime power management for the classic device.
>
> Changes in v5:
> - Rebase on the uninterruptible HMM invalidate wait fix, and move
>    aie2_hmm_invalidate() into common GEM code for AIE2 and AIE4.
> - Rebase on the umap range fault serialization fix, and move
>    aie2_populate_range() into common GEM code for AIE2 and AIE4.
> - Move runtime PM reference calls to the last patch, so each patch is
>    bisectable on its own.
>
> Changes in v4:
> - Return -ENODEV instead of -EAGAIN from aie4_cmd_wait() when the
>    context is in error, so waiters fail after a failed resume instead
>    of retrying forever.
> - Take a runtime PM reference in aie4_hwctx_init() so context creation
>    does not send mailbox messages to a suspended device.
> - Make the HMM invalidate wait uninterruptible, so a pending signal
>    does not let pages be freed while the NPU may still access them.
> - Record whether a command wait ended on completion or disconnect,
>    so a context unlinked and relinked during the wait cannot report
>    a false completion, and a torn read_index cannot stop the worker.
> - Resume the device in the wait ioctl when the context is suspended
>    by power management instead of returning -EAGAIN, and return 0
>    for commands completed before suspend.
> - Add a job timeout that stops the hardware context when a job does not
>    complete, so job fences published to dma_resv are always signaled in
>    finite time.
>
> Changes in v3 (addresses v2 review comments):
> - Lock, check and fence chained sub-command BOs with the job BOs,
>    since the NPU writes completion to command BO headers.
> - Use the validated payload pointer in submit_one_cmd() to fix a
>    TOCTOU on the user-writable command header.
> - Drop the last_read_index cache; get_read_index() returns 0 when
>    read_index is still invalid after a re-sample, so callers treat the
>    command as incomplete and keep waiting.
> - Align the runtime config message buffer to 4 bytes.
> - Move the HMM invalidate wait and populate_range into common GEM
>    code, and repopulate invalidated user mappings in AIE4 command
>    submission instead of failing the submit.
> - Drop the patch that finalized runtime PM before taking dev_lock on
>    removal; the PCI core keeps the device active during remove, so
>    there is no deadlock.
> - Use a stateless PF/VF device link, folded into the suspend and
>    resume patch, so it survives VF driver rebind such as vfio-pci.
> - Return -EBUSY from runtime suspend when a device has no
>    runtime_suspend callback, so the PM core keeps it active.
>
> Changes in v2:
> - Drop the redundant cert_feature_table configuration.
> - Call aie4_partition_fini() when aie4_restore_power_mode() fails, so
>    the partition is not leaked on hardware start failure.
> - Return -ETIME from best-effort firmware configuration steps, so a
>    mailbox timeout fails the probe instead of letting it succeed with
>    unresponsive firmware.
> - Fix a synchronize_srcu() deadlock in context teardown by stopping
>    the hardware context and waking all waiters before destroying it.
> - Use READ_ONCE() for read_index and for fields read from user-shared
>    command buffers, so checked values cannot change after validation.
> - Check that cert_comp is still linked in all command wait paths, so
>    -EAGAIN is only returned on a real disconnect.
> - Check that trace buffer addresses fit within 48 bits, as required by
>    the current CERT design, instead of silently truncating them.
> - Hold references to chained sub-command BOs until job release, so
>    userspace cannot free a BO while hardware may still access it.
> - Document that job fences are signaled when submission fails or the
>    hardware context is stopped, destroyed or suspended, and that job
>    timeout detection and recovery (TDR) will follow in a separate
>    change to guarantee the fence signaling in finite time.
> - Address use-after-free comments on fence dev_name().
> - Abort hardware contexts when resume fails to start the hardware,
>    so submitters waiting for a context to reconnect fail instead of
>    blocking forever.
> - Document that VF driver rebind requires re-enabling SR-IOV via
>    sriov_numvfs, which recreates the PF/VF PM device links.
> - Add pm_ptr() wrapper to fix the build with CONFIG_PM=n.
> - Remove hwctx_config for AIE4; use-after-free cases in the debug
>    buffer handling need more work.
> - Detect VF passthrough by comparing against the PF driver instead of
>    the module owner, which is NULL for built-in drivers.
>
> Changes in v1:
> - Firmware version 6.0: return IOMMU_PASID_INVALID from aie4_msg_pasid().
> - Power mode: consolidate cached power mode override restoration on
>    hardware start directly into the power mode introduction patch, and
>    respect user buffer size.
> - Transport hooks: fix header include to use <drm/amdxdna_accel.h>.
> - Command submission & fencing: fold fence timeline naming and unique
>    timeline context allocation into the command submission patch.
>
> Series structure:
> The patch layout is the same as v0 except for the v3 and v4 changes above;
> see the v0 cover letter for a per-patch overview.
>
> Testing:
> - Tested on AMD AIE4/NPU3 hardware in both classic and SR-IOV (PF/VF)
>    modes.
> - Verified kernel-mode command submission with direct and indirect
>    execution packets under concurrent workloads.
> - Verified system suspend/resume (S2idle/S3) during idle and active
>    command submission, and runtime autosuspend on the classic device.
> - Verified SR-IOV VF binding and execution.
> - Confirmed no regression on existing AIE2 devices (NPU1/NPU4).
>
>
> David Zhang (19):
>    accel/amdxdna: Rename NPU3 firmware files
>    accel/amdxdna: Remove mmap for doorbell
>    accel/amdxdna: Add CERT firmware version support
>    accel/amdxdna: Support firmware 6.0
>    accel/amdxdna: Add NPU3 classic device support
>    accel/amdxdna: Add AIE version query to aie4_get_info
>    accel/amdxdna: Add get and set power_mode for AIE4
>    accel/amdxdna: Add clock, DPM frequency, and resource info queries for
>      AIE4
>    accel/amdxdna: Add context switch hysteresis with debugfs control
>    accel/amdxdna: Refactor AIE4 hardware initialization sequence
>    accel/amdxdna: Decouple AIE4 doorbell and MSI-X notify transport hooks
>    accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout
>    accel/amdxdna: Prepare for AIE4 command submission
>    accel/amdxdna: Move HMM invalidate wait into common GEM code
>    accel/amdxdna: Make populate_range common for AIE2 and AIE4
>    accel/amdxdna: Implement AIE4 command packet building and submission
>    accel/amdxdna: Enable AIE4 firmware logging to DRAM
>    accel/amdxdna: Implement AIE4 suspend and resume
>    accel/amdxdna: Implement runtime suspend and resume support
>
>   drivers/accel/amdxdna/aie.c             |   33 +-
>   drivers/accel/amdxdna/aie.h             |   47 +-
>   drivers/accel/amdxdna/aie2_ctx.c        |   91 +-
>   drivers/accel/amdxdna/aie2_message.c    |    4 +-
>   drivers/accel/amdxdna/aie2_pci.c        |   67 +-
>   drivers/accel/amdxdna/aie2_pci.h        |   40 +-
>   drivers/accel/amdxdna/aie2_pm.c         |   10 +-
>   drivers/accel/amdxdna/aie4_ctx.c        | 1129 +++++++++++++++++++++--
>   drivers/accel/amdxdna/aie4_host_queue.h |   72 +-
>   drivers/accel/amdxdna/aie4_message.c    |  245 +++++
>   drivers/accel/amdxdna/aie4_msg_priv.h   |  149 ++-
>   drivers/accel/amdxdna/aie4_pci.c        |  818 +++++++++++++++-
>   drivers/accel/amdxdna/aie4_pci.h        |  117 ++-
>   drivers/accel/amdxdna/aie4_sriov.c      |   66 +-
>   drivers/accel/amdxdna/amdxdna_ctx.c     |   72 +-
>   drivers/accel/amdxdna/amdxdna_ctx.h     |   28 +-
>   drivers/accel/amdxdna/amdxdna_debugfs.c |    3 +
>   drivers/accel/amdxdna/amdxdna_gem.c     |   87 +-
>   drivers/accel/amdxdna/amdxdna_gem.h     |    1 +
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   46 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   20 +-
>   drivers/accel/amdxdna/amdxdna_pm.c      |   26 +
>   drivers/accel/amdxdna/amdxdna_pm.h      |    2 +
>   drivers/accel/amdxdna/amdxdna_sysfs.c   |    2 +-
>   drivers/accel/amdxdna/npu1_regs.c       |   19 +-
>   drivers/accel/amdxdna/npu3_regs.c       |  105 ++-
>   drivers/accel/amdxdna/npu4_regs.c       |   30 +-
>   27 files changed, 2922 insertions(+), 407 deletions(-)
>
