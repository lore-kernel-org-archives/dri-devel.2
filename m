Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CFC606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KAHDEfIk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8B210FCC7;
	Wed, 21 Oct 2026 08:51:58 +0000 (UTC)
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D2E10E257
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:10:15 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-398a0a87595so1924279a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792501815; x=1793106615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3wab0s6dhrFUkyhGEe3zCPYCSlTDeQMk/+nJqV0/iU=;
 b=KAHDEfIkAkHcj7TZ7fLYlDxwbN5RK+zw2//xzdilaCJwMH6043aqI7DaOlY37S7r9w
 fRE5UvByCwDoq6iX+eTPVnBwbbTM+vSZ8Y8ifzVnQzPDwRwgXEtga/saKP8rZ1x2mmG3
 J8LUDfAh/7n1SMQtrajTX8dRtpE1Rprff73S6vpkLcYmAAB0EKDCrBjWjnubrj4VWeOG
 1n7jpxlm9ARbqhy8yqJ2q0qe9TSu/w7wxDczT00x3ZcwmksVCkMHLGlHvwfqH/AL3SDI
 GEhgTmYDx7PdqsZlJBwRifkahS4OIPuJq4pKJJCWFKuc5Zxp+ZQoEA+WY7sUKbVjXC0I
 KimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501815; x=1793106615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a3wab0s6dhrFUkyhGEe3zCPYCSlTDeQMk/+nJqV0/iU=;
 b=oBZ8KdcKF8tcn5PmRI7tVVEAEFkD0US1toO15h8kMICaxBOeO3fJZgtRIAv3OImCZR
 Hc880L6LKeMTTlURC+s8MfnRYWMLWIt4bX/qMZCvsp0N+JKPtg52ai12dWnxKGK8mqV/
 pqA0R0+L6geZXBNpN8zgKkBwLBrgizOTJG6t8Pj7pEG66umKBGn3dtT89STOK8s4IN5d
 O2eNM9C42LkyjODDflWVIoSF7uDI1h1wyWt3Mcu5rkjdbjKXnCbWQF8abvHh+R/5op+0
 747DHCs6Fdae6NxihcCzfe464yM1ZKFTVcSaPixMHjRYhO5+FtLs1VibTtZPOZ/fXEX1
 TRbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6yZ7zpzI7Y1pZ/jZpUzb+Ewz+D9/WU3sOUSmD7mHUqsw+M/HYLuhY0Vps3qx9/mmPl/w7sImUFak=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLRo0cI1VQ9Q41KNjs/MJa+E4pEZIBP09nM3iNzo+GeCHGo1Anf
 RFvBDfYe9gG7DDUfq6oU0QU26XgZ9sCxE5A+zJNGCBTTMlyAgj4Qun00
X-Gm-Gg: AYBFou0ZTPBLpzXmV7s6oz/9EApqFIJkxWWVFg+VTNlUEGMiTdAdIA3r6c/x6oI7iYR
 EatlVpQt78W4b+Oe5DObVW5QKGS4ddcgvm3mhNWJA30GttRtYDyWXAQ8GrMi8u43Z5voIEBBzhw
 Swzl8+fTgDEQRNbUYWmerDLfHmJGu1kqAwEo9peHLapN4cb/dNJj19I4LFUjME5GPthAhUSmOZ3
 tmGLR1BJF27XfQFzOc0MVfZCAR7yzq55cSpb8/FysekyK8Oy4IaN5ff9Fq6dssh/jE8QcZPGD/C
 gOjKcuWKDXx6V1py8iX8yNJX0RFu6CF0ozXaGk24Kk9iPi3MXe45F5ZWCFCmmdN5nusWFLUpsDa
 HhQtLccbPftFkmTFc57tvdABPaDCQG3C5JkHZ0JuSBUs8b+Tj/ftgbu3eBWKNrVgaMSRtGnH83A
 Nhl68eCnFyA6cgUGNMRhQditA5TCAqtVWgKMbPn+rXoEDXLzUIljaT0IYAVORHe3tNg94apBc6J
 48Tv+BdlcXM0egkwiWNcQ6iRAkma6Oh+24RjV3n
X-Received: by 2002:a17:90b:510a:b0:3ab:1b19:78f4 with SMTP id
 98e67ed59e1d1-3acee279708mr10434846a91.6.1792501815386; 
 Tue, 20 Oct 2026 06:10:15 -0700 (PDT)
Received: from Linux-PC ([2a09:bac1:1980:20::1d3:a8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd3cc73c7sm10131496a91.4.2026.10.20.06.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:10:14 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, Lu Chen <tianshi12127@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add smartisan
Date: Tue, 20 Oct 2026 21:09:32 +0800
Message-ID: <20261020130934.2289011-2-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020130934.2289011-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261020130934.2289011-1-tianshi12127@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lu Chen <tianshi12127@gmail.com>

Add a vendor prefix for Smartisan Technology, used by Smartisan
devices such as the R1 (trident).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lu Chen <tianshi12127@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..6ad8d3499227 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1535,6 +1535,8 @@ patternProperties:
     description: Skyworks Solutions, Inc.
   "^smartfiber,.*":
     description: ShenZhen Smartfiber Technology Co, Ltd.
+  "^smartisan,.*":
+    description: Smartisan Technology Co., Ltd.
   "^smartlabs,.*":
     description: SmartLabs LLC
   "^smartrg,.*":
-- 
2.56.0

