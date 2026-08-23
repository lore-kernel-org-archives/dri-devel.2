Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA82C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0404310E048;
	Sun, 23 Aug 2026 16:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="RFYOzHLP";
	dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D64110E048
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787502826; bh=sinYjZisod9mWYzD4X6OTROm+a4ISnrR/8dvVGQYeN0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=RFYOzHLPhQO1qbJVSOSfBqr1x6YAEw+v+F6zP/tKcx8efVY29flNzruBiK9zv+TTD3ylCtTbm3DUbgJ83xKEzQqkzc/+7Yf1TTYWMtY5u7QzznB7dH/gFeApCBUyiriXqaTnYPKh+fpfEGDcPZ3dm9QXW7/XfSqkUlkNrbx/mr7Uq993APsY6TpMp9KmBm5kJug3t3Rw+TuJ+iadWFwUODl/4PkdtKjb2guHTO3taH0/dWH9RPpyuhrqkIDOCWzQPMb03Xrdu0xq8cAD+wVPWPqxAPJKyiAMN60wFQP2jkuA8j9yCygjCvUDR0m1FeOrEbjyVnHInWWIIwQfWxoUAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787502826; bh=oO6SYN4u7Vvk9HH+R20RUA1+6uk4LzXcksbmkhG4pWh=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=DFpNRi7O4PCv0aajypCR5M+blTeSOjq66Tgb7FfA5/NxUfFbamPTtpCBwYatF+92Ii3Lu93bLlxv0NZrUuRo2xDZcuEW2mD6pJMPMDIaEFcvIMNE1XxIMmYI0Du/08sCK2WU0g3uJyK+L3Ylt4AC5B+FNp5HoBG60VlRan+5oxk2hhKsusBG3hJmgAiOPFSQZTknyferDY0VB6jXx33g1pms6wkQ6b3PhvrXGfI8cskArcRvqJ6APusUvSAEcIt+Z0wW0d0j+68TZnTjrbGUkl7ZJzL0ZIisw8woCJ5DD2hVbS+Jul02BkALxO+Y2ltGCLuDybMGefpIGYxUneh5LA==
X-YMail-OSG: 3Qrtl_8VM1mxpuId5b91pABVMhpw7.697axo4ODlxC0GC0FGFjHzHIcOVnqnr0k
 j8o2uXUSW722I8gzajyDHgS7KftX6sgPU9dZ2k0nrjg9h6T.GxP1qZljvxgv9..SZqul.IAmim9Y
 2KXbfpclncacfixFZvOjZ6jmyy4YU_92O3J9AllXR0wCVp1pRWvbrcucod3fdDtLUkohowjxRQpG
 sLhxuVFK..7hrrokHnB.PhnIpzZhOVb4Hq4DMjo7MB8A5vREqELXgMrzaw7NiEQ7R6_lJ3CN_Ez_
 mg4R5RfzYFoosYJx8_j27SH2IIrE0JmED.AORcX6oL0mf99FIOeDdnCPzN1pVJyX4l7XnCGAQ5EF
 FNx63nfknmzKOiL2ZVSv.rmYV_fKDjRQ5jmO0xoztspwVG.wESFSiOvNTZvl67SP6e9ew5nKmE9P
 tRsYg_qHIR05IvsF18JFu9ew68Oyp0UM_T6Pra85GS9rp5Wn3fdQzUmU3aBBUBZdKTY5fwP9JiS4
 B7UG4ua9N5LUr19o9VvG0c1xPcl5HpXMg9PrvbJLXrgtnYKk4JdH6Fr5M6w7B2LPkNYz6O1PzPFN
 CwwtWvpE3HawfEo79xo9uvzSZKKGaNmJnSJQLizmb0B_uHtbfUtVuTFpqz3Y42d8QDcy8tNYoWfp
 WxFwIRw_xzp63QkleYNR21ppkf10lKbqeq.XSQ3DAiI6CYL7eJAhjgsPo1LYU9TjqTBPHBAXE.Ng
 5iYrpcMtmNqWq8UBJAjf4oBDDoaNdXix1sFl.9bPqZdFg_kwaj00geFeVKdW2MqkE041gNHZ0Ksa
 FxkwQ8.qCyPeBI0Cs1IigG8Je9Ycs30bMjy5CEBGH4FVE.g6Tol75yavY29Ov9HVtDArj24QkzVj
 tgXhXV_Ere.IP5MW.ibrW4eC7iD7NzBQ0KZSQQ4ZujpQt79r59XhOPeb7FOv2NBZ28yjr217wHUt
 bIDR55_tdjeMyH3wBX_iGJjHwCXBoX.7YZuF.YCOspNtNLtIZCAhnAbBFJ1I6fierU4gdsmAtO2z
 d6pTKFKP7cbEPxQgOCtY3_NqcBDyqxfOA3kI8TQ5PBhV9smewATi2UvvKfeg9sKFLULhDy1Ed4jB
 yC4_fU4P4JT_tICxm5OJ_a1y7HYq3g4MkdBfCK3EtO9zT89DRuEmthcOvEXM.gy_19nCXHlJ_7lR
 euAR3hUQIQigs15tYZvEoXA6KGatUunj8ApYaIkSS9.j_yagGQDfjbsZVHQAoVVj1CZA_B_5mqy3
 w4lY8ZjrJU7k6X_zNdOntOLOdLhc1WA8O1fsr15MHiNleoepNRWJDM4ZV1n9ftakYyRYehSp10Hd
 uSiV.EfV1wb5YtxuKpMUi7wt7IVAFl2ZuVur2DhubNc0Xu0iIVlIbrJZtUx5HzM7AmFo.0NJI8JU
 Duzcwtk1_u5ziSl7QQfYWpdOGDa1vqLOffNZJZHjwizCwuylndnlnH3ql3Ea1TU7BxrSm0eSpYsK
 WzOLZbYSNgnYcf6BBzsD_zrg2fWRnkPI.7HKVRZYo9RJCX7U9NwMCPJ7GIes3Qy_un_r0fdJeoXL
 qenlEMdxVg5smOIHRFGEoi9Qa.4fQ1dHM_mnCr4SwKSOUF2mYckM6o2lF1PaQAi5IrTMuooXHnrW
 slruWtsgkczmtksWcTrGNEm_3L9eYdNF96mE5P0_GipL3G90Kyw1t5fBdM1fVP.9NZ.kldZ6ME4q
 zlsWe.skp.3SNGIRDV6tA7hiQxXRQ3dguSCyMSWoH9bmVPz1Jwf3__8Z3qx_0FE5FB986wwZc34g
 wgW3m9UDTYoISYAofh.M_YHGdpVVEO1C6hEhAKiugtagan2.RLbO0gKJLgiWndUKSANbJlU7FuME
 vwJaYHPJPpinoSvyIhleB.eDP_8zYJoW39DxAuDTJDNkNGsUBD8K26tPjP_rEsIup9A76UmJ8S6a
 KO_X3qcO4P_3mszebFGNWjRT1wzGVRT3qcAusjoA1cJslWk5BgRLXjxqRf0sqcCkUV9Jm.y4pUCh
 mZhCFclbJ0t.2OhzbfmYk1SujbHEe8hDvGoKnxcXs4u1lPl8IKowoHbJS6I4BXRq_ZKfUNO1XtvA
 GSWPzVUiIGU6vHcNEFg_JcCqz07mmbWoTw1xxQoYo7DiyJmLLZ2GgherU4AH6ZDB2gYhxiY2.lkj
 LLi2o65XyCpMXKjJShZrQ67LDoroKwtV3ydNe9x5x1R1bCObjdPCfdflip0jD_sJ2XXw1CGmxt23
 BwmLP4WLjQF5mi2600k2f9izLVHPpnbF9USqBethkkKtreEIjiLXSCXq0TT7xT.2a.84ROf_uc1E
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 614c7083-4efa-484c-b466-2df93b7525c7
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 23 Aug 2026 16:33:46 +0000
Received: by hermes--production-ir2-cddf86dcf-9r6zx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a2bcbc9fccd52fe4d5a10437f8cc3d6a; 
 Sun, 23 Aug 2026 16:33:42 +0000 (UTC)
