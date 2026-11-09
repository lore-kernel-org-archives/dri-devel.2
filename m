Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4954606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e01iS8E/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081B110F044;
	Mon,  9 Nov 2026 06:33:19 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5521F10F043
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:11 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b305e10ac7so3923067b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205990; x=1794810790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G2Zb8KZeLEINCDUI3qHPSdhsinIOg05KfXMPggEOmCo=;
 b=e01iS8E/LnLKTQh6UzK6kUra83l9rD+Cpu3VzvTHBoOyHIBHXJDgF6si/gnix3Pe7O
 I3fNMMasHnFnTiUFW5V+zjfZKxZjPJc/jCrUaH2pLEJyIRTMgpgY8pPC+ppnsynJBDmg
 MC+H5DPq4bwWA3sIcUGXgn/zFDVCAIqrIspFRkCWS74/f3UMyEW3u2/Lmdxx+l+qrKss
 oMye0FuCmaEZWZ8o+UrG5jspUeZ38tumKVPpd0h7Lin3zrJeUfhD7QcBh6bSw93glZEL
 /iPC7OG5grl495Bqzz4jfb2GVj56tpb9oGzApQnhkQn2SOpCwbVbrs2KoXoBp56yvCwA
 mhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205990; x=1794810790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G2Zb8KZeLEINCDUI3qHPSdhsinIOg05KfXMPggEOmCo=;
 b=MTzuAia6UEx2yo/BJBZ8oHQZIqzvuqN1d58EsBshI7YbTxLL1ETCK5KQIRpsexO11n
 8AtRpGmQyvRSysiFuim3PqyEzdX+v50dsPSfDC5S8bb+lJPaX1FMJ9DL2p24ulH3jKtr
 5etWjWWl0AZZUh/CpzjwfQoQ0mOhXjOfF+duoZXU7ikCMqPUR7tPfWzhQVjCmoXAClpg
 LOHAQKWPP7Xsk3H93TSoE0SAAcCh9I3JP+PdOAXn2RlAGpzevT8y302MHKNUz9YbqfGv
 0HY2v1E8kUgOflNCcXc/vGSEbBbX3dNXcxh7LN1oI5xl6Yr54wRZids7j2D3iltnVIVO
 Lgbw==
X-Gm-Message-State: APuU4Z8t4NXm2yzD8WNNDHNS6SpojJ9UDdk7gspJlIrOcT5IidkcOPBM
 RnPAn203WYX9yrtrZjQBBk2jXYKowO88WtcHErfrdGCittPfPIApuuvIUFMHPg==
X-Gm-Gg: AYBFou2klYeCU6Q0b6A2eMbTRFPV6gGOcJIMsOgk0mYS+TgGZZjPbbwfNd+JgTeAKRf
 SrUIPV5EGrqUkQ/1aWchQXbH3wkp+Z6fYu0GyYTlctYlG3Zdjl2f+Or9/p3HhQSxc/s5UpHaHKj
 z8N9FRz+MYcsX1VswcOQuYhWZ1U0e7HygF3e/tLOkHmZjfv5j06pNia4d4Wvo2TifOkWw2hXwcB
 CbEO3STAMft84bWyJmPx8ZNbtibe0ZJqX/XlkJaYqjSag+K1WJgUMPeBiQsn9P4HxA7MH1CmhKD
 jqfKGD0yBh5PH45bkU3NqWINMp5wdlvHQIwo4irzgzub7cQpnA5RWQeO8sw49YuzSkDGuCnEqMH
 SlpTrUCr+MDfWDNtOUoSR4d7+88QSwQIemktKqB+Dr8xqExVr0377fWZ0sKOwr15r6eFGT/S28E
 hZvUIRZZXTluoO3sjKZhWyX/+PIrHai7TnU1M7UIwVzQvu6ZKfWhNVmUFFj6ExzvVtQGrNuZllI
 xIcnZHO61ibirwax64ep7vkV4t8bQOEi12YavNukL/IQ1gzkyxrc6CZvQrl/w++hnfp6QQijQ+w
 6E7eiAWmOgUi5gYI/qgud6HnhPox8mcVEtS1HcEtVZ9B8KBJzOxxOkylwbWYJZhVW4A=
X-Received: by 2002:a05:690c:8d03:b0:8b3:5496:2c8 with SMTP id
 00721157ae682-8b36cb2e4c9mr17086317b3.19.1794205990228; 
 Sun, 08 Nov 2026 22:33:10 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:09 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 1/6] drm/gma500: use the common dumb-buffer size helper
Date: Mon,  9 Nov 2026 03:32:58 -0300
Message-ID: <20261109063303.32658-2-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
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
