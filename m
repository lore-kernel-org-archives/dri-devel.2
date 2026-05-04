Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F993FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 15:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9710810E74C;
	Mon,  4 May 2026 15:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="OTqqXmw/";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14AB210E74C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 15:05:46 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso778025f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777907144; x=1778511944;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vGzvK4HsHm02j9O1TwzKamsko2ii3BucSi9rVkl9Lnw=;
 b=OTqqXmw/Ss/d6t74zIC9DEkUY1Ml1t9madccCjLvQOG4k3a7Ab1sGfz2bpxl5GFA8i
 xyhU+fTJbV8eMCtwr7fnVMb2OkQriT1o3p2FYUMa7NGTKchBf6rHWWwPyvuitCrKjQ9C
 XI6PP5I31QOKj1GTEh6r5VLI69z07sfcAJul98+0bLeWtrrpYE+eF1qdItBXsC4C0OWa
 Q9HfhJnTS1mop+WHfN57isN+/dvx0jZk4rh7HnbctigWLvzP6poE0A5X1HgheHhC0BuM
 BSFxBmkfm5k3DK5sB+iYBfWbGlHvp+ybE30/v7TUkYETYaPEGJV0ERovFa/VD6hHxPIq
 oM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907144; x=1778511944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGzvK4HsHm02j9O1TwzKamsko2ii3BucSi9rVkl9Lnw=;
 b=olBwxezo+0hhNjJKUiruA+slDGT2kobo6DgIws5E7sGpj5/VjWQnpxDkewXnoLbzr4
 SsvWl/TrYHj7BpJsMNnxpROGn/C2/HJ2OKsRuow72TUcibd4IbeMzcbI/G2YM6i4vVYt
 qQ6gzt/1yT7m8lpcltsePZw8eGbq805k2kE/ZGCXHr8ISWQvjdWlMK40+KweqE+YfSHH
 4Bg7drQLtmES6LZRnYJlguBCdkPOzAqDySurVpTLknP5EeeztAk1M+WlLdxHfXxuKx8q
 +6/LMvV0NfHB1MbzJ7LyXIDXknrVE1mzOcG5t+BqwguNOVM+HfDR5idIz7ApMSh9oAu0
 3gcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Aj9MdAttER0VrsYqH/97L82TkVM2eWiDfzajLC38MK82boenr77DigDMRL5ZnAYlj8edpRUaQsos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjN8+rQBadHPob+l4K3pS59J7q472NfiVhY8AqzkPhOhf8bDt7
 mkPi1Wp5PJD6zKP88MXcxbF/SIBovMKsIpO0OaC882E6KGULumufPG1wQLMl/A7QpdhOCj0Xymk
 euqkJ
X-Gm-Gg: AeBDiesCZAxA4IO+OhEEQc8JGFNWoS2xNq90TqLeSo4w/NR7D24HMxXbxgDF4Ik1o9x
 EJCuveXEbSbx2MP4B6kHz2bZdLeTwZtyZLqInxCpXmq6wj1GcgXRahCRtmEv4x8PbGb+BUmzXas
 CLoehNlqKukA+28vfQWgtFfQJd/8OO3Ih88QXyBIQsl7V2+GNn7l6xnum9zqjF5Y/4JzYmlMsgs
 2RWX0CB3tfyX+ngfQcig4KxoiM0sEv1UinF03KMK+GPVJoSUxM6nrVR1PpfBR4q1LS/NN8L0mBE
 YKRJGx6W+W/CPBi4xk/9JfW+AYQ+PJ4pfWHbdo7zllbiMvdltjxmJCsN/ek0DUkxAF40DYi/gjL
 Q0OB7Wt+aCMYuh4pZ/0wEeFe4P9YXoqUrpD2nz2OgGFyJjV3dnFAU3aZz7ceq1Ta0hILaHH2QjG
 MprFOreFoNiGb85fGDMKGRjmUDf91tllIxmAjMKYKT9hLHrlQ+bCKbmR039n8Fa0sIVUUgwx7w1
 PU+Uuma6UVOvJqPh611B7XbGw==
X-Received: by 2002:a05:600c:3487:b0:486:fb0b:ad79 with SMTP id
 5b1f17b1804b1-48a988a6ec9mr178609795e9.20.1777907144531; 
 Mon, 04 May 2026 08:05:44 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48d046faba7sm38072595e9.30.2026.05.04.08.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:05:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Subject: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
Date: Mon,  4 May 2026 17:05:37 +0200
Message-ID: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9388;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=NE1L6eMzG6COj1SB7uAmt2t6ZR5qluBMscfu2fv82Pc=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+LXC7vbJIuE2keRFm6HVDh2ebJ24M6YY8wzqT
 r96mRsBPBmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafi1wgAKCRCPgPtYfRL+
 Tl7GCACfNS/fqsNkHf6BM4BCBvB6p0B1vHt/ScUAqlpcSAqMYX8TzNHbiI+W88f+p/Vt3AVExJt
 LNxEJmfvDpAh3sTsue2/b4O/lc3hyU8y+Kw1VAYD7tkNcVUR/C6jcIB7QkOhwjNNsvj9RWpYghx
 7fftJjmp6E7aLxhP9v5e+WDD6F8v+p7+RIApXuSQgNr4iCCY1jBVmbnQBFr2kNJQnoZtDNLy5dF
 6yMkhqMJVJXebTe1j6thkum5+dfkHMjlcSrr6UeVNxJJdPJ8Kh10GudKxGbahDvUppWvhSBBa8R
 gWRoqIfS/iKEazlGfaUvk5/jVNOHfq3wJ/CEdLIpQLEr6H8j
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

