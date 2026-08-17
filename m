Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2EEC5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A057510E6D2;
	Mon, 17 Aug 2026 08:31:52 +0000 (UTC)
X-Greylist: delayed 373 seconds by postgrey-1.36 at gabe;
 Mon, 17 Aug 2026 08:31:51 UTC
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.78.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E3510E6CD;
 Mon, 17 Aug 2026 08:31:51 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout2.hostsharing.net (Postfix) with ESMTPS id 6C61710DF5;
 Mon, 17 Aug 2026 10:25:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 4D435602C817; Mon, 17 Aug 2026 10:25:36 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:25:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6] drm/radeon: fix internal display on iMac11,1
 (RV770/DCE3.1)
Message-ID: <aoLFgErQKXoxYE3H@wunner.de>
References: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
 <20260817004326.3192-1-gilles.risch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817004326.3192-1-gilles.risch@gmail.com>
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

On Mon, Aug 17, 2026 at 02:43:26AM +0200, Gilles Risch wrote:
> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> DisplayPort path. Without this fix the display stays dark under KMS.
> 
> This machine suffers from the same issue as iMac10,1 and iMac11,2:
> Apple routes the internal display through Link B of the DIG encoder
> instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> the Apple-specific encoder assignment into its own block, independent
> of the DCE version check.
> 
> Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> to avoid affecting other boards.
> 
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

> Good morning,
> 
> this is v6 of the patch, rebased on top of amd-staging-drm-next
> (agd5f/linux).
> 
> There are no functional or code changes since v5.
> 
> Regarding Lukas Wunner's previous Reviewed-by (which was provided on v2),
> I have kept him in CC so he can confirm if his review still stands given
> the changes between v2 and v5.
> 
> Could you have a look at this when you have a spare moment?
> 
> Regards,
> Gilles
> 
> Changes in v6:
> - Rebased on amd-staging-drm-next (no functional/code changes since v5)
> ---

Put additional information like this below the three dashes
so that it's not committed to the git repo when the maintainer
applies your patch.

> -	if (ASIC_IS_DCE32(rdev)) {
> -		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> -		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
> -			enc_idx = (dig->linkb) ? 1 : 0;
> -		else
> -			enc_idx = radeon_crtc->crtc_id;
> +	if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> +	    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
> +	    dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
> +		enc_idx = (dig->linkb) ? 1 : 0;
> +		goto assigned;
> +	}

Nit:
If the number of dmi_match() calls exceeds one or two, for readability
it's usually a good idea to create a table and match against that with
dmi_check_system().

Thanks,

Lukas
