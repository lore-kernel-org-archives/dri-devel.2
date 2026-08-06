Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380F1C56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7B910E33B;
	Thu,  6 Aug 2026 16:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="AVAdUL0G";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8ED110E348
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 16:16:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so425705e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786032980; x=1786637780;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mmh6B0a7r79J2eomONjpAfByXhOYwDWC3GxzEF2L44s=;
 b=AVAdUL0Gj4GtRQjPGvX4TwRANq6DDYAf4gyVKlv9Ij+bk5yuKizWqTuzjK25EKofrh
 PberPFPYhdwOIxJtG0eOyKe+Y0n1eBnvRD2WQU3OAVhIzEQPL/735wDb5kTfMCoeRgEh
 RgivAl8o0AK58mtnoY1YGTsqddiU8/gd+bNEI0s45Tj6o4rRFP2+ig80hGfC0E6gNzO0
 ZdFZ4LSmt0GG2fJ4EfNxAUTjRyO4G2JKrW0P8ZcJybyMTLTrnbKy1+ISoPTg/xcct5CD
 8uS1MHBpsmpXQKJcCXNAPS8j/agW978xG0c44GJ9rcOD+PhqhMiuxHQNQ62/54H0lkLw
 JHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032980; x=1786637780;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mmh6B0a7r79J2eomONjpAfByXhOYwDWC3GxzEF2L44s=;
 b=UV439tu6Tg0X8CA2bF1D0B26iT2w4qWRFCfWNYJYO7EIdM8sQrcB9iwAkcwOzCCIuK
 i703g0VmIMvrIil+DcQzFvV0BEjLTjrb03h+uN2lixiCOS8TWM+F8bZQ9KMQutGpXFmz
 WI3adG4gZ3pkMq1FpmumY61Jtb6YdPg06EytBUL/TVQoqSYWZHAS0ouaadtXRkH7M+Uh
 cCzklspSGMF7ZvkM5aK6rM21ZEMO9Arlrgv2jK/dz007UeMRqPSB6QA5iZna3zMXtY1j
 OBvZjuTZby0xUjpz9MUgHNgnr64U8ajTEA8AnnvecoaCuNeLVxhcGj8//2ff0ZL7RFIK
 xaNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYx4MPqdhmp8TiMui4D2/HpvZFlQjEP598wEOu+eeZoHmqigSU8Gt3JmcOKHvaNTZ74Su1i0k9g1w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJIgr6EGymX8q8Ljj44svnzBk6u8UZiq409RllMfXIbkVj0LOC
 DMplEPmcZRmOIzFmARhkKy5bvnbXeHEPjrAZxX0KKmayHRaeYor5jIDorQx/pZohUiY=
X-Gm-Gg: AR+sD11Gibhy7hNjw3OIbz/HD4rUR351gjqrO6hnRKX7azdu+HmqTQK5LhV7hHJpOxL
 N214zETQJrc2DyfASFuGKId24XACjH2K2HOhzVFSBbpVAjozVbtCwB0f4/znnejLkXdcURWYaIz
 WItalGeg2NVThEQLmPLL03mzXQdyH/P4f60NNVY+Sx+KfhzYL/kcp+crNKdBkgS4KCiM7XJa895
 R/s/e69aCvUQEn933zgE+ql6W14m7AQVnBOu5iX7+LEADp+o1qOG6Auu5BEDT8cRARx+6Qq8ZIX
 7HMK2bSUUl0HamKxwBBwJk/GMgBtXSuJ6K5QcTjSAuWUBjz0eDwwEe/aTLUjrhyxwuwHLK5ISBs
 /kl6rFdjokjukha1qNeZWV6Jq3ailjR2WvaIOE9BsAvopZp2Fr7ps8dvUmBF0kgihOQlDnwH5PW
 pgKXhMFYyA1ztePy3WEczEyiii09/rLWfNl+rOQlBULvtTFEl6BGwxibXA5WA03kXUv+hzEmoM5
 qnX2BtNDx/ZczwwNRkDXgeFljtxndIwdLXyVmVBs8fmpaIB124vJ3JXcq6BOzHP
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id
 5b1f17b1804b1-4994e71ed7bmr204456405e9.6.1786032979698; 
 Thu, 06 Aug 2026 09:16:19 -0700 (PDT)
Received: from localhost
 (p200300f65f0171047dc1d03432df4abc.dip0.t-ipconnect.de.
 [2003:f6:5f01:7104:7dc1:d034:32df:4abc])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4995427a244sm69306845e9.10.2026.08.06.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:16:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm: Drop #include <linux/mod_devicetable.h> from
 <drm/display/drm_dp_aux_bus.h>
Date: Thu,  6 Aug 2026 18:16:06 +0200
Message-ID: <21c9390024479ec625ca7a2e7a5b959f04d85878.1786032838.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=fbV7D+k+bZ8MZrEOrq13qeiU0Crm7nfk+/VtzgrB+L4=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqdLNGtbVg8UQg91lU5lGnS4ixqD9PEdxBk74bh
 NzXSXOXkHeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanSzRgAKCRCPgPtYfRL+
 TvxqB/0QQev1Kv1PjVygUM1ZEsHPFbWtyhMT88+VadGi913lHhfyzXHxExBbqqFCnkWyJailURe
 MLn38BIvXDPH66WJq42YKRj8Dv9muPifnH0q/NqGi221kYG5jhoYE2nZEXkWlqA1YuazmhnGsi4
 Se0fjDPbJZ1hXZmcVXho+FV21MIHC7hiTmxmyFSlj86GPaeX29e3w1HRgtzjMIoW4QO925ovFci
 mFKagyzqlQ1+8GZvvZ1PPh7JmiYF9mC8MtKkGtgMxO2vaySdW+xQylYlU5faTxreXpUiwLEPebS
 jioCQ6S9jKAcpPYcxRecLZgT54kEDrfPM/fDxw3xOOJ8mppH
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

Only .c files include <drm/display/drm_dp_aux_bus.h> (see

	git grep -l drm_dp_aux_bus\\.h

). From the device-id structures that <linux/mod_devicetable.h> provides
there are:

 - 8 files using struct auxiliary_device_id;
 - 2 files using struct i2c_device_id; and
 - 10 files using struct of_device_id

(and no other usages; see

	git grep -l drm_dp_aux_bus\\.h | xargs grep -oh -E "\<(acpi_device_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|vio_device_id|virtio_device_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>" | sort | uniq -c

).

The 8 files using struct auxiliary_device_id already include
<linux/auxiliary_bus.h>, the 2 files using struct i2c_device_id include
<linux/i2c.h> and drm_dp_aux_bus.h itself includes <linux/device.h>
which provide struct auxiliary_device_id, struct i2c_device_id and
struct of_device_id respectively.

So the include of <linux/mod_devicetable.h> can just be dropped. This
gets one step closer to being able to remove that header.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/drm/display/drm_dp_aux_bus.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/display/drm_dp_aux_bus.h b/include/drm/display/drm_dp_aux_bus.h
index 8a0a486383c5..ca8db8ccc1f9 100644
--- a/include/drm/display/drm_dp_aux_bus.h
+++ b/include/drm/display/drm_dp_aux_bus.h
@@ -11,7 +11,6 @@
 #define _DP_AUX_BUS_H_
 
 #include <linux/device.h>
-#include <linux/mod_devicetable.h>
 
 /**
  * struct dp_aux_ep_device - Main dev structure for DP AUX endpoints

base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
-- 
2.55.0.11.g153666a7d9bb

