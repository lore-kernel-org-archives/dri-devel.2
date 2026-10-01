Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3E7CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7E310F765;
	Thu,  1 Oct 2026 19:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOxi6p28";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7616D10F765
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:58:54 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so4793055e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884733; x=1791489533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NZQM6qPjUipP3twsEWuLikKTTxPNmXURRnws6p/YBzA=;
 b=bOxi6p28kiNEwH7HRVwsRVnuVhmZCEMsv5ZSf8Y40Psjz2AnM7x2DUJeFq09m0NcSe
 kcrVDQOHyniiqD0Yctr01ZGfNhBZV9igqMftdCvhnJVFpfHft2Y9ZiMtAkDVrfarIVbN
 ihGyUk4XQFDA6nH+f9/vz5d6+hewnvZOpvNt3Oo0e2m2fBu17kMQpOKA/wPsJDooKlJs
 8Ho9yxcBaLQVIe/OkXa3lEgWzdlnAJCZih1b02Z1kUztExoIe4Mx9FQgkhkW5nMtL6xS
 45ZW6NMRHb/0AGjokAyso0BUmP6Qj297RY+XTTggbiXtnkoozVVe3i+/jlP9/Ysbi+qX
 /2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884733; x=1791489533;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZQM6qPjUipP3twsEWuLikKTTxPNmXURRnws6p/YBzA=;
 b=P/n6G/Unngkfcflcr9M9M6iDY/3gGljLazaW5e8X8ZZWAnOMrbUKnZZa6fPDnKz0ms
 xvx0USmS7On/rVvOZKPmytqaTFlu9OO+sL+ElZWQZm3kFIocIT1+YH0B0HeAPTTo2HbL
 4Um7NWWWn1V80NsOJrwEskMyk4h+KTc3Nw+/ndcfLR8KxwZ8fpXAjExMDTO//XcJ/gmL
 KNPD9GBDvLLiSiq30TI20P6CWRiWf1iSY947rR0Le1fblAwA1w3NAch7BsbcVuu1gc0F
 EJqmVX4Spgigs9vy4h6X0+bGcN5gSy2ytYlW47P/6YEsIwtVv0e9TWfg9XGMcsXAa0va
 bEyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9zdjRdymjuG43z5f7VscQyWfefU7l1AlpjLlx++NmPkU+M4ddc8Khn0LSkKs8MyEJX8pWT1TH8uU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lwpLDFX9S3mp3YN3nLrzkgp7tR1yYoq0wPs4ELwgqu2rbTsRrL
 6mzXdYH9Li3TgsIsZU+qmm3xZpNI36ZZwHIfSvdSDu02dg2hfcZuCfOl
X-Gm-Gg: AYBFou37fNqVU2GQtdTBSCpYa90dfVrLt8oGCWivhUwRFhugoEzkYa0n26bdUt3CXdd
 JpS1hHw36v33SWD38WicpeRQZ6hmGjT4ORLNo7GDHLqgpvJxktUrbKR7V1KoP+DF6nrggmSLrWr
 TqsnrE5MV3iZ2Xt+O7/XlOYe78uxCDQY+OXN29h/FyvPDacgQFmAs/myHCm5PrJCuvbXTM3hXho
 g66XDEwIBBtT1k4GNgKQq//6ZGxFbKKL9hhbHPEhqS1YHOqCrYa+HTchTxFkJ+HG/zehX2zWAJn
 Sp8aEdBJQ/NKXji2Kj/T/x/ESzBnN8YvUJBqTDk5kY01Jtcsd9Rk/jaVbIpQ+L0p+xEyc+caZYa
 KNIMNQfzQdFJeFQVmHJ8CDCu+FSDnMrTDHSyO7hg5gA0nVC/YEQDOeAWHWg+UWfpSj8LdynYAOy
 arZY6rmli2ckKkSWWR/VW1b30GNT1L24K8Re/8yq+rnJ9CGmKuIiT3wa9iuQdoRsVlj5Nla4amU
 sp0cyoXP+ONs45p9FBnTnbdsA==
X-Received: by 2002:a05:600c:3490:b0:4a0:1b14:e845 with SMTP id
 5b1f17b1804b1-4a0274d1600mr11350325e9.2.1790884732686; 
 Thu, 01 Oct 2026 12:58:52 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:58:52 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 01/13] drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT
 with tabs
Date: Thu,  1 Oct 2026 21:58:35 +0200
Message-Id: <20261001195847.141192-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
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

The body of DRM_CLIENT_DEFAULT is indented with spaces, unlike every
other entry in the file. Use tabs, so that the next client added to the
list does not have to pick one or the other.

No functional change.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 6096c623d9d5..8d8bc37ec9f2 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -114,10 +114,10 @@ config DRM_CLIENT_DEFAULT_LOG
 endchoice
 
 config DRM_CLIENT_DEFAULT
-       string
-       depends on DRM_CLIENT
-       default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
-       default "log" if DRM_CLIENT_DEFAULT_LOG
-       default ""
+	string
+	depends on DRM_CLIENT
+	default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
+	default "log" if DRM_CLIENT_DEFAULT_LOG
+	default ""
 
 endmenu
-- 
2.39.5

