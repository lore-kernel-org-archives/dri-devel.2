Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D80606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=X8gqm0S4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6149910EBA3;
	Wed, 18 Nov 2026 08:23:23 +0000 (UTC)
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com
 [203.205.221.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAD310E1E7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794989468; bh=fNgBE2B2tf0kAWAtLKUdmZCH3D2stuwlS4hvQYwPVYo=;
 h=From:To:Cc:Subject:Date;
 b=X8gqm0S4cQV1dgA8wbNJljZ6nZV6QfhK50buoH+2DdI30Q+ZPo+FmBYPWy45xeYNX
 udk6WqCXPnM2w8diZCCH/ABsMPKdRyXjW22TRNV7U/GGOHj6SoSl6S+It4VHasDReu
 BdWKn2gegKK9uKJXjtbBeQ+tJONCFTzByVf6NWBs=
Received: from pjhArchLinux ([211.64.159.150])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id EC246C4; Wed, 18 Nov 2026 16:03:44 +0800
X-QQ-mid: xmsmtpt1794989024txq51cicx
Message-ID: <tencent_57158E41575923FECD5D1E091356C6B9410A@qq.com>
X-QQ-XMAILINFO: NcJw5CIirWgGYX1NvdLOhbG5veffgDsa3Id119NDlBsGsh5L4Ir+byxkIrJBBD
 iR7d+a2jWiIc29T2nMXgwS0YUjTo55p7oZprGhEOQdGtddvofCu1TecsWyaf+9K+TH0c1pCabhjf
 b8OENfmCYHMjF6omVIvwIeRuaA5eXetFP6UsgAB0aJyDIFpMGRZ+AZKRf2YyAkRKLHM4x6a+XIms
 j6AHpkwxpYWvLZsCYMrE/8yYbyDZQlWmnvPoYpdd22TLwc5NWb5YEOXZbvF0BIDDWJfNxhwTSscV
 EJxuw3T6RdBSua1LyZU3fHftGtVz2oruJbSJPnMDatzXARiiQgpd0gSi/WDWmvIm8iIJDgVuO4db
 JAcBjzFNRZIVencyLWpxoOSP+JKGzsA5zdAVq3CqHTCfKvdIfDTOWr827cDajHguxn0Hrn+1lvUl
 JW4ytvY3hvEvlopOF4AcRngWaT1kflpoegELjvdkeBTehTbi1bxGRMuXBxYxwRJ60uyYKXvBAO7C
 /KYmQF2RFmMCrlwlTBy7yn04DFefk7+ErgumdbEdpP0zKT3E7+wjWiIPsvuvcG198DoUvU0ZjXKj
 IybRvXjuJgaf3KYsJ9LwoTMpRj0do+dGCqm/HuqwvAYywQyF8QcWk3MHx2wq+tB0KalIaZpO9iIJ
 W/KQHBTSfELp2fBo0iYbAPEQV5LOSq3kG7jN34kr3UXMzOwCjJawB/qaM1Gk8vHRVGgfPSPr6Cyi
 iqNH3UH32A0Gz+0zxlhVHH7E0RG0YnvHrXz9YNMt4rEQn8ZoU5wbmYq75B5viP0jmMbCmh81gqgG
 M137FlBHntCJfI31AOZwfBPETWG557xrD4rXmEmPxmwIM1q3s5JaUy+YSnPRMSOGFqTzu3QOldBc
 XX3B6hy28X7Uu+0wwp0V+awgaSxKDk0T6qHYb/Zqt20NAnpyqkhrPtDJZhpY215zh/GKFOYnPb5A
 XLjZqjSj1digUbl+FgfA4G5o5T8+ij+26TaMLeRH3UXIBCIFU6cDrjJujmKOCJMFIDXJtBLgDmim
 IocZS7v6zyumhp8A6UpA+ZSDMZ748KeFHZ7C9YqQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/2] drm/panel: ilitek-ili9881c: add Industio Purple Pi OH
 panel
Date: Wed, 18 Nov 2026 16:03:36 +0800
X-OQ-MSGID: <20261118080338.523572-1-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the 7-inch 800x1280 ILI9881C panel used on
the Industio Purple Pi OH (RK3566).

The module is marked ZC-700010BH and has a 94x151 mm active area.  The
vendor device tree only describes it as a generic "simple-panel-dsi",
so no panel-vendor compatible is known; patch 1 adds a board-specific
compatible with ilitek,ili9881c as the fallback.

Patch 2 adds a dedicated driver entry with the vendor initialisation
sequence.  The existing am8001280g entry (another 7-inch 800x1280
ILI9881C panel) was tested on this hardware and only lights the
backlight without a picture, so the vendor sequence is required.

The panel is reset through GPIO0_D6 and its backlight is driven by PWM4.
On hardware, the panel probes as DSI-1 94x151, modetest reports the
expected mode, and the geometry test pattern is correct.

The board DTS that uses this compatible is part of a separate Purple Pi
OH board series.  AI assistance is disclosed in the commit trailers.

pjh456 (2):
  dt-bindings: display: panel: ilitek,ili9881c: add Industio Purple Pi
    OH panel
  drm/panel: ilitek-ili9881c: add Industio Purple Pi OH panel

 .../display/panel/ilitek,ili9881c.yaml        |   3 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222 ++++++++++++++++++
 2 files changed, 225 insertions(+)


base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

