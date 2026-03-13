Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AAD105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82EF10EC21;
	Fri, 13 Mar 2026 13:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdycYuDm";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F41910EC12
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:19 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-466f00535cfso1535064b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408259; x=1774013059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vB+cc01KMDy+1bX+9nVaruepBX97i9TSrBfN/R0HMBE=;
 b=MdycYuDmncXDn72uVtohze40ooYOKurGUI/qdNe/ZB4SqtcJ6UOZ1evgz6TjfxEn7M
 TzEcPj0dcDuAtgIhUp2CPCRdZyUkwzbsKJ+gz6WNobXgGxSYGb3ap3CBx5TiDxFIrh04
 ZwUruwihvmdFrf5pAjRYL7T7GD4/I7J7Zrz318HclYkOFWgLJYBED5dSqBgWMfGocq26
 yDg5XU++iXE+KqoIy50za8+xt53xn+CaJM9bjXY+/urLvx6KKq+x3YWAJZfLhsRhBzRU
 mcIbHZDu9vdVPAB0ZFbaRwrx6BPvAO4jZIw3lsKo4kfmunlG6BOHx+D8vz0GwDsu2wCJ
 uVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408259; x=1774013059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vB+cc01KMDy+1bX+9nVaruepBX97i9TSrBfN/R0HMBE=;
 b=TaP+fFrS109SboGb67RXRuzOlE/a1PoukJzA2obfbS2JS6Ou/7qQgB+XSbwmdgsaph
 kjGRcxyt2WQFn/86q8lartrRXSuDc1j2S86SgRM994+LBBzWYn4LbKhoZqfHoJWmIMcC
 JJwx98GYYZfE95Z6pbFiM8sCrKiSGebsKyJvw65v7ZdYVhQHpoUXGob/iZIxvp4S9Nqo
 yqOt+X2967UtYdYBXdKZvhkl1BreWF+n/Xhn0uMn5KdQ7IauNCsQMk78IYQNReNg/uEp
 jtoNs54/2V/zm2wfV27b8CDdWIq2+KC49LGtWaP6hgV1EFExtxanO7lLPxLybUI6y+ih
 AgaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVavhBNQ7O4+DNBWizLeo3cpO48YoJswfF9lNAB8MG/mWKx4K80pyqckLxiqfgglFAkWn3p5L6ygbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrH1V4VB4SFo/eQDDISNCG9Nfn4mINU3MypAZsBUHgnkzo2+EB
 YS19lmowseAXuk6yZ2Q7qY2tYtvq0q4dFiEtj1M8F8HSbcQII41whf+K
X-Gm-Gg: ATEYQzyY5yh/TyZyPtvqP7irSZPpxWTfOwOl4sR/5xt9gwFyPeI++8X1A/PlFCoyEsw
 E2cSyHdzMTKaP6oqnP/wXAsTvkR02iwfZNB01wdec3BlDTgQW70C3NGkItApRe6UzGQwbHF0ezm
 EDGXyQwWcjs4OGmmLAGiaoVQql/bSsCszUiInDFXmhVRpezFbxO/g66dS/pJEOKH4maO0+g8gzX
 FgHy9DD0/Qv3HCD2VBj82rbOuH2ybBvInIvw6hCM87/sxBuGrW4TKdqNKk8d+WuNnGRa0XOg4hy
 9+9Q9EPqLr+kQdcbxZiyvzxkM/A4PWCsm2UzPxWU+FPRGB20ZJ7pacNHuPaiaKU12LJxAbpBeZA
 +nSTr9HiFsa0nOoUrGScYcUiOcC4jIKc9Q0grSGnSsywZOUN9SHpRnpp0y8wI/eQNIJMRtmEHqN
 TbbrSftEXYmJjq0GPu/gqWlQ20rUUEj7p4UheF1JZeJF4h1rvU
X-Received: by 2002:a05:6808:158e:b0:45e:e07d:85af with SMTP id
 5614622812f47-467570a2be8mr1585147b6e.2.1773408258671; 
 Fri, 13 Mar 2026 06:24:18 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 38/65] drm-print: fix config-dependent unused variable
Date: Fri, 13 Mar 2026 07:20:03 -0600
Message-ID: <20260313132103.2529746-39-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, __drm_printfn_dbg() gets an
unused variable warning/error on 'category', even though the usage
follows immediately, in drm_debug_enabled(category).

For static-key optimized dyndbg, the macro doesn't actually check the
category var, since the static-key patches in the proper state.  The
compiler evidently sees this lack of reference and complains.

So this drops the local var and refs the field directly in the
macro-call, which avoids the warning/error.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 93dd714d4533..ceede094ff13 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -213,9 +213,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
-- 
2.53.0

