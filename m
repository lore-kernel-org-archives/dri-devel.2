Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FA606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a7eXHqbJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D108810F575;
	Tue, 27 Oct 2026 13:53:59 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB42810F575
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:48 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2546150f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109227; x=1793714027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ggIeAF8ymqQPticOc6wmD/qoAjkwXyVLKkCNBrapmc=;
 b=a7eXHqbJHxV89RLAv2S/YaYF/CwOcD0n2PeTY+3RliGT/4BUdAezWVqmVUTQrgcRlB
 E1YIUO96e0/TYImmz+aBTZmPQoKw3PaQ4+JTyvy15pevnpdhVRc/Rpnub8O6EqgjeZhS
 zoKwREXSg60pLabZlirlAaKokw2WThHna/fxGj6ER4Rps8xheT2CqJbXfQMR0mfiOb5o
 8YUib+hNk1GMNgr+g5+7OTo1Qy9h18u+xsM+3ZEIKFA6hJu/Pj9EqcjwWjlnLg2W+PYa
 QVh6T434RNGohYIICgkkRcK1m9BYp8l7Tq7C0uGcVzmCSJFxEJsth18VqRnKZVOx7tnl
 UVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109227; x=1793714027;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ggIeAF8ymqQPticOc6wmD/qoAjkwXyVLKkCNBrapmc=;
 b=BL4hn8RmHZtR17BiWfhTMrdPL/vxNHTnZgfSba5Ib425w8qy03dkvVETmFbVfciQ9V
 K23WADSZb7OafyHF2GajURoqfvd0W6t5Pp57/GGgd4Q3FGR+95aAvjQlYY2n+6cm4QrF
 X2Fnds3fp3skYHJCWmlCiPKMKKlJ2dkgO4pLz9mEJmF4KpAdCsSQDUFlNOuDtceCn1Nk
 dW/wb5h+PgN6U09+kzmN2MbH7CeAbtL3hnhUMixWqEQAnh9qwGo3Af82VL5fb0hjhW/V
 AJp36C9bARpPuE6d+tSvJ8YOubzQQg3ycrFQvsOsJrQfLOt8tmzPOiR3JKOCUX0vmmA7
 lsUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtDwBnimDY6iV4/Hy3wE6dxGv2YilkMkN0b6pAFZqggKdEj9pGMJRTDyNkdB9AyHWECqhLNRaZrgw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICQO9lYCVac0a7BXyFSfaaFvUVuKm1IH7v89lx8umqCt0AcVN6
 TWn3GTZ0FWqvNf2kGS6+/Fc3i5owiwzZNBSVCirZPCaq9M1prMPEWTdG
X-Gm-Gg: AYBFou2x17UfdoctFWPFw/rT8NzT/3K9BEN+JjZEpTuvDpLYv4dI8sL+YxBHiK8XsDe
 uzg+wLCYsLNNhrAElirkQRRjjvZRw+Lz4ccPPxARXd6iNxEGtZwPib8IpF6nwu8fPA35Y6QLX4I
 gDMgkvdU9iw4++L83GvLovvNFwlHAsQr9+Ai3unmjrn+aPgtxgqLX4TFwnfSxDKgXuJ9CF8U+u0
 ZsEpIlcv7SNL8u/3T6iyoLhScP5lAFIY6A+KtEvYANgYJOZxDniICCj0ipS1QvAG4XKuq1plidf
 7dlTEo2MBQpQo4N9JcdehtO9ygKtj9awmXb0bR9OtX81U4eOuiDFRA10GQaqzoJDRUNia+Dd2yJ
 GZuB5In+3HBrUE7gKnTm5Kc1E1k7zrzGRe8w0uUTbZOAGhFcVjcuaIcCenVI1ESV5F/Iyawn+TB
 Sf16UZCk39V0qVAedSqAyXAxNELuppqe9hzbmx4cbOoz6TPc7p4XsCpjV9V1ck0q+IYn1Ez+7bc
 5rh418coXAqamZIw8yU5afu2+RclUDdvfBceCB8sCQwtefxPpKGx/kbK41zhsa7PdWrEocpH1ih
 hYsztkox+hvVZspxVi6nAWIKkc7X
X-Received: by 2002:a05:6000:43d4:10b0:48c:77e3:6c8e with SMTP id
 ffacd0b85a97d-48e3eba1660mr15009254f8f.49.1793109227175; 
 Tue, 27 Oct 2026 06:53:47 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:53:46 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/15] drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with
 tabs
Date: Tue, 27 Oct 2026 14:53:28 +0100
Message-Id: <20261027135342.2003632-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The body of DRM_CLIENT_DEFAULT is indented with spaces, unlike every
other entry in the file. Use tabs, so that the next client added to the
list does not have to pick one or the other.

No functional change.

Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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

