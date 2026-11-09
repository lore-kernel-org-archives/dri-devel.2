Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36287606B9C8
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=arANNAwu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DFB10EEA2;
	Tue, 10 Nov 2026 08:33:45 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B688610E877
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:23:58 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso6416285e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794227037; x=1794831837;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ypL2grVntT+7ecU5ZYny6pR+6RbN0Ef9pRnQMEBx9Ng=;
 b=arANNAwu/22uExNfypmvzOStiX6eJUD6sbo1u/0p2ZNN+5/SJpWaAQ/RCxe9Tl/bBt
 23PPBPrp/akhVwf6yQhK5wUloKzK/pZckJWxAxayH8qRRib3eGCdtOBJByn4KtRZSWkv
 XFzJD4i/URSbNgC2DM2jfeSpIbKXJeWCrXw2DbBDqlWHLMNhoMgLq8Cjdss0LCfOMnkf
 rrEjkMksfbsQu/XPcgQun5amjpsVlKhViVrhhy9C570jhyTLvsRUOW8UOAqIuHkgMfHM
 GQxO5UzjDjWSv1ltH/KxvkwNPlN6lYaWex4Ik9oKmIQIsvGcIo7BvXEWqBnDkbQWDrtc
 PJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794227037; x=1794831837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ypL2grVntT+7ecU5ZYny6pR+6RbN0Ef9pRnQMEBx9Ng=;
 b=sywXfL/ahwfqm6HOmBlzx0Z65RlxwSp/ajlsX+XqpgWOhhv5x1DGYNDqxEwlGhCzlB
 De3enYAFGB1Dj7FztgckmmsPNvRyP9lAcobv51f2SRQCgTJZxJPVhNgzgvtgFfUf9vE6
 CcxhXRfBMf23NOc2jql83lPNwP76vxafsacHIlIL8Xud5sY9UoqQHp2aWRVTdMHWDRyL
 Xd4pcvtQapbPAyP+t5vOEXpXrYSBrQUje95ZVidPimMPZEE5b5KXjb6dTqwwhX4qEf2w
 +gDLC3P8HRcp9ibi6eO+HEIOj/WKZrnYjjU7JKKuJbeBg5jEqYgn7RPq0sKjAGReFc/Q
 YF0A==
X-Forwarded-Encrypted: i=1;
 AL+hErFh9bCV+L2k8N4OmJ1FHqZSa8vUl1A0LkrzYwpFuOWpZy1ni06jbL07fB6Txx3xS9LyojoJqmwmzJY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+161aWlB2zDs4VDjVn1p/8mRPaNp5e6Xw9XuvZRVQ1WPKpywAt
 zAmJfoDlIhScnvcGOcPv6AoIycrQwITjGYmcdnUeGSSgCD2+dOw0+Ay6VheDSVqfkSw=
X-Gm-Gg: AYBFou3bJbAiLhQabQzg2x+1yAZtvvxJDFN0wzDCqY477fw++UtrjdUuTIaAFpe+KUC
 /G9sGEn6rirfBkS38fLJBt5Aefjw6Lj6teg76xfSwlLTqesJMjmfDEyoOJpLNHvM2GL1+ms5ITx
 dWXFVH7UHFf4mZlUBc72nsgHdfynyJ1SN5L3+8wrr3qHszL08qfWIC9z1+MM5Nr3PcFlyvqk4C8
 sSIUe4kJd414Y0MBvuvdneNWfEq43MH0iRWiWokiuuzQ7wZY3nAeGIY6t4mjf5+0ZRN6Ab5NfF3
 CA1mV14NUdPG4ZXd9LBYdxd89A9CvkNqbnSqNDDD4exGDo7kf+7VjYR//URbhWUTdMwvVGbDB1E
 YPsRV45ExbaBhU7DLkue4xRc/L0Ci8uKFvBokq0Uijzr8LCAuqs47xab/ZC0tLBHjVtuXyerr2z
 w4zAEzLwDJn5N7pxUBUGDDIairwPIQnJhFYE0bMgTWlwfs/L64DO4vbAqSt5+7HCDYkLY1Mycps
 /VnxkDq6rbrTG+eZKDts1d+lPHMjUzC1oybA7uNdE+Y5xEKLWsywrZpfR5VMEuyvar7oioM0QW3
 bZvT0ZDq5eYFfoMcdpRt0X5bs/kcNribTGH9g1WPS9EH8UH1U6tkGt9tjmGxM74mlpzrEUONu86
 1VzMo2yI95g==
X-Received: by 2002:a05:600c:3e0e:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4b963c75b42mr68468965e9.21.1794227037216; 
 Mon, 09 Nov 2026 04:23:57 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597652ca7sm10500318f8f.39.2026.11.09.04.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:23:56 -0800 (PST)
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
Subject: [PATCH 1/5] dt-bindings: display: panel: ilitek,
 ili9806e: Add Youritech ILI9806E
Date: Mon,  9 Nov 2026 13:22:46 +0100
Message-ID: <20261109122250.720757-2-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
References: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add youritech panel as a compatible

Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
---
 .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml      | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
index 2080d9e0ffac..6f29ddc1fd09 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -19,6 +19,7 @@ properties:
           - densitron,dmt028vghmcmi-1d
           - ortustech,com35h3p70ulc
           - rocktech,rk050hr345-ct106a
+          - youritech,ili9806e
       - const: ilitek,ili9806e
 
   reg:
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..ac2f54adde73 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1979,6 +1979,8 @@ patternProperties:
     description: YSH & ATIL
   "^yones-toptech,.*":
     description: Yones Toptech Co., Ltd.
+  "^youritech,.*":
+    description: Shenzhen Youritech Co., Ltd.
   "^youyeetoo,.*":
     description: Hong Kong Cybodev Tech Limited (youyeetoo)
   "^ys,.*":
-- 
2.47.3

