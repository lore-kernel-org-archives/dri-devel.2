Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC2E1088E60
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA5F10E9EC;
	Thu, 19 Mar 2026 17:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="SCItzt50";
	dkim-atps=neutral
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270D610E96A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773941497; x=1774200697;
 bh=RvMMo0NAF7orTfavYi+xzo3XwN7ul4xPql6mf0zDMBA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SCItzt50M2hsKF/KJzBDcKLrd0PwQGDXRmDFMfBDKyI4i1Lfy5rbsLjFwOqwFy1Ex
 mQHItr7Es0hTUT1ldkm2xCAqm4Wg0BLCqOFatWhMJOV14lI3sbuL9OlERV+PZXDo0G
 yVeAwfKyCJ+w3H25/kFFiNuRv+VfjPIJq5rmMurL0KK1tf++1DgnXlBTf7mZdAtZ/V
 LDtbuF/9Or7N8UVNRI0fWbw9rs5JMD35CsGC+RVxcr0lSaI7i1/u4sEIGKKwcgXNFd
 ccAz4/geTCqgXjvX4/l+5HN8dAOq9fX9SvRXk6q6sGnAYPTlsG7ewW2OIz9WIdsDRf
 ydJAdw4VMoOWQ==
Date: Thu, 19 Mar 2026 17:31:35 +0000
To: Jonathan Marek <jonathan@marek.ca>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
Message-ID: <EEQIOfQNcsc4wya1P0uxlYBG4w9lAeW4OcTZpsxmpGCzf-tgl_3YO0H5zoZyU5XIwBKurxuki_gGca-Z9YfcdYOXN_wpwixoK8q_fITL1bw=@pm.me>
In-Reply-To: <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: d2b1ed9fad43303dd5f9f8c1a38a2936ff8bc4ec
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

On Thursday, March 19th, 2026 at 1:23 PM, Jonathan Marek <jonathan@marek.ca=
> wrote:

> On 3/19/26 10:54 AM, Neil Armstrong wrote:
> > On 3/19/26 15:40, Alexander Koskovich wrote:
> >> On Thursday, March 19th, 2026 at 10:13 AM, Neil Armstrong
> >> <neil.armstrong@linaro.org> wrote:
> >>
> >>> Hi,
> >>>
> >>> On 3/19/26 12:58, Alexander Koskovich wrote:
> >>>> Using bits_per_component * 3 as the divisor for the compressed INTF
> >>>> timing width produces constant FIFO errors for the BOE BF068MWM-TD0
> >>>> panel due to bits_per_component being 10 which results in a divisor
> >>>> of 30 instead of 24.
> >>>>
> >>>> Regardless of the compression ratio and pixel depth, 24 bits of
> >>>> compressed data are transferred per pclk, so the divisor should
> >>>> always be 24.
> >>>
> >>> Not true with widebus, specify why 24 and because DSI widebus is not
> >>> implemented yet.
> >>>
>=20
> DSI widebus is implemented, and always used when available. The
> adjustment for DSI widebus just doesn't happen in this function.
>=20
> >>>>
> >>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++----=
-
> >>>>    1 file changed, 4 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>> index 0ba777bda253..5419ef0be137 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>>> @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
> >>>>        }
> >>>>
> >>>>        /*
> >>>> -     * for DSI, if compression is enabled, then divide the
> >>>> horizonal active
> >>>> -     * timing parameters by compression ratio. bits of 3
> >>>> components(R/G/B)
> >>>> -     * is compressed into bits of 1 pixel.
> >>>> +     * For DSI, if DSC is enabled, 24 bits of compressed data are
> >>>> +     * transferred per pclk regardless of the source pixel depth.
> >>>>         */
> >>>>        if (phys_enc->hw_intf->cap->type !=3D INTF_DP &&
> >>>> timing->compression_en) {
> >>>>            struct drm_dsc_config *dsc =3D
> >>>>                   dpu_encoder_get_dsc_config(phys_enc->parent);
> >>>> +
> >>> Drop this change
> >>>
> >>>>            /*
> >>>>             * TODO: replace drm_dsc_get_bpp_int with logic to handle
> >>>>             * fractional part if there is fraction
> >>>>             */
> >>>> -        timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) =
/
> >>>> -                (dsc->bits_per_component * 3);
> >>>> +        timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) =
/ 24;
> >>>
> >>> It would be helpful to somehow show that 24 is 8 * 3, 8 being the
> >>> byte width and 3 the compression ratio.
> >>
> >> Can you clarify what the 3 represents? My panel should have a 3.75:1
> >> compression
> >> ratio (30/8) so the final divisor of 24 would be wrong for my panel if
> >> its the
> >> compression ratio?
> >
> > So my guess is that while the exact ratio on the DSI lanes is 3.75:1,
> > the ratio
> > used to calculate the INTF timings is 3, then the DSC encoder probably
> > does the
> > magic to feed 10bpp into a 3.75:1 ratio over the DSI lanes.
> >
>=20
> That's not how it works. INTF (which feeds DSI) is after DSC compression.
>=20
> INTF timings are always in RGB888 (24-bit) units. Ignoring widebus
> details, the INTF timing should match what is programmed on the DSI side
> (hdisplay, which is calculated as bytes per line / 3).
>=20
> (fwiw, the current "timing->width =3D ..." calculation here blames to me,
> but what I wrote originally was just "timing->width =3D timing->width / 3=
"
> with a comment about being incomplete.)
>=20
> > In dsi_adjust_pclk_for_compression, the pclk is adjusted to take in
> > account bits_per_component,
> > so I presume the actual DSI pclk _is_  timing->width *
> > drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3),
> > which is your 3.75:1, but the INTF needs to generate timing->width *
> > drm_dsc_get_bpp_int(dsc) / (8 * 3) pixels
> > to the DSC encoder which will emit timing->width *
> > drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3) pixels.
> >
>=20
> The hdisplay calculation in dsi_adjust_pclk_for_compression (which only
> affects the clock rate) seems to be wrong, and I think Alexander's panel
> must be running at a 20% lower clock because of it. dsi_timing_setup has
> the right hdisplay adjustment.

Checked against downstream and the clocks seem to match more or less:

downstream:
pclk: 110070156
byte: 103190771

upstream:
pclk: 110073457
byte: 103193865


>=20
> > In any case, 24 _is_ 3 * 8, 3 being the DSC compression ratio on the
> > INTF side.
> >
> > Dmitry, Konrad, could you help confirming this ?
> >
> > Neil
> >
> >>
> >>>
> >>>>            timing->xres =3D timing->width;
> >>>>        }
> >>>>    }
> >>>>
> >>>
> >>>
> >>>
> >>
> >> Thanks,
> >> Alex
> >
> 
