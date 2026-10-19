Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DD60A5BD1
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R3wFkk6O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B099210EEE9;
	Mon, 19 Oct 2026 16:48:08 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B5C10EDA4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZKFURtjYCI09Co1iGeqDxyeCL6oHGNzSicyyaP1MVBlE49ciG+quPtVtglZHZgMAHlCOCfI1CwZm0ba0KCBPvIT2KwaoKOXdKAmLvR4ibNN8NcbVT3BP4LkNM21vnpFeEfNIxjfgCJfhzqtviuTCsOh8p07wTWckinH4Ae0fCYdzZgQcLdgrUvATVj9Sf2kIucIaKWgj2fO63i88AyMb1hWlGzIMIjpe99NsHkn5HY9sY4ufNdT3eGsTyqV+n3t+n0+Ysgkrngv4UswpuUdHQD5VeYE3DWLHKaKcFfLwlBkN4UPWHiPGP8Wh0+Wo5EHWmaZ0LAPxPatBc3H4xYRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFdWuo441SZ0y7Ho6jIGKbs/DjKbr037W1nyJmZ7Wj8=;
 b=LCrYuZfOsg04H439mOSztlLDSkKGhhDuERvEfCLxoJirR3EdYJN+YIcEwqjbxy86xm8hT3l7Hm14MV4xff9rl3yeXo/9vj3ivM23ZKOvVE7k3TTri//x/d3bCNcFtuF9AKxdqn24MFPFwriTjrMoXetzfDk+gO3T/CxjkBNoHdoIgfZUp4NiYMo8TkeZTiorc6V6cwsC1CDw1wAc+C9gQetOZqqDLXt8fmI03/uNStIzMyiopR3KU/kqT4DIBj58sow+lyYB4nd9RoZaJw4+DMVLduBx5Y95ZGnIV9g9D7u7PVItZ4Nz3AFoVehY8qwNQeEdCTw9KRlU3vBDoU/NNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFdWuo441SZ0y7Ho6jIGKbs/DjKbr037W1nyJmZ7Wj8=;
 b=R3wFkk6O70Uydiio1nx/dSvDJVZJsyHT4bUVQN0AQNIC8HfHSznTn8cH9H1kr+JaIXn1qRbYTz2YeWg8vAnGowBaZZChdIxAuh7tUpOxUg6Ei8IHP7Ir8wI2fttbhFE10W87U4HbxFI22c/rUJN/tGrMru1N85TijA2MgOPOnrQ=
Received: from PH8P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::14)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:52 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::5c) by PH8P220CA0008.outlook.office365.com
 (2603:10b6:510:345::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 16:47:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:47:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:42 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:41 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 00/19] accel/amdxdna: Kernel submission and PM for AIE4
Date: Mon, 19 Oct 2026 09:47:27 -0700
Message-ID: <20261019164746.827277-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: f61f9fa2-e0b9-4cf3-9846-08df2e00b64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jCDgQoMnW999QkC+odPwEOKECaLresqMIl8h2JnBWXLe4FDRJTCeMqNS8wfmvj6ckbR4LDDqkHlpvxejU33+3FBodNNZDJhJlYjREv8pPn4c5FbhgAH4DMmR1riUBkHXeKRlEQSNj1ye4WffJWC/0ybRLQG1viWMxJxZMib6BBTWmLGYbXFGZxg0fuKKajZvXCxo694AcASFR6iKYlywUUZ6ndTkP9uGHtz/DAw/agTjWMotFUruyka2YyTt3p1xKm+Iqa9owHyrBFgRPQq2CaNQOZ8gglhcPOV7cltna373qOECcxikqiNHRKm3GISfOOscU2MBkShnOz9Q/UAawO8JgaAYhwJiQkJ55Ot65OYaXhhGolCvv6ugwiCRekLs1QEc+OwZz0EQ82mq+AaGVSrYgZfI8zclUvpW3Qkj1dMMazZbin/7Z7TrVRkp13Idnvv5GktbXRZuvBboTMte5+uac39SqQp7Hr4OKjV2dvfX1v3hH+XTgmsa2TQQ5VtOwszTali2sk2muFMRoUMLkV1wS2aYPmTRlDelKmXOkADk4DG4PuhKTxbl5CuxJ8qpzJGyY48CggCLYnx4q2NH06gqNu1np0HI/wWq0SvtvHSDG6qxEUsHscq/OjzQCvIncXO3laquFm+X3IN9OeXtYXn2IioisV8IfrBVfQz/TAeiy6Scyd9L8YBgMqOW2M+m0+uIJ08LAj6xMVWxtEhFFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ibJg6FPtmK0QU59iPinhGtZ8b7K5Q7+TtwLrmwCXpvi6MV09E2EQdOu6rhkQfzUHscpQBuItUGjLoAoZSzRadqklZRhMt5MkTYCEml8fqrxY3D2+tiCKtRX5dYqcREXzyuV+86fEYCxuebqRw0K41XbbCUwHgvOVCi8cAIAlPJXn4+wjPgQ+QhOLgRC+0YXqSWBpZP7Dqx7ejeBZBXeVHwvBXwtt9707HlVYgoEth4LHJZOLTkPbGyCXoaum5Rf8UKSfuBjizZqQCBnbvufkENHRkuBvRMWhKyBlERZKARcJnFFHJRixaOtOw1CtHbs/7Sdp5dUPhoIV5c+07vNG7b3JdhvVJPh6SssZ0Ija2Zq4UV6/RHznOVSzZ/nrI/Loenjpur2afKjG+JKuMpiZjB6DdoBoBBd+3hqDVlSrHC90+6zDMBs4ST8SWViFUOKx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:50.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61f9fa2-e0b9-4cf3-9846-08df2e00b64d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series extends the amdxdna accelerator driver to support
AMD AIE4 (NPU3) platforms, including classic and PF/VF for SR-IOV with
kernel-mode command submission (KMQ), system power management, and
runtime power management for the classic device.

