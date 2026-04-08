Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E06F10F9968
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EE310E260;
	Wed,  8 Apr 2026 20:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="O5HGT3NX";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C0A10E6D9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 20:22:44 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-50d8e11b948so1744881cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1775679764; x=1776284564;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wBJw70mUEicNNB549MIpFjeIXaI1p71OdOWBzakHM6k=;
 b=O5HGT3NXP9cZHnO87D96d1W9ZiBwlE8xXr/TO2E4iNWYpoRd84FMvhN5xhI2L2Tisl
 YdWp/mlb9oXi82EOjFByQj2sZMgUvKSpxK8m+U2ow83vc4T9XTDYb9PfGp4W5nzgO0MK
 1cveHrPzUEjxDHiyiMu2Tg/NCOwYcaTx0e/ffCFE19WGruxk6kfWDwNAmQ9ule0lhmMI
 mpbNrEqipa5egl645LcrG20D5tEZXQa5QBGgJSlol3f5jYXQhbwkKadpHRUjTOBOITH2
 NgCeXgWGp8Ik31Ibz/GCatgotEXdfqSHVJszOIhjJjUrbQ0wkvToiLhpfQSZ3kTNNEJk
 bsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775679764; x=1776284564;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBJw70mUEicNNB549MIpFjeIXaI1p71OdOWBzakHM6k=;
 b=k0R2tAfKkRQIXqRTerCR/d1IZMqTgzx494Z4MBMFVZkamyDi1WuSTff5OpTZORe2tX
 7+mAnrdwBQRDU2ID+WHfDsm23/4cs8eTMBO/f/fOwQI51KmC0/Ge36XMCb3b1F9G8Urg
 bkXT55XEwwjnt/uPwoeSLEqxIgHsvECWs9MrRmvNslbMXg56XC7YNPQVY0za4IG3qrZH
 A2AmSlruWrZFBWBFNVfsOAbFO+Qwg743vfwnePU8hrBuDD5AwjokUrxUiGBByn7YkG+1
 o4RY81SNC2rJIxrU28f6QVqfqroAPtBHP/XuItI3qZgTC2Lto24K2xBT006nF1z+N1QY
 iXUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7BBsg5ITU7Tpv4oe7cRg0TlLB4e9xc0dNoq+XUSqQnvGxzr1IKG8teLa1VScoGwqYT0lkYLHGrsA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVzrJINV7klBTSrmBXgRxum38foYoikIeACJDstZtq0S2nPvZf
 2AzUlwp2DANvZ7dLzZMrph8Xa4TgXWAPe6mQMu6zrqpKYv6a1ZSVF1D8poU6/bu5Boc=
X-Gm-Gg: AeBDieuih4SSTN4Eg7o+EUBZjnYyO9skurUenpVxixu9QEnsziY8NKEwHvF5Z0DVjJt
 mR06kWBu2t2nh7CjKTPc8EOJvjgweBW6KJ+B0GTxLrMc1jbBgRibwLZ9/VaQhTz6WmBZ6GyrLHW
 eg5+cxK7iVMBFIjc5KvvGIyMSqxb3jhkT+u8evJPSrFu8jbY5AODdMbR0kiRYWlsLc0N+YplAui
 jC5snDzhQiUthqMNgoyx/NZ8F0JAP9TsfCDE62YMxXPFmVABMlTgV/knZq75UatrQpeHxJY2eW5
 gqgoxB/pSBduTBk1n67GMn0zGvE8brCDidZAFhJgeRUiv3sm3Znv718d9PmFCs8UfbssaWBFJn8
 FAH9Skyvz6oXw2XxQX8Lw42SiMLZFo0NkJsAEW0dsC+omWgfHb4/sR5zVYaTI1hycB3FZ4d6/O0
 MUfweWyVdGGfT+jU5wqlUAy2flP53V
X-Received: by 2002:a05:622a:1984:b0:50b:4ba4:9add with SMTP id
 d75a77b69052e-50d62a9ca10mr334496991cf.34.1775679763542; 
 Wed, 08 Apr 2026 13:22:43 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4aed181asm192301041cf.0.2026.04.08.13.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 13:22:42 -0700 (PDT)
