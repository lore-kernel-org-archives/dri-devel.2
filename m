Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4376082BE7
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqX8zXq6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB2010F417;
	Mon,  9 Nov 2026 16:07:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAF810F368
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:07:10 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so12899875e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794240429; x=1794845229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PAVOiEo7yvU59/BVYzddko8QH5/O/35Z26C3YJ1MLT0=;
 b=YqX8zXq6xPRRE8MLOP/4+yafPcqiAggnT+QmC1CGzkFzl57YItImIqPQnFQMRqzPWl
 J4HKV0tlRCKq+vPR/yWdT8Cwn41DCx5TEGgHvjV26niY61tAYxRnaErGvAQTsGROiVAx
 eSNpQaL7Z44tUisOK8WWyU94gAX2NV7NDSX3+6swbEfkoriXjNJCGS9UKeYg9+FnMxgn
 VxLuZkGMnfN37S1T25g3gC+9tySVG6FQDH/n/SrS0CdZqYjtKPxwYF+6fZbOTHaqmoSC
 XetPEjpuQrY17/3bBJiZ/INQuDNoqFD/ou8cyycJjzuVM2CoU9AqZlRnQVw2XfvdS1nY
 O24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240429; x=1794845229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAVOiEo7yvU59/BVYzddko8QH5/O/35Z26C3YJ1MLT0=;
 b=AypyKSAF5X2VBBSTwNBEecgbyVuaJPRmRzJwwZiM8ao93LzWUQIOXD01/dwb5IxvON
 1TMHM98MoHoAB8Ssqj+/YZtWg66DgkF9Jbwq7BKz2UBCITrq+sHwQGWvK6UzfXfEzz7V
 TxWg6q6nLI/hWKfxemVRjEpnANuhYKqh1vGgZzVfM+k07z1ZNWHrKcFQB5yTAaYvv8+4
 sv1u0JE++HNwu31d/obXuanNvxT4eXv8oIBw2isuuIojH33HfQW2LslMfa4GmKvvlqHI
 bCSgKX/GChJpscP/AuiMy1w6SAtKDElwwjPhbHi/CBvconjaSu+gfkZ/GysnLw4Qu+W6
 WEQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEYpNyVrZsqUb1xxZ37vFTGPUYapmqv/Eja7omF9rFYe1r2sgDOSPoL9YofZwPIPpYMDNW5EA+1bL8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9behk7l3NdjHYjzfCNzoXoafCGHHJ1Bs92AWfR9DJEnpBfnE6I
 j65o4Gzhy5GAZh8mLFGwilXZfnztP82ZasV0/FBYYtFKZ1HsKcYSkWhD
X-Gm-Gg: AYBFou1tm99tsmBApsS0wnRH7Nrq9rH5C6E10eCZbns4aGhaK3vj46uEjZJOObwRawk
 kmhqAkcPxEbaxu8+DWNEdDDlOBZQKtoxIFDW/WdMytAMA9lODHWm5EDsg84dB5fV9mQkbZFoPYY
 vIdcadpiOOHFsgU4qGhdiTtDHxcItXm6p6m9KpDKCVnVr6je6KmdKjLgOgbaBEFgTIj7CNQziXp
 IDGJWUY4S0mSvn/54J/pyBlyVUY2+cd6PwBojLmBNXRAKK3bsqz/Li/O1c9/V696BIM/6rnGuma
 zNl308atOAys/Z6Tq1a0uYIk8dEceDjnqYM5On5QWnOiTpRNxb7bO4yaRZ20pBRNRM7ID8WfqU5
 GZL7qEJeyOKcXrnsMx2Ka4ysL6Fn5of5xrPvpBUV3o1HKSbIq0nHNOuuFeBh+jP+AIUPRyb9La7
 Wh7NZ/159TdqntcK0U0WlMcyLPdrEcWj8FhooZGc9Px4pC9qauGaelZPGbKiF7ldYevfL4svEGN
 8JAwLexve5LQyEQXpuO70I8fsl1p4c30A4CmqFrp73G8VJd0iWoZW5sDyud2ix13GG6z5sWxCM4
 fju+rx9y6AzCmzjsesWotgLBUgl46uV7sTkWpQsuUMv0wEdAV5AcDArWHwTjMpA9isZDmltnFf1
 1kQbAsiO2TXrAhcvhoM4ngvE3jeLzeq227d2vMyqJfQ==
X-Received: by 2002:a05:600c:4f86:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4b960d9b17dmr83943565e9.9.1794240428927; 
 Mon, 09 Nov 2026 08:07:08 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:863:742:6109:ac9d:152:38c3:6463])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90f119b96sm159174245e9.15.2026.11.09.08.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:07:08 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Igor Reznichenko <igor@reznichenko.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH v2 0/3] drm/panel: ilitek-ili9488: add the PocketGo S30 panel
Date: Mon,  9 Nov 2026 17:07:03 +0100
Message-ID: <20261109160706.2272332-1-romain.tisserand@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Miyoo PocketGo S30 is an Allwinner A33 handheld with a 320x480
1-lane MIPI-DSI panel built around an Ilitek ILI9488. The panel uses the
existing ILI9488 DSI driver with its own init sequence (from the stock
kernel), timings and DSI mode; the sequence is close to the
E35GH-I-MW800CB one.

Patch 1 makes the binding's port optional: the Allwinner sun6i DSI host
links its panel as a child node and has no output port, and the driver
does not use one. Patch 2 adds the compatible, patch 3 the panel. The
board devicetree will be sent to the sunxi tree separately.

Testing: each patch built with W=1 for arm (multi_v7_defconfig,
DRM_PANEL_ILITEK_ILI9488=y and =m) and arm64 (defconfig, =m), no
warnings; dt_binding_check clean for ilitek,ili9488.yaml. Tested on a
PocketGo S30 on 7.3.1 with v1 (A33 sun6i DSI, one lane): the panel
probes and attaches to the DSI host, and the picture shows the right
colors, size and position. v2 only renames the compatible and edits a
commit message.

Changes in v2:
- Drop the "pocketgo" vendor prefix patch: PocketGo is a product line,
  not a company (Krzysztof). The S30 is made by Bittboy/Miyoo, so use
  the existing "miyoo" prefix: "miyoo,pocketgo-s30-panel".
- 3/3: drop the claim that COLMOD sets the panel to 6 bits per color
  over DSI, only say the stock value is kept (Igor).
- Add Igor's Reviewed-by. I kept it on 2/3 and 3/3 although their
  compatible changed from "pocketgo,s30-panel" to
  "miyoo,pocketgo-s30-panel"; nothing else changed in them.
- Link to v1: https://lore.kernel.org/all/20261103110524.2812831-1-romain.tisserand@gmail.com/

Tool disclosure: this series was prepared with Claude Opus 5.5
(Anthropic) as a coding assistant, in an interactive session: it
extracted the stock init table and timings, wrote the code, the
bindings and the messages. I reviewed and understand it, and tested it
as described.

Romain TISSERAND (3):
  dt-bindings: display: panel: ilitek,ili9488: make the port optional
  dt-bindings: display: panel: ilitek,ili9488: add the PocketGo S30
    panel
  drm/panel: ilitek-ili9488: add the PocketGo S30 panel

 .../display/panel/ilitek,ili9488.yaml         |  2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  | 55 +++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)


base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.43.0

