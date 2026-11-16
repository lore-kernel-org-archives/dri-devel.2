Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99A606A31F
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjcgtciL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A7810E1EC;
	Sun, 15 Nov 2026 23:22:25 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B563010E0AC
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:22:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so16748825e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794784933; x=1795389733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uREsKIEDczdDVdj720bXK/T41S+3ar5PxkrrHsI/TEM=;
 b=NjcgtciLTpcMH9mmPUjcXK1B7zRGk2+Bk/JnDc3VI4LNwWuHfevMCF7f4LT4gkcVa2
 psltskPMjL29o0YM7NzjYyVmRx0WUMjqwg2zSnHWA3iYX87L7GBfpbjSaLjKlz53y1Ra
 nHReKDhMmtLKkj5J87lBtqfAMaOUzqPBZ7M0AKqqKrVaCf9WnvixLAuQLBxyWp4u2bP7
 J9pTt53r7AT+0Ra4Z9GYMuFfGxktmgXJ7ll4LktUc9Vg9TKRuu1R0tjUs1c1r/zlpRVE
 TrkuP1aRBZWcSS0+ZRtMByAOv9u2u8/NWvI9cab+qq2O/5vYhTkVN2L8iF0VmTYRtLeV
 XN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794784933; x=1795389733;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uREsKIEDczdDVdj720bXK/T41S+3ar5PxkrrHsI/TEM=;
 b=IkZdDjnMqetFU0f1qSbSgEEUc3x5AjiLKglVEJR/J6uXUI/SzwOmn6vwv+htElub7x
 Fvwen5bGd69VoypMt0ZlXz9Q471JwCPmHBfIxsDy+7M65rnTLi7xwvI0F8aDY/wW3CUl
 Axh+WK43ps6xWp6G+vwBr6Hq7J7dVaZFgye1luG/MFY67VSEvlb8PNUd9o4+oaxAG3L9
 LMf3bnG7U9NKsPpcpAEjD2HQXKIbrEMvkSYLcnBAG5zBxU5Hz6HUIB9WXdt4RJC5BhY9
 PFwWxagu5qfjcaClDxsiyWR9pHAzqenxO+iZ0boX5fFlCaUXpR5pAH9UqMx09djnoJLV
 M7zA==
X-Forwarded-Encrypted: i=1;
 AL+hErHXDQjjazH2lf1B8bbJ0soUdA/jPe0LGrSBilS/SixzDgZiEXx+sJYigGcK5nf+1c0m8TfpOSNBi3I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9k2HcWhBOY5D3ldE1BosBBZxhDCmt1qtChFIUsuUsx9k6Y/mZ4
 B76bKetql6qwJltiAL5KY9vFlM9dWNPrlqCO7f4OoMvUoT4MdAIiyyfW
X-Gm-Gg: AYBFou1srOKncC7CJkxQDrTDm5jIoGbSI1Yc+WabTZXXUCVZrBP+ViUvSMb+apPzBwQ
 Fj7bo/O2Y9PYuRIXulydrQbJqK9p3GHD+A0Mkk+uITth7d9ekffEfavEaQ+67e0UvZKi3rYO78q
 Q0vwsNccEyahnSvalo6U9J+KgzrncY3FYp5+IHKm9CPSg0CEQy+Rb3/TL/NjE1SaFYr4hhKaN+d
 mHObxLLB6TbHMgfnMtApe1Wx/RnGxEnGcXD9yhOh518aWK08F7e9EA4aMdquoYM7765S/LzzCPB
 jDhYhm5CjK1P6P0OKzf7LvETnXA7ZfMnpgnYfpQcfkr0d7qfLMvkZx1qLrXwYq+HeH1UX/d6SkK
 aV6zVXwihjYBRXY9jqiotRPc3ERSs8IaCZd4bX/sFRQ5z3QUdAxrBnPRn/OyICIBoF7HMmKUVb3
 ek4eTTBbY9jK1aA9I966UDwsrZ0W84GofaDMU5dWaDa9rTkb4cU+77Q0/zO2eDHWpj8bpYclVKq
 yprfi7vs3gxUyaMjTD+4iQ8oWcia25kGL/Xcnn6piv4FdnJNeTGOV5EjEbP7wnn6kbUIsoQGOy8
 PRHXcUOrAK9cUSmJyo1iOaGMvxK5VlNNvc5QyY61xzByNQPIMzKW9H0=
X-Received: by 2002:a05:600c:34d5:b0:4b7:6942:39bd with SMTP id
 5b1f17b1804b1-4bb55ab1610mr175771075e9.26.1794784932986; 
 Sun, 15 Nov 2026 15:22:12 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 15:22:12 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] drm: docs: remove bootsplash from TODO
Date: Mon, 16 Nov 2026 01:21:55 +0100
Message-Id: <20261116002156.1027726-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Valla <francesco@valla.it>

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e6d36f8da086..5e987e18bfcd 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -756,23 +756,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 
-- 
2.39.5

