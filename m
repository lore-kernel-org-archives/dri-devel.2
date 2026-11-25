Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D08606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmqyKT/Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8091D10EC88;
	Wed, 25 Nov 2026 03:28:22 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D3F10E778
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:28:14 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so2956640f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795577293; x=1796182093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sG4IjzQzTOsq8+1nteR/Dqn0VR6TUjyjIc18rbJBV9s=;
 b=DmqyKT/YWxm+0dcKFJT23c46Z/kzZ9bWvtsDLo04GSzAAAgxtI+6xia4oKomlHs3bG
 +ALaGaJ6I4WKKXJWH3HgR2y5+DSxf2/+2zg06bmuIWTnhFN8wV3BI5Xqn0fpE0fEuz53
 6i6zG6Vd3sm003LxFJyq2IEJLH0hSE4RaAM3gts3YUVaklrjdACCkG7ePWgcUAG+sgMz
 ciSspcduwpp+yxvjLXCeL+HdMKmSsew7hIhRMV5he+nybAdN4y+L0noYERwSMZLUS773
 zs1oQU0mof9wXMMwtSS339sxA+7NO/gWkby2V3rtr+d1UC54DQAf6w2l01kQLbPME+PL
 JJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795577293; x=1796182093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sG4IjzQzTOsq8+1nteR/Dqn0VR6TUjyjIc18rbJBV9s=;
 b=y/3XnHnznp3H1bDDZggSQZbgQpWEPyWBYvhTo6CwpzO0Avo6gG+z8MuDvZUFk8icN1
 6dMYKRwZxN+tsKdvD/CTAw7eSZe+8bSNAOFvC9HKjmKMBlMGhvkMgAEFsZyWwBMTmkdG
 ZUXmqh4JLwBJW4oHgrMnbI7jfxmzsaz36fZqlmF39a1/27QMsNBI/06Eqq2H2ylXrZfq
 cbF5aV6xfgLSMiPx/Uag8zUKEQdYeMuVj9RDR6iaSYJuEpdRPKO1ZjMIPJ2imF5v24OC
 xb1svP/xeenmx8WrA4axzR8eHdI4Nj3L5FsBWmJIZhWGoz1fBXV+blIPL5WeZ4sNSk5M
 AJEw==
X-Forwarded-Encrypted: i=1;
 AL+hErEE652lA/zA69e5PrZ9vxfjxfHfmr3m2BH8Bbf1mwwtypU07ntjAFLO4YaUrFLY9fOz1JVgC/Nyrvk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RiJr9uCKJmmPXBc6/4rJBFnQVtt+8Vykwz0Er3AISZzVumgLE
 eZa1np9r1nj7IyXG7cgvk19TLP8s6OfET99M/v4F46dS6uej+tpx0s5y
X-Gm-Gg: AZFdTZcJOgxtTcYANHfqUsBJp3zOed+PYdhV7DqsABlD/ae1V1H0XtqOsODdpGScJzm
 HivIsMn284lH1Atrdn/ePo1LrrDeSSckeRKV8QnrF9vZIlLZA+QSMZ7Ojz4v5bmsU/jRLDBhtf3
 Rr+19nvoooJwpZP7pr7iUIALFYgS20W5f0odcw7sQSQBtjwnh0Cb3RZtDtLkAsmTLzR85mcr58L
 BbEcYmuL15Q+yi/fvWYKrmrHPs2RDJ2kLVX5v/o8hWm5yJw0+ORFxEM3E2sYwVPYCSdGnEdOScm
 IpiXq3qkOn449/w0+AUmY9sdQ2x5x3REmKTR518qoDGoVfxVLbQgKZy5t3IGz6JmfH5vcyQkD8I
 2enl4N/Hqn5E7XprbHAoI35tOO97Wp7v2XhHc0JE2YWWFspdMlBo6PRTuVFnqIB8d43sSXzgLc9
 43STMpABoqOrFvAkSCYJ47l02CsoIuy/lrrrPOq38HlEiMMwTh0wkSbErUlj9nUkhX5j9f7svmF
 VL/lZI6fPQWCgVQYjwD36F+t5/1O6x6G7F7eKg/gICUyseKaUH0uvi0YoC88XolPLoY4OlNmahe
 lcg+ybE3vr0Hb6JIxbN26AK/MnnRAJD359WRVBHy2BrquG8G4byvncaaNu36TwY5AFtkuG1nlq0
 zYuIIpTIjfXliAlulJOFGXkZEozyOX7s=
X-Received: by 2002:a05:6000:2913:b0:4a8:7115:fa08 with SMTP id
 ffacd0b85a97d-4abb0f3c202mr33671845f8f.13.1795577293140; 
 Tue, 24 Nov 2026 19:28:13 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 19:28:12 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v6 4/6] dt-bindings: input: touchscreen: add LG SW42902
Date: Wed, 25 Nov 2026 04:28:00 +0100
Message-Id: <20261125032802.8460-5-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261125032802.8460-1-rofikcoga@gmail.com>
References: <20261125032802.8460-1-rofikcoga@gmail.com>
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

Document the LG SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 72 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..e8ef2d325635d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description:
+  The LG SW42902 is an I2C capacitive touchscreen controller used on the
+  LG V60 (timelm).
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: lg,sw42902
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low hardware reset
+
+  vcl-supply:
+    description: 3.3 V power supply
+
+  vdd-supply:
+    description: 1.8 V power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-supply
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "lg,sw42902";
+            reg = <0x48>;
+
+            interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-supply = <&reg_ts_vcl>;
+            vdd-supply = <&reg_ts_vdd>;
+
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a41a0690d9f0..8c88429e647ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15211,6 +15211,12 @@ F:	Documentation/ABI/testing/sysfs-platform-lg-laptop
 F:	Documentation/admin-guide/laptops/lg-laptop.rst
 F:	drivers/platform/x86/lg-laptop.c
 
+LG SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 LG SW43103 PANEL DRIVER
 M:	Abdur Rofik <rofikcoga@gmail.com>
 S:	Maintained
-- 
2.39.5

