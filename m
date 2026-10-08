Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828DBCA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC91A10E8CC;
	Thu,  8 Oct 2026 14:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="iG1i1oM1";
	dkim-atps=neutral
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1622B10E8CC
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 14:15:14 +0000 (UTC)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-917997ab0d9so31721076d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 07:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791468913; x=1792073713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=23/7I1cLa5qUs6dYo8ImpupBoI9HvqWEXqoMLGAOQcU=;
 b=r2sY8MCtTGWThSUGO6/fY0DdCFFGcIImbr+yyvWLPKT9IY4jJGsE6coSdDN+KbRhn7
 FivfR/UPFvfFO7cfL5lmfeFwouxOktkVKlPQc4QkXvO0Bk+E2e5xD6JM+Yri5FnXMUuR
 sB95Agslmx3+qovb9zogO9Ci1mmGHOc1xjgLGezT5yRdRUxGs6TcQ9ewxBwUQ7KeXTUS
 3oy7b6e995pranXBMlgHXWbZ/i5UTRNdyYUzhzRYswBfdRgnni4NREk+KdVUTZltyR43
 IGNDwiFbxu/Smvd1+D+pTp6kc91lw5r/CO0JimNn5hCeVhATbfrEXzs9bM5vOgd0FM+Y
 /mgQ==
X-Gm-Message-State: AFuF++md4BEQUveo1GG1Lw+ghV+g9updHvEXVB41TJHPyhT4mWxfa+hZ
 6yXM4zj42TXz6D91wgjiwsEI/nSCnFWuUgRLzPPKBlkQupY51z91XeTu17kC2xsEhes8A//bX+/
 jNUPgpJx5sHjMi/04A3ZBvLPfDIEiVaDmBPMAptKjWncyasQVpEjzAqCaU2+HeTdY0fA/lCcgoi
 HjILvVKrQ0r+1DKnmruk3PZlqkimcUl0II9EgAydnEAkkAji8jiU0Cj4z7vVHTZpUadoNDPUFSH
 Um7eu3kA+lGO9SVDsG0
X-Gm-Gg: AYBFou00ATX8S7tHxoCgsvuOcpu7MP8hX2rHPp6E/XWQo5d4EpB1xADQWyFxyGRNfq7
 eGWWvrzR817sXfEC2kD4G851rdUJeuZODizUiOlAz5SjkhKupVUGb0aftwqM6vjLMlYBJQ/Fkke
 TIQ2mIo57LrlUYlDD2zHiyTScu6NBBSH5Fz3dkXDac6/Dj4QX7Ingh5SGPQq7vL+jDmvpuvG+MN
 Z5JZKGV3rR3k+AQcWLPkFKXt9KcinTG9WBQ2B/qzUGdfINJUPyIzcptNUUBnyNd6mwvJA0Ru147
 15Zu3qiYvSX87+tu3ps7AfYllQ0/AgyzvyFuftDujjRe/70iFNZBB+JsqO6Ri1Qv+0wQyXWLJOM
 SJQ4TBkSlMfxNL+dEGHPg0RpNkVy1ZE6YeJ2SJ+G2ennv/Q2MIrf5HjEZ/pdduz/JHtspGp6ZEJ
 aNplOE06PmjrG/zrIZ9IhPAyu3p9D2hpb6y3o=
X-Received: by 2002:a05:620a:4486:b0:939:feaa:949c with SMTP id
 af79cd13be357-93e9b754be9mr1031554785a.36.1791468912433; 
 Thu, 08 Oct 2026 07:15:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93e9912449asm172867085a.10.2026.10.08.07.15.12
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Oct 2026 07:15:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbacbb996so868636985a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791468912; x=1792073712;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=23/7I1cLa5qUs6dYo8ImpupBoI9HvqWEXqoMLGAOQcU=;
 b=iG1i1oM14Xb+DCzdJn/c7SkhNdRAquGOMHOCr9BCtJagPoZMqeEOPiQpWc67/A12hS
 2kXyufwBDS3DDJcWzzNkYPVlMVIgkrOYsNhLyIJUfRDeOvLltwYGeCCP6y1o1iBFzyoq
 Vd2KukVA9lv+oi4ef58hjKW7gNl5ET9SWYSAQ=
X-Received: by 2002:a05:620a:4096:b0:93c:c73c:91f9 with SMTP id
 af79cd13be357-93e9b73696fmr1124168085a.31.1791468911517; 
 Thu, 08 Oct 2026 07:15:11 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:93c:c73c:91f9 with SMTP id
 af79cd13be357-93e9b73696fmr1124158885a.31.1791468910775; 
 Thu, 08 Oct 2026 07:15:10 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e99160036sm493015985a.25.2026.10.08.07.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 07:15:08 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Make vmw_bo_driver function pointer table readonly
Date: Thu,  8 Oct 2026 09:15:01 -0500
Message-ID: <20261008141501.2182964-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Function pointer tables should always be readonly.

Fixes: 8af8a109b34f ("drm/ttm: device naming cleanup")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8abab84..9f95ab759dd9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -927,7 +927,7 @@ vmw_is_cursor_bypass3_enabled(const struct vmw_private *dev_priv)
 extern const size_t vmw_tt_size;
 extern struct ttm_placement vmw_vram_placement;
 extern struct ttm_placement vmw_sys_placement;
-extern struct ttm_device_funcs vmw_bo_driver;
+extern const struct ttm_device_funcs vmw_bo_driver;
 extern const struct vmw_sg_table *
 vmw_bo_sg_table(struct ttm_buffer_object *bo);
 int vmw_bo_create_and_populate(struct vmw_private *dev_priv,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index dfd08ee19041..659738e1ba6c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -545,7 +545,7 @@ static int vmw_move(struct ttm_buffer_object *bo,
 	return ret;
 }
 
-struct ttm_device_funcs vmw_bo_driver = {
+const struct ttm_device_funcs vmw_bo_driver = {
 	.ttm_tt_create = &vmw_ttm_tt_create,
 	.ttm_tt_populate = &vmw_ttm_populate,
 	.ttm_tt_unpopulate = &vmw_ttm_unpopulate,
-- 
2.56.0

