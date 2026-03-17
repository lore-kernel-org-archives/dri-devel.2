Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B691EFD875F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2636C10E5C2;
	Tue, 17 Mar 2026 12:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dj6AZHdq";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B2210E5C2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:36:15 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43b4d73463dso419419f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773750974; x=1774355774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M4lFHCL1tyYPIUcCrRlaru3igXJSxxHN0zRr+ZhxeaE=;
 b=Dj6AZHdqHUMeHaQT2avhfAsVLj9BJWKP45/A35X+9ZPsu48d/EmMNniXkecec0eqDf
 zerchhiESzP+1G/Dz0Vu+V5TuTSx3cT3JKOl005moaKrWG98KMlTZMuvpcdbKA0ENsN+
 6Fo5xEuJi/vujcbrY8zeBz90xmfUMNHZKD9BbutB2R28I5HovE429B6d53eIJaVM/Dbj
 8RJG9TRfqZa4FbUnNk6CKGWARBo5Eljd4HGRDcLOpYRxWXpKw7+sfdQzWWzVWAhKdhxu
 OTCuKtkmGD53m1SQqfvB5YEJN/yqDBi64Q2UnJ+BI9is1rJj1uokKdJcQRoKeZOM1bBV
 CSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750974; x=1774355774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4lFHCL1tyYPIUcCrRlaru3igXJSxxHN0zRr+ZhxeaE=;
 b=Ge8Ecdlyw53JD/sup98RBWRE3LXY/9HvQbt3rfAM5SawtRmjt9jrw8jHab+MrAIGr/
 YVtCwVzWtnJxrjyE1K1HYNIn2oN+HDUpQCeWlP1xp8BVli4EV9uZ7+tizp1PlUDnT+Ev
 RxCOgAfvAlnuz7WSdjhh5SqD0E7v7GDUTUlSCFdcDqS86+wMj3wNqvE9JxnjuZiEVPcH
 iH77xoBeojKKjDkdVkpCFIZuRC7+5HNNQTmdh70ilWk5PoN/v3V2OzKedKiLxhk7J6dH
 v94aKZsD7DoQaLSYm0v0AOGMpHPIeyPT5EdYVNSwxI4uXGqS4538mYq6mPx6p6khau83
 6shQ==
X-Gm-Message-State: AOJu0YwHEJc+svDJSHGNwtzYQhIMNJIqfXDUQlYRuCJCnn/TvZchAhCU
 oMFudFj5yjHq8GGAxTkYGoowxIW5MADNQJs+bvOgHORKQ4eSs4nB4Xbq
X-Gm-Gg: ATEYQzzgGzny+lkPCcR369CCzGvb6na8s1avCdGibzWp52sP8keqe3wvtcKBbeom85K
 cLcxnSzsggKwKKz9Ig9ALao/DpmYHxbCeI9Qh6DLLSpdT7b2qrvCw5ZcXfVWqlKIi+J3ZosXRs3
 jAE+bo61py+aW7XicUGeS/Pw/p62DcbmKLqFa5gimtDszjraxlgnLx7hB7058L+I7PLM95sgzDU
 ZKPYHhlH6IXqDuqi6xTsB5LX04r6LLNz1a7JMPppBoZL8/I8/JUhMWWcyTxbZ97Vbmd4CkGpaMy
 GdouD/TlwALB/C1HOQERh7f0gnHokb162/3GOFSL6Wiq8mS5CMQxSDk2I1AdvNq09YAx3Z1bxwi
 Fbos5SIOTGF60KdYQBvE+5e4Bq5UeUqMcoF3bijv0P0Y7Bcw4Ajlh2l6/F0UHFKfe4YlX8A8f1L
 f6cWWKJDDkttQtvHofFylZ2JCy+DE0FFZDeymSHZ55n9hh4kA5
X-Received: by 2002:a05:6000:2003:b0:435:9cd5:bb2a with SMTP id
 ffacd0b85a97d-43a04d8736fmr29772032f8f.24.1773750973905; 
 Tue, 17 Mar 2026 05:36:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b4f845841sm3247444f8f.11.2026.03.17.05.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 05:36:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/2] Improvements on RZ/G2L MIPI DSI driver
Date: Tue, 17 Mar 2026 12:35:59 +0000
Message-ID: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

Enhance RZ/G2L MIPI DSI driver based on "Figure 34.5 Power on sequence",
on section "34.4.2.1 Reset" of the RZ/G2L hardware manual Rev.1.50 May,
2025.

As per the hardware manual, it is required to wait >= 1msec after
deasserting the CMN_RSTB signal, and writing to DSI PHY timing registers
and few LINK registers should be done before deasserting the CMN_RSTB.

Biju Das (2):
  drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1ms delay in D-PHY init
  drm: renesas: rzg2l_mipi_dsi: Fix the power-on sequence

 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.43.0

