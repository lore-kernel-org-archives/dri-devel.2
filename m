Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF993CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA7110E548;
	Mon, 12 Oct 2026 07:32:19 +0000 (UTC)
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2735210E02A
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:01:24 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 98e67ed59e1d1-3ab1a154579so275404a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791687684; x=1792292484; darn=lists.freedesktop.org;
 h=content-type:mime-version:subject:cc:to:from:date:message-id:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rNcSfb2fz+pnEjz/bC8gFntw6Gwe17MPr3niIZnTHK0=;
 b=NoBwpN6UVwQXgg3lThasHxypj4TydIjEsiZHtqojWi9j3nHsYYI2bHHf0Et7uA8wjQ
 dacplBIECsRuAZZoPT4JHDnIil0UW6SRZ1Noe4ENrTkUGRBYg7qWeCIyuzckMnKIggBH
 k+kvUXeH873nOKjaNBtlXlwT2nM964hOwtVqPFhS9WiHhut4Fh4rKGQAGRt8sHtGipbn
 +5IrT2gfTq3W4hTIQ2CF9/H8ekcPqyyPi1t/HJMOgK5jw9/svsYPcUCDzF0HyOLT+JyK
 HbeYxKklqkB2LrtdBORmqwhqEJflVBv5hn7C4xKaM+PvGshPZ/h965SKe1uhsX8s0C8c
 iKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791687684; x=1792292484;
 h=content-type:mime-version:subject:cc:to:from:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rNcSfb2fz+pnEjz/bC8gFntw6Gwe17MPr3niIZnTHK0=;
 b=SRW/xG7mg5z0GPq18AukBMByf3s54AjIOc8Rc6B0JeSI/8DqdaXxCxOE9/FcJkH+3N
 zOt0mQg1N4BLEbNpi8tjDlqEN6Twuydn42+gXVf2Ly5XMsnQcC9b+V59Z37fUeCqd6LW
 Q3Fv6w6tbhuEU5wUrQckrbw1UW0I5o1iov0DSe3/WRLDQCjhAjMp7E5PzFWXAVGZnVlg
 YYlBl5zov9gJDxCs9AZ0eNo25yW93F0qIjz5tU7gE7hsLOIwk4+8DpS8xBQzNyE6Tt5t
 JB/eDMRKmQzfJHrT/P/ouKvAzGS1U1C7cdfnRGCUpUq7esxhq5HyU0SYYW2YBYK9nX2e
 2eYQ==
X-Gm-Message-State: AFq9FYLYQ9w4z7rUdWYAehs4ndSHZGCWtHl57Vg1XTGCS+1Balh5LcnL
 f78HyD7Gp+igJfqnYVCYCGvTrGFH1SqAtMNhTFvGt36oygnr/aci+ATa
X-Gm-Gg: AYBFou37ncQ6iRYhrUPL1XM51km3lVoR2H7OmmD8P0vYz8mQPfQiEGJojU63ZQi+6iV
 Hejml8/eBopUSv74uKRzKZ4BrKXSwRQHQ1RMn4DLTTkI8RPMBs//m+iUpx47Y/A0tMBFsfBy1aS
 I00TvcO3FcTnTjlQU65ESnQTu2o6Azf/PKI2ryuTQMSVHfvyGCmQNdKZh+XOYUDYa4SHA5LGVgp
 7hZTsaLeZFLV1/2KafUI6ji0JL087cDWg0mPPrD8OJdN2kxJZWvKTgYzPiImzpn/zghXx+zxX2+
 OyFNt2RaovagL43xXM0YP5Pd7/nrwUCL28xLhvbZ0PEkKZkUmX7SJfCe1WUW3m96K5967d8KaVG
 HxdWqe6zS/xiSWFPtVzU8iErUVNGXZKNuV6NgZsu++wpKL9M9ZxdLXq7o1ribnGkj76/ee0EM16
 OSc5Up7dtbXeJVAK13JWjdSpVrtVVnxIzTaMOhWSKbHHjJDh/6KNJtxPiD54zEAhv67Twj9Bt2e
 YM5x/gSVU9HYaEgxctvY+TqJbz3jFddGLfKiaCQ0uYIzSc=
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a4f with SMTP id
 98e67ed59e1d1-3ab3af75ac1mr4671255a91.51.1791687683539; 
 Sat, 10 Oct 2026 20:01:23 -0700 (PDT)
