Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E83DCA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891AF10FC66;
	Thu,  8 Oct 2026 06:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="CXbU2lsI";
	dkim-atps=neutral
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516E010FC64
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bv1jDj5+4ceXExh4la2r4jHiCrVNiMGuQvVHrbsH5P4=; b=CXbU2lsIDxPYw7eV5m2QYZ/CUD
 5h+tWvx0DANzSN+8mXe6+mNXtic7+Eb9rfLtNAuwof69TwKND82dMZzN+CL14t9pcL7FakHmR7pCN
 WD1mDUFnOkp+E4OfU6P4y8SJMDiAwn6vOUlZR0C/QWsNvxiBPEA7o7laWmiWjqK2YE/eXCELa0c4O
 NoOKqpP3+NKM4RLyTDMLMfZmzLTSVj0SCFPoupwDDJSOEvHEJ2tjhb1M1ieb6ENDOdvTvBWvEqFYb
 v4fTpYKZSWjWCzmM8tc9d+gQIzJEO5ne11KdQP07b8rnZTmGeCZryDOgkzQ7wbyfJhMfcKbMRz569
 ZmPBmlvw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46684
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xEgqG-0000000AIc8-2qgg; Thu, 08 Oct 2026 07:38:54 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: [PATCH 1/2] dt-bindings: display: panel-simple: Allow "data-mapping"
 for "auo, g104sn02"
Date: Thu,  8 Oct 2026 07:38:49 +0200
Message-Id: <20261008053850.2941955-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

As per the AUO G104SN02 datasheet, section 6.4.1 "SEL68", this panel's
SEL68 pin selects between 6 bits (SEL68 low/NC) and 8 bits (SEL68 high)
per color over LVDS, i.e. an 18-bit or a 24-bit input format.

Currently, the auo_g104sn02 panel_desc only allows for the 24-bit
configuration by default. Boards wired for the 18-bit configuration need
the override introduced by commit 1cd3ea3e4b12 ("drm/panel-simple: allow
LVDS format override")) to describe that instead.

Thus allow "data-mapping" override for "auo,g104sn02" in the schema.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index eb49832b26c4..11d4a8275ecd 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -396,6 +396,7 @@ if:
       compatible:
         contains:
           enum:
+            - auo,g104sn02
             - innolux,g101ice-l01
             - yes-optoelectronics,ytc700tlag-05-201c
 then:
-- 
2.34.1

