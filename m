Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB096C79FAC
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63CA10E5F0;
	Tue,  8 Sep 2026 08:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZagvFGLw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2471310E0D7;
 Tue,  8 Sep 2026 08:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDC3uhhzBrFH89G/l7l9RL0F/4tEvfH0Ie2LJbODB9XcoMxeLvCtq3XXkUf8XSstG07hpZ3W98QUyDBdvq17lcpTcXjUsxr3tXMM2XL6z2eASrthoeKaopSQIZCwn8eXicZJwOUN2TPPVxmISnpkbFEK2kYR1eyMdn9ieeweWLGSESuvVFVKkq9KARM1nkSVKbky3CJvyuPuSQ0CeCQCna4SOy79yAYR1aRKP5USYrq/NmfKb+206AreRUm8U6OZR+10ndr4AF3/QNkivZOOufNCkyi5tsTz2WPVM62WRGyXfzbkKFSK2iUYirYKa1Yj7eKaCMJX+VTzjTCEgiwE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6brJ9xSKGLWRtz5LgcT1HlzZrssaw79bS9DxugncFHk=;
 b=gtIiV0+KCe3CrEr6eESSduOg8U3S2EfOg8VORWAFKYCK/NNv5LWocZTCalpBRLTHHDlTz8UtnqJ3LPJbgt0uSq6MskBKi0rQ1dZtTpu1f0FXb25eN3lriEDWHLoZv9EWzFhwQbHCofc0yJraOX5HO7aqZj6MtO9i9viPVp3Hk0LBkxIXx+y0pvCGJdtnlRDYw7IotFhBatzbalpJIo5oHIXgLIJMivM/x+N528EbYaSZSSDvGeU/p5D/39rZaI+62bf+vbW9qrcUuds+vfzzn6NfyDpvDsyx3CSAVE1a0pAJ0XF0n7sPkGAZUJvyt91aqEWFaqFNT6CI7HMqEQjLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6brJ9xSKGLWRtz5LgcT1HlzZrssaw79bS9DxugncFHk=;
 b=ZagvFGLwmy30db0PwQtVJ/Zb5w0a+Mq3bgLz4UUCotbx2/sRmPME/Z1006gWzN/8Tpj3gvt1TLQZfjrhhSn5VlUT/SwPA66t/TMqXRIr5tn0W39WcCGm/oSRK81goES36ffEXnEyTk6fE1HJywS3OBaz+zLYIE+UAP8WmaLPyCg=
Received: from BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:46:45 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::1e) by BN9PR03CA0295.outlook.office365.com
 (2603:10b6:408:f5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 08:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 08:46:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 03:46:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v8 0/3] drm: Extract dma-fence-to-workqueue pattern into
 common helpers
