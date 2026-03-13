Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE06105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187D210E175;
	Fri, 13 Mar 2026 15:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="UYw6stbk";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478BD10E175
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414674; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V4vsuUaofgd8lt0XzGwpkWlQjfq6Y1PPNiDJ8nJj8sWL3pKOO45mnZfUhrYUyX4hCvuW/+cx27tj0Z954sudKteCpxJfAsfVu8nWk49OWs3QVRyspY3vgKQJswp12vg+6NFoYBhUbIhTpGEXci70jG0v3NntbRlHytCAEC9nTM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414674;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ddH5Yc4c0IevX3wa5L4ZVOfMqtq9xMzu+E7rLqoDebY=; 
 b=jkGOZvMQJuaOpmJPHZJPGhVJK6zJ5YZiUm38lGsuKhoitL4a/asT+rt0XxciYfcNtj1VNfzJIw66sWU4Teodf1+dp9LuuS6d4uav4fEjvoOrkJpqWag2jeEt6QUx25dp70DLPuCtl5Hsp7I9fGJQVmyNSlxvvKi0wR8H1WTXgP4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414674; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ddH5Yc4c0IevX3wa5L4ZVOfMqtq9xMzu+E7rLqoDebY=;
 b=UYw6stbki7TROzm+DDJQDDTYJqAZp6x3idB/5ISLL/J5v92952so0i6Mt5uMbQiL
 IUvQ8BICjBXA0GcCwt69MhTjckB/UYxUgmZZsiieIzRnaiulZDcUxhFf7/QT5PfTFLT
 KDlRoTZ4Gl+8JT6ui8t2O92OpVhBXYfoLLainFl0=
Received: by mx.zohomail.com with SMTPS id 1773414672194873.5209431416926;
 Fri, 13 Mar 2026 08:11:12 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 07/11] drm/gpuvm: Ensure correctness of unmap/remaps of
 repeated regions
Date: Fri, 13 Mar 2026 15:09:44 +0000
Message-ID: <20260313150956.1618635-8-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When an unmap or map operation that leads to a remap intersects with a
GPU VA that spans over a repeated range, the newly spawned VAs must
preserve the repeated property, ie, VA's range must be a multiple of
gem.range, and also the VA's start address must be on a gem.range
boundary. When this doesn't hold, disallow such operations and notify
UM with an invalid argument error.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 67 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_gpuvm.h     |  7 +++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index ca7445f767fc..80750119221d 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2462,6 +2462,65 @@ static int validate_map_request(struct drm_gpuvm *gpuvm,
 	return 0;
 }
 
+static int
+validate_repeated_unmap_request(struct drm_gpuvm *gpuvm,
+				u64 req_addr, u64 req_end)
+{
+	struct drm_gpuva *first, *last, *va;
+	u64 multiple;
+
+	if (!(gpuvm->flags & DRM_GPUVM_HAS_REPEAT_MAPS))
+		return 0;
+
+	/* Find the first and last VAs the map request intersects with */
+	first = last = NULL;
+	drm_gpuvm_for_each_va_range(va, gpuvm, req_addr, req_end) {
+		if (!first)
+			first = va;
+		last = va;
+	}
+
+	if (!first)
+		return 0;
+
+	if (first->flags & DRM_GPUVA_REPEAT) {
+		u64 addr = first->va.addr;
+		u64 range = first->va.range;
+		u64 end = addr + range;
+
+		drm_WARN_ON(gpuvm->drm, first->gem.repeat_range == 0);
+
+		if (addr < req_addr) {
+			multiple = req_addr;
+			if (do_div(multiple, first->gem.repeat_range))
+				return -EINVAL;
+		}
+
+		if (end > req_end) {
+			multiple = req_end;
+			if (do_div(multiple, first->gem.repeat_range))
+				return -EINVAL;
+			return 0;
+		}
+	}
+
+	if ((first != last) && (last->flags & DRM_GPUVA_REPEAT)) {
+		u64 addr = last->va.addr;
+		u64 range = last->va.range;
+		u64 end = addr + range;
+
+		drm_WARN_ON(last->vm->drm, last->gem.repeat_range == 0);
+
+		if (end > req_end) {
+			multiple = req_end;
+			if (do_div(multiple, last->gem.repeat_range))
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int
 __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		   const struct drm_gpuvm_ops *ops, void *priv,
@@ -2479,6 +2538,10 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 	if (unlikely(ret))
 		return -EINVAL;
 
+	ret = validate_repeated_unmap_request(gpuvm, req_addr, req_end);
+	if (ret)
+		return ret;
+
 	drm_gpuvm_for_each_va_range_safe(va, next, gpuvm, req_addr, req_end) {
 		struct drm_gem_object *obj = va->gem.obj;
 		u64 offset = va->gem.offset;
@@ -2653,6 +2716,10 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 	if (unlikely(!drm_gpuvm_range_valid(gpuvm, req_addr, req_range)))
 		return -EINVAL;
 
+	ret = validate_repeated_unmap_request(gpuvm, req_addr, req_end);
+	if (ret)
+		return ret;
+
 	drm_gpuvm_for_each_va_range_safe(va, next, gpuvm, req_addr, req_end) {
 		struct drm_gpuva_op_map prev = {}, next = {};
 		bool prev_split = false, next_split = false;
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index cd2f55bc1707..61f66dfe4ed7 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -230,10 +230,15 @@ enum drm_gpuvm_flags {
 	 */
 	DRM_GPUVM_IMMEDIATE_MODE = BIT(1),
 
+	/**
+	 * @DRM_GPUVM_HAS_REPEAT_MAPS: There are repeated VAs in the GPUVM
+	 */
+	DRM_GPUVM_HAS_REPEAT_MAPS = BIT(2),
+
 	/**
 	 * @DRM_GPUVM_USERBITS: user defined bits
 	 */
-	DRM_GPUVM_USERBITS = BIT(2),
+	DRM_GPUVM_USERBITS = BIT(3),
 };
 
 /**
-- 
2.53.0

