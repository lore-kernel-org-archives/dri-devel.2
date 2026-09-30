Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E66CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB4A10F40F;
	Wed, 30 Sep 2026 13:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ChZsXolk";
	dkim-atps=neutral
Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com
 [74.125.224.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1A310F40E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:42:53 +0000 (UTC)
Received: by mail-yx2-f40.google.com with SMTP id
 956f58d0204a3-66e4aa8d881so5667187d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790775772; cv=none;
 d=google.com; s=arc-20260327;
 b=NaGHC6wnZ0X7qociUfTRZ7oQecWgbZ7YKr+xTzkT61dqv5AchFwek06QshXme/2ieQ
 cszgU8m8Wm0Mo02a7wXmBhyNA7lYn6MASJNcFrbGKy5uEWmzpTa2toCb1h5u7YyhuuFJ
 /QJLtiG03MlaiUSZuH2fNa7BM07Y3bI/FPriC9B+BC0SkAS9tBthjwgGsS/9V0WBhrnG
 i+KsymL9joJItMvImPdmMfruHSV1vtiBbxHIsyInlQDkh48uHyEi6fRAWdfD0xo+1+ma
 aFfXjbG0iTdUgbS5ceUQy9VibW6L0KQ8Kx2ed8mhI3kDyJrFwsBp0O87Yf0WiLDiwBQy
 IGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DhCRdy2JCa2oSL6X3aWOWI051OiTlXnSfcThJ9UZLT0=;
 fh=0Z8ArQYdmNGxmRaZ8MVihgPJioqhPQnqX6JrWdXdKDs=;
 b=mB/86/C8IAojcGvLIOB1hoEBwXy1t31RUcIqr5dCijj32UUX3uUd310+KKX50XMMHa
 Yhu+XzpDMBGL3Y1CSCv6huYgOqGYI/4PQiFZJXJhnGs6060l7m/fG/SQjb9RyNNIv3mB
 iJu//vbkyDLWB0VoqQ/Y6ruiTNZhD87Na+/ZiMr0ZfeY/EoRDm4pfGu9mPja0d/p3VZV
 g/gt2zLx1y/pOtm+aK42PDmC/LoEptI6KbCToKu9gQjpRJWnzGRXhDtSrVi5VcHZQcFC
 dtMhLFCApCj1VKwNKYVpf/gRD9IZj0ZwGmdHvbd1Bp29TCuVmz7FdFmkzRN7yZXoBr7+
 t3dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790775772; x=1791380572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DhCRdy2JCa2oSL6X3aWOWI051OiTlXnSfcThJ9UZLT0=;
 b=ChZsXolkmZ/DMqggF2jaSejG9X7LZXIVsWCuMX9Kl7yjJe7X7blKAbXV9V9fUZEYSB
 XJIyqmn01fqZsoYAv+7ykg6evNzlpNbqeWIV1sfyW3TIT2dEcAhvs2kuduOekIvqyDhk
 ML3onsvA2bo1+9rzNpmMFJ3Rv+aSoaKPB4wFIi3BTpLLonPvkgZGxp+RYJtu3EQ//MeQ
 P0bORkD1mq0vjdgMXuZ3jgHdAssGWIhdLe1+vsjz0ZQHV8H+b6s1rKJkr/QHtGABYvBc
 h7e2ktk/nFiOg1UkInOHSHh1EqDYAFIbhHSpowAvcF3dkr7U0/NK+Z9H+cEXTCMJJlOy
 /WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775772; x=1791380572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DhCRdy2JCa2oSL6X3aWOWI051OiTlXnSfcThJ9UZLT0=;
 b=OQuEzAGzNUEy5hgSXohtaJeLcs13nfJP5Nh331h2RG3Ff2c7uBl4k8J3u0deh74WKh
 GXRac3//+0JRSwwgpmnP/Vv/Nryaa1PVEzYKq4eyryyEiIVq6fXtD+/ne3o87nulO4CH
 8vWZVkp/60Wye1Uc34q0MjlDDlhvlXwVyuBY9CAjmE6V19/T25P8aSEKfPYzrjr5HMsr
 OgoIC48H4O0kfphJWim7IN1IfDM4ihOeivE5Pa4PZeMsDSA5aHbOpMpmAcb6ng+TGSzM
 xWIS7471DXuxiw+Urjhh/3M0J4nhNBJjfwGXmwYle1I8bmhhyBFzK+SmHeqVCOTNYvqb
 1nww==
X-Forwarded-Encrypted: i=1;
 AKwUvByiVxUUUfpGr2hDeONig/aoHqOmAIy953EVPv1g8f/eSF+ey4e1Exqf5+pQEimo1afZhT9LXUXOwTg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzGCM1/d2Zlsq/gjRlrW9F9fRhGYZYdsP/ka+Az1ZfhmI5OhTO
 KBMqFWFcixnrjCm/tMG8j39zKRsGaSX3xnijYBKFOuTbaOkSiok3MWQLUcLeqi2ax8toUSJbDC3
 +J4I1Sq7TzR/QNIyZW+poIfbzXLHhlH8cCv7dDy4kwA==
X-Gm-Gg: AYBFou3bDCOCFKYJ5/6/TKGlOlIzzyh3k9PCj+1YXCitcyOPtxZVSUXvOZfBFMU/Jof
 7hsy8oWC7hNQpl/J9Jb3NSd9vVE7ri089VT2mEBmFgAPTuTJ8bP460sZ91Gxku12DoucstthHXg
 4HmPeM8moqhvA9sT/0Hz6WICP0CJ5uA8nI/oPg52XZ706hExjEy3LnNPEFeJ542odjYQOh+mibZ
 dBwh/7HsnCAPJxlWmAcdVmO6lBnuSBA1GoekQpBAa1bBoW2fxMQjArillCT3kyF7gcga9vCY7y0
 uQo0KZbHib8nv/It5xaFWXbZ0FS/8y2ryQCrvZUJjoK7S0hgh6Bvlstd8QA4/Rlk7ee3PiCSQrk
 =
X-Received: by 2002:a05:690e:4888:20b0:671:464a:46e7 with SMTP id
 956f58d0204a3-676834802cfmr493380d50.28.1790775772498; Wed, 30 Sep 2026
 06:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-2-c042266b9eeb@linaro.org>
 <5r6xd4iiwnv2v5ji7xeddihlqstmtajvw5ixmntlwxxmcvo7y6@zueqflvz3lr5>
In-Reply-To: <5r6xd4iiwnv2v5ji7xeddihlqstmtajvw5ixmntlwxxmcvo7y6@zueqflvz3lr5>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 30 Sep 2026 21:42:41 +0800
X-Gm-Features: AclHuK8pN-tKG1Z4oDPKCBz_In7b0hfp5ejCHcZi1g56pqmcGmYpl4iWM_GNAmM
Message-ID: <CABymUCP5Gs5Zx9C39RHj+1_mU7aLou9sfgZO=7yS=+fVPWHeLg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
9=E6=9C=8830=E6=97=A5=E5=91=A8=E4=B8=89 00:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 27, 2026 at 04:08:41PM +0800, Jun Nie wrote:
> > Some panels require multiple slice to be sent in a single DSC packet. A=
nd
> > this feature is a must for specific panels, such as Sharp ls026b3sa06. =
Add
> > a dsc_slice_per_pkt member into struct drm_dsc_config and support the
> > feature in msm mdss driver.
> >
> > Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 27 ++++++++++++---------------
> >  include/drm/display/drm_dsc.h      |  7 +++++++
> >  2 files changed, 19 insertions(+), 15 deletions(-)
> >
> > @@ -1719,8 +1709,14 @@ static int dsi_host_attach(struct mipi_dsi_host =
*host,
> >       msm_host->lanes =3D dsi->lanes;
> >       msm_host->format =3D dsi->format;
> >       msm_host->mode_flags =3D dsi->mode_flags;
> > -     if (dsi->dsc)
> > +     if (dsi->dsc) {
> >               msm_host->dsc =3D dsi->dsc;
> > +             /* for backwards compatibility, assume 1 if not set */
> > +             msm_host->dsc_slice_per_pkt =3D dsi->dsc->dsc_slice_per_p=
kt ?: 1;
> > +     } else {
> > +             msm_host->dsc =3D NULL;
> > +             msm_host->dsc_slice_per_pkt =3D 0;
> > +     }
>
> Why do you need the else branch? Isn't it already NULL / 0 by default?

AI bot review comments reminding a case that panel device may be switched
to another panel. Not sure whether it is possible in real world. Just add t=
his
for safe.
>
> >
> >       if (msm_host->format =3D=3D MIPI_DSI_FMT_RGB101010) {
> >               if (!msm_dsi_host_version_geq(msm_host, MSM_DSI_VER_MAJOR=
_6G,
> > @@ -1757,6 +1753,7 @@ static int dsi_host_detach(struct mipi_dsi_host *=
host,
> >       struct msm_dsi_host *msm_host =3D to_msm_dsi_host(host);
> >
> >       dsi_dev_detach(msm_host->pdev);
> > +     msm_host->dsc =3D NULL;
>
> If you are fixing something, it should come as a separate commit.

The same case as above.
>
> >
> >       DBG("id=3D%d", msm_host->id);
> >
> > diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_ds=
c.h
> > index bbbe7438473d3..c522ab3d71853 100644
> > --- a/include/drm/display/drm_dsc.h
> > +++ b/include/drm/display/drm_dsc.h
> > @@ -267,6 +267,13 @@ struct drm_dsc_config {
> >        * Offset adjustment for second line in Native 4:2:0 mode
> >        */
> >       u16 second_line_offset_adj;
> > +
> > +     /**
> > +      * @dsc_slice_per_pkt:
> > +      * Number of DSC slices to be sent in a single packet. This is no=
t
> > +      * part of DSC standard, and only used in some DSI panels so far.
> > +      */
> > +     unsigned int dsc_slice_per_pkt;
>
> If it's not a part of the standard, I think, it should not be a part of
> drm_dsc_config. In the end, drm_dsc_config is also being used by other
> parties, e.g. DP or HDMI. A year ago I saw a version of this patch,
> having this field in the struct mipi_dsi_device. I think it's a more
> correct place.

I will move to struct mipi_dsi_device in next version.
>
> --
> With best wishes
> Dmitry
