Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A582CD4F41
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C94D10F431;
	Fri, 15 May 2026 07:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g19KuSDj";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB4310E0A6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:30 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so4387720b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823750; x=1779428550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uA3KbxtyArVx1TPayII+4ue5MWymrrbmptjetuH5M+E=;
 b=g19KuSDjRPmN+Kf3C1g5Frs2Xp4UttPStteaK0KuXAq3Idrl8gxLJfH+esTiOkI9qI
 QmOyMc5BNkATaGgHfocvhRoL0UFPgsFnivAXu/tzZmxCADeFfwQF1L011YTc6eVeTGhG
 cwwFOEq04k7SqoF6p04DOiOOCk/B4Xv+iYR6nGgaK/7EM2WMENBTmXV4qVfvH6ag1nMC
 fPglBK2QS+xmL9hfAIwHWAFEij9epOy9qjW1vx//aLLJVNHnnoXwJCrmt+P0Zis3cZlr
 PA5pY0CemjhjFby4lXXNOCk+hhi3d5d6V1Q/waMWykIwnzRcYuFrYNFIRebfs3i++agr
 rhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823750; x=1779428550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uA3KbxtyArVx1TPayII+4ue5MWymrrbmptjetuH5M+E=;
 b=nwWmocAUrbuWZn9JZdP3FSv3GIYDLut0TMks4GjQRxOikS+rqBI8M48NFdycYY/TIO
 NiFvgPfqSvCDOG+HIhUnd+ZFkXJ3pK2uctq2nWGZ0UTT2ltm1sEX4WqfN4rzb1wcDl7R
 V8lR73TpH3H4jNGC68xrg3HEM+Wlx6HKTTLc/rM1YI1B4FFowbYU8IkEX+WV9lTRKOwk
 nGa0HsisP74fiesb+fg4P28ZWflF3fq+JyUE22J8AJ8PMI7uiMWMW/nIfvzIGpG/2f8p
 gsXdJKm/kw+yn5zaM0H0hCymbaQPU8yLw5NNZGIznb3pROR4hpa3uNcLNuMXK+p8Gfld
 VFFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sjn2GYt7AUyVBTQeUMO4SVUx5imzPff5Qc1ihrCbZOTposJd+y0P2W/rZNPPLBeJXEjbmNghpkmA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAS/4QmQuitNyz2WEMjkwJMwkL5kOoUH7fBWcS6m2PKxjiEGdD
 RTWrllcDb0keqr4TiPudfNQAkp/43L7km0ebtD8mZBP//sge4QIWYgeI
X-Gm-Gg: Acq92OFYGqWqQWlJo0RmvSNHdcxVOplfZqVVzt1QVt7uGHacXMw5ohDESxW5dR7qucL
 22YJeu5tOBWHOf+tFEHwADgZyaUikAJTHNrdJnuAHOL+/KRP69Y4F42zAnSoGnTdJRjQAtltv+Q
 ghX5rPBkSy30jwvQ4q8Rbjuahs9NW+uhKaGGh9leyDC/qY5r9vYard2tw4Vr2YqnXRDKgwi0zUs
 nyf5A3CzTCfta8Q38brxvOt5w/1JLEZIK57ziY6vpxKkUnnfLmAlqfcvIMO1IBchTXG7TUmsCnT
 Gk6j0oJ0qK2/BTXEYew41wG3Qx8eoLA2UgIZpoYRBCVhzwLbWDwmfawg1RAFiCNDTJJgzkFrC/w
 WwAbEndzp1C5wKOHcqrsyqzXOR5C9W2qhy6awnpB02e8XDRbrXgxPE+4Ny3/F9/+SmABa9a+0r6
 GAWZwzakKfFavc8hyEL+p6oRUJLD8GTAORcoH7reXwQeus7SveSp1z4v6irD/Vgz/7hQfC+Hm3P
 nAXUx8zoVYZIcDH8ZaiHisOnxU=
X-Received: by 2002:a05:6a00:2793:b0:83f:2568:d456 with SMTP id
 d2e1a72fcca58-83f33d277e9mr2723997b3a.29.1778823749726; 
 Thu, 14 May 2026 22:42:29 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:42:29 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: arm: qcom: Add Microsoft Surface Pro 12in
Date: Fri, 15 May 2026 15:41:46 +1000
Message-ID: <e54aa6c1e190b0e26d58504c5ea1b05fd09d64d3.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

Document the compatible string for the Microsoft Surface Pro
12-inch, 1st Edition with Snapdragon, based on the Qualcomm X1P42100
SoC.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index b4943123d2e4..aaa9a129908a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1168,6 +1168,10 @@ properties:
           - const: microsoft,denali
           - const: qcom,x1e80100
 
+      - items:
+          - const: microsoft,surface-pro-12in
+          - const: qcom,x1p42100
+
       - items:
           - enum:
               - qcom,purwa-iot-evk
-- 
2.53.0

