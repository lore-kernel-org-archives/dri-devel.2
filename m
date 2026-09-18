Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731E1C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A1910E837;
	Fri, 18 Sep 2026 06:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UYxj20H4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786CD10E821
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqEv6nNDr8GNtKrqtAV/E9zyb4oKeMZWW+bq228sD5LjdLYgnWv48sDRBvP4/9JxBDklYASH9naNENsMnaUXX5W7pQM7N/Skja4guFvXhf8ZiDcWdZ6oc7VYpP2c4wuElzjPth8k7WdB0NQCdjxPSvBnqwh+DQzq9NF2AYn/xsTsykdyKLwxKbf8/sdidFxA81ghjHF6Y1geYxMbttGGYweFLdIoNe2fnJSeTqA2Z/UWecAQnOFeYy+dDoqUlqnoPlmkW7cioctiWXyVU+iRG34IEBluwf23eNBGbfq3t9kZ/gtVezx8dF6g7Kg+fSl3GF4DLx6J0T+oHvKoG6gZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJh0fssR6jqk9eTbXm98iYYXn1vIZRv8drZWsbcmuJc=;
 b=tq55et1k3DVHWZafJXFnE1ixKnwzzV6hapxNwdNqC+TR/l+rYQslfwEIpJl6x3qoTGecfCU87VNXOiLzswA8VNxh6LKoO5Q3KM0qVIk9Z2Ns61BCg+m318iDM9m+7ACYSnp+VmI5zrtQ5rcVMVRC3THs84e15cgnIY3R1uRygzgW7QsmcGJ4MlgVUpWTXX49VZClY8DJQQ5MlstAQdoGb9iCaG3V4MeLB0Hz5+N+D4jzDirXNXhkjw8E/g37b820kz1fwfpJmUZOeqhAFHVf6kzObFjrN2Bhn9WSmY8FpOdYpaanHAnuWNWN+uDe9aPnK3pKAuqmux7MINI/C73qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJh0fssR6jqk9eTbXm98iYYXn1vIZRv8drZWsbcmuJc=;
 b=UYxj20H4mXyOcBWdiDAWzHIWOBd/hANxf5wfTY35grd6mQh3PsB40C3ghaK8J3ITtH0aOQZgW/xK0axaot5NnWLHpCFXgFF13vK055cV8ur1lVRUfIVwHtwkUACmGJ9/xDpfiH1vUl15nvvig1EG5GxxAGEoz6nqVbP3KkNttrc=
Received: from PH0PR07CA0058.namprd07.prod.outlook.com (2603:10b6:510:e::33)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 06:57:11 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::10) by PH0PR07CA0058.outlook.office365.com
 (2603:10b6:510:e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 06:57:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 06:57:11 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:57:09 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 18 Sep 2026 14:56:53 +0800
Message-ID: <20260918065653.2170828-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918065653.2170828-1-honghuan@amd.com>
References: <20260918065653.2170828-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f30193-e5e8-47a3-d0ea-08df15521064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1PH59HaOC/WFOiEi5AYnj9wXnhV67RzQNiAnyby8FDpkjCEKKkn16IpIRNfx4sQmK5orfqN6diEF5MSdCvL0bt8jXnkDca6B5WaOBKmF8sa6RAUci9bAZmZEntb2Gf/V1UXtBC7yg/Zdg+S1P3ua4mBDr7AmUDROSscvjrs4yQ6Hb+Dk2N2GU9TqJ8v6XyqJN9CLaGzn0JPhBT+RKJNolIpNTQFK/ZQhvF+88Cbo+pz4H9WL8zJ8nMLn7/560OFg9oJ+Q+GuvAPkeGArBvcZbqxp3L6ire1n7+kgOhrbiAiM5hOwF1lgL03QX8Q7By6YM+z3De/0J2r5r8ZShk6xrh9UJeIxEeDbD7bpNQc90u24ZUepb1hjOlsy/d9JOrxrpCsGtZ5DqkheKHK9EFSt49TDJGw0c9YE6JORFYc4s3bsoNyy2MF89yFKlmTTBxjq+FAtPCuAlHlj0/1NzjqpT48686det/5P1Uhqt1GX9XxerDIxCuuChSh/1A+lN72Kv7jX+hzsDHRYKv63VKYjRJyjjpRbwuRUvchPG/UxdwM/zdbULAxpC1wLMWV/BgSIkPLZQV02m3g8d7/LRSSVpO87j7Cc96t1kb2DC3YkEp0ukDJPTiweZ/Hk4Fk/TsbHlNQsyCRl6swmxu1aIDBjBWhUxEV/T6Cs7HXI8SlEWmHckMQCHqk9Pr+7gJtWeNC+wYkFHmt09gBXCxpc7o97QQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: speZpyDKLy3BvFQ0WkgAb913PHXPMaqSPeIqbasd+zMZuR0MmFG+Uwf+0cJ9jCG4ThAGWmM/gedOf6Qi5oYrmXcbQcBnmDWVHeFQcu6bU2YjliJBjgOuk8LOVENRNIN5xij9CWlNHoKqioDM2eNkbj7GghnjAiuJlOUAeIiIJnTF4OpE51TLMIWgdU3Hx5ImH4R8TXPb9P5wPcl8vByiR4m4Z+l/0UDZ1XKyNLbXuItjIBXdyZ2/9WqhVuv7qVpYlieTnZdoEF/qVUw7xkbLfA31UIjY2stkIRA218WUom0usftThdGOV50K+Yyi7RcffL3gqQGJW1p70WXZlGUehVyFGZAYrmH7AP1qyjrqggO5OlviJTzSxaWvm4wQT8leGpSQhw/0JWWfxMZm7b+2Y1jFQv7KW2juWKlP6GRrJAoHCM9hnZk0Z9knTfBubQG5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:57:11.5098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f30193-e5e8-47a3-d0ea-08df15521064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
- Accept VIRTGPU_BLOB_FLAG_USE_READONLY and pass it through on
  the CREATE_BLOB wire
- Advertise VIRTGPU_PARAM_USERPTR

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 27 +++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..d42ca3898d 100644
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
@@ -122,6 +125,9 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 		value = vgdev->blob_alignment;
 		break;
+	case VIRTGPU_PARAM_USERPTR:
+		value = 1;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -453,11 +459,18 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
 
+	if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
+		return -EINVAL;
+
 	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		if (!vgdev->has_resource_assign_uuid)
 			return -EINVAL;
 	}
 
+	if (rc_blob->userptr &&
+	    rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
+		return -EINVAL;
+
 	switch (rc_blob->blob_mem) {
 	case VIRTGPU_BLOB_MEM_GUEST:
 		*guest_blob = true;
@@ -495,6 +508,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
 	if (vgdev->has_blob_alignment &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
@@ -518,9 +532,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
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
@@ -538,7 +553,9 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
+	else if (guest_blob)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
-- 
2.34.1

