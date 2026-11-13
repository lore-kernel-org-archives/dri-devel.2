Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF6606C566
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wR6Nuj+k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C8011269C;
	Fri, 13 Nov 2026 16:19:05 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9004311269C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:55 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c445c95d553so218645666b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586734; x=1795191534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvB29j5CecJ6jZKtZEMGpW6S1Git4SOKTeuMF3fwTjM=;
 b=wR6Nuj+kDE14/UC66V0ArQYYqXMNmEXmxo4ntZbFiP5ktw1ZM1+qILp+CiE+h/9M6E
 2pwgxaEmsBVR7WUuPv91/OBWFuSPP1yCNlRqCD0ThWmi+pA8oroYOpao+SU0fTPsma5t
 SWWxZUExOjjCn/+Rpakd9ocIFpvxQ+KJSYMI5+Y8t1EfiXpSzkviNGzOGtjqXvPofHmM
 t3Q+tLZXfTsW5C9GnX++8JKGOf/nenbQGjEecSZwr9Gg8bjp2Y4fi8NxvDe8/nFuJ2nd
 iiHTrWRB1veQcWBywJxw9qTNV+mFpgNhfynlfwWWt12PIu15L8lZLUOuLzmT6X/fRMNT
 3UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586734; x=1795191534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvB29j5CecJ6jZKtZEMGpW6S1Git4SOKTeuMF3fwTjM=;
 b=VyGtLapJh24fmrV866rl9RqYJgFeq1/YF5WqdD0QkSDuU9R9KOXCQI4szkLSgd18Bv
 RZ3X4or6DTqn6GczdTIs5SmhFyvYL8K67uxOGsGbert77A3af/pj52AyAEtNTEQ80gE9
 xIrUG4eud29XAgwwTAC2sF6fPJQU6fzysQoOqY4vebDudzAnSNls1nJDdhtd/WAc1nB1
 8tpTV2DVnoRpuiqt0Ow2tDUqCwIQga/SffJzcglssrOBKkDpNpzC8GDkgVcJKxfuMfJH
 GrSUQaYO/G19fEk5yAo0qxWW4bNVsYwdNdlj/UtbhAB45HnOjcKKrJTRrZ+dDKhdRmwr
 YrrQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFo2LVKPI9a9shyAvJxm1Nmx7CUvElig4+RZQ+JvM6QPTicxuOMMyF/xLLK5wuMshfQPeTgMUYQ770=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+k1W/V0K9lOwS0PY3ZbvOLttrxR3y7XUrStDmEhtQRqExV97o9
 k+fRh1PmH6uAAmxTxqtsK1/zHTMvAeVhxxlMJX32hWiz6/sHBbyEHL2t
X-Gm-Gg: AYBFou2lqGMjdb6lz+HBzwhxmezmS6iKLEfYJCteWAbq0UJJuSArmDlRL8kBSRfE/4a
 ODv5c0VDrHIYM5RJG3VQXVgvE7hy3+XXSUT9LMeYHh7H+rJDZSCRLXb5MCAbEEqeormzP6Y+rEN
 MHBaZN/VTHX1EyL0fraczEFdw2ZdB3xtktQjDWbyLePmkFKh393hyH/gOjAzbvyVNd1zG/JdMvc
 xa0jrSKUMTzDI/RYX2Vm/8FGUBQgkQ+Bi2O3pEfdt4MFrdSb4iLcOLUAT1yOseK4NWQIiZD2d7u
 fKL+8W8zmkr/CI6h4tXJllCk3rn7aW8nlwNEXGp/fZWf1DExI+r+lFE2ebRcU+o9BULdxBF7oo0
 UdAkZUOV8W33ZLyepLv1x3icseMnt8WAwSb1LSlETYDFSE0m1Fh6/qiEVSxfSqB+wH88fe7glWg
 QuWtGv7f5Cji/7dmyl3SFMKlfLd3wuTLCxsnXpsfNz0B9wdBVBOPZp0xT5dscbXvxXAsSCzdg0W
 qgPHGIv5zwPqvJ0uy6kAok20Fsa35gO2glDJwYmIxnpgUk6cjWIaERLosaNAC0LOry4CxqQCeVT
 U8NCCxPdHmITvVZ7ReDgqh1xME9oHuLOzqrfwFW0Ia9kOhqkS7G2da+OPTeax70IE306VF+A6p3
 OM4MKkqkfPw==
X-Received: by 2002:a17:907:3e9d:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c5096396e4fmr271748466b.28.1794586733814; 
 Fri, 13 Nov 2026 08:18:53 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:53 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 07/10] dt-bindings: display: tegra: Document Tegra114 CSI
Date: Fri, 13 Nov 2026 18:18:16 +0200
Message-ID: <20261113161819.36847-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
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

Add a separate compatible string for the Tegra114 CSI, as it has a
different programming model, uses three additional clocks, and does not
contain MIPI calibration logic.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/tegra/nvidia,tegra20-csi.yaml     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
index a1aea9590769f..0c18ac81c6d6f 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - nvidia,tegra20-csi
       - nvidia,tegra30-csi
+      - nvidia,tegra114-csi
 
   reg:
     maxItems: 1
@@ -24,12 +25,18 @@ properties:
       - description: module clock
       - description: PAD A clock
       - description: PAD B clock
+      - description: A/B lanes clock
+      - description: C/D lanes clock
+      - description: E lane clock
 
   clock-names:
     items:
       - const: csi
       - const: csia-pad
       - const: csib-pad
+      - const: cilab
+      - const: cilcd
+      - const: cile
 
   avdd-dsi-csi-supply:
     description: DSI/CSI power supply. Must supply 1.2 V.
@@ -125,6 +132,22 @@ allOf:
         clock-names:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra114-csi
+    then:
+      properties:
+        "#nvidia,mipi-calibrate-cells": false
+
+        clocks:
+          minItems: 6
+
+        clock-names:
+          minItems: 6
+
 additionalProperties: false
 
 required:
-- 
2.53.0

