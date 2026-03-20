Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC195108B90B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592E310EACC;
	Fri, 20 Mar 2026 12:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DvZDL2Wd";
	dkim-atps=neutral
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C84510EACC
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:08:14 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-950d235b500so457108241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 05:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774008493; cv=none;
 d=google.com; s=arc-20240605;
 b=edTuASSQojNN6e9Zy1UdyLs4D6RqkYW/dgC3SNvRbzLCt3IqjsbtZXh+gPOTvE1eKR
 0G+NYcB7vweZPH6ELZeTU2ZcDM0LK+fq1plKQNeRqc7b+Y/4G2Fg3u8IlaAaHLmI00Wx
 Dt6PpAJH6vrmIvEWOM1m2BqWgsdEtX0PHTFzy555g1wLK/n30arafXSvpQnV+m9qhlKO
 sStq1ghopWfbd7F/UhMQyVhK3z7lshX/bYJKd0ffv9M4feFEHuYqc+jFkDGNCWeQ+GVK
 NuhFbO0ohgR4SvHDprhnyNJ67ygZ4TA7sYFrZ8AhyIwPHUodsPo+DrSryvvJ0K823IJr
 FJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Qpko9v6Uv9SOlICvwfaBdGeXRMXz2LcJLxIYJaIJnHg=;
 fh=4gRag+zCHPGYEiDAOeORl1ENMsqg5a87NmUr9gBhL6Q=;
 b=k+pEHINvTCvvrvbN2Qme69VFRuwETSlLRwf8H84C3WuV2l/TZQWip1mK+3kWQPxdhA
 m1gRgZ1FFaRnzKf+VDJJZGmDMEW3mkSwdSspszLyXSb5zORO7Iuvq4ITG8U3lIx6Z2kl
 BydH6yCKzUKk1zbNHMdyz50LnjSjKpXXrq2++oMn7qDOY588rXWR7uDfTjZegwDXafHV
 eJdoVa12zZH4GYK6aG//4Wqd2ooNqjt2LuhSs2YGLxwVtlEGx/ZqwLaUcTASabxH5VOy
 5sEaM8/4rDaVOSq7idXhA9qPVTAQNsDv9Fqg0MlrufZOGO5OwVJ2M9qKVXtEjU3JG5mc
 SEWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774008493; x=1774613293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qpko9v6Uv9SOlICvwfaBdGeXRMXz2LcJLxIYJaIJnHg=;
 b=DvZDL2Wd8w50YgR02ouvn9aidu7X3PwG1ygVE5AYrm6q3UNZ7T7ua+07FTJCEkm9RT
 aBMtsgREnUyDdCf2WlC/2OHmmYzYyNbeb+i9W263AtfV6aIO99m4iDpU0Hw6oIoJ+zti
 4GXWG8RA4SQ9u2Kr9uBp0wabU21Kgfi7k/2kEyuZO7IG5AHPUeRzw6dDVWSmmKHK02vb
 wLr/9xKqCeV1zvuqYTNWVnRen6avnTRYqqUi/7uu8m1kBcl2DBBEVlkQU2WvUTvS5RQg
 ntaIf1Y27cj+RYgxgDlQu+SHBMTAcAE0yUyDTSOO+XfNgL49G4j7WpIZt11vkpBJqmAH
 jxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774008493; x=1774613293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpko9v6Uv9SOlICvwfaBdGeXRMXz2LcJLxIYJaIJnHg=;
 b=PR8N9gbUfvuAAWg3p6+9Q1bmaI6wcxa3ta/x3X7kFVEHgo9AYSf5G+BiHxy5jSthyu
 q9xJ3gfZ1IVCay9YWg8psxMw/6Z4Mc5sUwtxGQhwIiHU7zPixgAAOFBYIPwQ00XI9M9v
 qoOR3ZUU2Axbwm22/+vrZB/RJ+12RVOHj+ub+ZLkMnO6D5galN1wEzX9mvE97Usb5DQH
 zkbtwpBJ40fGkG6muJxUJ1Mv6Tfv7//tMDpUZOsVedvAHyLEgjpeMFjxmqJt1RVaumUX
 Do7KB6/A75PBQSAobLU7WvYxJTVcsIL0VeQO2w00paQf5p+2TbGre6Fg6+uuUjDxT9IO
 +qjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH+WGWqJwfEjigUtsizK+QnDiWZawlFsl+501J0zLjzNgfgYVCKOHT+ZIwBC9euXO4E2IxRL39blE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2WB8D0+EHNGjmh9wyW+CWO/luOUM7TYh2bserLI/0a4V9IUkq
 OCxYHzl6kOO7SEe6f4MSOCMgwadXDB7ubLwQJpSpRhG8H1pWxoWfJOQebl60WOhhf1/vflhkNuT
 JqAUi3pw7tBPmrcXzfr2lfxHsHkBJZQM=
