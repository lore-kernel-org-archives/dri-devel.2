Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB91606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BWxbpDst
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEC410FB95;
	Wed, 25 Nov 2026 11:26:44 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4556B10FB97
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:36 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so1260559566b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605995; x=1796210795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0FXQy5JXr1wYq6VfY5iDrFuAvChplEIolQ2bpb+3GU=;
 b=BWxbpDst4trFKLf7cVjRQb/C8LEwwl+tnjXwPSlTYiFwn7AhFtP3BE0o7c/Q5k5sLC
 a/pFaiRpsi+QryNE3K0ZgXAaBeWJheU/JSPXjTU8kZUn4NM9/uzPDiUM29Mx6Mvcwspx
 Zu2iWT4z5E3/PapkF1X/ml/OQ4o8T8IOZcVLC2IyY/G64u/o+j2Yj5aoLPNX5OuMGeFN
 p8WICwZPgs8WzOXhLTzvXjh8armzUpaurV7fPJHns59qeH3l7S+7AG7WUT57+bIjo/lI
 Gs7rXg5aOs7XdeRduIoTFDRv8YcfZFs/8ZK1090R3AvZcGTz3/2RXCPl8aBp13NXapwd
 hIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605995; x=1796210795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v0FXQy5JXr1wYq6VfY5iDrFuAvChplEIolQ2bpb+3GU=;
 b=hpTiegKQxwUvapEf6qx1MMdFlhYvCpWb5Eo5Y/bMoyTjojuN+2NCJNxbPA4OSNgue0
 +ekqfo+oYYjd4a+zuK5+wJn3+1t1rKkNVru4Y9iIH/Nt+D0JzLVKLzQc/QabJtkzp1EH
 o6BgYH/XgTBotifsjxxZ9Fs/puhRFljys+iCi/HJaSt1MnLV6TUtx6oej44w9tyyYIeT
 Hfnshr92IhmJcBTBPUDj+nC0rgKF7c7MCsEJHCerc+MyQ8vQlyZ1ll+gemNksd1UWkUi
 E+YHET7C4qgnLcEFUkM7uvm/si62Pt8JC3NLV6PRwO4caGEk+TiuNOpH0CIFm7cKOGRZ
 XuOg==
X-Forwarded-Encrypted: i=1;
 AL+hErGsnw/1QLiPxSDBo4LIDoZz2SL1RkoxlYI5ga/Oxs9RqxhgUMXat3XvZKDe7milmdbtOUNQxFUPXxw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ewSqMcNhnf61sZa8BdhJJptXE6OL0padniLKeOhx9i20IU5dw
 wG5w6DL/LcQVbHFdsPAvp38hFx4XwTn3uCt4kDjAiGojU3Hixrq8P3PE
X-Gm-Gg: AZFdTZcRx2D0jBQ4I12iwfjSOxVc31qbXNsRIRg9UVCHh7iK2S83UN86ZOAR3DpCK2p
 ksGahTZkBHaQxinKTY+exnmPB4X6cgQYKEGLXjMEO5k4h07vndeW5EvVUFBeEolKGpDJRuGJEt4
 6tDSsHqTE55egLKbwF3QqCauF0Yn+E8Ro2OzPbHVEMnDVKwYHd4+onrhYboVTk35S0ooRMQATy4
 KwvpIXzVhsU2RFzX+tqgiJWlVxjb2lCab8CzcYeeBG0hcfs4WE8cgATYtIB/pvxlsLEY2syI6l3
 nQa8SBVIOrzjRguGv9XURcNX7QT86zPobYoigyioi6hanhaWgc2x0DBXJF7tuR5PaefuAtVjvkH
 96KyXhywuNEyQxNcSWOX9om0mlj0/LncelQ28EzjP3Y5w1+q4Urhhf1EG0SvVRmSvNwPEerbGt+
 UjNWdcY0CickQ/2a4cpJrev4Nr8BVyLKJVCpHuZsGZqRMbrMbw9kH+0BRyrB9DdmHw4kV0SwEYX
 nR8fWwbUUY9hd5uDvDk3nIdfPE/+JCyOAT4YtnbR0XArzNkH4N51DBtyQwWKF1T7oAbh4XwCd2R
 n31Z2mIWinyPHzfl1lWIL4WyD+aozETvKf8Zao1+EDv10J/2liw0EOOMZ2aezSb3Cpu8W9s0FCE
 wVjGY7qP2ZWkJHfVSvunsYVc7u51A/f8=
X-Received: by 2002:a17:907:1c8f:b0:c50:9412:93f0 with SMTP id
 a640c23a62f3a-c51317e3208mr1522656666b.8.1795605994515; 
 Wed, 25 Nov 2026 03:26:34 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:33 -0800 (PST)
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
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 4/7] dt-bindings: display: tegra: Document Tegra114 CSI
Date: Wed, 25 Nov 2026 13:26:10 +0200
Message-ID: <20261125112613.237333-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125112613.237333-1-clamor95@gmail.com>
References: <20261125112613.237333-1-clamor95@gmail.com>
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
 .../display/tegra/nvidia,tegra20-csi.yaml     | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
index a1aea9590769f..6296f3ab1d0ce 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - nvidia,tegra20-csi
       - nvidia,tegra30-csi
+      - nvidia,tegra114-csi
 
   reg:
     maxItems: 1
@@ -24,12 +25,12 @@ properties:
       - description: module clock
       - description: PAD A clock
       - description: PAD B clock
+      - description: A/B lanes clock
+      - description: C/D lanes clock
+      - description: E lane clock
 
   clock-names:
-    items:
-      - const: csi
-      - const: csia-pad
-      - const: csib-pad
+    minItems: 3
 
   avdd-dsi-csi-supply:
     description: DSI/CSI power supply. Must supply 1.2 V.
@@ -121,9 +122,35 @@ allOf:
       properties:
         clocks:
           minItems: 3
+          maxItems: 3
 
         clock-names:
-          minItems: 3
+          items:
+            - const: csi
+            - const: csia-pad
+            - const: csib-pad
+
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
+          items:
+            - const: csi
+            - const: csia-pad
+            - const: csib-pad
+            - const: cilab
+            - const: cilcd
+            - const: cile
 
 additionalProperties: false
 
-- 
2.53.0

