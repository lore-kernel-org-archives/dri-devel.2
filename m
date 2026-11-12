Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8F606A882
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=b6eXUSF+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0FD10E0A0;
	Thu, 12 Nov 2026 04:53:24 +0000 (UTC)
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF9410E0A0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 04:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1794459197; bh=rmmtZEiiYCjEz5YeMfpxLJ53oSEMI3p25+n3xrKUbEI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:From:Subject:Reply-To:Content-Type;
 b=b6eXUSF+DOnkD07t6G+IhhKqFMPXfe7Bn4n6uKxf6eKo5tbW43/LJGDCsExZJXqVRKjazi10ZfE+t9VWgKQC936WhosQkfI6sYhYG+jaXOuN2Ya5BqPZaZ+lIAOlmhFgKIy0CNdBR02IShJS0nZiUR9GVjhaE2CWAOc3lRckzRx+eIuju0wz537zpy86fWkDDA5H6jzcWJQn4jJ0RrWiVhRlylTSOrR8/HrVAdhz2Jqg/IR42k8P9exjgAMy/oB6lB2vkQonBlF+7tEFMQwl5OlfS+P0oU1GK2MbcPPSQGVt4+SRaY1U3T0rrgeyX5sA7yaIhXHCUObqHlEbGswJ5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794459197; bh=stuDFiBLF0wo2DBcID3z9UaRdVfh913ihRbRtZa4dE3=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=IfpW5IizBSS35ZvYsptK7hQlLPx6q2t+C/HOYp/X+T65TEzv6nz1Ez1PuNxZ3+xIO5J3sWobsHgtv4EOhdlL/3LCMd+fqzJO5l7QVMOJEf/GU7FAzgUHC2DrKB0xZfQjqKkJh5AMD7ha+vJgboLcfB/A/e1+PbUzb4xt9IxgqNG/YyFV0J5+sfVXWovD8dqr8uMM4lySK3k15+OjqmAuT38QnSLmBLEHP7lF7tQ37CHGK4EkZorD8Xa2xM7aQ81u5nXNSRc4LlI0rgXfInc2ogaoUPliB/cZhoevA9fzLv8ttmN1OAhsjrP5E2UMLeuJJNG1mAn54aQE1y7t2oUYrg==
