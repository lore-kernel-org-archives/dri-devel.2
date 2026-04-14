Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77C5FA0C37
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0714C10E681;
	Wed, 15 Apr 2026 07:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Hjhyr3JL";
	dkim-atps=neutral
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com
 [209.85.217.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D547D10E05C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:41:13 +0000 (UTC)
Received: by mail-vs1-f97.google.com with SMTP id
 ada2fe7eead31-60581b491a0so2031563137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1776202873; x=1776807673; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCAekC6JihikkAEuEdzid7oOkeSPTTqIBC2dONRzXqc=;
 b=Hjhyr3JLtCiMedcm8NHZ5WhrfJeGhXeLM1YG5Fi3meyqPk/Qvkvmr8MmpH4rMxMBdU
 YOriTGrjGqzCq4NLmYGsoTawYHLt+b58MtKhnmw6gMGXfMSRL4CiOAbNr2WlujTG1zq1
 t9xT48oUFfcqZh8S1e4FcA98vuWlh4saikrRMs3kfy797TxX5vZt8ubKpJinLR1Iaf5m
 xADwgjDw6qmiDZ3NUVuvFoh2kWa/wXo94QoiOC8XTk+2Zlb/nh6KXyg4AmcDZOUFZkNO
 /OdcbshIKULbRlzoLoQ136uAG7V/EzdFqCIDVFdLFEwTyBgweFjwH3henpe/Z31j0rkL
 HQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202873; x=1776807673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iCAekC6JihikkAEuEdzid7oOkeSPTTqIBC2dONRzXqc=;
 b=Uk8lLnG6HZiP8B3A5kyzVYE7uSm81iBDfTk8+26yFjcfBacS4WCpFztYqmumwEwvpc
 rfS+SsSZRxJou8bpYaWhENId6JxzYw1Ber1EUVfmzmBycfiYjw4nMDhz1xXBNDwQ4rcV
 x0YgYBZZKbTiXlRwEL1ceD/QpRcvLAHjSdXMpw/6zzxKpH0t4gX5qlUvgBLmkSXqhOY7
 NwNCZS2xH2ei0g8TCyvb7Y/REO5+Euvys+V580uOE26PytvA+MUe5cXS/apOjlWC0NMj
 LCLi/tQ9RA+VEN9TfC4b4lZNFrMuTQrxmYon3YuyObo7Y++x5xfjiRd+qaEUtC/o70Hy
 S0FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ru4m/Rj2UdBUP3yF526boKfjzBE8DlkaxoQOPbdkRO3z7LdtRUBI4KEDl1SDV5qnNZNqkZzpJJNE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxASdrUf5W+GBRBGVHFbJtAzrf1n1N6uoJjLLeQrEnYCuCR6nP
 9HkHK0HpZD7B0dDKltbcPdj36DiAXE9ion/T6Bg08JyHgiaumu6hQmvk0sU/9yhVFgXOOwSAcnq
 RMWe+muJlyu7+CD69jSoOr0BQtbU04211hUp9
X-Gm-Gg: AeBDievza6LE5ZQBJrg6qodVz691ayly+eh3uQ5X4EEzhk4/U+zh5geGJCcCs6UG8kD
 vjwKD4c4JmJMUCJa8jKNEiHbfmQjCMYyimzYZ/p/q64IRo5OH3WiIa/omTon891TGeD2U7xlqbW
 gh5b55Xy96f0A0unRrgtFrdyK2cTPdwHGqjfJbEpBIEZ58ipMNyxe6TQrkX2EKwEUEJTCFLqiyu
 +HyM3Us+eltMw79+PaIuoZB8bUCPiKVn+pZIckFOItU9Z0mw6YLUy/NIGqkUJvjCILuvDTE9pBV
 kIyIOTYjDVp9i5hFjMy0BhuRjQ6Ujo8jgafT8psSE2VM1QtxZwItmx5Kd7Vha5nScZMP8bsdCE7
 wQHRBpUSr/437xtoaH6WKgHPTBxtyhVQlYEY1wPTjJ10p/M0S4dycdDY=
X-Received: by 2002:a05:6102:48:b0:611:959c:86e with SMTP id
 ada2fe7eead31-611959c25e6mr1708483137.32.1776202872864; 
 Tue, 14 Apr 2026 14:41:12 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-95691131afesm346899241.1.2026.04.14.14.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:41:12 -0700 (PDT)
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
Subject: [PATCH v7 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Date: Tue, 14 Apr 2026 16:40:54 -0500
Message-ID: <20260414214104.1363987-4-dennis@ausil.us>
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
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 8aa31ca3c72d..42c1f3d5ba0c 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_match[] = {
 		.data = &(const struct simple_bridge_info) {
 			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
 		},
+	}, {
+		.compatible = "lontium,lt8711uxd",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "parade,ps185hdm",
 		.data = &(const struct simple_bridge_info) {
-- 
2.53.0

