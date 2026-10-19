Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E24ElX5Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E4710F2EC;
	Tue, 20 Oct 2026 07:36:28 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE2F10E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:44:00 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-3535a54c09bso1862530eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403039; x=1793007839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
 b=E24ElX5Z0rdGfVD+WHJWMkI9OyDipMOTrrtPfY2LQ7JxDRKc3kjQ1Iln6zMw/z02RK
 sjdCwumuq9InuvYltP1Qbla51nLPdo8Mm/clGmD8fYtdncKARKy81nqIl2RmbvlK3pNN
 39bXGEJMS+RGiExMgk9v66VboCMF89VTbN2T1BgYryfQCmbHnEeAZUysvNpJHi67f9cV
 DZX/Czo0ZTmwV8ZV245JIWTQLtR2UHHCTZ9tcvGy9DiScMX4UU1ndEP0PCPhpO/HPWQ7
 GvIq9rNXSWwGWEShzG/ulwVHdSy8pC27hBJEK/f2Cpn3vtQP9R1hwftWRFGWJ2fQG74x
 Qk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403039; x=1793007839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
 b=dBMaAwGx46/GbUBIemtY5NoysdWNV04FWdX4AH3eqPVbyY9n4e+tQi8JAroI3cyby5
 wCgwE6Uwa4k2+XhONsjMBAFeWegJ9m1nafAKcrJAIhqw6xSggV1ZJjdBUlliqrw61kVT
 3p7qjmUFzu0pJMpaqGz+4+Yg1YRUPeXuUHh2s0sYOaWlsBs9FAFBnJl6+bzEjh5vBi6Q
 YRdOmmcdPZ5E2pt5N1yo+l3Rdp0Brw6xhrDpnIWmG+K2aLuQGlBRnxRfdq4ESb9eT6e6
 TtUe+XNz9Ob/R1nZ8PK8XLkv8oQlFYc4fB4K7QHso09kiEMGka/Tt/WZG24agfDLMAYj
 j6/w==
X-Gm-Message-State: AFq9FYKGcP07mexc3APlAkebVLF1VhgW/hERB3HQ68N7uvGyQr4xIeEK
 m7UnT1Q8jLZ9fQoXjF+d7YDcyNM7COsiutINbZoMiiVDP+PUL0mtj1VP
X-Gm-Gg: AYBFou2sPDO+TuodHQxQByEGt2bNq+qQv08gIBmMm7xg/5hyVURmTgDPFkFAk1o30eT
 of59oaKOtz717hb60MvWMeMPcSvM69voNGO1KrGKSW1O0tJYlTrXbzBHXFLGVf+frEgBZdNh/A1
 3XE03yLwZt192zqHoXlDO1GW9PV1m7qCIiOi+mEkLNC0Qn6NeexAUf/DA22VJzef5UTgiC7ggPF
 XyKKk47FskkfNMiA+HcCxMJ13lf/p6kiWPKkBsqj7Rk7Xfk4LHDuL+q+cA2k358+9/9cbwIxitV
 RfEK9ATNegexgHJpvJwXifK5B4Iadiw4pUV3pxBspZeffiiUnzTVoDeNjendyKuzYGzqD0GMbHm
 0QLBNpEm4095Q0Tg3gFL1u8HHnF0O6dDkXbwKxDob3DTe9hUmuT8xNbxGXJGVTwVe1rlKZ+NnQY
 NfvBMesmKcp6kgvAGQZ+IqJhgZf4vJHDOorXmtcXLKv7pWxySGfM2o7oPDAMU/Hv5l0XHgv7ECO
 pDvuBv236gMr21p44Umsbdrv4p/GUKN9XQ=
X-Received: by 2002:a05:7301:6404:b0:360:f13a:ff0e with SMTP id
 5a478bee46e88-361a1b539f1mr10748987eec.23.1792403039178; 
 Mon, 19 Oct 2026 02:43:59 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:43:58 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v5 3/3] fbcon: Retry rotated font allocation after failure
Date: Mon, 19 Oct 2026 17:43:31 +0800
Message-ID: <20261019094331.1128871-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81bae..7afd63dcee7b 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.56.0

