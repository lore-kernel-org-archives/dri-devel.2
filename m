Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D612FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104D610E83C;
	Mon, 27 Apr 2026 17:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DlelMwn/";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CC110E830
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:11:46 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-682fce74c06so8159828eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777309905; x=1777914705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qm0WgPLRhpaE+/n98mlMN9+6F5W+8cs8HRYLALKl0Vo=;
 b=DlelMwn/Z2H/AhMATWEjtCnguCx2Hln85bY4hFUSAAJI3K7vo5AQN17fHkIzV4tRDp
 HD/Uhj5GkDIVTWNXgM/YGnLDgKtgNmOsJFcmG+I5TSZZUsf4LvuLSBaxCAa/jLx5lTaF
 lissEcywTYi0d/0A0vnX7ZY3HgsTJ4BVhKB0/5qfFKtvW9TqxnDdhli4ws4O2OTPAgjv
 YaCaFBMTbWr90wfQWV2dHRO8Zx6fGHz8fWxTz3uUnRkYFF+itNVfMJeUJnAOqti3AD+Q
 CT+vjKTAt7D25XJjLeZTJKuYIiXVe/FuZkkdZxPlDzhBjkLloYMpyk+evuq6G3D4Ax+s
 1sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309905; x=1777914705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qm0WgPLRhpaE+/n98mlMN9+6F5W+8cs8HRYLALKl0Vo=;
 b=F1bya5XIF7HaLkSapQ6lohvgLBEQ8PtMUGnQm9Nosw2RlV3YuFLTsNAhtpTyFyDEuP
 UKMtExeNZVkLXNmuasWF9D0Ceft6knNdhpB4dmOtINBCxo5rr1BgQXWfDt23ASBioF4t
 5XLEGKxeftsp0gvPy+gbizLXH5aGTBl18on5sWgJpmaT6KEYwAMEh9bOu9E+WXpbGowU
 9YbPF8goAvm4fFqJnH2VO4dV/RwxMIoy2HEerftem3Oc58AGvITGxgHyxTEBm7BtnwZh
 Vrzu95Uf4sn0+b/12mOfPvyJe8ztbyWlbbzJ6eU4E8bmYkdWLvhp7XxUrKOs7QdQWyOO
 Mt9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ92zSDGFzfvq+IG60liI/2rN43A/t3AZHHyOkbmn7JlnBrlAkbVapHnmEDIZ7UXfWGSYS0kmTkja+g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTIzi6WBOEuMbWgptMYSrvbJDN/Dh5ZfIEMI88DgajA3Aawr4s
 5liI/YnZ2atjm00S6jBSiAY6P8dFUsKap5elgAB5CJufn0OERb72wvbp
X-Gm-Gg: AeBDieva39yC60G792uMbS87IGPKdnMM7mBwyii0Q+D0tTKGj365s2sHgIRgPx0uz69
 TZ5MdxQ20JSwf6+1scXR4OXo4oYRJh/rFfu/sJ31G8P46YmOXYRnQPiK+ck+xeP0emii1/K4CJu
 fXUub++NnZyi6Aj2JIkn4Xt/EeehpFwC6JPumxl7V8uBN4+xEITjvK6nIJVRE81HHsvbprUL7tx
 AGPLnqlopMjra2F+dqz68vErWeQnp0lQfrovlWcxFMseBHdjvm9NwpLvjjUftc/b4OZNpsqdMEH
 wJhHlM54cMEb5f1DGUD1b2mlY0LEhiDDOXZNtQg18err6Ertstisl04qk/lgU9I9OJ+cHnknHmw
 qfMdPMmpDA/9hzK2sCNQvDksDJ+PJbe01qTxAL/FpE30W7M/jly5JuhTTE/9QVJHShlTihw3ojT
 Ezin885wyCtXTu9eEpRUSYAww8m81hBno=
X-Received: by 2002:a05:6820:1996:b0:696:1dbd:9827 with SMTP id
 006d021491bc7-6961dbda16cmr10887373eaf.12.1777309905398; 
 Mon, 27 Apr 2026 10:11:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:11:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org,
 simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 jesszhan0024@gmail.com, neil.armstrong@linaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/6] dt-bindings: display: panel: document Anbernic TD4310
 panel
Date: Mon, 27 Apr 2026 12:09:11 -0500
Message-ID: <20260427170914.5062-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Chris Morgan <macromorgan@hotmail.com>

The panel used by Anbernic in the RG Vita-Pro is a DSI panel based
on the TD4310 controller IC. It measures approximately 5.5 inches
diagonally and is 1080x1920 in resolution.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../display/panel/anbernic,td4310.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
new file mode 100644
index 000000000000..2da957cd5d49
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,td4310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic TD4310 Based Panels
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
+
+description:
+  Bindings for Anbernic TD4310 Based Panels, such as the RG-Vita-Pro
+  panel (a 1080x1920 5.5 inch panel).
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: anbernic,panel-vita-pro
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Panel power supply
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "anbernic,panel-vita-pro";
+            reg = <0>;
+            backlight = <&backlight>;
+            enable-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+            rotation = <270>;
+            vdd-supply = <&vdd_lcd>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.43.0

