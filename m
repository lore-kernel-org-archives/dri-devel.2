Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24516C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B01410E492;
	Thu,  3 Sep 2026 21:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IzIdR8i2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C48810E492
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:21:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4094041FBD;
 Thu,  3 Sep 2026 21:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCFC1F000E9;
 Thu,  3 Sep 2026 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788470486;
 bh=KedTXzxUdYGUnfRzacipYvTaxSNtl2STNA/jYDoukls=;
 h=From:Subject:Date:To:Cc;
 b=IzIdR8i2afZdJ/NWZmeSsEtWAWNc9nL7x11Mai/3GVVSClpHqKE3+8HqUk3K1IZgh
 bI7G24SnlC6QJ8hnWQGxPR75mJNU+VT3Y3NUDmi2Pga5tbTrTDmyiIdgLRkUvzeicU
 mFjKvkQfHLkxiuuU9J7O1VVTW/Z0nMEEVhwZypuiqrKpDIRe9dLaUvNu4DcRW3VpI4
 0DQnM3OSBxirAvY4j7dFxU18pKMPjiAl8ZjWisZ3FYghu376QQVnG/+YzoJVAd5Mw9
 r5LpDKtirrcicItDrD9+R7KZr2WobMiNoU1wiWxrwAwjKN86lpQZP7zXnaQ8Y3EQea
 GKqYSAMGIRX7A==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] drm/panel: samsung: Share test key command helpers
Date: Thu, 03 Sep 2026 23:21:18 +0200
Message-Id: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gZSK/6uIi6KphrQVhoQQby7x
 eVbzDygnIQVhuKBxJeoxJBhygLmzYWVUZZsqKhqqCeLSzrwdIF3RY2ePWFru65pTe3muofcnYm
 93P9znN73AxKzCYNjAAAA
X-Change-ID: 20260903-drm-panels-sofef0-73886714ac49
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Several Samsung display controller drivers use identical three-byte
commands to enable and disable test key levels. The commands are
currently repeated as driver-specific macros or raw DCS writes.

Add a private Samsung DSI header with typed helpers for all three test
key levels. Use it in the drivers that already identify these commands
by level, including the S6E88A0 AMS452EF01 driver whose comments identify
the raw F0 pair as level 2 commands.

Drivers with conflicting level numbering or without an established
test-key name are deliberately left unchanged.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      drm/panel: samsung: Add shared test key helpers
      drm/panel: samsung-s6e88a0-ams452ef01: Use test key helpers

 drivers/gpu/drm/panel/panel-samsung-dsi.h          | 38 ++++++++++++
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c   | 71 +++++++++-------------
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 70 +++++++++------------
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |  6 +-
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  | 23 +++----
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      | 15 ++---
 6 files changed, 116 insertions(+), 107 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260903-drm-panels-sofef0-73886714ac49

Best regards,
--  
Linus Walleij <linusw@kernel.org>

