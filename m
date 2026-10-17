Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8132CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A3B10E647;
	Sun, 18 Oct 2026 14:53:14 +0000 (UTC)
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA8B10E24A
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 08:36:06 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4821449so420010a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792226166; x=1792830966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Q8IZ33W6NNgXpiE2H7gk1DjA4QMN4AQzf1Ck9B7ifM=;
 b=mzzFPyXuAahJ5zSaYlqNIHsdYTkt9MIYZeZxrEM0vqVlPjYAw6YgYiUDvvOBy5evUh
 zvMVnH8pWC088bqypBeUHUtSORzQxNjmym2/fPMcJ9kuY/DqVZf/5mIaeyszeA9HmoS+
 DA7dA16zFkao3ZbqLRhuzwQgKvmFcuCuY3oqFkxlLLsz86P/0JZVYuYQdK0pFYEBoyjw
 6FCyQWo5TjKEXqM+w8Fw6lYjc+/tSiY/BnjrofP1yZWCNSQGYRaLgytiyA8NtCFGA0vb
 lWhjuhQGrFugmc7FxPSfNFPL03Mt2eJCaTzLMtzH6zyYds46geA8/eVFb8Hm+lkyWbzq
 2JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792226166; x=1792830966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Q8IZ33W6NNgXpiE2H7gk1DjA4QMN4AQzf1Ck9B7ifM=;
 b=ZIKvNartok29D6ZKRmMtSajgIbY1t8Qp9fRElN1AXvfd8yxoDUL+pMumAwzDd8uQDu
 Xrjq/PUKYzzIxSW0TkCqFerKutUP4mkNjlRPvpWKjPIUkvt4sQ063gTLAYVUeZW+DmGE
 av+cbddR9iexxHBRsQBa4dtsMaEVfY4vbRGa/hzcl+521lFPUzlwBUh95Q2ZeVwO3MuU
 e1Xa8a6zZbdt/SaMpnrDzHyTr72srEFSfs51QDw2+9nDc6J28aJS70+3YKbMm15Ys6Rg
 IwCPMAwthU25IID5NAeQ1T3arUXZqdoFTMEDAs++lmnVl6U1c9xqJ5hX44/JQV7KCgmI
 ZEuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh0nJBIkMH8Fvrj0+YuJi6BZvs+W+Uf2Hnojc4YA1RCcFKqKM+tM85i/uip13mHbiv6c0ZYb6jWX8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKv2oC6ROkhDjVv4mnAYmnSd9Hb+fRXWMTMZiMyiej01sDoFWQP
 Z+dzHzGAfrgGgpBkUAQ1SbEI41Q8s7vkycaGUpg7zp4ElB1SfKtylnji
X-Gm-Gg: AYBFou2us9SKmKPxMA9VXC8HJs/xanmf+spxWfZc2GGZZpabGJLf1MMaRPCk3HCo6lY
 +WvbGK5IqEdc/CzOmXf2mlgte5rZpNCRECS0OIdbh0uxFpJ3YY3fKHOdOITrHcOZ7F31hdcqiEQ
 fGjyhhOity4LB9PmY3AiScWn1tDqtV/4F9wZHMLXpFFjnXtjHPo6U+V7Ufi3CiqYl5TdtGM9JnA
 LBX4nvYrbgvuhBQ3pr5x5AOO9RkNDUxiP0Bg/IO6D+PMsTSV+OPOVk7jOl+sugW/n0mXZAo5P5E
 UWgDPz0tEyhI6QNoKKDchlbWaKJFs7zm1sbf+M3f3yG651S6irvGtCKvYNZ24oEl1mC8A4suZDx
 ofItls48q0u1ykrPGsePpCWyxA09qU7yPOweDH8XVvIsVJ5cG/ggikuhQyKVWBYKs+KzAuFO5aC
 FAsbCh918h0sv68tVwHRGo8AFFvLD7+ZVIu1gwOmth/st6DbVu38GRixE=
X-Received: by 2002:a17:90b:5111:b0:3ac:a521:960 with SMTP id
 98e67ed59e1d1-3acee2927aemr1967627a91.1.1792226166418; 
 Sat, 17 Oct 2026 01:36:06 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:3141::4e8:8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm12548544a91.7.2026.10.17.01.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 01:36:05 -0700 (PDT)
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
Subject: [PATCH 0/3] drm/panel: Add Smartisan TD4362 panel support
Date: Sat, 17 Oct 2026 16:35:28 +0800
Message-ID: <20261017083531.766557-1-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
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

