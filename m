Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E3606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=f0QgEvlG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948B8112C4C;
	Fri,  6 Nov 2026 09:18:53 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 309AF10E873
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=f0QgEvlGtr0hFGFIHu0ogaOFbcThCjuubVjB3QcGmZRUNr5GIZ7d522SC6ORdo8+RMhf82OVYgyqM
 RP7a0uShwdfNnXX1vYPu8FH2xQrG+mFcoQhNdBBCvpRbmedruRhKnUGVBOStNasua9RMEin5t6de2N
 JdPM7oE791PhuhwA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aeafbfb5e0-786b9;
 Wed, 04 Nov 2026 17:33:47 +0800 (CST)
X-RM-TRANSID: 2ee16aeafbfb5e0-786b9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from FHA-W6400298 (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeafbf81cb-1d563;
 Wed, 04 Nov 2026 17:33:47 +0800 (CST)
X-RM-TRANSID: 2ee76aeafbf81cb-1d563
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 0/3] drm: Fix resource leaks on power-on failure paths
Date: Wed,  4 Nov 2026 17:33:41 +0800
Message-ID: <20261104093345.1674-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes similar resource leak bugs in DRM panel and bridge
drivers.

In all three drivers, a primary resource (regulator or clock) is enabled
first, followed by a secondary resource. If enabling the secondary
resource fails, the drivers return directly without disabling the first
one. Because these resources are reference-counted and the matching
power-off/unprepare callbacks won't be triggered on failure, the
reference counts leak.

Patch 1 and 2 use goto labels to rollback the regulators. Patch 3 is a
void function and explicitly disables the leaked regulator on failure.

Tang Bin (3):
  drm/panel: renesas-r61307: disable vcc on iovcc enable failure
  drm/panel: otm8009a: disable supply on init_sequence failure
  drm/bridge: anx6345: disable dvdd12 on dvdd25 enable failure

 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 1 +
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   | 6 +++++-
 drivers/gpu/drm/panel/panel-renesas-r61307.c       | 6 +++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.52.0.windows.1



