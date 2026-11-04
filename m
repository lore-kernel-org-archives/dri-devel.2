Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80E606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=H06A/TS0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE28112C3E;
	Fri,  6 Nov 2026 09:18:48 +0000 (UTC)
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com
 [111.22.67.137])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9709210FA60
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=H06A/TS051Jqsx0O/xneDZwyB1eYClsnMAwRYCOz8TChJm1R/F0zSWa+2dkyEV42lV77IIGC9o8OF
 36TsBtNcHPOC93TSN47eUJrHizAP/Vw0VClf0L53f052BpB4nA0ExKiKDKcde0AjhHR3OeMWSZwTRd
 tIufOouHC7GYWmOA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46aeaf1dd177-3bbcd;
 Wed, 04 Nov 2026 16:50:38 +0800 (CST)
X-RM-TRANSID: 2ee46aeaf1dd177-3bbcd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from FHA-W6400298 (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeaf1dc8a0-1bc06;
 Wed, 04 Nov 2026 16:50:38 +0800 (CST)
X-RM-TRANSID: 2ee76aeaf1dc8a0-1bc06
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 0/2] drm/panel: Fix pp3300 regulator leaks on prepare()
 failures
Date: Wed,  4 Nov 2026 16:50:33 +0800
Message-ID: <20261104085036.1441-1-tangbin@cmss.chinamobile.com>
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

This series fixes a copy-paste bug in the panel prepare() error paths.

Both the boe-tv101wum-nl6 and ilitek-ili9882t drivers enable pp3300 first, 
but fail to disable it if a subsequent step (like enabling pp1800 or 
sending DCS commands) fails. This leads to a regulator refcount leak 
across repeated prepare failures.

The ili9882t driver was derived from the boe driver, which is why it 
inherited the identical bug.

Tang Bin (2):
  drm/panel: boe-tv101wum-nl6: disable pp3300 on prepare() error paths
  drm/panel: ilitek-ili9882t: disable pp3300 on prepare() error paths

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 4 +++-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.52.0.windows.1



