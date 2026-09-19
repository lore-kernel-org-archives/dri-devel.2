Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B58C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEC210E3C0;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="etD6qjDs";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585CF10E589
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:16 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso1455641a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857316; x=1790462116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IxqUXVNAFu/lNiJ42A0NWtfZcrliflvc5eUvqHrWqjg=;
 b=etD6qjDs4FcD37FcV1ECfsWiF+7NRx8fFyfi5N3L/fHUh1p4+uUXtoO/ZascrlgpGe
 61NVIcP5oV0lttIPb3nXj31JqEkexKFxwnYKwcjcS2X+BDAjQIb+GcwETPHwyXEU5WXE
 /nRqjT0utYQeoqciu730OlDKo+rwXmRzErBUh9j0ZpTccWPVywYbZJEdJtMXSWIAOZXa
 z6NM3qjJxMsGEsrHBEaJp8zgXQoyIhpzhZs3R7+ih5fNnvTYqKRfhGJzVUaygKzQ9x8v
 q6REhAB7QOUjo36IWxOZ5yzh0PZDzMR9vxWMa1/UnDzUYENYf6JAniE+5nWTg9tPXmjR
 yGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857316; x=1790462116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IxqUXVNAFu/lNiJ42A0NWtfZcrliflvc5eUvqHrWqjg=;
 b=fNUewEQOSMmgPsg3qfIJofIlV6zhFabOvbJDywWFnpYD/2aKRq4i0TS83dK8ESUHIg
 8ZKqZp14gkOk8WfSe/aTnbwfXz/r6qOvXvHYCMU5hBhHB8bxYlv5qYgRhJ2rdMPkKmGn
 Hfw6TNwn4+5SRtrc4nr41Zzhu9MoN3GgnkUDI4BfWwQisuqfZ4uz8yzOKG21/OTtJy30
 htjq0EMBk1k5faPulvvyT2YTwoKp1ldb0SuKcI/elsJbeDlduHZJ893gK1AFOz7hoAIs
 i0+BtAOf7rM40TRftouR65dDxiKDe7/6AJ3z9qzwBgMDsoIgJ/IEx4w3Laj8TnyM+X3S
 XM7Q==
X-Gm-Message-State: AFuF++l5Vn5UTfq16i8w1Jlp9CEdhWojUDojEpIQBx+2K6s3WZHfB9mQ
 x9EPPnRDUb38mn0yiZonpXjkLiJBj3Ds54P5azpFBUkIKX4t6NJR1qSg
X-Gm-Gg: AYBFou35UZtFRlJDQ3yW11KDbqHM9ejAZtmi49C8mpcV7xqH/4ovdieq9ks84lTySaY
 Bfoo6XJ1935w9ZGbROo3l2JawP18N5yrfgRojPxjkPh1z92cvE8+EDhRo3ZmsGg9D3lx6ix6Hdf
 y6qamNWUfiXFbaG+SKQgQXyrR0DLb6d6560E2u3fdPq1z7x2FvRbPOkYhD3Ib2tzCHcz30lbN7E
 xz5DQEY4LLC/qe5OAwvw/kCCdx1PfdQjXbfeACMnHpZCqo3npjQ+tsQB2jgMLvxNR57QM5WU4qI
 skdDFX4KRbLLC0lP226+3MewOnqWAgN907XAgzT/aLtUVU0gpvv6fiwU0n68402USF5Si9RCpC2
 tddtgm43Mss1a7OTnbcYJkCxEbfhyXMZoT18CaSw5MRb6iZLkOieq5EN2jeqZXxRp0wGPKZcRMr
 l4yodF+kc3tGPD1rh9ekH0EbGJIC9cIyrD1DBQKhOgT0UYA23qgdAKCPbJOzMJs+quy/5wCXThj
 XB5/7JRJvvkM+YNT553o4RC4nCAjVbczdl8oBo/29Operpvjfv8tzeec9hV7j7aqtvGX1BmV7SF
 hXuSMDi8dQ==
X-Received: by 2002:a17:90b:3909:b0:39e:3558:f925 with SMTP id
 98e67ed59e1d1-39e54d86a97mr10901965a91.24.1789857315829; 
 Sat, 19 Sep 2026 15:35:15 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37c64csm6092871a91.10.2026.09.19.15.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:15 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: tzimmermann@suse.de, jfalempe@redhat.com, simona@ffwll.ch,
 airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mgag200: prevent PLL divide-by-zero and validate
 framebuffer pitch/size
Date: Sat, 19 Sep 2026 22:35:14 +0000
Message-ID: <20260919223514.3889611-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

In drivers/gpu/drm/mgag200/ (mgag200_mode.c, mgag200_g200se.c), validate
clock/PLL parameters and verify framebuffer pitch * height fits in VRAM.

Fixes: 414c45310625 ("mgag200: initial g200se driver (v2)")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index 349ec36f6d49..d24af3bb5029 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -257,17 +257,17 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	if (delta > permitteddelta || !m) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	fvv = pllreffreq * n / m;
 	fvv = (fvv - 800000) / 50000;
 	if (fvv > 15)
 		fvv = 15;
 	s = fvv << 1;
 
-	if (delta > permitteddelta) {
-		pr_warn("PLL delta too large\n");
-		return -EINVAL;
-	}
-
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 7e07fc3f1a60..a881d85e6f39 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -468,6 +468,7 @@ int mgag200_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
 	struct drm_framebuffer *new_fb = new_plane_state->fb;
 	struct drm_framebuffer *fb = NULL;
+	struct mga_device *mdev = to_mga_device(plane->dev);
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
 	struct mgag200_crtc_state *new_mgag200_crtc_state;
@@ -485,6 +486,9 @@ int mgag200_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	else if (!new_plane_state->visible)
 		return 0;
 
+	if ((u64)new_fb->pitches[0] * new_fb->height > mdev->vram_available)
+		return -EINVAL;
+
 	if (plane->state)
 		fb = plane->state->fb;
 
