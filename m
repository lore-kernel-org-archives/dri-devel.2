Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF705CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAD310E5F7;
	Thu, 14 May 2026 21:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ltyBb/RN";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB6310E3D8
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 17:41:49 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5a88de2b52eso10450129e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780508; x=1779385308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1l+SpR/UEyvWMAal4xyrEteWb4GfZNc3Ty6R5bexWb8=;
 b=ltyBb/RNrS0Lx0eUMykFWZQWSkMlqr4a1XfzaI+Jtga48yu+2bPGIN5tmQkejQR4Bq
 BwZmv53jremzcQxCevimW8/cIjH0ryIdRD10Nk0dvCYxSmglVDcSSfsv30XyCnv3TyM1
 oE7KSa1fA0LIsesXS9OTElxScLyHDF0mYIsvaqZnamRLehdlk+Wh6UrlPW9J2nKYveus
 QJvwJxGVaI2KKmBSVlN4jD9OHtieQjDlveYqymsPKphgvdFDlHe+gNJI57Nk6RpryZ8w
 RNFYI7SVf/eS8OdvVMyB5m3/zgxDAkNuN4N7QcpEmlxfQFTISQ72CKtUJp5tFo7IAWmS
 cIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780508; x=1779385308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l+SpR/UEyvWMAal4xyrEteWb4GfZNc3Ty6R5bexWb8=;
 b=LzkIWEiP/l8fUuRLuVAmBSdqnjAWO8HXz6lohQ3n48i+rbHoB6vf7e4SDPdEzEfm2j
 7cZ1B9ldEL7bADHz//6e1KD/TB66ZoXPjpS1R4pgLz0KJvUFSsGMw3RaPPnOb3tEImhQ
 NZU3hp3SWm1FMyG8yeNZ2jdCLwvAzLk/cC2fCQnWma6Gw7L0q/2J9TNLe+fVrGucuicF
 b7ZclMIX4jB8BYoi/CbWHIiVg2/5r1+pTERQ3Bmx44h3Zjs/hTVXmpqivIBZAsf5G8dx
 ZBUajVYqEXUAqRs/RFcAhL0nyQbWIC6RmwQD/prDrEDc21ZOOE+72wnB1MpvjLtVmX0V
 YfiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tb+N8Ne1oWVukQUgw/P6ZplHP378HXjY6toGYO/ouVuMRHKUsA3+M8+w7Pt6ll9/nTqa8t5rT4W0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxYGXGsIRz2GfkASnNnV4E/WMqttECL/OR5e395skwr0NMcFJE
 k8SMJt1HhvZ/AqrNSrnBPxUV1Ie8QCD1ZtBNwC/1msTzKaQRHEhF2J5R
X-Gm-Gg: Acq92OHrXtG902eyNACEZSbb3LrcsL0FfOeGlqz5Ou1/VqWnodnREE3l70SMLy/+JD6
 aTW28PyOh9nYr1yuAJuooWQtQda/5O63hTB7YlqkzTpRc7ck0KdcB3/mMkf7R6u0OaNHDnZWst9
 ABH5VHkooUlW9/vRYegBWetelYqPoTqa8S7mzkJVNbl4Nef8q8kYZ3fAEf6+IqTG+4CJa5wgGlL
 6X+EE2NIELC6U73ZTRMRG2NDDln83rUrXoOX+giDEN2KAKblhGRQeFnVeDR8cQcPeg/vxlnTCc6
 YzL1TP8cHtiJ+JP4pBhUHRhpiTaU+rDJ27Jw/L7jmJgISvmgpkuZIcmBBhZGzoeof+5nyCx9yMp
 UH72bnB3k7Uvte4hwy2jx32sYtBTZzcxUucrhMtRgRNnNrp1m1QhP9ZRS4kp/glsOKYwOkVqt6y
 zDK2Kv1eZO9IouKHEeJPft/Y++pgsPT0gY06Cq5+7xsn9poXEtVVtByMuG1iaw19JFyIU=
X-Received: by 2002:a05:6512:1287:b0:5a9:bdab:2d19 with SMTP id
 2adb3069b0e04-5aa0e5c3b4emr47624e87.0.1778780507399; 
 Thu, 14 May 2026 10:41:47 -0700 (PDT)
Received: from localhost.localdomain ([217.107.127.207])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c84dsm613528e87.10.2026.05.14.10.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:41:46 -0700 (PDT)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: Mark Bulatov <ms.bulatov7@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH] drm/nouveau: handle nouveau_hw_get_clock() return value
Date: Thu, 14 May 2026 20:40:08 +0300
Message-Id: <20260514174008.4515-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

From: Mark Bulatov <ms.bulatov7@gmail.com>

In the nv04_update_arb() function, MClk and NVClk are passed to
nv04_calc_arb() or nv10_calc_arb(), where they are used as divisors.
MClk and NVClk are calculated using nouveau_hw_get_clock(), which, via
nouveau_hw_pllvals_to_clk(), can return 0, resulting in division by 0.

The result of nouveau_hw_get_pllvals() in the nouveau_hw_get_clock()
function can also return -ENOENT, which is not checked anywhere.

Fix all this by adding a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
index 1d3542d6006b..2f59b8739fc1 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
@@ -202,6 +202,9 @@ nv04_update_arb(struct drm_device *dev, int VClk, int bpp,
 	uint32_t cfg1 = nvif_rd32(device, NV04_PFB_CFG1);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	if (MClk <= 0 || NVClk <= 0)
+		return;
+
 	sim_data.pclk_khz = VClk;
 	sim_data.mclk_khz = MClk;
 	sim_data.nvclk_khz = NVClk;
-- 
2.39.5

