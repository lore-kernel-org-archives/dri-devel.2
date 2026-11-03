Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA22606EEA7
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yaD6qdqO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7944210E7EB;
	Tue,  3 Nov 2026 11:05:34 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E1B10E7EB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:05:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso26791905e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793703926; x=1794308726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pJi/n0AaKQOOTYBC/6OtkfE66KoOOzcdQt8wdIV60Jc=;
 b=yaD6qdqOyTpmCIrc7bHvbJG/bNL9iFz0RG1fFssYaNuSAWyp34PhzfOdhU1tZP5yDC
 418xGVcULfCuKSky2Jeq99kpg26Xq9NgvKJTEaNbU9Li8GIkld1J4YJE3YrWPb+xmlbE
 S1c2GuXPDm1ew5we7aS3qPpQhDn+4qacNUfH8ta8IN2vIY9rFLdEGZEY/ljdSYXn3Mac
 Q+pKTQXXFylX394IhHtRNO49aSXP8+4xUwRZKO5gCBbYb4VaUUYDPwz/gTP4ux1Mk52p
 xiH9jHbraptgD5YRzx0V5mf2iXaMDTtRUh2pDaLxU+nA4iNLSSJ0+tPPXi6sTVnpZz9e
 onOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703926; x=1794308726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pJi/n0AaKQOOTYBC/6OtkfE66KoOOzcdQt8wdIV60Jc=;
 b=FT1iIphSjQUc9ry5B5CBZuKPAEkop3JXzAnLGjhty9IthHDxPe2sFHiYoZ/Fc8nASV
 mxgc2rFQxzzOnPIp2LU+ZDYMZMf2HgAA7bcbzRGReAx+2w0V915ODXckgl5IijLf1WIn
 ZeGzZdhzCIX1vCd3BZVCQwi4kB8h6CTAUzgm6miFI6V/VndqZ/fOzpctoNNx2xuefCAL
 K7TYna0Zj6co0acwYnaa8XCCUbGPpduM+oGYcpcw1RA9+L5PR7EIgP+96GoXkYIamDr+
 SOxQNncA9S516Q3N28RUXCsKY3N3g7RRVQzj4W/bLfORg2Kxv5B+3Op1p4sMSnwha+sL
 N9Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydOlVLVh945X2CZZbwlcdA+W0sK0ArGF0t0L3igGjmICLtc7EsMnc5Q4bEUwOa/Bt7FlpgihOD4xw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ic3mVtMTzrpP2maLN5SaECwyHT9liIIZsNXytPHBZlUImxJxP
 2e1K3Augo7Az15kFqiZhd2+p9DLHyc4zNSd+iIGIZ6UMV7V/2L+XI2/b
X-Gm-Gg: AYBFou3GKpc/oU8GZXMH8rWwgToV7uK6ZATh8GAzrz3kxJx65h7LR84J6ciVT6OwHj1
 FirptkTVYD5PgfMJPbl5UC7Z5zDJ8xe38pdaiLdTCjFzzjle92F2FCexwKZT9rqDWN/jvZiazYb
 8V5Yx3iAt0kuOuLSY/aYky4oZswkHol8nIW9JB0+QRbLeGR0KjdvKuEn2PpZGNHJiVnpPLGyaZ0
 idGh/9lxI6u2OmtbGQKOTUKf13Ei+UvaWbaPIANMt70zOXKcBzqDXKjEEwpgJdvd/dj3HXOUThX
 Av54CEeQ0SG9ZXS2YzYQj0GQmHbehFhl0wSS98VNLiGIE7dVP1vLXGEGQV334BfcRfFklISHEEH
 i8cVOc+EOvpVFlaUIzoHq2AoWhh+ZIXbxqJSatsAIpZ0WTNYv7RsgBx9Y4I1i354CFFRYZfaaiQ
 n/55t7k41tJW1EaKcPHXKWkrpPZKtsK+JqR6dSxwQe3mjdAW1zppzhUia8KiOrP8U7tt/YQXVrF
 L2LBX0M/Uvl2xoeYCRITtsifuYHsmD+5uOkyQClIUAA2S8Q20dGQU0ovUlzljXbU4gnuYHYMkmi
 0PSqHhW4f+9RaLWm0s31nWQM2vToLan7rT40lE9CNgCP6XcZltbvS5OG9AWPkM6oNYTTPML29S5
 o37lnPwPH6ftfqL1mLtuPA/p9mAobqqbuJCZrSE8xMX9hBWI6jh8N1EjyHjbRJ1DqSiA=
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4ac187a6960mr289278915e9.27.1793703926209; 
 Tue, 03 Nov 2026 03:05:26 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:14ec:7986:30c8:6bc6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm53218155e9.4.2026.11.03.03.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:05:25 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Igor Reznichenko <igor@reznichenko.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: add PocketGo
Date: Tue,  3 Nov 2026 12:05:21 +0100
Message-ID: <20261103110524.2812831-2-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103110524.2812831-1-romain.tisserand@gmail.com>
References: <20261103110524.2812831-1-romain.tisserand@gmail.com>
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

PocketGo is the brand of handheld game consoles such as the PocketGo S30
(Allwinner A33).

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..f538e6a27ec0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1339,6 +1339,8 @@ patternProperties:
     description: PNI Sensor Corporation
   "^pocketbook,.*":
     description: PocketBook International SA
+  "^pocketgo,.*":
+    description: PocketGo
   "^polaroid,.*":
     description: Polaroid Corporation
   "^polyhex,.*":
-- 
2.43.0

