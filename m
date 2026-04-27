Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32726FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DF510E92D;
	Mon, 27 Apr 2026 20:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W+Puyo1H";
	dkim-atps=neutral
X-Greylist: delayed 983 seconds by postgrey-1.36 at gabe;
 Mon, 27 Apr 2026 20:49:56 UTC
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C53910E92D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xiedBNgS3v0HKs9MaLb+U085nP+6kQ9+o8L2ezvJ83w=; b=W+Puyo1H4BCcN7OvF2lL3fm3sG
 FRhEcBPmmiBznTgslTmX8epY+W8atEQYUUAjkeT5Y40ty7VVW7zn/a4za9MuHpT5QpI5BjhOo8+BD
 iLodQuq6jU+9Q/QGou70CwHXpK/Ky8jDtlTH4qTh2MEkc4y+bvUaXwl68XVP4w8sRZ/nNfzYLOfuE
 cDy6b/feRp7xiuWRkSWnOHXO2eaCgd9niDJqe62s3AR2sDxFxzcglDUBBo2lDog1PEIOCAdqs4hXV
 WzAgYsBWEZo63b5l4Kl4ndaI+4jAjUg36fJ2pCADy6HUvDjzJwM0HiBDvpSR75lRn4PEjK5lOGBQ6
 JAly2ghA==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50902)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <linux@armlinux.org.uk>) id 1wHSh9-000000007cQ-2smk;
 Mon, 27 Apr 2026 21:36:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1wHSh7-000000005fw-16ew; Mon, 27 Apr 2026 21:36:41 +0100
Date: Mon, 27 Apr 2026 21:36:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Jyri Sarha <jsarha@ti.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Bajjuri Praneeth <praneeth@ti.com>,
 kernel test robot <lkp@intel.com>, thomas.petazzoni@bootlin.com,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/bridge: tda998x: Use __be32 for audio port OF
 property pointer
Message-ID: <ae_I2U_izQs0a471@shell.armlinux.org.uk>
References: <20260417155545.1069280-1-kory.maincent@bootlin.com>
 <ae_IDtaIHvw3gtU2@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae_IDtaIHvw3gtU2@shell.armlinux.org.uk>
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

On Mon, Apr 27, 2026 at 09:33:19PM +0100, Russell King (Oracle) wrote:
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@intel.com/
> 
> This also look scorrect.

Actually, no, this isn't correct. Although this contains the warnings
for the u32 vs __be32 on lines 1784..1785, this report is actually for
a problem on line 1296, which is using 0 as a return value in a
function returning a pointer.

Please omit this, or alternatively replace it with the correct LKP
report that's associated with this particular problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
