Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F45606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3EC210FCCC;
	Wed, 18 Nov 2026 13:47:15 +0000 (UTC)
Received: from mail-dl2-f6.google.com (mail-dl2-f6.google.com [74.125.229.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F37610F89F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:47:43 +0000 (UTC)
Received: by mail-dl2-f6.google.com with SMTP id
 a92af1059eb24-1b3a6a69818so83525c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995262; x=1795600062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iYdl6eyKs5fIOVCFa3VvRxi3TSrFPXOeEaR5IAbyi34=;
 b=BfPR6U17w5aNsIJNFKjZLdFi2JtI74WZTKv8L404mwXWg1yAAKcmfPyLn6ClnH1FLw
 xodgeSp8YhTh6TruwgybFWl+fjeR+ca33DttZsmZcYfoLUqQWtAZyjR6cYAqiJ/xr4Zx
 /y7/95QGknX7mC0dlzj2FDQRslgZOLVSZQNnZefzn5ZqbetA6nGgFsJYyevp1ItI0i5X
 As+fo0fBjEvWVTJGl4HZgSaQEl+QzcnDkaTUfdlXh7Cdv8IvshAQF8qgxsJtWnNDSBUy
 S5R+IWTwjTKiSQ8BSCE6LJtNiabGMpVCgQoilWIzBLDCfk4unv6kCEN4/4rTwU4nxBio
 a5WQ==
X-Gm-Message-State: APuU4Z+4IEnZnQiOTYpLc6+otZaoX+k4d6yP1NbH2ktdTxrIawsn1NAP
 NgXMPVMBDBWCmcjSmel3HKvWQb+Vr/4s+AUs48BM+ahbZzyBTfXKbweX
X-Gm-Gg: AYBFou2r/cJ83RhbIHACiKCK8zuqQAeT3+2E7gzJrlEEVcGSAe7bmWG7K5r+VVWgPxY
 udYuleMzOL2HdahSnyVZjfKqwjoJM0TNZC9jiuqQPZ8Q1EsGo+1epVP9BxnJS7RplxLKoMBySdP
 9lUvW/WZ1cn+7Vy4+ByrFr14NdDd2Pv48bgu/rGQpucn6WHQYfWCvlTHlDd+fsQgFrqyTEnnK8d
 V01I4yM/SKbYlky93jnhA1RaR22OtiWoQKgzaw6ytzhICbF8ZS6zhHmkY9A5tOCoxcbTCWiAlNh
 XpqCkr/uKzEUuTWHFXbob9OIr1kv34vGM/F/Vr5FaZvIHm/xA8JcneJUC7J2qxyzW2GJhR3ajjw
 mMoz0EehCmFc0HFoR82RbCI12LTlC3jIUp2qjxYycY6PfWpdNyKUkzm4UYkSBTY03calXHPhR/P
 qvTdm8HS+8ZAbua36d8QYFqxFlOgYgarKzrUrUQTZwzgOD9QDkcrCxH5naH2xAT72ii36A2F47v
 sIVSAtUVf0JMJ/JqgnHYHpp4YRQIbhJUHm+csZvrMRHT8fWfnrIc30gLecPNjSCLU6jyx/ANowv
 5/uoW3ArMjdlAJSbI9AeHAWohw==
X-Received: by 2002:a05:7022:e803:b0:1b2:490b:6fdd with SMTP id
 a92af1059eb24-1b543d0db8fmr2322014c88.24.1794995262495; 
 Wed, 18 Nov 2026 01:47:42 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784017sm5326510c88.4.2026.11.18.01.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:47:42 -0800 (PST)
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Shenzhen Industio
 Technology
Date: Wed, 18 Nov 2026 17:47:18 +0800
Message-ID: <20261118094720.110127-2-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118094720.110127-1-147148383@qq.com>
References: <20261118094720.110127-1-147148383@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the "industio" vendor prefix for Shenzhen Industio Technology
Co., Ltd., whose Purple Pi OH RK3566 board is supported by a
follow-up patch.

Signed-off-by: pjh456 <147148383@qq.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..9c149f327dd3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -831,6 +831,8 @@ patternProperties:
     description: INCOstartec GmbH
   "^indiedroid,.*":
     description: Indiedroid
+  "^industio,.*":
+    description: Shenzhen Industio Technology Co., Ltd.
   "^inet-tek,.*":
     description: Shenzhen iNet Mobile Internet Technology Co., Ltd
   "^infineon,.*":
-- 
2.56.1

