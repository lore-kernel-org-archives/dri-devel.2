Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A641606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=E4qD0tjy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C075510EC6B;
	Mon, 26 Oct 2026 08:36:45 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A9610E86D
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:58:20 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so3501315e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918699; x=1793523499;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0eUvvq6t18C5RgJIwzh9hbYdswBGCIE7/yO5zUERv48=;
 b=E4qD0tjyjD20ukHDR3f2UgvERJrgnMefOtcSyarRXBvHo+5V+jD1qeBP1IElVAj90G
 zWDOV4A3wLusWwx4m5kmfzFKWW4I7OE1FjOUJIxPjNdJGRG3kUIO8T6unO6CgUoG0Ca4
 Gy2+fCYAD1mXritZJiYIum0B3e/b5KrZDIdtxM17Wb5RUqUBz0gaXIHWgJqPknxX7m8U
 RRWkk5r3KVAIO26cEcivNSo4CnI899cptyybtAG3+l6Pt9ITU0uPBqYAXlqoNc1QEMN9
 tbNrHhzInRN0gKcREMg+EVMuiYgXZRyzKjGnfmdHflR1YrkTxeWopIKo0GAxHM/T9d5l
 YTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792918699; x=1793523499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0eUvvq6t18C5RgJIwzh9hbYdswBGCIE7/yO5zUERv48=;
 b=ifd+AhEGY9fGPulSFtN2sej/oD6Qqdn1V/jjwY7VghwGQpLEU78Qzbnt20WGgFrkFn
 tsriyEuvn2StsGiRTScHFRdEKcqUMt8J/tQV6TQi6giJnbQzzVV6dBOUOAOfHb+R/cNa
 LEcdDtd0HoIdKgX7ZoANXf/XDgipmk3ZLRlKQ8LcxD3duxgPpjAZVfhg619kpYSf2wTO
 Tzxt5Ix18i+WNv4zBa4ZsZI0MQb37syVC7XFE0HoV9gDbRJzBGfqf4uNK0304hYgQVfi
 kc2WWxNJQmDfOIJjaPgRrF9yoV+rGFgNOMlf4irBZ062mIEA48WAPrbNcsXt4ikaNTBk
 5dTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMGOqFVF9E8CssoV8XHPJWicgkAZ3iGWsxS5usJmYy3AOS+6CFUwujYJH/V9wEN9WNYvUdijVa5f4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKhSSzFQJpDOKR5ELbnbNXycLl7CLZ0eVwG3t4YJQ+f0FbXYhUj
 nNNvCdwGfYFB1wjv2asx4fm1R7ckeUPB+STy8t+VaWTfxizHGOjeMe7PlhXbp7envo64TJCKKVJ
 lnrFwaVo=
X-Gm-Gg: AYBFou2Z0ZWZvXXxoj3uw3pEQDpPu2+9nIhw94bqRUN36yKptlCqQ1es0r2tX0Xt70Z
 QRGN+AAbVnjpQWj3KpB4QUqy9S0PkpWCIL5N7z+KhiDX4RnFVKqMcocxLKoagAhkY6/DKo4wzAL
 AAMznhKZnXm2x+fpmw1fe9L/spi0VZQwMZ0XQn6uH72hie6UXhLQMz62RvsBoUV7Oqiifed/xj6
 qYgfiVC7VXZlFiv1EvHrzftQGIrTiyKuxl0nv8G/4uezrnJLHayh/QOJUeP+m+m2CBy+w3gDv6F
 lOiOdEOuq04LchDoSnuqQZSA6gKPTuv5fFYcrHuuWkw7bj3zf3g21XA7G134C+N/LmKdhUmM5P2
 4SKIcZT22gqzrr9I+OxlAULR+N/0ozm4tb73SKUYOr6FxrGGum7Bek0bnamkP/a37Yzvuonl2RN
 0AXk/9yUCeNAAXjfVeJUMnit8dznCfZ7zY5Ea2QcyBWgPAlLv0E12T1V+g5cu+QyTLe2l4uFF3a
 TPv55QvU3FZoogQovzARD3XP/ixfdX8CvFgrLG+q921ddeik45jHnOhxXeseyrr3wJg4Y16hJ7O
 BSsrgyBl/KTgV8Dso+DJUJiMspB/biy8rvwhb1A0Mcs3vyaL7UTE0UaMlTLgmBZDCwLlVJAjaBB
 l0JUZNeC3jHOsjyMUo9k=
X-Received: by 2002:a05:600c:5248:b0:4a2:150f:15fc with SMTP id
 5b1f17b1804b1-4a35ac91242mr67013405e9.5.1792918698790; 
 Sun, 25 Oct 2026 01:58:18 -0700 (PDT)
Received: from localhost.localdomain
 (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr.
 [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm9094542f8f.17.2026.10.25.01.58.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 01:58:18 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 1/5] dt-bindings: vendor-prefixes: Add HiBy
Date: Sun, 25 Oct 2026 09:58:12 +0100
Message-ID: <20261025085816.60405-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025085816.60405-1-olivier@mgcrea.io>
References: <20261025085816.60405-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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

HiBy makes digital audio players, among them the R1.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..b5bb11c20471 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -722,6 +722,8 @@ patternProperties:
     description: HEAD acoustics
   "^hechuang,.*":
     description: Shenzhen Hechuang Intelligent Co.
+  "^hiby,.*":
+    description: Guangzhou HiBy Technology Co., Ltd.
   "^hideep,.*":
     description: HiDeep Inc.
   "^himax,.*":
-- 
2.39.5

