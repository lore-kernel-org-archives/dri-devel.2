Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF03CD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E57810EA76;
	Sun,  7 Jun 2026 14:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiHLQzIR";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2928910E851
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:36:37 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so2659493a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780774596; x=1781379396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3SKuhqAQ41toicMDwphPyybla4nmto2uMS/JLzt08ug=;
 b=aiHLQzIRSte0uW174oYx1nWUFmD6aJx1GQlpHHhdDv6NZ2B2VQySD7nsOIIBDu8Q87
 sRdjlPfGTIT0AnNjaXV7j89gbdB2mzXvoxidzhvgOq6bkyeAqPiB0pGy4oU/mbGYbdyG
 FaM8QSy3WLEQTocZpbTTPUFqjPw0MCh/ihGXpTT+T700gB3Ekx7qnOodr0vfk6x6F5oa
 XGm+bk4doualpwI5N7w0HKDHZUpnHnYXHV3Go7gLrVD0rpuCqqQKifKXoVmkZmAgXnuM
 Bp2KAbHZCzHFdkOXACctq3jRzAZFSQ+lSdEswMK9xchEaCPMhq6OiNlFZT9Ju5AuBVSv
 aJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780774596; x=1781379396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SKuhqAQ41toicMDwphPyybla4nmto2uMS/JLzt08ug=;
 b=RYAAozW2TG9u5EF/9ZSvhJN+CkTi32M2NKMZjeYzcfWRbVyTlemtp2e4mzdvXo3j83
 lY6LhXnnZnkaEpVcHazAksEMXDvPpdopM4+PCz1E4Wr0BoprNQsWia8jUNKe1q5H308x
 kiq+JferwgLUip+qWq+QYm9tlKZTkHkvy5l+xDUirJxtKMRkGE6RKBjQ9YsTg/DEQBhX
 LHz+HmHF5Fm+bJhbpVC8mLgqzCUof0TydslGtv5VYslMInBQoENux3ceFiXjFiP4l54q
 B0jba6k2/Mf9EiDSl1uMy+RegpPsgjIO29d6Rp5c23DIpoPDXVVcanqjwY/YNUY9FT1v
 WdbQ==
X-Gm-Message-State: AOJu0YxNWddO2dO6UXY+FsY/CPljmwo/TTH2vTh+2cPpNzKTughyIlsj
 Q7XJ9lbDpCOET3yxz/b6+yQq5sxWVDAlXOuDev5V3tN4L84PXUAZGDcl1TwvUg==
X-Gm-Gg: Acq92OEoEfR97VzVMIClmTKnAMC6STK4E3/42r7cvMJLNmYkhyAuS75hGIg25Hr5+h2
 lzEpF258GHW2jNwanZaOUmNBiKh0Emedvj4p646HanH18V58HzS9qxwd2YDOVWX3bxINrJBsNcx
 Idlww8m9wuJDpM5Vi82Kn8hwlxa2e6cYkyJdDuxrP4/UMePwrC2tiY+fE2qQBIjHvYcXNXNgjO2
 Dyi+wTvwrz0UMg8GX4X0KDvWwCUrBYQqYCFa0T4iCbeWzqRov9pzTGoGkP1unLz8pfh3+OMgESm
 cBxcEP/Goo5XIdlmee7iE0PG9zJo5tIx/jGfBwYzjuiLoJlRTx/QV+iOWgc98NZE1qXNevzTua4
 7ORtC1CFmvBOrVPhJ4Kl6FwlbPXPr2v0R4Fc3wfbmNbzghK0pssSzOjmQ3IgvTxQS+DbLEEZCoZ
 oYVASwBNr2EOfZJ/D+qTAZGhuMHJdI/jppYGSnly7esnA6wucgyrI5CXmDGrNQSfV8Cz58lCqO/
 Irg5E9Rk9fuA71d7mwDEMtGd2qdCwZe/8wPa1+gEFcoYKpsl7XF6A==
X-Received: by 2002:a17:90b:5109:b0:372:94b9:76d8 with SMTP id
 98e67ed59e1d1-37294b97715mr3437119a91.6.1780774596567; 
 Sat, 06 Jun 2026 12:36:36 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37135861581sm3003643a91.2.2026.06.06.12.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:36:36 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, robert.foss@linaro.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/bridge: replace deprecated DRM logging macros
Date: Sun,  7 Jun 2026 01:06:14 +0530
Message-ID: <20260606193625.24465-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

Replace a small set of deprecated DRM_INFO() and DRM_ERROR() calls in
bridge drivers with device-aware drm_info() and drm_err() helpers.

The replacements pass connector->dev or bridge->dev as appropriate,
preserving log levels while associating messages with the DRM device.

No functional changes.

Piyush Patle (5):
  drm/bridge: simple-bridge: replace deprecated DRM logging macros
  drm/bridge: ti-tfp410: replace deprecated DRM_INFO macro
  drm/bridge: chrontel-ch7033: replace deprecated DRM_ERROR macro
  drm/bridge: panel: replace deprecated DRM_ERROR macro
  drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: replace deprecated
    DRM_ERROR macro

 drivers/gpu/drm/bridge/chrontel-ch7033.c                 | 2 +-
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 drivers/gpu/drm/bridge/panel.c                           | 2 +-
 drivers/gpu/drm/bridge/simple-bridge.c                   | 6 +++---
 drivers/gpu/drm/bridge/ti-tfp410.c                       | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.43.0

