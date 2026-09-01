Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928AFC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76EDC10F3FF;
	Thu,  3 Sep 2026 07:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="FkAeej/s";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5B710EDFE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:48:17 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so339655e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1788284896;
 x=1788889696; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Ybla6Y62reZI1CmxWmKc144ZA3IjT4POIfUXQKsL2w=;
 b=FkAeej/sziBBl1shQQRUxER+tDSnq5ZyXbObKGzPdNaIkfWJv5zWSq6ZQwDhOf6rWc
 YVbtuVQyWRvXf+gIqxViDW3ieYRaq35hp4VLmKD7Qs/3OIi8XFD8RFXJ+316b4Z0fYRK
 x0u7wNNPjJbwtIjx7PtP8wKfZOx7tmPTYP1PIgeWGyJ1vjn1GQWjNXVXn+WPJmk36m9w
 NZKFonEXbbQIdTPcc3SUdtaZN3j97Un857V2WKfZLvOZQaVzfA7Pux2n2Jnxo+KRTSNw
 HSKwVSnJT8QOHPgL7tj8l1ILymj7fm+clnxaSMseEW8Qb0TS8PznXguOQ8zDyAtiKR8i
 EB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284896; x=1788889696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Ybla6Y62reZI1CmxWmKc144ZA3IjT4POIfUXQKsL2w=;
 b=gk8GcUCyNkZlfiD58ifEHJfKZdZW7U0uFdSlC/+796WiAe2JCx4b7Fr14ZfzVYujRF
 rlP1EARWVF9eSe5GvScU4twvNIf8nMBD4NeWjT0rSW2QChpMiG88AoWEg6cOejLSiS8l
 o9QVaSva+jEPIsAwzLIvHTCOvEQeOiAxBeOXn77l7jwktgqd5oxzNAUklKZn7nOAw7qk
 88KwDfy/7fyL375l1qzvFROIvNd2qlLRCE1HrBcoHbREJ1emaYuBJBCdasMyVYavjbA2
 mfU1ZGko7G4TNPSo+SGc4Wnm4Dt9drXeXpWdYc21ktLKxl69y/1SYmAttbeHnrIT7bOt
 AxXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXaRT5YO7gkNh26nzbir8U55D/IxX1rITQ4SrXBwo4uf9PFg4LEUejFkg5uYhag7y1kxk9jf7t674=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kIc3YHNZ+E/1unSuHsVre/rZChe/0QVkghAt9mdd/gWEURilRP
 UWoAqZgF7tR5EHuYqOg1WFe4Dx9YInivgnQG45cdUJPT6JruZO6GKjf2W8XnoCHrTg==
X-Gm-Gg: AR+sD11v+YFTTu149lNY3B3apgY2f5dcYbIdXteoTrhSLvKEA6mG88/Cg8C9gTlle53
 gOtO+9Hq272OPmIRenAdXIjuoiN8koNI/1pZR1zRDiDWk4v7py78MwUYpmc771/4j1nxkhcMxZs
 sRqzw4ox0OuxLLJ5C+NRoYqWWnJxu3vXpSv1AsnQdLwiLJ2VBzY7DUwVfC1oEBw3/LYRgwJFa4D
 Mht3xoJ/oJ2PfGagxJIHwgzELVhR/SjTvcRysaRE6ic5FDBCx9y1CljntPV08R6kG93RHuSfxZV
 V8wzEqx4phqUTBpVcvbYyb/IkaTnT/GvTJnkc2aN6Uy5HF2fPGqv258z6jjXZAe3bM5/rZtLjZt
 9ulARO7BUfFEHZiy2MpuLUND91Ax7XgkcYCWiMvBKUKBXH7QCYspa1JdrTnN/lT0n+gOVB1TOra
 iPoCFQ6pU+DryCYArVm0zR6hH/7apvMNa93mZLHe2SVIuVvJC0MtPsc59WXYWuyTtKi0b3J2Ewr
 Q5qRIbOtlSR9sQ751usyJ3zEA==
X-Received: by 2002:a05:600c:8107:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49cd26ad005mr380287175e9.15.1788284896231; 
 Tue, 01 Sep 2026 10:48:16 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm2369225e9.14.2026.09.01.10.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:48:15 -0700 (PDT)
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
Subject: [PATCH v14 5/5] arm64: defconfig: Update coreboot firmware symbols
Date: Tue,  1 Sep 2026 18:48:06 +0100
Message-ID: <72952b598bd73ca282026139e4a1db7af89c30ba.1788284852.git.sean@starlabs.systems>
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

The generic coreboot firmware Kconfig symbols were renamed from
CONFIG_GOOGLE_* to CONFIG_COREBOOT_* while keeping the old names as
transitional compatibility symbols.

Select the new names directly in the arm64 defconfig so the checked-in
defconfig follows the visible Kconfig symbols. Keep this separate from
the rename patch so the configuration churn is easy to review
independently.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 arch/arm64/configs/defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6ec8d3a69c98..90a7b49d408b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -267,9 +267,9 @@ CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_MTK_ADSP_IPC=m
-CONFIG_GOOGLE_FIRMWARE=y
-CONFIG_GOOGLE_CBMEM=m
-CONFIG_GOOGLE_COREBOOT_TABLE=m
+CONFIG_COREBOOT_FIRMWARE=y
+CONFIG_COREBOOT_CBMEM=m
+CONFIG_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
