Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE148CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0471510E249;
	Wed, 30 Sep 2026 10:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZAAZFiP";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C1B10E249
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:48:15 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34c2a97ec17so717972eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790765294; cv=none;
 d=google.com; s=arc-20260327;
 b=fjRfJyA5mg8oCxM301UwWeNFySujF5C1Ewd8MgdmG2W1qigbzx0nPA53NxHbpNOpsO
 SQ7DdyMA8z3R+CCy/3Llo3bQD7UqcOpdB8wJjo1z1+Bvi51qdSnee/zc0C4jiIV+SdAi
 tf/hh6WwVeDaZBi6ZQnYct0YOB1snl5ZvaRPbQXiDky7ahyGunPCG/Lwl87M6hd5RwL6
 xI7KLoYvrNjemmnwj33PUC2mXsOX7AWpRrRtBYDgg3hKNJNjXU2Nle58TMjbXSQORac2
 eyis2AUlGbuT/lmemUix1V3u4uLG6l7+/lE8+GkoPdZcAkT/sZuTvclJUBg+N0Jia0eE
 TUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PzwGy8l1+YM8qJ7FQ+1mOaVfQljvGUnBphrwb0sFzIw=;
 fh=sAgf4DFvoZ4Y3V3C/B8WDagt/Enr4zXslhxEVS6zqLU=;
 b=YFZ3r9VmA8okCGhRxQmPzdwYbfQL4fHfqGFhIff55NGDiMnFzrwOR6d6D4/DTs+tNk
 aVXWxweKU2A15vdqK5sNHcfUfw7EzDmnQ0+D1q4r2X8QziSYon8ob4UP0XHJJup3ZEEx
 dztGIloe68/PZF28l3xL3dLW0CicBEQkk6fMOg+X9yNsn0s2Xw4rRlA73AGTGAza2odp
 yQEZhw4nhpADmJXvWGeMgwyb99AS2kWYPiBdSsZexXjRp59IGDgWSRI5jagnaHNRLz/+
 Ant7Ajb0Wld5Yg77xQwBki10NlMXplN2ygFWcmACAy6AVyb1yNqo2BVrhkGU2Fzs1+yu
 r/Yw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790765294; x=1791370094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PzwGy8l1+YM8qJ7FQ+1mOaVfQljvGUnBphrwb0sFzIw=;
 b=nZAAZFiPqslWQzCM+mJd2TJYkUYV6ATbZN7Zef6K9yX5Ucw9PjCwiZ08iqHsC6fz31
 U5mcvQLJcGW51QNgWoERz9N0urNfQxBHLIDjqRA5J+CCegSBrg9dlFLHbcMQ7Fe3TQje
 J8weuz3VcBwiiU+B4UPP+/xVOs+JrI/00bj5NTU34Fhcx+szdII/pcmggwsFdsevaiuj
 hmfCVpICBh2CRL0oxsGMmJzvFIHFiM86MdsW7Lhs73qvRt0Wt4B3uka7LdB0XTaIpxr/
 +uWjkdWkdXlereWuz/KYaaIiYwav3Fmseaf2LZIUgBtTYdVor+RYjd/nT34mX9aLqRd4
 JUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790765294; x=1791370094;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PzwGy8l1+YM8qJ7FQ+1mOaVfQljvGUnBphrwb0sFzIw=;
 b=icGfObw3uRcj7xNAxlft1Yf6KwIHf7haWkV5ozjp0D/dprZZthi+tw38yy47l6l7nv
 I702mwjSDsAHXG4TZKJrfYX883+7QTX0mOCMVlhLIEVoMi+PkVcAEExiiGuP5uyLQ16e
 mlFRNy44KQLFA2NAENrzQ3zPBuj7x4zzNTMuS3HplcWeWkdTk/JfIlI9ajrWUsHs3mSq
 l81eLcQwTFhMSoKunhJnADNZXoWnqyRBUnGZXEQn+FO1UzaFFo1WxhhpIam1PjZkuaqR
 bKOeNbu4RsbRmgwfA0G5lU1fLBngNLiOuNG27PzKIiM31Ja2FhUHMil81OzpgMVuYEyp
 uFuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfwhGyBA+ZaNOSoVErT1qlguq3hEOTE63EsBbpynV6CiowEOkCB24Dq0wCEvj3yTwzMQG9rOgUN3M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIEnjImpYAY9zQ60xRIgPjL3AlYqiCMC6zgd3VCLYMs2IA3obiq
 wTfMrZdJwFyKL1seZkmUqnnRPbkDTMburuAif6Do6yBV+RkxL+O/xcLFAlvNe9qiXFf58SPuTLv
 ju8d6+stgAmTIGO2xkhaJMG4x+VfwRhM=
