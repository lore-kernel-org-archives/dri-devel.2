Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B77BC98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6000410E4BE;
	Thu, 24 Sep 2026 09:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="utVXGfNG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B5F10E4BE
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 09:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSoQhzFOjsNfvGFEYMnWuaTqyoywjuas6Aka5nGoP7xMA38RNQycbm20vfihCBKSZtNJQAfo8ycGT/XhWvHN78YPdG3jFxNBBNSUzQcYQwQE9NNJZmsavtpd7lH9vaPVnfU613znsFe0FDaSN7Lp6Gnqa5SA6qGLo0/dQE3I3zR4eC6g/CiGgV7ZuLM0bWQu0YrdgwTdZsW7dRYChOsk4ZJKODIjAVoYyI1FGjBHCPY/gpMdp+KyU8xFqjk62fk3rnErA70MFjXg3pjHptYbJA9Eo9e/MyZk2IFoOzRi9ErufAegwbYt3ET60fp+Bq7NOAND6+34395srd/yct+IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KixhLCT8Sy0JVFdESmBfF/ksLTBjSdShCFoD5dBLjl0=;
 b=iNZWp8nS430JiZxyPbGOlRbmbAoUn4COpCSMc32s96qumFBIHHy3+4oU4qm9nQLEJqr846sHKRFxhaPlpjailNBNY9QUTmLSkqLzZSDMO91s4D9pguhj7Lq+39IZwbRrB3o/JIIiCFKRTnH8eRs5ae00xokdEd4cBS33zFHs8HFi5gXoCJFaF3oFU2FbiIYMRePZdp+d+oTbBrsYA1Fgw8F8QpfAxDGgjOPaxgHROcwUYvcu+Ptha9UT1MyTw+YQIOrLGASGDk45GYiFUNce6/pUo4KpabCySiycdZFWVdfzPbKnaq083XKPJq4Dvlqptnql/HneYbaF65FLvrpqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KixhLCT8Sy0JVFdESmBfF/ksLTBjSdShCFoD5dBLjl0=;
 b=utVXGfNGUbHJRPve4LmMUp5023NGpUUV3C0NBj8r/3QLGZFFXRR9ehMjX12691vEObasljKwo0iwmi1xNe3lxupKeyCtMxrCFcK75YCCUv1Hsnu6MLnh9cdNzuxkIL4PEyZ6mdqNcNlF0VSAKT8ioqvYy/IXsjuGcS/j2ZZR1V8=
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:56:14 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::92) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:56:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:56:14 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 04:56:11 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dmitry.osipenko@collabora.com>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 <airlied@redhat.com>, <kraxel@redhat.com>
CC: <gurchetansingh@chromium.org>, <olvaffe@gmail.com>, <Ray.Huang@amd.com>,
 <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v9 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Date: Thu, 24 Sep 2026 17:55:53 +0800
Message-ID: <20260924095556.1326164-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924095556.1326164-1-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e73dd1-6f8c-486a-1ec4-08df1a221231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: zFP2OjEjZZiMJ4M3mSZIisqC19ljQpI0tPZPwBrkpD1Uu++ofcLOD5I1achrh2M0aAgEGROEFWTKQQtX/9I9HkHO6GHWNW2HgJKSd28cCEnKnwpNPzH1Rvfqy4y10ee57qr7VjWphlLynK+d968yozfIweqJyj7eOKQMeGSozl4jU2w486XtXD28vS4DI18jaOrmBC9lIvth7G9KH1rFuvfhibfQReJBVoNl7UganRsq9mULdMfdaGPeUGwn0fSD6IuBwu4fcxn20RlOdy9wUJGpRu9+uLXijiQkFbq5eONrRfI8QErCAnho+kAur1JqbMt9SXd3X0neOITqFZpp2rM4jUTh4sb9G0SQXGhWqxtjQAKfHDjT08yex8tmFQyAugDpoxETTnxQ+uUrwpYqyr9e0OBZ+wzMyCxFshwWpXIVc2JB5lhing1kZ9L5U6Akq57dPUrr76si5ltrYFsnYRpQiaCP5TKS7I3RvwpqoBMjcsPBxk9rvYbRadZSF7UyXJdkIgscHE4i8n8o7wD7NPAvlAwSh7bpkFk48rOhdCVYB9FBjqdEzy9WvtI+BOWJkcm12vjcNiRZK0oxdy0Ctg9rm4Tihz8WZy15tFHMQhLwyiljCxRpAZQH82BjnLNtHFfwfkZks6fYLaz94E/QcqqZhrS+L8ys+SXZQKwAbaF4GeIIs+AcoFthzr8tbSO9i/UeYyC28cVDlmTOTFPLLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YPAtiAV/ygHc+u+ocMCabko9dy4xMaicX8RHV3AA1kEf4Y9HY29wPjh6tDeQJ44PaAyyUMRBTlRyDoTsWA/rLoPPT/qpCkl1Fi/eRtBU/csVfouUmi+zRKvZPetYmMcyLeZWqY7yN9mxBLoLPjQdssRgtXPL2upspANx/T5O+FQS7n8XeULZ1HEzZFxbtFyzPsUKFF4IrAhquSUNqtZlL9eV81+OSfwsUSr+268f5rZ+QEiiiH8/9BVA7c83kUzTy/Li0q4mCmgy6ePi1gtpTVxhHwXnasc/QSZ2UVswizk54GSpFHHZkVTUfh/oj4MD/9eZ7TSm1B8YVASr8ucpObMvBbE0wqgrgUmgeayNUod4q6Kw4fdQ2mU1LDIubRVM0ilswa/iX/5Mfi1oZ15Bvw+5R5Ma8jeN9iron7U97e+GTXxSnC4nzy7YPCfbjsyq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:56:14.5482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e73dd1-6f8c-486a-1ec4-08df1a221231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107
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

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform
for GPU compute and HPC workloads.

ID 7 is already used by VIRCL, and gfxstream's rutabaga_gfx has
already claimed IDs 7-9 ahead of any spec or kernel header update,
so ROCm uses ID 10 to avoid a further collision. A matching
virtio-gpu specification change is in progress to register this
assignment.

Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h
for consistency with the other capability sets exposed through
DRM_IOCTL_VIRTGPU_GET_CAPS.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/virtgpu_drm.h  | 1 +
 include/uapi/linux/virtio_gpu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..9b886e9772 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -170,6 +170,7 @@ struct drm_virtgpu_3d_wait {
 #define VIRTGPU_DRM_CAPSET_VENUS 4
 #define VIRTGPU_DRM_CAPSET_CROSS_DOMAIN 5
 #define VIRTGPU_DRM_CAPSET_DRM 6
+#define VIRTGPU_DRM_CAPSET_ROCM 10
 struct drm_virtgpu_get_caps {
 	__u32 cap_set_id;
 	__u32 cap_set_ver;
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..e22049835e 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 10
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {

base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1