Message-ID: <1eb28694bc5fd70efe32b00a5519e82086a79b89.camel@aol.com>
Subject: Re: [PATCH] drm/gud: validate GUD_ROTATION_0 is present in
 supported rotations
From: Ruben Wauters <rubenru09@aol.com>
To: Sajal Gupta <sajal2005gupta@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, 
 syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
Date: Sun, 23 Aug 2026 17:33:35 +0100
In-Reply-To: <20260821071812.16500-1-sajal2005gupta@gmail.com>
References: <20260821071812.16500-1-sajal2005gupta@gmail.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-yU06Pes14ILQgBR/pQxv"
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26380
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


--=-yU06Pes14ILQgBR/pQxv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 12:46 +0530, Sajal Gupta wrote:
> The rotation argument to drm_plane_create_rotation_property() is set to
> DRM_MODE_ROTATE_0, and the device reported rotation bitmask is used as
> the supported_rotations argument. The driver never validates that
> GUD_ROTATION_0 is present, so a device that omits it from its
> GUD_PROPERTY_ROTATION triggers the
> WARN_ON(rotation & ~supported_rotations) in
> drm_plane_create_rotation_property()
>=20
> Fix this by skipping the creation of rotation property if the device
> doesn't have the GUD_ROTATION_0 bit

