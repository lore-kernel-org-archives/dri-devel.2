Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EE3FF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53DB10E51B;
	Sun, 26 Apr 2026 06:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="lV0eQJ5/";
	dkim-atps=neutral
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC4510E0A0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:10:20 +0000 (UTC)
Received: by mail-dl1-f99.google.com with SMTP id
 a92af1059eb24-12dbd0f8063so2403282c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777086620; x=1777691420; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzwyg+Q8PpdccnVWRF49NDrMOdX2e/qspSUaU1qJfGA=;
 b=lV0eQJ5/GgnR3i/Ebil7osKqN1gi2CHiriENiRm6I6u7xrISCV8ro5+40CMedNU5tc
 i082TYCD7vgaG3NWJKNjEeDuGm8PxqIWRPTkG8J5ObmwRPaBL40ypnm9uUKiaDIa7k3v
 WXoPmm4KeAnUAQyPNhfVmBPhGMt8m4aw2j9LPWEDLHRMNJmxHssJ0eC+Uf/vtf5PNAZ6
 EMsXnbM3hlisfN4z3SJGn/UUpr4x20sIP5CTkEwxbeDYzOOdaTwTvAKIEW2XFz0zqVBI
 4iFGyXAGdBrZmZxYiLaDyQfuhVkHaN/Y0l45TNg/bba+i6z3HQnjH/9R1g4IVK3yWMoU
 xpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777086620; x=1777691420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hzwyg+Q8PpdccnVWRF49NDrMOdX2e/qspSUaU1qJfGA=;
 b=q/6sW/axTKX0uRVTT0wqxainhRn0B194sm/Z2cOdYemAkyoO6e1jY/za6QQFwZJ+z7
 1k2WH/J6y5A0sI4PrL/tqfwrEj6wfp3eunBRkaX8XE/wSvyWKan7WaDX4STgqUDllI4W
 wXk9svs+ahvEEH0p2Hi/s98kC9WyDmITuRZ7WHWsk6EnxcqoRGMte4ioE7+m5VbFMq7o
 YxP+yIDrX2MqeP6oV21PjZCU7Qd34PzPgswMDqdWxjqw+tjWmDYbsf2ErzCmMgMBi9dO
 EytUw1CjplDb4rFZ6uSPgJ/iXvE/5MLD89aC3lSD6H0ui93Jlwklx6Yw6D45KsLiUH+r
 0YsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LkjFM4sLqGP58vqL1LTiyxMDFn6W5pNWrSPhGMKbMrq2XMS0FyBt6s1sh/TzZIDTiDCE43Glx6Ms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybTGDBVcizCWhWuMJWryHEj6tAlbGRlqnMtPudO4LTRy5lBcRW
 7YLPTx1C6JD5+j4yGP4ZVP7Nn3rARkIi5Rxo1d4B32N7o65Op/1/ronCw7CANodTv64J5GncRb/
 BovhIYv8B5WVtUI/rDovvk2850lv8F2qVTThu
X-Gm-Gg: AeBDiesj7JbkXP3xk6Wj3Gq9cyM0/ae0IRuNvQ3Gsfs/8N/kaJsB+/VfPlaLdGEqTSn
 0bR2EFN68cIEIeaCkj5nyybGbELMcHjpAdjDel+p9w6LeVcO7w5ROsCFEggqucYmrWPSpQB6OAF
 qZ9gMsb1GFhbS3RtCvtounhF4X92AAHAOMtdujQ7HHff4WrxJ6q3E338Z1bv342v/+gtbYie3w8
 bD3V7+zoFOOXKo5PS5AHhngozM2p+ByXosthKLF4+xvwKOE3lz+U1e9vARWuLv/tNxiGH10Uu2T
 amyU0oDeoAivISBq9s/PzU3P3SUdIV8KLoN2kmbkeqZkRUS+vkMFkLwZ2Df5DZ/YILnZ4eRl10D
 nFPsK891SvOlBdWAHwQ2rfuvmxX+49/hcPuousnoHzZc99kJkEplb1Rc=
X-Received: by 2002:a05:7301:3808:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2e479724538mr19046348eec.16.1777086619649; 
 Fri, 24 Apr 2026 20:10:19 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2e53a3ae691sm1728646eec.11.2026.04.24.20.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 20:10:19 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 2/6] dt-bindings: display: bridge: simple: document the
 Lontium LT8711UXD DP-to-HDMI bridge
Date: Fri, 24 Apr 2026 22:10:07 -0500
Message-ID: <20260425031011.2529364-3-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425031011.2529364-1-dennis@ausil.us>
References: <20260425031011.2529364-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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
2.53.0

