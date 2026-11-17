Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E4606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCsW+gpm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E09C10FCC6;
	Wed, 18 Nov 2026 13:47:11 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB6B10E5C9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:52 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so540975f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919190; x=1795523990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rwJM/btZEuTlA5fjq2BpjxzgulZAXHvNDImvE1z8MG8=;
 b=QCsW+gpmtMiyhckpYd3g52FWbyVibmGbdj3ooPxM2dtj1i9cbw8ryXgO2cKFxdPB4a
 xYiW7JHC9mQIHtOfwTlThIQYIdqepXPYmZZNL5BGiwto4M/zPd3e4kSyCqS3Qx63Kp/H
 x8PMn0+xhJTVuEWzpQukSkNvzHJImU8RDsDybOPyMyP1qbxWSTVpABcg5uPjNfSZkh+e
 bvRLTIw3JwfzQN03iXV151R9PivY3HtD7HSJUH31jpsRXeeDxa7WFhBi4YDI05yl9APu
 bnAPfQmm3KJquGWm+o1KgNDKPI2Md+LhXeJYKsMuCMgopF0i11eWIcKYE8Hes89/HzVK
 v2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919190; x=1795523990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rwJM/btZEuTlA5fjq2BpjxzgulZAXHvNDImvE1z8MG8=;
 b=1/xDAdO3W/zr8m/TE7Ej7FiJSIXEkScX/LPrfhFClKSsazDPY5K0VgfoFi0KNnV1Mg
 rJi0e2+NeaZEYpP7QpmC/iQ/cbQ0mzXs49NQrs+8MfBYxN0Rn5annPxp8MmHObvayD+g
 BQjJpnPa9lGKr+IFSYazlthYpV12OGSOxfTIYWCBxgfvi9dawJGaICUPY5wwLbmQvfHo
 q+8GUm1vyW3kxtkaLLl3QsI5sEbr6xzRMLFON8MDqxwOWv0n6SgYf5iQZbeJ/cPBOton
 tePn9KTnhGsp/xaigycC9E9AiCQI44jQd6Dbtm+WKAv2rGMGgYHFEsyJxtW5+1FXqOGC
 TgKg==
X-Forwarded-Encrypted: i=1;
 AL+hErFdia30viiJyROusBf/Q+95VEiocTdDmrZJYzzayD/jfh0hOY0n9hZjlchzF0UPifjZZ7c7O7v+fTI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/LsJT+6LhmPR9u8IiB6dL/hPsC/rG9d4v+LlH1Ag4oCeM7L/ET
 dYZwQXg+bn+UJsNa6kKcTWEGyg+11aiYAJZOo1GY6h2ooUN8C8UK4K1w
X-Gm-Gg: AYBFou1Rf5e3gagLoJ7xqbM+pYwP0DbkDp1dD9mpWQ87T0YICP9cT9XiVpACHgLfN/o
 qVEeFxVRsaFk9Yx3XiPzXmKzAEZslM5CWxbjsNUWKtRBa0jDUhbDKDTwMlhgsqf8iyWvDC19QXV
 4OIp1Q71Sv0hDArIWnY3k/aE+jHwZRv7nLwzNWzqHGBH34UJxT6muoxVNADUpaRSHAMXXwosKcF
 RdNmWR2SjqIg7qZoxyOHoz2LiiehmSWuDp+FJqdZOoNnfJuqJhS0pwYMgcRjlCaR2uiSso7trqf
 ZiJ4vDzN8kXWZsjTo3yHx4dUGmdV8D5zLlkmZvKbQZuERjJ1oBw7j1Myu/I9TqAaWOebnPhjC3K
 yg9ad4F9Q4m16mUUWh7hqezqvUHLNI1gkH+Fa1jqOs/mzeXg/SHNm/O5Kdv+L7jCfGkQt4KjomT
 XBv6FatZNEZcBXE4YZGTRP/F7apYOHKyGJRqYLPacuhZXIwY5fIGpT9+ZnqYQJ/UARjVN4+lsk3
 M5KFLVXrZ5cl0vUjpdzdr99hwgDNBY37r400O0Sj47p5WfsBMmCjAKLL6ChM1b/5QCTh9mRK3Wk
 V6aOiGK5wHwU/akcKUsNS/WLeLTN3gYyewk1xgEtkPuyky1OZlyzYDF23KxV3PYGjimOoypT973
 IGzIktbKZeDcbMA4=
X-Received: by 2002:a05:600c:4513:b0:4bb:687c:4fbe with SMTP id
 5b1f17b1804b1-4bb7837c4e5mr56003575e9.8.1794919189862; 
 Tue, 17 Nov 2026 04:39:49 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:49 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 01/11] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Tue, 17 Nov 2026 13:39:36 +0100
Message-Id: <20261117123946.668557-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
SM8250, and register the LG Electronics vendor prefix.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml        | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..f8b34109171d0 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lge,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f10..fa50a81880f0b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -971,6 +971,8 @@ patternProperties:
     description: Lenovo Group Ltd.
   "^lg,.*":
     description: LG Corporation
+  "^lge,.*":
+    description: LG Electronics
   "^lgphilips,.*":
     description: LG Display
   "^libretech,.*":
-- 
2.39.5

