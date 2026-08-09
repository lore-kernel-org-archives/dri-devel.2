Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2F5C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A839610E680;
	Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oFs35r+F";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E67B10E07C
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 22:48:15 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so149992266b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786315694; x=1786920494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LP4UJ6rcNxj5vtQd0NWw+zniHfA0ViW+8Yb9WndmdNQ=;
 b=oFs35r+F2mclFcR9pXK1yyYfEhrfpnd/NeDus4TGwdE7PPEWrXdl/eA5POE+h/Clbm
 t7R8LVaI2+59PvkjSb6hNdW9pwv/0ADgvZVXAdZXm3Bzo5nUM1KmGf3w8WgTki/h/VmA
 JbhzFvkHT8cEyOKUEny64esK11M6ctOqzV346MlRqnsWGp9dPz9VPRyn/NbrHmh37nHy
 8iBKpBplPuy0okCfIbHladZ3MBcSiecl+m+qJO3mDaClrVJBcBWTJY3oi6qRqk8S77O0
 RDuJcoIUjAFtCeT4njdYPnTE0QnSNTgAQ9BAgZuG5LL45bqB0F86OJUef41EdIYLsids
 i28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315694; x=1786920494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LP4UJ6rcNxj5vtQd0NWw+zniHfA0ViW+8Yb9WndmdNQ=;
 b=rOtOfb80HWSZijAoepI9TsljM/uB3dQtTWU7FEu3IzUoS2BbCPvzCYZ5YAAC1cEmlT
 TFq2WFTuYOdzB7g81lRcOLSYj4z78IrmbcS9S39rJCi1tEkJgTQ3ie9TWKH6Gqc35zwZ
 SJevyIthExniOeqZYcJ5aiCk8mZZFquCw9/YRRhIkA24tQXI4N8sfrnPPn32ClGxzsxv
 Q26BzFUPjvIK9rbdkkyTrX4yPxGrMcCf7WKPt9EXhMNkJx1BiMOPT+PkeipvAsO8gEa9
 pemhma3+MQo4GnYEixpNwy6uvqUos5hsM8O7IsudxOP0GM+z+fgmNC39gcP+iZVx7I3A
 mTIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCRvZtVdPIwJXn7neewghNCrm668otorIKcjnHKkkmpmD+/oKgWMih0TLQd3iGxUR1hI+JIsvHXa8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxokyBzEdIqyD7CSIpbv8tV8b6qgO89TE9H1cm4gjQTeWgGb6H6
 S/WTb71JxzttPPbZSKoCUVtr8crFDFXtxua5kZQkEMhvJnOgAqnSpjew
X-Gm-Gg: AR+sD10HFmunZAusadJe/CWY6xAaOEAeNc5TbxYkM7A+Nc3RJOc0387NnUI0r31ADgX
 pc1h0Zlfulmv0ZGoguJyUwdX0ykFvuDWp13Nq6QtEtQacrFm851sLcfnzkVRJNum+SPsOjVY0r1
 Z5NahkoalDJd0wGqkHhlwrxXmW06LbKxCSsZLr+h0upDQZzZ8cZVb/UVM21ywKN9pzQ3/tV4qFA
 v11yTP2Pre2fYyONOZwhvcMqPCuU/BF5YrSvIC4qlf3gYbELlymxc1SkNsgf6fR1hbNeTREfHFf
 PWTdiN06hhLgLhceM7pDrMJoYMtHNmbOhz8YI2XtVBmg2pyB5+GeDlEJqNigvE8zgJeMyf5c8Y5
 ukPg69oFz4apVewoMItj9D5M2t2JqxwjgQJNnJPWa0alXhamxRzgF6UQR4rykxbR227M8EQD1uX
 RR0eprmanJhRU9JSnWONYwV6mgomwREOEoq2KRVzJAs101L61DXJrZLPE=
X-Received: by 2002:a17:907:1c01:b0:c12:b227:614b with SMTP id
 a640c23a62f3a-c2087558b24mr676705766b.27.1786315693477; 
 Sun, 09 Aug 2026 15:48:13 -0700 (PDT)
Received: from beelink.. ([213.152.188.86]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080cc2bddsm297087866b.42.2026.08.09.15.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:48:12 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] drm/vmwgfx: return an error when a shared GB surface has
 no backup buffer
Date: Sun,  9 Aug 2026 19:48:00 -0300
Message-ID: <20260809224800.771632-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:38:24 +0000
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

vmw_gb_surface_reference_internal() rejects a surface that has no backup
buffer by logging an error and jumping to out_bad_resource, but it never
sets ret on that path. ret is still 0 from the earlier successful
vmw_surface_handle_reference(), so the ioctl returns success while
leaving the reply structure uninitialised. drm_ioctl() then copies the
72-byte reply back to user space; on a CONFIG_INIT_STACK_NONE build that
is an information leak of stale stack contents, and on every build user
space is handed a "successful" reply that was never produced.
DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so an unprivileged local
user can reach it.

Set ret to -EINVAL and, on the error paths, drop the reference that
vmw_surface_handle_reference() took; once the ioctl fails user space no
longer releases it via DRM_VMW_UNREF_SURFACE. The unref is guarded by
ret so the shared success fall-through keeps the reference the caller
still owns, and it also plugs the same leak on the drm_gem_handle_create()
failure path.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Suggested-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2:
 - Shortened the commit message (Zack Rusin).
 - Also drop the reference taken by vmw_surface_handle_reference() on the
   error paths; with the ioctl now returning an error, user space no
   longer releases it via DRM_VMW_UNREF_SURFACE (Zack Rusin). This also
   plugs the same pre-existing leak on the drm_gem_handle_create() path.

v1: https://lore.kernel.org/all/20260808231002.67559-1-qwe.aldo@gmail.com/

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e..164886a3e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	srf = &user_srf->srf;
 	if (!srf->res.guest_memory_bo) {
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
+		ret = -EINVAL;
 		goto out_bad_resource;
 	}
 	metadata = &srf->metadata;
@@ -1758,6 +1759,9 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->creq.must_be_zero = 0;
 
 out_bad_resource:
+	if (ret)
+		ttm_ref_object_base_unref(vmw_fpriv(file_priv)->tfile,
+					  base->handle);
 	ttm_base_object_unref(&base);
 
 	return ret;
-- 
2.43.0

