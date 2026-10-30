Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFC606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=a8sqbx3o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1249010EA0A;
	Sun,  1 Nov 2026 12:00:45 +0000 (UTC)
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com
 [111.22.67.137])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1962D1127B3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=a8sqbx3oNNhXt0lqJ1Oxjxjwozq8dO9yMt7Z2eHUcN5GhpHTZGfVKfN2BUaOgM11ES27bKPL8uAYx
 SIRIMgLuWtZ+MZeX7q7s1GSV7tlfLvQ/I04QNVltqxYIsn64Vww7MvseqcqvZAm9UDkFPo8mRkX9rV
 VAdEBgeocndfTbUI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46ae49d35e51-15517;
 Fri, 30 Oct 2026 21:35:49 +0800 (CST)
X-RM-TRANSID: 2ee46ae49d35e51-15517
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[112.22.250.195])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ae49d33695-0d785;
 Fri, 30 Oct 2026 21:35:49 +0800 (CST)
X-RM-TRANSID: 2eea6ae49d33695-0d785
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: laixiangwu <laixiangwu@cmss.chinamobile.com>,
 dri-devel@lists.freedesktop.org, Lucas Stach <l.stach@pengutronix.de>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] drm/imx/dcss: Fix clock leak on blkctl init failure
Date: Fri, 30 Oct 2026 21:31:30 +0800
Message-ID: <20261030133355.1938-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <auRgElrEh0YlUaKc@vm>
References: <auRgElrEh0YlUaKc@vm>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Laurentiu,=0D
=0D
Thank you for the review!=0D
=0D
I've renamed the error labels as you suggested and sent a v2, which=0D
threads below this mail. Please take a look.=0D
=0D
Best regards,=0D
laixiangwu=0D