X-Gm-Gg: AYBFou33p0KwgwY6J7GTzLgMxBNKQqsL6N4s3zj3AvTIOziVBvKP/BU3Um/RJ7Gmy++
 gKCJgJA1EGuxkJtM+OFlczuJbt9bsBX2oxNNwSSdFqkxtHFS5sHQgheyOi5h8Rc8swWwMpLyeGA
 BQhEyRqhECKrVQm9oNyCA5OPpl7oHQQ2B5VCBCa/cGVjz0AbHlwrXZ6p9VU8YUBFsTL9m0+yFTS
 v1tbZKzpWM3lPfLFja+yy5XbEfLAz823+NlfaOxOhPYuNdHmXtLElxZ8CykN78d9xzIsPN6syHY
 0fEMZomO+m0nOmq7iiRrYrieDCpUkK2k8ZjqSzkYZXE1no2VpImyVAQ3BVBcT6BxCsXHPZk6k2u
 cN9kvqhS5mU3s
X-Received: by 2002:a05:7300:8296:b0:34b:7e89:997 with SMTP id
 5a478bee46e88-34cdd69689dmr1294076eec.38.1790765294291; Wed, 30 Sep 2026
 03:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
 <arzNgbx465QIKYdX@orome>
 <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
 <arzilGz4akKvRF1K@orome>
 <CAPVz0n0-baCzHOXjWLOCLjv8fb5GbE9a2v=8tBYr3RgHkEu+qg@mail.gmail.com>
 <arznE4HKl9r_mPX2@orome>
In-Reply-To: <arznE4HKl9r_mPX2@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 13:48:02 +0300
X-Gm-Features: AclHuK-qGc3Psoay8x3hInLmhZCMxpDiJ3bmtWhyIJMqMqR4y3RvUdbuIDV09gs
Message-ID: <CAPVz0n2A8oU_yRFQ_u_YkXSa5x7PtK8sYZ_p2P+GNcphq-bP-w@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:43 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 01:34:19PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:23 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 30, 2026 at 12:08:41PM +0300, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12=
:02 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrote:
> > > [...]
> > > > > > +static const struct of_device_id panel_dbi_of_match[] =3D {
> > > > > > +     { .compatible =3D "hit,tx10d07vm0baa", .data =3D (void *)=
PANEL_DBI_TX10D07VM0BAA },
> > > > > > +     { .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *)P=
ANEL_DBI_LH400WV3 },
> > > > >
> > > > > Why the detour through that PANEL_DB_* enum? You could just pass =
the
> > > > > panel funcs pointers directly via .data here.
> > > > >
> > > >
> > > > Passing API/OPS via .data is discouraged.
> > >
> > > No it's not. We do it all the time.
> > >
> >
> > I have had some controversial experience with MFD, with passing cell
> > composition. If DRM subsystem allows this, I am more then happy to
> > pass panel ops directly.
> >
> > > > > Also, looking at the enable/disable sequences these are in fact t=
wo
> > > > > different drivers, with the only commonality being that they happ=
en to
> > > > > be used in the same device. Rolling them both into one driver see=
ms a
> > > > > bit odd.
> > > >
> > > > I did this to simplify maintainance. Both panels are used in the LG
> > > > Optimus 2X. My assumption is that LG switched one to another at som=
e
> > > > point, hence they share same timings, controls and supplies, but
> > > > differ in en/disable sequence. Additionally, these are the the only
> > > > DBI Type B-only panels in the kernel, from what I can see.
> > >
> > > That's just one more reason to put them into more of a generic driver=
,
> > > which would allow people to find it and extend/improve it as needed.
> > >
> >
> > This driver cannot be "generic". Both panels don't fall into any
> > category of being "generic". They are grouped solely cause they share
> > same timings, controls and supplies (only these 2 panels, other will
> > definitely differ) and are used in the same device. I have no problems
> > in splitting them into 2 distinct drivers.
>
> The driver can still be mostly generic. And I suspect that the panels
> might have different names for the supplies and controls as well, they
> just happen to match in schematics or sources that you used as reference
> because they are for the same device.
>
> My point is, you can keep a lot of boilerplate in a generic DBI driver
> and then parameterize the things that aren't the same across them. That
> gives you the best of both worlds.
>
> The reason why I objected is that you have a very specific name for the
> driver file and the second panel doesn't match that at all, so it's
> confusing.
>

Noted. I will split them to remove confusion. I assume that schema can
remain common.

IMHO creating a generic DBI Type B panel driver does not wort it,
especially since these panels are more like non-simple DSI panels and
always require a dedicated en/disable sequence.

> Thierry
