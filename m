Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB87606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=psVneav9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2E71121A4;
	Thu, 26 Nov 2026 12:50:37 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DEA112199
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:50:30 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3863db981d4so9828854eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 04:50:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795697430; cv=none;
 d=google.com; s=arc-20260327;
 b=sJQI0NcV3rW+M8sBcTr5prnN3A/Nf9kEjaJn1fTnkXm/Cap6c1UU/RxsYQmFcKHQXN
 gt2dyIXzOkD7U1zdEGRWpJ4JOtU9FM7a9xQU2vxDcxw4hjcVSFx244oGEuTdb2hmJ8Bu
 lelM9VkdezwG0z991SsuNInLBpGYwRk57G1Rw+mUyvwJRyjNd1u0+HV2flx19mPcL9WQ
 zOsUBMvdfN0cwaXEzWRMyLtxKrZezszU8ZT1/+jjXa4C/Ms4cs7KdSVoqbaVv5XxiflA
 SYyuFwG/Ipz+0c4r5TY5YH4Q/95o9CkFdrtzfBwjGenEg0DEa8gUIiXIYQIN24drcgvb
 Bkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ruYpKxR0jnfDu2Yt0vn3RyxCANQ3viM4x4RpbrQpd9M=;
 fh=yRrAZgMLsAKr29aotbHjyGHkMp4Ct/0fGRdUqmvgHq0=;
 b=SpNtQW01oqiSqZRHIPicupbNwax8J+rjwK23zntL/AFiSsjwRyQ+HLe3KtPLdc+ZDj
 DIH23FzuotPB1vhlSwNYeFhwmPc1soddHDasKYU5t4TYPoxA/So0PH8KG0wHOzD2Cgh6
 KfDCTn3Kzu3i4YtVrgdZSm9ewKpZCI4oXvMhO5fnfjvEEwMOER1w5HbDydAXj9fsanxp
 Cbgq6W1NoljnM8chiAqPZZkNITPeGtvE4b5lHFY1tjGjn0e2j71T3T1G0Gm0uklGk+KO
 Hjzv7N0sgbt1y1aRB5DPy24D8bieXsYhrEO3hrZsZoRdZj9CblMSF4wn9XkurRQp/abz
 hIog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795697430; x=1796302230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ruYpKxR0jnfDu2Yt0vn3RyxCANQ3viM4x4RpbrQpd9M=;
 b=psVneav9Unc4ymcKTXu4slGlLtb79tR/K3CnVtUff7IqEFArhlS83uHmdSUBe+dsUP
 fasaiBTXG40JXx7aU8j4UFn9pkCTR8Hv4PGX5MSGmKVo2tZ5zj/4KuglddtQkfY1ItsO
 VSZbffKVES7N8u0Kl7LYpVXlTYdqr8+WrYsWlaF8Uqi3leGSE3vTeZk83FrLdc8GCyVr
 fywZTHbUwpPjNCodJAKlhUC8GjFnotX2MWltvsn07XN1VmIJIeZLtoYmPO0I4gNGX2er
 1xCfl2YPjBHogG5dm8NtHWPP09Y9AGjXpe3ei7Q0FB/Xg2YrDwLktQx4Vatm9rVje8Vm
 xRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795697430; x=1796302230;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ruYpKxR0jnfDu2Yt0vn3RyxCANQ3viM4x4RpbrQpd9M=;
 b=CugTsJwlNaV4Vl0Ylan/mjGD0SE3OqBQsXnd73PH1fThidrRJKkGuDj1UKtfHrJVPv
 GhPcw2cZI/G+01BkgiAonNEOZmgSIvM3Rmo3RCH81ppcaEbSpU6HjeL1UvUNQjyiI7Or
 6ZFn+dvtVwgxxEAxk2WhaIGiUeh5YVQYR2eLH5BgCdp8UL5+Xa61BYOl1578tUCgydL0
 tPD5KWKK93mq3GS/ZjAYnH0BBBX/e+fRs7urMRDTkq8+XU6y7gADRIQvBYvxVibXbN+D
 Ud7cNh6xLX+1byAtRX4cphLqLrab+C3FaO7nswnCW9olX0fwbvnnhcQuXQPW7Ep+XU+J
 cTww==
