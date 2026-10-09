Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8930DCA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107EA112090;
	Fri,  9 Oct 2026 11:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ff3ZcHQu";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181E9112085
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:25:09 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso5372216a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 04:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791545106; x=1792149906; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N0b0o/iVMAqwN7EkNfQamm6FVceYxCUCOkfAzEvfWWw=;
 b=ff3ZcHQu7t3VnN0h3Xt+2KqFNRipErdkwNrq07NYLszgIwDvNZ1nS95DrokjoA5k5L
 AlFjPfG+gOsCFwwLsphoSyB3q56rBCfQtuUZDWpRp1ywfUNWiqgX9rKcfjMUnUY988eD
 3rM+Cn7kl/lZaT2AH+nWctZUVi7+R2Crgdbz1ihPzK5o9llAAMLEalzkL3EPk2aj3SwW
 QmuwdcSMn61K8SNG1aM9xvSwvNgz2Va4XHcB+mPkfIEoq+ow55nydAVrh4CuW05v4ce2
 Hkbr80eyEnTByr39Fr8qd2q/0eZqbMzEqlXc3bG1Ug8elng2IlJ43hwfXxf66xYjzxRO
 /CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791545106; x=1792149906;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N0b0o/iVMAqwN7EkNfQamm6FVceYxCUCOkfAzEvfWWw=;
 b=RPt0wMnuoiRO7HYDNgCFcuEXv4q6GFF/fWz2J2FTrxzGPY4Kwhd/z17amigCVsy66J
 6ldPjhLaT1uSyHIyxsWDjA6fB7h50HpY7sc0U2XS1dCvmyFX0itd3FabF3OvZDVUHtQ4
 v85lO0b6a2Inwk6Kr2MtCfKV3aIXMTDfEs5LyiFgDY2LjcCYuDpvuL23ZEWXbts6oEQ4
 v//ZQE9BhOgAK4fv7Qg6h6Tc8lEPeFHsxOVAQksZRHXTaGoftYytEHC2RHlQlI4XSN4v
 +cGRBGYImM/MHVvE/RDlzeqYU8dSU2bhvgwrvCFH4XIytBUvPI2mSKKylmFdodq1ej4u
 B1CQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEf9M2YR1iAbhYHrn9HAiCzAY4EsHFBqzTKExO7Ccu+KcR/mFQAOr4DIw20oC8mo2qv23usPZtw5o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKWoyMWTOtJsJi7b/HaOX9NbQLMgNlYHe9cdlAuPxm0TVPjhGZ1
 xAIc+7rBFF9PaBUHqL/aOi2rcHNYZ41usIaDMztIsjtB9lMno4HQF4nQwnwmX+fIQf0=
X-Gm-Gg: AYBFou2L+GSw3fWp6ENOSHpksr6UrHuTIiN9aVNxTe+Skp/ax9H2nJNAkTnoIuniUzo
 /prE/5OzRSCe7V2msbKcRAt/5yR12ox1w8dk4aHju+3+aLoVEgJUorPKW5JQuT5wE9Y9dJ5OojE
 eC6tU9PSgzblYwwu138Svbuh0RRA9nB3I9B6DmR6t1tDelrRY/Jxs76rDQf7WvF6YDNVKv9n3KS
 7UJmTFhNszkH4xw0Xzoz4DE+hityMRaTvKdK9c7e4uDHGdIsCLkH1vknk5h/c7jOqjnCivWPqk2
 ToK5yWGmCO7QNQaD+lQZfL41mUXWVV+XTbMdBXrJUmF2j8p+pZXUFGuQ0V17G4PdMlZ8/mof7xP
 7kwWb1Ne0CzUeqx5DSmpmU9N88L6HnpkIOZyBPanaEg/v9GPzDgkVQYlhRTbOMNmI3AG+eZCCP9
 jim4NVLqnU6wjo4rOuuAnCfFzFbXqVcWMuF2U0sq6cugryTSboyOH/oqERzOzdCc5nH+b5cuyCA
 SInaUw7SDphpUGs1LqS553YLNkdoFz/5Emr7iKWNbVrjY185Ak4
X-Received: by 2002:a05:6402:5189:b0:6aa:96b3:9d7b with SMTP id
 4fb4d7f45d1cf-6b17c29892dmr1280328a12.45.1791545106487; 
 Fri, 09 Oct 2026 04:25:06 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dd3597sm985764a12.14.2026.10.09.04.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:25:05 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v4 0/4] Add Novatek NT37705 panel driver for Fairphone (Gen. 6)
Date: Fri, 09 Oct 2026 13:24:59 +0200
Message-Id: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OQW7CMBAF0KtEXmM0tmPXZtV7VF3EkwlxBUlqB
 wuEcveaULUIsfzSf3/myhLFQIntqiuLlEMK41BCvakY9s2wJx7akpkEaUCD4N1k+NQMdOCqVRq
 dc611NSv9KVIXzuvWx+c9p5P/IpxvA7+NSN+ncmS+15hvEnEcj8cw76r8tlU8omI33Yc0j/GyP
 pbFWn7xQxYcOIFDD9pogfjeNSFO/TjQtsyuS1n+ayfso5ZFG+M01gDWSXil1Z8WAPJRq6Jrb6G
 zyqNT5lkvy/IDgGAixmABAAA=
X-Change-ID: 20260501-fp6-panel-3d35c999d894
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791545105; l=1623;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=3RiJrg3T/A4hkKUCBr13+wDz2DdeBZFJrHuY/UKpTuQ=;
 b=n9sHWAPeaTz9L7Cy6z9jwdx3y6w5vzk+5mzW0/ZlQz3qGFVUMFYW57e+R6ZqSvxIy0hegT4mX
 x3/J0mNuhZHBttdJDYIRjMBMuURkyAbJDcdJ6clw7UjiSEyywsqyeAu
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Add bindings and a panel driver for the NT37705, and then enable display
on the Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v4:
- Use MIPI_DCS_* for a few commands (Dmitry)
- Link to v3: https://patch.msgid.link/20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com

Changes in v3:
- dt-bindings: don't use 'contains' (Sashiko)
- driver: Use devm_drm_panel_add & devm_mipi_dsi_attach
- driver: Replace linux/mod_devicetable.h with linux/device-id/of.h
  (Uwe)
- Link to v2: https://patch.msgid.link/20260918-fp6-panel-v2-0-6695c4008920@fairphone.com

Changes in v2:
- Fix kconfig dependencies of panel driver
- Pick up tags
- Link to v1: https://patch.msgid.link/20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com

---
Luca Weiss (4):
      dt-bindings: display: panel: Add Novatek NT37705
      drm/panel: Add driver for Novatek NT37705 panel
      arm64: defconfig: Enable Novatek NT37705 panel
      arm64: dts: qcom: milos-fairphone-fp6: Enable display

 .../bindings/display/panel/novatek,nt37705.yaml    |  71 ++++
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  64 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37705.c      | 396 +++++++++++++++++++++
 6 files changed, 545 insertions(+)
---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260501-fp6-panel-3d35c999d894

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

