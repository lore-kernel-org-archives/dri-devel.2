Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D793CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0328510E52E;
	Wed,  6 May 2026 08:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N+kYe8pP";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D380210E52E
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 08:11:45 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so2776075fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 01:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778055105; cv=none;
 d=google.com; s=arc-20240605;
 b=KvR309cMjN/q1NqqSldzOH/80rkJuCT4Ak4r3d5pLCl4ZDnijJn94agNeZnAw+3RFi
 ufymwH7q10S/a60YRAQlOspO95O9zPzn0lVbpCSETAAqVMMMLVOCxnvtM/fqMQ2EoV/S
 Lc2+Hb5+pL3k7/81Pdh/eXeyBmKzVD0RRc8NtYetpwQLLTwyTy33uexY3JhaoSCD0hQ8
 WLqbMkxDXcnB1F5mMkGvsKt+PKsrh9TuGT1stOiBTpIHCnGpn0u/np3bzdGOn2GkzBpd
 ZCsD8ywDQPTllboknEG61W9p/aZxznLhaEmdvPy8H4WDpXRfmOsiq+GBTcVshSC65iF/
 orUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IlGNO18deW2lnhAeELV6unEFzT07BSx4sNFsPfJ4KSA=;
 fh=D3mbR8TQFHL2g9WOSSH/Hk5h55Xo3w7lhSOIvAGkU1w=;
 b=S2mSoWRbKBCTDaDRpGnEZyd3oViPmrmIURN+Cwi8lADLdMrapMflVXv/GfcFN41kJY
 AA0X5blFt2/fJWg5NIuv3NtQfn64EnCLMuFw1RaLyOJjSCqS1yb4sGuWH7LQLdtBdhGY
 FVG+1rWGpAlVxf17sOs9oIkFvqQ7lUaYhiFHn7Fl73BY2pnyjsQeLwXvNlY83RrErlLm
 EKW50kFOCsH9P8yDosL4rd0cW/PjbSLoarH+4KEDgPq/Kj7EYlbftxKJo0UvivZXGlKr
 f0CPF6DlAArvWJf2CZtvKcCFKb5/Y/HtqzND8hByx4DhIGNqqvap5raTCGFfn33D2IYO
 lFWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778055105; x=1778659905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlGNO18deW2lnhAeELV6unEFzT07BSx4sNFsPfJ4KSA=;
 b=N+kYe8pP3R2fBUGZu+Au0C2JHOQWSo+5hda320XuW7Gg1Lks9L5L51SMwqSfKdXyIj
 /R+7H8rdWYWhq72OA6vj99LFB/mfZskmMjnWAgBBNhEFfeXcpLv1LVyoxDf+J6scJ/5E
 Lqa221PXHTuHgcPUnEJ6Cb/qztx0z9WvW4LtDLSo1ElzV5KDuEdr+qLQ9UbqiJIz6Lw1
 mqN9N0u+gqo/jB47D0WOfH+11f1rTzkmBXg2koXoiusbfP2YBgkZlOeVvfP6yPIHmDGc
 UTZnDPf5pvLPeq2jFKdnZJPcj/XaM0rQEEVjNiC9f7ZSO9mNB3NXkWdQ6J3AOG2Lozd1
 Fd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778055105; x=1778659905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlGNO18deW2lnhAeELV6unEFzT07BSx4sNFsPfJ4KSA=;
 b=TbG5NrWiMJR+6d1hLRq5gpiN72QrBx9eIRVrbASzv0MuUyZa5QhYrxY/Kfbtm+PRBz
 Goi2gzr+4DyU3q0LTRtlXLWKuGYJsS6LAqYQWKvTkNIxNFT+v/z6Ml71A1CIxWpj8hK7
 L3omYnge3a0wKTlbf2KQo/WHOMCpEf67ZR6ptbfsuB+zDGWX8fDxyIPSlThUhYi73//e
 n3zzvKbuSLIEtfx4DtEbE+jgxPZi7QV5YG/Zh69hbgOI0juyD6DRH4m+OH9bP94TZLXV
 +uKF5B0PcLol9rR+i1eDuODmFSuDPSvHWZAEsOgUmNdjQP5UQLrYx218zIWJ+3KBV8nm
 LVTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93rF8urftbXF9H+BHLI7e5S6l2g0MDE6k1OIKtIIa2jeCoCUCtL0lmiXUsyqzfu3M+WykAGvlcb8g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3s2xpiUA8l7dZYees9Jw9vVT1IljCRMDLtYLVrRqz0y9XKS4q
 NXPTcYhuqwvVapxPrKdO5+3bgigaGdpxUET7YqhyxL50DtisHkyEPXcaq1vtCwQ2ys6tJxcr2iG
 JUiD2+DvkczPjDNjrHV3qc440Vo/Qy3M=
X-Gm-Gg: AeBDiesX7grEnnm/l9jSvOxAlcKkE6cex90FCgWAHehQ/hJncehwe8cS4SwrwW9cJKC
 aN57p0me8E1Mamzm6wPI8LEvkL5cg5UMNNtu0TcqsTMAB+WEFMBUxIfhJPNSVn2PwOQSdqyvP7V
 cFALShrHGxfdYOl0YZ4Nlch61Yycqw8fi8wXp8n5sBaEbY3lKloAo9y2L7UpMRyqilEJ8UKyO6v
 S/AELEXkBZvwFYjHWqczXQFV/0vJsHkZXSwDsllt5uFym23sVeDWyRedvdgbWb2R3hgngejm4Cr
 3fwrMhp8uhKocVnaOw==
X-Received: by 2002:a05:6808:1c0a:b0:467:70c:a7d1 with SMTP id
 5614622812f47-48042499994mr1260774b6e.27.1778055104887; Wed, 06 May 2026
 01:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
 <981b4edf04d7fce3bd750f1136ac4ad78628d114.1777545446.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <981b4edf04d7fce3bd750f1136ac4ad78628d114.1777545446.git.u.kleine-koenig@baylibre.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 6 May 2026 10:11:33 +0200
X-Gm-Features: AVHnY4LNpr-vFbumyzlchXC9SkKu2r0V-5GK-mPxWJ_WIJac4-7gh3ZWjp2MAUo
Message-ID: <CAMeQTsYi+x53oTeHywdC_oV_p00aFpx3t_FxujzBK+Q0DQMJUA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/gma500: Drop unused include of
 <drm/drm_pciids.h>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 30, 2026 at 12:45=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable=
 Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The <drm/drm_pciids.h> header only defines radeon_PCI_IDS which isn't
> used in the gma500 driver. So drop the useless include statement.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Applied to drm-misc-next

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index 039da26ef24d..f7ec6c21a9a1 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -24,7 +24,6 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_ioctl.h>
> -#include <drm/drm_pciids.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
>
> --
> 2.47.3
>
