Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6371AC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A07010E18C;
	Tue,  4 Aug 2026 15:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+62J/pC";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C97A10E18C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:08:17 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so5260714b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785856097; x=1786460897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4Qg2o+emc3m6rF47B2E/svsOXDIcQrkgOFSzKR4MaY=;
 b=k+62J/pC9+PCw7PHb7TTSGLWLTQ1axvnXox03EPmIp3HvYg1KCxSIQX6fN7sTiunMF
 pIt0bVRYK89I15D86wpP5BlZ6toTn1qJg4nKqsvpDA0dW7dx6SPT3/KeSO0nXp69UmNV
 LFo6yrJSUSPPAQRInKBV7VyC46r4RdhT87G1Ro13oWy8e8SwIdDitJsbdz6mMRKhNmC4
 bZExuZkf5S0c6Zq9bArx99cdwbb4X6gygeLExH1fP+oHRIGuvw5oDr1KiKFJJRqb0leL
 wpKyu/9tlFn3ZJDyloPZNtvJdk/iSjL8D734o0jd/UiiKRVTCOu1Gti98M6Os3OKu7LH
 zz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785856097; x=1786460897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S4Qg2o+emc3m6rF47B2E/svsOXDIcQrkgOFSzKR4MaY=;
 b=FYGZ3HZfM+UFz7IpOW0CxQulsj5FFWUVyHErlBGHvSp1F0QtfxbgGwQuNO9X5HFSkV
 bSKchfSNbhtbzPqxNJOt6Ccm/4977AbPNThgTEtrTsWPIu3uRiVnuTF6KwCpoiJw/x10
 JGN+TJS/Kyz5VD5tdyepe8YXNx+j1s6j0bddWQtDOcsHNUp8sLWrgk7SSzdJ5VbJjyHP
 MIANIPQljV3/YWZJ2PS3WFDQrF8XQ8KO2K5p8Pj8/d3UtiZo3W0Mknar9QL/KBCMUCfe
 xsbqPD6m2cmw8r/23ptx30GiHd8qF/XeRrNxhCL3jx5J+qL5xEp676Kr7BvGJkhLO2Un
 DAjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLwURzOwwgEheu4SK1zlf/w5SEu91O0uuJZIxJPeDJsGEDyQPdQ+MqyuX1TM41QuzqZsaBUr5HcnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4YT8phcKzyYBFbHvsURsR1piii0hukdfCRVtV6WkwZYPtXHqg
 alD5ll9mA8zX9z8edEYze5EjZFyr0rpi95au1sTGb0kaq27AblUthLY=
X-Gm-Gg: AR+sD12IY4uS/ZS8GIWfVZfCIuRw+gr7QyU5O6zeaQ2S2DJ7xXAYxj8itKqFSCQWHSU
 kI4gWLFuqKmrpVE9uYx5pddmJ4QLU5pIWL661AdRNg/hnA/EccFzemKK8GfvvSKjQsQ77xWVfGi
 eodsXyPrbVMh+Y888d3qh7pSqTBAK138xscU2hBUvhO9d3AKjP8N23TZ+qI4zmCUXolaFOfCUnk
 meopxdkNX4Cd6a5xa1e86932ssnD+Wxns+NloLhb20XSDsdma4t1QkrIt5y1qlm4nVDkBSTK3ta
 6y1HgNxUEtI30Hguy1lfS5nzZADJZaDojDmi75nIEFL4Jo30di0fwYgKbR/tkQJAbLKprVb9DcQ
 tj8NhRr+HmfrTEELnh0Yza0nYOnPjFZemMSP96hhm1a2FmDgOIQxLmcLV+cwMUeR1xI+BExxJ0Q
 OzNFQvc4rVXwpIrjzQ47Ote5pkCu0e7rDUqkONdFjyeazJmqwr064GjgQxcU1IhwYjk8OftYL4+
 LAoe1NeSwwriWoJ9WEVDJnarKuYs3RIqyx1hpZ6OpdldsWE9yj4xWF7Zfl012SAEPkPD2sBbk5T
 nqkQw4sRVfC70XdC9MIdbqg=
X-Received: by 2002:a05:6a00:ad1:b0:845:4126:222b with SMTP id
 d2e1a72fcca58-84ee47d8768mr14159742b3a.28.1785856096851; 
 Tue, 04 Aug 2026 08:08:16 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edc41ca4dsm5420587b3a.52.2026.08.04.08.08.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Aug 2026 08:08:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/meson: clean up KMS polling on register failure
Date: Wed,  5 Aug 2026 00:08:02 +0900
Message-ID: <20260804150802.45262-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260524160657.17802-1-mhun512@gmail.com>
References: <20260524160657.17802-1-mhun512@gmail.com>
MIME-Version: 1.0
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

meson_drv_bind_master() starts the KMS polling helper before registering
the DRM device. If drm_dev_register() fails, probe unwinds the IRQ and
DRM device without stopping the polling helper.

Call drm_kms_helper_poll_fini() on that failure path before freeing the
IRQ.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Avoid the unused uninstall_irq label reported by the kernel test robot.
- Link to v1: https://lore.kernel.org/r/20260524160657.17802-1-mhun512@gmail.com

 drivers/gpu/drm/meson/meson_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 49ff9f1f16..bcc36f2cdc 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -351,8 +351,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	platform_set_drvdata(pdev, priv);
 
 	ret = drm_dev_register(drm, 0);
-	if (ret)
+	if (ret) {
+		drm_kms_helper_poll_fini(drm);
 		goto uninstall_irq;
+	}
 
 	drm_client_setup(drm, NULL);
 
-- 
2.47.1
