Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35454FA0C3E
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6164310E68D;
	Wed, 15 Apr 2026 07:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="QKdUafRQ";
	dkim-atps=neutral
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD9B10E05C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:41:10 +0000 (UTC)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-9539d9f1675so3611939241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1776202870; x=1776807670; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qyy2EUSFHuUvP8vn408rgcFPQdBTOKcJ9K4PyZHCKk0=;
 b=QKdUafRQATl+q9azpVoTwIXGL52thG9DoJ4IadPfFLgAppoxpZU+mUTjV23I86i/7v
 yUGZfeTZdLO6juuVdnVGPnlx+dAvlBQhKR8YjxXXHc65PSH9Zo9sBIEOmPHRo6wzwayc
 xeGfDVCxiC31Sl8AGuNuUQiu/z+n10wXrxSshKagesP4QGDECwaGNfs93zoDPsH7euix
 1lUmmu9qmYOegTTDaStaA9URlVOMZhZN5zyChAvzFfTEhTV/I1YmSvYvrJJv5Apd2YO5
 rr/D4Z/V63Mr/VUGJA7JANU35nzqNNTuDCT1gpD+2hnyRj25ziCsTIa5ogENDHbPfZhW
 7aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202870; x=1776807670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qyy2EUSFHuUvP8vn408rgcFPQdBTOKcJ9K4PyZHCKk0=;
 b=J6ojgUQ1ta2e7/TcMD7QOmOs4/KLuu3hzaFiSi6y2q7ww6ov+U5NvkLS/78jnakbtK
 y9nwwDD/d6ZQf09iMrzlu66MdCYnoS4gAkW3dZlM8Nui3r7OJC+MdgvBpLrdak92+U3O
 svOvHHgCWVolt43evaHpVLw3sitViMIdJMTTK7GHqvFJ555xqlMaUscAdBuBa5tLM233
 KdEoNy63PSSggt92by00Zi5KDo/DPlMmLnH4en3lXA76UfkNJQoB3/6UcpisE8pKjZzS
 bJLsTpIgS+PZNEIBwUt7NIooGigx9avdigNWKcjcYP134PSD/u0He6ACbyLE28FdEBEo
 Jy3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XDEczpGS6TOSNghNSvcXX5XP9Wxr92F1l0eOUM2sAWVDy3Ct84hKxxTtGw5wOog1XCistnCmAm5E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhnAxq2XcNjLSUr3qhoZWSR7Q4iKczLdy+27RV3osVT58yenSI
 EMzVHNvV3M4NCuyl5S7AzQDzjej0vTISJzNlEa91d7Mnt8u4O4dcvnkyAPpWXy7mJMNPWXO+2GP
 /9F0sxB4ayTplf3rqA2zHZIcQz97gRp2dqjCM
X-Gm-Gg: AeBDietUlTbkMEV4rhJJXrQkOVCxXmgF4QN/zIl+m3s+fksk/xKseHevBoBD3OiePzW
 5xrCjgtYPaSQLV4syAWXpCcU7u0XP7jDqDJ1s85aR+SO0/nykogXfnccysDCVFtidWoYcVePdyZ
 KDHNLSdb+O4/9xYWT1ph8EPxl+XnQPYJISpu5B/+gHhZcoslJKP9S0RI482afnhLr/6DcAhr239
 svkGvJjTpyyhSwSE9qCVgfTzsFmh5T2XNAherCsfHA/07GlRe74ikA31JOInYvBLt1Mun9Z0AxB
 vk/AHDSSXgNmQDa0yJp4kDl/Ddkfh6AxkXrx7ILvQ4fzoVA2HYibLpb/MLwwkpZWD9cwGGkI8Cj
 gd0fdKmwnX/GAsvmmW/5gVVVJAZgQkzsZ5malXQkr7lMW79KUMgJ9MtE=
X-Received: by 2002:a05:6102:c0c:b0:608:9c0:4908 with SMTP id
 ada2fe7eead31-60a01271472mr9236374137.32.1776202869938; 
 Tue, 14 Apr 2026 14:41:09 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-95691131afesm346899241.1.2026.04.14.14.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:41:09 -0700 (PDT)
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
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/6] dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
Date: Tue, 14 Apr 2026 16:40:52 -0500
Message-ID: <20260414214104.1363987-2-dennis@ausil.us>
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

Add compatible string for the Orange Pi 5 Pro.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ae77ded9fe47..3c6b83a84463 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1320,6 +1320,7 @@ properties:
         items:
           - enum:
               - xunlong,orangepi-5
+              - xunlong,orangepi-5-pro
               - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
-- 
2.53.0

