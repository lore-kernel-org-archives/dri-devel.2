Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CDEFF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C98D10EE3E;
	Wed, 29 Apr 2026 04:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="e52F/Xbk";
	dkim-atps=neutral
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com
 [209.85.167.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DE310EE3E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:15:37 +0000 (UTC)
Received: by mail-oi1-f227.google.com with SMTP id
 5614622812f47-4645dde00a7so356929b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 21:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777436136; x=1778040936; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUANSDjJgu1WXHjNheDgVJfCwB+h6we7yJfErm3QH3E=;
 b=e52F/XbkW80EeujMk8WoIw5TJAKBpZdcLpPC1gBXPoIUnadXkdJHXztQHpdIFsadZp
 tNPmmnM7anRmTY599WvzVzTdiVyhgSQE9/iSQUszVRVcw5fPj0UFBxDo5jV1aprDRMlL
 K7kavIEDFH3/4+guUX3uh5mLETdRbhbsEFrFYvdpLYRM9zKc1EBhVOfpVxpyI4IE6up0
 S8dKTuhwCbFMj5wCj3rKmlYGpe7ca0XzlN/geNb/RQpyBVYhoawXnd2eYeLCF+9m1BpY
 C/AdGM6gAxpOSOnclYoyLVlh27gQAu+M4frGIZ7KBes7slnT+xM5BQed8j95+bkvwrFT
 AbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777436136; x=1778040936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cUANSDjJgu1WXHjNheDgVJfCwB+h6we7yJfErm3QH3E=;
 b=bgUs0EpSfPEnl0ZbTJWaxkyb9x79wePPkLZmavEwb1/hGi18CPZhHzXZmQEjnIxeAo
 K+hcyXjkV2nUXyufMIF+pJ0AHFptSEG0AEJz4TxdmX0+JC5BxMhNcGlTT976c4fMoEfc
 T16os7qGOW+olfd9070X3EbkEQuGL8idnA+Nv7Z1vglmjZysA5bnZtlzvsAaV6s9qCXk
 FYDhXzQv1YNgyesOSTW/RLBEF+ToMJBInq4FNiDPt7DZc/XDGHV6gblK9iISAZL2Ychy
 g5MI743LIfDa7R4165idktKilnEkxLLT0c4LfWShL+FeUv2dzwgwc7En4Hbt3ahJzV2R
 L86A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UW3CKivn/S88tcVgJGTfJ3Grk8lB+JdRHUYWX6wNiY0zhA40pzCbyjEMVNHtFA67KoWxkKrnrlkQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy//tV4AVH7w7U8BI3xtiNoh1tFCqLVXjj2DY0JbfTAO9pnrOMw
 g2BPtlvIDH9w+wlc99E1sGwsWHgh8o01a1TRYZFeKNVBLvn2L38zeYgNfUse5ZTGhMLx26ZdxzC
 0CVX3/7U3bN+wTz6DXxmC8LtAfLOjCvb/BP7h
X-Gm-Gg: AeBDiesvXMKEeyOsFp8Nl08g4cI6n2rSFsMzQ8LqkSpJsre1sEP8YXx2eZJcSO0hjQH
 v7dlPdFBDD8akHFMranTCqVPITFLs63egv1JmV5RWvPD0skbjFg0eGZpHsLWfifF1fOjoaIq/Co
 YmeuVtv4V0g+dCoE/0GZ8nJ9zq2GVEL92KS9bUjNEVB5c6yPghDZ6wnVvnD2TEJxteldv04LR8B
 7b0RmhkXj+3wGchR8WSNkdWa5pqJBiwAuUs6bddC5lpYEgV9F0CzeeutO+kDiBH+TJWK/CYgMjV
 AZICRo6Z9I5wn71vMkLWVHykuVh/lHbUDJN7gzUYsmHLg0kzEbXOmvOvz0HEMqq4MNHguPo5/DR
 fjKrV0MQtlRhZHBwAl3CTWV36bYly4WCEZSu2lS4eXZWG7uxK451w4Jo=
X-Received: by 2002:a05:6820:2210:b0:67e:2a62:35ba with SMTP id
 006d021491bc7-696699b7162mr686474eaf.15.1777436136286; 
 Tue, 28 Apr 2026 21:15:36 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6966baf952asm41557eaf.9.2026.04.28.21.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:15:36 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Dennis Gilmore <dennis@ausil.us>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/3] dt-bindings: display: bridge: simple: document the
 Lontium LT8711UXD DP-to-HDMI bridge
Date: Tue, 28 Apr 2026 23:15:26 -0500
Message-ID: <20260429041528.558254-2-dennis@ausil.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429041528.558254-1-dennis@ausil.us>
References: <20260429041528.558254-1-dennis@ausil.us>
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

The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
to HDMI2.0 converter, designed to connect a USB Type-C source or a DP1.4
source to an HDMI2.0 sink. The device can be running uncontrolled or it
can be attached over I2C, the bindings describe the uncontrolled mode.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
2.54.0