Changes in v5:
- Rebase on the uninterruptible HMM invalidate wait fix, and move
  aie2_hmm_invalidate() into common GEM code for AIE2 and AIE4.
- Rebase on the umap range fault serialization fix, and move
  aie2_populate_range() into common GEM code for AIE2 and AIE4.
- Move runtime PM reference calls to the last patch, so each patch is
  bisectable on its own.

Changes in v4:
- Return -ENODEV instead of -EAGAIN from aie4_cmd_wait() when the
  context is in error, so waiters fail after a failed resume instead
  of retrying forever.
- Take a runtime PM reference in aie4_hwctx_init() so context creation
  does not send mailbox messages to a suspended device.
- Make the HMM invalidate wait uninterruptible, so a pending signal
  does not let pages be freed while the NPU may still access them.
- Record whether a command wait ended on completion or disconnect,
  so a context unlinked and relinked during the wait cannot report
  a false completion, and a torn read_index cannot stop the worker.
- Resume the device in the wait ioctl when the context is suspended
  by power management instead of returning -EAGAIN, and return 0
  for commands completed before suspend.
- Add a job timeout that stops the hardware context when a job does not
  complete, so job fences published to dma_resv are always signaled in
  finite time.

Changes in v3 (addresses v2 review comments):
- Lock, check and fence chained sub-command BOs with the job BOs,
  since the NPU writes completion to command BO headers.
- Use the validated payload pointer in submit_one_cmd() to fix a
  TOCTOU on the user-writable command header.
- Drop the last_read_index cache; get_read_index() returns 0 when
  read_index is still invalid after a re-sample, so callers treat the
  command as incomplete and keep waiting.
- Align the runtime config message buffer to 4 bytes.
- Move the HMM invalidate wait and populate_range into common GEM
  code, and repopulate invalidated user mappings in AIE4 command
  submission instead of failing the submit.
- Drop the patch that finalized runtime PM before taking dev_lock on
  removal; the PCI core keeps the device active during remove, so
  there is no deadlock.
- Use a stateless PF/VF device link, folded into the suspend and
  resume patch, so it survives VF driver rebind such as vfio-pci.
- Return -EBUSY from runtime suspend when a device has no
  runtime_suspend callback, so the PM core keeps it active.

Changes in v2:
- Drop the redundant cert_feature_table configuration.
- Call aie4_partition_fini() when aie4_restore_power_mode() fails, so
  the partition is not leaked on hardware start failure.
- Return -ETIME from best-effort firmware configuration steps, so a
  mailbox timeout fails the probe instead of letting it succeed with
  unresponsive firmware.
- Fix a synchronize_srcu() deadlock in context teardown by stopping
  the hardware context and waking all waiters before destroying it.
- Use READ_ONCE() for read_index and for fields read from user-shared
  command buffers, so checked values cannot change after validation.
- Check that cert_comp is still linked in all command wait paths, so
  -EAGAIN is only returned on a real disconnect.
- Check that trace buffer addresses fit within 48 bits, as required by
  the current CERT design, instead of silently truncating them.
- Hold references to chained sub-command BOs until job release, so
  userspace cannot free a BO while hardware may still access it.
- Document that job fences are signaled when submission fails or the
  hardware context is stopped, destroyed or suspended, and that job
  timeout detection and recovery (TDR) will follow in a separate
  change to guarantee the fence signaling in finite time.
