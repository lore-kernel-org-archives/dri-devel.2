Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FA606A330
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fz83wsiR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDF010E3C3;
	Sun, 22 Nov 2026 15:30:51 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0981C10E3C3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:30:45 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so22263875e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361444; x=1795966244;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AcE23n4pwXrPvICR/OBmKOqECG6PQtTg4meGhVNm1yI=;
 b=fz83wsiR1ZwucLkIb/v0H02OcQgWf4r8h7TCI2AKdWcLVQVPhtHps0H+GCC+1nI1vI
 vRHiqAFQ0Alf9xIgu1gPwewuKc7akvcjAAcvsw0Qn6goUfR7iVb/1uDBgkAeY3pUbmyu
 MphNO3dNrIwSUDVmURHPAaHBz3wyipgWydmK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361444; x=1795966244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AcE23n4pwXrPvICR/OBmKOqECG6PQtTg4meGhVNm1yI=;
 b=RNr+AXqx+obmhckoVNsEFRtNWGcUN0BCEy8WEs3ap07yWV6TqCOo7bitA3g9OrCNTK
 mIIbOt5rlWYQ7diKd6cyDrPllfjehKo7cKnJT5RSqwKuVXaro0NlPqM9G/MFwOfrLZKW
 0klv7lgskF6UNvV80yC3/rUgHM3AAy2MLD2jwR5pDNFTOlQL32q5u/NH3e8zz6jXjWIa
 Hly9FxeGNgE8Pe9b636spFiuK/3qri0fj+jVJa0rOg48TkoTFYK1wFvDvXm2oDrMFc/E
 wZBJm0uPlITVYtrHus3nXLEHxPUToE9GAqsr1Axy/pvMmZHia2KPPKWBDihoYFAxtMY0
 1cEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEZ5EYMOP09HITJt7tOqfzMyxPHmcDuAn4ZcjDexlaP9dQkqLys8asc2cyxpiNPVmUB0AsE61Ajwjk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ADIzatzODOVO4yzPkhZNyExT8BUPPAi5Pdm6GcsvbC0eDredz
 HXqvObW1+XbRwufDhb+kRJT4bFzj+NgrV3YaF9UH7HvSOcwzHAxUP4lOM2W6hKhdipk=
X-Gm-Gg: AZFdTZcwedjqrURp/IVNpE7JVnwhTx6G2SbPBAqi1sMs80p5qdZDF03pxcM7TC1p5cM
 DW9fQKTXrhEXSh1YRBnW8IaIIBvdEf/I0JpsElcld+mYJsrwQFx8kJOWLo565WVvEkOB7Wen1s6
 lySigHzqE8CSBO+gc+AEy4TNWHHerT8adedd6RdrONZIlON8+1UvsBOl0xjUyN415b+xVPg8q5g
 NP4NJw3w2jxYRPs4UsBrAZQYB6Bs47LWddmc2Vsgd0GMH+lFxYcWGIWiXJKEQta6lKSC5GHlw01
 JRlPJE4JStrGu/NfJMrdInUR3jPk+D0SZI/F+W8Y3dYNXlwNhsvbmpMtEzbzJU2LNKheg7nk07l
 ax+Mf19jSAfe9fscJab872IKX6zamBUj2Q7FPw1YdskWRJ+M4e1aWPF1ZsX0ndE5RvdBiIzi9wH
 WAfWZvNgeIbJMWxp+0ZmtnWewvFi8nESqO89yVaGzeZX5wznpPi52N45iPbedtCj/25J+Dd6LuQ
 ENheFnS7Ap/x4D/9SWzkJz2qN/ydZ6r+AJMSkTFFqy8fZEJMLvFTfNbYLF97QWVsM2K/nJ6o3hk
 oVKT7fTv+NqhY8HmxoFEb83atXoC00wHOXPBKCHT5jqAjTvoKknvDgGTyzk1G+k/aDpcFnoywk/
 wsLgp2efJjV767xhxVp4/ZU8mPCa5JMUpRcDM9m0GSgqyXncXvHjwnsJf6wy90ZwIWhlvkpjth/
 VxvKH9cl6gif73bBuPhSbALJeM0nz7qpzXajG6TLz9Z+Dp1p0=
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id
 5b1f17b1804b1-4bb88944bf5mr182002275e9.35.1795361444382; 
 Sun, 22 Nov 2026 07:30:44 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:30:43 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Robert Foss <rfoss@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Simona Vetter <simona@ffwll.ch>, Stefan Agner <stefan@agner.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] drm: State readout for the i.MX8MN display pipeline
Date: Sun, 22 Nov 2026 16:30:00 +0100
Message-ID: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series implements the hardware state readout [1] for the display
pipeline of the i.MX8MN (LCDIF, Samsung DSIM, Synaptics R63353 panel),
so that the splash screen shown by the bootloader stays on, without a
modeset, until a client draws.

The first two patches add the hooks a bridge and a panel need to
acquire their resources (runtime PM, regulators) when they are found
enabled. They are a proposal, since the drivers converted so far
didn't need them.

The series is based on [1] and needs [2] to keep the power domains of
the display on.

Tested on i.MX8MN (BSH SMM S2 PRO).

[1] https://lore.kernel.org/r/20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org
[2] https://lore.kernel.org/r/20261122095927.2631909-1-dario.binacchi@amarulasolutions.com


Dario Binacchi (8):
  drm/bridge: Add atomic_sro_install_state hook
  drm/panel: Add sro_install hook
  drm/mxsfb: Use the bridge connector
  drm/mxsfb: Switch to drm_mode_config_create_initial_state()
  drm/mxsfb: Stop the controller in hw_reset
  drm/mxsfb: Implement hw state readout
  drm/bridge: samsung-dsim: Implement hw state readout
  drm/panel: synaptics-r63353: Support hw state readout

 drivers/gpu/drm/bridge/samsung-dsim.c         | 125 +++++-
 drivers/gpu/drm/drm_bridge.c                  |  41 ++
 drivers/gpu/drm/drm_panel.c                   |  16 +
 drivers/gpu/drm/mxsfb/Kconfig                 |   2 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  31 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c             | 394 +++++++++++++++++-
 drivers/gpu/drm/mxsfb/mxsfb_regs.h            |   3 +
 .../gpu/drm/panel/panel-synaptics-r63353.c    |  33 +-
 include/drm/drm_bridge.h                      |  20 +
 include/drm/drm_panel.h                       |  10 +
 10 files changed, 642 insertions(+), 33 deletions(-)

---
base-commit: fe97bd8df0365f5aa27ea88b621e3f475bdd544d
branch: drm-sro-rfc

-- 
2.43.0

