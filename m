Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93AACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA7210E131;
	Thu, 15 Oct 2026 12:27:44 +0000 (UTC)
X-Greylist: delayed 601 seconds by postgrey-1.36 at gabe;
 Thu, 15 Oct 2026 12:27:42 UTC
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB46710E131
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:27:42 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout1.hostsharing.net (Postfix) with ESMTPS id C3414695;
 Thu, 15 Oct 2026 14:17:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 9C62160D366E; Thu, 15 Oct 2026 14:17:39 +0200 (CEST)
Date: Thu, 15 Oct 2026 14:17:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Konstantin Sinyuk <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Koby Elbaz <elbaz.koby@gmail.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update habanalabs maintainer contacts and
 status
Message-ID: <atDEY4wdfSqdhkH5@wunner.de>
References: <179187884916.468.5557909498363748284@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179187884916.468.5557909498363748284@kernel.org>
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

On Tue, Oct 13, 2026 at 11:07:29AM +0300, Konstantin Sinyuk wrote:
> Update the contact addresses for Konstantin Sinyuk and Koby Elbaz
> and add the corresponding mailmap entries.
> 
> Set the driver status to Maintained to reflect the current
> maintenance arrangement.
> 
> Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
> Acked-by: Koby Elbaz <elbaz.koby@gmail.com>
> ---
> Lukas, following our discussion at LPC, here is the contact and
> maintenance-status update.

Applied to drm-misc-fixes, thanks.

Unfortunately I narrowly missed this morning's drm-misc-fixes pull,
so I'm afraid this will take another week until it gets forwarded.

> +++ b/MAINTAINERS
> @@ -11432,8 +11432,8 @@
>  HABANALABS PCI DRIVER
> -M:	Koby Elbaz <koby.elbaz@intel.com>
> -M:	Konstantin Sinyuk <konstantin.sinyuk@intel.com>
> +M:	Konstantin Sinyuk <ksinyuk@kernel.org>
> +M:	Koby Elbaz <elbaz.koby@gmail.com>
>  L:	dri-devel@lists.freedesktop.org
> -S:	Supported
> +S:	Maintained
>  C:	irc://irc.oftc.net/dri-devel
>  T:	git https://github.com/HabanaAI/drivers.accel.habanalabs.kernel.git
>  F:	Documentation/ABI/testing/debugfs-driver-habanalabs

I assume you both retain access to that git repo.  Please send another
update if/when a change to the repo's location becomes necessary.

Thanks,

Lukas
