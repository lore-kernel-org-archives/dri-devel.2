Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BB606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQnQtPGb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F32CF10E66A;
	Mon,  9 Nov 2026 05:55:06 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377BF10E5B4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:54:59 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-67bef25eb92so649775d50.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203698; x=1794808498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=awuA15J4VhRGDI5nx7UhP1UoV64JLiCj0xKneoV5aus=;
 b=nQnQtPGbFVjNYR764VdRFASULeH+zHTug/fvf962MPNf8VW2U2m4osCvKweqBOUnKb
 39YmfKJNoWoFdhBkAo+1GL3OTRhtm6dNB6LtAt/OdGDqZi3vUOCIOGfU7LUbQTibxHdH
 ffPfQrDFhnR5GJxWq3MbHRbPIDBST4mu1ch+1Ft8ln3VjOhUjJwL6N2FoMHLy419EhGi
 QGchv57hC5ATwrnlzeNNXNDIEEy2vxQ5VyS5MmHWByjy80E3nGHbnwsydPUBbZsF3kd6
 hYYjssqDbZF2oP4buhhCFKeTEbvkke7ZMoToZYcgRnTKKpAeHj3omn6dtLYWj/VtuW1r
 +Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203698; x=1794808498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=awuA15J4VhRGDI5nx7UhP1UoV64JLiCj0xKneoV5aus=;
 b=10BHfTbbRSDlEA8KQfLMVxNC4T/cHf0I0CuFEZGRh8GZXn0tKdRhhkN0yZZaS1DV+o
 77qT+F/zFS8gWU1GsTmArkkoGnYU8vwR0uAp+afoFqY/JynHPKbSChSZiA1PZCyfh/iH
 PxxVwly1pdiKoPozfmL4J5ru+d5J/lPG33h5yQPr1WpRis1ZVCGwBm+LnFf4av2YDWUF
 q8dskAhoVXQrSIMUAxvsll+3LHIFMySf3v3ENN8qsx0ZlEjVwZvvrsxsTLTTGI29C/WF
 i30D4Dn3HfG2neyzKjRdvUso2C0FXT0H6e2++m/UZOs2NzbqSxhUGwpug+ETkGZxs1p3
 av/w==
X-Gm-Message-State: APuU4Z9b7KPSuFh2VTinhlcu2nNS2oZ4vLekq8XLIhzuwOvAXD9Wm8rL
 m957QOY6JLM4APNESRM8b7KsHWE9aG/kVZ3RoxIIBXZP0kxRkbF34pJN/lm/+0K7
X-Gm-Gg: AYBFou35+Fu0VepMxM2PQNraDgc1rOuqrh/0+twSSvx6qbHK0CD+0BgU84BOgO1r4e6
 OFw/1ygZecCpZ6FvWxqbxmI+MAw92SA2FehEPBdDp+N12vqrbYA65ookbmS6uvkJImgxxhSXB6D
 C41MkH/W+KdqXh7h+GUSx410+l05DoMLe0uLMW+aqrkskXQIhpyPBCxB5oS+SLSMPqob4gQVkEw
 5eWlEo9D3Kr5iNqeMTamJyYEB65FnZlK7XQ9k8oDd0hL2T+eG0ear/l61YYVf7RqavGxABljoxO
 KhDiJRTsskMuxurtv3gQnb+ejom7d8k3LZEgEUYMTu9sfidkpV6+HKcd429kdOQq5HQgNHFEMNX
 +au/x9Jdbfea4eCXBaE6ujEV783P8oIbRF7vtu6RtZtvHaJOOAQebfK8J5IBCM4nojpmJjD4zUj
 TBeawpq6WeoHAq5TFqsq5bur5wIFt2G08LHuKIhR2Z5ZO+A0g66aX9hyzSqN8xZ3pyLAS+6dmdK
 qV7KIxhsjLkwculm03xXiHWrQKRtzMuE5Yh1NbIRStsMtVcizBLt3ZwPKhT94aDzvZSr1c7CZYs
 ZvNGuP/zj4rzko+Ke65EOkY/t/ZxoFflyhhamvE/I/b2sFa/Xl6FtccjRvRZUiVc5Xw=
X-Received: by 2002:a05:690e:11c3:b0:67a:553d:c06f with SMTP id
 956f58d0204a3-67c29d79897mr3771064d50.44.1794203698166; 
 Sun, 08 Nov 2026 21:54:58 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:54:57 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com,
 Gabriel Gama <operatingsystemsdepression@gmail.com>
Subject: [RFC PATCH 1/6] drm/gma500: use the common dumb-buffer size helper
Date: Mon,  9 Nov 2026 02:54:45 -0300
Message-ID: <20261109055451.17458-2-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use drm_mode_size_dumb() instead of unchecked size_t arithmetic when
calculating dumb-buffer pitch and size. Preserve 64-byte pitch alignment
and page-aligned allocations through the common DRM helper.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

---
 drivers/gpu/drm/gma500/gem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 2708e8c68..7250bf660 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>
 
 #include <drm/drm.h>
+#include <drm/drm_dumb_buffers.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vma_manager.h>
 
@@ -200,21 +201,16 @@ psb_gem_create(struct drm_device *dev, u64 size, const char *name, bool stolen,
 int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			struct drm_mode_create_dumb *args)
 {
-	size_t pitch, size;
 	struct psb_gem_object *pobj;
 	struct drm_gem_object *obj;
 	u32 handle;
 	int ret;
 
-	pitch = args->width * DIV_ROUND_UP(args->bpp, 8);
-	pitch = ALIGN(pitch, 64);
-
-	size = pitch * args->height;
-	size = roundup(size, PAGE_SIZE);
-	if (!size)
-		return -EINVAL;
+	ret = drm_mode_size_dumb(dev, args, 64, 0);
+	if (ret)
+		return ret;
 
-	pobj = psb_gem_create(dev, size, "gem", false, PAGE_SIZE);
+	pobj = psb_gem_create(dev, args->size, "gem", false, PAGE_SIZE);
 	if (IS_ERR(pobj))
 		return PTR_ERR(pobj);
 	obj = &pobj->base;
@@ -225,8 +221,6 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 
 	drm_gem_object_put(obj);
 
-	args->pitch = pitch;
-	args->size = size;
 	args->handle = handle;
 
 	return 0;