Hello, Thank you for the patch
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Reported-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Defe2810681f1b065d3a8
> Tested-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
> Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
Acked-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/gpu/drm/gud/gud_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.=
c
> index 89bd6ca36003..3a1b9e2a2eaa 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -289,6 +289,8 @@ static int gud_plane_add_properties(struct gud_device=
 *gdrm)
>  			 * but mask out any additions on future devices.
>  			 */
>  			val &=3D GUD_ROTATION_MASK;
> +			if (!(val & GUD_ROTATION_0))
> +				continue;
>  			ret =3D drm_plane_create_rotation_property(&gdrm->plane,
>  								 DRM_MODE_ROTATE_0, val);
>  			break;
> --
> 2.55.0

--=-yU06Pes14ILQgBR/pQxv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqLIN8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhdsQP/iFITCkNCJ7BMhf2/Y1f
fdiQgOY3wSVFCVFFA7Td6+F4ICZ92w1jzZc8JTqyHOHoR9tui9DgnKaqyKzO7sve
LlFHXop4l68+W5SxDLyfkki5hb1fyns2Z2496Dn+/+z/HnIVS69WzdgM8uWT3n6K
DYMeqhDQWTpbMYxPRuakjvGmYQuN+wwN7zN3VkK32OyMYx4qO2vO3CyUVtJPq2YN
afLq4rENSHdhFuZCuTY+bsnKxnczt4l21hh3vQf/aiq/EGo6AzSH3Zf03HvA6bro
hwTTuKCorkDXe6jasmln1tNLNAkKjMKHNtQym691kWf7WXcokLyWj3Yz4ypt/tS3
R1g1xuYi8H8pqsq9EcwjKceciJbAHoQRt1NaaRZwg0ZLfGWFFu3uA4FTcKivWkJ1
+hIHnY/uMpSrtE3UIEZ4JM20MI+IHa4ENYTuznkjU/Syjhw4ycuMz5fyXtvd/UGz
6t7s1CXaYuyEV5SecYh/J41tJ7DrkAtgYpsk7WLobTjCdkTyILAUwjS0icYbDaPf
j6a2/0JmM1AsWDwaUwciFT1qR3FBPVlB0kZA6EGF2rViqrWzQ38z2bCjujiup6A8
azebC+ge9KMzJTW8hb7CnvsjP7XuDx89psgt8wuMep8Fxt/3nnjUPsNj0x85YmmV
5ITn0T2ZUAeWcTHi/fhdJm4e
=dH6j
-----END PGP SIGNATURE-----

--=-yU06Pes14ILQgBR/pQxv--
