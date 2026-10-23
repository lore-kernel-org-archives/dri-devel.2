Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92679606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gl6Vfoy5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC5A112CD5;
	Fri, 23 Oct 2026 18:17:29 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76FC10E083
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:39:33 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-5363c8de563so10864301cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792777173; cv=none;
 d=google.com; s=arc-20260327;
 b=UsVlxNkzpy0N/OmlVT6Uz77V2yWnomFlDcogVeFYgBHu8rkPsoRw+SSDMzTq0tlRuO
 krOVJOUrr0cKDYYs8g0pNHHw18OmFY4nd7RvBjHhYAcM8mOl+8dGiwPILO3o7v2M1qNH
 El8+HSsgMeo3p21s9BCV7JjXLGDbyU0oQjgDiwL81A2GUWDHFcdl5QR05Qne/xrRiKFX
 8c4a6Ym1hrzaWvnl2FA/w33AzTTaoManl6zNkTJnHdEPOJIxLpxHOEpkmzx2Dal2tQ2b
 ePzAehmm6iKknL5T48D3RUxLtciHptmjZE6mh7guTPPQPG5RYNYDJO/aB33WC5CsnrI0
 Es/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cc3FE1z378wB4L+jt9EKV2qXjcL3kdL6ypL5aBm/j2I=;
 fh=GKgXtktyn2+YYLkr/RYQIMDymVZQObBNb8FeJcTVE3M=;
 b=rtDV2b30qv0UZKYX6/ihQNjAnD2qpxMMhZoybh46XQUTH8rD7gFufPjX2a8g5L/FQ7
 bQDRdsLhzEY1tFB6Po2oVMq6dIrCXWW25FcD0n3CiazBpZyMXaPUsoXYO8LWv5mN41BO
 nNIGJ2zbKsNs5AS4QUJnAgJtt79q8w8jkHn//SGH2bR+sxAAjAQpu/yFTTPYcjYJBko3
 WWGr6for9cP7JueMkwCnNVUXcnop3vi7Z5U7IJZ2jBrQvQI2Jol6DztgxH3W3qEO2Kaz
 gljAFAYGcVyS5EKl5T3EQHV3R+azIpL0oM2t+zd8NdnoqJ4da5cdyuoVs8uDYt48tjVa
 f22A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792777173; x=1793381973; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cc3FE1z378wB4L+jt9EKV2qXjcL3kdL6ypL5aBm/j2I=;
 b=Gl6Vfoy50CjvnqKHKZdV4lISucSxhr+nbtED9RoSFUnH137yL0tucXpV+txWHFec59
 VN3ZIN4WXdkajzAsEs9R5OSt6pP1HTiYiTwg+tcE1XiMBWiwYrXDKKl7MnPrIKmReT91
 NfNku+ReqrHYR5Y+Hojtn8OHfQbxzSMFG5KOQjoTBD09arW49P+P/dD10C5r9vDqqqAV
 tSsVzg92dbtYh6dtN/FMBl5LZ0Jtuh2B6RK96pQLNEOeXNwfGl50u5dbwrgcScLjWX3X
 r7ftsrkKMgy15UY94tCYpKYVndO6n5wKOTt5ZjGGe0ao3h552hvSFaUYJCpo0xtv7vwd
 zkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777173; x=1793381973;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cc3FE1z378wB4L+jt9EKV2qXjcL3kdL6ypL5aBm/j2I=;
 b=QAfCRZ/kvdOmkpP7mit5ZemvU9gKBoQ9CCR0Df2tbDRc/UyJY+zhyFsnLWjUVYINPp
 e/UfVODtlZ44McvrjbDyUqjLrE05y1uXecPbeSJcr6hwP9d6ent8wEI/2vEg61o297UQ
 rq5qMQ6XmFeXmT0A4mFJBu6baQ8aMKT2W/ySU6Pf0S/Wykf9A6snCnhwPkqzBAZJt+Jg
 gtwCeqfX8+P3bv6ZuHafuiFrHly8gnU+Y5LZ0JGHjV/kr4V7afGllDsvmvpgKCq30yIG
 rLzglzofafnmM3FkrdEA7hJogU3ScC6aMZZjiygLx0PyVqVK5HQWrkqlP0wWit/YTa6v
 69PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPa/OpKBsi19Te4ndqjnVORJTEBwxqCs1wH/T6hivptTB66DHN4GOxACNhSoDxyAQlD7/P81r3s5o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLM4yTCQtd2q1dzQIRYXyfgvE/E9vc4BospW1EtNaG/mW5BJqxB
 pZzwoy8tXzrPFprPhaX38SVGPIEH1UyDfTLqaSPMuIh0Nj8kjAn1Dm8M7FQ+RQX0BrcYajGD2DS
 rSk6Al2SVfJFK/M3G1kEziDacIu8HDJ8=
