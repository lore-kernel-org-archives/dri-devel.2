Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390BCCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D095010F5D0;
	Wed,  7 Oct 2026 13:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="NTGSFEmJ";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0157110E183
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 18:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 0C2563D81826;
 Tue,  6 Oct 2026 14:36:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZkvDCHzsCSi8; Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 3E0E33D81833;
 Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3E0E33D81833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1791311775; bh=NwilUudvHR64yQJ5WBzZma1gFM83v7HbCJfxnJwVZes=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=NTGSFEmJKz+lELcDJejdRt+hHB1rmN+9xzLPHW3vof8aLCJgmMcFXqBeC4SDbUsOG
 GtC/P/EtKyuUx4LmMMexI3a3FuuhR6j+RSUMxUMsmr3ZbMdTVdj9gAvXtFRB8j0b/x
 dNa/pDp54Lkgt4fikmh1ZIcxEhGh3qRtCvmKJa1/huLzAXM6qVOgbFpiS78GtvnfLz
 mS/feS97d6I7SsQJiXwDNjCgeujN2A/ZAp+EUOjtWRApzTqoUYT0MdPRrEbcXF02pD
 d8Ef0X7ijX+1iPO6PeZEQp/8mToL7HBgWApi9Y+gq2FCMl4lBa0lrnpNEsUr4I7PG3
 XvBymVVlnRfKw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4vAwc199pX0Y; Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DE69E3D8181A;
 Tue,  6 Oct 2026 14:36:14 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: add compatible for DCLTek
 300249 5.5in panel
Date: Tue,  6 Oct 2026 14:34:54 -0400
Message-Id: <20261006183455.2350966-2-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

The DCLTek dt300249 is a panel using the Ilitek ILI9881C controller.
Add a new compatible for it.

Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili98=
81c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881=
c.yaml
index 42e35986fbf6..6bcfa67be854 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yam=
l
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yam=
l
@@ -19,6 +19,7 @@ properties:
           - ampire,am8001280g
           - bananapi,lhr050h41
           - bestar,bsd1218-a101kl68
+          - dcltek,dt300249
           - feixin,k101-im2byl02
           - raspberrypi,dsi-5inch
           - raspberrypi,dsi-7inch
--=20
2.34.1

