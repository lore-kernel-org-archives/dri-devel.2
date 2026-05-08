Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4E7CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451F110E2F7;
	Fri,  8 May 2026 10:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/xAe8b+";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9D410E30F
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:00:43 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so1106224f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 03:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778234442; cv=none;
 d=google.com; s=arc-20240605;
 b=iFoAxwqCCj7/RE8dZekWmlOBfMFKGpwDKQrpuCx3pfw1eRtxIdu0XpuRGl5Vkm/11x
 WTKMN+Oj+2X0MDbmJ4cMpnGs08o+94Bvo6RteU3hydf70/h45AryrP0qhX/eEGtTc/s+
 weKzBgL5MNqwAANeHmQvsqlC9Ryp1RerdGWcg+ztA+fiipeOjbra27vrJpyMEU104jXI
 QqtO9cy6Us9t+PewFnDyPmmiTJhZ7tZhj6smwumcV0O0Uu/J8TObszWK/OZw6binM+Oo
 pkYyQiwbP2+8u9BWibxwaZkvupmfoKEPHsB/rKLuMjCp4a9UOs31ZymtegcsH3CVxAqF
 uUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u+geW7HzvpvuwmCodYfbhbpyQH/Dv/H3RYeFTEhDvMY=;
 fh=pWuasUF/FABhJnFqiOKQdPp2kd6PEUmoDOCDyjgNmJY=;
 b=hTRg1fMJPTiGo6hkFHtKUiBoIICBG7ZhOeI7hvTMGPFfSLZ/owoF0JzGABRvUJw9G6
 MJUTlQ1svPywfO8VwPBwe4QIFKluMC3ugApGmWvNh6rszVvCya8Bpdvw+eqvRH+y6XYy
 NmBwmMP8zOzd5FPr5WXGijynSEmoORrpXUS/hbV6N9ZzsH+KsU0X67SXyvXyPUJ9YyHw
 pDwkl0YjpFD5/kyw9WqFrGFaaac5TVTnsIShXrHt9OL91CWWxa1RPPCnRQxnRSkmS/XR
 oxTVxANVqWYj13U/SQGLWeSIeSUdl9PNAXBqAuqM7+r4iYeuuE4RzZn3gYLbC35YOFj0
 EdAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778234442; x=1778839242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+geW7HzvpvuwmCodYfbhbpyQH/Dv/H3RYeFTEhDvMY=;
 b=Y/xAe8b+4YDk4lAJroWvR4lqaly0y/nSSYHMAyjdOEGaJmbdJXAbTsWkgSuTsgzXuz
 TLKoaAI/4rOoEAMo7YZ/utvAPBV6s3MEdDd0aB2b/5JBY+R6/NE1RQSbo+5JrNBfpyAN
 a3lrHd4VCS9731z8hliDkHY0Af0xxEyZi95JKIbm3mBB3Zi2wotRIadl7qeSycwv5C1i
 12gNJjJYx5cQgdOPbmRFaT+SuQLP/bRXdT4iflGOBkTkYGWfSm7l4DySbVYHzPTBQq96
 pBxV0m6kesmZ4dYNghVzDM+BqFwxsZYp4DCF1nPuWPMm29qqJjZPFOwEGLropf3BKt4q
 gVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234442; x=1778839242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u+geW7HzvpvuwmCodYfbhbpyQH/Dv/H3RYeFTEhDvMY=;
 b=nRaZaM2k9OCt1qkeMNyPkzD4uGZPx1HaWwv60Ru9uVhnBd3QZPVobNLA26P2BHdNlI
 xGuLSSh5mbSSU0XYpnLipL5ExItDXJGPS1FiTzj7MPWcF5qCyAPI6MQ8cFUmjfzE5rb9
 fpNO2ZkzOlfznjDX999c7gsuqJFqsmvV2V8hqhiajRpQF31zIY1k5+Yhw9pIVYaYd8e3
 SHvFpQS8afewMUcDv5iNKZd+9O+Gd5lt6mgq612ij4mYTKrgFYVZEovl/Vm/BJjdzl9J
 ln0vF+AevusmUrA2x11fe6s5oVks0ce/Fkoyx0YlhqxGt35NuPP235aF3i+LVnyBJ5Hx
 SMWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Bm7p417V95LQ0eL4PUGtBVDnqaxiJ4jycPn6coOtv1sTryQnC9bQCqTgoOCjJzJDyKgkAR07pwJ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya9q1uOsUnxlMrnAovhAMJBG55Iz5djYoEsCpuYX9loWy9wfY7
 PDHO7bMTTCG/JWN+ghsIwAtlDZK+r+UyAj0dDNF6N/xOVZWwWiYzfW/ovzwIO+pTbS3aaiNEAg7
 fsQCj6EzpwQk4NtJJpZv+ZE83fWGCqk4=
X-Gm-Gg: Acq92OF+52d9QxhArdv/nsBlBsRoerhb03KVWoB19H/bMeEj3Ig52IeqmEBB1PuaYco
 LMHRB+c94oO88kEXze2YzVWIN6by3MWbHB8NaiSMc4AoEBejw/SBbA8sfkYf/XKuDmXz9ZTThx+
 1FohQnroLLyfl5XkqvC86m3co147kmcCTd/b2XdFm1WvpsRpklgvsTDdbykxHzQDzRLj38bNFXC
 3+7+92AZ97Yek69p+nLVtdH/Gj7P6lNSn45BZs3lsKFMRsWE+h2iOsVVM5EAsLCZBKch05KL2Fl
 7bA7g0HlxG6AWoyxYZ+N8LbcNw8aYVD80+H8oaNi9zO2OVKtqQmSvzkXP3HgECsb+oeN+sXW9qf
 K/oJd
