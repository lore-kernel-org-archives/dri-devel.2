Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD63606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ08J85x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B898410F9F6;
	Wed, 25 Nov 2026 08:41:36 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAE310E838
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:18:30 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so39686625e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795547908; x=1796152708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yPaStIqUsFXmNLYCrNHs2JQTzK46Sd8vnaUQkzY6azQ=;
 b=KJ08J85x4GO4UkVpcAHbDOunL1eV3TkijjruW1MX4ZQ/3w8Jgl6QehcmdZ6xa5jOW4
 Uadtv7F169UzzqxePtdqT+w4ImVoZE51Vj1+PWNIwHGoZZJn8PMkiSdLbBXIb0Qlx0s8
 fXswaDEXG8TIo0ZasxCPk6J2t1Ngd1+v1D4BokPVF3VGDFi8ifg0iWEWcJaiu7VGngtY
 C45wzRWM+7cHEQZ0g2aP6iHYhT0Bw3qYfohdoANQWCDA0HEjU2w3c9wBXPyIQs4xC5ry
 Sj0mKjkP02nu1yHDmUBbELBc2+ZaRzSxK0foAj5scQCRCr4h3Siw3rHxuSd9xdGZtMGr
 uBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547908; x=1796152708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yPaStIqUsFXmNLYCrNHs2JQTzK46Sd8vnaUQkzY6azQ=;
 b=2brjVkHJYP1EML+xNAmpRa90D2k7k/EaLoZ9FyAzWv8SoZkd8VHTCmcx3KJZUrfHfA
 4A3XAYmcKUYWZo21I9+OdA1v6Ls30cBlErZuq76MZlue8JM06XOKmItGLmnRLqhHLRo7
 0/hNofB6Gfjpa58WEfT8SG8K2Eio8VKMjY19mYH99fxoxS3pvbX54w1bF7LU8D7KTDsI
 5jQJ/FgBmUrNqZx41j9sQMLgndDD27V9LEiBU+ObCfzoP/Z1rCiNcigwpjkrrl9lwdx8
 1luU09t4XN+t5oGJt5DX+dU2IWKxOj7woCbnSMhAsOaelvrkJppA+AAM/aZhNazfbl+4
 nZog==
X-Gm-Message-State: APuU4Z+WWPPb0eKpp+o/+QwtjZI/qv4+Sb8gfR8KnfDlBswIpiIWyD/E
 GqaMt5YGGasQn2Az8KR0P17lm5opLSGZNwdtQePznS9xD0IJkEOsZcU=
X-Gm-Gg: AZFdTZcSU65Y6AwcRkuWB3X4HmWlFaMA/Epxv0vMZGHpeUgD2epYABheq5kUmQ6Df+R
 euy7WGaVcdGCgjhjC1x7QNq6boEPqV7nJG7v1Ba/d7AKes2DdWemgVqaehwe46YWxQr9GwLiHhm
 eji8uh2j2J6EriNj2332q9x7iXjKFFw3Es2QtWsRZTZZSq2Aru64qIsO7GJNE1Pmhj1KrhBVnUj
 f7K9Sbo5tH/yS/fK6tL/Jy4PNIkr8gQFsO0KcaYKP2ZM+iRRHlstNc3CXA+WKDzIgq89SQ3f26n
 XqrcZhj6jm51HnMQqzWSClfAn1/Jg6s1DLBF2eYs+pbqVTPGKo29q9f3fVluPq2GnfCeBbzbZA+
 Gu2b39Je63YN/1zmowIWdzBZWC4KhS2lRvu6e6NBxYgzEvcOLxHkVto6QNFn0d3uu5jTE+g2t01
 ABUuqEdpBgQukVqGOd5X867NPvB/M92l0ii4nO8EEiL80sDXBz+340uVkzCK6yjH0Uj1z5nYUtP
 nwAF+hZEbL4/WJ6kIRnjQOmjD4iFpPJH7LAX25c2yxbItNaRqFseoaqAJq2G04a0fXBl6v3PPsr
 7BdE0byyKRLbuRxlQ1Aew2X5SD6uRdI3/trbAeTjIe6oCb6UrRoDDA==
X-Received: by 2002:a05:600c:5249:b0:4bb:665c:a078 with SMTP id
 5b1f17b1804b1-4bb8893a89bmr317787135e9.28.1795547908057; 
 Tue, 24 Nov 2026 11:18:28 -0800 (PST)
Received: from localhost.localdomain ([93.145.31.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm463320985e9.15.2026.11.24.11.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:18:27 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH 0/2] drm/bridge: Add Lontium LT9721 HDMI to eDP bridge support
Date: Tue, 24 Nov 2026 20:18:01 +0100
Message-Id: <20261124191803.283266-1-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds Device Tree binding documentation and a DRM bridge driver
for the Lontium LT9721 HDMI 1.4 to 1/2/4-lane eDP 1.4 bridge chip.

The LT9721 accepts an HDMI 1.4 TMDS video stream (up to 3.4 Gbps/lane) and
drives a 1-, 2-, or 4-lane eDP 1.4 output at RBR (1.62 Gbps) or HBR
(2.7 Gbps) per lane, controlled over a paged I2C register interface.

Patch 1 documents the "lontium,lt9721" binding, including power supplies,
reset GPIO, OF graph input/output endpoints with lane/polarity remapping,
and the DisplayPort AUX bus.

Patch 2 implements the atomic DRM bridge driver, registering the DP AUX
channel (supporting both Native AUX for DPCD and I2C-over-AUX for EDID)
and populating downstream eDP panels via devm_of_dp_aux_populate_bus().

Hardware-tested on an NXP i.MX8MP-based platform on a v5.10 kernel
(driving a 2-lane 1080p eDP panel with dynamic EDID mode discovery over
DP AUX), and forward-ported and build-/schema-tested against linux-next.

Gianfranco Mariotti (2):
  dt-bindings: display: bridge: Add Lontium LT9721 HDMI to eDP bridge
  drm/bridge: Add Lontium LT9721 HDMI to eDP bridge driver

 .../display/bridge/lontium,lt9721.yaml        |  169 ++
 MAINTAINERS                                   |    8 +
 drivers/gpu/drm/bridge/Kconfig                |   16 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/lontium-lt9721.c       | 1640 +++++++++++++++++
 5 files changed, 1834 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt9721.c

-- 
2.25.1

