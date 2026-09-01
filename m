Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A64CC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C5810F3F5;
	Thu,  3 Sep 2026 07:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="r2jB+JYt";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED38810E401
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:48:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso307205e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1788284893;
 x=1788889693; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0l43AVlC6vAtGNyUJOGdQyBhYz3ewWV5F6wFrMVKpks=;
 b=r2jB+JYt+ffFAIOK20Gl/NNRGhou681FXkd4lCwc/6d0HMcW7vpx5mBcq7yQZY6ZdW
 BqS515OCx2bGhHuZOczy2gfBhM84VUqj0yvCPhxJ+fBIjPMxzULyDVpuXBp32Xiv+LV1
 xsr+AhgPY7E7cMttr5KobSspbxnjRDHxlt/UBle3BJ2slzzMA38e8u7QjsC2zMyPf4Ci
 nSRO3kYwQhQ+x4tBkHeKg6yPDI/JCbT7bNbVYS3m+4wtH0+tK6iZJ/HF3PrZRho/P51C
 ZK4j840IcNt1KQrssP1OvqAQNOTo7lY1gKZnXjYthI/DhXJFEXQcVbS60+FL7koKuS06
 NJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284893; x=1788889693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0l43AVlC6vAtGNyUJOGdQyBhYz3ewWV5F6wFrMVKpks=;
 b=QmvJXgpGmBGz3+1JlYrNhAmxyuVt3lR+XXXaRniLBCeTN1s23Nww6ssulqE9CiYHtA
 fylMvUUyiMI9R63lgLNio/pe8U4As+2woz49s+qT7WNSLMDA5s1J619PI7dEe/06np1r
 nAf1rCbsxbxsrsfrhW9MgvPToPhurOqxChoJlHoQHCG84V2qKHaHu2XtlzkQakrO2o82
 3vYFiSfTjZWfDjcs/B2CRoAcaipFmAdZwweFyAdCcq2Hk785RzBP9da/381/m42mPy+R
 FHaib2BgcjN/D5yy457imsuEPd12N91x55u1zmZnu3WFl3fIx4QFe2O2Y8pQIogpaU3A
 7hNg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqb7WskQDlsiF/KpNEbHThKdp8g9D/5wx67Plu1659XHHhgjZMw/DyfFcwqlCkzqwG4VXz1RYWnMIQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lxYy2AZjqQkOjdSxAlDfPKIBD+zEJ6TEKVz5g+7jnXCGx1IUew
 641xp5GhWGJWax8Ukgbkjt5FiKJaYIZRt6FK0PxIyTz1+GF9kJ9GxUaT/s7d/Ixp4Q==
X-Gm-Gg: AR+sD10RgAR0HtiPmM/7/lpW1wKjD1j9HHCrbo9a0K3tLRVwWPlMXb+gM35RqTeCAAm
 SEMlVWz85Q7aMTvynDriVySPZxIGU6lNuzZT9R0xDLJDmrrjBoIWrMkrBtfHDOUh+lvtNqd+5cn
 Pi09PlWlhQLAoYmPdPRFt/kGhNVUJ7wYjlwS+tOCLJNXuXGyxoE53HUlIiLXei7qHktn/IwLix3
 PEjdLYVgJY7NYs4LySXqD81J1kQZ08gpT568H4cQyEzyWRYAQpAP0iGlqHRCj+REycR74d2616+
 n/xJtZWel3j/Gz7bz9L/UcQLuxdFEi8PGrer1jjjDfeoO9vrSFGB6yi5MHoijcdyJymxQinvROH
 FWCZEQdmcjBpcy7KakMTpnnqlB2JJs6FNC1w0ceBZ4yr17SHDYvVdvUnf19M4s299GkBCDYoZff
 5eJruQeONmvdCVuhOZlTu6bCidMi9xDdL7jPEYmEg2sVJqEK9vdb+wgX7Sh6OK68e+5wMt/0lK0
 QeYlaH3P6T2yBA=
X-Received: by 2002:a05:600c:4512:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49cdc14d69dmr178611345e9.3.1788284893038; 
 Tue, 01 Sep 2026 10:48:13 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm2369225e9.14.2026.09.01.10.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:48:12 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Will Deacon <will@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Sean Rhodes <sean@starlabs.systems>, Huacai Chen <chenhuacai@kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Yidi Lin <yidilin@google.com>, Kees Cook <kees@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 chrome-platform@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Subject: [PATCH v14 3/5] drm/sysfb: Update coreboot framebuffer Kconfig symbol
Date: Tue,  1 Sep 2026 18:48:04 +0100
Message-ID: <1748b8899ec772cc435dc57dc55f76c15da95f0a.1788284852.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788284852.git.sean@starlabs.systems>
References: <cover.1788284852.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

The coreboot firmware directory rename introduces COREBOOT_FRAMEBUFFER as
the user-facing symbol while retaining GOOGLE_FRAMEBUFFER_COREBOOT as a
transitional compatibility symbol.

Make DRM_COREBOOTDRM depend on the new symbol. This keeps the DRM
dependency aligned with the renamed firmware option without changing
runtime behavior.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/gpu/drm/sysfb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index f7e48178885e..2bfcd59bfe6d 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -10,7 +10,7 @@ config DRM_SYSFB_HELPER
 config DRM_COREBOOTDRM
 	tristate "Coreboot framebuffer driver"
 	depends on DRM && MMU
-	depends on GOOGLE_FRAMEBUFFER_COREBOOT
+	depends on COREBOOT_FRAMEBUFFER
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
