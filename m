Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3C8C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660A610E861;
	Fri, 18 Sep 2026 08:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOcHicA3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F2B10E861
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwFEiZN9MxaKdY4N5BSTZkoNTNX5GwPsvgi9yAlkQYpZXJ9DYQPy8uLEtesy6hlon8kUlZ9unISCqD2o8uohl8WrkmXdiY5Mwdegp4vNlwUUzwd642xt4+y89nGbqqIvntmofqRFw3i4PTLi9lb+mE8l1bXtmrpyGBOKnEWItyyECkLY/rlF9goWRP4FzbbyoOhsRRRXxVS/LA7lXLT3eETeBmbCE5ZEncFLMuG2jCxotvUuQDLLBdG1xnbjwuh4LeGYSLeTpPKRf0CUVrHoo4qAeYRk9cvkGvOdB8iBz/aND96oIy4/hroRyttVbA4tMDY2l0J1k3ud+lAQn5HOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh7t9lCZvEKIt8fCKxkY0noneQl/NapxT7EK65Iw9pM=;
 b=edC49QAnhkyFaImk8Tqytgn4yBARVAuA+eNDhb5D6gitF4I5aXjBeKJVzofRG4hyTRnrzZlWvhhfg6j6c1j3Qnju/RJNXOHA6GUmksfY/e4EMCBwb9fD0BFnHtu5uCDVFBlWniOY9roZqYU6d82V/8kS1vGRNZbQMikuBPchMfLFBMkg74PcCcd6i6N5xbkpxx58R51uxj9AmLVZuKcp/3Hr7pxAXDdS0FfIy4WQai0L4hHLDoJIe/B1AcY68eF8zhzGLhSurO8Ndbzm0u+BCTK18e/E5aGpzZ8QH9aEKvLda3T8HWDDNAmPF5MJqqtrJBhuOSFoI1xmuyPCLTYaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh7t9lCZvEKIt8fCKxkY0noneQl/NapxT7EK65Iw9pM=;
 b=SOcHicA33ZIDuRRkSC+Wa9rQkO1exNeBlfvGb/Rb7rN+lJLvGeDI9HiEnsGka/KhsisGo74qI6sTKbh9sVuOPD8+mbCRJnd7ByaDoyr5O6fvT21/CEwV9kidHj+WIhXuwhd4pVlGZ7drSQv1rms7ZCwBu2Mix4oY8+4jy9dtktQ=
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by DS0PR12MB999313.namprd12.prod.outlook.com (2603:10b6:8:42c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:23:29 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::5a) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 08:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 08:23:29 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 03:23:26 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 18 Sep 2026 16:23:11 +0800
Message-ID: <20260918082311.2213619-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918082311.2213619-1-honghuan@amd.com>
References: <20260918082311.2213619-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|DS0PR12MB999313:EE_
X-MS-Office365-Filtering-Correlation-Id: 35de3a73-253d-4b26-8624-08df155e1ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jzlOSzWQCkIJugJLeOd8SYB7sNv2nWQ+DXSX1Zoy9VwyMP20dWJzN/a9flBX8RLVrtjbfFV4aJLvPMSABVtEr2HtQHOZOgXDLHp/ypI4jFZY0EB5X2+9994OT27OCwFmjtOcUzvOyKOYghucA8BVyasJTCTi5U/a9RyEs60F5a8lXJjxMgSuMXijfz9kkMXAQb9k07FSexIyC1uezMZ86SXEVgxXVkeP3Ehnf1X9Ee9sL3rFuFpj6E8DDj4SjqOGZNLdkiYI/2RTBiyBPwnaEkiCjHB5/wKPfj9TuKZUX0fYgN6jOGzipt4VGAEJqleGT8Ou1RyNdl+S2xp2z3d43PpUNOmJ5VatAUZk6ugKWVrKzuF0Ix898o4PoQJhie/2MS4uaaGw9bFNfgCAlGamFF3Jmf7fLDITj3Klg2U/W0YePlr0TA3eT5oNLUDuV53i8y1zHaRGBuDxtB2N+PLfiUHqMB6WqYl8P1/OYK68Q4IL+zoHX/Y/YpnIEpCCbJ3EfV1wBMX3ecgjnHqpJUpCG9+f31U3zRTv84/n+KPrM2OXyTKEX44Nrd9GIvYWmWsgH8DTeTda1JZq7iONdlp8KR3pqQbXgmY+WM/pvEfiVbAIKpl2+15vk025//WzJTvQVhVSiNNgIO/ytBFkvArCecLcvHzAVR8CvUJyNmJNLABlZs6w1VJhoAD6tZb3ZhgbwXCes3vhRhC/mApLtEHcGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nfgWABvkd2Lt2D/aauffmKBt9bevbzwnEQB/1fSCBpJk3KeTarZ5UudysyIVJGBFmu4jlwXcoS8crPgyp/INAjbbaD3iWb1O3pG6gYVjoEcrI/cLtkin2HSi8Yy1B63rSn3ivl2njyTurMc+UD9qP2e0QLI6HFnPS2p91K+bOYqyqJOXBeArd+x1DIB71HhGxmptbGLMEhpC7YXDnIOLmYzSMbBAAVVl3FTrM3w6kN6lwv+FQfgiLRKj99DRPp1R9APolEugghVoCbegqzW0ox3W8Ccs6nIy2E7Zrq+q0T6GLM7B50Obm4JozZGJGv/k0WIBMyl8iNWD4UrU5GJXk4QFQLtmju2EUM9m3G1tOlzEd7kejevezCpcBUv6VbShXy920b2P3dHCCPWH5IbB+As0T2F8KUDEhkk7Z1KfIr5ZfH37wQropwDhqTWmdMcI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:23:29.4815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de3a73-253d-4b26-8624-08df155e1ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999313
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