X-YMail-OSG: xqUA4lUVM1lKepWEmblRjXaddiS_EqxwTiFlTyi6tfxTS9qJ3BlYKBldaHwL9Zu
 1Vl_Tp0lPhviZ4UO54epOFTzkWS1nCE4nqRtigvh4ClKSIPjtvK01lb6nnQCbUgygLUA1ao6hXnB
 oAPfKcmQhiGx_pBJ_uDlGNcBFOlznYs8PRwEsgeWs9LcFh9NtcrERIygDeivxwE5QMC.H26PylAc
 jvd7vfDq2LSqN3yBHyTg3svdXKghB09wOUnIJlkZUcXFiHTn9GC7pTAw0GgSr.fqPY.Ifd9ZyTU.
 Z.DXrYTHq1N5KKffITjEZXboAzZbOCoj27ylhXOS.RMbeTQIDmPHKU96Eo5eSJ8sjW27BF9h.V0L
 EIXZmYSh33tdcRoQEJ2wzm1Oaww6CLrtyb9PHPoFJay2AlBm3DAPPgRfWlAxTm6fay9ohvPuGAMx
 3bkLrSjHBHM.nIzBclPkoAAnVOMnLqNYwdwvLEQA9USWsj5AXMia7sDF0OLkx9vf4mB64V9Mkd4C
 uPU2fae7RbCwTWlLTldnKT70vk3d_GCmGlFjVWkNguVF02RBXMpyVvWC5qBz3Goq.X_sY6Auc9Ex
 yztjISSV5E0MdpQWfgTTysQaUSZeRfHSV6zzUUOClVLX3y5U9jkSZmJohEc1IYx4jGqNfwkHFpPO
 g1spaO.bd_ORas4WNPalW4LjVGvzhlBUwP8VprKhhMEf3dRO8LQPL9argTv2lbnjPtuswNxvO1y4
 UESnXl7T5z4aZLAbEeEBi9NBsbsZn1uJ1Cq_S9zIvKhtaGm4VEJGv6n2KVYfYQ_TVjB9Y85ZhvpP
 j6gVmCYZZYsi.tKYZmw.FXzxHnDE1w9NW_TiR2KlKnA4TylKGd7ptTStXm45TegeLi8X.3..bCfD
 5SM59hMyNGUWAcFYz23mVv0B3EdFmPDVG.ULEo9HzSGNy9GkdFOsVuo8lBP8ZKHtex1rS4V2iokB
 GcfIfssBxtjwn5lUxn53Tnm2Y3aovTgtqfe_xxWzKyLhCKyn5f_abJu96tpZ5TBOgRynwnzV1XJu
 KRwxkg7ip9ucymhk.af_hOv0taAn.mHlLnOtBcC3GdhZ0GnEWpB96pUlBpM6kzJf9SVDGQxW11Od
 104.V8HfPpQ3v9MK2Quzdcxoxm97I3FTUzWq85bTG2raSXINPNXmSUpptLX5ekPNCQ.tppF4RueN
 .Br4c9J1_MuzTFmMnt.P2UViTT23yeWhImcKd1g02upz.lOaliV3SlrmiogZHUQqWKGUPA9CGfhP
 Uto8ZwSAlDzoATxCEc6aBtmcdOGrg0MPB9NwrIbTmJiHtqBeUCGbXRi0KP5SiIXBLdLMovY94W2A
 RSnROeeE0.Drjc.uStPrQ_s__YJhPv0GpJxEosPWHGW0.7U5YTxSYItBo_JQpyJ9Ds36yt7E7aU8
 JcsQEBMCI5mdbpGNKO7Y5uo8podx.KYL0pYO5plYkJEkJWbRXNkcDuOcP2LzXIidSAKhG2UY04KI
 NMAIruqhtkY_70jOdVOLDdxi6Dqm8eb8PrRfkBXZBfjMbHMzUVjHVn54Fo5XAqDpC_FhwQ51R8tI
 jeq8HB9Wzvpg8.jq01liiJ4nHWiCcISFJKJaHLiv_0.NI_zhXVcmFU1lKOQGzixxYJXHZu2txCvs
 BKCBFEVY33OOmDCwt01G8lVvUVChtCFDE76PV5OJ0Rcz5MaP5dL8MmLauV4TciaVgmrpRQ27gBJx
 iMPnENXVpo7zXndQcy2bBVjXhwrj03a4Xf553zr2d_WdxUjKBI0Hw2IhM36yxj8u4PurCGMKfNn_
 dWjxSRaaCM1xkN52s1gJEUV7SHhDVU8HIdPy1kGs_awUcCn70Bx9GGFNiPV1wh1Z9gSLrKJDzH1q
 bZ8oC2TWR4PTXJRP4O78iCM6fVlBdMgNMPrm6rSdHZqO52ufLQ0xh4_hxILS_K3.TEMQVuXZOuZf
 RF6Lsuc6RA.Si_HPyNfmoGindpHOZOXa76X9X7LX9sIKOp1fzP.oWAr18lmNB0GsKcPsj_NxZ7hs
 tbN51xdojZ5rYv1nH3xqMYjtNyQ3eUZiG45F.HmIhpc5TNjNP59WEQo47gar3tpE.mFHrmbWPq9V
 RVMhTrqTkA3H_2ehmo9pu9wXXEccWL_7Rt5QfBzX3SpnPFdX5D2DtdPfzU_HVLSbt0vLeUlVQiyy
 bILWERJLDeSZ7UfDjxaPPfXSa_qugYl_cWq2DP93cxDmPXne1nEBRdtQF722IRCg8BUS6wJdWzai
 FecUmoNNfpTfit7sjoMRnzFHcFk5ftIQI6EB7lIhA9lMkVpQ8Va0JzbzZl5jdkRRjRN.cRyl4e9j
 vOQ--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 8d84778e-b50f-4eca-97da-ddb93ccf4410
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 12 Nov 2026 04:53:17 +0000
Received: by hermes--production-ir2-5dd9bf4598-c45bs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 25a7201e524977813d9a734f67faf447; 
 Thu, 12 Nov 2026 04:53:15 +0000 (UTC)
Message-ID: <64a1a408abc00c9bfd4abc3517c610768a087014.camel@aol.com>
Subject: Re: [PATCH] drm/gud: avoid divide error in gud_stats_debugfs
From: Ruben Wauters <rubenru09@aol.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>, Thomas Zimmermann
 <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>, Cheng Wen	
 <wencheng@xidian.edu.cn>
Date: Thu, 12 Nov 2026 04:53:04 +0000
In-Reply-To: <962581aca91290526f4cac2330fa97b4311051b4.camel@aol.com>
References: <20261029073311.14556-1-25031212351@stu.xidian.edu.cn>
 <962581aca91290526f4cac2330fa97b4311051b4.camel@aol.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 SWKQ8KA==
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-4DGSrKLT4zurYWF1lTJH"
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.26943
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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


--=-4DGSrKLT4zurYWF1lTJH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-30 at 22:07 +0000, Ruben Wauters wrote:
> On Thu, 2026-10-29 at 15:33 +0800, YuanZhe Liu wrote:
> > gud_stats_debugfs() computes the compression ratio by dividing the
> > accumulated uncompressed length by stats_actual_length. That
> > counter
> > is
> > zero until the first framebuffer flush has completed, so reading
> > the
> > stats debugfs file on a display which negotiates LZ4 compression
> > raises
> > a divide error before any frame has been sent. The wrap-around
> > reset
> > in
> > gud_flush_rect() also clears the counter for a moment, which a
> > concurrent read can observe.
> >=20
> > Copy the counter into a local variable and skip the ratio
> > computation
> > when it is zero.
> >=20
> > Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> > Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> > Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> > Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> > Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> Acked-by: Ruben Wauters <rubenru09@aol.com>

