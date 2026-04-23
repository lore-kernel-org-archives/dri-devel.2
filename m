Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A870F99355
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DE310E2FD;
	Thu, 23 Apr 2026 08:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqCdh4dN";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136D810E2DC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:50:29 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-692205ca402so2173516eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776905429; cv=none;
 d=google.com; s=arc-20240605;
 b=Bas5jAmZ9WkaUFgfqoLlTaKoxITuHg7pIM0VhcAzg6EKsLBQ27XsXxJ0JyI60EyG3/
 s0Z4vXPaygup3UQz/RsKJtJIwQVWAI0zfocdbwPkpz9oabcPEFvLX72XmTiEkse3zaZF
 U68w40i4qS92dABOye4eMmBx7u3A9izqHIDDsKAmCy298O/6Gy7pTCG+DVXKmjnNfZ+o
 UiSHpAgdnLPhImpDyNkZ8QM65+Ug2Xi/8t6GRCeZniithe9CxN1TkUi8DmDxkpxxzbKl
 Lm++0hJKATUoFkwWayuGWR3Cr8nLPuSqH5Qt/l07S3mONzVTeBoJeHah9vvAPafdSPdM
 h/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/nEWRDfbzTChYAGuWA9e4JOGkSzV/lYIHVDwL6GP/tA=;
 fh=sKF+/v7MmOrQLOf94A4Hlb1RDIcx+kwZWPH9BCDU688=;
 b=a4cD0n33X+02G10N0gExmE/DLxEB/5zECbIq2bl1nB38PmgAv3v5pw2+1VBIsnL/WN
 9emPkrRp7X3v5RFxsB5utE1VBAcma694/bzvdm/imaF+65UYz9OaATlBHBlMMvl1d5XV
 5oJiZZ3b/4Zzagequu7ESV6+J77B1v4mYlP9MD/UWwuifS5h/SmBvVU3g3EmQEdn4+TR
 u3e4QIRbcEOUFDi7A78NMsi9YkCnrWak/nFY+ZxSoSg1l+V8G5otSQJyVYOA9I/y1Gzn
 vWsDBLwqgEEf5h+GoI7EHUIX1TAwtww0FUmYJl2ZUmB/FOr218iFGct+ly+56S6EUugb
 fJyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776905429; x=1777510229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nEWRDfbzTChYAGuWA9e4JOGkSzV/lYIHVDwL6GP/tA=;
 b=DqCdh4dNMJNG26EzzvAh8vHbMAtxakDxg8zejFiEP3JdsFLaEXbNlaGsmVJZNLr2vJ
 CmAxacJHrTm0R8JsWq1F+QXm5IwNpDAUXRk+JsvVg8oxmuzslfrU8z6kdamnb39dUsHB
 /H5Ygnbxg/5+1CYkv5cu5Wi9NWL1XNRMTxPz/lXYrjqTdqSTvREES7VWow20/yAL5YFa
 Cwx98yygAp34LU9ZDllIn5y2mq4WGpRwbbVZ1sjCpTsO6/7ayPvdQZSLGtDzc44j4kuQ
 uXQH/PwtztLAtJ1MeF96nW3fvHaEmVgt4MyMrq+b+QO5KlHZVAA1ykd2DSUiJbH+8pqY
 7zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776905429; x=1777510229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/nEWRDfbzTChYAGuWA9e4JOGkSzV/lYIHVDwL6GP/tA=;
 b=gB6ajwsf3zdfuU6K9bGyqCVhv1PSa08aw2f3ds2Ui0IQIUnLZt2QMse52byg8cjzM0
 K9E4GRS63t4pKLP0YZBrroVGXM0rz+8a4TWoHDqrpj6KL61cn1OfcE4rqTQr7yJPWzo6
 8B946UtXFfWBPIV0LzEcBYu965H5v2NKwaV8bJaqUKkro4jTB8VyyGVYONZFOEQJAqKe
 iwpeDS9qA1mN4YUwwhppQOeZ65og0c2L469TmObAhgs8PBvouMVJY6MIGnjLcYyeOqlf
 v+BvAe8b0TAXuF3Ftf39cRMNcg6b4zqzeBUhiGrkAITtFb09ilRnhrvaU71cUsEhusdk
 xsZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bcd+Ln3dWCBnx+MC/FmJdO28wrc3uNQdbQDW5l2AkahQIO4XsZdqUgVChLUL/4f76Pi+BAT4CyRQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3hSCD4Gwm0FK+oPffElIEeEdJUqqhGRHUKUKo3Xk2EZoqka6t
 aKvSsRpueFwJVeuoJz3WVYIWy1vQXi69g6VtWF0l+njGjbS/mMz0kfkZ/slr+iTLL1INxP4xt2/
 m/I2jUEbuPge7GeOKPd9o9VRH95Ta6iY=
X-Gm-Gg: AeBDies4vH2yjCPER/Me3KNVrtfFHirmFqZZzrb+NYJewgzzHR6z6RIIT47iG9U3+A8
 ssTUfvE71qrJBA2jdMfRvV1DqpVrXDbxhWeRahYY6dMY6G/8gfYNX4ulKzSa4nX6qUEs+i1wPwu
 s06NHZ66K4I5uzLZxa03a/SOlITPsonmzzWX/Wnn0vx/tn2c2XoV+prgF/9V0uBCSeXibjvpjdm
 otBnrUI1U16jody0jT1d3Y0RVL9DgRAx4pCPkAYsGIoFZOMppZRJjNbu2RtJIRonaSM5uZyoUdA
 m2JS3eQI6Bq3AQg2Fw==
