Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE95FCCF2D3
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC18410E696;
	Sun, 18 Oct 2026 14:53:56 +0000 (UTC)
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFED010E3CA
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 10:33:23 +0000 (UTC)
Received: by mail-pz2-f6.google.com with SMTP id
 41be03b00d2f7-cd616db42fcso287541a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792233203; x=1792838003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PE+HwLCwRnxv9Z9DzgjUbOHs4/5c++tnA7FG82mBFBc=;
 b=EFx5wQO4ilFEW6HiEPx42GcCzy14Ni8tm+okv34kvc7TnLVwP+dnB/jzuBprECPwGT
 y4O7+nnVfrHTrFHwWcV7v1kqYISeO/9OYS4hZzOqEb+4kZj/ocPNtcxGb5r23mrZpfFV
 DqhDPBg18DrdVQZaHG1VMb2jWBraHk2AzTj7g1BY45IzvIv+yXu1ZWcnHeMgQ+5xuXnN
 evtLrSXKEeMGtXwhwbwgcQNq/Mb74PTX24M5Ez+q7ObA3ci4oCnkK66mHJoxLkoB+9Sb
 xo0yEADsAWMbNX2uFGOPCGfkjSy7/3Dz9HxYmu3gRhlfz1KujrKnzaSH7FMYL7ms5mEh
 0IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233203; x=1792838003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PE+HwLCwRnxv9Z9DzgjUbOHs4/5c++tnA7FG82mBFBc=;
 b=CGYSP6fNoBgxCVa9Z4Ah/a4jvwlbS5w6zJgZn/1nA6Gzfkpw42AwjgJjx2esohYFZi
 IeI+ctYzk73QjmXtyXCC7xTI06ItcCBhcz+TB0BkERhQ9irHC4by0VipKZeaZ7NQDQSL
 o21M4JY0pBzKqyA9beT3UlMQMy5oIzhCsBNg8onlsYHY2UAD//2fh2j/uNQuoc6wf/Jy
 b9uKMJOGRHrOSJ2sMuOQ0dk5eK92wYB1jdPXDy0MLLmQWc6/lNyR6bD3AD7EqcMpmV41
 +AC2bRsxmWKDOTgO9X+IombsbJ2QCqNl+zXa39z/JeVHqS2HGvAGVodmczbZCd7nfdsp
 j8PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGzljcBqQ9CW4YSzKFuMuENaY5U6k5NHPih+3dTf5pIBkYOPqw54YPPLXjVthu0yRx8Uxm6dmE6NE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTk8S/i7tgg6EcpMjokYPCDs0rAPlkOBpCgF5iSxWfzWbIECRd
 kKfSNVnc8v3p+BUpHSph9uTEFOfUi+Hia4RAKqKHsCX4drZtHwkXJkUJ
X-Gm-Gg: AYBFou2fGUXp8TudpWDkbw5ps9x3pX1JzXZgQWefHii4Rt20xe6rywoGlYILjaWthkT
 3eXxax2vDEhv4dAWr1UbmbWolYwf/rb/EXEdGC3/B0hIgRtWLQ54gm136k4cITY6arhmwDW9Jw3
 6h9w8KsdOPKTa/H1hMh1PomDU3n0OxSNG2f0VaTUCbBesP3s/P3Oha3FHVhQBmn6Fq05iLxDwjr
 lGIkbSIILO7JoMg8CsPzx+0Y0V32m+06txsey/iU38C95W7FusfPLFp0e0FmvAO0vYEusf8owWa
 jZWIzSWV6OXavNdYudsJEDcHsHZiCUCpJbL1iBo4l6+1Hss9PDUFh/Zou/tdoAEhr30gJAj3nW4
 F7ot6eAReA8QgmgnXM4SdPUo3yGrSQYrPGBzMZET5WUcp2pdrK7KiieOtjhQzb9nKZUsK5fbL8U
 Ysw2yPO3fwlRbPhalvWTvBBKbLwzkTmQctIzr8FXZ+Ds37kx5bk/OFYBxx
X-Received: by 2002:a05:6a00:13a6:b0:878:34d7:6a24 with SMTP id
 d2e1a72fcca58-8a04be4a6bfmr1651573b3a.38.1792233203390; 
 Sat, 17 Oct 2026 03:33:23 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:372d::57f:4e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f58414986sm2051585b3a.57.2026.10.17.03.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 03:33:22 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH v2 0/3] drm/panel: Add Smartisan TD4362 panel support
Date: Sat, 17 Oct 2026 18:32:47 +0800
Message-ID: <20261017103250.800109-1-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017083531.766557-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: Lu Chen <tianshi12127@gmail.com>

This series adds support for the Smartisan TD4362, a 1080x2242
command mode DSI panel found in the Smartisan R1 (trident)
smartphone.

The initialization and power sequences were converted from the
downstream device tree with linux-mdss-dsi-panel-driver-generator,
and the driver was tested on a Smartisan R1 (trident).

Patch 1 adds the "smartisan" vendor prefix, patch 2 documents the
panel binding, and patch 3 adds the DRM panel driver itself.

Changes in v2:
- rename lab-supply/ibb-supply to vsp-supply/vsn-supply (per review)

Lu Chen (3):
  dt-bindings: vendor-prefixes: add smartisan
  dt-bindings: display: panel: add Smartisan TD4362
  drm/panel: add driver for Smartisan TD4362

 .../display/panel/smartisan,td4362.yaml       |  75 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-smartisan-td4362.c    | 263 ++++++++++++++++++
 5 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-smartisan-td4362.c

-- 
2.56.0