X-Gm-Gg: ATEYQzw57Yhk/aGjiFKxDp8vycgqnRPhyn7Leg9kBHi4H9L082QfdvPqiDzmglLsoQq
 Bln0XZAYr9Um1bEx2R20utQ8QxUieTLN3HFteVJJh7UHil6WKb0FOTqBHaSbzjx+44urtWFSdLi
 aFK2m2L0V/6VUnW7krtiJqPXlcSAYqtu5y2O4iKjsjsAA6JGe1tKPqMtbwtX0hO722HjFMHp6Aa
 SxjSBAq0Rzbf4LssqRIZDCwMvrOm5IwP/gAI3YyoUp8d8Qr3PN3nT7AmL6OA1o4psLCagUUPCri
 wM5WFbpC
X-Received: by 2002:a05:6102:4a81:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-602aed27230mr1195716137.28.1774008492934; Fri, 20 Mar 2026
 05:08:12 -0700 (PDT)
MIME-Version: 1.0
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 20 Mar 2026 20:07:46 +0800
X-Gm-Features: AaiRm53IYd5mxSjYs0gkBExJVtx1S6K0r6ROFO9ciiV3q521x0whe0nuV42GAAs
Message-ID: <CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: akoskovich@pm.me
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, jeffrey.l.hugo@gmail.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Marek <jonathan@marek.ca>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>
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

On Fri, Mar 20, 2026 at 4:17=E2=80=AFPM Alexander Koskovich <akoskovich@pm.=
me> wrote:
> >
> > On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <dmitry.barysh=
kov@oss.qualcomm.com> wrote:
> >
> > > On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Koskovich wrote:
> > > > On Friday, March 20th, 2026 at 2:50 AM, Alexander Koskovich <akosko=
vich@pm.me> wrote:
> > > >
> > > > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov <dmitry.=
baryshkov@oss.qualcomm.com> wrote:
> > > > >
> > > > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Koskovich w=
rote:
> > > > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek <jona=
than@marek.ca> wrote:
> > > > > > >
> > > > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek =
wrote:
> > > > > > > > ...
> > > > > > > > >>
> > > > > > > > >> That's not how it works. INTF (which feeds DSI) is after=
 DSC compression.
