Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE102606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jsaBElm0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE5B10F917;
	Wed, 11 Nov 2026 08:01:38 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8572710F884
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=jsaBElm0mzVd15WRo/O1k6Ga+oXtdF8Q5f0I+ZP/ENzP/IxI7sGb0vDeiFsgq11zDZzPCwwCOZD2P
 mKBpQjXseT7yBrkXca8fNANwc/F3hHgPZN1AC28A2sDprqYdXgcl+T7kyVcfC3nn2M0RbQ/Pwl6WNU
 hKK05HYHa274jeSY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af420d75ae-d3baf;
 Wed, 11 Nov 2026 16:01:28 +0800 (CST)
X-RM-TRANSID: 2ee56af420d75ae-d3baf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af420d6f92-d43e4;
 Wed, 11 Nov 2026 16:01:28 +0800 (CST)
X-RM-TRANSID: 2ee56af420d6f92-d43e4
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: dri-devel@lists.freedesktop.org
Cc: laixiangwu <laixiangwu@cmss.chinamobile.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix runtime PM refcount leak in
 set_bridge()
Date: Wed, 11 Nov 2026 16:01:25 +0800
Message-ID: <20261111080126.1549-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <sashiko-outbox-190700@kernel.org>
References: <sashiko-outbox-190700@kernel.org>
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: laixiangwu <laixiangwu@cmss.chinamobile.com>

Hi,

thanks for the review.  You are right: since 917c8d192ba6ad
("drm/bridge: analogix_dp: don't wait for PLL lock too early") removed
the PLL lock polling loop, analogix_dp_init_analog_func() only
performs register writes and always returns 0, so the error check
this patch tried to fix is dead code and the leak it addressed cannot
actually happen.

Instead of keeping a fix for an unreachable path, v2 drops the dead
error check and makes the function void.

v2 follows shortly.

Best regards,
laixiangwu


