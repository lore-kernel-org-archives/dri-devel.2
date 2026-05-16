Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E609BCD4F3C
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 18:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1F810E1F4;
	Sat, 16 May 2026 18:17:10 +0000 (UTC)
X-Greylist: delayed 430 seconds by postgrey-1.36 at gabe;
 Sat, 16 May 2026 18:17:09 UTC
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EAF10E1DE;
 Sat, 16 May 2026 18:17:09 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout3.hostsharing.net (Postfix) with ESMTPS id 25B90C26;
 Sat, 16 May 2026 20:09:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id E30E4600E5AC; Sat, 16 May 2026 20:09:56 +0200 (CEST)
Date: Sat, 16 May 2026 20:09:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/radeon: fix internal display on iMac11, 1
 (RV770/DCE3.1)
Message-ID: <agiy9II5jkHEgPAq@wunner.de>
References: <20260510185426.4264-1-gilles.risch@gmail.com>
 <20260516092420.3579-2-gilles.risch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516092420.3579-2-gilles.risch@gmail.com>
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

On Sat, May 16, 2026 at 11:24:21AM +0200, Gilles Risch wrote:
> The Apple iMac11,1 (late 2009) has an integrated ATI Mobility Radeon
> HD 4850 (RV770/M98L) with a 2560x1440 internal panel connected via an
> internal DisplayPort path. This machine suffers from a similar problem
> as the iMac10,1 (late 2009) and the iMac11,2 (mid 2010). Without this
> fix the display stays dark under KMS. Two issues are addressed:
> 
> 1. The RV770 implements DCE3.1 and not DCE3.2. ASIC_IS_DCE32() starts at
>    CHIP_RV730 which is newer than RV770, so the RV770 never matched the
>    DCE3.2 PLL and encoder logic. Introduce ASIC_IS_DCE31() starting at
>    CHIP_RV770 to fix this.
> 
> 2. Apple routed the internal display through Link B of the DIG encoder
>    instead of Link A, as observed in the kernel display connector log.
>    The same quirk already exists for iMac10,1 and iMac11,2 - iMac11,1
>    was simply missing from the list.

Not an expert in the radeon driver or AMD chip revisions, but if it
helps improve support for older Macs I'll be happy to offer my:

Reviewed-by: Lukas Wunner <lukas@wunner.de>

It's not immediately obvious that CHIP_RV770 precedes CHIP_RV730
in the enum and that hence ASIC_IS_DCE31() subsumes ASIC_IS_DCE32().

Thanks,

Lukas
