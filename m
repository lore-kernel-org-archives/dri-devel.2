Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E847CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E1D10F381;
	Thu, 21 May 2026 15:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B68tX1O6";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C721310F380
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:02 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso56021925e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375661; x=1779980461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRbrNVL6NB/TaXW8v79sMJA8urvaGBAFet012ki4EYI=;
 b=B68tX1O6AVlW4jaX8Dj2R+CJ/hnsBQkYWVfV0uEV6Fc+aLi+9uET6E57/33CusD94e
 S9k+C0tK0JC9FZbtk9u8ulEr3YcksQwFjlSVrbJKAOvS3AOCiDMGN9eRXtmoRPYtKnSR
 q07a6JwTGg9Db+KzpCi6dKReIEQsbHURYj1ENhO3xBrp3BeA6F8t+4Uc+Z8N8b+yCxer
 lABXLkF/vgtLfu2QhXZVVFZ0AzxCuGDpo5s6fvRNHcs5qqYCT7iJVNYGjjcWkGXA+ZkB
 IgJr9g1+xa9obzdPNifiaLhUy8sH3NkEf9TGrgixhMl6NK9FXQbYLsNAYAPQxCNnMhQ5
 5hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375661; x=1779980461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RRbrNVL6NB/TaXW8v79sMJA8urvaGBAFet012ki4EYI=;
 b=aGRBdUwqTEnIjEQKCbcEf9NS6CUijLNXp7GXIM+pZ1GrqnBRO1IIWcY/3cKIw42Zwm
 ibxTMaodMs/fmS4xQwvFn/FVEYPGhOEAJFm6PiSdBHiLpyhDiEaasFYY2Xt6XioyXXes
 uVCusq4e/+rl4Gfyz33bIE/rDOSKNK4Dc6BWoEKW20dr4J7RK12M9IZiXU0ItUvrqaV6
 l6a5PkXsKMZ0WRfnSNfrjovcgv/yJmp4AP67TCTJ9HwLYC+pzrhdYt46QsVXIHMk1WQB
 kliAwlst09iy8PqJVWNKf5q+OIdL3T+av+yt5SFCA0yN4RQvU1LIV12397WbMu/MkeMZ
 TiVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nmL0Wi0I/1xXuvKRHIUqD8c9qddHdF5xbFFvgFFKMJQWio7kw2OMPWBKICa9AToUzYbsgpc6MVII=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOokDtnbML15/ZfDmR6FAewQZ+GzUy+cw0jHVosNw4J4dbrsov
 BQUeHskOlna9d56Ce9U+G+FTlw/m3sAHsflh+zQsviZUSDBvXtZZS+fh
X-Gm-Gg: Acq92OFAkz4rBD2o2MYGv0/IwKAh6HNdcqw0PGmSwFRR+1ZabPn2klvSaS3fIOHSnLR
 NYkDbz9gnjiQZpTqvEokwSp5YBX1iOc+Xnk93CwliWjuoiIWC/UVX/PNcZYGsOz1828fmTHSr0b
 65MOqybbXbXvVw2u5rS4nfuCGNQ4TMyMWfgg83sViFfoRHYDtK2NBvsW2CLM8TkYgL89W9LHndq
 8Zjj9qmusg2OpXKLoOXscY48O6N3gPgWbpnVCOXSoVm3LctNgaQPH0P1utV9hHgK0DKzI3aZRf1
 phPftthN9tOFIjL1BxRlF7VWJm+ooRytvN5veOl/bBcutS2XXnm9PBSIOtDP+ZPU0qqYQ/aVxQo
 mHtv48ucR9o1b6pTvHYZKIH+YJCNy4couLa/UQPmk89d2pKmm5fTXG8QO1T0salgg5KP8EU2h5W
 /wOOjH90pPNnmrORzslHoQ50SqNyLkTcKLZlQoPHqMug==
X-Received: by 2002:a05:600c:8b18:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-4903609cf42mr52668395e9.22.1779375661077; 
 Thu, 21 May 2026 08:01:01 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:00 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 01/15] dt-bindings: display: panel: Move Logic Technologies
 LT170410-2WHC to LVDS
Date: Thu, 21 May 2026 16:00:37 +0100
Message-ID: <20260521150038.103538-18-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150038.103538-17-ivitro@gmail.com>
References: <20260521150038.103538-17-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Vitor Soares <vitor.soares@toradex.com>

The Logic Technologies LT170410-2WHC is an LVDS panel, so move it to
the correct bindings file.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index b31c67babaa8..9db96dd724b2 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,8 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap Touch Mod.
+          - logictechno,lt170410-2whc
           # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
           - samsung,ltn070nl01
           # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3e41ed0ef5d5..f7e09f5b1b5e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -206,8 +206,6 @@ properties:
       - logictechno,lt161010-2nhc
         # Logic Technologies LT161010-2NHR 7" WVGA TFT Resistive Touch Module
       - logictechno,lt161010-2nhr
-        # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap Touch Mod.
-      - logictechno,lt170410-2whc
         # Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT Resistive Touch Module
       - logictechno,lttd800480070-l2rt
         # Logic Technologies LTTD800480070-L6WH-RT 7” 800x480 TFT Resistive Touch Module
-- 
2.54.0