X-Gm-Gg: AYBFou11ISb+g3P2egUbLMyof/+DvwAn1S7obinlLq6eARTUwjSHsXjJUXBXs/Gs0wy
 oerqZSYPiu5HQ9esyfkTXUH/2CFy/9UVWo+jWVVv7cND149mv978lKdic8loD0lifL14BtgJKXo
 xnpBZnKo1i/+FEnfMKmogWDwRDwkPeyhkBq1NXCaavKXUl+sfC6JMesIIybz8T9oViWL3YU7OeE
 x7NvxUOitKuC6265fXdvFH9+zXZrA8powG3jKqfsShBM9yNVD8w8gCmedkxdL96WnvpAfbUM/T4
 e5JQ7NeMCEkl1A8Qu1MVD0lYZ/pVh3iSsjQBNaVyaAIK+30upoMxkXxenGbIXIFj0EqbyycUpK0
 Vy/zPzk5vDWPwRKymsHHk3p/6jNm8Jy6zN0mqCWPHaJ+e7Jy6yt+FMbkNs1jTxk2fRNpW6e8+43
 k0klbj/N36f4ICPu/dNrVXRmXEQp+DScAQWv5LkE6DvE/B/Artm60=
X-Received: by 2002:a05:622a:591a:b0:536:8ff4:2c2b with SMTP id
 d75a77b69052e-536c28dcf22mr40802351cf.57.1792777172585; Fri, 23 Oct 2026
 10:39:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260920013050.21259-1-djanice1980@gmail.com>
 <CHXPR12MB999220096CBA8DA25F23E138A0E5642@CHXPR12MB999220.namprd12.prod.outlook.com>
 <CHXPR12MB99922053033BBEAB715EB8F8DBE5642@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB99922053033BBEAB715EB8F8DBE5642@CHXPR12MB999220.namprd12.prod.outlook.com>
From: David Janice <djanice1980@gmail.com>
Date: Fri, 23 Oct 2026 12:39:20 -0500
X-Gm-Features: AclHuK94EIzIr25iMyVeixtjOOKr1_lElRYZMHi-Wt1CK_XfxcPhyKQPzwzAH9c
Message-ID: <CAEUr4BdiYg8ZEBDdg3rSr0uyMEFX1SG76MQk8s1GEgULkkEe5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training
 at every rate
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000889295065e8576cc"
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000889295065e8576cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

Thanks for the titles. Before dropping my patch I tested both changes on
my hardware:

  "drm/amd/display: Fix HDMI2.2 LT timeout duration"
  "drm/amd/display: Adjust HDMI FRL LT timeout"

Setup: ASUS ROG Flow Z13 (GZ302EA, Strix Halo, DCN 3.5), LG C2 OLED
(firmware 43.21.74), certified Ultra High Speed HDMI cable, 4K120 10-bit
RGB =3D FRL 10 Gbps x4. Kernel 7.3 (CachyOS 7.3.0-4). I applied the first
change and the 220 ms line from the second (d6751306 in
amd-staging-drm-next) to link_hdmi_frl.c, and left out the FLT_no_timeout
compliance rework in between, since a TV never sets that bit.

