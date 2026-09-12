Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1763DC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E2C10E4E5;
	Sat, 12 Sep 2026 12:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="ATabx2ZC";
	dkim-atps=neutral
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EBE10E4E5
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789216567; bh=Lx85r0W+jeUnQMK0+dOI3OPVKtpzc7tM7ldROhGz60k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=ATabx2ZCp0gNiEXKoS6KMlEtR4jL8/aqJvJED33IcOrEiqZmRew12arSeASkPPKtumlkxXevWLld29Bs26eF08j2DSEyLhLg59ExxzaLF+XEO22yZE7znk8zyRSdwJcMzKqj+jFXO6JuHpu/r1S4dM55ePaCmsXc1XrDSBka8zDQFzZueAb4hiouomQBHSd/vgTdZApauWmiEskV2EoEzJgw6uIYROrfUB/BLdPa3v3FPx3gWsU/XY3ysrcFUTxHQaT2VEjZg4u3KQdZy2t2Yev0l5nY5LTj1uCXDxRHdcxm7fZTf5g9GIuJA9EiEYMhaN2tJFS3LQ5uuuMOQEudXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789216567; bh=ry73VeSW+sb35E3cGuVG0CuPK18vlamasKnoKEnS5nw=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=Kzgpk2Xp8B4JJ7SGyl4AjsygFYJVbiw6IOxRjXYq6PWSaqK09r4XwyJW2YYXsQEVP5DiJ7JLuRT3pPAC591QPAroWIf6qz2aHgzViy47xEDBOSF0QDtEp++RLdAkBYNipEQaLFQB9SRrHUqCzrYSTg4UpeibaX01fTpAv5GMMcUm6nym5bHD69l7BndqyV+wezeu4yg2SGX8zKL7DBJDH5ZLklznrJl9lB6RzupcKgWtKYJhwil5wRVmkUlqRgr9HYX4P8Kt+S1fQtyL7bqkPIj6wBrrtpmpAuvdDpCRH1xOyqsSUZ6oQ34fHBABial8W5avHzXHO4MibLOec24aXw==
X-YMail-OSG: z2Yz0KIVM1n9mmUwgGlVFNaVPcs.Z3LinkqcN_vpv6g.Ez3nXvQ8hVz9Swp6S2V
 LnehiZGrtVL16YXwinmvMrUwr76DaRGwzZkgZtRIILyLFkJAYvIEa8374yd_XTUG2pwO8lyCaiQq
 K2jvD4JEEuRnDxluTxJnOYObkwWiww62u3qvesjG7Q3UqinnijTaa5ld8gDWTwjyeM3EtvX52YZm
 H87fAgUvOaYTdOCGNvALybtBlpYWhnloMHd2mnh0BHVo7mXCyk9qeiP7sgD_Rn.rY_dxjHiyu7eu
 OIjfGC7v6Vj9.ErXB4tuFwSSWZCegg8tFJbzzHIZBniyVa5sY0KkG9XCIQh1uwzKA_jPYoQNztjw
 TS.ewQXIZ9Yugio5l6HEjmw5OGFAMJZWpPsHsRXeR1qfEjzVVRe8mnGva1VrJD0uBJBSHX_yTzVx
 PLbdjNaASFNLVJ8tHX3Y6Fp.st96KPj27gIFK2VKfVWrDlqmn9ckLaODUdUNhYKh5yVhym_R2d0a
 NcavPkcH3HTqd4YTJU2utdilyl7A932HuM5CyYKLxj49_dIAH3ODklMrTuTr0Q3DHy72kiCxBnOJ
 rI3inn9lOiVp.26E04XqNQZvaKf873rgffvl7mkIRtEXd7zUPonqykuHzH9pavsZjlasx93AS867
 .XjE1UfFgSCRfI.M4XMoVmxzEkly1ebOvxNkToa6A_8.vlYIBNVQT_8tNICkA4T0P9miolNfteQU
 oYgm9JWjEU0iwMegr_u87ZC4Lz5dmeGvtgfL4kc4u.A7qlD0EWeXo_JAPYq16ztFZXgnCRV20hlh
 8LacUw3xuKG7WzH36MGdSZm3i2rYumlE9HqHZHGMGQ19XyV8ki8wL4MryIdhQvRAaiLBdGJL_0EP
 qay2t4W5izCiaNKTmtwjtDEtVCiNQAGAKYmRkogxdCnvnOc6O_wZ.4CMJlx2lXfuJYkZz.N6X0LE
 GokfOcgKFu1LOg_3O6bDo8w6ZHQM1fEE5YWbyuAf2OHf4CPRCRIQ4qVRzzZAgUxLPFvoY_Vp9zv.
 w4GA1hKcfr.tPjMI9b8lstDrJkopX_gp07ZwUBo9NgOulX3W33cLIPe8qPrsL668lBHR1UOkdi1z
 9tV9tLkfPMXEKlReoT_e7uWOegV.SG7Y1bH.y6IM1WhZCrBjqagqIi811lxRqM1TDFDRuGsDCfMP
 uP0DLt_FC1aVbz5w3UUM9SogfseosF3bYeJu8PRtM8rDUXxiAeTE4MmA9XialT.7vNOxmuptCBuz
 bP6wLlyVo_SLxE58AiduKdXYOPrR.RkOd8jXUlPhwpUXLb6Z7JA8yWPmrZdKS.9mst3sb3UnMTTc
 aZ_huL1QTlT9qJZUy4_XsBD.eOrX5LHd5oIj4NTa.it4x.ibqRmIxdYCFTW1xXgY3iVlVtjCiIkZ
 0GxCPKdc3C1_geEsT2WkC__ThFrpnMZHSln7M2EGHViORiyUfagQalOSd28OC0V7CsqL1.iskC9J
 rZNqhKbqEDEf4Tr0POHbhWxCq9JNdoC6M6eeukvE4i8xk7okI7fOwY1M9NzFIJDkw4SgFYcMSufL
 KljuG4HawcX.SeFbuGtl7Vvjbb5fgmbYU9krvECon49wGu1jPuGA1qpgU9b5E7pHwQFws7w9Yj9G
 M1HxEZTNkZ0YsALtXHvTeTm74u3Dizi9YKtkzp2oOHY9l4ZoiZuxOIvbPULW9MqfKQDng32Nh0dJ
 zzdzmDWKvdGRQ7fu48JKGnLVlMNhzHRUyrRyQ_s0oIaY75mRXLESzvDuFXKfxwFv.U1Vc39nehNj
 .2Rk3hepl.iFGxrIJgZvN0kZd2CLM_q6s_JYgNOQWs5DueUhfD8P6H7fUSN_KxyWDQX_JLTIU0M6
 0a.cEVl2n590Tlnxn5FRxuYr4RtXIOyPx1RmzQJg9gpDZ.c9xeKiyBlXeucTo_ENTw7LCG51wgqp
 WV7E3s4ZDJdo1xo0EJyxlA23ffX2yrtt.KdO4hBBYkHzA_WSbO4jnpRz8A1PXbwYC27v7D9V6neU
 2i8XV.vd3BHRO_9ZKu0uUDtwFIAcEdrfmaJS.__QGVaJuSjBJMtsOy1xTStB9PVnuGXGsRop02hd
 mkO9slSrJX_X.GbN7eIl7r16wY.hC0P7MpyQtwsVi2UsTyYgEHIPfXC2DVOx9prTCUcWDv_tHqHL
 7GTHtcQMZnaRWl.qWZZv3Gv_kXwg.8kASvnnXVviU9oG6V1oR1JE2eOgSLJg63jYwAHIUrUJ0KS8
 xRCtkoScSqxNm4SnWJaDKvFsnRvN4HT46.w0y51GAwCRQUsoQQ5SdKfBntZACXvpA4oh3
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 3416b63d-630d-4d85-a3f5-ab7bb9b240c5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 12 Sep 2026 12:36:07 +0000
Received: by hermes--production-ir2-cddf86dcf-zlkgn (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 227c9617cdb3fdecd9416df7ccea6728; 
 Sat, 12 Sep 2026 12:36:03 +0000 (UTC)
Message-ID: <43b9f5782e43ef795a53976a3b15ee09c304ec1f.camel@aol.com>
Subject: Re: [PATCH] drm/gud: fix out-of-bounds write in
 gud_plane_atomic_check()
From: Ruben Wauters <rubenru09@aol.com>
To: Sajal Gupta <sajal2005gupta@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 noralf@tronnes.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sashiko	 <sashiko-bot@kernel.org>
Date: Sat, 12 Sep 2026 13:35:57 +0100
In-Reply-To: <20260902123254.36987-1-sajal2005gupta@gmail.com>
References: <20260902123254.36987-1-sajal2005gupta@gmail.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=mQINBGQqWbcBEADD5YXfvC27D1wjh1hOmjTjSwAFjQDGynLtrhBBZpJ+NBsfu++ffR7HF
 d/AaSJ+hqJni6HBNr/DMxWYMC8fOAr6zCSAX6fD2Rvy6rq6emuLaGOFkAIWDyuFWw40anlSCPZN+f
 fXTKJvARo45ZpC9PcfNu9/iRl/CpzSdiB5U4O2YtggXPWyOm9ev+bysmn6sjS1d+IZ7iTs9Ef0O4v
 I+1VFXvZMaY0YzG7EoYnKfeeUD7IGLpI4EEkNqLaU4onLN/qkXUwjT+YTw/VtTxNCmtTVFf57RAg2
 toscC85JjcrOeGSXdpP3J9CPdcIDMpOlnE//KuJIA3QMkckPQgnYtRw3ZhbiVxLNNJSUYm7PuRd9L
 LyObX7dpi0YfsUhxmD2+grw+Yvh2YlPWFybBDBgzRIcSMMSw0ertL64hBof06aVIlT8+TBf1Sq7O+
 obGYoXUi2q6qAuz+0y11spGk0YOffx4ChGPMQGGGaXGaCcjRMuJ050MF4dtwep/mSWH/p8EJtIKY8
 LfP/2c6G8leikMddtb+wKSNUuGYE6ctgcUtlltssRt74ls/ajYE00K52dlhCiaKxd2y0KpYEfWXPE
 pfiQ8yd/P/6fZCaOleY4k8Y2/JmlVUfwfVcVmb3mKWxKQXaHhT3cEvv8yuFDZgkTvZInINKtxxzly
 1i3TlY/nn5mwwARAQABtCFSdWJlbiBXYXV0ZXJzIDxydWJlbnJ1MDlAYW9sLmNvbT6JAlQEEwEIAD
 4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTehs0109D1XkJCLZjSflDAUK4M4QUCaPU
 lLgIZAQAKCRDSflDAUK4M4bK/D/wOugk+nS1PVpk5XkoSB3BXpW0yEuu55EjxXuFfN7mGdtRDq6kn
 WIunzqN9vb7qBFcfz1uG9OxEQpiEhGTW7aIkgCCDbyCk//bb2uRKRy7nVHA9E8p6Zya+974iY0+LV
 LkzIN/CgDavmljWIKQvyPL280KU9PjH2blbH5g6skwAc6MU9pCp6H5W00DYFjMW1j5NCBk5d6UDQ9
 OLukHTU5lHURNB4y0EMZg1eHRjqPk/bxXQA7dAz6BtMKhY+ZY8qDd8XC0sA6Zjsr5r8Os4/mDIn8I
 mzcpVNBKiLU0wpZ58TOUuB0s8wUwXZgwyAkG0sMDqasrQAHx5aVZUfb62p3DosMALacVjHrnW4Kwp
 rwfV9lKxfxPyDoGxtcwCAEdA58fG1FsqFqDxB/qkhyvF/4fzEtcOAHcgEAXR9W5G4PU6KInEidNX1
 1B9IuXRV+5NX6pQ0JAYN10WP7TI5SVzx1ebu6+bdLM0etdLU/0urUJjrnIgfQlRItq091/Qb5k4x5
 WTTeD0Y5Ko5/LSUX95R9z06ZffKWKqrl3QpZbAJrOI9PmDwbV8E5PNsIFE84+O2iqfF01j2rXaj+I
 dRhLIkp2jnabmNTFJtCy/N0Yrx16Gd8FnbOxZkbAER8F49MAm1JBQWoIPRbjRrXKJdkAtJr43RCkS
 VabceKfcvFR7bPf9z7QdcmVkMDMxMDAwIDxydWJlbnJ1MDlAYW9sLmNvbT6JAlEEEwEIADsCGwMFC
 wkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTehs0109D1XkJCLZjSflDAUK4M4QUCaPUlJwAKCR
 DSflDAUK4M4YOiD/0au/ik0WOM0fwVYY6+PQbU9QeHAJ5kuVesCNA57Zwhe2eAeLvAkmh67hmUzTK
 XD46kqeu81cRYG4WlECv2pYUaEkPni9vmpSMTPpmXvpkekaVNrX1qgBVSd2vfP1xG3QmuQXcGiWZw
 gzPDbN/rCjs4iUqwjDrUpnb1c5va2bTfsqATAUfz4MKobkt+NGlJ7wpTY/TE2noeT2Q8v4NWcNkbM
 MMDkACUut0kyzrgeLxu5u8AS2d5TnWHaZwi5hy8egbGTe2FW/fz8GT4ZgOEExshNt2vs2Ay7CGyhm
 v8SJfsvoUQFoIjAKfQ+KLrjCL3nT27Cl1g0Xj6c16f6qH0/ns9uym6SisNr6FzxN4RauMCQsHBeRZ
 qFhJ5WYXaBBziPfa46Jrdnd385KvsQ7V5cGitM6mBx4tDo3cN0jzYqosuBVrwyiOewklRLYrf0go0
 wh31YtoJXeJ0ObH65oHINmT2gqyaii5ZHe+avPwnKE03W5pHwenGCbgSnOndy5eGeamSD7AgwKw4V
 j5r2FeK8K7tU8rpONWu0pkDqq3tMVOcDguTPufXIBFgLDQy4OoC7dHoJRplg8ull5wMjI9ERR0oaP
 8IVIXxGcFRph02eKbZfqK51lMtns3kTe5DgHao5vrE+2GseLnEWE37cWnBQDhYgjwxIWtjGVp6KG7
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-AIYPRBPr3NqvjOzWOXo5"
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26525
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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


--=-AIYPRBPr3NqvjOzWOXo5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-02 at 18:00 +0530, Sajal Gupta wrote:
> The plane property loop uses req->properties[num_properties + i] as write
> index while simultaneously incrementing `num_properties` inside the loop.
> At iteration i, num_properties has also incremented by i, so the write
> is done at `initial_num_properties + 2*i`, skipping every other index and
> advancing by 2 per iteration.
>=20
> With just 2 connector and 32 plane properties the last write happens at
> index 64, one slot past the end of the 64-slot (indices 0=E2=80=9363)
> allocation. A USB device can trigger OOB by advertising the maximum
> number of properties.
>=20
> Fix by dropping the redundant `+ i`; num_properties is already the correc=
t
> running index, as gud_connector_fill_properties() fills the preceding
> slots.
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260821071812.16500-1-sajal2005gupt=
a%40gmail.com?part=3D1
> Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
Cc: <stable@vger.kernel.org>
Acked-by: Ruben Wauters <rubenru09@aol.com>

Sorry, for some reason I didn't receive this patch in my mailbox, only
by manually searching for patches did I find it, thanks for the patch.
> ---
>=20
> Verified with KASAN using a raw-gadget fake GUD device reporting 2
> connector properties and 32 plane properties:
>=20
>   BUG: KASAN: slab-out-of-bounds in gud_plane_atomic_check+0x1352/0x1ba0
>   Write of size 2 at addr ffff88800d029a9a by task temm/270
>=20
>   Call Trace:
>    <TASK>
>    kasan_report+0xfa/0x120
>    gud_plane_atomic_check+0x1352/0x1ba0
>    drm_atomic_helper_check_planes+0x2f2/0x9b0
>    drm_atomic_helper_check+0x72/0x140
>    drm_atomic_check_only+0x127b/0x3420
>    drm_atomic_commit+0x124/0x2e0
>    drm_atomic_helper_set_config+0xd9/0x130
>    drm_mode_setcrtc+0xcfd/0x1b20
>    drm_ioctl_kernel+0x167/0x2d0
>    drm_ioctl+0x53f/0xbe0
>    __x64_sys_ioctl+0x137/0x1c0
>    do_syscall_64+0xde/0x4b0
>    </TASK>
>=20
>   The buggy address is located 0 bytes to the right of
>   allocated 666-byte region [ffff88800d029800, ffff88800d029a9a)
>=20
>=20
>  drivers/gpu/drm/gud/gud_pipe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index 5ef887d8485a..54adc401bc1b 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -562,8 +562,8 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  			goto out;
>  		}
>=20
> -		req->properties[num_properties + i].prop =3D cpu_to_le16(prop);
> -		req->properties[num_properties + i].val =3D cpu_to_le64(val);
> +		req->properties[num_properties].prop =3D cpu_to_le16(prop);
> +		req->properties[num_properties].val =3D cpu_to_le64(val);
>  		num_properties++;
>  	}
>=20
> --
> 2.55.0

