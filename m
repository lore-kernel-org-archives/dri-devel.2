Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C700C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965F610E250;
	Thu, 10 Sep 2026 07:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jTjQ7F8L";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9650A10E250
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789025036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOllz7iFisoMuqz9HYVsrPAX9tAU/LdtpLGaNl5A5Bo=;
 b=jTjQ7F8Lt+rVplHy3HwNU1pqr/HmxUzhYo9A4Iq4Y5CHz/T2igNCGBo4RM5nAFvY+S6KWy
 rxUIH4aPrDEtOS3L4QvohViE7IkgMOX9wGirOGRVfqNq6MI9Oc79iEgvZ37Ig7Rgd3kPih
 +r17+LoGeBFdpREbNDmqTZcBsndQPrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-1ofWDJrQPPeiyvcFNf2EyA-1; Thu, 10 Sep 2026 03:23:55 -0400
X-MC-Unique: 1ofWDJrQPPeiyvcFNf2EyA-1
X-Mimecast-MFC-AGG-ID: 1ofWDJrQPPeiyvcFNf2EyA_1789025034
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso46551015e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789025034; x=1789629834;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jz9koIHvC3GBX/XUcgHOfcrwJtKrYjkKEL6ZBTQ6TM0=;
 b=EbmJAeJvzq2GjsyJ5dPY1ocb3yrNwh+wy7brTQY0/igoYcS+vHYUWZ/gWionb/Levk
 7ySFeRBKuaAzICavxRzyBHD2BUQng0wZeW1b/bEphKFrcUkM57QfjlVN/W6cMueE6uy/
 YHJVnTtNal9Cw5geWBAFA5umE+Wd9xFyW63Yxy6snvgBGuRgF70fYcK7Yt5e960vH5I0
 PTlFEAWSj+hilla7y384NzyY8EHg7Wl9Z7uSf0eHbQZfpuFgM+C6X3yYgOzZmMe32bxm
 T7RXmlSGsJPuWeboABP8YgGkwvC+jamuU9lppJNNVWtkq6exxbdtmvEoPt0jTXZZ8pnl
 F88w==
X-Gm-Message-State: AFuF++m2F4fsgn680GUuIUfUcI6DZahUGXYKjHdvOAL45reSKByXCByZ
 mF5YrL1CNGPFHGkOLB0nqaBxHHqu8BnGu6Jg65pwRlFtPMW5sbBaAKf/2+xpFmZEmxeUFY4tvSg
 oj6xu2hi7EbR5vXJO0HP2iN6kr4qs6icXzvc7pWbs590qj+HtLa8HnJvU9dkO0NWuNl90Dw==
X-Gm-Gg: AYBFou2KBkYIUHiZN57BABQekC5f+InC7kuOt7pR6zFSU3NBRVoKbYkVTp5fFEXFXGh
 c8COWbUfNfPehf2wCHQFHQDrOpTygsI+JpweRrkZ/1GI2DkOYsEwxbapCFzz0ykkgnF28VrBrhb
 aO8uZx+bZ0IvLwZBPnbsbSEySnG1dQb1vH5qGlLgirM3lhAKj4D10ZLMA2xNVyWegrL1D61LLE2
 ESRDMTpgOuOpU/AFEh5ypdOvrsUJuPs6fYbZ/9FHdZDmU7nQim79lTP3jKIxY4OgHSkYBpOrcys
 nHzqmuUe5CjFcsESDj7hrTNRa6WI2/rqPIWGIJVeJtrNUHQtNIvzNOdKnpQ+hVeSEvZeB1ofLdV
 cN1MFG0axj38ziz9naJYcMnb0uipKOiyNfO0gvH9WUOFZPrNEPKJngxIM9A==
X-Received: by 2002:a05:600c:46d5:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49d258d8be2mr48295445e9.9.1789025034237; 
 Thu, 10 Sep 2026 00:23:54 -0700 (PDT)
X-Received: by 2002:a05:600c:46d5:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49d258d8be2mr48294805e9.9.1789025033597; 
 Thu, 10 Sep 2026 00:23:53 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm19301115e9.13.2026.09.10.00.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:23:49 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
 ilias.apalodimas@linaro.org, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 1/3] firmware/sysfb: Remove rotation quirk for Lenovo
 D330
In-Reply-To: <20260904090850.43060-2-tzimmermann@suse.de>
References: <20260904090850.43060-1-tzimmermann@suse.de>
 <20260904090850.43060-2-tzimmermann@suse.de>
Date: Thu, 10 Sep 2026 09:23:48 +0200
Message-ID: <871pb1efi3.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vro0iQETGyp0ikyFdPq41cbyUPTtF91VzwYvb0qiynk_1789025034
X-Mimecast-Originator: redhat.com
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The Lenovo D330 is a notebook with detachable display. The display
> is installed in landscape orientation, but the display mode is in
> portrait orientation. By default, the display output is rotated to
> the left by 90=C2=B0.
>
> The sysfb quirk breaks the display by swapping display width and
> height; and thus mixing up the display geometry. Fix this by keeping
> the display as-is. The sysfb DRM drivers, usually efidrm, will pick
> the correct panel orientation for the display.
>
> The exact behavior might depend on the version of the BIOS release,
> but the exact version numbers of broken and good releases are unknown.
> Users are advised to update to the latest firmware.
>
> Tested on a Lenovo D330-10IGM IdeaPad with firmware 8NCN43WW.
>
> v3:
> - mention possible dependency on BIOS release in commit description
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
>  =09=09},
>  =09=09.callback =3D efifb_swap_width_height,
>  =09},
> -=09{
> -=09=09/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
> -=09=09.matches =3D {
> -=09=09=09DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -=09=09=09DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
> -=09=09=09=09=09"Lenovo ideapad D330-10IGM"),
> -=09=09},
> -=09=09.callback =3D efifb_swap_width_height,
> -=09},

Agreed that is better to rely on the information provided by the
firmware, instead of having this quirk. Specially given that it
breaks when the firmware provides the correct display geometry.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

