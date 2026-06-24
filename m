Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D76CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA76910F124;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkpJHr8K";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DB210EE53
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:03:37 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2c6bb8a5980so4215115ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782295417; x=1782900217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gb3l7+RmaQj62IRizU/FL/p+5/dRuUnOWMIn3BevCrc=;
 b=DkpJHr8KDNyUSYCFHyfv6Oc/P9WD5B6ydAzRBA6GbcI/1lQdJ0cdrNHZvglQn+iSuw
 H2tfNafaccnLWXn6tFbPoASob9pV5VdphZuGcqeJ5VwRUH20d2oK+eKCGS9nhPIMd0jV
 5D9snuwecml14rq+IKtnQQWdXCluLITfBwEBaGaThDNmiRAqd6dMg/4vBe+uiPKSUMBC
 WU4IUaEd2bpLq0DijwvxwealvkekjDs8/2f+IbEDTX0O987qe9q7zKIHyyMlHhgenYF0
 SlPLGJBVO1xGO0NEWzQQh+dER1wFM171Db5uBNssPy9Wvnzng4r8hjmMvpzdS7C78hcg
 GSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782295417; x=1782900217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gb3l7+RmaQj62IRizU/FL/p+5/dRuUnOWMIn3BevCrc=;
 b=Jea3jlIsncb/k64niowWmvc9dbx2JHa0EGYBOx8tZx+gTEGobSIIiqY8EPry0tt0yG
 v45h6IGpplpWZMyAe0wEM/il+pR+8G3rE6R4oNleTY4GtzL+B4a6JLz7hxBvACdO3GtD
 kY8jwQHeOmI6LoNhk+xWS07aEM66hSwz4YytbZYZ39vx17jN/WZvkq5yQ6r4m07LAeZf
 BcUCI95hi4kxTNo092IAor2DBfkJldhpwU3Wsss+9xX1G30gPWM9dX3vZsFte11RowML
 svebiDGRSficcmIdQpWtbqEIMEPk5WAg/tIFURD9Ni6A8E3fTZzOwq86TcjAr3mzXuEg
 2H2A==
X-Gm-Message-State: AOJu0YySejkKhLOPy9vSJwCWRs7zeJhoZ39d4dNMccSfQ/f7hgbl2Nws
 f1wbS3WuUi4ibQw/55jp/iv9kQrF3yIb/yAOhwRdB4Z0+z6cl4O+8te+WaM21vr4
X-Gm-Gg: AfdE7cnDTJ2PaQb5U/pGU4r/v2ijlcXopqmdK6PlnTqstk/lTZTNL/3kDsCL76Elve6
 kkGVoM0F4WYcWhXFgsEosS9TyLbHlcV32cJ36+3qCEuckQlC9sE4wFjuRdC/d5nAPZKIDsc2sv4
 +dT7A2rEuVTJqLksyrCkRlFTi2X3CAq58OnQyUfJbQn2ujhlpAC+9Gw3mCISaz6UbWK3+MgdWbm
 jxKdNzvsDkcMB7Rug0IWwkNyoABKGUYde7oeFcrpmFctNpvwZcJYZhSoHho1m5JcZoLvgHenAqh
 gyt23TVxf/rINA3Iyfco2zTmzGIMNclC0UQMAwuegnJ4pNPj68nWIBue3sA/BIVNKQsK9WppxN4
 gfICfcYKFdpv0L1/qypBzQ0eYJhBSRK2q6azKIo3zJo9PZl2ap9kwezfFk6erLgaCAKvH1IDJRQ
 SIqVaY9o3xpRX5yAZB5nZ4exgADHQq73Vcwf93ti0HYGyHXiDrULZN01b14t4n9ni5m6hcp+viP
 0lM0/VGCZxPVn8kS3uYwZUoQQYlxw==
X-Received: by 2002:a17:903:228b:b0:2c7:ef3b:e17f with SMTP id
 d9443c01a7336-2c7ef3bed39mr3258385ad.36.1782295416767; 
 Wed, 24 Jun 2026 03:03:36 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([115.246.20.146]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c743bfe785sm126061495ad.66.2026.06.24.03.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:03:35 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: victor.liu@nxp.com, marex@nabladev.com, daniel.baluta@nxp.com,
 Frank.Li@nxp.com, shawnguo@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Subject: [RFC] drm/imx: upstream direction for i.MX95 display support
Date: Wed, 24 Jun 2026 15:33:18 +0530
Message-ID: <20260624100326.413699-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

Hi all,

This is an RFC to settle the i.MX95 display architecture before any code is
(re)posted. It is a question, not a submission.

It follows Marek's earlier [1] and Liu Ying's reply there proposing a separate 
i.MX95 driver plus a shared helper library rather than extending the existing 
i.MX8QXP DC driver (drivers/gpu/drm/imx/dc/). That question was never resolved, 
and it gates any serious submission.

The implementation I evaluated is based on the existing NXP downstream 
dpu95 driver. My work has focused on bringing it up on current
mainline, DT integration, FRDM enablement and validation rather than
developing a new driver. I am not proposing to repost that driver as-is;
I would rather settle the architecture first.

The current dc/ implementation is a multi-device component driver with one
platform_driver per block bound via the component framework. The downstream
i.MX95 driver is a single monolithic platform_driver mapping all blocks from
one register base. Unifying appears to require reconciling two bind models,
rather than only adding match_data.

DomainBlend is i.MX95-only and sits on the atomic CRTC path, with no
i.MX8QXP analogue.

The block decomposition also differs: i.MX95 has
dither/hscaler/vscaler/fetcheco/fetchyuv/domainblend, while i.MX8QXP uses
fetchwarp.

There is also anticipated divergence which is not yet upstream (i.MX8QXP
prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95 blit
engine), although mainline dc/ is KMS-only today.

A single parametrised driver may still be possible, but these
differences led me to revisit the question before preparing a series.

The ported stack is functional on an i.MX95 15x15 FRDM with an IT6263
LVDS-to-HDMI bridge on LVDS channel 1. The DPU probes successfully,
EDID is read through the bridge, and modesetting works at
1280x720@60 and 1920x1080@60. Weston and sway both run correctly.
Tested pipeline DPU -> pixel-interleaver -> pixel-link -> LDB -> 
LVDS PHY -> IT6263 -> HDMI, using JEIDA-24 mapping. DSI is not covered.

One question for Liu Ying is whether the separate-driver plus shared
helper-library approach is still the preferred direction, and where the
helper boundary would be drawn (which blocks/ops are shared versus
implemented per driver).

If that approach is still preferred, I would be interested in working on
the helper-library extraction. Before spending time on it, I would like
to understand whether it matches the intended upstream direction or
whether similar work is already planned.

Likewise, it would be useful to understand whether extending dc/ is still
considered preferable, and how the component and monolithic driver models
would be reconciled given the differences described above.

Thanks,
Piyush Patle

References
[1]  https://lore.kernel.org/dri-devel/20251011170213.128907-1-marek.vasut@mailbox.org/
