Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D6606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOz6Mp/1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952DE10EB64;
	Sat,  7 Nov 2026 14:28:20 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA7C10E521
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:21:19 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so3618595e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 03:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793964078; x=1794568878;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g2yTl4PVSyd+fgLTgPgtlO0e+H5KFW8y2uBPZ5q/jBQ=;
 b=DOz6Mp/1tpFPsbO6DedwzUgaAF8eEW3VmwCgbaaadlKLh+5DAN+Z3o+33grZR8XiS3
 FIRgNGpe4uvbG/kxKh6y2+tWswiEVlZn8yMTABd4hhjV5SDo9FzIDFWRdKZar1TXe4I0
 Z3J0J6iKgQV1fOrStLg2Ec9GisjbWLtwpBnuQf3L74v5/fRY38tjOFvkbjkVsuzDlU+5
 r+53tAIUrkDACPTBAqFwMDQFWCLf326c94BiPmdehcmz+2ge1kBLi41euWLmy6hoC/FN
 eJLa3rrLQZKi0D08ucLRJeqzYZ+B0rw/wAdb3vxXdrrkkCREWWWTw0xIxaljIaF6C6s6
 jxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964078; x=1794568878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g2yTl4PVSyd+fgLTgPgtlO0e+H5KFW8y2uBPZ5q/jBQ=;
 b=zjFM8c1Hsbhvjnm33Vk/hmT0m+3c4dJVymZqTHV6NQhfZLJCbkvT+uBu1QKQ85+PN/
 jyeQu43i+++DDBdW/NoP/5yXeACRoPUQV8mJErL5N0pVD/XCQ7Vxbh4pKDwFJW+fsFD2
 XfbEUxOgNk+LgjVDk3pZr9onScuCmphwtheosTIQnGlZjPcL3jkVj25bHb/oXarUuT6K
 sjjO82nmX6P1d9Aa9uny9Znlmpi0+AV4x7EcoidP5pr6jBOrR7/NTaqB66JqfNURDdY4
 i+G/tZ2YDaGeCXdI+/unZ952D6xQHn81nDFaBkvbyCTd6A2x40XQNR0mgV38zSee3gjr
 k86g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu3zEwHtAmiJBoIpWlfGnMM0IQJX+Qvoz87OUS142lggWrrIhEHyRUl+7PczE1wUG4AzLgSE3NwZA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Vo7sKrWnjqaveocOmPh2Zf4I2QwJGVLvT2KvfPG3oOhv4VmgL
 0YJnUHTtbOMId36wcVJw2NtuiWkiFnfIjFw3p1iN6c4I/S56AhZmc8OphasmPZlwka0=
X-Gm-Gg: AYBFou2+JDatVBuonhldqx0DqCUJ6y3Pu743CDOCAV1/6H1otApNPsvacN3evQyajVp
 lU4pi6kZ2qPZLmna8EfSdA7+zAZkXpbrrpWOmehXb3LyWcDe8b3saVwzcZ1VY16gO7Gmk/6PIc4
 D9uKuDiBPjvH7ya9+DK4MYI5jkoK90XK8Ntg4lv2XDT+/2LEWdsz+WJ5uUA+28n3E5D4ITEJEjs
 KdDsJZozeE9ksIlDUkaaEFSRej9dUUiodVOKX6g8Ms5kTFiada1kc3/M4VFHd3DaKTu5K25TLwL
 aTeI8ffIXQzkRHYDhET12VSu4yOUyGdUWYivJvqRRt6EYXwiJg3SYnwG5L6mpvh8jj0OqlmmqM8
 to8ZoLZFx6CLlMp/+2Bipj4neL4k1CS3LkvADTHaXgWIwDdRyWnDItEkGo1Wmyj5eoFxANK+6Tw
 ZpOQBkHxUS6QnMKnnrCuv2Ew98lW/ZqVnT7ylNYPwmxM2SL79b26FgEXjLA/wbXTtXw8DeOW72I
 7JdJ0Z6X3+RrtSjw9mpndWrecHCoqX8bJJU240Wx7iA7bCXi7JYhTL3h7WtGTXpmuSuo39gb00M
 v/bctdl9/9bzdgABwiqYYfLlmD40pOFEX4cQVnrzbb4bp0RD+ROKLxLncsh7EgM=
X-Received: by 2002:a05:600c:a015:b0:4a2:1612:6367 with SMTP id
 5b1f17b1804b1-4b6df11d637mr31306905e9.15.1793964078175; 
 Fri, 06 Nov 2026 03:21:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2028d9bsm102404695e9.9.2026.11.06.03.21.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 03:21:17 -0800 (PST)
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
 Olivier Louvignes <olivier@mgcrea.io>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add HiBy
Date: Fri,  6 Nov 2026 12:19:56 +0100
Message-ID: <20261106112000.1612-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106112000.1612-1-olivier@mgcrea.io>
References: <20261106112000.1612-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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

