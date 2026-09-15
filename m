Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2A9C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E74C10FA8B;
	Tue, 15 Sep 2026 07:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UNztBd7H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0040B10FA89
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 83AD244043;
 Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59C3AC2BD01;
 Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789457988;
 bh=UdMaaxVxX8faS5D/R59hxfAkCFC0hSCarXqNvw4Plzk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=UNztBd7HO35GxpuzWbeFV3i+3XTQGaItN9kYkboY3gU+78Lf/k5ffAreYxTLLFHfQ
 QmEu3CTCotYs3LnqbKBR3j3NKNtmZLtSfNhWqztMKt9K6pywM+SMrh0nNoxvBzk54i
 ZAoFDU6RjxvHvgAhnf/w9mY+J5fz+rsORBJoL1l09UsNnGICMgcE1B0GmjLHx4OgzV
 4SfgFH6eq2mtu+TWE5SEN6yuZr6vqotiM1a9OF22xnYNKCrJ/JT35VU18XlyChA4+X
 BaJyPDQEYbDFHTx3qO/QcrMHfUrjPng2TzO2he9z1ymixNK1axCiizqoxPqrofUaKU
 3dm1v5yzfndGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3C025C88E75;
 Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 15 Sep 2026 15:39:12 +0800
Subject: [PATCH v2 3/4] drm/virtio: fix object leaks in
 virtio_gpu_resource_create_blob_ioctl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-fixes-v2-3-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
In-Reply-To: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=gmVVZGqljoLUgVlULUlI1tOIf4EBWb5LQtGm6rkt9fE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBXfnPhTbs/5prpKPvbE5ptnF9Rk6sdnvZlnn9f1d
 72ntLBV9dqOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmEhdHMP/UIW9ipqJV5Km
 /Wd8dGJ5As/5Yxmf/e07u8p8pZM3TFk1g+F/+hy9zXW5bH8spjY/9Crh+vl3g+NVdb1pOWzif47
 n/rrICwBu3U3v
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Junrui Luo <moonafterrain@outlook.com>

virtio_gpu_resource_create_blob_ioctl() calls drm_gem_object_release() on
both the virtio_gpu_resource_assign_uuid() and drm_gem_handle_create()
error paths instead of dropping the reference it owns, so
obj->funcs->free() never runs and the virtio_gpu_object, the resource id
and the host-side resource are leaked.

Use drm_gem_object_put() instead.

Fixes: 897b4d1acaf5 ("drm/virtio: implement blob resources: resource create blob ioctl")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d16f07abb266..fcdb07a37972 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -557,14 +557,14 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		ret = virtio_gpu_resource_assign_uuid(vgdev, bo);
 		if (ret) {
-			drm_gem_object_release(obj);
+			drm_gem_object_put(obj);
 			return ret;
 		}
 	}
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 

-- 
2.51.2