> > > > > > > > >>
> > > > > > > > >> INTF timings are always in RGB888 (24-bit) units. Ignori=
ng widebus details,
> > > > > > > > >> the INTF timing should match what is programmed on the D=
SI side (hdisplay,
> > > > > > > > >> which is calculated as bytes per line / 3).
> > > > > > > > >>
> > > > > > > > >> (fwiw, the current "timing->width =3D ..." calculation h=
ere blames to me, but
> > > > > > > > >> what I wrote originally was just "timing->width =3D timi=
ng->width / 3" with a
> > > > > > > > >> comment about being incomplete.)
> > > > > > > > >>
> > > > > > > > > Okay. After reading the docs (sorry, it took a while).
> > > > > > > > >
> > > > > > > > > - When widebus is not enabled, the transfer is always 24 =
bit of
> > > > > > > > >    compressed data. Thus if it is not in play, pclk and t=
iming->width
> > > > > > > > >    should be scaled by source_pixel_depth / compression_r=
atio / 24. In
> > > > > > > > >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'=
.
> > > > > > > > >
> > > > > > > > >    For RGB101010 / 8bpp DSC this should result in the PCL=
K being lowered
> > > > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > > > >
> > > > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the tran=
sfer takes
> > > > > > > > >    more than 24 bits. In this case the PCLK and timing->w=
idth should be
> > > > > > > > >    scaled exactly by the DSC compression ratio, which is
> > > > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_compone=
nt).
> > > > > > > > >
> > > > > > > > > So, this piece of code needs to be adjusted to check for =
the widebus
> > > > > > > > > being enabled or not.
> > > > > > > > >
> > > > > > > >
> > > > > > > > The widebus adjustment on the MDP/INTF side is already in
> > > > > > > > dpu_hw_intf_setup_timing_engine: the "data width" is divide=
d by 2 for
> > > > > > > > 48-bit widebus instead of 24-bit. there shouldn't be any ot=
her
> > > > > > > > adjustment (downstream doesn't have any other adjustment).
> > > > > > > >
> > > > > > > > a relevant downstream comment: "In DATABUS-WIDEN mode, MDP =
always sends
> > > > > > > > out 48-bit compressed data per pclk and on average, DSI con=
sumes an
> > > > > > > > amount of compressed data equivalent to the uncompressed pi=
xel depth per
> > > > > > > > pclk."
> > > > > > > >
> > > > > > > > Based on that comment, this patch is correct, and the
> > > > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)'=
 adjustment
> > > > > > > > only applies to DSI.
> > > > > > >
> > > > > > > If I keep the INTF side at /24 and change the DSI side to:
> > > > > > >
> > > > > > > if (wide_bus)
> > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_ds=
c_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > > > else
> > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_ds=
c_get_bpp_int(dsc), 24);
> > > > > >
> > > > > > Please check the actual fps (I'm usually using a vblank-synced =
GL, e.g.
> > > > > > kmscube).
> > > > > >
> > > > > > At least this matches my expectations.
> > > > >
> > > > > Hmmm with kmscube I am getting 120FPS with 24 and 100FPS with 30.=
 So I guess that's a no go
> > > >
> > > > Although it was using dsc->bits_per_component * 3 regardless before=
 for
> > > > dsi_adjust_pclk_for_compression so I guess that's what Jonathan was
> > > > referring to earlier...
> > >
> > > Do you have any of the patches by Marijn or Pengyu?
> > >
> > > - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-regresses-ag=
ain-v1-1-6a422141eeea@somainline.org/
> > >
> > > - https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitlt=
latltl@gmail.com/
> >
> > Nope, I can test with them though if you'd like
>
> Tested the following 3 patches on top of this series:
> drm/msm/dsi: fix hdisplay calculation when programming dsi registers
> drm/msm/dsi: fix bits_per_pclk
> drm/msm/dsi: fix hdisplay calculation for CMD mode panel
>
> Getting constant FIFO errors with them applied:
> [   64.851635] dsi_err_worker: status=3D4
> [   64.851692] dsi_err_worker: status=3D4
> [   64.851730] dsi_err_worker: status=3D4
> [   64.851766] dsi_err_worker: status=3D4
> [   64.851802] dsi_err_worker: status=3D4
> [   64.851837] dsi_err_worker: status=3D4
> [   64.851903] dsi_err_worker: status=3D4
> [   64.851940] dsi_err_worker: status=3D4
> [   64.851976] dsi_err_worker: status=3D4
> [   64.852011] dsi_err_worker: status=3D4

Personally, I use
timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_int(dsc),
                         dsc->bits_per_component * 3);

DIV_ROUND_UP is magic for me. If not, I got status=3D4 too.

This works for 8-bit dst bpc with 10-bit src bpc.

Best wishes,
Pengyu
