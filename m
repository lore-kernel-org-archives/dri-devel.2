Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A38CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E5A10EB0E;
	Tue, 12 May 2026 14:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPaKEh3c";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD0510EAD5
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:41:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so50890725e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596900; x=1779201700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZMjl5wlw03SWoU3yFGiKDurKpP+omQjQUlHWLj/NzM=;
 b=dPaKEh3cAOrR7h6Mm51PDHWNu6Owiy9lmozVeOG8hd+BWBUGfIAWAASKO46xD+zsJg
 2Gxz5Kc0r9ttDRQZM+/fL1kLzW678s8/JZI7aXIi17789/TuFV3gu+82sHwaFkr3ljEk
 l2/v+oaBhAyV6x8AhVIajzdKXeN48l6D8jQLX5C9+d2RQBZ8IxlwIsFJRpsLHNWfVHuy
 RXbTYOmptqtbUpCzF8FCxQ32ve/acqWhHPELXHzeU7Dx8/YSFTsyR6qYLFgNhiVzcwU5
 QcPwHDK8g4YiZva14epWfnKVuKS7qZlgtkDRswkmJc11PLb4GJ4sReddvP5+A0Sh/uBW
 POeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596900; x=1779201700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dZMjl5wlw03SWoU3yFGiKDurKpP+omQjQUlHWLj/NzM=;
 b=gpeXQ7AGn/PPVf2S0kzSoXFJpFRcM4CUNGap2xp0eEd3kGypD8PMke8q/qwEtnR8U7
 8AQHVHXkFqjrpLCmkPyC3Is47NTSKClHvpau5b9zjNUDu3xzI8QqFJ4J9lsOroryIsiV
 6mDTGvEoBDOFuMCjbDdzUfK5ZfRFzad72ytrfZmprMmr9nF6yEDAymIaotYNB6GvagSM
 oprh2oJyJQZPe8CUUWkQoudoCTPFTLvP+xRKSoDQLfBpA84lyROkAp68ssXOwdI9XaIu
 LDc6M9mxbRlMLZPimWFth/GKwYphef+6wXZ3QWlcqV2hIGCQjqJq8xuWEr32X5hlZmkT
 VTvQ==
X-Gm-Message-State: AOJu0YwQKpXda7Js4TvZBZJZHEOBS7G2gJOrQadtAZE/TgdFcqhQx5vf
 ysP99RntJuI5JT6TNaVD4A9EjUbTltEu2nWI6XGTs+lHtGyXRhWmXyAX
X-Gm-Gg: Acq92OFNv3tshL8fe3/uZaRzNXVZ2AO/NHUM6T5/vgWJCHWs21G1oQTLg4ORIB/IdjY
 J2WFTdAnadq3DxZ2bWOreDzeEycOUhli1sbrz502wO7uiOGzPVlLgWYveRno/hhAXZvCYpQnF2f
 +p0nHrFWnY7Qxv6I2KUocu2GZGHI8sszaaER6mQUVwSCiYfPD7NOcrYzgvoeVfMhGI9r+PFGvNV
 S29S2Z42pW42IWEyN9J6NuvkCi2GienjWM+eEkH/Fy+nmQI73RV5PhJcvcoNnCnsxNarCLY3TMj
 L2DxfllWdGkkA+zt9SvdeBfGTg4m9su6eiOz1FY5NyWYx9l7+cmz8mBAp+kfh/jkC8hAhE4WIc4
 g044Dpk1HnBhkSAq/viWivKLGSCafkUp286vTdHAacRROjxNEPux+/x6+iDW/sLKReGk7R1xIpv
 x39+zTPEOYMssWQxc+lnw94fFJZv9K5eK6PTAlRmObCj/R2rIjzrg8UEKtDKQay6WphK2nnIU00
 DcRHH0FMOOd/WBCDepc
X-Received: by 2002:a05:600c:33a9:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-48e51e0bb9amr295666785e9.1.1778596899908; 
 Tue, 12 May 2026 07:41:39 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:77f5:545a:798:321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm34978713f8f.31.2026.05.12.07.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:41:39 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/5] dt-bindings: display: renesas,
 rzg2l-du: Refuse port@1 for RZ/G2UL
Date: Tue, 12 May 2026 15:41:00 +0100
Message-ID: <20260512144104.761531-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

The RZ/G2UL DU supports only a single port@0 DPI. Explicitly refuse
port@1 in the ports node.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3:
- Was orignally part of separate series [0]
[0] https://lore.kernel.org/all/d1e0d4e0fe74e60345a3d043fb4f9128c1057638.1778141145.git.tommaso.merciai.xr@bp.renesas.com/
---
 Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 2cc66dcef870..5add3b832eab 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -102,6 +102,7 @@ allOf:
           properties:
             port@0:
               description: DPI
+            port@1: false
 
           required:
             - port@0
-- 
2.54.0

