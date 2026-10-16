Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF27CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E623112765;
	Fri, 16 Oct 2026 11:20:34 +0000 (UTC)
X-Greylist: delayed 534 seconds by postgrey-1.36 at gabe;
 Fri, 16 Oct 2026 11:20:32 UTC
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D0D112765
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 11:20:32 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout3.hostsharing.net (Postfix) with ESMTPS id F38F5C94;
 Fri, 16 Oct 2026 13:11:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id B2E5C602EA06; Fri, 16 Oct 2026 13:11:35 +0200 (CEST)
Date: Fri, 16 Oct 2026 13:11:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Adam Azuddin <azuddinadam@gmail.com>
Cc: Aun-Ali Zaidi <admin@kodeit.net>, Aditya Garg <aditya.garg@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Atharva Tiwari <evepolonium@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/appletbdrm: Fix incorrect error message on encoder
 attach failure
Message-ID: <atIGZ78zy4St-MEA@wunner.de>
References: <20260926-fix-err-msg-appletbdrm-v1-1-bb578a7dbdda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-fix-err-msg-appletbdrm-v1-1-bb578a7dbdda@gmail.com>
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

On Sat, Sep 26, 2026 at 09:18:11PM +0800, Adam Azuddin wrote:
> drm_connector_attach_encoder() replaced an earlier call to
> drm_simple_display_pipe_init() during review, but the error message
> logged on failure was not updated to match and still refers to the
> old call.
> 
> Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Macs")
> Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>

Applied to drm-misc-next for v7.5, thanks.
