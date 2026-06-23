Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD8CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D473810EDDF;
	Wed, 24 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLxuITLW";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C761A10E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:58:22 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-139aff562e1so367038c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782244702; x=1782849502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwWnRfNKOCzBCV525CaMblQsIuzpWTFabgqtV6LDX6A=;
 b=DLxuITLW6+CQpj5dGyXRUjNJBGthRe1BetUK0ne30egaJtQzVt5wOXbkxgwBNxzBOq
 PAl74K8vEDzAWRbfn1lkLOkPdKp5LWqbwG5CDgo8qKKNJXD1tjyY77E9DabAAc0WIEow
 823+fZ5/fQGhL1kY2dyyi7Tgjqg+bSThG8sqXX20e/cDfMP5JpktsJlp14Tf07b/ayVC
 yb4oC5UEDPJcnUHomh5GL9/lAPHksKg6e7cfYteQUBoDKh9x3t4xPjFMFr4PxiUQSMcF
 hMKSU5O1pofVRu9dINk3nqikqVWmeP2yVVSYyDPE/dZQdYkQesBGnMulD1qDriKpwy0h
 STWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244702; x=1782849502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VwWnRfNKOCzBCV525CaMblQsIuzpWTFabgqtV6LDX6A=;
 b=QClzmcdhK7l30w/TDZa5ru5V1XKcvikp7cN9dHwS3pJdyme7Ul66/uF2aiQf8Xv5xr
 AS1wiXFNe3oKv4HG01fSZGRIS1afbXTlCSAxZQoZG4TmJVYBOtziigUR7a8nTZ9C2eUD
 ce+IFBO2A85DK0Bf0OWwd3qjrzZwjD+XZVVxmX0B8PWmBx82UNRqRBfr41bRG0xn/nSq
 ROHnD+xQiVPft/YHMrbggs1Kprnav9SNe4jQdfAxcdDoI2UHdXeji/IDzU5Q8vOzxr1A
 jbuubpsykVP1ng6PQSde/RLJDz1uuPo4bSiOeiHot2Y9VwVyvZIyxlNnv48Jo533QnH6
 AI7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HdDIRWFfEZZmcmzSdYNrpumhu/6y7y6wk/kfov65i4EhfX3AuGSkWJfWBOlSp3wxsDr3fbUGiRi8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQOI5gHb2PYOlGejeXwBm25yHtP6qxN8a1nyeDwKRjb7FTKKjF
 pma+qLHWybNcDAZhAldX9eDOGqyXOCblDobnuPDSRJYvlBGkKkSABtD1
X-Gm-Gg: AfdE7cmdjjScK7QmTJMuuN/ne+btnPPz4QEEan8Ct8k07crNiGf1ag5o9l07F4syl3s
 bTKk9qmofCc6jYT3A35/WFdCN20x++b9GOe89B0p3SLEGd52U7+ZXz8m/lUHMGVM34YSdZ7htG6
 5z3t6h1SEX6zhy7qfDtEBGh5PkfiiRSmcBuwnP08WO6ha2oQ7A9nA5BY+NhtUMYWjheAVLFH7d4
 xfMjzT2PTk2j/jVGYPVVNTrVUZ58CCSvqQy87XmZJkHRd5KeqNN+P05GKcMqGBjHQsA4UgbnQC6
 hFTleQgfo12cHPPNO4esSPyNGumCO7C1vvIDnoLSqGhkfBZ/U3hsl2DJjO7CWyiHB7Bpf0iSsgX
 nCyTktfM3UPJELugtI+sHfRSRTX0i5MoF+KNEyx14jIV1G6TdqfMdOo0Fn8E1plVe+vDYZfF+bR
 H8i7Yem5rFiIKTeP5QN2GCOnXtqgy9EXX+cGae2faDNk8ZevChjSLO6VT/x8BtMGq+Eogo/DzCa
 D1tfZhjd2oVM6KZSYfySqHxy3tY9rn+hGwCYQpIJLM=
X-Received: by 2002:a05:7022:410:b0:11a:342e:8a98 with SMTP id
 a92af1059eb24-139d0b58d17mr176972c88.0.1782244701970; 
 Tue, 23 Jun 2026 12:58:21 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add85c40sm15730896c88.15.2026.06.23.12.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:58:21 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com,
 sam@ravnborg.org
Cc: leonardo.costa@toradex.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] dt-bindings: vendor-prefixes: Add Opto Logic
Date: Tue, 23 Jun 2026 16:57:37 -0300
Message-ID: <20260623195741.495734-2-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

Add vendor prefix for Opto Logic, a Swiss display solutions provider and
printing systems manufacturer.

Link: https://optologic.ch/
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index dd94c50e97f9c..ce0607afc1f4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1247,6 +1247,8 @@ patternProperties:
     description: OpenWrt
   "^option,.*":
     description: Option NV
+  "^optologic,.*":
+    description: Opto Logic S.A.
   "^oranth,.*":
     description: Shenzhen Oranth Technology Co., Ltd.
   "^ORCL,.*":
