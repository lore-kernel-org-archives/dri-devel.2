Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF7C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBED10E862;
	Wed, 19 Aug 2026 18:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="nY9SLc2E";
	dkim-atps=neutral
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com
 [74.125.231.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C2310E862
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:47:21 +0000 (UTC)
Received: by mail-oi2-f10.google.com with SMTP id
 46e09a7af769-7f3a9f626a1so435631a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1787165241; x=1787770041;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QSwrHGgl2AT1GasXRYkV9GR6hxZV3VVSWH3II1cAJck=;
 b=nY9SLc2Ei1AZZqPnkctAmdI4el1mHUvLYvBYcEP4chItGEGH4N6z5Lt8EQGnvb0jf2
 przcfJouXCdQLRs7qOgXzm6bf3ySJ0Xz5euwbXkUaDFVub1z31yTrrf1MiVYt5ynp6+l
 5TIx3nL6p9F7NHpckxJbJROW1X8WPvHWsGxTGxQx0l6rrETv0VqkIVBHNKj7aoZWTOns
 VGA2fx/gJAxBeakFtxhaE8JK3epuT1K0bvbCx5jBBJMj3H4eGN3P2QwrG0XGhsdVULW1
 FE6BbyGYIYknsa6/G8YfT3PqO3HNFKeNSJ/Ayyt7dBxLagYuY/Pt697V7Fg0Bpaydkdt
 /p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165241; x=1787770041;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSwrHGgl2AT1GasXRYkV9GR6hxZV3VVSWH3II1cAJck=;
 b=oRw2I7u6Vy9AqokdPWYC59gypFQyipadkF2J5RK6AamgIduE7DSGex0HE9G+T/0u0W
 MHZ0cLfOn3cSwl6JZ9HLuKLTNdh1w++IHNhR3IZW3U/CBmro8slgJVe3Kw9iyIvOem/C
 ViJCbHN/Ld+UMjuKkjUNuuk6zhqHckvfPCJ3imHg8uq2yRQPDQkLrqSi0YTy3eTWDYgW
 ZkJMLXJRrAbmBJt7kKST2On+9vpZOdQ8wFqAZ5UMukUkQf0mEyAs3YdaQqqVybLiX7jt
 JT+0y1JEpc6XR/HQNqz9geHAXTr/2YNQFM2ReOUC012wIihKZZC8Aog2PvJjfKyRjiaG
 AEgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdJTbxYH4RJCKjPY+idurWfYi/r2Y9klK1KJXWWH7+0igMpEvscyL+LmGfGjjhv8MCaZjFOPvpD7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7uH+L/qHbOYTqVnA0T8dw0CW17Ev503haUJOOFvZ2DqEDiE/L
 54EIM0YLYeXhaByWlZfcpGrtVNizopMZl2Is1H4Tnq0cfdDKvKSiJwFgU4QyXeCF8F8=
X-Gm-Gg: AR+sD12S0IPEuMZ8tYZLZgpMFLidns+D+oFC33RRV3IfQ/gBsbrLVNal/xC95xC7HFb
 5aje+/pAhOFoMUeZLk5X3Pz7g08ik9M/NTp1N0WrqM6YrrSM83OLuzSbE06YJx8C+DdkHgCEuEG
 mAF2BG76aF3FQPsMG5Gdexoer8ehueggGL7LJ/2wKl8ZW26UFSMCEr+csQXxYLvJjkcoxnpZOp2
 5j0uXamlGsR4Xo9BE/XYg0ohyZfrktCokbNTXXnQrnTfx00FtYoM3pRt+w/IjTP5vygpZ3A7teM
 DzZvBXgv7Kfu0y0FrDx0vurapXay9d04zAKfsZTIFaRtAK8WnT0vtlnogOXKXSIu5wuqcrn1d6Z
 52uTuhQunsWAevfA9v4rUoWjLL2TychqVEiiolMi/R1C95dhImxSTUsupqJgiu/mY7rZAJ8CvCB
 zCkMimt63TkfX6vRrq7J/y0RdLYJNGn6zrI2BEHpXJbzat9MRP/dd2KrLusRK4037cucmjhNE4V
 hk=
X-Received: by 2002:a05:6830:6d17:b0:7e9:adef:4fd4 with SMTP id
 46e09a7af769-7f43fa916b2mr7494544a34.11.1787165240632; 
 Wed, 19 Aug 2026 11:47:20 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::c41? ([2606:6d00:15:e221::c41])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f440023019sm2466411a34.15.2026.08.19.11.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:47:19 -0700 (PDT)
Message-ID: <41ce17bc5d62c2d2a1fb820fa9d4ffb89d20a672.camel@ndufresne.ca>
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jonas Karlman <jonas@kwiboo.se>, Igor Paunovic <royalnet026@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>, 
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, 	linux-rockchip@lists.infradead.org
Date: Wed, 19 Aug 2026 14:47:17 -0400
In-Reply-To: <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
 <20260818072936.41844-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <20260819055324.33669-1-royalnet026@gmail.com>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-BonzMBfzDgbeskESyC4p"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
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


--=-BonzMBfzDgbeskESyC4p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 19 ao=C3=BBt 2026 =C3=A0 11:40 +0200, Jonas Karlman a =C3=A9cri=
t=C2=A0:
> Hi Igor,
>=20
> On 8/19/2026 7:52 AM, Igor Paunovic wrote:
> > Hi Jonas,
> >=20
> > On 8/18/2026 2:30 PM, Jonas Karlman wrote:
> > > Looking closer at my old commits, it was the PCLK_GPU_ROOT that was
> > > needed for e.g. RK3576 and RK3528. This clock is not described in RK3=
588
> > > clock tree so it never gets disabled by Linux clock framework.
> > >=20
> > > I suspect similarly one of the NPU root clocks is what drives the NPU
> > > PVTPLL and thus always must be kept enabled when PVTPLL mode is used.
> >=20
> > Thank you - the PCLK_GPU_ROOT observation was the missing piece. I went
> > through the firmware my board actually runs and can now name the clock
> > for the NPU case.
> >=20
> > First a correction to what I told Nicolas earlier: my BL31 is not the
> > vendor blob. The boot banner reports v2.12.0-9-gd5c68fd92, which is the
> > edk2-rk3588 project's TF-A branch: upstream v2.12.0 plus nine feature
> > commits (SCMI voltage domain, eMMC clock, TRNG, ...). The only one of
> > those touching rk3588_clk.c adds an eMMC clock; the NPU set_rate/PVTPLL
> > path is unmodified mainline v2.12. So Nicolas and I are effectively
> > running the same clock code, and the firmware-difference caveat from my
> > earlier mail mostly evaporates.
> >=20
> > What clk_npu_set_rate() in plat/rockchip/rk3588/drivers/scmi/rk3588_clk=
.c
> > does:
> >=20
> > - The rate table gives every OPP from 300 MHz up a ring length > 0, so
> >   they all take the PVTPLL path; 200 MHz has length 0 and takes the
> >   normal GPLL divider path. The 200 MHz suspend rate we both converged
> >   on is therefore safe by construction on this SoC.
> >=20
> > - For a PVTPLL rate the firmware programs ring_sel/length/calibration
> >   (cal cnt =3D 24, T =3D 1 us, i.e. a 24 MHz reference) into NPU GRF at
> >   0xfd5a2000 (NPU_PVTPLL_CON0..2), and only then flips the mux in CRU
> >   CLKSEL_CON(74) to the PVTPLL path.
> >=20
> > The Linux side is where the NPU differs from your GPU case: the NPU
> > root clocks are fully described in clk-rk3588.c. pclk_npu_root is a
> > gateable composite (CLKGATE_CON(29) bit 4) and NPU GRF hangs off it
> > (pclk_npu_grf, CLK_IGNORE_UNUSED). In the mainline DT only core 0
> > (fdab0000) requests PCLK_NPU_ROOT as its "pclk"; cores 1/2 only hold
> > their aclk/hclk. So whenever core 0 is runtime-suspended, pclk_npu_root
> > has no user left and gets gated.
> >=20
> > An SCMI set_rate to a PVTPLL rate issued in that state programs a GRF
> > whose bus clock is off, while the mux write still lands because the CRU
> > is always clocked - leaving clk_npu_dsu0 parked on a ring that was
> > never configured. That matches the empirical failure in my RFC exactly:
> > the sysfs min_freq write while suspended, followed by the power-domain
> > power-on ack timeout. (I have not put a scope on the APB bus, so "the
> > GRF write cannot land" is inferred from the failure signature plus the
> > gate state, not observed directly.)
>=20
> Ideally the SCMI firmware code should probably be updated to ensure any
> required root clock is ungated, and possible also hide some related
> clocks from OS. I am not even sure this is feasible option and this may
> diverge too much from vendor blobs and may not be backward compatible.
>=20
> >=20
> > For the series this reinforces the hold-all guard: resuming all cores -
> > core 0 in particular - around every rate change keeps pclk_npu_root
> > enabled for the duration of the SCMI call, closing the window for the
> > sysfs, governor and cooling paths alike. Your .config_clks() +
> > pm_runtime_suspended() check covers the OPP-initiated paths; I will
> > reference it and your branch in the cover letter.
>=20
> I played around with Nicolas patches and created a more updated
> config_clks() variant that tries to use the clocks configured for opp
> instead of keeping track of the clock, see [2]. Have not done any
> runtime testing of that, but wanted to share the link anyway :-)
>=20
> If I remember correctly for the GPU path on RK3576, keeping the 'bus'
> clock enabled at all times helped ensure any root clock was enabled
> while GRF is accessed. I cannot remember that I had any issues with GPU
> GRF access for PD and sysfs governor paths. The config_clks() helped
> ensure set_rate never was called during GPU probe or when governor was
> changed. Maybe I missed testing some other paths :-)
>=20
> [2] https://github.com/Kwiboo/linux-rockchip/commits/next-20260803-rk-hdm=
i-v6/

This looks like one of many hacks down, I'll make sure to test and integrat=
e
that.

cheers,
Nicolas

>=20
> >=20
> > One open point where your GPU experience may help: besides the GRF
> > programming interface, do you know whether the ring/monitor logic also
> > depends on hclk_npu_root, or is the 24 MHz calibration reference
> > (xin24m, always on) the only other input? If you never had to find out,
> > I will determine it empirically by holding only pclk and cycling rates.
>=20
> I do not know, and never looked too deep into it, with the root clk
> enabled everything seemed to work great, so I was happy enough with that
> and just moved on to next thing :-)
>=20
> Regards,
> Jonas
>=20
> >=20
> > Regards,
> > Igor

--=-BonzMBfzDgbeskESyC4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaoX6NQAKCRDZQZRRKWBy
9LyVAP47C2FSx0QcA5CyoG+DF+6pVuAUKKTgxac0gHmccFpXZAEAgpv4oEEnibPG
Z9h4UhoOl1Pc1NoDcvVGE6EeBqYNDA8=
=/Ev9
-----END PGP SIGNATURE-----

--=-BonzMBfzDgbeskESyC4p--