X-Received: by 2002:a5d:5f90:0:b0:448:7049:a6c9 with SMTP id
 ffacd0b85a97d-4515b056c3emr18956040f8f.5.1778234441801; Fri, 08 May 2026
 03:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506201400.GC1652535@killaraus.ideasonboard.com>
In-Reply-To: <20260506201400.GC1652535@killaraus.ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 8 May 2026 11:00:15 +0100
X-Gm-Features: AVHnY4LP8csuKz7LBRlHomSywlqEiEgGQCH4EJ0easAGNDrVsix2yt5Y_eKl99w
Message-ID: <CA+V-a8u_74SmeAKAXUqSKyWvp41pJavd_b_ESUOozCnrifBEpA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm: renesas: rz-du: Move mode_valid logic to per-SoC
 clock limits
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Laurent,

Thank you for the review.

On Wed, May 6, 2026 at 9:14=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Apr 29, 2026 at 06:00:11PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Move pixel clock validation from a fixed encoder check to per SoC
> > constraints stored in rzg2l_du_device_info.
> >
> > Pixel clock limits differ across SoCs in the RZ DU family and cannot be
> > expressed by a single shared rule. For example, RZ/G2UL (R9A07G043U)
> > limits the DPAD0 pixel clock to 83.5 MHz, while other SoCs such as
> > RZ/T2H require a wider operating range.
> >
> > Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to
> > describe the supported pixel clock range for each SoC. Update
> > rzg2l_du_encoder_mode_valid() to return MODE_CLOCK_LOW when the pixel
> > clock falls below mode_clock_min and MODE_CLOCK_HIGH when it exceeds
> > mode_clock_max.
> >
> > Set the pixel clock limits for RZ/G2UL(R9A07G043U) to 20.875MHz minimum
> > and 83.5MHz maximum.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 2 ++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h | 2 ++
> >  4 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu=
/drm/renesas/rz-du/rzg2l_du_drv.c
> > index 0fef33a5a089..3b7162c6e1f4 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -35,6 +35,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a=
07g043u_info =3D {
> >                       .port =3D 0,
> >               },
> >       },
> > +     .mode_clock_min =3D 20875,
> > +     .mode_clock_max =3D 83500,
> >  };
> >
> >  static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info =3D {
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu=
/drm/renesas/rz-du/rzg2l_du_drv.h
> > index 58806c2a8f2b..885558eb9547 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -44,10 +44,14 @@ struct rzg2l_du_output_routing {
> >   * struct rzg2l_du_device_info - DU model-specific information
> >   * @channels_mask: bit mask of available DU channels
> >   * @routes: array of CRTC to output routes, indexed by output (RZG2L_D=
U_OUTPUT_*)
> > + * @mode_clock_min: minimum pixel clock in kHz
> > + * @mode_clock_max: maximum pixel clock in kHz
> >   */
> >  struct rzg2l_du_device_info {
> >       unsigned int channels_mask;
> >       struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
> > +     u32 mode_clock_min;
> > +     u32 mode_clock_max;
> >  };
> >
> >  #define RZG2L_DU_MAX_CRTCS           1
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers=
/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > index d53068733c66..ad02efec1c23 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > @@ -50,8 +50,11 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *enco=
der,
> >                           const struct drm_display_mode *mode)
> >  {
> >       struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> > +     const struct rzg2l_du_device_info *info =3D renc->info;
>
> You could use
>
>         struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->base.de=
v);
>         const struct rzg2l_du_device_info *info =3D rcdu->info;
>
> and avoid the info pointer in struct rzg2l_du_encoder. Up to you.
>
Agreed, I will drop the info pointer for now.

> >
> > -     if (renc->output =3D=3D RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83=
500)
> > +     if (info->mode_clock_min && mode->clock < info->mode_clock_min)
> > +             return MODE_CLOCK_LOW;
> > +     if (info->mode_clock_max && mode->clock > info->mode_clock_max)
> >               return MODE_CLOCK_HIGH;
>
> The new check now applies to all outputs, not just the DPAD0 output. Is
> that intentional ?
>
The RZ/G2UL SoC only supports DPAD0 so the check is redundant.

> >
> >       return MODE_OK;
> > @@ -107,6 +110,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *=
rcdu,
> >       if (IS_ERR(renc))
> >               return PTR_ERR(renc);
> >
> > +     renc->info =3D rcdu->info;
> >       renc->output =3D output;
> >       drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_func=
s);
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers=
/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > index 3e430c1f6132..39a1d178b856 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > @@ -14,10 +14,12 @@
> >  #include <linux/container_of.h>
> >
> >  struct rzg2l_du_device;
> > +struct rzg2l_du_device_info;
> >
> >  struct rzg2l_du_encoder {
> >       struct drm_encoder base;
> >       enum rzg2l_du_output output;
> > +     const struct rzg2l_du_device_info *info;
>
> If you want to keep a pointer here to avoid going through
> to_rzg2l_du_device(), I would store a backpointer to rzg2l_du_device
> instead of just an info pointer, it could come handy in other places.
>
As agreed above I will drop this pointer for now.

Cheers,
Prabhakar