Applied to drm-misc-fixes, thanks for the patch
>=20
> Sashiko highlighted a potential issue with reading
> stats_actual_length
> twice when a flush_rect occurs between them. This *could* still
> trigger
> a divide error, however, this implementation is still better than
> current. The best thing to do would be to put a READ_ONCE when
> stats_actual_length is read.
>=20
> This patch is better than the current implementation, and I don't
> think
> many compilers would optimise it to two memory reads? But it is
> possible, and compiler optimisation is a fairly complicated topic, so
> if you do wish you can add the READ_ONCE, but I'm also happy for it
> to
> go in without, as it is better than current.
>=20
> Ruben
> > ---
> > =C2=A0drivers/gpu/drm/gud/gud_drv.c | 13 ++++++++++---
> > =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/gud/gud_drv.c
> > b/drivers/gpu/drm/gud/gud_drv.c
> > index 3a1b9e2a2eaa..85ddb302d2ba 100644
> > --- a/drivers/gpu/drm/gud/gud_drv.c
> > +++ b/drivers/gpu/drm/gud/gud_drv.c
> > @@ -329,10 +329,17 @@ static int gud_stats_debugfs(struct seq_file
> > *m, void *data)
> > =C2=A0	seq_puts(m, "\n");
> > =C2=A0
> > =C2=A0	if (gdrm->compression) {
> > +		u64 actual_length =3D gdrm->stats_actual_length;
> > =C2=A0		u64 remainder;
> > -		u64 ratio =3D div64_u64_rem(gdrm->stats_length,
> > gdrm-
> > > stats_actual_length,
> > -					=C2=A0 &remainder);
> > -		u64 ratio_frac =3D div64_u64(remainder * 10, gdrm-
> > > stats_actual_length);
> > +		u64 ratio, ratio_frac;
> > +
> > +		if (!actual_length) {
> > +			seq_puts(m, "Compression ratio: n/a\n");
> > +			return 0;
> > +		}
> > +
> > +		ratio =3D div64_u64_rem(gdrm->stats_length,
> > actual_length, &remainder);
> > +		ratio_frac =3D div64_u64(remainder * 10,
> > actual_length);
> > =C2=A0
> > =C2=A0		seq_printf(m, "Compression ratio: %llu.%llu\n",
> > ratio, ratio_frac);
> > =C2=A0	}

--=-4DGSrKLT4zurYWF1lTJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQLCBAABCgCsFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmr1RjAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRERTg2Q0QzNUQzRDBGNTVFNDI0MjJE
OThEMjdFNTBDMDUwQUUwQ0UxEhxydWJlbnJ1MDlAYW9sLmNvbQAKCRDSflDAUK4M
4UiPEACbrkd0LeXt3bFBHgQyOFfdWBd2T4FQ2c2H+SZVUgkszXP8jtr6b4fIrVHJ
wYYWO8vl1JjWlG46pFwWnr0DQMZ8zlmLys3UQGy8+z6tuCbhicjcyhAPHt96gD3V
l/c41GVqQ6xdL/ZlFQfRfLpG04uQqLs/hI70dKj/l84Va0hbBBiL/12Ahm9feexa
KW2HC3CUVMgbUh4wXHjv45pQNFx8ceVueWxIOIQFDTTAiwbN85GRh6sOBU39QmfJ
wE3wU3fJumLQcrKswtUcyFJh4m7nCgAGBaX4KoAXnFLVnWT/WzJ5HXU5lNkim2Z6
ulLUDqWQ4gkhSFUuUm3f3gflrTTPkazLnAZB2tnhKHz+LaBRk+He9gAe78WBlOiK
SU8Djca7+O8jSqEL9SFa3EcSLtdiyoOjkfDY5V5GA9qaYpaOkzhG2EopodlO3APS
6lFmIgZW6n6StwLpZ5Bg9pZx2BDMblya+TkViQ1FLwAPjFIfImpBbwm5xBe66vrn
6ctYhzuXQlcobGeJRASo0aGTNyCxRGTiqG8Pn3UCCYRMDdahByd/x/FrIQQjzzO4
iI4A9LhQkAR4fYK/XRe7Dkwci9Zzv2fszH4/GvPo6j5NSh/sMp6dGhtueMagmxHf
IXfWYQt8cHSLuFBf7VcE0KDlEeNTh+Pi5F3AsYDCZpgEuqP8GA==
=a1ef
-----END PGP SIGNATURE-----

--=-4DGSrKLT4zurYWF1lTJH--
