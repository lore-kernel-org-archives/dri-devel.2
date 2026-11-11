Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E30606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=cCnP0DpO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CF910E36B;
	Wed, 11 Nov 2026 09:47:32 +0000 (UTC)
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com
 [111.22.67.151])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6047E10E36B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=cCnP0DpO/Haoism1z+bfki46kVkU+0jS9FcHfg58+FpghWRZQq2cS/Ln/7+7DoNBqNXXlABt5jXrc
 hErT90wBa2yxITWPZogy3yZl7Kxj2utG8rK4geJEm3s2q3OYEiXWVcOQ7oSdHG/EVnM8so/6dYqyRW
 7Ew5e5F4dB52NXdg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af439a9f29-13df7;
 Wed, 11 Nov 2026 17:47:21 +0800 (CST)
X-RM-TRANSID: 2ee26af439a9f29-13df7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af439a6c55-d7dfd;
 Wed, 11 Nov 2026 17:47:21 +0800 (CST)
X-RM-TRANSID: 2ee76af439a6c55-d7dfd
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: dri-devel@lists.freedesktop.org
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Drop dead error check for
 analogix_dp_init_analog_func()
Date: Wed, 11 Nov 2026 17:47:17 +0800
Message-ID: <20261111094719.1655-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <sashiko-outbox-208563@kernel.org>
References: <sashiko-outbox-208563@kernel.org>
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

Hi,

thanks for the review.  You are right, an account handle is not a
proper name for the Developer's Certificate of Origin.  v3 uses
"Xiangwu Lai" for the author and the Signed-off-by trailer; it
follows shortly.

Best regards,
Xiangwu Lai


