Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3A606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=O9ewXwZy;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=H6wVSQ21
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9995D10EEA0;
	Tue, 17 Nov 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="O9ewXwZy";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="H6wVSQ21";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD1310E1C4
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870407; bh=1zG5seXGoYlvBJzHn/0HbYB
 l3NQWQveVdHCEOzhGHtA=; b=O9ewXwZy2+/LvZVw5WpYLZv3gaqMOnrpFtC9ETVCXpqJskR2m4
 mWgx9IsKuUNWG5KSvRYbWeNbxEnHLUPcK5CA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794870407; bh=1zG5seXGoYlvBJzHn/0HbYB
 l3NQWQveVdHCEOzhGHtA=; b=H6wVSQ21WHy4mA0yhRSRl2H7LJHhMwmQFYbH38PIVwu837UfR1
 fDHcwSPkNbfStN4oYTN881EvxFv5d91nhzotq2PkM2wbzEUGnyol45aYwKqe72+KXvZIS8RaSuW
 jevT8HG6L2WecgqUlRBXXpw/wufEvCLIpb4D1qLzcQNdiCf8YABVecegSFHTC9ayYmYKonLcaeC
 q4NENRxAW1xUGC40LPs57aATuaGlHOAThrn+QIOrPiEKDxvgeas2F/ZPlzToQfCwqGE4t79vS9L
 Y6w0EveJL2zk7ULdVUvWxIir4FYoNvJjpYLj2PQBdvIC8Xx4s4MWjZ+r8fyOxLfzjXw==;
Message-ID: <01f936dc-20d7-4b63-b3b7-c1e9c841fd11@erebion.eu>
Date: Tue, 17 Nov 2026 00:06:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-6-7318a19806eb@erebion.eu>
 <sashiko-outbox-217825@kernel.org>
From: erebion <erebion@erebion.eu>
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <sashiko-outbox-217825@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pWh7rxlbKNUN3h1nSLgB0TyK"
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:18 +0000
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pWh7rxlbKNUN3h1nSLgB0TyK
Content-Type: multipart/mixed; boundary="------------ftwDOvZB3FQ6fHFfbCDAPZAD";
 protected-headers="v1"; hp="clear"
Message-ID: <01f936dc-20d7-4b63-b3b7-c1e9c841fd11@erebion.eu>
Date: Tue, 17 Nov 2026 00:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-6-7318a19806eb@erebion.eu>
 <sashiko-outbox-217825@kernel.org>
From: erebion <erebion@erebion.eu>
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <sashiko-outbox-217825@kernel.org>

--------------ftwDOvZB3FQ6fHFfbCDAPZAD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTYvMjYgMjM6NTYsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5k
IDEgcG90ZW50aWFsDQo+IGlzc3VlIHRvIGNvbnNpZGVyOg0KPiAtIFtIaWdoXSBhcm02NDog
ZHRzOiBxY29tOiBTaWduZWQtb2ZmLWJ5IGFuZCBBdXRob3IgdXNlIGhhbmRsZSBpbnN0ZWFk
DQo+ICAgIG9mIHJlYWwgbmFtZQ0KDQpUaGF0IHdhcyBhbHJlYWR5IGRpc2N1c3NlZCBpbiB2
MiBvZiB0aGlzIHBhdGNoIHNlcmllcy4NCg0KLS0gDQplcmViaW9uDQoNClhNUFA6IGVyZWJp
b25AZXJlYmlvbi5ldQ0KDQpBY2NlcHRlZCBsYW5ndWFnZXM6IEdlcm1hbiwgRW5nbGlzaCwg
U3dlZGlzaCwgTm9yd2VnaWFuLCBEYW5pc2gNCg0K

--------------ftwDOvZB3FQ6fHFfbCDAPZAD--

--------------pWh7rxlbKNUN3h1nSLgB0TyK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavuMhwUDAAAAAAAKCRCOr0AybgKufVDl
AP9bdsGivDZ+5ZFbswLaeKvB4ixNiCxlnuyaWRGIhA/21wD+PGChG8OLRjLlsi07HgWmxqedE9qi
LYBhIfRgfzyd+QY=
=s4wk
-----END PGP SIGNATURE-----

--------------pWh7rxlbKNUN3h1nSLgB0TyK--
