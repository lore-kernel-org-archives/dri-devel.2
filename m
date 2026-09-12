Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D11C88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B0310E9C1;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBN/3jNs";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27AE10E076
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 02:50:21 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca94bso715275e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789181420; x=1789786220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dS5TWjIyY6rCkmcHNbVz3M1ExhC8gLMjxLvMLk2nxQw=;
 b=IBN/3jNsG4kIWBhVSRRNHDh95WpSJtYbTzuFhyjT3ubs/dLLIsQkFhpTqrPDtF0KIa
 pmgFYV+BneI9w6o3Nx+kUJ8M2J8SAwqCTdelNX7A21TU4f8kpYCW/comW77q5/BOUxof
 whdWCdrPzC6Nf4rC2iC+axVKAgYYTkqkzqjBQmPaLAZDXhLdxJLZWYnw8yZhBBxWIG3O
 iVTnHMue1i8si1RbAz25RYul5y7QrJ8AsM88vXVB1yhARqLnKjgnBnIv4j1sIJsIGJvY
 PaTUer4ocCFgbj4l50IBf+Oq0Nx6STAxRbO+zTqHabdKGwwG0y3pH6W+60O/WfWEfKwd
 vfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789181420; x=1789786220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dS5TWjIyY6rCkmcHNbVz3M1ExhC8gLMjxLvMLk2nxQw=;
 b=SGd2peyMtaLQ9OzyHrLGTTnLu3urjaql9CRuL6Cf7IJyaPItPQW3wLNhbFQOaGov5h
 Hxjh6Jr6vBD5rVdd1gq02RbGX2TzDmjc3ALI56J+v4vWq4iord4rHCrzNIrwerZlOTaZ
 zUg3gpTyDX84iOLNvScMO3jFJw4E1To17UeryBIaOEaEC3Ub+o90cPaGWIbKgh3HOj9k
 wJIa6jN20iRFTNQduOcPpbYCFE0BlhH7w19do9qkO5i0HBdei1cd6pR0qJCLIYy3ThlT
 HZ/Is+p8cPu/9NiGIu1oZq3z/Atg+fMBtRvgP1RxQyYQ1CoaVAo76Bb9ts0/rMRce1Be
 vKEQ==
X-Gm-Message-State: AFuF++kQq74uUzfO8mRZGjhKRplOynNK3NgIE4Pu9eeKchjLkkojt9rI
 SR63PkeHoef554rdI9mTtEHuFN3P7rp1msueZKcW2Qqq3xkxtdqjywtm
X-Gm-Gg: AYBFou2NaBHYQmIZUQMbRgo+80O4wNmd67j54SAhJCFfaWfO7IT3qvryREkQrv1lzWC
 Qvj+QfsthrDQpB55tK98dPXrU3GU+NQjIFP9fIQI706yefUUsz79yLg9jGPVz7ggFt1CKtED6Dx
 KlTw1b6oObhM41qVnmh5JTIiQv+bPjbbt5lCvmDkHPGmgKlG+I3eXOi34jyzANe27iBe7TjDhkb
 hNYzjathgieZ+Yk/sQKjwNiz8RTAANTqPvWXOlFI78kBlfxLLTYbNUM7mi/hJYdmz087/vKY03z
 S5ZIgsQrHeSs3cTednfozFVIyEdVnLtux0FlJImvSsNq9Xl1va6anJnYCK7XafTdkX67u935Smg
 4o8+bQLL0TY1S25v3/tvA2yLwCAQYdyC6baXXkWZvGRv4ebFpRtZT/v28GqAaNwtF3knZrA5VUj
 HaZ31x9E3bGe53WyHwPctqPSYmg8vd/qVY6bSI1NUoP/juPabm1a01pR6Mh38mF36M0itaTAebj
 0vVsA==
X-Received: by 2002:a05:600c:1c1b:b0:49c:fc6c:be05 with SMTP id
 5b1f17b1804b1-49e6cbf99f1mr9581565e9.28.1789181420012; 
 Fri, 11 Sep 2026 19:50:20 -0700 (PDT)
Received: from beelink.. ([186.247.163.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm194629105e9.2.2026.09.11.19.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 19:50:19 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/qxl: validate relocation dst_offset against the
 destination BO
Date: Fri, 11 Sep 2026 23:50:09 -0300
Message-ID: <20260912025009.1991197-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

qxl_process_single_command() copies relocation entries from userspace and
passes them to apply_reloc() / apply_surf_reloc() without checking
whether dst_offset falls within the destination buffer object.

apply_reloc() writes 8 bytes and apply_surf_reloc() writes 4 bytes at
the byte offset named by the relocation.  A userspace-chosen offset that
exceeds the BO's allocation leads to an out-of-bounds write into
adjacent slab memory.

When the destination is the command/release BO itself (dst_handle == 0),
the write lands relative to the release's own release_info header.  An
offset of zero overwrites the release_info.id, which the garbage
collector later uses as a release index, leading to a use-after-free of
a release chosen by userspace.  Both paths are reachable from any render
client (DRM_AUTH).

Add two bounds checks:

  - When writing into the release's own BO (dst_handle == 0), require
    that dst_offset points past the release_info header and stays within
    the command data area.

  - For every relocation, require that the final byte offset plus the
    write width does not exceed the destination BO size.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026ce..b62f32b6d 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -227,10 +227,27 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 				goto out_free_bos;
 			reloc_info[i].dst_offset = reloc.dst_offset;
 		} else {
+			if (reloc.dst_offset < sizeof(union qxl_release_info) ||
+			    reloc.dst_offset >= sizeof(union qxl_release_info) +
+						cmd->command_size) {
+				ret = -EINVAL;
+				goto out_free_bos;
+			}
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		{
+			size_t write_size = reloc.reloc_type == QXL_RELOC_TYPE_BO ?
+					    sizeof(uint64_t) : sizeof(uint32_t);
+
+			if (reloc_info[i].dst_offset + write_size >
+			    reloc_info[i].dst_bo->tbo.base.size) {
+				ret = -EINVAL;
+				goto out_free_bos;
+			}
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
-- 
2.43.0

