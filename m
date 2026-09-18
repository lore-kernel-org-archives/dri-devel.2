Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE1C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B705D10F263;
	Fri, 18 Sep 2026 07:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEZbrMc0";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3D010F253
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6V/VEap/gwRav29wcr5egTaKcAVdAiCGv2errjMYg8gfhxbVRzQRI4bnx5uXE0E+0lZLDDygHgBK1TLYsuNzp7TPDgyreSLcHRmNq1FN0O/uMhat2qVASAue+Np7Rk3H77zXu6zhn0Tf4AX0Np92/VRuQxtNs8ZWhl79gF2GYionZ/CAxkLD4VVEI2/IueYgVexa1U+QJXiSiIG9M6ghblBXwUGPWQbBprW0fbcOL544OTUO12GERUzrVwy/JuF6eJaVfOxil63p1zaMUx2Aido2A2UTeyGGA4Hfb7hcB2ymiolgEzXnPPMG88QvS3uU4nZJhCJztmir3X2n0Amuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh7t9lCZvEKIt8fCKxkY0noneQl/NapxT7EK65Iw9pM=;
 b=LyzkSb0Ab3BlW37cNuxOiG/1qENBHXyk/+zN/3+75UaWoejsseJ+v6mPgn8WtT5IlEXA8RqsiQ1nwSTLpQPg1A8oTTsZLv92oHkfrXNDsGNj0lvipPuer23+EB4DJzY6em4bbg3MlYsZpdGqouHh2ufKRlnDI/5RClTWYHPLE5862dS4HzVdqZDCHZ/FnDHcArt/SxJuJoIycgE+rAE5i1C49a5U0UpkInUE9atk+syehEkZ3A8McFqn19BJaWznWek7ZQszRYbDSIYWU5oUCT8b5VbPHpfJdk25Uo2Mcx/aM0IsA0c7nax9eBrfDapy0G/EBp9z9oGtQE0rjWl2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh7t9lCZvEKIt8fCKxkY0noneQl/NapxT7EK65Iw9pM=;
 b=bEZbrMc0rLYFqeAF45Qi9INX+Dw+wh0vHHkT4trXABK0cjlKezOFVhp8OMYKuOPv/wZTN4l9K1gAxzyE0j+6Ce7ReHkpFYrigPwg22kiMqolQTW2b4x/WEnO5ccrQV7oHWqsJ85Lj8agEOc0ywB2Oej687sanajZHVMysmX2Ack=
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 07:56:18 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::50) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 07:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 07:56:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 02:56:16 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 18 Sep 2026 15:56:00 +0800
Message-ID: <20260918075600.2197253-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918075600.2197253-1-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: b191140f-b2f5-415a-8e9b-08df155a521a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cpDeo/n1yYRA01Sh9GmSlODZ1HCaGok1M3MIY08ZhTl6ZCO9o3iWskn7GTcT6YQh9xNyksLMqc2QkJHq7zIz75YgdQNOBaF6Z+c05Uf3grQokhXCF3RGSy+L36U5Y+Oq8mFypGyQPyqFBb/X6sJxSGCPwkx6tJnyKZ9Yn1U0vSWI89yf2cGIWxun2HfocZtdcmxt46l6iEBgvPRH002mIVKnRpnUJO4znZg+IXExkZl0FfwHhTATpdatKdkDMvnaGHSVgTLx1Jvvghbk/+1ynpI8kGP3rV5qOvRlNNmbLag8yeSD0iGXzXy+Pm+orUjsyPlScUQA++hm9rSisqy/EC4Q64Qaf3FE06VFT7ff+OTUA8v1dqvsT2YDxIa9r/dK5zxoTGoaRNp6+zga7tUAzYPCSv47a4XPYAnqBwNGd3dQO9tVFUTrL9RwgrxHaekDUfXnyH57CPRUpJVQKlpVCcPHxaQpDqIqPXlefbSpeOOz46NsE88Ok7y+HyGPNzkfAIgGSb2HnDZne0n86yBk7J7sIEZYKnNLHFAIesM4wASPRabwuoFMRyg7zQr+x+keWdJRTeLh/5M3DOwsk/OHiQQO8WvWKg212OUnowR2aiB0lNDtVXMwa714vlSgAFyItnuvqUzhc5IF3RqI89hsyME9/Rybr6+rJgw8wt+nWG2hthwnuRNcrG0MWoPzvuFn0NNQZFymKeoDokTo+L+lrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n3O2aLyURz5nTHroZQMllWoXJcEmxM98iYDyWrM7Q1+r8Q6D9EZIeymKCOathe8qM+JjVP5JeLRIaEKiuO5AcLTCu/QTCCwDbhDO5s/EvmRYfTAH03JzL4FXzZPIMsbNnjopXPCgoS9zGE/AUmGC6b1pgUFlO4T5M465kjmxg5+7P7PhAeD9mwb0JCv4RY35g91KMjDuXSsQbUev7Y6X2RNsUPR0Mb3ky+smvn1XDTray+dnHYUTBLoJa0ZT1FqGOOvbgtv4eGuPsv0FTSD5lYoSMmSEvpmLZ2KDckeaI3oZSsUdAtLAIYJLiXirpeILd2AJbz6Pa2ldyM+FsZwXa+mX1It74JAsRcJ8fAC0S2Q3B7ymtOjpcl/YUAneRMEpBsgVwHveEGiCozN+jaUtMrc2we40KRWCAY23dt6NADPPfgDMqA03mqfot/zsKFCp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:56:17.8281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b191140f-b2f5-415a-8e9b-08df155a521a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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

