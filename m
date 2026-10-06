Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B59CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E5010E129;
	Tue,  6 Oct 2026 12:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="gilhD+fD";
	dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A80010E129
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1791289208; bh=VsaSHlXqrmr/etCWdlCTiPDjrmJy0QmLkERhO8rj0bE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=gilhD+fD+aiTo7omG1+R9+xIFL/a6d8qRew9CRn7qea8RcJIj359vX+qwZAO9Z1+N2PH2O2aKLQPNZv7o1fEEl2jJcx/Jk7jhEna9JGbGFdBxXW/Fi3COmf7L2NwFOY0NaIu7ywAqFffyGTaiSTuHJhTx1YV8ZD9LSojuNTn57aBt6/DwIo1PtMksF+5QJmWyAAsFDBqxDe18zQT3qwVQCTBz1lNfpEho/m+91FMdWQDlMkvU1Zdn/Y6g49Ran+IyCmfZsEGIAnvM8WAo9Zt01Mw/MavI9OuPFcJ8LAQULZZEQEszOnl1/lFLQOb2+zjEU5STBHuiaMIq2uyDwdaSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791289208; bh=jFa8fe39cXMvXRscTtzPtGktMAPZ0kchXp4f1K49xLf=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=cQPmJtV1Y93oolufHDDpWCspADlXbMB+s6MzxycCxiy7pFNUs1UUusifj0mr69kC2RhpK3ermkFtlVCB0j1lCJ52Ghmtx204ULVTBBzCbqRsl0RRG1ekos3zXE6gzjYcksZP48EvMIcjpHHDCyYIYL53V87GKv6/57hiQ1NdBMkiUyq4pu2Jir2O2qQ23NMuRfAC5bHjCzs9YBECO4O6umAp/VsVj+PO0OgQhKSYKE6+ucJQSzLyh1HRUaK2x2j6xDWWpZF581uus7CBFj97i2n8FEe2lTGaZ+BBLGP3JSn0iniVC7rXI/1IbkxLsNp/++gsgvWl9EEOBl3fuVYcEQ==
X-YMail-OSG: kXZSJhQVM1l4cnthdPQvdKfRMdzfcWIKI9mzt.AlUusrsu6yFByIDERgVGIqf5b
 .ZpnmN48l0KV8HBNP0tsehOi79SaEq5fr6T93DYPacwgD5eJgVOjbddK86v9djpFKPdUGIk4PzIX
 yFDhX12Ugh7ElnVZVKFhaGtlrZdCVHWUagHIQEn2LQE6uJ8IyvbCqTZQhcNMCK1uGxcDTwAOXaDO
 bdRg10St3dzYynnD8KNQqEI2I5RpBxxD1W5UiNwMS9JDBveix9lysluM0AJ3yZPhzS_xr2ezLkFo
 4JG5rtL2X.SrlcQlIqS1uFwuEhlbtd8czom..RhAd9jmN_jAJiWSrgsnO3H_Dy9E1E1gD5tRuRnO
 PwCgbFb10I8CED97l5QtY_7xu3dj0sdpY5fMejx1f8Ldk6m6C8kT1XXyM4QNxf7ci5ZM..3H6fww
 ny43jnGL6.TBNXK62r0SJ5bPv0uRTsl3jMrdhrfhMe4.ym_w9nazLaqt9DLbEAu7Jo7Bmu3vcDbb
 d0LBqpLSlt9CYpS14TUaldyE4_7hS1MDvCgWgwHfEdzCtFroLD76UT00rxC63.KTY8wQC.M.bynL
 EsDsggYqK3Wxdc6xJG1QdKT061NDTRL0q0.DDhE12_gt7bx50vmEYtvJBUoOFcnW14pM3_qp.JNT
 lf2e5bjanCGsA_opzcV9G52kCUWO_bBNHOrGAgU0UIQut_KIzQkc1epXDju6fHgQ9e3_rca0OcTx
 0F9AcC_ZGNYUGottr_mK2phE8bWvgKlw2dLnrAowdxOsnRaEFd55m2nbbxUHSOicqo1KmsvTI0sR
 iIYDQOTdx_eYZdF21lUDKaoKBHo.zuWw11_xWhTWE60QlP6Y7OPt3ttPc4z1MkCmZfcEXdw8lCd4
 sc0nmS15MaM8XZdq13PnHtcSpPWMJzLbR3EXAqneD3XpZ6nM6Xrw9v8ekesv0vfnp_mB6nafGq4k
 xy7mrDkmZnOzKoJwtKvhayC6OFhLJd_lfSGJfLrMA0VRqUUT4hpKZPks1nmpBKJ7L0P47kCXrd0H
 Wu85ed.B19K861B8B7ki8vRC1WMkutBqRmipMtbbaTihdEuKhalxRW_1enqZbAttu2VhbZma0BRw
 6eWfErzRohn0ty0lm.Bp_5iJPx0vIan.RSzwd05DMxOO9ByW_Xw1yopBznJiaHNgCfPILcsO.UVo
 XRc6kfEzIbpcCjJdKsWh71Z1yN1ijggTUDDMgUf5ZnO51tzd4BMDcMAoIXgRm7SKnvsM9vk2nxCL
 vgYWSdHoFmzeLj9b.uOr83GXATj2ZYCMzcZHYYXE4Gbkntz7fL.syGy1tgf.UxlM4CvdJMbcvj8x
 59afHAxHQj4uDo853_6DI8IsE9U9qjrjWDMOhhGFqGDcYPlTWpiFrgp7ldSQzyPyr4cMQEv7Pqok
 a6mxg4ZaWWLtm4_qJJNeEGvYcbEp6XuGQWag1ozgJ1GjBYiyRcL3RrGnMyGQBiG20Q4ZDwN55ZlL
 xdWAL3gtFh355wtApU.dpnKhIb9wHYy6h2zUpFOZQ.bfTahLLOu6dfs3goEoMEQio7CM5L60c_TI
 qXWqm0iawfu5p5xp_XE0Ief6qoHtULPdhPBFPQ2clO_c6jGq1PZt6Z06pivwP_FXPmi2_UHkzlxn
 18gE2oRc_0QUAdWBfxzy0MXI2RVCpgCp7vvxnvfYLD3ulpiVpQS1owAMncm4aO1E_1pdugqVaiBS
 .bNnvpOBchYI3739JVpcXE20.nRFa2rX9Jlj1_Hrz3tUjSX7J40iPdHXHg5.2IxwP.KSBLMe6vG8
 Tpe7Lo0JJrljRjKpE1j5VbhooZT1uaBAu6SOMVabhctJ1h6ZoLRsHxGyBdWqZn1jdK4sWgmdLhZH
 rRqzU18NXJDLB9f8vIKv025q0oLplZc2dBOug_dghM85gzAvhLBkORA7.KQJHewg0.txpF49.4ic
 hKi8YZYXk47caGPZKQN8.MDyQjV8y7MsfiukQ3YL3q50AjxEPIUoLQOj9IZrhaqr47jhBhf7Z_oX
 5mdfzGmvHBVsEi8g.BDk6SCfze9shDuN1ONJT8WwgKJBrOQVGSdUq3mr9nmGaW5wwpBsWKem32oM
 6LYuFqZFE.nbR64SVn4RERlQRWSb1NC.KWJ1h4UGmMVwPwgQItm_pLXPCJ0eZB5l6o4v5RRGSkw_
 IB0oEib1C30A4CJpLM16qPXquFguNCxS0DfUt.wvUVoC5NdQLFZ3YR4FanMw_3Qm_ocM.gMO6sV2
 okzaxldWYVTjh53GH7rJLRVIIE9bILq1UaEP8.Gk3ybiaAcY3HKkYvcxetAE5
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 3f2ca717-a9ce-414e-8118-5766e604d46f
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 6 Oct 2026 12:20:08 +0000
Received: by hermes--production-ir2-5dd9bf4598-vvk7z (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID e59c3c356c4555e72f269c6939591e4a; 
 Tue, 06 Oct 2026 12:20:04 +0000 (UTC)
Message-ID: <23f062e2e497a58821003115176d71183f5c06b0.camel@aol.com>
Subject: Re: [PATCH] drm/gud: don't keep a connector without a CRTC as
 connector_state
From: Ruben Wauters <rubenru09@aol.com>
To: Sajal Gupta <sajal2005gupta@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 noralf@tronnes.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sashiko	 <sashiko-bot@kernel.org>
Date: Tue, 06 Oct 2026 13:20:01 +0100
In-Reply-To: <20260922084026.15481-1-sajal2005gupta@gmail.com>
References: <20260922084026.15481-1-sajal2005gupta@gmail.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-7lZk0vyErrpYnufwA6aj"
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668
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


--=-7lZk0vyErrpYnufwA6aj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-09-22 at 14:10 +0530, Sajal Gupta wrote:
> If the 'for_each_new_connector_in_state()' loop finishes without
> hitting the break, connector_state is left pointing at the last
> connector visited, which has no CRTC, instead of
> staying NULL.
>=20
> That skips the "if (!connector_state)" fallback below the loop, which
> looks up the active connector when the state contains none. The
> function then carries on with a connector that is not driven.
>=20
> Fix by resetting connector_state to NULL for each connector visited that
> has no CRTC, so that it is NULL when none was found and the fallback runs=
.
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260902123254.36987-1-sajal2005gupt=
a@gmail.com?part=3D1
> Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
Acked-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/gpu/drm/gud/gud_pipe.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index aa7792966287..5aa5ac2f3727 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -507,6 +507,7 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  	for_each_new_connector_in_state(state, connector, connector_state, i) {
>  		if (connector_state->crtc)
>  			break;
> +		connector_state =3D NULL;
>  	}
>=20
>  	/*
> --
> 2.55.0

--=-7lZk0vyErrpYnufwA6aj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmrE53EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhYAwQALRHQCEzAJLWrKgQ6OVr
UoemwL5sHR9PHETv9Ic/YJ2J81b9p8A30QsGkn6c+4m/rXt0nj595b/8V0uxajca
CD4YvWsH/19aoFEvCYznKM4nNiLPkf0jOuI7RPy5o/akBfAjSrRzSWJ7YkXN9rJL
E3C3lfZAxXJOR0yK78Jkpog2Ledj2nxBNDG8CCrSzrVsi/SfHAczjM/l4o8a6+8u
ggyqwPi0N40iebdxyVWiQbs55ibMUw6b0lg469DjiFlrfi4Bf6M2OvM460k1zIfg
HmCBgiKv5+Mg/kLUtvHJHy+CWqFPuDMCToS6gXlMl2w/lW/MhuOYd88LXPqpyvaE
0QfgsROW4jC7LeKOlePoag88S4ZFRIE+wYUN+VSe+sLQjUbyzdH70cX+3RqZo7JL
JdZqzV6V7Kn1k+QeqLhI5WC6OoZ1HUarl+tbIQYYuJL/l8ohGIyIH/JK3TeVYAfe
JzYgEwp0pJlMUYXJouJ19Cp3zNg88ThS/uzKxqZzDBudJOS+c7oxTsEGXFwdFl42
+Fk6Ws0jW4C9hQVZidQJmipZGkGmaX9lLesR1kbtPucf0c3SuTyTyTKb88coBdQ/
N+3VTN/HYynRIg7NgG7QMw+fvXMK/Hk9HYNckVG1hiNgPc1rjertsSjh1HtZere4
x3N4TAcELiYxYbJrfPhT+iSq
=gwXS
-----END PGP SIGNATURE-----

--=-7lZk0vyErrpYnufwA6aj--
