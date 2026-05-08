Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ED0CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797CB10E2C1;
	Fri,  8 May 2026 14:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="crONrLXH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9046010F4FD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 01D18439C7;
 Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FCAC2BCB0;
 Fri,  8 May 2026 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778251588;
 bh=pcJbTLDoncDYuOjwOJV4L1AfLbap53q0hiYuc9oFonM=;
 h=From:To:Cc:Subject:Date:From;
 b=crONrLXHf+/ahloLLVXzsxTvVDuv47wzuU3QcjI9gHRh/5EcHKOJmxa/HIj4m0RGq
 LedXKGOBYZNfi4Fum13XySZ/N+XymMsKrbqijV+0MP8Zsf/ihrrqh12pEzGEaFP5Zy
 9Ax8CdFQZxXIACFRJFcSlurcGOpLERKZmEAoaXcYLFPMM5k8wZy10ybDTndDdYPDJF
 zsP06mSavZj8hFSRu+0ZEZ+DUZscSd8xU6AS0gnRn4hxdveZ/t7SPuCMQ78/ATQhTJ
 euCYFOaltA8KxGo3ioD9WouuwJSIgDe/yZP6ApN8S4KPf1XXu0VC8YAdJ5u2Y8h5I2
 i7aZKlz71Aqhg==
Received: from johan by xi.lan with local (Exim 4.98.2)
 (envelope-from <johan@kernel.org>) id 1wLMTC-00000000FZ1-2adL;
 Fri, 08 May 2026 16:46:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] drm/gma500: fix i2c adapter hang and leaks
Date: Fri,  8 May 2026 16:44:43 +0200
Message-ID: <20260508144446.59722-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
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

I stumbled over these when looking into i2c lifetime issues.

Note that the allocated adapter (or looked up reference) appears to be
leaking on successful LVDS init as well. Not sure if it matters.

Johan


Johan Hovold (3):
  drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
  drm/gma500/oaktrail_lvds: fix hang on init failure
  drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init

 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 1 +
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.53.0