- Address use-after-free comments on fence dev_name().
- Abort hardware contexts when resume fails to start the hardware,
  so submitters waiting for a context to reconnect fail instead of
  blocking forever.
- Document that VF driver rebind requires re-enabling SR-IOV via
  sriov_numvfs, which recreates the PF/VF PM device links.
- Add pm_ptr() wrapper to fix the build with CONFIG_PM=n.
- Remove hwctx_config for AIE4; use-after-free cases in the debug
  buffer handling need more work.
- Detect VF passthrough by comparing against the PF driver instead of
  the module owner, which is NULL for built-in drivers.

Changes in v1:
- Firmware version 6.0: return IOMMU_PASID_INVALID from aie4_msg_pasid().
- Power mode: consolidate cached power mode override restoration on
  hardware start directly into the power mode introduction patch, and
  respect user buffer size.
- Transport hooks: fix header include to use <drm/amdxdna_accel.h>.
- Command submission & fencing: fold fence timeline naming and unique
  timeline context allocation into the command submission patch.

Series structure:
The patch layout is the same as v0 except for the v3 and v4 changes above;
see the v0 cover letter for a per-patch overview.

Testing:
- Tested on AMD AIE4/NPU3 hardware in both classic and SR-IOV (PF/VF)
  modes.
- Verified kernel-mode command submission with direct and indirect
  execution packets under concurrent workloads.
- Verified system suspend/resume (S2idle/S3) during idle and active
  command submission, and runtime autosuspend on the classic device.
- Verified SR-IOV VF binding and execution.
- Confirmed no regression on existing AIE2 devices (NPU1/NPU4).


David Zhang (19):
  accel/amdxdna: Rename NPU3 firmware files
  accel/amdxdna: Remove mmap for doorbell
  accel/amdxdna: Add CERT firmware version support
  accel/amdxdna: Support firmware 6.0
  accel/amdxdna: Add NPU3 classic device support
  accel/amdxdna: Add AIE version query to aie4_get_info
  accel/amdxdna: Add get and set power_mode for AIE4
  accel/amdxdna: Add clock, DPM frequency, and resource info queries for
    AIE4
  accel/amdxdna: Add context switch hysteresis with debugfs control
  accel/amdxdna: Refactor AIE4 hardware initialization sequence
  accel/amdxdna: Decouple AIE4 doorbell and MSI-X notify transport hooks
  accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout
  accel/amdxdna: Prepare for AIE4 command submission
  accel/amdxdna: Move HMM invalidate wait into common GEM code
  accel/amdxdna: Make populate_range common for AIE2 and AIE4
  accel/amdxdna: Implement AIE4 command packet building and submission
  accel/amdxdna: Enable AIE4 firmware logging to DRAM
  accel/amdxdna: Implement AIE4 suspend and resume
  accel/amdxdna: Implement runtime suspend and resume support

 drivers/accel/amdxdna/aie.c             |   33 +-
 drivers/accel/amdxdna/aie.h             |   47 +-
 drivers/accel/amdxdna/aie2_ctx.c        |   91 +-
 drivers/accel/amdxdna/aie2_message.c    |    4 +-
 drivers/accel/amdxdna/aie2_pci.c        |   67 +-
 drivers/accel/amdxdna/aie2_pci.h        |   40 +-
 drivers/accel/amdxdna/aie2_pm.c         |   10 +-
 drivers/accel/amdxdna/aie4_ctx.c        | 1129 +++++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h |   72 +-
 drivers/accel/amdxdna/aie4_message.c    |  245 +++++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  149 ++-
 drivers/accel/amdxdna/aie4_pci.c        |  818 +++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  117 ++-
 drivers/accel/amdxdna/aie4_sriov.c      |   66 +-
 drivers/accel/amdxdna/amdxdna_ctx.c     |   72 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |   28 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c |    3 +
 drivers/accel/amdxdna/amdxdna_gem.c     |   87 +-
 drivers/accel/amdxdna/amdxdna_gem.h     |    1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   46 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   20 +-
 drivers/accel/amdxdna/amdxdna_pm.c      |   26 +
 drivers/accel/amdxdna/amdxdna_pm.h      |    2 +
 drivers/accel/amdxdna/amdxdna_sysfs.c   |    2 +-
 drivers/accel/amdxdna/npu1_regs.c       |   19 +-
 drivers/accel/amdxdna/npu3_regs.c       |  105 ++-
 drivers/accel/amdxdna/npu4_regs.c       |   30 +-
 27 files changed, 2922 insertions(+), 407 deletions(-)

-- 
2.34.1

