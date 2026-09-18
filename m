Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906D6C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE74510E81B;
	Fri, 18 Sep 2026 05:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaOJjSUJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1D510E81B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H33he4pQCQrzrHheY6SjvOakeZXRNaThJdCN+rOsOa5y7FgVDZGP1F90A1/LTGoQdCrPNGIjRyBcYn5GQqVgcx7bzWxVPfUvRJF7RyFxXqqTBrwVU9grB5N1qjJQqfvPy0qWffMniC9TLJqBJw1Odt0qPB9Su51jdJqjAbLheMMxG0JkFnk4U7d+0fGW2/je6COba0Tpj5SiqD4NkYYayQ3MVw1MFlT8H70HFCIeezVFbEydlDdsnTSvYSOOAnbluT7Xt52v7GKksp/FIcXRQNK49S7W5q81i0KQhb/HRb5a7AgHxQgFb/RZPVBSthLD43WhYVoGcUQcGAWjMslMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCJdbxMl53zu6YWD2gEnQkBU8tuaJsSHhyRwawa5J9M=;
 b=QRBrVqOF2WfRGqQkb/GgmTBZUCEzNoj9ceLUg1yte60NcDqVjJi1lnK1GNkJIi4KXPWRHI0ZR/r4I0gNKO9kTmIbBBF6JBtKDI9bqDjFRuKFohw0QKEkebtbu2dJPyDeWD9rU5UBf6e8jNzyukjsixHdpiFHFTPLsvcFnYXD7ThuA1CIje5Noo20/p3AJLd1eIMm4GqQzxx8yK4J+mRIc/POHEjV5rwZcsox+yl588oJ6RUIyT9JIW6bC7aeHuieQ4cVoXA4KsaRy3HtzInzScNDcnn/dElKio5JKn+mJw3bYbuiJOI/6C4XvspfzaDaR9u8v6+JQjHYWLbhHvCgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCJdbxMl53zu6YWD2gEnQkBU8tuaJsSHhyRwawa5J9M=;
 b=UaOJjSUJzCP3o7ie3daPdzdzqXeug4eg2IwbC82s42mMtDpdak5RNstMJGkNDY2S3I7fY1QvzMkAGBMU7iY5w9VIkVxdyRDj1RSZ2mZ7nF4tSNijZgp0VZsu5thlr3yF9LMtt8mwZR5yHeytHEWhBAoImurh0z2tvUANl4i8P9w=
Received: from CH2PR14CA0032.namprd14.prod.outlook.com (2603:10b6:610:56::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 05:59:34 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::49) by CH2PR14CA0032.outlook.office365.com
 (2603:10b6:610:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 05:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 05:59:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 00:59:33 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 18 Sep 2026 13:59:17 +0800
Message-ID: <20260918055917.2133574-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918055917.2133574-1-honghuan@amd.com>
References: <20260918055917.2133574-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8b9d7c-22b6-4ef4-4b5d-08df154a03e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IehFMJiiQExFrsylsuGZ+NmQtAhWEV2a87k4Oj4hKewnfx2dOj4M3EuG4MiZV734008woU6xLoV+Hkv81tUMLl2DZtMmng08z7WaN5S5EhBSSSavL5HzydpEQp/kKkDO7dJsxqT6fwZ7tM6tKXWR7ABRvPKF2IyZSWCDyjzFjpcgQWEIuuvZ/em8DUrZT0ZA9vL1W5mCGLDgMCGwUeFx+Mn18IHZvIDeCjqVYjziDlM04JsvRcBt2NAkS35eDvamUgwlx3i8H9SljNxbpNMypzwJVP5ZYTraBmLDG4rlsXFTI9bslC8o1KbW9CkJ5BHv1tbHbI6Wms6I+pU18lH4hTTvVpCGJRLchqThji8/6WR7L6524W115tvs0alwKWvitnVaW1o92ZE+FX+duH8QJKXfK+9ZOBlCMvxGrWV+Rsye1NsdTknP06nLj9J7/Pua4GAA17LMytcSza1CPNzw3b4BFcvpzQsMglizpc3X7lLV98ISdzVTTfAyK2xKPUD8FLEBdlzju48LrZSbS2tKy1mQZMnhSHTCnpY6qdKdZWfSWUYNVqnIX3MgASTuxS4AnKjaZmRfhB6Db//Mg7e98uLJs7Zyup6p9IeL3ScWsycEMgYV6jDT5a26y0pA7hRG+zZafiII6ZB9Zhe8VQlmZk/+bm+/b4Q2UEbgS1Ja2pyR1aQdDT5ZXbvyqOCfaDrWNZtRWeLl6xsp1X1UAucrwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 80xmTtuV5fBnK01WqCcW9tYFrgV68BgM3ehc3YCInkvq1AppyM5YBaemUqjy62qsV0xrDX5E6ePoHUuRGJX8Yo7ndbF/rmUowamIzvDttSo1uunRxwjthx4E6gN8DjLYEGr43zo0maoy950cWEQESjZJyFsB/6k94ldOXMd6CfxdqShv7N8RVH+pPnpH/DxWLGJYSd9MVGohJyU3G5lDOzl+w92t1slZ/ukanHyfpEykXX5UgsOs3CFhbIMD8TnMvM3Ycaiv/NS+WHRb91JCd0s511YZ34D1VXfr8S3wjWWK/8O+uCjlt7s+LpjUATLwUko56z/reuNMKuDnP14nkL8nQ3Vi7+HjtrZtgxPZp/awax5txsIo9Tgeh2z5enrT953+/KleZUlMgLuxpIsw9SwuhknEkZrYEGPnnHSXpvl/vWQQ4WKEvj7zAarmfBHF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:59:34.6353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8b9d7c-22b6-4ef4-4b5d-08df154a03e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

- Accept DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR and
  HINT_USERPTR_RDONLY in VIRTGPU_BLOB_HINT_MASK
- Require userptr if and only if HINT_USERPTR is set
- Reject HINT_USERPTR unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Pass the userspace address into the internal create params
- Call virtio_gpu_userptr_create() for userptr blob requests

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 29 +++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..225a550be0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -38,6 +38,10 @@
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
 
+#define VIRTGPU_BLOB_HINT_MASK (DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING | \
+				DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR | \
+				DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY)
+
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
 					     struct virtio_gpu_fpriv *vfpriv)
@@ -453,11 +457,25 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
 
+	if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
+		return -EINVAL;
+
 	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		if (!vgdev->has_resource_assign_uuid)
 			return -EINVAL;
 	}
 
+	if (rc_blob->blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR) {
+		if (!rc_blob->userptr)
+			return -EINVAL;
+	} else {
+		if (rc_blob->userptr)
+			return -EINVAL;
+
+		if (rc_blob->blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY)
+			return -EINVAL;
+	}
+
 	switch (rc_blob->blob_mem) {
 	case VIRTGPU_BLOB_MEM_GUEST:
 		*guest_blob = true;
@@ -472,6 +490,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 		return -EINVAL;
 	}
 
+	/* Userptr is only defined for pure guest backing. */
+	if ((rc_blob->blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR) &&
+	    rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
+		return -EINVAL;
+
 	if (*host3d_blob) {
 		if (!vgdev->has_virgl_3d)
 			return -EINVAL;
@@ -495,6 +518,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
 	if (vgdev->has_blob_alignment &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
@@ -538,7 +562,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob &&
+	    (params.blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR))
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
+	else if (guest_blob)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
-- 
2.34.1

