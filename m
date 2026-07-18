Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410EC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A841A10E5B1;
	Sat, 18 Jul 2026 14:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="maWdL5OX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290AE10E5B1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=tFG+MUX+cRNSZMBWDxcF7gV/h1B70zxD/kMldbvWjSE=; b=maWdL5OXJnoesTPBjSLefONW77
 Fx87ySPTRX6tuJiM2NFndnuUYSv6Ok/aGAbDw/kfciIiNLrLbP24lfQRdHXWMrbfY1ksRwNuIZok8
 JktFL+DLMsreESsG42zrE5PIWS469UpJQRoAX/PxHG0IxsN32vs5wUhUO9L6WUh+TyJhGyHt9dcB8
 gW8Fo257NQDQkfygMWoyk5M5AJqn8+4+nIkvvkXW6+t4SP68MPYVraBPHR5eY6bqX+rJ5YrdMUTHU
 aFzGmPxvAMSgYCw30mCHY3jH30Ftj4wZMx4oCqYuobBLhL1hdxmkxVQSU1uHN9+VKqVGvkb2bzu6W
 9ZINmbeQ==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wl6Ny-00HTMY-JS; Sat, 18 Jul 2026 16:51:27 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: take i2c adapter module reference
Date: Sat, 18 Jul 2026 11:51:03 -0300
Message-ID: <178438625488.3077907.10437803537253623825.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132448.1565278-1-johan@kernel.org>
References: <20260716132448.1565278-1-johan@kernel.org>
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


On Thu, 16 Jul 2026 15:24:48 +0200, Johan Hovold wrote:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
> 
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: hdmi: take i2c adapter module reference
      commit: 7a4b7122a623e3d57fc15cf843a9d45fbd72c6ab

Best regards,
- Maíra
