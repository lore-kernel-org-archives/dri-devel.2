Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335E606D838
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SZ3ufG3V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3E011245D;
	Fri,  6 Nov 2026 08:27:03 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D8C10E9DC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WATPF0jylaad22lx1cObgum/5PTLZDvra9w5chNtoPL5cbuyG5LF8vKY3JHtxgMIURMVJZvCvOmdLMRK97HHoUhCUz8W9Bfm99N2yUjW4Y1ilnLwdRNpLfm7iPF14pPjQ1Hk0Diq6q24s9tdG8ozv/+enlTVi9GW3u5LzkfmlTvClkhXZEzJZtmpMAM5wrDcGtiOHDBVmeUjYT9b4Ll1YSPt/HWELsH4nMAkQwRhDbURpLBDvSmXYcUR1MR+7tHJ2BKrOruczr8hoSOV63zQBvZ/mnCNJUF4a5zMzvsxE/fn4ifW5Z6RNClTlqgt08cI2P/OGkQjCfTDV3J68ytgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xEFLP+Nvprb4NYFnlQfnz7vty0C3ZZijL6g6xhB7kE=;
 b=FZE/pUSj7rfVONAjQSxoQJ7CKoJaM5aLsWoQkGTYTaSUchHdSJHWlkwaeiiSsqsASN3/GhDlCVNGG803XL+JMYreQFOVJM3FCcDQfeS8/cZ3RRIXi+ILqDPNefbRaytIir3FDwjdvuJ1IFAiXGwCptKgt6e0omtjdOrh42U+wGJNaYypqJqUZQnSxbttoYcJjnekoUdGpst2jTeKosmWRGHO2NxaHaJls4KNyRAAy3/AlH91viQY93fjV2ykjdC0gcCAMUc4W21mE9QTIoGjrJxEbfboWTB0PvvlXAc6zM4CBmF9deyVGMlPiDgcTwEUTf4hHKvPaDbPHKFzwnsA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xEFLP+Nvprb4NYFnlQfnz7vty0C3ZZijL6g6xhB7kE=;
 b=SZ3ufG3Vj7zpeZ88/dg3cRexpV25NhaTqE2aYK+x+ztyOKnkjCGKBJ/2OrDyJ90PVCu1PvfxR2z0EKeHLiN0l7yAQQN395aQwmLBc9I7KspfPblYMj00J3ISKL1vXog1ameCMN/P5uAPkr6G10A9OdddH62/lq19G056JmHJCmc=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 08:26:52 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::4c) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:26:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:26:51 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:26:41 -0600
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v10 1/4] drm/virtio: add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 6 Nov 2026 16:26:22 +0800
Message-ID: <20261106082625.812860-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106082625.812860-1-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c338b7-efd7-4b24-a031-08df3bdfb56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|261022105027099003|261021121427099003|261009223027099003|56012099006|261026121527099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3s7CsOy+Kq4rNcEDyAUtZmlGReZG0NQ+Y4oYvR99zTL0XBEGmZX/Z5JTG+gQa+7sMY9P2nqb9sAkvkKxc4x7E7AR1fyuaQVtP7AYFeVszH2RQRuUf+mCaaL1pxGhqzaVCn5GMRxNM0I2FaNPHVsBpw1w55jzxOneHhi0j8jFPLTqoVHvHrtlgRrz3pMe9jNeyR4CEphEf1bY4+8999Y3Egb4jRbe3BhQcRKVS8oZktkYQp0Ii7ZlMLMtF41nukRp4VjrOoSGckkC2xLWPVpV4UFSqt2Xfk/yN+/7tKnQWvc+z1z+el4KqXp6zmhURPVD/slRMnyjWWf0oosUbrCmEcoqeT8uhSiFOu/HIHFevI/t2HHTkX090qJbGCjqw1Hb1CeZsRvok+2G4rQxk4nP6RSz/2bclda/pkUv+qrTOsdBqjraofq7J3Qrx0KOQECmZqVfTYf0ytjbsiVG/fLYlCZn4UE4WMWRF3i5M4q0R0BdMVtwVpYwpU45dfcEIrsdCvZSi7dNGVVXA7tJ/J9GtSjkXyFj0uddskmtsxGduiTq0d1AD7Ax4Bs5LYJiYCqvuerVmW4SiOqDMqKfnuKlUXKPMEhbmlV81vBMNnyA2ctP0NI8wtBCZRrptXBa9+cdWVDriwgaHw9Al32w/4b5XGRKb+lLmYryzW0jsjTQHWE1ySOU5+Z2/X0j1ZV2eXqqAMekq10ly5Prwl7WGMfFxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003)(56012099006)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: az1UGPtLLYN7cWssVCV6HYiM5UcKfahvckl27SmxgrHTseS5mVipoDWCksIYSHd8c3WrKt92m4mYjUlhDHXNQgxFOMs6hPL3xv8udrH+a7ApnUjX+HTKXRCb6xVCb6xjIUxQpEYS9dL88MRrEm0lYR+1o/hwL/NSSgx2i6slY5X/EtSeu+4HxrUx5ODQ8GUhkRITX+/k50O7Ceh82O14HDXq56x/DzucfrAeLo2HTQIIQbBtgrClSG24Wl5Nw3MMmdEj5+0PrciFZ7TS2G3ADb+n0MUZ2VuW46PRMi4PJMbHecuosZH7YyZgfSo34CLNLk9E58Czi8LrOhCZmUo1XYLimZERsd2sSMRoPXUDLuyuuj+usC7HCnHfZfruTo6FKZwbHGkkykBleEVn0zo5AvEtzI5oDl1UxnUTdyKbYZbDXEh6McHB9KoH32U9dgVW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:26:51.6146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c338b7-efd7-4b24-a031-08df3bdfb56d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support ROCm
compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform for
GPU compute and HPC workloads.

ID 7 is already used by the OpenCL capset (VIRCL), and gfxstream's
rutabaga_gfx has already claimed IDs 7-9 ahead of any spec or kernel
header update, so ROCm uses ID 10 to avoid a further collision. A
matching virtio-gpu specification change is in progress to register this
assignment.

Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h for
consistency with the other capability sets exposed through
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
-- 
2.34.1

