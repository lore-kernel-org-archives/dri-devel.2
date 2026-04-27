Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C148FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E17A10E92F;
	Mon, 27 Apr 2026 20:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DD0CEUac";
	dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F47B10E92F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b6p+7B0gTye48rX8dXe6m7frVhoTqEq1SDQ7r4+JJRc=; b=DD0CEUacdjehDpKLO2S6rFuP8y
 LObPOqseD+zGE23eWiW3ed92VXTW/tFdhXc4TE4g/00psgbj6AOZZ2rgndGe5BxMFdK5VHAqVup+V
 PMrgQKYNVEWAjKS0uLABh/Vk8+wtKWdruG+NPQl2G0ytEu68ZHjMcyALCb705LaHuv88KxvKyWXxH
 +vHdnZsxs2ja+27jwmTESAW7MfgmXmoWxFDqsFm1xScvEUzolKtJ6pjigho6CkmUuCq0WW7OWG5ow
 KZxtmv+XRblFV/j8SbQx9MuKxSr6R/dC7NTIAOih3Fgpjln3RP6WCh23Z4qftDDx89aXicuc3qQsK
 2CgMAIrQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47702)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <linux@armlinux.org.uk>) id 1wHSdv-000000007bw-2VIP;
 Mon, 27 Apr 2026 21:33:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1wHSdq-000000005fl-3m52; Mon, 27 Apr 2026 21:33:18 +0100
Date: Mon, 27 Apr 2026 21:33:18 +0100
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
Message-ID: <ae_IDtaIHvw3gtU2@shell.armlinux.org.uk>
References: <20260417155545.1069280-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417155545.1069280-1-kory.maincent@bootlin.com>
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

On Fri, Apr 17, 2026 at 05:55:44PM +0200, Kory Maincent wrote:
> From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
> 
> of_get_property() returns a pointer to big-endian (__be32) data, but
> port_data in tda998x_get_audio_ports() was declared as const u32 *,
> causing a sparse endianness type mismatch warning. Fix the declaration
> to use const __be32 *.

This is correct.

drivers/of/fdt.c::populate_properties() assigns pp->value to point into
the flattened device tree's data, and the native data format is big
endian.

                pp->value  = (__be32 *)val;

This pointer is returned by of_get_property().

port_data is read using be32_to_cpup().

So, yes, port_data should have been a __be32 pointer.


> Fixes: 7e567624dc5a4 ("drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding")

This is correct.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@intel.com/

This also look scorrect.

> Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
