Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88674CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82A610E5BC;
	Tue,  9 Jun 2026 18:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZhYd5WTv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E9710E5BC
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eDqBRZyyQFTG1aJRuyLocs2xO/35+HTugTlFBZJbiSI=; b=ZhYd5WTvI0yv8nw9t2u8wiK1zb
 /phLPOgqRS1ku056F4tTLBs1OKIoo0aZfAGUhLyMKeyuUKMQwlq0lvM9jpdbQY8YV0rHy5kXWXaFX
 jo+ShX69K85bqpnq+iKdXgPaiWlPzBOpkwO+pXersbrfAHmsqR9NVhtn31Nsof4mH35mW7Jd7qnpr
 ooBCW/P0bVn1eMfqyVc0iKec0iFg8caOwRjUc1i8gkUZPPU0cu7pvdzMi1We+lbNCnO522vYNwqC6
 y8qkkX39Gam8UUIEsfkJsYG5r9M1wT5Lv2ZlfxGzFAzEeGMofcHgqZNAS58avnMFQ3t475vCbiw9v
 CcgL/nAw==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX10x-00F6Lb-TO; Tue, 09 Jun 2026 20:17:28 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Emma Anholt <anholt@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] drm/v3d: Deprecate V3D 3.3 and 4.1 support
Date: Tue,  9 Jun 2026 15:17:08 -0300
Message-ID: <178102902558.1180812.15875772125825655162.b4-ty@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606185616.694188-2-mcanal@igalia.com>
References: <20260606185616.694188-2-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Sat, 06 Jun 2026 15:55:13 -0300, Maíra Canal wrote:
> V3D 3.3 (Broadcom BCM7268) and V3D 4.1 (Broadcom BCM7278) has had no
> in-tree userspace since Mesa dropped support in 2024, on the grounds
> that those generations were no longer being tested. The situation in
> the kernel is similar: the maintainers don't have this hardware, the
> hardware is not available for purchase, and there is no known user of
> these GPUs.
> 
> [...]

Applied, thanks!

[1/1] drm/v3d: Deprecate V3D 3.3 and 4.1 support
      commit: 7ffcc4fffb45ee98e7a9683e109050246dc194af

Best regards,
- Maíra
