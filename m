Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7011A606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=f2suiyoZ;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=R4+S3A89
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895DB10EE8C;
	Tue, 17 Nov 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="f2suiyoZ";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="R4+S3A89";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 787A410F44B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794861640; bh=uYEsHswoRNseodH++TxdwgD
 r/xzEz75Lf+J/mrVvjMQ=; b=f2suiyoZNonKNrtYzo4XR3rw/2hw6v0CMmCWDw1MkNfbnBUcNK
 jXDX+bUaF6Rk/IT1PfPmXgkJbw5oatzNsPBw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794861640; bh=uYEsHswoRNseodH++TxdwgD
 r/xzEz75Lf+J/mrVvjMQ=; b=R4+S3A89Rq4mS/5aS+NMMBcvI1FEUbpqDKIqH5inEXCXI7O32P
 aq+UPgf7G7OTjFanUprCmVTmb9ZRZLdu2+YZLjG2G6XkErUuOvwrHi0wa8yxeW8LGQSCgGblywV
 wiC/XIlZAn2+cyE1r69kyE/Ohifa3vZ8FOc14TuuStyFOZD7jAvg46S0d5yQ2dDuh/1+awVRMwv
 9em6zbh9tQH921kLNvFFFmHdlDX+Xsj9zFbTGCHBu7Wxk9TlFN1VoI9v4uMAzYYH2k5V2d7+Drp
 DhY2ydXE8+b8MRQDskuNX0Nqv+1Czbzpc7oiIvN/EHSdGqUTv6cncpQ4cQJ7r5gDllw==;
Message-ID: <d0e893dc-9202-4dd4-a436-04f9555a3709@erebion.eu>
Date: Mon, 16 Nov 2026 21:40:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-4-4b01c50a821c@erebion.eu>
 <sashiko-outbox-212072@kernel.org>
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
In-Reply-To: <sashiko-outbox-212072@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iMRKHPEdZv0P0Zdah8mDWd6a"
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
--------------iMRKHPEdZv0P0Zdah8mDWd6a
Content-Type: multipart/mixed; boundary="------------YAhizkrOGz48dsav80Ya24GS";
 protected-headers="v1"; hp="clear"
Message-ID: <d0e893dc-9202-4dd4-a436-04f9555a3709@erebion.eu>
Date: Mon, 16 Nov 2026 21:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-4-4b01c50a821c@erebion.eu>
 <sashiko-outbox-212072@kernel.org>
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
In-Reply-To: <sashiko-outbox-212072@kernel.org>

--------------YAhizkrOGz48dsav80Ya24GS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTMvMjYgMDI6NDAsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5k
IDIgcG90ZW50aWFsDQo+IGlzc3VlcyB0byBjb25zaWRlcjoNCj4gLSBbSGlnaF0gYXJtNjQ6
IGR0czogcWNvbTogU2lnbmVkLW9mZi1ieSB1c2VzIGhhbmRsZSBlcmViaW9uIGluc3RlYWQg
b2YNCj4gICAgcmVhbCBuYW1lDQoNCkJvdCBpcyB3cm9uZyB0byBicmluZyB0aGF0IHVwIGFn
YWluLi4uIFRoYXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGluIHYyLi4uDQoNCj4gLSBbTG93
XSBhcm02NDogZHRzOiBxY29tOiBzbTYzNTAtbGVuYTogaW5jb25zaXN0ZW50IFNvbnkgZmly
bXdhcmUtbmFtZQ0KPiAgICBwYXRoDQpCb3QgaXMgcmlnaHQgYWJvdXQgdGhpcyBvZW4sIHRo
b3VnaCwgd2lsbCBiZSBmaXhlZC4NCg0KLS0gDQplcmViaW9uDQoNClhNUFA6IGVyZWJpb25A
ZXJlYmlvbi5ldQ0KDQpBY2NlcHRlZCBsYW5ndWFnZXM6IEdlcm1hbiwgRW5nbGlzaCwgU3dl
ZGlzaCwgTm9yd2VnaWFuLCBEYW5pc2gNCg0K

--------------YAhizkrOGz48dsav80Ya24GS--

--------------iMRKHPEdZv0P0Zdah8mDWd6a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavtqRwUDAAAAAAAKCRCOr0AybgKufcF7
AQDcxQ/A8fuHeeCx/oHX2pQUsEtWCHYRDhn5p0DK5Jcd6AEA1UaQrqZkZjfSEO5IMO39ZZ3+EgDO
OM6uTQh2u631wA8=
=vMzx
-----END PGP SIGNATURE-----

--------------iMRKHPEdZv0P0Zdah8mDWd6a--