X-Forwarded-Encrypted: i=1;
 AL+hErGCPmuT+gQIcoedLBn3LPBwq/6nK1J6UyGoeSMYeRZ2hJ8PLYaUo62SEXKsXiVkd/ACTPmYECkPxNo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/cw6aWU4TNJSz21jEsL4YyoaUNB1bJ2kN0k6R9MQjc8ASssmD+
 xuctpm+MEnLDQCuqpJqDJailwZz4V6jWYpvlkWQs2uCwM9bHwGXhpc10l0/5vS65YAUl5jeKzLR
 YUrR1RGG11UGJwmgJzVfp2sQK/eRU3ts=
X-Gm-Gg: AZFdTZcAAGW9QT11UxD461u4pwRkBUly3ryjndRqW5UlgDGhFFchcYUwMshJx3xlbRY
 pBgIsQq0OPwS/Y16hUavsQfcV+gOH1BHdbPYXaBawtMzIJJ9mynsu/6bjaEfXmsM0cervaGgL2f
 UTz0tBgpaRYCV1mh/76XHLC9EEENif8xdnFjw84Tz6OVew8MduEWVKIxHtDcbnrO3urhrL54+2K
 FiZy/zQQ/Hcn/S3PxyffhJdpIK+w2xIOEcRZFz01oXTg/ZbXc7Rdh+WX6NHf4iHwodPYDm5/ot9
 QFvYaoY8MCuw5VUGcUIE3LgW/cUnvAf4toRvf1GX9Jfs1AeAN7cSj2s9AphCpV34DfIQ5gKrO+k
 hjXfdWrYF79n37FxTlHh3P35Pc/XHtl4E/WgGomvQ+uDmKNne289iX/RdtFuXLtef4rQ68xxI/J
 l5wuGqb+ik1UT9FMizLBd6TR8Ho6wPCg==
X-Received: by 2002:a05:7301:4d18:b0:37d:bd4e:c378 with SMTP id
 5a478bee46e88-3857181d8ddmr20532737eec.41.1795697429793; Thu, 26 Nov 2026
 04:50:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115085826.89641-1-clamor95@gmail.com>
 <20261115085826.89641-5-clamor95@gmail.com>
 <20261126114728.GG38590@joneslee-macbookpro.roam.internal>
 <CAPVz0n138PXP88++q4QXiao-7=nzade=e_jAdfKK0_xsEyPtFg@mail.gmail.com>
 <20261126124719.GJ38590@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261126124719.GJ38590@joneslee-macbookpro.roam.internal>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 26 Nov 2026 14:50:18 +0200
X-Gm-Features: Aa3M54royAl1sABN4xJ1Cip7AOIlFSUkJQoKYmmC67r_RL_cs_moDjpaDX6PwaQ
Message-ID: <CAPVz0n1xgOqusgO23pXzZdaq0A-j0NyX2PvYPyzrzrqUfYM+3Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:4=
7 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 26 Nov 2026, Svyatoslav Ryhel wrote:
>
> > =D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
13:47 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
> > >
> > > > The AAT2870 supports a dedicated main power supply input alongside =
parent
> > > > power supply for its internal regulators.
> > > >
> > > > Add support for retrieving and managing these supply regulators
> > > > (vin-supply and in-ldo-supply) using the regulator framework to ens=
ure
> > > > proper power supply dependencies and power-up sequencing.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/mfd/aat2870-core.c            | 5 +++++
> > > >  drivers/regulator/aat2870-regulator.c | 1 +
> > >
> > > Is this a build dep?
> > >
> >
> > More a logical link, I can break it but it still will be part of this p=
atch set.
> >
> > > Would something that was working before, break?
> >
> > Other way, it was broken (aat2870 may have a dedicated supply) and now
> > it is fixed.
>
> Great.  Split it and Mark and I will take them into our own subsystems.
>
> Thanks.
>

Then pick first 3. I will send this as a follow-up

> --
> Lee Jones
