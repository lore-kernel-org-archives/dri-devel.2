Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E30C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4A710ED28;
	Wed, 19 Aug 2026 06:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ldYIcR6D";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBA710E477
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:55:02 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-472326ca506so2746719f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787003701;
 x=1787608501; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=waubqiuCOYRQ2QTo7ozti7dFGxycb8EqFHbDI6qm6Lk=;
 b=ldYIcR6D+Gp/jJ9a2QT1xI6Crl16DXMrIMj0EtC2nJjVzC7TJoouXHdsISKDY8+0nG
 A7GhlZdCOhU0BimD2BSRhVUXpX6HjMi+nkuhZGa2cmQxDCMn1ZixWT5rXHGFl1tnmxEq
 OY837HUk39tM7mLxZwIpexha/UZ3dhQIvsCAqlut6/37PvkG8WQCwYjZXBXXsngwy/Um
 vrooFAXJLPe8NSIV3X5QVhvhy8u/+S94uDNk1ElBllrOqqwyANJhTxm10rTMLngkJe7U
 PGXb0POKvKaL6kP5yRiyS9Tc70U9VaKopRm4mXnmcL7p6UMaRsf+k4dz+FrP5w7m0hGL
 DDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787003701; x=1787608501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=waubqiuCOYRQ2QTo7ozti7dFGxycb8EqFHbDI6qm6Lk=;
 b=OpcoiHsC1OR36RIhk0x9qOCBDeAM2Fh58aPeO60OYUDes5aXhMTUlvv9XpSqPzwWtn
 I6GEMe5DZJ1pNLQgyajhAVFvrjy3cgeBaNoNSj2GXPPgv2yONyLZtdCxPKHYLAyHjYP8
 V+730sXaFBriVbbBB5JCa4romlXrJujlpNsbpNKscsCh258rX4XX3toPlxIIRb8Vef46
 nBRLT66U5FAUbhJzUO79i+Zqmb6MFg1P/3ivYwqzjIHe9N93TWs5QczW0Gu3c6s/gufs
 YnbjQCuIoqfXx5z6OMNRfQWi5DoKOHFmefpZEr+Jc7dNKwAvjCCC2XCylbntK1rOiYkb
 Tydg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqCJncNJJ0oKCg0YUjBp4r5igh40ByxCBxj0Z10Dwggqopiw0kJ6MHJD9OOnBLIzGNsLWB2S+aUZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzge7/7IgMur2qu/5z89PRL+2dljcpaZBZIy8Zlv+YA5slamRud
 1MtqWn7xxzfV51YLu8Ld7WFkJmHLcMpeHqF3ZwcABCT74l9EH/EX4acBnACiUO/Sww==
X-Gm-Gg: AR+sD10X6WFXMkshJ/VqHPKhQy8wFOv+2Z4cq//MaSJd7Zl803wMO0ud/Ok+YEzajzF
 5kiNd/7QOv8M3GMtGhN2F6jYlFIatH30ifE87Z4JGddJynQmSUOev/RemZCTqAkxqU146APxNJY
 zuB1rY+5qE0XQ36qQ0KkHNU7DJqGzkwB48hkNcoaIHNBL+Cc6FLEywS/uB4T2kcWgndqPKQsfsa
 V8+I6UHj6CHi5mdLZHg3/EgZX8I1ArQL6tCo/TPZ9973a7yM/XNMWb6jglh8vDXoZ2uc0QgeQfT
 erKYbOtdI6fdK2+uF39vg27XzyQLxuk1q4oYu/3t7SJmATz+zZzGVyePSt/DEH8fZvYWY3HOBdO
 oSfRqx3DgUEuzoRCQWTBSXJbk8elMOHk0hj99HBmj3g70qfphEnosTGpmQbV6Byty+A2qXCIu/g
 X+Kx3HNWydvGrXLpZ8Xezz3j3kWo671cqi9VCkPM/NryU3KDqm/FaaGLOg6XHjvh5eUDv70oB82
 U0ezzeibfLD1A==
X-Received: by 2002:a05:6000:4a01:b0:47f:8f8f:e493 with SMTP id
 ffacd0b85a97d-482a8fe9b5amr6047922f8f.3.1787003701113; 
 Mon, 17 Aug 2026 14:55:01 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b3f0sm6060954f8f.14.2026.08.17.14.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 14:55:00 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: chrome-platform@lists.linux.dev
Cc: Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Sean Rhodes <sean@starlabs.systems>, "Michael S. Tsirkin" <mst@redhat.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 linux-kernel@vger.kernel.org, oliver@liuxiaozhen.dev
Subject: [PATCH v13 RESEND 5/5] arm64: defconfig: Update coreboot firmware
 symbols
Date: Mon, 17 Aug 2026 22:54:51 +0100
Message-ID: <540bd3107a81da9555655ed2d5a9252ed04a620a.1787003659.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787003659.git.sean@starlabs.systems>
References: <cover.1787003659.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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
index 654a102cb5bc..32ec89a872d9 100644
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
