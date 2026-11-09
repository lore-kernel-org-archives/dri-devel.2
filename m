Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCF606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFzOqwWy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003A810F06A;
	Mon,  9 Nov 2026 06:33:30 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126E910F044
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:13 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8b30ff12f84so2732467b3.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205992; x=1794810792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEu0wdew+iMptxTTw5emRmK5vIojTERF04Lyu1HiyZM=;
 b=JFzOqwWyN7pjvuDo9tr8MZf3UDCMqGoofaoiamf3cBAVIovjgVGVjMtYnqJkvbi59Y
 uNPdqtGaGwXa6Ggf4vf8xjm2P4z1UpyAVVo1+8fYl/+BFJciDaCoFefw/wjqLrGJPmPJ
 ohBy6E9+l94xIisruZmA9bHAb2G4AHF6zaAMp+yCUJh/Pm2i3rfe1JTjOJF8L60a/tC7
 fTJiWdnBvJQBMg6zoL6GeHCtpV10LwNPK44e8gSW/AqDf7y5tVbciqDN/XNeOmuj5jSC
 /WJK3Dh0FdeA22avRnaiHhACzDd07FD65ntyPoSCDYWZXdYGVH7N8snlzJLKIJ4pb96g
 lBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205992; x=1794810792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jEu0wdew+iMptxTTw5emRmK5vIojTERF04Lyu1HiyZM=;
 b=eg5Se89X3SX1yqbDaNsNOKH7mV4Fb8A3mmcEDonb51eAhVRmh3g1Nn1X+C34/8x9js
 T1D1s4wcnUL3V4Y5QupJbcGtsWCnvism4Sag0x4HrT1LKsZO1tZqOt3YSBxI21U+nVUs
 gq3ZluD23H5KG7b3FDO46v3LEqXWuOrX4Uk2bub3SgxNpy3TgteNMGum8XzinPg05xPg
 DuXGTV0QDo9TsbfceSNcGSUqvNcm7bb+RG7vD81FVFIYv2qXaUHS4NgBk7I9BQOvLGBF
 7ETBDyVgb+81SVOY7tX6IGdfGlr0CkRIrTvJJyUZ874RoIYeeV1pmrkUBw2nTvC3p56u
 ziVg==
X-Gm-Message-State: APuU4Z/eQGIb39Af67ySqQkZO20NwvlNzFIWyZyfx9pnJjBMHvTj4BYT
 /x/wvEa97A7VGJPLVpHjMEm7YeN51oLAyAqcPdB8C3HOAf1/RuDl4cILjvUQFw==
X-Gm-Gg: AYBFou3Qv6LTMPdNOHqc54P4y3p1+cTqE9h0IAqQ7QY48tq732fVtidxmhAEwBH1cLQ
 d+/845yBNOPw1pcLgEDH6Cgey5usJDewm8YsIgmhWcBv8Imph5LO7R93EuYdZfPECI8kJ3ey2e/
 55baXLmCH9OipIjjchEXJIDErK++oa0sDdkr3qMi66GPhW+9OjORRTV00CiF66j8fKL6LqBHAlf
 8KKJdd4qelBunhke66B2yAjrT029K9F+a6InZt3/IL36UnLJ1rxvE+fmwuTUO+CApyxEmk2FHge
 JQddXk0OvlUuI0ymPxoPlqheYUqjP5wO4TsWZMivSuboyuldupJgTJFND7uC095XaoFjrD8kxJP
 43ROAhz4kcH65A05PwQxImwioVNn5KR4mE9JrJHTR/xdHY2C4erhwHvsnkxPEYKiWX6mXgymEB7
 KEz61D/PcDJel9aD2Rk7p5eV44peZmijZKQ/VA+rULcq0+ukiVwMfoil6rwnmrujfgz2D89tHLy
 W1NwsgERrHWuU0VISDKEG+Xj9dfkOgFZBf9TwWKk4erXWmbZA8AcliE06XO6X1Y3bGLldonnBWD
 71EHoTeD2rOnGShSkgONOCMq8667WNKkodBxfYTaYJ74ksEV2/08NRTdN0aZsrMZPeE=
X-Received: by 2002:a05:690c:a412:10b0:8b3:1f74:c59d with SMTP id
 00721157ae682-8b36cb38894mr15376667b3.48.1794205991889; 
 Sun, 08 Nov 2026 22:33:11 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:11 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 2/6] drm/gma500: do not underflow an unpinned GEM object
Date: Mon,  9 Nov 2026 03:32:59 -0300
Message-ID: <20261109063303.32658-3-operatingsystemsdepression@gmail.com>
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

Return after warning if psb_gem_unpin() is called without a pin.
Decrementing zero makes in_gart negative, so later pins incorrectly skip
backing-page and mapping setup. Release the reservation lock normally.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
 drivers/gpu/drm/gma500/gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 7250bf660..fa5d3f137 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -85,7 +85,8 @@ void psb_gem_unpin(struct psb_gem_object *pobj)
 	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
 		return;
 
-	WARN_ON(!pobj->in_gart);
+	if (WARN_ON(!pobj->in_gart))
+		goto out;
 
 	--pobj->in_gart;
 