Integrate userptr into the blob resource creation ioctl.

- A non-zero userptr selects virtio_gpu_userptr_create()
- Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
  advertised VIRTIO_GPU_F_BLOB_READONLY
- Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index 3a68a16b58..b8b9b40584 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -55,6 +55,7 @@ static int virtio_gpu_features(struct seq_file *m, void *data)
 			    vgdev->has_resource_assign_uuid);
 
 	virtio_gpu_add_bool(m, "blob resources", vgdev->has_resource_blob);
+	virtio_gpu_add_bool(m, "blob readonly", vgdev->has_blob_readonly);
 	virtio_gpu_add_bool(m, "context init", vgdev->has_context_init);
 	virtio_gpu_add_int(m, "cap sets", vgdev->num_capsets);
 	virtio_gpu_add_int(m, "scanouts", vgdev->num_scanouts);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..3dc058e50e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,10 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_READONLY)
+
+#define VIRTGPU_BLOB_HINT_MASK DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING
 
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
@@ -122,6 +125,12 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 		value = vgdev->blob_alignment;
 		break;
+	case VIRTGPU_PARAM_USERPTR:
+		value = 1;
+		break;
+	case VIRTGPU_PARAM_BLOB_READONLY:
+		value = vgdev->has_blob_readonly ? 1 : 0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -453,11 +462,23 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
 
+	if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
+		return -EINVAL;
+
 	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		if (!vgdev->has_resource_assign_uuid)
 			return -EINVAL;
 	}
 
+	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_READONLY) {
+		if (!vgdev->has_blob_readonly)
+			return -EINVAL;
+	}
+
+	if (rc_blob->userptr &&
+	    rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
+		return -EINVAL;
+
 	switch (rc_blob->blob_mem) {
 	case VIRTGPU_BLOB_MEM_GUEST:
 		*guest_blob = true;
@@ -495,6 +516,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
 	if (vgdev->has_blob_alignment &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
@@ -518,9 +540,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_resource_create_blob *rc_blob = data;
 
-	if (verify_blob(vgdev, vfpriv, &params, rc_blob,
-			&guest_blob, &host3d_blob))
-		return -EINVAL;
+	ret = verify_blob(vgdev, vfpriv, &params, rc_blob,
+			  &guest_blob, &host3d_blob);
+	if (ret)
+		return ret;
 
 	if (vgdev->has_virgl_3d)
 		virtio_gpu_create_context(dev, file);
@@ -538,7 +561,9 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
+	else if (guest_blob)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1d4d3bf46a..06c2bded49 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -249,15 +249,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		vgdev->blob_alignment = blob_alignment;
 	}
 
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_READONLY))
+		vgdev->has_blob_readonly = true;
+
 	DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
 		 vgdev->has_virgl_3d    ? '+' : '-',
 		 vgdev->has_edid        ? '+' : '-',
 		 vgdev->has_resource_blob ? '+' : '-',
 		 vgdev->has_host_visible ? '+' : '-');
 
-	DRM_INFO("features: %ccontext_init %cblob_alignment\n",
+	DRM_INFO("features: %ccontext_init %cblob_alignment %cblob_readonly\n",
 		 vgdev->has_context_init ? '+' : '-',
-		 vgdev->has_blob_alignment ? '+' : '-');
+		 vgdev->has_blob_alignment ? '+' : '-',
+		 vgdev->has_blob_readonly ? '+' : '-');
 
 	ret = virtio_gpu_find_vqs(vgdev);
 	if (ret) {
-- 
2.34.1