The .driver_data member of the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using the PCI_DEVICE macro and named initializers is more
explicit and thus easier to parse. Also skip explicit assignments of 0
(which the compiler then takes care of).

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But IMHO it's also a nice cleanup
on its own.

The anonymous union will allow changes like the following:

-	{ PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr = &psb_chip_ops },

(together with the respective change in the code when the value is
used). This gets rid of a bunch of casts and thus slightly improves
type safety.

Best regards
Uwe

 drivers/gpu/drm/gma500/psb_drv.c      | 56 +++++++++++++--------------
 drivers/gpu/drm/loongson/lsdc_drv.c   |  4 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c | 24 ++++++------
 drivers/gpu/drm/qxl/qxl_drv.c         | 15 ++++---
 4 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f5355f..039da26ef24d 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -56,36 +56,36 @@ static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
  */
 static const struct pci_device_id pciidlist[] = {
 	/* Poulsbo */
-	{ 0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_ops },
-	{ 0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x8109), .driver_data = (long) &psb_chip_ops },
 	/* Oak Trail */
-	{ 0x8086, 0x4100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4103, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4107, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4100), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4101), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4102), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4103), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4104), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4105), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4106), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4107), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4108), .driver_data = (long) &oaktrail_chip_ops },
 	/* Cedar Trail */
-	{ 0x8086, 0x0be0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0beb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bec, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bed, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bee, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bef, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0, }
+	{ PCI_DEVICE(0x8086, 0x0be0), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be1), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be2), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be3), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be4), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be5), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be6), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be7), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be8), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be9), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bea), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0beb), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bec), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bed), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bee), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bef), .driver_data = (long) &cdv_chip_ops },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 1ece1ea42f78..f9f7271ddbff 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -444,8 +444,8 @@ static const struct dev_pm_ops lsdc_pm_ops = {
 };
 
 static const struct pci_device_id lsdc_pciid_list[] = {
-	{PCI_VDEVICE(LOONGSON, 0x7a06), CHIP_LS7A1000},
-	{PCI_VDEVICE(LOONGSON, 0x7a36), CHIP_LS7A2000},
+	{ PCI_VDEVICE(LOONGSON, 0x7a06), .driver_data = CHIP_LS7A1000 },
+	{ PCI_VDEVICE(LOONGSON, 0x7a36), .driver_data = CHIP_LS7A2000 },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index a32be27c39e8..8ad4ddb60ee6 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -205,18 +205,18 @@ int mgag200_device_init(struct mga_device *mdev,
  */
 
 static const struct pci_device_id mgag200_pciidlist[] = {
-	{ PCI_VENDOR_ID_MATROX, 0x520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_PCI },
-	{ PCI_VENDOR_ID_MATROX, 0x521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_AGP },
-	{ PCI_VENDOR_ID_MATROX, 0x522, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_SE_A },
-	{ PCI_VENDOR_ID_MATROX, 0x524, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_SE_B },
-	{ PCI_VENDOR_ID_MATROX, 0x530, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EV },
-	{ PCI_VENDOR_ID_MATROX, 0x532, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_WB },
-	{ PCI_VENDOR_ID_MATROX, 0x533, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH },
-	{ PCI_VENDOR_ID_MATROX, 0x534, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_ER },
-	{ PCI_VENDOR_ID_MATROX, 0x536, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EW3 },
-	{ PCI_VENDOR_ID_MATROX, 0x538, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH3 },
-	{ PCI_VENDOR_ID_MATROX, 0x53a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH5 },
-	{0,}
+	{ PCI_VDEVICE(MATROX, 0x0520), .driver_data = G200_PCI },
+	{ PCI_VDEVICE(MATROX, 0x0521), .driver_data = G200_AGP },
+	{ PCI_VDEVICE(MATROX, 0x0522), .driver_data = G200_SE_A },
+	{ PCI_VDEVICE(MATROX, 0x0524), .driver_data = G200_SE_B },
+	{ PCI_VDEVICE(MATROX, 0x0530), .driver_data = G200_EV },
+	{ PCI_VDEVICE(MATROX, 0x0532), .driver_data = G200_WB },
+	{ PCI_VDEVICE(MATROX, 0x0533), .driver_data = G200_EH },
+	{ PCI_VDEVICE(MATROX, 0x0534), .driver_data = G200_ER },
+	{ PCI_VDEVICE(MATROX, 0x0536), .driver_data = G200_EW3 },
+	{ PCI_VDEVICE(MATROX, 0x0538), .driver_data = G200_EH3 },
+	{ PCI_VDEVICE(MATROX, 0x053a), .driver_data = G200_EH5 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, mgag200_pciidlist);
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..6c3c309b8e4d 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -50,11 +50,16 @@
 #include "qxl_object.h"
 
 static const struct pci_device_id pciidlist[] = {
-	{ 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8,
-	  0xffff00, 0 },
-	{ 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_OTHER << 8,
-	  0xffff00, 0 },
-	{ 0, 0, 0 },
+	{
+		PCI_DEVICE(0x1b36, 0x0100),
+		.class = PCI_CLASS_DISPLAY_VGA << 8,
+		.class_mask = 0xffff00
+	}, {
+		PCI_DEVICE(0x1b36, 0x0100),
+		.class = PCI_CLASS_DISPLAY_OTHER << 8,
+		.class_mask = 0xffff00
+	},
+	{ },
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