--=-AIYPRBPr3NqvjOzWOXo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqlRy0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhJSEQAIhALwsMzSm+ghvLzzEb
sFJDn2yAVoumSdo+mGeP60+kDmWIlz3C79apzRoL3trFn2qHnZAq2E5TjF199/a9
V9sqo457YxHvgZ7SFnvzEd8VIF5UJ698HQOltRomGMHwtv8SFC2oRH2dZZFKRYTk
RoXutTWfwGEsnjPlvjNH+DukBz5iYdlNIBipJXqyiXa7O+ARyw+uzbArqeFM7icj
z3ZQaZ7J6xfP10Tb7Dfd6RIFqwXLktAkXtplUz5xDDBZjxjVwsJpAJ4gPcIB1pRW
+dIr5yt1ynqtodSB9UmAs1R0AVbmZ9XTUAlQghk1N6I3dINsU1a+KWvydWh5kLFM
sYCNI/eyvup4IA9BnwRCNnqKnqeYrxwpUNOIvBFyhNf4nuGzzea+i08rDNLUwFfg
eKblr70NMzvYrgQkqGV6qK1UnFZ3SVm3modW3nq4nB0iqho6S7V702uGS3QrYoqw
6dJJ3kZsa+YcO89YKbeL7Erb+IYGbFcDAxlN+Em28LTz/557mc8VZGEA+zAfvC/l
7Ol4wU9wjqkepyam3MwHJKZoO8G2lcPiL6+RvIk7VhWjxnkpDeD2ZbswmoYY7P70
WBBecytV8dFKtfoy75z3mYl9oGF8qmKMVGZJnnYQEd5gYV7q3e7tPB3QmzFAotcq
qFHkspvYgT9cXpfALbM+uhlQ
=CaGy
-----END PGP SIGNATURE-----

--=-AIYPRBPr3NqvjOzWOXo5--
