Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76594CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C4D10F38E;
	Thu, 21 May 2026 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X9fQLs7K";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559E210F37D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:34 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso7444815e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375693; x=1779980493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJdvze/3qUGSdeaywOgRH9jPh9c2UmVUF7voWWqWYm0=;
 b=X9fQLs7K0BXJBLbC6VqTH2AVvk+F0pt03pRmipmRRI13cOV9gxVwuLqRqTzA80N+E3
 bUST3o3vLzutxPtZR1xU57KCEXgaJD7gZvV0oSjQVxwkdveoyeIwsdaqdS+hBFpfRx0O
 E90G8Arx/CP9rsdXQYQ0G5nvmFtWZ2RME4sCFypeUrQ3rJf5YR9tuxZBLGZ2OAYQ/mlZ
 oEC1bo3aic+qBk3iuJX8Yjyfvf4Rv54Bt4BNo7tcJzOZmzMh7EpD3Z/jJApInSo2+y08
 tffs+IqRIBGFgl6+1hyhpC2Xv8DWfsQpfFBVod3k3Fsi0m8Y0NG0d/Hx+4qSNFxux6+p
 7iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375693; x=1779980493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kJdvze/3qUGSdeaywOgRH9jPh9c2UmVUF7voWWqWYm0=;
 b=eQnmvl3cF5OmZ/Fz/sniF2wlVGDTXVOrq1prN5m2grQI8FMd5Z/HyJ/3CWOD1IzvSA
 drac+JsueeB3N4Nrp7gj2dGFRbjyyTDMHhnqhc74WFurHmkeBDSrHkAqAsZq5KTZ8zP2
 Lig8bnqvkyM44jM0oG6dpVpdY2VXCH75O9YPnoXEwtdbqbVb/iOwd8IZ7ZQ9jhJljb/0
 IRGyCsD99L8wUoZBG/s1Ape5A8C+/oPq5ly9zZ8dGutBhC9wXvXVsS34hoFosBu0V7Zg
 fsr6gZ1JjQk3FkF67jxf1PBiVVn0zpn5+7mTxL7mP+fh3gGsbVod6MRo0pmKZ0hVXXnn
 Gugg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6qkgpt0nMmCfiXG9qbVCTvD7Uw/6+PHTS4cpTCbp9gMhhnOFPh41Vkbs+v3quo6JxbDN5FlSZKus=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyp4R7Wn4FcWn9PLJWcqggd51w7cHeTQSfZUebsa1Kw7xS3JdO3
 l++xfFo6+8RRXAg5o3s4Bi1NXYJ24HQB83QWzKWmy6QI8QEhXq+1ZfcH
X-Gm-Gg: Acq92OH0okVeTN5YOVjyyNb8nVq0ao/y1xVJ0onHonnjiGfJ57+5wMsYgnFFeTbT8g0
 j1jtQqkCsW+Wkc4+dMoEtj0ezMmcxQ/me5RNrU5rsoQNWllBvkkWB0mfUrL1BbPaDmQpsvy9gXq
 Pw0yRMmkDwTLrxijrh2QSZ0g9I6xXMsp4uVwe5MkLCKRLqm4vbDLp/c1uHI72v//XMdkqqCB9Eu
 LDiUaVmICEL2FSoC5fDOTvrkZAPdsfAPNs86A+LfSkrg9GgbzJ0rCPvS4OzaUfougimd2N7iIvV
 eclBvAvkryvcD60J1dsZhqDqox/9ZLeGaP4jS9vp8JUEQPmI0yHswwlxM/5Zt+mWs57l/Rkyk83
 mrWFBRauYokZ7yCSHLOHmf17NCYPUahKT3ImoEiokhUMND0ebuLiCQ66y9YoWrA8FcxLVtI6AV+
 aB1CUyYqrdLNcG9ZcNOggNuQhZMDqQ0IO/bA+dIArsww==
X-Received: by 2002:a05:600c:17d2:b0:490:b07:5fd1 with SMTP id
 5b1f17b1804b1-49036052603mr29364105e9.11.1779375689908; 
 Thu, 21 May 2026 08:01:29 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:29 -0700 (PDT)
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
Subject: [PATCH v1 14/15] dt-bindings: display: panel-lvds: Add LG LP156WF1
Date: Thu, 21 May 2026 16:00:50 +0100
Message-ID: <20260521150038.103538-31-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150038.103538-17-ivitro@gmail.com>
References: <20260521150038.103538-17-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

Add the compatible string for the LG LP156WF1 15.6" FHD (1920x1080)
dual-channel TFT LCD LVDS panel.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 45183a1439ce..a6af2b9cc2f9 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,8 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # LG LP156WF1 15.6" FHD (1920x1080) dual-channel TFT LCD LVDS panel
+          - lg,lp156wf1
           # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap Touch Mod.
           - logictechno,lt170410-2whc
           # Riverdi RVT101HVLNWC00 10.1" WXGA (1280x800) TFT LCD LVDS panel
-- 
2.54.0

