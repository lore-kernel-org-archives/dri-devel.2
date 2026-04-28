Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188ADFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8178E10EAFB;
	Tue, 28 Apr 2026 10:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kh4srMFq";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C389910EAFD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:04:06 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso114009415e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777370645; x=1777975445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EaJ4+olCt0ESjMkUsLHtcaVD2PslzC6qCqa9YfkQU9A=;
 b=kh4srMFqn7uocoK4JuEFrA5VhSHaNt3s2ECh4gSJCcxOpg9eqLzWVEbHtTLhjxBjUa
 aDZIKe89ZVK4lK20Al7/pKy0NXw8N9FTMu0GwgFMu5BER+yxzgEmn7dBQAn43EIPBd+X
 ZO/dPk5CgAK28qa8vGaTsYh1dLOtw1wQXb2drA/Jbdksd0v2DILzNv7TQnRSI06qL3oH
 pYdlQh+tp7bqaAlul0M/FaCywFXRc9uO4sNZ2Ic3C7phpOVp9vhkqQLIbn85KXLbu88L
 Z8OLHrUJgp87dHXcep5HbJXWLCmr6vvGq8LsSq+NlIM+vcFnGq7W+DcQ2PtgUD3jTFiM
 qceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777370645; x=1777975445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaJ4+olCt0ESjMkUsLHtcaVD2PslzC6qCqa9YfkQU9A=;
 b=cNks8eGWjxn3+yNex+QsQo11PiPOj+LKd4boN2TeIRXKB7f0rtOe6Qg7tzRieyRh/X
 I+rDMQG2K2QDvGvxih06mj3/9Fh+lx8tZ/E9tfHL3sSNnCJAk6WupjmDpxX9alwQqcPY
 TZOTz1jMc+MNV6b/9POSz5EgUaIyoluG0SFcZPqhxP6roYyv0N1CVUopEDrmhiKFOrKr
 SRVbucJT6n+ruZXfB+xiL8hK1WWHotfpGbDudzuMN2oznbpScqjygmCpfhLm5mZ5XpOY
 f1+oKKlgUofuC6lyfVSIY4QnXwhoZ0uT8KuHbyJDG+VK0LYvn3sRC64wW5ylRiL2iJh+
 Y3sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZluwvUEbDAGc0QUbnN9tw/tZ50O2i6DZVQjKD3U95PQ4rwE8jaJoJCNknLO4ZUhqXH+Nej+JinRo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywx8TZHZJMeZ2eS+sV3O0OaUGkp5tr3mGX0waNXY2y6Qh7p4fD2
 IMoKk7Qnld1s6F8OZftgXMjzA/hj1NlxPGuYA7IgddXi6DVysqcEDIZh
X-Gm-Gg: AeBDieuBvWK9pjZl61OwfiyuUPz6efA3mDNrZZQ2iqUr431lEGUcce5Kov5LebWZPrJ
 jrVnj0+m65ImS/zsCsSAPzcjYB7Hovy+dXbFMgORXbspctJ9NSzpUO9/u9DkrhKvIDecueubKyP
 nXGCifcXNk3Sqep3OgI5+XxdYWwcCDFhYc87ye8h7bObIWAJD3XZCZDdM/wjZx6+hi9rkSO6zJR
 YHSNPp/lQMFqkwAOyVW/KCm6fl/cyPHtC/+cGg0w6DfbD0c4auwedmA+K8yFxVBUeeW/JzvvCUn
 SqLPFdDFR8Xgsq0/+en8eBvi30TBVkw0Beho3dzUSnCQjkeWKtqrhjkxzZp/4t7Bc4vp8SGJUVK
 nzKkdeb9KXdbp6Jr3wvDb8xwpsNTjdc2IgxziLh0lS7PfcBf6UXtwYspC7s5Ii65Ubxkb0Ms8A3
 K//JydzqovL4DsOEyTTsp462eeZiAqW2aaGWxUk6fEz5lH91o48DD88tJuDbH3Q2Oi6nfTDg82M
 +2glnuqPQIt/ZCT2zNdmOKsIF3W6/12ObzVsXGBaFCnVOPz
X-Received: by 2002:a05:600c:a403:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48a78a391b9mr21393605e9.10.1777370645029; 
 Tue, 28 Apr 2026 03:04:05 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8851:8e5e:9c47:30d1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e126csm23640705e9.5.2026.04.28.03.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 03:04:04 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: display/msm: Fix typo in clock-names property
Date: Tue, 28 Apr 2026 11:03:38 +0100
Message-ID: <20260428100338.3179722-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Fixes: 9be5c47908e66 ("dt-bindings: display/msm: expand to support MST")
Fixes: 7403e87c13847 ("dt-bindings: display: msm: Fix reg ranges and clocks on Glymur")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Added "Fixes" tags.
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