X-Received: by 2002:a05:6820:168b:b0:694:a2c9:2d50 with SMTP id
 006d021491bc7-694a2c92d8cmr3710704eaf.59.1776905428946; Wed, 22 Apr 2026
 17:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-3-syyang@lontium.com>
 <stkoeboxioodtki3nyksdglihgze243u25ui7dbyac4tuuobgx@ncl4j6l4vfqh>
 <CAFQXuNYXP1fiJtUiMb5iBL=jVXTB8HX8JLzto_eGOZvUaeZkfw@mail.gmail.com>
 <mvthlwcekj6i2h7bi5lns7ycictafjjyninvubp6adgaqxchkz@372c36cxon5t>
 <CAFQXuNZG-La0YpmHgMA-TZ2ayPDLfEvkbrSJZyW-jFCzXU-mLw@mail.gmail.com>
 <seno7shjhledyrunl5pib323zwgshtyhi455hzyspkhuvbps4m@qb4gwwakfww7>
In-Reply-To: <seno7shjhledyrunl5pib323zwgshtyhi455hzyspkhuvbps4m@qb4gwwakfww7>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 23 Apr 2026 08:50:13 +0800
X-Gm-Features: AQROBzBHLWJYWmQo9B-MiMuVDVxir1nNlnqbfrHtYvsavDSTDptUuFtwGXyCe4c
Message-ID: <CAFQXuNYUj6OnR9Fo4qqebO3g38A2jbARbUWzgTXjYVB08WYcbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: This patch add new DRM bridge driver
 for LT9611C(EX/UXD) chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 tzimmermann@suse.de, xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:51:37 +0000
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
4=E6=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B 02:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 22, 2026 at 12:41:11PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B44=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 18:48=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Tue, Apr 21, 2026 at 03:37:52PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90=
 wrote:
> > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=
=E5=B9=B44=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 20:18=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > On Mon, Apr 20, 2026 at 02:16:44PM +0800, syyang@lontium.com wrot=
e:
> > > > > > From: Sunyun Yang <syyang@lontium.com>
> > > >
> > > > > > +
> > > > > > +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridg=
e,
> > > > > > +                                   struct drm_connector *conne=
ctor,
> > > > > > +                                   struct hdmi_codec_daifmt *f=
mt,
> > > > > > +                                   struct hdmi_codec_params *h=
parms)
> > > > > > +{
> > > > > > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > > > > > +     u8 audio_cmd[6] =3D {0x57, 0x48, 0x36, 0x3a};
> > > > > > +     u8 data[5];
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     /* Validate sample rate and width (LT9611C auto-detects b=
ut we still check) */
> > > > >
> > > > > What for? You don't trust ASoC / ALSA core that the rates would m=
atch
> > > > > HDMI_RATES?
> > > >
> > > > Chip has limitations on sample_rate, sample_width, and fmt, and can=
not
> > > > support all formats.
> > > > The validation here is to ensure that only the formats supported by
> > > > the chip are used.
> > >
> > > Again, for sample rates, is it different from HDMI_RATES? If not, it =
is
> > > useless protective coding.
> > >
> >
> > I checked the definition of HDMI_RATES and ended up doing a redundant
> > validation.
> >
> > #define HDMI_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> > SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> > SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |\
> > SNDRV_PCM_RATE_192000)
> >
> > However, if HDMI_RATES is extended in the future to include sample
> > rate not supported by LT9611C, this driver would require corresponding
> > updates.
> > If this is not expected to happen, I can remove the redundant check.
>
> Updating HDMI_RATES would cause enough issues for the existign drivers
> which don't have this kind of a check.
>
OK,
it will be removed in next version.

> >
> > > > >
> > > > > > +     switch (hparms->sample_rate) {
> > > > > > +     case 32000:
> > > > > > +     case 44100:
> > > > > > +     case 48000:
> > > > > > +     case 88200:
> > > > > > +     case 96000:
> > > > > > +     case 176400:
> > > > > > +     case 192000:
> > > > > > +             break;
> > > > > > +     default:
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +
> > > > > > +     switch (hparms->sample_width) {
> > > > > > +     case 16:
> > > > > > +     case 18:
> > > > > > +     case 20:
> > > > > > +     case 24:
> > > > >
> > > > > and no support for 32?
> > > > >
> > > > no support for 32
> > >
> > > Then check for that rather than listing all the widths. If you check =
the
> > > hdmi-codec, you can't get 18-bit samples at all.
> > >
> > You are right, there is no 18-bit support.
> >
> > same reason with sample rate.
>
> Yep. Check for 32-bit, the rest is fine.
>
Same , it will be fixed in next version.

> >
> > > > > > +MODULE_LICENSE("GPL v2");
> > > > >
> > > > >
> > > > > I think, checkpatch.pl should have flagged this.
> > > > >
> > > > yes,  it is need use GPL?
> > >
> > > If it flagged the line, why didn't you fix it? What did checkpatch sa=
y?
> > >
> > Sorry, it is my mistake. i will fix.
> > checkpatch say:
> > WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
> > ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> > #1450: FILE: drivers/gpu/drm/bridge/lontium-lt9611c.c:1364:
> >
>
> So... If there was a warning, why did you ignore it? Please don't,
> unless you really know what you are doing.
>

it will use GPL in next version.

> >
> > > > I see that many of the latest code still use GPL v2.
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry
