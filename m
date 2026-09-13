Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35328C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323DD10E8B5;
	Sun, 13 Sep 2026 22:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6e70v+l";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6FC10E8B5
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:30:23 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f705536so356316466b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338622; x=1789943422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vt5o0BxKweowhjdX5zbCd6SyPluSfyfpCfycMWtAzT4=;
 b=j6e70v+laPFpROo2V6BeV1Um9NXI/rd11CP6bPhHysrOmjvErU9isRN0Pw34aPeC9Z
 VAbW4wHAcOaJ7C0Nf66pEjJmwAAw1V97nTUkkCYsayCz1XvKT+3vw7Vmt47rXiVNCsAx
 f2ajrnOE9grMsRF6T7jo3C3t+1XYtM7AEz3uLkMjagSLla4sJwjQK9Q97AXM7TtDY1sI
 iGR+LSNvyT/j0aO+Pe+ihqcMNpOxXnqt02Zg/y8iebXJSkEOcL9bkRKcScankLgImJ4u
 PuhNViXZQz76hRW3h8E1RcmRa1Pf2JF4nCP0Yfsc97LwnvfStrP4qWEN2kKn+POrivLV
 0Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338622; x=1789943422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vt5o0BxKweowhjdX5zbCd6SyPluSfyfpCfycMWtAzT4=;
 b=c+zwZhC9fWcqxWGoXupgWVEBpeJqj7SP1g3AcrBvCIn/s6O3M6VtmZ5HvbFf5ND9K7
 9aoPiPB7hd9LR7TLbnPStjBYPrXdoniZAEz5nbMT1IOCUSwvRs2pgzTtvb2fdqdiCZ3e
 HNDaafR9pDPmfIQHOaVTEc5I2OcbixzIzvxagzrA6kiQ3YI8iTJRHHhNAoFdukh4FBAp
 q7LKsF2SNdrAqDmh6lzb4w4mqi7av6/YKzBqjNHxUy/znkQ/qgfegKWiZ9Cr7hrgcaYy
 Sa3Ng/7Qc6FbMB95EISTVTRtlF9OG71RJZkwpLymRzxDcdT2dJborRk2Pmed9vg8lubJ
 w8sQ==
X-Gm-Message-State: AFuF++mcJt3cvuak7nYdBq7lURKqqBPUJNGgNj4FoFCcsBkpQMzhmQS+
 sDXsu1kQM+9+00eHHEPg2dTcf/HW+wnFDspwKz1+1IMkSq8pqaR+8B8P
X-Gm-Gg: AYBFou2pUp2yUQ5QLq1XNWcR4ZsTwdo0ORLMBGdQmYCXQAX/3t0w++g8VDgxTY8Da8M
 w0OgEXZNeEAqn/kmQYcytcAHyqK6sjnVvTxzUgrIYvb5eEZIaDy/nbuCmxRvR7Ph4D4VZfEBcv1
 zL2YJTxxv9rcka5liPKpIBncO/F4PRwbnrxez3hX2WJBDNyiodn3sgUvu65Anx96+twJBSATQqW
 ADHeyz/A71W+cxhYfARXglhl7B+ocCxgdz9nCVdjzjYQvZySqIasUoPQaJDqQ8+2ZbMKsdV6Vae
 4PwP3JK2za3C3PaXtUYuU93N5mT9VR8W5qu2ml/XqZtb2VrsGI/ex7jdIpe7Wqm7yeUWwJbPo7p
 ZQBqB2JTlevg0P4EkNWX5CmHC8ATJ3iVull+HyYofU1qCtX36tayhObnd5dJANtOPWAkft+XERR
 8Y8gkbBJ14zQMfd761r0rPNkHGlOxwI6LB1GjGUrR2eON1T2vXcAPzUqHdra+IL3LA
X-Received: by 2002:a17:907:7215:b0:c25:5a7:87f with SMTP id
 a640c23a62f3a-c29b804baffmr6802966b.0.1789338621865; 
 Sun, 13 Sep 2026 15:30:21 -0700 (PDT)
Received: from beelink.. ([186.247.78.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:30:21 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 1/4] drm/qxl: validate relocation dst_offset against
 destination BO
Date: Sun, 13 Sep 2026 19:29:57 -0300
Message-ID: <20260913223000.695299-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
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
    that dst_offset points past the release_info header and that the
    final byte (offset + write width) stays within the command data area.

  - For every relocation, require that the final byte offset plus the
    write width does not exceed the destination BO size.  Cast to u64
    before the addition so the check cannot be bypassed by a 32-bit
    integer overflow on ILP32 platforms.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026ce..e727a35c9 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -204,6 +204,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
+		size_t write_size;
 
 		if (copy_from_user(&reloc, u + i, sizeof(reloc))) {
 			ret = -EFAULT;
@@ -220,6 +221,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		}
 		reloc_info[i].type = reloc.reloc_type;
 
+		write_size = reloc.reloc_type == QXL_RELOC_TYPE_BO ?
+			     sizeof(uint64_t) : sizeof(uint32_t);
+
 		if (reloc.dst_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.dst_handle, release,
 						 &reloc_info[i].dst_bo);
@@ -227,10 +231,22 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 				goto out_free_bos;
 			reloc_info[i].dst_offset = reloc.dst_offset;
 		} else {
+			if (reloc.dst_offset < sizeof(union qxl_release_info) ||
+			    reloc.dst_offset + write_size >
+			    sizeof(union qxl_release_info) + cmd->command_size) {
+				ret = -EINVAL;
+				goto out_free_bos;
+			}
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		if ((u64)reloc_info[i].dst_offset + write_size >
+		    reloc_info[i].dst_bo->tbo.base.size) {
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
-- 
2.43.0

