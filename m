Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E8CD98C6
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5103910EB06;
	Wed, 10 Jun 2026 16:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="YYPUc81H";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 781EC10EB06
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:57:17 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so77557705e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781110636; x=1781715436;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKc/9gHD6AG7EiLzZfBoaV//voVPGhzjPMsLXJoxjhg=;
 b=YYPUc81H5D06u/aBE/7x0teTiySX0av8IaTCGpUBmRF95OBdRDeuAb1AbbixYq0YMu
 1hrV2gGatpC+H0F1+7S6FeV5QtTAIugum3q2LP6uFcoRTJdVkEpH5P1KJWnDmDIJTxks
 TfFzJx9UH7Lqtakzjh3xPU3l87iKGXMBfCTL3T4Ny1rL91q90NUS+EjSPTrtd/dPP7ZY
 z1oxPZJQmEimgRchnyKT7EFYrl9z0sdJwb5QoX+DQDFRi5DVIsM8lO6dBHZ9CzKUT2NU
 AgdphC2kQGoMaaeX4iR/Ze5K8uGjmvdbcIWfggLI4vXfr/zc3SImsD8Ta246G9TLrVpK
 kOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110636; x=1781715436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKc/9gHD6AG7EiLzZfBoaV//voVPGhzjPMsLXJoxjhg=;
 b=RkxPFMHqLAhs3o97bgxK8OFyJuk/RQGl04EzrKbszEF/BY4YRDUA6Nd/Z+EC4j5yDb
 H5L1qyt8mtqRLWQQdAU8tGx2p1KYwU/GmKjuWuC9GpxbhgooXsZI5/YwjXM/vYmYugn2
 PJQvG1qTb3vuC00Y8yZNhBYtlpkQ4RTqejlkd7xuRdNfvl3kc6c23CYEmMmMurFLgTHL
 +G3htEJQiEQVTj5rVxdibuOYT4bbQTJzIVIKutPVuZfM6jYdNLrCClLjr8pvgoybaLcw
 hr+wbbrw7v1kBgD2dAciC702ATpoFK6o7kC1Dg0cANGEMxneMyuw+v33Gj6z66YOk45k
 3r8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Jg9eFV7alSS7jWUm1zloYLeF5IvgsS4v729HB3G+gT5RveYOx5tMDLNoVm7CyLl3iDL0gj31pYnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/TZPtSHDZC064vh6n50IghaZi4KECxcVsmoMyDbSqmyDkruV0
 zw76Z3eo+YSJAo5lp6LwaWblcpySFn/nUeM1lbE9ba+WQ7aGoqjI6paOJ+bcfCvooY4=
X-Gm-Gg: Acq92OG9mWpMq1Pz573N5NJy8x+pisv6cjiAs1bhN2Z73DierUOqe6WkI9XQcNCqNL7
 yHvNby9uogQ6Fi4iRfyBEx3aniwtSbOaJCpBt7uvqxA0iOp7EtqFUpCIy+YF7/UHDBQgtKJAy+j
 6C/iHSbL95qP/w+/Uk8zLqKNMkPKSnWcPuN/WsqyHZYI4gWEqMYoQk9XlMZg6n/Nlz1oBsKCtoR
 I0Frd1E8dOKAyrIJUQ89q0G/3nLp2z2qbHxh75tEm+r8zxy36NZE0vJ/8oMZA7KxoQ5qaeFUbRi
 JE11svuFaGnbxYANb37Q8wLwRVoc0SoJGoPs3a5WLscBnzn7jm7bpjVSO59fAeE1kVI8ae5NmV7
 vTJ+CxGZjM9nrND07HFj+JZH3b/DjAVUSATl+3C0sX2tDzOouqmxJixRPn8Ku4wCPHbsLOXC+0j
 bpQGj9GDjeKKm1F3RW6LFt4qhBoS80zZC4/NW+J6jZJbiNgeltE/aujb5isjBBWqT/w2oKQacqX
 Unk394BxmRrebPa58qPJmTOtw==
X-Received: by 2002:a05:600c:5246:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-490c25ff39amr412376905e9.27.1781110636075; 
 Wed, 10 Jun 2026 09:57:16 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490e2b2353bsm472115e9.10.2026.06.10.09.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:57:14 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:57:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jianmin Lv <lvjianmin@loongson.cn>, 
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
Message-ID: <aimXS-lR_Qpf0a5X@monoceros>
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2s72lnhithaooffd"
Content-Disposition: inline
In-Reply-To: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
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


--2s72lnhithaooffd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

On Mon, May 04, 2026 at 05:05:37PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using the PCI_DEVICE macro and named initializers is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Does someone feel responsible to pick up this patch? (Or give review
feedback?)

Best regards
Uwe

--2s72lnhithaooffd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopl2YACgkQj4D7WH0S
/k7mfwf/cI81prOW+yctb6KBDLo0GNXT+8e6M1DzvwtBjMUFyQkiO9E69Nj0fVip
jdfsHsFCbqoY9j/mPFG3LTQ/einC1A6UCiUftmuS+yd1RZkrobVsEGZNnvFD9EfB
U3IcQdTSV5Ek1pK6SGLhe5559INii1x4VFGtwBGm2kNEcpRkVlorH9KVXQMIYEAP
2NfPETMFdSDMvpILe/YuOu4fwjYSktGk84F8d51PLhuB93+n670Iq4004AYFBR7C
lnUZ9g8BaXK8Y4B/PmAn48Fom3SQaDu1lgYg/IKLel2s4z0poNpBipOjcqTNrw/t
52NdBnb1zyPcgvcMAhVzvDfkV9xHDA==
=3wRg
-----END PGP SIGNATURE-----

--2s72lnhithaooffd--
