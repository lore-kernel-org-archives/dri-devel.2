Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D93CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A4D10E6A8;
	Wed,  7 Oct 2026 21:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GxTVdq//";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A78B10E6A8
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 21:21:16 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5df34e70a50so33113e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791408075; x=1792012875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LOpZSgzRV4NwYdKLmYPXK96b+o+B6wygQfoMMD57LmQ=;
 b=GxTVdq//eSsGp7aPYJeFsYOa7t4OQFOw7xY+mTwp5LKNox1+gIfWXSqW/Olh4dG9BZ
 UQWqpPIeSPNOtvoZMUhV6mPQ3Cle8Fq603YbLApwhEPy1JQPE//Wk3Yjk+9KU/e202i+
 o95XFUhzDu6/+dSCD07GbOtAV/fZn5xusgSOE5FoNqsDp5CfXdmchKYcTzKZxOOav8hA
 WZSEtG9WkJJ6UxQi5x6r4sBzmqHWmn8uRC5emlgB68qQNO2pLc/4b+tl3CSyMHyUkeW5
 tYNEg9VCdYegvRgGvNfStA7tgNlAVC0/u4CCgkr8lcbhGcLQ99qNgTq+4ZpHY+T4v9gh
 K4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791408075; x=1792012875;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LOpZSgzRV4NwYdKLmYPXK96b+o+B6wygQfoMMD57LmQ=;
 b=DU7D6n4ebKarAV8UZUpx5hM9ruz2rypFt9AAhWr0Wp982xuHfsH4ZP7hRa4Etuy+XA
 yREIKjU+OFoRLPzaQyH1dbjJuiWTq9Uj7MAZHcWqs3BTZzVsWaUXbeKAD7AygfQ4Gr9+
 SWme62P2U0CYz+oou4wMzsNh90lMzd7feZOKhmqXzUbZ1mVzpwRvxeGdUnCrBVsJZOH6
 +I35lSJvFCY9VACPG3Q/9fwnGfOPjBSh7SCLx8doPkf7D9U6ffa02FFxY2Q6h3XwrxCW
 NqdFHaWyQDYGaTTzJh3ZEDUqTvIOhEuLnIVu68eBVvD6/KtTEJVE5Hmr4DdgHgF9RDBa
 kVhg==
X-Gm-Message-State: AFq9FYLAwfzVm0K96XmJADF5u+lsq+dpmaVRZpxV/XvwZV3Vja89Q/6s
 khK94WUycfG72krz8dqf6zEvLxH5vQxWUk08779mi0ZZUQaeFWgBkmLn
X-Gm-Gg: AYBFou1aTjtvJOiIdH5iB0VW9YEQf8dgfjyE2mrZKQhNf/9zinkcrt339BQgXTKdWtG
 1pdccgYjVFej1Qd/kJtQWM90ETcDJvSBj5HtFlzy2Ip/RSOJ5h81hjLyonEMx+woj4jBj1ygIIf
 Tt558cYcoDax4Ykhzck7Z0P9Q9/Riq0gxXTQg2PtsaultJsFwwx9k/bKfZZIM3BIwYlTBji8pjG
 FUtwmHIZ1S57eHecmQyiCsfn+le+k3KPsDZZG8JcEZldmNQSMFzGoZmxMmxXoxPQipGEFhIYgkq
 Z4C9l09IFroIWaG6vBTGL9aU4oNaDBZHCey4576kKGGr66W53SPbLz2kxLQf3Nk0oPEu7enD6IT
 6gUMaS6KQYsiZiat0MbV61o7sYK3jS/RQOM4upoAU9RxLl8+z6IS2NmG9uXjOwGgRlcmlZGJXsq
 2GS4wkhpi5y+2xSha6Sy6qnvpMWfOdgQIkVW+yMegyXLGIQlR7HEl/Vv2gXmPpY2E=
X-Received: by 2002:a05:6122:6849:10b0:5cd:4fdc:4c30 with SMTP id
 71dfb90a1353d-5e82a137713mr88297e0c.8.1791408075168; 
 Wed, 07 Oct 2026 14:21:15 -0700 (PDT)
Received: from beelink.. ([187.13.30.250]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e6c4d62704sm3115891e0c.10.2026.10.07.14.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:21:14 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com,
 stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 1/2] drm/vmwgfx: return an error when a shared GB surface
 has no backup buffer
Date: Wed,  7 Oct 2026 18:20:48 -0300
Message-ID: <20261007212051.2574235-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007212051.2574235-1-qwe.aldo@gmail.com>
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
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

vmw_gb_surface_reference_internal() rejects a surface that has no backup
buffer by logging an error and jumping to out_bad_resource, but it never
sets ret on that path. ret is still 0 from the earlier successful
vmw_surface_handle_reference(), so the ioctl returns success while
leaving the reply structure unfilled — user space is handed a
"successful" reply that was never produced. DRM_VMW_GB_SURFACE_REF is
DRM_RENDER_ALLOW, so an unprivileged local user can reach it.

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
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..97966d849583 100644
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
+					 base->handle);
 	ttm_base_object_unref(&base);
 
 	return ret;
-- 
2.43.0

