Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA4606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5xYCAMe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F59310E47B;
	Sun,  1 Nov 2026 21:25:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183F210E47B
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 21:25:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DD7760054;
 Sun,  1 Nov 2026 21:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC221F000C1;
 Sun,  1 Nov 2026 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793568307;
 bh=aa7BtySn53aZmx7RdGM7rYSDbXWpBnUs4KO28aFZ9nQ=;
 h=From:To:Cc:Subject:Date;
 b=e5xYCAMeWuhFfg/yxBWQDNgSOFcvEvA/iHgOUpXKSG4QzJBjgNgCMWXzkOyqiKO2h
 Xkf1Jd9IYgHEL/xUGfSPnw5Xw2/rqk3eCq7Od97qGMK6K2ApxlQxj8XxuyNfBybOpr
 K11JPFYFXzwSwO4lzt0sEnhqWDAmYwZM18W1LHaVEHn318+IiCu8rbkRR3L/PGK01X
 9++Sun6PB3rvadjP0GDNIHi4tqsU9kcO6fH7C9DEdlXrEXeWZYuhCryRiNEkao2mLD
 K2/6HZg+hmLGkHfsL03IyPsvujcd1a83Ybq4W0r7SwO36iXYw8JHDjAX1NFiZOXE/G
 +FyMKbl7bt6hg==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/panel: visionox-r66451: Fix brightness and power on
Date: Sun,  1 Nov 2026 23:24:56 +0200
Message-ID: <20261101212458.2431191-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two fixes for the Visionox R66451 panel driver, found while enabling the
panel on the Qualcomm SM8350-HDK display card.

The first change sends the DCS brightness value MSB first, as the panel
expects. Without it, the brightness does not follow the requested value,
and the default brightness is received as a different value.

The second change waits longer after the panel reset. With the current
10ms delay, the panel misses the initialization commands, does not exit
sleep mode, and the display stays black.

Vladimir Zapolskiy (2):
  drm/panel: visionox-r66451: Send the brightness value MSB first
  drm/panel: visionox-r66451: Wait longer after the panel reset

 drivers/gpu/drm/panel/panel-visionox-r66451.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0