Date: Tue, 8 Sep 2026 14:16:24 +0530
Message-ID: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: cb617224-cb1c-414e-ed14-08df0d85b683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: IXW8TpY3m7orO7ieIAfvnAYDKBWwMeSEo92neQcSxtXv7WggXLqvWoGyDgXtF7Tr4PQ2aZtu6g4H3xtJhKiU1sEEnZ2wscfFza4rxdzcjOdQOzEuQ6mNNmBa3sw0YwPcn4CnkYK69cXh5PTfmn4FbXQ811hEhaY8xAtt+dlZhKBeCNlaGqgid6DLSeVDFacqUNXBwFCqD6kDLLCnQL2BzidxhdcDL9F7JmLu/ttUZP8nmJ92m0S3CTneatwduCrzi14kJ2+/g+Y+V11gS8fA1QMNIneNRKQMX6PT+3LfiAS8KaSFVTlwupfmWZyL9+W6pyKK9YEObbojsUWyusRLFrOgm5xK6NxvDQJJwFGr50VGz016nAJupMMP4kIS8orn353zIyB5exmW9qILoJDSz3G+JnEllQP6tI2AY/dNs5uCOskcnmhvvrSt2V+PXAdM+xqkLsZSLe+iPhktd6J/OszLjgFs7MSAzbch+pav+VWa7vmAmcWV/3cm/GHmrtNelnNND9949kzHtBRQSAek6ejaRlPnKb07MuDx0+IqOydt2Sn6CFN9XOD8evwGG0YYtM+yKQ4InXeGbF9EwxCUDDTJgCzjNMz7ri9zkrTQZ9kgXcAY20yIJDY4I+raDayjO6iOHWqXFyOUGuYef3D7MO+p9UF5Bqt6Ktdz+8cNiifumL2Y8xpkxBK2btRKjv0VpnqqSyN183MesyR0F6WiDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +0HT9dlc1/hRJUFkuFAjR05K+cU7Hb+E8ik/eBn4+pO269mf00AyaxL8LoSsz9WeOjgROMnm45/UWBCpVCUTfn8uRBxbAncBQwGBLHWta8Pzr6SA5laQcqPSXiNfi3Xm/VTO00cLiiTaC8t9JkLtRsaesLWj5i2JKArlWmuQlXxQ1RsfM4gEMYBEDigfa7IfHoEZCoK3vCNXbYJGVELNkwtMZ1Ts8hbVzMJ95zmkD/eA8NZuVjaojmohbmzraN9MBB+Fw9Iyhbf8dNakLIyxLghLUd4UIbIQSCZqJ6sokSyARYdrWKMwvocHxHnTJfbuyR3UGpbVUqrRNyeyW66CAttkdONXvyL8oxJjeHTzS7t98S97fXKPl89Cn7POdMF5Zd2HQLUtrRS1GLoVrj/AnBdf9cw2VHEXSBY5OHsi4rgIGXLCi/aa3y6newo0Z7kq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:46:45.3373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb617224-cb1c-414e-ed14-08df0d85b683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

This series extracts the dma-fence-callback-to-workqueue pattern shared
between XE and AMDGPU into common DRM helpers.

Patch 1 introduces drm_work_fence — a generic helper that queues a work
item when a dma-fence signals, for work that cannot run in IRQ context.

Patch 2 introduces drm_user_fence — extends drm_work_fence with
kthread_use_mm() support for drivers that need to write completion
status to userspace memory.

Patch 3 converts XE's open-coded xe_user_fence to use drm_user_fence.

v8:
- Fix copyright: The Linux Foundation → Advanced Micro Devices, Inc.
- Switch EXPORT_SYMBOL_GPL → EXPORT_SYMBOL for MIT-licensed code (Matt)
- Rename drm_work_fence_ops callback: writeback → worker (Matt)
- Rename drm_user_fence_ops callback: worker → writeback (Matt)
- Fix xe_ufence_worker ordering: WRITE_ONCE before copy_to_user,
  add smp_wmb() before wake_up_all (Matt, confirmed via 8ae04fe9ffc93)
- Rename .worker → .writeback in xe_ufence_ops (Matt)
- Drop Patch 4 pending design decision on compare address read method

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Christian König <christian.koenig@amd.com>

Srinivasan Shanmugam (3):
  drm: Add drm_work_fence helper
  drm: Add drm_user_fence helper
  drm/xe: Convert xe_user_fence to drm_user_fence

 drivers/gpu/drm/Makefile           |   2 +
 drivers/gpu/drm/drm_user_fence.c   |  70 +++++++++++
 drivers/gpu/drm/drm_work_fence.c   | 184 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 154 +++++++++++++-----------
 drivers/gpu/drm/xe/xe_sync.h       |   2 +
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 drivers/gpu/drm/xe/xe_vm.c         |   1 +
 include/drm/drm_user_fence.h       | 123 +++++++++++++++++++
 include/drm/drm_work_fence.h       |  69 +++++++++++
 9 files changed, 537 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 drivers/gpu/drm/drm_work_fence.c
 create mode 100644 include/drm/drm_user_fence.h
 create mode 100644 include/drm/drm_work_fence.h

-- 
2.34.1