Test: 20 mode switches 4K60 -> 4K120 with drm.debug=3D0x2, time measured
from "Poll for FLT_UPDATE" to PASSED/FAILED.

  220 ms (your changes):  28 trainings, 4 timed out at 221 ms
                          ("Timeout waiting for FLT_UPDATE"). Each one
                          passed on the driver's retry ~0.4 s later.
  ~300 ms (my patch):     29 trainings, 0 timeouts. Loop time 196-244 ms,
                          median 208 ms, 9 of 29 over 220 ms.

Over about 270 earlier trainings with this TV the longest was 257 ms. So
220 ms works, but with this sink it costs a retry on roughly one link-up
in three to seven. Would you consider 300 ms for every rate, the same as
for >=3D 16G? I'm happy to test any patch.

Separately, a regression I hit in 7.3 that is unrelated to the timeout:

fill_stream_properties_from_drm_display_mode() in amdgpu_dm_connector.c
now does

    if (is_hdmi_ep)
            adjust_colour_depth_from_display_info(timing_out, info);

which clamps FRL streams to the sink's max_tmds_clock. v7.2 only did this
for SIGNAL_TYPE_HDMI_TYPE_A. On the C2 (600 MHz max TMDS), 4K60 10-bit
needs 742.5 MHz, so it is lowered to 8-bit, update_stream_signal() then
moves the stream to TMDS, and the TV loses HDR at 4K60. On 7.2 the same
mode trained FRL at 6G x4, 10-bit. 4K120 is unaffected only because no
depth fits under 600 MHz, so the clamp gives up.

Locally I changed the condition to

    if (is_hdmi_ep && stream->signal !=3D SIGNAL_TYPE_HDMI_FRL)

At that point stream->signal is still the sink's signal, and
update_stream_signal() runs again after the fill. With this, 4K60 is back
to FRL 6G x4, 10-bit, with HDR. dc_validate_stream() still checks the FRL
bandwidth, and the caller falls back to the next depth if it doesn't fit.
I can send this as a proper patch if that helps.

On Fri, Oct 23, 2026 at 11:59=E2=80=AFAM Zuo, Jerry <Jerry.Zuo@amd.com> wro=
te:

> AMD General
>
> > -----Original Message-----
> > From: Zuo, Jerry
> > Sent: Friday, October 23, 2026 11:50
> > To: 'David Janice' <djanice1980@gmail.com>;
> amd-gfx@lists.freedesktop.org
> > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; dri-devel@lists.freedesktop.org
> > Subject: RE: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link
> > training at every rate
> >
> > Your change already being considered in below two changes. Please kindl=
y
> > check below two changes:
> > "drm/amd/display: Fix HDMI2.2 LT timeout duration"
> > "drm/amd/display: Adjust HDMI FRL LT timeout"
>
> Just add commit title for your reference.
>
> Regards,
> Jerry
> >
> > Regards,
> > Jerry
> >
> > > -----Original Message-----
> > > From: David Janice <djanice1980@gmail.com>
> > > Sent: Saturday, September 19, 2026 21:31
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher=
,
> > > Alexander <Alexander.Deucher@amd.com>; Zuo, Jerry
> > <Jerry.Zuo@amd.com>;
> > > dri-devel@lists.freedesktop.org; David Janice <djanice1980@gmail.com>
> > > Subject: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link
> > > training at every rate
> > >
> > > [You don't often get email from djanice1980@gmail.com. Learn why this
> > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > hdmi_frl_perform_link_training() gives LTS:3 a single budget of 105
> > > polls at 2 ms (~210 ms) that starts at the FRL_Rate write and is not
> > > restarted when the sink raises its first FLT_update with the LTP
> > > request. A sink that needs close to
> > > 200 ms after the LTP request to report lock therefore fails whenever
> > > its LTP request itself takes more than a few tens of ms.
> > >
> > > Measured on an LG C2 (GSM 49352, 2022) driven by a Strix Halo DP-HDMI
> > > FRL PCON, DPMS off/on with drm.debug=3D0x2, kernel 7.2.6:
> > >
> > >   6G x4  (3840x2160@60 10bpc):  LTP request at poll 11 (~21 ms),
> > >          lock at poll 100 (~179 ms later): PASSED first try.
> > >   10G x4 (3840x2160@120 10bpc): LTP request at poll 22 (~44 ms),
> > >          no lock by poll 105: "FAILED - Timeout waiting for
> FLT_UPDATE".
> > >          Retry 200 ms later: LTP request at poll 11, lock at poll 101=
:
> > >          PASSED.
> > >
> > > The sink answers FLT_READY on the first poll every time and locks in =
a
> > > steady
> > > ~180 ms at both rates, so it is neither slow to wake nor marginal; th=
e
> > > total just does not fit 210 ms once the LTP request is late, which
> > > happens far more often at 10G. On this system that is the difference
> > > between reliable DPMS wakes at
> > > 4K60 and mostly dark ones at
> > > 4K120: hdmi_frl_perform_link_training_with_retries() retrains at the
> > > same rate up to four times 200 ms apart and the output is then left
> dark.
> > >
> > > "drm/amd/display: Update and revert FRL LT Timeout behaviour" already
> > > allows 155 polls (~300 ms) for 16 Gbps and above. Use that budget at
> > > every rate. With the change applied to 7.2.6, five consecutive DPMS
> > > wakes at 10G
> > > x4 trained on the first attempt; three of them locked at poll 104-105=
,
> i.e.
> > > inside the last 1-2 polls of the old budget.
> > >
> > > Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > > Signed-off-by: David Janice <djanice1980@gmail.com>
> > > ---
> > >  .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 14
> > > +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > > b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > > index 7f93009..005feb9 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> > > @@ -528,10 +528,18 @@ static enum link_result
> > > hdmi_frl_perform_link_training(struct ddc_service *ddc_s
> > >
> > >                 FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n"=
);
> > >                 /*LTS:3: Start Link Training*/
> > > -               /*Start FLT Timer =3D 200 ms, or 300ms if link rate >=
=3D
> 16Gbps*/
> > > +               /*
> > > +                * Start FLT Timer =3D 300 ms. HDMI 2.1 specifies
> > > + FLT_TIMEOUT =3D 200
> > > ms,
> > > +                * but this budget runs from the FRL_Rate write to th=
e
> final
> > > +                * FLT_update and some sinks need more than that in
> total: an LG
> > C2
> > > +                * (2022) at 10G x4 raises its first FLT_update (the
> LTP request)
> > > +                * ~45 ms after the rate write and reports lock a
> further ~180 ms
> > > +                * later, ~225 ms in all, so it failed the 105-poll
> (~210 ms) budget on
> > > +                * most DPMS wakes at 4K120 while at 6G x4 (~20 ms +
> > > + ~180 ms) it
> > > just
> > > +                * fit. Use the 300 ms already allowed for >=3D 16 Gb=
ps
> at every rate.
> > > +                */
> > >                 num_polls =3D 0;
> > > -               if (link_settings->frl_link_rate >=3D
> HDMI_FRL_LINK_RATE_16GBPS)
> > > -                       max_polls =3D 155;
> > > +               max_polls =3D 155;
> > >
> > >                 while (num_polls < max_polls) {
> > >                         flt_poll_cur_time =3D
> > > dm_get_timestamp(ddc_service->ctx);
> > > --
> > > 2.55.0
>
>

--000000000000889295065e8576cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jerry,<br><br>Thanks for the titles. Before dropping my=
 patch I tested both changes on<br>my hardware:<br><br>=C2=A0 &quot;drm/amd=
/display: Fix HDMI2.2 LT timeout duration&quot;<br>=C2=A0 &quot;drm/amd/dis=
play: Adjust HDMI FRL LT timeout&quot;<br><br>Setup: ASUS ROG Flow Z13 (GZ3=
02EA, Strix Halo, DCN 3.5), LG C2 OLED<br>(firmware 43.21.74), certified Ul=
tra High Speed HDMI cable, 4K120 10-bit<br>RGB =3D FRL 10 Gbps x4. Kernel 7=
.3 (CachyOS 7.3.0-4). I applied the first<br>change and the 220 ms line fro=
m the second (d6751306 in<br>amd-staging-drm-next) to link_hdmi_frl.c, and =
left out the FLT_no_timeout<br>compliance rework in between, since a TV nev=
er sets that bit.<br><br>Test: 20 mode switches 4K60 -&gt; 4K120 with drm.d=
ebug=3D0x2, time measured<br>from &quot;Poll for FLT_UPDATE&quot; to PASSED=
/FAILED.<br><br>=C2=A0 220 ms (your changes): =C2=A028 trainings, 4 timed o=
ut at 221 ms<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;Timeout waiting for FLT_UPDATE&quot;=
). Each one<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 passed on the driver&#39;s retry ~0.4 s lat=
er.<br>=C2=A0 ~300 ms (my patch): =C2=A0 =C2=A0 29 trainings, 0 timeouts. L=
oop time 196-244 ms,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 median 208 ms, 9 of 29 over 220 m=
s.<br><br>Over about 270 earlier trainings with this TV the longest was 257=
 ms. So<br>220 ms works, but with this sink it costs a retry on roughly one=
 link-up<br>in three to seven. Would you consider 300 ms for every rate, th=
e same as<br>for &gt;=3D 16G? I&#39;m happy to test any patch.<br><br>Separ=
ately, a regression I hit in 7.3 that is unrelated to the timeout:<br><br>f=
ill_stream_properties_from_drm_display_mode() in amdgpu_dm_connector.c<br>n=
ow does<br><br>=C2=A0 =C2=A0 if (is_hdmi_ep)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 adjust_colour_depth_from_display_info(timing_out, info);<br>=
<br>which clamps FRL streams to the sink&#39;s max_tmds_clock. v7.2 only di=
d this<br>for SIGNAL_TYPE_HDMI_TYPE_A. On the C2 (600 MHz max TMDS), 4K60 1=
0-bit<br>needs 742.5 MHz, so it is lowered to 8-bit, update_stream_signal()=
 then<br>moves the stream to TMDS, and the TV loses HDR at 4K60. On 7.2 the=
 same<br>mode trained FRL at 6G x4, 10-bit. 4K120 is unaffected only becaus=
e no<br>depth fits under 600 MHz, so the clamp gives up.<br><br>Locally I c=
hanged the condition to<br><br>=C2=A0 =C2=A0 if (is_hdmi_ep &amp;&amp; stre=
am-&gt;signal !=3D SIGNAL_TYPE_HDMI_FRL)<br><br>At that point stream-&gt;si=
gnal is still the sink&#39;s signal, and<br>update_stream_signal() runs aga=
in after the fill. With this, 4K60 is back<br>to FRL 6G x4, 10-bit, with HD=
R. dc_validate_stream() still checks the FRL<br>bandwidth, and the caller f=
alls back to the next depth if it doesn&#39;t fit.<br>I can send this as a =
proper patch if that helps.</div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2026 at 11=
:59=E2=80=AFAM Zuo, Jerry &lt;<a href=3D"mailto:Jerry.Zuo@amd.com">Jerry.Zu=
o@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">AMD General<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Zuo, Jerry<br>
&gt; Sent: Friday, October 23, 2026 11:50<br>
&gt; To: &#39;David Janice&#39; &lt;<a href=3D"mailto:djanice1980@gmail.com=
" target=3D"_blank">djanice1980@gmail.com</a>&gt;; <a href=3D"mailto:amd-gf=
x@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a=
><br>
&gt; Cc: Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com" targ=
et=3D"_blank">Harry.Wentland@amd.com</a>&gt;; Li, Sun peng (Leo)<br>
&gt; &lt;<a href=3D"mailto:Sunpeng.Li@amd.com" target=3D"_blank">Sunpeng.Li=
@amd.com</a>&gt;; Rodrigo Siqueira &lt;<a href=3D"mailto:siqueira@igalia.co=
m" target=3D"_blank">siqueira@igalia.com</a>&gt;; Deucher,<br>
&gt; Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_=
blank">Alexander.Deucher@amd.com</a>&gt;; <a href=3D"mailto:dri-devel@lists=
.freedesktop.org" target=3D"_blank">dri-devel@lists.freedesktop.org</a><br>
&gt; Subject: RE: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link<b=
r>
&gt; training at every rate<br>
&gt;<br>
&gt; Your change already being considered in below two changes. Please kind=
ly<br>
&gt; check below two changes:<br>
&gt; &quot;drm/amd/display: Fix HDMI2.2 LT timeout duration&quot;<br>
&gt; &quot;drm/amd/display: Adjust HDMI FRL LT timeout&quot;<br>
<br>
Just add commit title for your reference.<br>
<br>
Regards,<br>
Jerry<br>
&gt;<br>
&gt; Regards,<br>
&gt; Jerry<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: David Janice &lt;<a href=3D"mailto:djanice1980@gmail.com" t=
arget=3D"_blank">djanice1980@gmail.com</a>&gt;<br>
&gt; &gt; Sent: Saturday, September 19, 2026 21:31<br>
&gt; &gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_b=
lank">amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt; Cc: Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland@amd.com"=
 target=3D"_blank">Harry.Wentland@amd.com</a>&gt;; Li, Sun peng (Leo)<br>
&gt; &gt; &lt;<a href=3D"mailto:Sunpeng.Li@amd.com" target=3D"_blank">Sunpe=
ng.Li@amd.com</a>&gt;; Rodrigo Siqueira &lt;<a href=3D"mailto:siqueira@igal=
ia.com" target=3D"_blank">siqueira@igalia.com</a>&gt;; Deucher,<br>
&gt; &gt; Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=
=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Zuo, Jerry<br>
&gt; &lt;<a href=3D"mailto:Jerry.Zuo@amd.com" target=3D"_blank">Jerry.Zuo@a=
md.com</a>&gt;;<br>
&gt; &gt; <a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_bla=
nk">dri-devel@lists.freedesktop.org</a>; David Janice &lt;<a href=3D"mailto=
:djanice1980@gmail.com" target=3D"_blank">djanice1980@gmail.com</a>&gt;<br>
&gt; &gt; Subject: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link<=
br>
&gt; &gt; training at every rate<br>
&gt; &gt;<br>
&gt; &gt; [You don&#39;t often get email from <a href=3D"mailto:djanice1980=
@gmail.com" target=3D"_blank">djanice1980@gmail.com</a>. Learn why this<br>
&gt; &gt; is important at <a href=3D"https://aka.ms/LearnAboutSenderIdentif=
ication" rel=3D"noreferrer" target=3D"_blank">https://aka.ms/LearnAboutSend=
erIdentification</a> ]<br>
&gt; &gt;<br>
&gt; &gt; hdmi_frl_perform_link_training() gives LTS:3 a single budget of 1=
05<br>
&gt; &gt; polls at 2 ms (~210 ms) that starts at the FRL_Rate write and is =
not<br>
&gt; &gt; restarted when the sink raises its first FLT_update with the LTP<=
br>
&gt; &gt; request. A sink that needs close to<br>
&gt; &gt; 200 ms after the LTP request to report lock therefore fails whene=
ver<br>
&gt; &gt; its LTP request itself takes more than a few tens of ms.<br>
&gt; &gt;<br>
&gt; &gt; Measured on an LG C2 (GSM 49352, 2022) driven by a Strix Halo DP-=
HDMI<br>
&gt; &gt; FRL PCON, DPMS off/on with drm.debug=3D0x2, kernel 7.2.6:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A06G x4=C2=A0 (3840x2160@60 10bpc):=C2=A0 LTP request a=
t poll 11 (~21 ms),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock at poll 100 (~179 ms later=
): PASSED first try.<br>
&gt; &gt;=C2=A0 =C2=A010G x4 (3840x2160@120 10bpc): LTP request at poll 22 =
(~44 ms),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no lock by poll 105: &quot;FAIL=
ED - Timeout waiting for FLT_UPDATE&quot;.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Retry 200 ms later: LTP request=
 at poll 11, lock at poll 101:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PASSED.<br>
&gt; &gt;<br>
&gt; &gt; The sink answers FLT_READY on the first poll every time and locks=
 in a<br>
&gt; &gt; steady<br>
&gt; &gt; ~180 ms at both rates, so it is neither slow to wake nor marginal=
; the<br>
&gt; &gt; total just does not fit 210 ms once the LTP request is late, whic=
h<br>
&gt; &gt; happens far more often at 10G. On this system that is the differe=
nce<br>
&gt; &gt; between reliable DPMS wakes at<br>
&gt; &gt; 4K60 and mostly dark ones at<br>
&gt; &gt; 4K120: hdmi_frl_perform_link_training_with_retries() retrains at =
the<br>
&gt; &gt; same rate up to four times 200 ms apart and the output is then le=
ft dark.<br>
&gt; &gt;<br>
&gt; &gt; &quot;drm/amd/display: Update and revert FRL LT Timeout behaviour=
&quot; already<br>
&gt; &gt; allows 155 polls (~300 ms) for 16 Gbps and above. Use that budget=
 at<br>
&gt; &gt; every rate. With the change applied to 7.2.6, five consecutive DP=
MS<br>
&gt; &gt; wakes at 10G<br>
&gt; &gt; x4 trained on the first attempt; three of them locked at poll 104=
-105, i.e.<br>
&gt; &gt; inside the last 1-2 polls of the old budget.<br>
&gt; &gt;<br>
&gt; &gt; Cc: Fangzhi Zuo &lt;<a href=3D"mailto:Jerry.Zuo@amd.com" target=
=3D"_blank">Jerry.Zuo@amd.com</a>&gt;<br>
&gt; &gt; Signed-off-by: David Janice &lt;<a href=3D"mailto:djanice1980@gma=
il.com" target=3D"_blank">djanice1980@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 .../amd/display/dc/link/protocols/link_hdmi_frl.c=C2=A0 | 1=
4<br>
&gt; &gt; +++++++++++---<br>
&gt; &gt;=C2=A0 1 file changed, 11 insertions(+), 3 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git<br>
&gt; &gt; a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c<b=
r>
&gt; &gt; b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c<b=
r>
&gt; &gt; index 7f93009..005feb9 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl=
.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl=
.c<br>
&gt; &gt; @@ -528,10 +528,18 @@ static enum link_result<br>
&gt; &gt; hdmi_frl_perform_link_training(struct ddc_service *ddc_s<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FRL_=
INFO(&quot;FRL LINK TRAINING:=C2=A0 Poll for FLT_UPDATE.\n&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*LT=
S:3: Start Link Training*/<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*Start F=
LT Timer =3D 200 ms, or 300ms if link rate &gt;=3D 16Gbps*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start =
FLT Timer =3D 300 ms. HDMI 2.1 specifies<br>
&gt; &gt; + FLT_TIMEOUT =3D 200<br>
&gt; &gt; ms,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * but th=
is budget runs from the FRL_Rate write to the final<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * FLT_up=
date and some sinks need more than that in total: an LG<br>
&gt; C2<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (2022)=
 at 10G x4 raises its first FLT_update (the LTP request)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ~45 ms=
 after the rate write and reports lock a further ~180 ms<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * later,=
 ~225 ms in all, so it failed the 105-poll (~210 ms) budget on<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * most D=
PMS wakes at 4K120 while at 6G x4 (~20 ms +<br>
&gt; &gt; + ~180 ms) it<br>
&gt; &gt; just<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * fit. U=
se the 300 ms already allowed for &gt;=3D 16 Gbps at every rate.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_=
polls =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (link_=
settings-&gt;frl_link_rate &gt;=3D HDMI_FRL_LINK_RATE_16GBPS)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0max_polls =3D 155;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_polls=
 =3D 155;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0whil=
e (num_polls &lt; max_polls) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0flt_poll_cur_time =3D<br>
&gt; &gt; dm_get_timestamp(ddc_service-&gt;ctx);<br>
&gt; &gt; --<br>
&gt; &gt; 2.55.0<br>
<br>
</blockquote></div>

--000000000000889295065e8576cc--