Received: from send-qxl-v2-public.eml (bb116-14-52-5.singnet.com.sg.
 [116.14.52.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3386ba90sm6645866a91.1.2026.10.10.20.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 20:01:23 -0700 (PDT)
Message-ID: <6acafc03.6b76d992.279a8.b343@mx.google.com>
Date: Sat, 10 Oct 2026 20:01:23 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Subject: [PATCH v2] drm/qxl: validate relocation destination offsets
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

The QXL execbuffer ioctl lets userspace request relocations into a
destination buffer object at an arbitrary offset.  The offset is never
validated against the size of that object, and the relocation is applied
with a plain pointer write into the object's io-mapping window:

  apply_reloc():
      reloc_page = qxl_bo_kmap_atomic_page(qdev, dst_bo, dst_offset & PAGE_MASK);
      *(uint64_t *)(reloc_page + (dst_offset & ~PAGE_MASK)) = ...;

  apply_surf_reloc():
      reloc_page = qxl_bo_kmap_atomic_page(qdev, dst_bo, dst_offset & PAGE_MASK);
      *(uint32_t *)(reloc_page + (dst_offset & ~PAGE_MASK)) = id;

so a user supplied dst_offset turns into an out-of-bounds kernel write of
8 (or 4) bytes.  As the offset is additionally truncated into a 32bit
member and handed on as "int page_offset" to qxl_bo_kmap_atomic_page(),
the write can even be placed before the object (sign extension).

Validate the offset plus the access size against the destination object
size, and make the offset/parameter types wide enough that the check is
not defeated by truncation or sign extension.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
---
v2: use a real-name Signed-off-by (noted by Willy Tarreau).
    The reproducer and full report were sent to the maintainers on 2026-10-06;
    the reproducer can be shared on request.
 drivers/gpu/drm/qxl/qxl_ioctl.c  | 20 +++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_object.c |  2 +-
 drivers/gpu/drm/qxl/qxl_object.h |  2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -73,7 +73,7 @@
 struct qxl_reloc_info {
 	int type;
 	struct qxl_bo *dst_bo;
-	uint32_t dst_offset;
+	uint64_t dst_offset;
 	struct qxl_bo *src_bo;
 	int src_offset;
 };
@@ -149,6 +149,7 @@
 	void *fb_cmd;
 	int i, ret;
 	int unwritten;
+	u32 reloc_size;
 
 	switch (cmd->type) {
 	case QXL_CMD_DRAW:
@@ -231,6 +232,23 @@
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		/*
+		 * The relocation is applied with a plain write into the memory
+		 * window of the destination object, so the user supplied offset
+		 * must be validated against the object size.  Otherwise userspace
+		 * can write anywhere in the mapping window set up by
+		 * qxl_bo_kmap_atomic_page(), i.e. outside of the object.
+		 */
+		reloc_size = (reloc.reloc_type == QXL_RELOC_TYPE_BO) ?
+			     sizeof(uint64_t) : sizeof(uint32_t);
+		if (reloc_info[i].dst_offset > reloc_info[i].dst_bo->tbo.base.size ||
+		    reloc_size > reloc_info[i].dst_bo->tbo.base.size -
+				 reloc_info[i].dst_offset) {
+			DRM_DEBUG("reloc dst offset out of bounds\n");
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -204,7 +204,7 @@
 }
 
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
-			      struct qxl_bo *bo, int page_offset)
+			      struct qxl_bo *bo, unsigned long page_offset)
 {
 	unsigned long offset;
 	void *rptr;
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -63,7 +63,7 @@
 int qxl_bo_vmap_locked(struct qxl_bo *bo, struct iosys_map *map);
 int qxl_bo_vunmap_and_unpin(struct qxl_bo *bo);
 void qxl_bo_vunmap_locked(struct qxl_bo *bo);
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
+void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, unsigned long page_offset);
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
 extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
 extern void qxl_bo_unref(struct qxl_bo **bo);

