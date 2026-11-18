Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B872606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3TrmNUm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C5310E07F;
	Wed, 18 Nov 2026 13:52:26 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E52010E7F2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:52:10 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso1525708eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795009929; x=1795614729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RZ3vrLi3jrHMyymz0x9oO4kFMwY1lDGMb6nA1tnV5sM=;
 b=l3TrmNUmirhsZQ7Asjl3cF6pKRa2LiC9t+1igy68UuO04U6nFZK7+yGeO/enhrF75Z
 l4lc7nOhNPJLQNAf/ertKhbVLMCzv5tUlilokrSA61co0dfxt9rNU2UEr4MTrVGqdQHv
 8vA2y+uH8ViGYcomjDvy4gjcjhrkjBK6b1Pt5erwgg2efRL7J+A0rZQyyuhqL20LgsXi
 3UOrLsxonGye8SMwPxDFUYDdiD1HAjVwJO1oybS3nU5c3nnCFZr61Dd5BBA/HBTfphLd
 aYO/jGJCkbGU2el2osCkYsZWMcUoo4sCMQD7YMqxVW8kSVJn5Maoa5/0Bnzt0i4xaMGI
 /K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009929; x=1795614729;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RZ3vrLi3jrHMyymz0x9oO4kFMwY1lDGMb6nA1tnV5sM=;
 b=ai04DYEkddoBvN0j3zJLCJ42MMsqKP/4vbXErmXdoEejo4hyCYJE1Tp/KF0s0uS0D4
 eBWR2z/PiQJ0uSA4b1i5HbCUS80POhy2v+eKAY4so+wywNy4A0pfocDTJCTnSc+iuGYF
 ECo6tpfg4PF0NCISorqCMgv+ljWUtZ5Zn66RHT0ROO4rHyCf9TGTwFgLrqiKXY6HWqVi
 K8dBMunFdEMjaWGruRozdIfZdNM/biG61cY7hcDGZkuTVeLkerj3PeJpJox7575sBjSX
 mnK8AQMfBPXnnshEhfUFZEmiy36RN9sIxvb3+dF54DFwKoZ7doeIgmDzeB6F3i2ToBh8
 2B4g==
X-Forwarded-Encrypted: i=1;
 AL+hErHckWNWMX5fl1jNOFdQq8UDiGD2rvxG+MBskm84+IFzSuBVPiix7wqQ/MQ1X8TWvjYav+FAvTTMZew=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+b75RG7+rbDxk1ZVqsvS18ZyKoIgS+wMzhkWM58lhtVMIYiZIY
 WTu/9m3viOXDi286g6gHImwXM6qOtXXtcm/YpvKqU6xkc7Yal486EPA=
X-Gm-Gg: AZFdTZe/2S/2XiRJYfdxRxAMHYHYNKDHZHNrXfnICYW+b6hrUx3CI3cbMvo6tiv5LpR
 GbTzvA3k/21WFyCvWVys+E9/1tZQEuJp5UnnMMO396IO0U2woFbO/c9bCE6GftTgWTwi7accaKM
 dgMHsz4wtAmFafVRdOwZt19W9+AkHDf7wnJdwLoN2M6j0uPt6OvHI2pJ3kbvmXK7HjthBuXOO0n
 ko8e0Yr3Wk84ZtUESEZleYhEP1Vf8q+FJzybue48iVUMOhI6XRb1YGCakYUE/MjcaajrSt3fyDd
 OV972u6XgV6fFhGoigFQ5YXj9bZKYSGVYBiZcwgpiWzJcoD80nw31k625Y7dyIv2AA81YKIqb3i
 2ooXEBwcXYxC9UE7Nhg8eFmv+iI6KV9TJgXJfvqpto3lzpAsXfK+uPXAx8nO8lOcdQdiW23nJmU
 e/hzivElH53L32b24/ro+YDlTIiSElUHxjshQs+rquANkWM2HgnT5UzdGMhi9XIs/UG/2XCIcqH
 Et7Sp2Gk9Pybqxlv5rc4ZK/0DI1cJ8Z5K1WbZ6RFwR5Lg+QfEZMwuHeMa6kVytYFERlQnZr2Drh
 YyLx4x8LKYjC7H/4GZbtJCYQW1DMfCFr0VIupukZuXbDR7QuQaU1Y1jwDUNmCQn+0qjhDNnWGI7
 5Zn8oIw==
X-Received: by 2002:a05:7300:1c9c:b0:361:1dd6:531b with SMTP id
 5a478bee46e88-38281025c89mr2808520eec.26.1795009929066; 
 Wed, 18 Nov 2026 05:52:09 -0800 (PST)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a7eaf3b3sm9576421eec.27.2026.11.18.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:52:08 -0800 (PST)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/2] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Date: Wed, 18 Nov 2026 10:48:53 -0300
Message-ID: <ee36486140ce93f97d78ba526917cafc896b7e83.1795008752.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795008752.git.nico.antinori.7@gmail.com>
References: <cover.1795008752.git.nico.antinori.7@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Note: Carried "Reviewed-by: Krzysztof Kozlowski <...>" from v3 since the
only change was the removal of adding Chipwealth to vendor-prefixes.yml.
This was added in commit 058ee00216a1 ("dt-bindings: vendor-prefixes:
Add Chip Wealth Technology").

Note: Based on drm-next commit 601c30449c80 ("Merge tag
'drm-misc-next-2026-11-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next") to avoid
conflicts when applying the series.

 .../bindings/display/chipwealth,ch1115.yaml   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml

diff --git a/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
new file mode 100644
index 000000000000..6b037c40242e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/chipwealth,ch1115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chipwealth CH1115 Display Controller
+
+maintainers:
+  - Nicolás Antinori <nico.antinori.7@gmail.com>
+
+description:
+  Chipwealth CH1115 is a controller for monochrome dot matrix OLED
+  panels.
+
+  https://datasheet4u.com/download/1576606/CH1115.html
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    const: chipwealth,ch1115
+
+  reg:
+    maxItems: 1
+
+  chipwealth,inverted:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
+  chipwealth,offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    default: 0
+    description:
+      Display start line offset. Specifies the vertical alignment and row shift
+      along the Y-coordinate.
+
+  width-mm: true
+  height-mm: true
+  flip-horizontal: true
+  flip-vertical: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - width-mm
+  - height-mm
+  - panel-timing
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@3c {
+            compatible = "chipwealth,ch1115";
+            reg = <0x3c>;
+            width-mm = <12>;
+            height-mm = <8>;
+            chipwealth,offset = <8>;
+            panel-timing {
+                clock-frequency = <0>;
+                hactive = <88>;
+                vactive = <48>;
+                hfront-porch = <0>;
+                hback-porch = <0>;
+                hsync-len = <0>;
+                vsync-len = <0>;
+                vfront-porch = <0>;
+                vback-porch = <0>;
+            };
+        };
+    };
-- 
2.47.3

