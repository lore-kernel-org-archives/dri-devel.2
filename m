Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E2606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fj13VgNa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4728F11254D;
	Thu, 29 Oct 2026 20:58:46 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79D910E4B4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:58:39 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-91c63449320so622066d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793307519; x=1793912319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DqR3VaUxV5ZL1mlLLS8dI5+d5I/tI6arVdpvogwVwQc=;
 b=Fj13VgNa/MmAW4YIlQkLIiuETwUGr6ZUUlVGAzBYNS8isrBiGK7dixXsJatfV6toxk
 X4ar1oSIFBNkuYLojlH2UD5bFooMjS48q+9RPXqgnKgSYY1AifGWk2zlDSZ0d7fRsXeo
 SnwQ0t2J/vuHnAa8lJN7Jq501OszAS7EFGutlG0/JUIUtMZSPLA/HqfyNvnqgnMwfFsZ
 Lnbk1SHpGcJ98Xi0A6dCJUIbeoqyRvqTjAWTP1ftW9MjSkUk4BNQRT04mxPpFEANRivq
 NXpKH4qCi7lOE5hJMy+sABeq1bK6n4uTYNliZ8vBk9w3uRPOo0nf4nNfyxBZ9wvawMA6
 QBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793307519; x=1793912319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DqR3VaUxV5ZL1mlLLS8dI5+d5I/tI6arVdpvogwVwQc=;
 b=VWQ0hcRTgPWDVCLJ97ZiK3zEBnyXrpbhK8+r0SD/8f+IhxOWhmUevf80HeVKuPZYtW
 uww6kIfpjNgdApu5r60c1ue1S+Q1g3m+GgKBTZsiiY3622NqObKZGv3NOgIhhuFf7sVG
 NolcrZLapTeRoNZHf1n71wD3s0AARRAma3nMJWiLpvB1PxCFsR57rJtHOCbWiLlI7hUC
 ifssXbmwuzV7sLCaRvVKqb+YeoJ2wnkdvbWeViYyIAVA5A8dKwWT2CK86iQB9kJ5yYsI
 7kRSZR/KPjdeVnvr/+sUng3q2fQM2BWgz81iKlMybWLrrhTu+BijAuR+xQ5LHlYbQ+nm
 J2DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/4qHnnxo5tPex6DvS8Ysja1amCSd46vykeSAYTcjVfUP1uNlo0UWZmBRpyEIRboe6stHe3yEPbQc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLoZjGHacF3Jii49XPfmE8EGDTzSTmVdtdR4JT687KWW71EuxNO
 NFnKIJesNjU+uf8PZzUCGk9zyqk1YcUF6Pp34EUiIeeZ9uorqX8Owo6f
X-Gm-Gg: AYBFou2y3MBOUfS045L6gmP6WJp/y5rGlgf4FVwCacnehlecn7Ld17FA3uQnweYYvJs
 AhTvnJ22zskUXPGNJOcH/rQ/rvc+7IbcRAy1LII87UOkBrACLwR5t+YMGC8w9U3z9OwlJ+uYKTb
 CzGcujAaVb6Z+3hA8TBpHR2ZyT1vAb27oLVWsflw7uQDQglNPClOA3JMYgi1bLMJG8i8knNiIdB
 9RKSvKo2mh0PEz1n+R0c1PV0m0VcDfJEZluvXTA8a5j/WxR2cQIsqiNAQ/FCA2YIkcAyc92peXB
 7rHRM1RSDz3SNa11v/1Rv8mYnOzGbjMYTAFITOQpnhP9t/OBN1c2Q4WrA1Y4d4porSeSbOf5/zi
 Df1R4LVDy9VABsKcXzJ5bBQ5yF7j8knqKpEfpow2Qk6TU33VjenFSWBJTIX+IGKcx6t8ttB4jRi
 GLkm641mJ7dcMgNbsnaGuhGNyq09nANnL5pWvy3I6iRAFt2hH3JQ1aRMQp5bN743ZT/m75AwhgQ
 sy4AqcGPgEslpEKIrSJqCCZzlnwrICk/IM0jeZIJtAusxhhjtkpyHq1JVHw0/6JeKs+CQwpR9rG
 a0rdj9lvM9/SBiOXJL4/cquuGBmfQQDq2vKZX8oKw9FZlEk=
X-Received: by 2002:a05:6214:3212:b0:917:8ea8:cf48 with SMTP id
 6a1803df08f44-91ca4ae7fd3mr2661636d6.11.1793307518784; 
 Thu, 29 Oct 2026 13:58:38 -0700 (PDT)
Received: from holowork.tail3176d.ts.net ([71.104.86.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca31032c9sm6006136d6.21.2026.10.29.13.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:58:37 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Amit Barzilai <amit.barzilai22@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Piparo <holofermes@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: solomon,
 ssd132x: Add col-offset and dclk properties for the SSD1322
Date: Thu, 29 Oct 2026 16:57:50 -0400
Message-ID: <20261029205751.3513474-2-holofermes@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029205751.3513474-1-holofermes@gmail.com>
References: <20261029205751.3513474-1-holofermes@gmail.com>
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add solomon,col-offset, solomon,dclk-div and solomon,dclk-frq for the
SSD1322, to set where the panel sits in the controller's columns and
the panel's refresh rate. On the SSD1322 the clock divisor is a power
of two, from 1 to 1024.

Assisted-by: LLM
Signed-off-by: Fabio Piparo <holofermes@gmail.com>
---
 .../bindings/display/solomon,ssd132x.yaml     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
index dd7939989cf..6c7830af0e5 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
@@ -16,6 +16,29 @@ properties:
       - solomon,ssd1325
       - solomon,ssd1327
 
+  solomon,col-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 119
+    default: 0
+    description:
+      Offset of columns that the screen is mapped to, in units of four
+      pixels.
+
+  solomon,dclk-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
+    default: 2
+    description:
+      Clock divisor.
+
+  solomon,dclk-frq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    default: 9
+    description:
+      Clock frequency, higher value means higher frequency.
+
 required:
   - compatible
   - reg
@@ -46,6 +69,9 @@ allOf:
           default: 128
         solomon,height:
           default: 80
+        solomon,col-offset: false
+        solomon,dclk-div: false
+        solomon,dclk-frq: false
 
   - if:
       properties:
@@ -58,6 +84,9 @@ allOf:
           default: 128
         solomon,height:
           default: 128
+        solomon,col-offset: false
+        solomon,dclk-div: false
+        solomon,dclk-frq: false
 
 unevaluatedProperties: false
 
-- 
2.53.0

