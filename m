Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C78C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838F510E88E;
	Mon, 20 Jul 2026 10:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FFtH+tEV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A2210E88E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=dctkNF72TrooIIAdgjxkwyzxyJFMosXnCmp1ADq5SVw=; b=FFtH+tEV/wO//aXL49aZAcs/Hs
 Z54JWGvSn7+UWoBnZHqB92sPXYX8pys+TGaagwCiO30CsDUH6M1QAwrw25vzW4C1KXoX5/zi05Vi2
 rfFjfeQtsHdcUcaH7Xc1e5EV2iO0WLhzGBC551YUmZ1zTLrBMByng9E+MvsXtVM2u24PxmzpSEtbT
 P8C1KorKtXxaYr4FO1xmYT5caAPUtIOb/cVK1EAIdrI/Wxh1qMXe5g3PLgB/uyYl66a7Pay2DpKxg
 ZF/Nio59OUcBL7LOtosFJu17g+l4q/zGFDHS2d0VXlyxyThMSZ3JubCTXwUmrg1CMPXLPbQnsvvaq
 GIqDmY9A==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wllcF-000ygG-5M; Mon, 20 Jul 2026 12:52:55 +0200
Message-ID: <eb26958d59d331d3495687fb7c368e04163a3a25.camel@igalia.com>
Subject: Re: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling the
 clock on suspend
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Date: Mon, 20 Jul 2026 12:52:44 +0200
In-Reply-To: <4a933063-14da-4164-9422-3b110ddad675@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
 <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
 <c4b5bfd3a5fe8d4ee1d283b77db3530158bb3a17.camel@igalia.com>
 <4a933063-14da-4164-9422-3b110ddad675@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

El lun, 20-07-2026 a las 07:51 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 20/07/26 04:38, Iago Toral wrote:
> > Hi Ma=C3=ADra,
> >=20
> > I question below:
> >=20
> > (...)
> >=20
> > El s=C3=A1b, 18-07-2026 a las 10:44 -0300, Ma=C3=ADra Canal escribi=C3=
=B3:
> > > diff --git a/drivers/gpu/drm/v3d/v3d_power.c
> > > b/drivers/gpu/drm/v3d/v3d_power.c
> > > index ade8e932fb9c..f608e6d5516a 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_power.c
> > > +++ b/drivers/gpu/drm/v3d/v3d_power.c
> > > @@ -56,8 +56,15 @@ int v3d_power_suspend(struct device *dev)
> > > =C2=A0=20
> > > =C2=A0=C2=A0	v3d_clean_caches(v3d);
> > > =C2=A0=20
> > > +	/* Wait until V3D has no active or pending AXI
> > > transactions.
> > > */
> > > +	v3d_idle_axi(v3d, 0);
> > > +	v3d_idle_gca(v3d);
> >=20
> > Don't we need to do anything on the resume path for these?
>=20
> The documentation states that we don't need to re-enable the AXI
> transactions after a V3D reset/shutdown.

Great, thanks! for the series:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

>=20
> Best regards,
> - Ma=C3=ADra
>=20
> >=20
> > Iago
> >=20
> > > +
> > > =C2=A0=C2=A0	ret =3D v3d_suspend_sms(v3d);
> > > =C2=A0=C2=A0	if (ret) {
> > > +		/* Staying active: undo the GMP STOP_REQ from
> > > v3d_idle_axi(). */
> > > +		V3D_WRITE(V3D_GMP_CFG(v3d->ver),
> > > +			=C2=A0 V3D_READ(V3D_GMP_CFG(v3d->ver)) &
> > > ~V3D_GMP_CFG_STOP_REQ);
> > > =C2=A0=C2=A0		v3d_irq_enable(v3d);
> > > =C2=A0=C2=A0		return ret;
> > > =C2=A0=C2=A0	}
> > >=20
> >=20
>=20
>=20

