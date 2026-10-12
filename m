Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954B6CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CC410F2AF;
	Mon, 12 Oct 2026 18:11:22 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026A310F2CF
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:11:15 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6afb0d2a586so3837388a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791828674; x=1792433474; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H+lZKGmObmd47/Y9rOiwVSAJPnc99rNMg+8rnP10wQQ=;
 b=piewcuKTxXsXgdTCCT91cIpnzbdj9KGcHwOd5+Bxlk2voSgrgUkHz1tHo+o5rqBSO5
 PZ0qg9KuqJbrAmNS5rkXFZskys21LZ2/AV1TqKijZVN9Uz0tOm4xSx0a4i/P16CR/jqS
 lxV8Y/Dc83Rt2+VwG/VDRDXJSHXwqcbjwuJiHcw919DOSKwPAQhSctBuUA3nBDywUygs
 3fxPyoPO9fgQQ5c+MoqkYSqfG+/4XX5bwnQ34if9ac+J+h34kCkgKhPJjTc0pUnL0m4Q
 G1BPbYwSy7JuFgKGsKsu6yxhznOm1LVC3q/epjW5w3aYpxzk8wmtSGZ08Q5EdGmz8/e2
 AnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828674; x=1792433474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H+lZKGmObmd47/Y9rOiwVSAJPnc99rNMg+8rnP10wQQ=;
 b=ONZSYpLeBFCyGrlDdggrsH4s5vLl3ONgfBOzVlNoZmkSEuuEHLp7FdvORMxGHHNxcS
 S3pntee+vsZxc8spYxLdzb9GAwHhcAN3joOygmIBJ7QDkYl7VoUl2bTmHgm/26rblsSd
 mtUvU2JQnRqFJb/i9G2fJ2GrcFi6MObk5DIPqJxxx132jCBZ4ak/WB4Szrd8zo8aYpuh
 HCIENqV3h4JX1ns3yUpfY6mMK1zqRjSrPByORLBTSmVHUuvk5levxSxJcHxY69Oe4d17
 NEls1gyeXqxJpj86pz6hBPyXCcL90yt8YCirhvrdkLNp4GjKcv1FzNlp6ea163HCCYl3
 EVNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy48Y+L7D6f/Rscfp+HvRGaKIIW9h27hkS7L+hCSqWtzsu+gfeWOmgt53Oeue3sa7jNVqwVAYq0zFY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLkE7xaQpqYiJo7hGC+ySwWXvDy4KQPalI87/0m5mLs46Eim3Dg
 c15VSpI1AY8nLua338uz3a7Rw4WqJ4XLoGFdhVbwTkpoZrRAV4owK0tI7F6NeDwLW9k=
X-Gm-Gg: AYBFou26xGzIAgXM41RSLpQXQCdtSOvaznwX84Jg5zQErDeuRYlcKY3VCaq9RpddF3H
 Uvg5R3qyC264QboXxTrcUyG/TuVx9ItaL3qmEgbzVAvfbAHpMKfk9DM5tzhy3Sd8bIdtPQADlgI
 Lz+5YLobQrthee+XMvCTTfsiVZQhs5eNRE5whG1B3Tbku6vcToJNHSK0iwOUtJBAMKT5YVTZXlI
 Y1QiSctOA7Eb7gQ/canGqICElbDPdghPZmAoOGg945bxOPqAYQVUyaPr+udEYvjOtlOjjuWfDoE
 xwM6DyYQLZUiH1IrhYo58qMgRU8CRt92M8eNEJT3TULEODXbdyYEmTaSBLJ9orHSmG4MT2tnJlJ
 TbUpsmYET1eyp4uwAodsCR+lb05NJeqbwvGfs1J7X74fAgrtewgkQBQEr6Olr5oWJnn0bA0z9xH
 fhHgvIVFOYtEzaYOOn21Dogqaf9qJc2ArusSNMkZDLx/Fsy+Qw5xBsizHppHn9+TDMmP1kcLTGd
 hmSAQj4H2Vfb8N0hWSU7CZjiVac+/yQbAkA+pD9ECCDnOKeni9VZj+NLUDjUissq6tT02pLD6f3
 xsxo84k3/2Oo3kjE0PQ=
X-Received: by 2002:a17:907:9690:b0:c21:450d:cd88 with SMTP id
 a640c23a62f3a-c31a9a3361fmr925645566b.6.1791828674339; 
 Mon, 12 Oct 2026 11:11:14 -0700 (PDT)
Received: from [192.168.101.179]
 (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl.
 [2001:1c04:504:7401:4b2e:1820:6d24:b264])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac924dsm498415466b.70.2026.10.12.11.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:11:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 12 Oct 2026 20:11:04 +0200
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Add Samsung Galaxy Book2 Go
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-book2go-v1-2-7188e7ea7a15@fairphone.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
In-Reply-To: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, Luca Weiss <luca@lucaweiss.eu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791828669; l=1131;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DuXzIQSun3W9jTWkn0omnZ8RlHXkIOkrEU0r1GCIViY=;
 b=oxiEWLGe3H8pzO7bcR/tz+NQOoZwruYk7HCL2vpDG8HwyoDuSCTZdpze9SQqgYW2Wkw1J2FDY
 U1pxGlyB9J1DKCDaaTZsaiNK+mo0vI89+6A63YfyKvYFP379CuXN+2U
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

From: Luca Weiss <luca@lucaweiss.eu>

The Samsung Galaxy Book2 Go is a laptop with a Snapdragon 7c+ Gen 3 SoC
(SC7280).

It appears to exist in three variants:

  NP340XNAA-EXP:
    4GB RAM + 128GB UFS, WiFi-only (NP340XNA-KA1UK)

  NP345XNAA-EXP:
    4GB RAM + 128GB UFS, 5G (NP345XNA-KA1UK)
    8GB RAM + 256GB UFS, 5G (NP345XNA-KA2UK)

The internal code name is Hermes2-14.

Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..5048e878b7ca 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -887,6 +887,11 @@ properties:
           - const: google,zombie-sku514
           - const: qcom,sc7280
 
+      - items:
+          - enum:
+              - samsung,galaxy-book2-go
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g

-- 
2.56.0

