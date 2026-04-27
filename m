Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF865FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176EF10E2CB;
	Mon, 27 Apr 2026 15:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVFs4tJk";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD4110E2CB
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:47:05 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so5804345f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777304824; x=1777909624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SAfTMxnj/6IMVjfTHuWc/Km6sx3eQW0UAcM2xEXbSOk=;
 b=iVFs4tJkrbblZtnneobEElplXl5bswdXkE0DZQ0zAyp8L7kI1UNsEOsjMsj+rQS0mM
 hbDsKZfvXYnByC7rahBproLraY63Hr5SkApc/PaDvlYeIrebUCyEhG39XYMuJ7CdsJUp
 Q+8uixUA5Kp7THlZ6tZJc9EI+AGGQ74G5G6+4LiyonovC2N4g+fPVTPcr/Am8MehjpWE
 Q/acjLfghC+awPOR4nFD6evrmVdrIvPW5KLqSjKtaLVriBHL868CMdeU+e8svPCTAaRp
 HBZSPz/JTY7K1ZFtt3hO0QqALuEtyygwYYkrsJNLuF3639n+JXIXkjmpjq5GgtHMNbJZ
 Wiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304824; x=1777909624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAfTMxnj/6IMVjfTHuWc/Km6sx3eQW0UAcM2xEXbSOk=;
 b=mCRl18UDMYe2CwkhAXDx53gBLjT0dki83RI7JlbmR778uUeoqZ4l2hiUPGfsE4ZJym
 DbfNeziognhRCEZdB5uYN1BlAaacObIuBjpGzy+aVCglUWfVXE4IcCilL3ZXEburgFLg
 hhZbRsJmc1nnux4jtRXIYwvdX1sP1ekrYhhWITwwKewXG4RtVPO3eJajKaJhsqm2Mt2U
 j856tkXpZ6fy+CHTJ0SlQf7NQFaDTvaEPNB+S9Wn3rz9+AM5SJ8zy5AUjEZzfSHXkjfs
 akuzAJjupJJqVUFPkUaB6fjMIEdUxyuSiezMIc+BL0NOP2IkIrbqAOUbiv81yOrWjowy
 fkXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SgNczYOmlU0x1Xn0k3ov8ZvcYJxboh/wO/BB/B/KdP0D173Tz8C3eS5oI1UnV9lnqjG6lU991wP8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIIf67j1nUaGdIsDMZsgmZaIlBLuLoyrCQt7mBpwefMGf2j3RQ
 qa3dYouf8L6OkqgO6+HXVVXGqJlnQzb8tFYeZO24YNH9QJKeo7RiBNEC
X-Gm-Gg: AeBDieuMeTirypoSVczmaqeq/7CQr9EVWH+TcubaEm6RnpSNacbs2tv6gAjrbnAcpkZ
 04mgrBBnIrUJOUCoQKtQ9LNoKsAsrCuHlRDmEm12c+dxG18AIrlyv+2z9vlTe6N0UQ/rlWbzMtU
 9KDc9zTrabr1DW7W2bdGsdalknj+soepIITRQdvvjixAH10DCc1LycYv3e/X6h1aKGwaGvzngVZ
 Oge5xNBVklEzC/Oi+ZbAz+WEP+iVTHOyHtNiV1tinOOtB580jRj4U3y22CAU9729x7twvwKZjh5
 Tt9jpzu/kTOyenDpORRqdYGpbUjlMPsavhHqCxs++l79NngN4tYlwVqqymWrNfdINgZlsKCYCRU
 34+4QOHRapIIlaxG4Dta5ny+Hj1ZzHRLY37OCbJq0TcFWd5ueoy4zzwGsA9yTxcBUkBMO8HpIKw
 C9INgJFjUdB/Td8B/5dY6qdd6fsXYi5oXsrMJoKI+Q2lxtGVVsdKbc5GxeHycOp8ZNt568aFq4l
 TjckIWA0yO/nklibkfFZxO6+Vy+E+WeXC9Hm6YJh60qUIWW
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-4411c18f7c5mr47093562f8f.37.1777304823718; 
 Mon, 27 Apr 2026 08:47:03 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f97:a47d:8f30:c055])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm80537830f8f.16.2026.04.27.08.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:47:03 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: display/msm: Fix typo in clock-names property
Date: Mon, 27 Apr 2026 16:46:58 +0100
Message-ID: <20260427154658.276737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix the typo "clocks-names" to "clock-names" in the allOf/if conditional
blocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, patch applies on top of next-20260427.
---
 .../devicetree/bindings/display/msm/dp-controller.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 8239adb7f7d3..43ebd053f98c 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -243,7 +243,7 @@ allOf:
         clocks:
           minItems: 5
           maxItems: 5
-        clocks-names:
+        clock-names:
           minItems: 5
           maxItems: 5
 
@@ -264,7 +264,7 @@ allOf:
         clocks:
           minItems: 5
           maxItems: 6
-        clocks-names:
+        clock-names:
           minItems: 5
           maxItems: 6
 
@@ -286,7 +286,7 @@ allOf:
         clocks:
           minItems: 6
           maxItems: 6
-        clocks-names:
+        clock-names:
           minItems: 6
           maxItems: 6
 
@@ -306,7 +306,7 @@ allOf:
         clocks:
           minItems: 6
           maxItems: 8
-        clocks-names:
+        clock-names:
           minItems: 6
           maxItems: 8
 
@@ -326,7 +326,7 @@ allOf:
         clocks:
           minItems: 5
           maxItems: 6
-        clocks-names:
+        clock-names:
           minItems: 5
           maxItems: 6
 
-- 
2.54.0

