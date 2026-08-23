Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733BFC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D623D10E05F;
	Sun, 23 Aug 2026 16:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="fHHQR2Fp";
	dkim-atps=neutral
Received: from sonic301-22.consmr.mail.gq1.yahoo.com
 (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794B210E05F
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787503019; bh=OKi5qXoPdjEo4yi1r9gA2Z+oOi/C30ZjEZUOraOxNW8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=fHHQR2FpvR22GaHM6kIdmwRDl+BfKv275yFDmjbMBS5SwyDMfxQlk7KWtbv5ZCwXY9+vZsN5PTspYygx2xUAFhKxYLkQkXMgQsbYFRbN2vZwv6puBpiYF7JGzUMyNRpUQAnn1B7/Lj51n0T70XIekdzXnXjHu99QmkYEzITfRuMGrP/+ULY5qdb12tkTQ1fzEcgzOaZs5MZTvNkv5qexzC8dTAISuINa8iGN7sr5K0nLcTpRNddXhlMVRWPZI6D0Fl1YwNWu0QjQeZa6EwYgYIBg3Z1TfbSvFs7nmpYje0om3ka/IvBqodgnXZ8xAp8rAQ6U76p3ZHbRmOy9LTD6yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787503019; bh=byAlPVl0xoK1ERAkQ3whZnx0Uj+auVUoT6JpIK8colD=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=Eqe2TE1x8XN8BCXglVXIS42L0W3uVScifsn/nmXckdbJ5NQ/MINtyJblOhThiLKaR3/jOklPAuFWQ2g2XAvqQjxEyddQaXmnYrWwDrGyPywu3AhXO6mF5v6S+cM0uu/rTySHye7YLYQ8TGKFF/7wCaN6dlafYII+eMyo6r8n8ERlWImFkz1Om9L7ZMk5gu+4jprDXRtpGuIU4WvY0Ze2m9QOK5rIIR6VJWTRqgX5y4asu1kOX6pq6jJPoPwO84zxfsxuDjtqNSHmxywhwC4POShM+B7f5Iin3mwZZwqtkcKOZ9nP/4VwC1gNjFwnHxggvTDGa547m5q/8ZRdZkjmnw==
X-YMail-OSG: 1Dj_N7kVM1lhvEkH7lmXHNY1d2Xjs8I_6IKACafw4ffLCrj8wL9aNt_wzxFdd6u
 nKSviS4oPrsmM.c7T8rdQQcWekVBk96XmPOcMqoY4OtNzpPUPICcccdNBcTMPCQQ74JnC3HDYcMF
 ASFY_2RdwE3MeniWB7fBdMGIOTcFXOmbcxsyttE_3vZ8qQucIATfuTiHcbfrV6rfbh51woqxNKde
 6Nf9t2AgtfYCopeWNhqEFkZ2IvKxmgBjGnhJLtYSR7k_2DGN2VXLQHNxOSwAQcN9i.op_9P3wenE
 UHHHa9euEcW21ORlTp4onDwuhqnyRGIVkhcZExNd0n4v9lt50_sKmS2HIagc2BYfEkC0P6n2lMFV
 i5FAqRLcutAGTNSTuVGZFvOatGYdA5JAVRpM3_FUa._vJiXfppi8lC8Vcqs2l9eTjQUE5iBCo.nX
 EE8zbXQdVjzXIVHb62aJYAoLPAIXgrtQdXXu_czd9hHKXSavk6mV08X7L_sEl6tdSQiaypIsPa_E
 CpD4QXbyxss6H8iKPV7yNgcjJeyg_R0EAk8eCXnDcSL4v5w1x2RguqeHIirrxuUJrd0k39J0e3Ct
 iE4oIgxegyXH_viu.yoeI7gOZY6hU93lLaWnFPGWj2BHSzBAG2wBWp6kdGggKqdNHwP1S.YDOLSn
 kThxgyRtH1GJV8TR4qCAuTeLyH86oguBUtlGl5wHaqtsUfScTpWJ1iP2KxIbjt4JiDxGiofEDY8k
 r.SNNucfPP3PyBYh5on9ooOFnZxjtLJPhXhftSgXOiOSOw0RcMhsn8772pBlPdEbVJQkoJ1vgwId
 ONCCFJyudoJUA6jQh5nqWoczYCUyUeFcCIx1.Y4rAFvSlJDZmfqvB.knUGkrEu2QJXVhFX0rakMy
 s2R6ImAfBAV6Ie_yWAPTF4wV7T_VUJwZ4u6Q9iXrrnXfrg.G0vhtDvBzZ_eIHv5ED9b5a9bje2US
 jn73Bq4OcjSUX1Z5FZxgCtTb9pOpcrhEVdU63SUCFEsFlcsZnjqSysFtVVgsM09BzBClZMVLgB26
 g.2_SOtna6eQWf2JNqRAiAeDcSnH70Ps8HBmRd8WxgzVQ5fwOJRwHjYkMHiiWSMcf4XJmgKrWQcV
 1hE734CN1RILc6UVH5IhkbG_s9_3ikXNkSaZa3B_uNkK91eMDLdrDgl.Y4CT2AkFI.TaveJthi2_
 Aa6QIUIwOzLaLJIEIjqFGyIaptNK_OFxhUsnMw_qwWPLHkAI.Br5Aj383s08mfajWGdy_T4kTnGn
 jT_khpy21dmlggGGGWAhiZv6P2X5SROTIo.YPjI0OhkO4E5LX3yxCIdOUEnqBh4EBzK.TosEVd4B
 k8b3zuoX4.XkDF1tUHcefcVc27HLJoll57zY2Le0AqUVZrCJlcfDRkS3lfEpEEGjd09Hdq9y_7tw
 7yf90tS68roJ_k42QgZ5Vx5CB0zS1vTjlY8qSAZGYfYS83kfKY_Qix9cXJMEtmXxV0IDnx4rjjOx
 529Yqz8s4JO0oNaBFVVehD3Ipqq_Zc807nrJoLOxN535tYxeBZ9OjvlIP1uoMUN6WpcJYWACbfGj
 _zYxtcEgvh12624Ie_zWRF1eqlqGp48565OnxdvVBlyXdX5Y7c51D1JIerKT4.pifJCESXtPDhb6
 4LQpdnrjIPPvusZQRqGHgp5knzmE5NG95BNOibAOCoDGzQl_KZhm3cqBcG4CCA4HffwY4unf3BkF
 4w7UiYatBGHToFNuNk05ubWc32Lda.XGUy7U9cl3QJKZBOsyxL8vnaA4uIoVZqY4FgGQi_UxJB97
 agg6CqLTYu39dY8LvsUCo2t1bhDuvarC1IefyCHyHgB8hbOsureYeJ6cNavgdK.Igjyq01NMhDNb
 SXGjA7OZBr.Sq05wmIeRf8CeHCjotNXZ9p0782JpmxAtnzXJYkd.HMBEB7L7BUApPbn81yMkrwPJ
 K8PuEtNbTDQ0neK3n4pp6ybjKIlXUfPXBmWb5wseNhHfAN6ocAs0_KO.gExOTHPn5VrEfN9S.zPk
 kEomuFWgcVmxoqQuyautcAtsISf7bSyLjccfNzOQOwOltr_gJ0YTyRMkKz3QpAzdip7RYqI78.qH
 0KjtCoKecciEPl2sf10AIAN5c5Nv4IrOXKH.RqNjBq0WDrvIaHqaQH1NrRNFJ_1u2DBmniIDGNR_
 P4rAJ_PY1rCdrlOqkrsaCS45.zvaBhWI_V7OPQPJlGs7Eno2xXvWxO9e6paPBE5xsbjFBU4GSBpq
 14c0Dnv8mnu2oBNLLrBbT7b48YLwWx2uMp8LA5z0ipJUqXPYnU4wNKEUlJdPHY5KKeO2i2JlOUYI
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: b86c90b9-04fd-451d-8fe0-8f8be3ea2489
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 23 Aug 2026 16:36:59 +0000
Received: by hermes--production-ir2-cddf86dcf-mdt6r (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 8fc7884556ecdc6e11584157a58f787c; 
 Sun, 23 Aug 2026 16:36:55 +0000 (UTC)
Message-ID: <5d01ba87df6252992930a58be632dd076cb56e93.camel@aol.com>
Subject: Re: [PATCH 07/70] drm/gud: Switch to
 drm_atomic_helper_crtc_create_state
From: Ruben Wauters <rubenru09@aol.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Date: Sun, 23 Aug 2026 17:36:52 +0100
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-7-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-7-fb793475c05a@kernel.org>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-SXdX/vqtMceMwWuqm8YX"
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


--=-SXdX/vqtMceMwWuqm8YX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 16:38 +0200, Maxime Ripard wrote:
> The gud crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_crtc_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Ruben Wauters <rubenru09@aol.com>
> ---
> Cc: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/gpu/drm/gud/gud_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.=
c
> index 89bd6ca36003..83a036c6e41d 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -343,11 +343,11 @@ static const struct drm_crtc_helper_funcs gud_crtc_=
helper_funcs =3D {
>  	.atomic_enable =3D gud_crtc_atomic_enable,
>  	.atomic_disable =3D gud_crtc_atomic_disable,
>  };
> =20
>  static const struct drm_crtc_funcs gud_crtc_funcs =3D {
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,
>  	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,

--=-SXdX/vqtMceMwWuqm8YX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqLIaQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhgqEQAJMfZ8WVxnV6O4lkBu3O
QAbQQVjxKJyIHhK6PrDcbUffzg28YWfrZ8mNrYBEc+/5aVcRpVuIdnNfLQJdJ1Vr
NPf5VJiLPOqU55czH0d+iy3KxH/lODDr9QqavvuE0ldgsb2dReMyzfRFxXyxQ4zV
DFqo1isJKaerEDTVOkEQ5B4PADmyALBziRrGnl9Tr+6+6Q+rsdhqMuAthGvuc+bh
H1UG6FIcivyu3VjoYxGKh6DzHNyw0l3WPoSR4v9aHT0gPWVFpyIoEhtIGSKtSPwK
C0+SdBLy7WLgXW+2UMVGC/StoonychUoO+UPMH9axONzkCutY3x5q/IeQox+xn50
kCNjkr1O18GhHXCaWgOEjsLE+FOffDFLxKicco191XetS5RKgBIdTKRkrTN511IC
L7bq3IQf6BBQc7YjBd7cL+KkPwu5KeA6a3UAgrUlLbvqYpFLgwFjMAmZVa5VtmL/
btpfiYLINl4N+OpI5oTvj8LbCAWY0gDLtPFj8uSYGNAJwIfLjWN8rjlHR+XnrkPe
miIjC9YE50iG/GoBwz3LGq+rdTP6vG9rLWZX/4RnpWX31j55g4vDLcyhhZf3+EVB
dTkFjXzrCUeujM7hMdlrazinBkZnu/aRdld2Im7FMpKF5TfsvuanyrJ0RRfYhoo7
c0BEKu1T3JxsSOAqzpzpvQ5f
=NcvT
-----END PGP SIGNATURE-----

--=-SXdX/vqtMceMwWuqm8YX--
