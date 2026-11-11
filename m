Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77305606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VanWIAsk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE96A10F94F;
	Wed, 11 Nov 2026 08:22:59 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E2F10E2AB
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:13:13 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so35353795e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794384792; x=1794989592;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KPcuJ9giKkrlerWYcNE3whtnD+oxjr3nl+OlK6HR6lc=;
 b=VanWIAskk06J/lVnba3pHSf9mK2TYmzheXpwxfCMFRsc+j5OGFE58B1Gi3GNVjAH6B
 xX7yKxdYwe1SGHSixIH05OCKxN5KbktEB81IB+lK1DXdg4aSLYsMA7Xe3ixXBijAyBUp
 RI00Pgv+OyKp0M8Q6WehugKEkGILTKvED3CAeyxPlHXW9B/YE7vLdHVxsO/CED9YRF3M
 UgLWNX15rSTlCZX1HfepNLkJ8tpet5K+BvdRMqmmzw8Jt4D/5K7fV6eso4UMdts8/c2h
 IkaB8zq+WsBFhZGy7U/XBONOKZfFa3U6JhpR+0XSVPLM2aBlBXwBDKyIKJFHQV3aJjAS
 IB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384792; x=1794989592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KPcuJ9giKkrlerWYcNE3whtnD+oxjr3nl+OlK6HR6lc=;
 b=G+Op+tyyQkxqCxzt2p+NioO4UoFixI0DtitYipB6VWE+egpFApXiLzR/cMODwFm5SA
 IzaTPAZZM7H0SX9OLYbiquq7jLDDkgr/QLCryHDFw+wfDNONQ8vKNy/Y8iIc6iZb26Ek
 4uLdcp0iH2L9UAiAQbk7u1bOjBTa8PSHZJmMR7CybeY/CFAlR9ZxgYVo669K4ZrNS9y6
 cNiUQzc+VN+FXboq5tc05qj1ozz7qq55HwXm8EjMX8hSCR5Siis6KUZzOfo7Kq8dMKY0
 0b6A2lyy50G1RDkattbS7VUrGhMy+CBFyZ2QRq+9ZdD7u9/+iXzvsOyI7sQKAz3EhmS+
 vKwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHgtcCcaF9cx3ABMg8ux1s5p36XH1K4NpNGvYrC8z7UVKTQXQwMjWplwbhelR4i2nz/LynzOefyd5I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+o1urK6JyurfRaKhS0swKiOfOtcxc9Opy5OX5XDJp5MeCr0ICT
 AH2R29FeN1wpcA8XZe9ZpWaJo8aZNx8pfLPZkQOhSm+hq3gCTiZl5YeRvmlE20CmGUA=
X-Gm-Gg: AYBFou2EwN7TX4F2sWEVloCtuUF3irmMWhpXWkqoJsuEkzNFdNZ5D4qpR8iVzgZlqa7
 tpI0vhA2L+NKm1Wy/YYBGg0wKFS+9bCToK+H/Ta3mLwRkxzZid/lpr8naLYEAZhQfNUaHcgJiUX
 N1iPwKDL4VsaRjBJHc5kw1lWUBarzVN8RMnzgjj9ZgI033YpGkCQ1tjFVXM4U8B3JsDCVUeTvm+
 CFnhb0dCAvr0LLpwWbVLUv/GDdVSRyYPTkwDf8E/8nf0KUpU9hSJiA7ctdQ3L7MdQTmvaLk5fvr
 9BGYMi5N7Ac0Oiks9myBzd0pHT0NJNiWvteErber/Vkl+0lPHBnRQTdxJZFEFqlmPfe1P9byfgJ
 sBRSwqZGn8k6oZJPdwA6Ouwq274ukyAAd1ckiFTLr/Gy9HN/x+nU+JKq2ag22zpeDPFSedwHNS5
 2CGIQg1a0ORB7Xw0VHHAAJw+wIdLJ/V5iY1jhmIUb5Httl/rYwt7fGJ9/F2o/1fUvIve9fT8z6r
 L6x+k22fQsSGovYCE7s8leiz5DFB0l2ZzRKiV5UDQNlCNgFVXEtLSVxxsQQxD4SJ7jHjGLi5tMP
 bnIrWOH61xeOdsflQCbXEKxGcB2D4guWyVBH99bfhR11tnbB/3QUeBiaz/+JKpwaL4BBg+EEfg6
 ELqh2LGemlQ==
X-Received: by 2002:a05:600c:8b24:b0:4a2:a9:ed87 with SMTP id
 5b1f17b1804b1-4ba0938a10dmr25548105e9.19.1794384791851; 
 Wed, 11 Nov 2026 00:13:11 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm113233815e9.15.2026.11.11.00.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:13:11 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Subject: [PATCH v2 4/5] dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms
Date: Wed, 11 Nov 2026 09:11:49 +0100
Message-ID: <20261111081150.950272-5-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
References: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the vendor prefix for bytesatwork AG and add the compatible
strings for the byteENGINE i.MX93 System on Module (SoM) on the
byteDEVKIT carrier board.

Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
---
 Documentation/devicetree/bindings/arm/fsl.yaml         | 7 +++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c8290a83205b..e4be6fdb5808 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1555,6 +1555,13 @@ properties:
               - fsl,imx93-wireless-frdm   # i.MX93 and IW610G WLCSP (Wi-Fi + BLE + 802.15.4) SiP FRDM Board
           - const: fsl,imx93
 
+      - description: i.MX93 boards with bytesatwork byteENGINE and byteDEVKIT
+        items:
+          - enum:
+              - bytesatwork,bytedevkit-imx93
+          - const: bytesatwork,byteengine-imx93
+          - const: fsl,imx93
+
       - description: i.MX93 boards with Toradex Lino Modules and Verdin Adapter
         items:
           - enum:
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ac2f54adde73..95f386db1d01 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -285,6 +285,8 @@ patternProperties:
     description: B&R Industrial Automation GmbH
   "^bytedance,.*":
     description: ByteDance Ltd.
+  "^bytesatwork,.*":
+    description: bytesatwork AG
   "^calamp,.*":
     description: CalAmp Corp.
   "^calao,.*":
-- 
2.47.3

