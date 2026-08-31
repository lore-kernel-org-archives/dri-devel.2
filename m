Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8602C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D488C10E278;
	Mon, 31 Aug 2026 12:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="He8nP5KE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CA510E278
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788180591; x=1819716591;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=ZocEU62Tp7CW5EHPQf17jxETiiTSZAvc7mJXXDvDRW8=;
 b=He8nP5KEMDy9jtFaOvTnsRyAx5cPM8K5SCO24LILyNIJaReWJKUeBF+z
 lABWtzd4z2BARi3vkxR21OkJZP73x/3Fp7GszPCGjEaFNCE5qXrLrHgmv
 Rqt+SS3bQxCCGAp3wy6IePxP3x23HrZDVlLhK46nATWG2CeErZ9fp3CFy
 pfChkMuPI/F9qwUwID+VZJ4nozcIkSXMEPjzqVstu87yeM1j8SY65x1sP
 lLyx9TcoW05aL7Oc5Vm0NIpBmGOjgTAiwD79JR+9+rRrkCS0uo93c4bZ4
 DE1S9c3P5ku8MNUEzOs5Cm40BEcdULBgb/o5KUkvA6fH8RDLEPxy5yrov A==;
X-CSE-ConnectionGUID: XB64pViKQPusEPw4omFJcA==
X-CSE-MsgGUID: B6tRzSH5TR+QwfsNLl0c9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92396730"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="92396730"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:49:50 -0700
X-CSE-ConnectionGUID: c0HA87LeQU+ClPH7jZ54MA==
X-CSE-MsgGUID: x1fqedx1ROevCmq0ZjLOIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="266203450"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:49:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 ardb@kernel.org, ilias.apalodimas@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/3] firmware/sysfb: Remove rotation quirk for Lenovo
 D330
In-Reply-To: <20260831093020.494701-2-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260831093020.494701-1-tzimmermann@suse.de>
 <20260831093020.494701-2-tzimmermann@suse.de>
Date: Mon, 31 Aug 2026 15:49:44 +0300
Message-ID: <5f8aceb5b36607877509995550d6dbbfad675ba7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 31 Aug 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> The Lenovo D330 is a notebook with unmountable display. The display

Please elaborate on what you mean by "unmountable display".

No comments on the patch itself, I just haven't heard that before.

> is installed in landscape orientation, but the display mode is in
> portrait orientation. By default, the display output is rotated to
> the left by 90=C2=B0.
>
> The sysfb quirk breaks the display by swapping display width and
> height; and thus mixing up the display geometry. Fix this by keeping
> the display as-is. The sysfb DRM drivers, usually efidrm, will pick
> the correct panel orientation for the display.
>
> Tested on a Lenovo D330-10IGM IdeaPad.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/sysfb_efi.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysf=
b_efi.c
> index 685283bb7327..2338de73c62c 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -301,15 +301,6 @@ static const struct dmi_system_id efifb_dmi_swap_wid=
th_height[] __initconst =3D {
>  		},
>  		.callback =3D efifb_swap_width_height,
>  	},
> -	{
> -		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
> -		.matches =3D {
> -			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
> -					"Lenovo ideapad D330-10IGM"),
> -		},
> -		.callback =3D efifb_swap_width_height,
> -	},
>  	{
>  		/*
>  		 * Lenovo IdeaPad Duet 3 10IGL5 and 10IGL5-LTE with

--=20
Jani Nikula, Intel
