Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DA606EE99
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGvKCvxJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E66710E7D1;
	Tue,  3 Nov 2026 11:05:33 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E1910E7D1
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:05:27 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso38255405e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793703926; x=1794308726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LFiGU0wVYYFRIuNAq63PC6SLhwVIgqIMMPvA4Bls3qE=;
 b=UGvKCvxJuKuJ7+Ff/bs8xi55rIqvdH8TceNtmKH42AsgTvipeKLFq9J3iXzSbog+4U
 WQmbpziO+WJA7OZdUyWdbjTjR+/pDbh0dmVT29IjtRZZTaOdbedl0P9koEII2ivBw4GH
 qAffxzpkikO8NqN1kHL9NMU569xpw+gmILk80CEDhMYWoq17eOQOCmA1JebKx0dJ5Ya3
 MOd5KC+F7cmto5rhx6XdhvtuQYsQG5wMJYnNOFHRDTHfhgrS4il9MFA2zQ8Ah0T5U0kb
 ZLG/ItGBQ9KvFIXir3DHbPaJ5pp4LrhHPSNB6/MbRAHBZKo3qEu3rZT7mCahoatpqkGl
 rwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703926; x=1794308726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LFiGU0wVYYFRIuNAq63PC6SLhwVIgqIMMPvA4Bls3qE=;
 b=0rymUPYbNBS+SUG7GO8ScELwDNZamxA+7Ez1i/5y/xA7Aw+Lfo/SUMUZIwWso3mKz7
 Np72HZtY7Dv6fdEgZUQWcuSE3aU+jyaTeJqzdhs4nQ6I0xai5vkzARZvyJyO0+H7Gkyn
 RO+2gaMGdiwnmE5xmGrA2hq9+u61ub7i8xHfvuBAUQskfencbmJS/TAkbX+BI767FM7Q
 szohClIvmetO6uTgQpxV12wxo6g1fyFhaiNc9gig7Ir0uQ/xiWvA/QOetGB3kDWPJQ8C
 qSavbMsN8vsN8uzIaTB7EbJnewrTUr569maAgRtQJiDHl8FRSZCkYAIbdV+YIg4XQ+Qm
 S43Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhBNqNicme7NxJzORrsarDguxHKBKWu7pddxhTFVlmZ8dI0gsD19WhEAibIEeVk4+nx+YFF3zP99Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ylDswuEHCDnauV6zryTamPDhu+JQtpw/xfBbLORTk5FMIdsdH
 cVW7OynJqjQ2fm85SUySPIzcE68BihJ6K+BZHx9+wGByHt9T3UVroWrv
X-Gm-Gg: AYBFou2ep1UPlbzg3Dq/0Tywma8Z9+otsF81bQQd4npWTxpGcueUwPH1b8zbS5O1Qxr
 OokJdQ+urTgxRCSCKjtTRQ66jWjY1y9OkRRf7tiLoG23PIW9eQpt0+nH2dOSETaQYdgVqFVzSMD
 5Rq+QkHo/FlvWe0icXVDWEcaHwqXomiRTmKf/3OG5OyIwbDnZ9DPhi74Y0xPA1cpKlORzCq7mEV
 dzOSdwyVmiuhm92Ukg4d/N/dlEB50SdyglKMsm8lCvWmCzRx2XaoUVxlRbhS+XD4pysochwaEh1
 yegoO0BC/SW+u8jnJytvMZMuzpEIdUnkczNvABo5XQUp/IfX3QRHo10miUc2SWDVlWGmONBde12
 OGJzjyIihUcWimhnXa9JHMrhuEbQFpWDJK5ZLrrpjz8tx2jfAV8aIN5XJA/NgQAQRc0RT2k6//f
 6wlu9ahZR7AWPb9gZ4rUyC72BEMbMH8VcAMLDDL0a+vVSClt1Zr0A4TMelXjAcfdWKiIY0gOLoy
 y+gY6ndQwhQqj4R/dOiVVchvgaaxREGyepW6M/vT4SceiW+lAyoRsdoPfGKwPl2inLVT0UikMqZ
 yrEnk3KoNhIly6RZHJuw2sVFYBtBk5ckEYo2OUVCINMeeIHXhJ1cIO2BZP5rmpWZl9s5h6tiv8j
 mKr24cIYhkxbkPcKgtmeK9SnX1SliyxX1gD1Oeblq9YIzKw==
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4ac14ec873emr282656675e9.4.1793703925515; 
 Tue, 03 Nov 2026 03:05:25 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:14ec:7986:30c8:6bc6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm53218155e9.4.2026.11.03.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:05:25 -0800 (PST)
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
Subject: [PATCH 0/4] drm/panel: ilitek-ili9488: add the PocketGo S30 panel
Date: Tue,  3 Nov 2026 12:05:20 +0100
Message-ID: <20261103110524.2812831-1-romain.tisserand@gmail.com>
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

The PocketGo S30 is an Allwinner A33 handheld with a 320x480 1-lane
MIPI-DSI panel built around an Ilitek ILI9488. The panel uses the
existing ILI9488 DSI driver with its own init sequence (from the stock
kernel), timings and DSI mode; the sequence is close to the
E35GH-I-MW800CB one.

Patch 1 adds the vendor prefix. Patch 2 makes the binding's port
optional: the Allwinner sun6i DSI host links its panel as a child node
and has no output port, and the driver does not use one. Patch 3 adds
the compatible, patch 4 the panel. The board devicetree will be sent to
the sunxi tree separately.

Testing: each patch built with W=1 for arm (multi_v7_defconfig,
DRM_PANEL_ILITEK_ILI9488=y and =m) and arm64 (defconfig, =m), no
warnings; dt_binding_check clean for ilitek,ili9488.yaml and
vendor-prefixes.yaml. Tested on a PocketGo S30 on 7.3.1 with the final
version of this series (A33 sun6i DSI, one lane): the panel probes and
attaches to the DSI host, and the picture shows the right colors, size
and position.

Tool disclosure: this series was prepared with Claude Opus 5.5
(Anthropic) as a coding assistant, in an interactive session: it
extracted the stock init table and timings, wrote the code, the
bindings and the messages. I reviewed and understand it, and tested it
as described.

Romain TISSERAND (4):
  dt-bindings: vendor-prefixes: add PocketGo
  dt-bindings: display: panel: ilitek,ili9488: make the port optional
  dt-bindings: display: panel: ilitek,ili9488: add the PocketGo S30
    panel
  drm/panel: ilitek-ili9488: add the PocketGo S30 panel

 .../display/panel/ilitek,ili9488.yaml         |  2 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  | 55 +++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)


base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.43.0

