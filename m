Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FE606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXvJZBT2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A5310F849;
	Tue,  3 Nov 2026 22:48:46 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C0B10F8C8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:48:40 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-98febe968deso70130241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793746119; x=1794350919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VpueH27K6JlaQKxGbcQGMz0cimxkNE7G18UyqQoWER4=;
 b=DXvJZBT2WK61pjrrx6BnOvB65rzNu8lLiarQdopQicm7AiITteX/wfqkpao/UVQCvs
 N2FEJ9E16y8EHYvSrCaXYERA/buSOLLoA89ZM+erWRxpvreVfThpQz+0qGIpOVkxcrhv
 oibBghFTrxuNKxHVSFvMICLON4J0iUkEYS9HC9MkjZI0eo++1haiCq2JwUgkDd9tXHjN
 pJp7q8RPjlatecCsROvcGF4+QH8FIgCETvncckTBBmEoJlJpsN6Vi3dbK8Lze1lp+NA8
 peqgmpNL5aZzY/Mxgk4xbJ+/uFPMglcqHKN3181Mra0W/xl3/QnSlAQBVITfaIypkKg3
 X9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793746119; x=1794350919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpueH27K6JlaQKxGbcQGMz0cimxkNE7G18UyqQoWER4=;
 b=egL6YUMuWwPRAZbrBLc6Lp67QTt7JFUQQl9oQiJ3Zq96LGV4fleNQXB4wqZ0oxZiYR
 ZRwSr3cuqpLYqyZQGBu3ygn7dyOUM1bvY1TF2FINSiO4HJoO4ysQLiD2yLr3nD80nxYl
 /vkzp6tRdm+CJOLQDsZbC4pWpzT4b0dC5NsJ+gwQMwyJtVn4BK1GarJNLHIOvfu7BumG
 9iwUrfpFf3sjF8x61LRBSmDb5Ikkp2czF/t8O74U5ZtdPisKaoD0AiBCI9xCQBM5Y4+4
 QAkTb4ha4ukGdRKb1a6uko26OblJ/inGSlmTrne6YX/41rJpTTc2xVW3oydQPmvnkZGA
 GY0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx6l9TKhywDDDege+RwO60p4Fp1GzEA5T2Lvcj1JZcfc/JPTF+42sjqD5f73xtxNwGJfV/XxbSLlw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+EWUAV0qEYHknLl9/v4ax/KIhVBjdHeQJ7VSLfJ2UKPmTtvzZm
 POTm+PmUTB1JRL0siAfpfRJevCrnBA6Zg+L1VE1jb/VN9J7FJzByayMp
X-Gm-Gg: AYBFou0xjmGklw2dBMTRgHuFoSmI9l/QV5FCTpN1/89miAJ+HDCO37JBufGOYnjt9lI
 YftXqLFXqMWfnzhzn02GfB4KU8Tdg9medrECwh2UY4AyWRcDSO4tgevUqJd0jV8AfTQWms1Qg69
 L1S7zbo4BGIm+TLgJtfch7b/MzdbjqLPIG1U4enUvIXAT3493dawbFOtrDkSnWXLQofPxVYbfhu
 TrWjOEHGldnuopLSRTsfzXUn5uygj5+60HV6FsTuNid7k9AmHLCYPLBD61HRi4FVCDSISPEsUFx
 APFWLc9ADxseVX4YT2ukP0kJ/6CEnXMZ249miXm8ctYbYt6CAju0Lal5afa0fml3UB2/8/EUsSo
 pznFP0sYSUACatbalvLHzUgzPhGwj8jw3tKiJ3pcNuTKwsTJymO43SNktpAJ0Jahd12xr3Brwm2
 U5Qa6biWWLVT+v7FC1uAF6hAvcZii6SJg0fAMeZURa8BycYXUMhVQACOeWauMuVqlhg0HOMbqH2
 znCRcIG2P1tryAngwqwmJ45ChSg3o2p1HxGKjdBbTPELINz+FIGT8Vs0jHEOoKf5VA0t+1RJ7qH
 CagERJYPgmvgZOB9uTiW1w4xKq8yQDj0t3RDJS2M4MfPf4F4A+fhBsMj2r4CbNWf2cG+r7e/Khu
 JnRLWk5Py8BeAC9c1P/zuHdY=
X-Received: by 2002:a05:6102:160e:b0:7cb:bbcc:e4e with SMTP id
 ada2fe7eead31-7d07271116bmr5937597137.23.1793746118899; 
 Tue, 03 Nov 2026 14:48:38 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a802:6062:72c1:c30a:87cd:60c1])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-998d69af4fcsm401286241.2.2026.11.03.14.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:48:37 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: p.zabel@pengutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, luca.ceresoli@bootlin.com,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: display: imx: Document fsl,pcr
Date: Tue,  3 Nov 2026 19:48:30 -0300
Message-ID: <20261103224830.377009-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Some i.MX25 and i.MX27 devicetree display nodes contain fsl,pcr, but
this property is not documented. As a result, dt-core.yaml reports
its raw bytes as an invalid property:

imx27-phytec-phycard-s-rdk.dtb: display: fsl,pcr: b'\xf0\xc8\x80\x80' is
not of type 'object', 'integer', 'array', 'boolean', 'null'

Document fsl,pcr.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
With this change applied, imx_v4_v5_defconfig builds with zero dt-schema
warnings.

 .../devicetree/bindings/display/imx/fsl,imx-lcdc.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
index 84610b5690c4..f1931436a4d8 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
@@ -65,6 +65,12 @@ properties:
     description:
       LCDC Sharp Configuration Register value.
 
+  fsl,pcr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      LCDC Panel Configuration Register value used in the display node
+      referenced by the display property.
+
 allOf:
   - if:
       properties:
-- 
2.43.0