Message-ID: <cd1de04076917d65ccd7dd91d9392af7977a4906.camel@ndufresne.ca>
Subject: Re: [PATCH v2 0/5] Migrate soc, drm-mediatek, mdp3 to new CMDQ APIs
 (series 2/4)
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jason-JH Lin <jason-jh.lin@mediatek.com>, Jassi Brar	
 <jassisinghbrar@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Nancy Lin	
 <nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Paul-PL
 Chen	 <paul-pl.chen@mediatek.com>, Moudy Ho <moudy.ho@mediatek.com>,
 Xiandong Wang	 <xiandong.wang@mediatek.com>, Sirius Wang
 <sirius.wang@mediatek.com>, Fei Shao	 <fshao@chromium.org>, Chen-yu Tsai
 <wenst@chromium.org>, 	Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-media@vger.kernel.org
Date: Wed, 08 Apr 2026 16:22:41 -0400
In-Reply-To: <20260325035836.2110757-1-jason-jh.lin@mediatek.com>
References: <20260325035836.2110757-1-jason-jh.lin@mediatek.com>
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
 protocol="application/pgp-signature"; boundary="=-RDSjhy/5yQt09mvK/09B"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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


--=-RDSjhy/5yQt09mvK/09B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 25 mars 2026 =C3=A0 11:57 +0800, Jason-JH Lin a =C3=A9crit=C2=
=A0:
> This series migrates the MediaTek SoC, DRM, and MDP3 drivers to the new
> CMDQ APIs introduced for MT8196.
>=20
> Series application order:
> =C2=A0 1. [Series V2 2/4] Migrate subsystems to new CMDQ APIs (this serie=
s)
> =C2=A0 2. [Series V2 3/4] Remove shift_pa from CMDQ jump functions
> =C2=A0 3. [Series V2 4/4] Remove deprecated CMDQ APIs
>=20
> Please apply this series after the MT8196 GCE support series,
> and before the following series.
>=20
> ---
>=20
> Change in v2:
> 1. Rebase on linux-next
> 2. Fix build error of -EINVAL in patch2.
>=20
> ---
>=20
> Jason-JH Lin (5):
> =C2=A0 soc: mediatek: Use pkt_write function pointer for subsys ID
> =C2=A0=C2=A0=C2=A0 compatibility
> =C2=A0 soc: mediatek: mtk-cmdq: Add cmdq_pkt_jump_rel_temp() for removing
> =C2=A0=C2=A0=C2=A0 shift_pa
> =C2=A0 drm/mediatek:Use reg_write function pointer for subsys ID
> =C2=A0=C2=A0=C2=A0 compatibility
> =C2=A0 media: platform: mtk-mdp3: Refactor CMDQ writes for CMDQ API chang=
e
> =C2=A0 media: platform: mtk-mdp3: Change cmdq_pkt_jump_rel() to
> =C2=A0=C2=A0=C2=A0 cmdq_pkt_jump_rel_temp()

Can the two last be applied to the media tree alone without breaking anythi=
ng ?
Otherwise I will need to wait for the soc: patches to have landed.

Nicolas

>=20
> =C2=A0drivers/gpu/drm/mediatek/mtk_ddp_comp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 12 +++++-----
> =C2=A0.../platform/mediatek/mdp3/mtk-mdp3-cmdq.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 6 ++---
> =C2=A0.../platform/mediatek/mdp3/mtk-mdp3-comp.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 6 ++---
> =C2=A0drivers/soc/mediatek/mtk-mmsys.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++---
> =C2=A0drivers/soc/mediatek/mtk-mutex.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++--
> =C2=A0include/linux/soc/mediatek/mtk-cmdq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 24 +++++++++++++++++++
> =C2=A06 files changed, 44 insertions(+), 17 deletions(-)

--=-RDSjhy/5yQt09mvK/09B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCada5EQAKCRDZQZRRKWBy
9BvDAQDiGnxs8IuI1dVJpXUEYd4nLqhHu0mrYWUd+Xo+VGU9BQD+M4bHsQCcq4KC
eU/cm+cZeMh1990/2+dj1+RYXPBBewk=
=HqBw
-----END PGP SIGNATURE-----

--=-RDSjhy/5yQt09mvK/09B--
