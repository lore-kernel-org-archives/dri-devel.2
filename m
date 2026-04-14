Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF2BFA0C3D
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E7310E682;
	Wed, 15 Apr 2026 07:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="QGNoPnuK";
	dkim-atps=neutral
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com
 [209.85.221.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B4010E05C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:41:12 +0000 (UTC)
Received: by mail-vk1-f228.google.com with SMTP id
 71dfb90a1353d-56d89f35940so2087204e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1776202871; x=1776807671; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pdc35Ylej5ItvmLOneRVPWcqxy/OnSmxmxiLCyeKGpU=;
 b=QGNoPnuKQwqEnNb8a899VQLNqZ2vCN9OOUvH184L9GGVf+3km+vOQzMWc9N9xU6YhJ
 0/XdR0K2WmhZGPaXfcHmXZ7gS0FOtv4riE55UlmqExVSJLo1ZDLokoBWnB9Kp06sF6qY
 Ne6e/0BAOdDwd889Jllt01p5b8MwiYbJNIZMgU2e7d5/LXo8dLs4ujuttQB/CK/S59KW
 IgTsfxwC+XnrZXWpnH4F8kyka/aMebV9PoJseroiu/+sei093nTPI8aSh7MM9lEMSpIs
 iT29ugin+gCu9fwJJxYtjQJGlVIObn8CYmv2B5PbrINP364yjvUzK2ZGNGLmhef3u4eW
 qnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202871; x=1776807671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pdc35Ylej5ItvmLOneRVPWcqxy/OnSmxmxiLCyeKGpU=;
 b=X+Jdf8z0ZYJeebwo6Z89hdPhKhxA5dlE4vM3F9Ks20q4HgmNod/dbI4UjKDyseFhKM
 XlmNPhPAd8OpKk0atsc/cNT54JJrWql/XAgLPpVWv2kqA3Fw6nw/xApYUexiP+ODrNcP
 Qzwuqinmky3DEioN7+rh7vFviDcU+pb3DtpgPoNmmM0iiUHnGUvgi8JGozeWnfiblrfc
 N+rBsslMYRJ+ErN3tODf1YEDFh/XGyC+2huZpmglTJao3zQIpR3zHcGkj2y3qqHZjmZe
 782YHdu/K7rWZWVtrhamsu4LrMUeYiNwFJ0FcDyfT7s+RQTDyEhAg316eRSkDuEEmMlv
 8f0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8x/3rjFrJctxkOMTDH3nfQ4+bdQUusG4z+kD1eMHJkLeZrcgrELSOqtGwU/eLtguloTcIDdvo5z7w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw93p8IqMtsPz+nUEa3cJoaQ+MF38lN2wNmfnYRZE/p/0nyG4jX
 PWZBaAfnjfhnwfDi0ACjIFtomFfnAqGUjBl5gJyb5ix/HYhHZ6wRnFp0MwWIST1/kOs4/PhUKG5
 rpVDsrw9lOqaUshDU1hfTUzSotuiNqC4lggus
X-Gm-Gg: AeBDiesJQOSMqjbkLXBrOWd3MmC0ZZh32G/jiF+f0CdPowxSI1CTcjPOuOe1x3x/dUB
 VbnGz8zkbr5EwE25cyQenJJcBjiOXz7wWB9RsAkUGz9PaH2ckTrcN2e0Oy84z0gTdxxjWux74p9
 cggeyOn4jifxR4avPI8w1YTpYXsLakd+RbnGzp/zoeaspcB8n4M5gNT78LWb3h75g5iV4yWw9Qk
 sQ8MZO4zIw+Lj6+Vof+oVQuGm8XtTnyHvIQzpUDqP8WJ20jXTC0Kwvw31VTv8IeLxE1axTRMiEh
 Z1Nwd3ONHDvcchs8HfRy2vglKwpuZ9O5FiVjw08hSzqIBsrywXEr54uXxa0BQLOHCkW7g+lOI44
 tDpgRIQspptrAm47+/Ei9Wqg6xUM6MHeZ1Mk2CNe3ZwA9YayzLNyrxeM=
X-Received: by 2002:a05:6122:4b82:b0:56c:ce0b:fecd with SMTP id
 71dfb90a1353d-56f3bce78b3mr9047810e0c.12.1776202871351; 
 Tue, 14 Apr 2026 14:41:11 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-95691131afesm346899241.1.2026.04.14.14.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:41:11 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: 
Cc: Alexey Charkov <alchark@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, Hsun Lai <i@chainsx.cn>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jimmy Hon <honyuenkwun@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Michael Riesch <michael.riesch@collabora.com>,
 Mykola Kvach <xakep.amatop@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v7 2/6] dt-bindings: display: bridge: simple: document the
 Lontium LT8711UXD DP-to-HDMI bridge
Date: Tue, 14 Apr 2026 16:40:53 -0500
Message-ID: <20260414214104.1363987-3-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414214104.1363987-1-dennis@ausil.us>
References: <20260414214104.1363987-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Apr 2026 07:14:48 +0000
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

The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
to HDMI2.0 converter, designed to connect a USB Type-C source or
a DP1.4 source to an HDMI2.0 sink.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index e6808419f625..752c736c8f85 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -30,6 +30,7 @@ properties:
           - algoltek,ag6311
           - asl-tek,cs5263
           - dumb-vga-dac
+          - lontium,lt8711uxd
           - parade,ps185hdm
           - radxa,ra620
           - realtek,rtd2171
-- 
2.53.0

