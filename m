Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEA1CC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0762C10F5C1;
	Tue, 13 Oct 2026 07:53:50 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546C910E714
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:35:50 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-677bf06de21so1742636d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866149; x=1792470949; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uZmMXlQEPn/Zuz4J8J6iJ6oFHFWuuc9FMm2/aQX315E=;
 b=dwYCdnd57ulMoCT2jJ8O481d/6WHB0y9arLqel8/wjvhN7dUlCCEe/F7oqxNriScX6
 gzRj69uX+x9v0YslNWobWPtkDxcH9jBDY6Akf6vxDB7tuTHQ/MCWIkJGr2HwVTbK5Z81
 MDS2P7hUS+xqp/q9tIl2sMFVAL1ER0lCHa+ncCZGOWLpJPnv6tXmmYPrWnYM8nXjaRA/
 3Ukz1Zv2gRjxjy4Xv8krQEiFQhtYedvK0giNBONpgbXUza5TjNHVlvqTSPdd8KSVeqnn
 XkPaX9M/YaOWd6EfqaQ/n/b/pJCXkvOC+m+C5KQH7aOStNdD9swhq/QWagDcRT+ixqWk
 T/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866149; x=1792470949;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uZmMXlQEPn/Zuz4J8J6iJ6oFHFWuuc9FMm2/aQX315E=;
 b=00s9DJWgoWTkN1ijjRFVPr3hKFUvw60wkODqODU9IruXfbcdoLrZzPtdjle7jvWeXK
 U9WAJOGW72lFNX+2x/i2w4RuISb7ZTiluDdDXFMD6QNIgMr8nGUOazr+WuLRGQPJDZBO
 oBTwrZ7eiuXhiMdFeiXdVTNLQymGniTDlqBX1W5T7HlXT2JIEl2HkOn/1K4ByJQBb2Wz
 oOBZaHAsJl4DFuyKRIWIBMTHd8B+pDbXQyySQHsVtYfpt23CfkE/IkgJgS2p8TKUeZ/t
 vMaI42wAu/Nzu37LEcdnpbgES42S1MMAs7csjl+ppqNmwrLvEIexVTng+b0j+6TfoZ8j
 HfTQ==
X-Gm-Message-State: AFq9FYL045yg4SStPIi0gaShGPTnH4kprT6No/l4wt45HMnoTFJSfdNr
 si5uWaLP8b3UYxfJwj+ou2+tcQk8yvblPepeqeH8hU4AMeWJUtFSdGRO
X-Gm-Gg: AYBFou3npLbIN/PPuBAf+OI5pxCMn+Vo6TEWfAeeIkU5ZPfZYIpFwgrRscL2B/HwPha
 fJC1NYdoO7xuk+8CXKt0XXEGvr7FA8cDvpV5cKhSm05bKM7q64T0cKjccmDOfvNemJv+e/MW6IM
 FlnGc0WTAJRE0X4Hzs5wdiutvd1vv1FYKiF4FPti1xJjpt+xIzg8XpKdrtDmnGZOVLHs8XMS+xZ
 r5KBSNMZBa8gbk2bseYQx0t8GlwKIchFHBWoJTJFujzJ2GcX47KhNxHWWFPWjMcWJf8Z+CFgW4k
 9nTbOVw0NSsdiPlCmFNCpkIuVOT0uPwmNCX1fUzFP1nHUytaHlkoPtbE0LSX++Vht5ZAX810lxf
 ETSuK507uuCpKkf5jtjCs0bheVdUlx/WdpLIlbiRK/5eClEQFp3NENOLu87n3sEShNqL2BlMyE4
 e/bIX5b0kyqQYllejyxmwIv70MBSZxu+jA57uq+ZdBsjwV0NLpP51AAUQCRbOhsHMkAfdjg+Pem
 4GiG4s5TlrqvQ==
X-Received: by 2002:a05:690e:d59:b0:674:a21e:bd20 with SMTP id
 956f58d0204a3-67936267934mr2403854d50.78.1791866149013; 
 Mon, 12 Oct 2026 21:35:49 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67935606f5esm4448152d50.4.2026.10.12.21.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:35:47 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH 0/4] drm/panel: Convert four panel drivers to
 mipi_dsi_*_multi()
Date: Mon, 12 Oct 2026 23:34:35 -0500
Message-Id: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0ND3dzMgkzd3NKckkxdiFZds2RLi6TUZINkc9NUJaC+gqLUtMwKsJn
 RsbW1ANERJ+RjAAAA
X-Change-ID: 20261011-mipi-multi-series-6c98bec0c75e
To: Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

This series converts deprecated mipi_dsi_dcs_*() calls to their
_multi() equivalents in four panel drivers: leadtek-ltk500hd1829,
kingdisplay-kd097d04, innolux-p079zca, and newvision-nv3051d. The
first two drivers also convert mipi_dsi_generic_write().

In patches 2-4, unprepare() previously returned early when
enter_sleep_mode() failed, skipping GPIO and regulator teardown.
Because drm_panel_unprepare() leaves panel->prepared set when the
callback returns an error, the panel could not be prepared again.
These patches remove the early return, so GPIO and regulator
teardown always runs, and have unprepare() always return 0, so
drm_panel_unprepare() clears panel->prepared. Patches 2 and 3
likewise stop returning regulator disable errors from unprepare().

In patches 1, 3, and 4, the original code treated a set_display_off()
failure as non-fatal and still attempted enter_sleep_mode(). These
patches clear accum_err after set_display_off_multi() to keep that
behaviour.

All four patches are compile tested only. checkpatch and a W=1 build
are clean. Tested-by tags would be very welcome.

While converting nv3051d, I noticed that panel_nv3051d_init_sequence()
always returns 0, so init sequence errors never reach prepare(). This
series leaves that unchanged, and I plan to send a separate fix.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Akash Sukhavasi (4):
      drm/panel: leadtek-ltk500hd1829: Use mipi_dsi_*_multi()
      drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi(); fix minor bugs
      drm/panel: innolux-p079zca: Use mipi_dsi_*_multi(); fix minor bugs
      drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi(); fix minor bugs

 drivers/gpu/drm/panel/panel-innolux-p079zca.c      | 43 +++++++-----------
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 53 ++++++++--------------
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c | 40 ++++++----------
 drivers/gpu/drm/panel/panel-newvision-nv3051d.c    | 36 ++++++---------
 4 files changed, 61 insertions(+), 111 deletions(-)
---
base-commit: 725953d4da85cfb97a4c309fad6346b72f8529e7
change-id: 20261011-mipi-multi-series-6c98bec0c75e

Best regards,
-- 
Akash Sukhavasi <akash.sukhavasi@gmail.com>

