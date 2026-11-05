Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C531606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Icn3aCWa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6F9112891;
	Thu,  5 Nov 2026 23:21:45 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A05112891
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=aLvtIORUcIji39lg8fiARd0b21RbnKtHkgK4GoPW0iY=; t=1793920899; x=2109280899; 
 b=Icn3aCWa7alsFZjcaDb6YVfLZsY92ovkFXcRz65AknaqHn7Ptm/qGHiYGE+g7QdyMXzqeem0dMi
 fufxH5RxV7dnNlacIx7r2b/Wag+Ic6J4jyATBIt82qma//6YY0CM75CqWNplithyDEIP0UadwTRRO
 OQlD6/g3MBSZjnpIab659BvCdDQ3PikEGl0+UN8DcruRnjWz6NgC6yhwR2+MH0TYdckS4t7s5kp8x
 kkCmlVnZw2lIXaM6UmcnnsTsUIoeDv89eNNLZMeRKr8PB4Vnhfbufkna3p7gxXPqn4s8ayALzTYV6
 MBGCMkf7Z4dBRX7XWRdWaXJDef9HOivdJdFg==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xP6lm-003qVr-Ll; Fri, 06 Nov 2026 00:21:23 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Paul Cercueil <paul.cercueil@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] drm: remove deprecated *_of_get_bridge() from
 non-OF drivers
Date: Thu,  5 Nov 2026 20:20:09 -0300
Message-ID: <179392080015.2087368.10442125005944134792.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
References: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 05 Nov 2026 11:32:04 +0100, Luca Ceresoli wrote:
> Replace the deprecated *_of_get_bridge() calls with
> of_drm_get_bridge_by_endpoint() for all drivers which can be built without
> CONFIG_OF.
> 
> Some of those drivers had a build failure for configs without
> CONFIG_OF. This series used have fixes for those failures plus other
> patches to convert all other such drivers to
> of_drm_get_bridge_by_endpoint().
> 
> [...]

Applied, thanks!

[1/3] drm/vc4: dpi: stop using deprecated drmm_of_get_bridge()
      commit: 5c18e4b11829d9228510d9580027598b54d382e7
[2/3] drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()
      commit: 4a38a538775e072fee707aa28aea5ccd50941796
[3/3] drm/vc4: dsi: remove unnecessary intermediate pointer computation
      commit: 41ecf852c07391687beb129e12a231760b5d783f

Best regards,
- Maíra
