Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD0606B9CD
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=xxdHOm2m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A6B10EE9B;
	Tue, 10 Nov 2026 08:33:49 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB2D10F490
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:47:59 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so737153f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mgcrea.io; s=google; t=1794246477; x=1794851277; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g2yTl4PVSyd+fgLTgPgtlO0e+H5KFW8y2uBPZ5q/jBQ=;
 b=xxdHOm2mj8T1R25IlwFwl2M0iHZeeGIeQrXOJzFm8CtTj2BuZWK72XmTH96lHi3dAM
 ricND3/EUlxGdpmA+ZVG9J+AfSrivdy0XqmPlu77299wTE9JT7okOdvvmPDjMn6rGUUs
 /dY5+XUSZmH4FyplSdkAaUhhF2W1/bo98CSBSu7Cx0u/BwZNXW5Z0qvRjNy041y+xwVP
 r6PDNM+rHEedhT60xL8F7JrBKa1G6QxFIM+pXTpNS2/ZA8hN/vCIi02VL7KcjYZ2SSFs
 AFkkEDEk/s7NAdxJx3ybkLbMfzturnpOg461snjhcn0htkEh+sW88qlfh5T3QITVHIR3
 wUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794246477; x=1794851277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g2yTl4PVSyd+fgLTgPgtlO0e+H5KFW8y2uBPZ5q/jBQ=;
 b=tK+w5+aYl8VWcMD0fqoYyrCRXeNtuTZLsiHpKLd7ZpR9GrRGihrzrzjEwrIu1tE4ZQ
 qguK3MZ+qYy1zK+bCxy210e8yVhTNVtVLZ7YAPtmG/MBrZMFfGrsOdI0DxHuLfMMGT9f
 sPgIhy6Cq2QS5g1tAEcpoNKssUPFYNRu3LE5h36+rEzpLNGlqjbQa6wF/ZQKkFGvLg1D
 41coIAOyEeYIELN5/NYTKbXX2cvw8iulyjlmLrkoXDoLl1fyW/Z6T9gByHDbfkVNchd7
 Tk4hjn+yvL5FlYI+dplFCknn+5fMiMIPNScyqwuYbHZstZ5REXvIf4DJSBayhZ8l853y
 MIiw==
X-Forwarded-Encrypted: i=1;
 AL+hErHU83mKGwxZAaiG/VYado3KTRS0oOopJG7HKDIOQDCY3oqKlswfutKp14XUkT1N/PctQH/t1yijAKY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+H/FE8QAdfD128RzKf8IKLCUCUkFs5NvqL8jygNVq1Om1NHor+
 XT8w+rDDEo+VRnsltmxQB6DZzuA/RtQnm7GAF7/X0gDBTVyz3aSCmcUSi5jM24oWItc=
X-Gm-Gg: AYBFou2qg1nnZliQ0qL0ylcgvHWLGS1MwO5zbygSseazA9WwZz9r4gXunntP6iWiCFc
 Wy7u9dX4k/JF5D5wuh/yFR4HxkBgPaHzPVLcaF5ZoiiAb0KTaPIsMKBW9QQyQ6zTCJSVAEdMryr
 G+FUu9fwgzzz7xbPROzieqrIBztCW9NbjZfUt+QK+/GbUsDoWUhKQGQWgilHbvIib44HBy5pRFe
 PxARadsZBr/C85n7qO81a0ZPiNYOwnyWhYeilaJvohMOTAmHHJsNUDqR/OEqVHRObf/Bd4+S9RF
 vSyTmIRUanAKsPpDVLBJFHvDAtU6sAfbG9HSS5NEkeXu9GeLX4J50i3aihA0oVgv2pNE7IiXA+U
 jrhW5oyfcxzpiu4z1P6Y8pOhnD6v21FWOnFaqa5JeR/Re43B6AQcFgIaOQavP26eh0KpT4GqAW/
 /7TQikoHxxeEC6TIyDqLVCwxIiBw+uKonimJbNP/q4wTFVO4wGdJiahmjU4TwtJ0nWLXvgI0u9N
 vrJ5vhGP7TTZ7/2DedQ1fH5XdBcooSjrkwUyb1bxwU7S2fxafIQyuoxrCNhZGnIwxbDD/5vzBkq
 DfZ+Yf4tgq/NE3em2COz3Ds2tB0qXU1L4FOOK7x8pvLiZAf+AZL4Mm2ypRwftt8=
X-Received: by 2002:a05:6000:40cd:b0:491:4e13:fde5 with SMTP id
 ffacd0b85a97d-4982d03bde3mr421828f8f.8.1794246477535; 
 Mon, 09 Nov 2026 09:47:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:e834:fd4d:2ecb:b787])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm167322f8f.53.2026.11.09.09.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 09:47:57 -0800 (PST)
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add HiBy
Date: Mon,  9 Nov 2026 18:46:36 +0100
Message-ID: <20261109174640.96951-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109174640.96951-1-olivier@mgcrea.io>
References: <20261109174640.96951-1-olivier@mgcrea.io>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HiBy makes digital audio players, among them the R1.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 7602034374d7..0bbab57d6c25 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -732,6 +732,8 @@ patternProperties:
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

