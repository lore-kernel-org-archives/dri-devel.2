Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6A606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=z1+4/uer;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=r6zqq8BD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423BA10F434;
	Tue,  3 Nov 2026 08:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="z1+4/uer";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="r6zqq8BD";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374DE10E61F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:From:Subject:Date:Message-ID; t=1793622036; bh=RtKTi6lwJ4fch5OCeYjhsg7
 s4+EyI/ILJ6qlxyxa940=; b=z1+4/uerr8cHYL1w6+Hv/p/kkYlVfJlMWKncQX+mYIFDKRkmci
 sN4xEMwPGuW23h+fVzw0bMdvkKGnD4maXSCA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:From:Subject:Date:Message-ID; t=1793622036; bh=RtKTi6lwJ4fch5OCeYjhsg7
 s4+EyI/ILJ6qlxyxa940=; b=r6zqq8BDiz3b02+Tw4UQML7SPnfxxQV6gjUrgJxdvLag5rTLZ5
 5KrrW28YcPyxWGDdpJHaziIMzqsgGcRtv36O9V37X2MF+wg5/j/9KZVz2X9yWOBeM7eNlj8tXWn
 2ThYmzSEZ4T5Hk5L7f35k+gU8V06vgEBCUuN5Blsjw7Zev8MjNjtjz1CKFd53Ch3fQORsWUU8kN
 0Gqd2oPlsX+P5xd+f75m3zKADbqKlqwRk1lE/VTPySa57JMCXbLcIWTV0Z/JEqleJ9M3nLqXlsD
 Q7hZpSyduV0MQQN9l6e07lF0uzuNfnGEoOh3AXAb5WFXlcAj17CvWfgFEYavmWkDVag==;
Message-ID: <a29b9e58-996c-4e94-b121-106e4bc17237@erebion.eu>
Date: Mon, 2 Nov 2026 13:20:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
Content-Language: en-GB
From: erebion <erebion@erebion.eu>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-11-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192768@kernel.org>
 <dc96c6bb-0ac2-4f67-84b5-2284d37afa44@erebion.eu>
 <c539ae6d-8018-49ba-b4fe-8e52306c93bd@erebion.eu>
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <c539ae6d-8018-49ba-b4fe-8e52306c93bd@erebion.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UOqc5Wh3bge3NTajNydAHPsn"
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:46 +0000
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
--------------UOqc5Wh3bge3NTajNydAHPsn
Content-Type: multipart/mixed; boundary="------------H0BohUyAyRGKbi8hEbhSKGjo";
 protected-headers="v1"; hp="clear"
Message-ID: <a29b9e58-996c-4e94-b121-106e4bc17237@erebion.eu>
Date: Mon, 2 Nov 2026 13:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
Content-Language: en-GB
From: erebion <erebion@erebion.eu>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-11-cdc3be96d257@erebion.eu>
 <sashiko-outbox-192768@kernel.org>
 <dc96c6bb-0ac2-4f67-84b5-2284d37afa44@erebion.eu>
 <c539ae6d-8018-49ba-b4fe-8e52306c93bd@erebion.eu>
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <c539ae6d-8018-49ba-b4fe-8e52306c93bd@erebion.eu>

--------------H0BohUyAyRGKbi8hEbhSKGjo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAxMS8yLzI2IDAyOjMzLCBlcmViaW9uIHdyb3RlOg0KPiBPbiAxMS8yLzI2IDAxOjM1
LCBlcmViaW9uIHdyb3RlOg0KPj4gT24gMTEvMi8yNiAwMDo0NCwgc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyB3cm90ZToNCj4+PiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4+PiBTaG91bGQgcmVh
cl9jYW1fc2Vuc29yIHJlZmVyZW5jZSBBREM1X0dQSU8yXzEwMEtfUFUgaW5zdGVhZCBvZg0K
Pj4+IEFEQzVfR1BJTzZfMTAwS19QVSBoZXJlPw0KPj4+DQo+Pj4gT24gUE02MTUwTCwgcGh5
c2ljYWwgcGluIGdwaW82IGlzIHJvdXRlZCB0byBBREM1X0dQSU8yXzEwMEtfUFUgDQo+Pj4g
KDB4NTMpLCBhbmQNCj4+PiB1bmRlciAmcG02MTUwbF9hZGMgYmVsb3cgdGhlIHJlYXIgY2Ft
ZXJhIHRoZXJtaXN0b3IgY2hhbm5lbCBpcyANCj4+PiBkZWZpbmVkIGFzOg0KPj4NCj4+IEFo
IHllcywgbG9va3MgbGlrZSBJIGNvbmZ1c2VkIGdwaW82IGZyb20gZG93bnN0cmVhbSBEVCBh
bmQgZ3BpbzIgZnJvbSANCj4+IGluY2x1ZGUvZHQtYmluZGluZ3MvaWlvL3Fjb20sc3BtaS12
YWRjLmgNCj4+DQo+PiBXaWxsIGZpeCB3aXRoIHY0Li4uDQo+IHJvb3RAbW9iaWFuOn4jIGNh
dCAvc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lMzgvdGVtcA0KPiAtNDAwMDANCj4g
cm9vdEBtb2JpYW46fiMgY2F0IC9zeXMvY2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUzOC90
eXBlDQo+IHJlYXItY2FtLXRoZXJtYWwNCj4gDQo+IFdlbGwsIHRoaXMgZG9lcyBub3QgbG9v
ayByaWdodCBlaXRoZXIuIEkgc3dlYXIgSSBkb24ndCBsaXZlIGluIEFudGFyY3RpY2EuDQo+
IA0KPiANCj4gID4+IFNob3VsZCByZWFyX2NhbV9zZW5zb3IgcmVmZXJlbmNlIEFEQzVfR1BJ
TzJfMTAwS19QVSBpbnN0ZWFkIG9mDQo+ICA+PiBBREM1X0dQSU82XzEwMEtfUFUgaGVyZT8N
Cj4gDQo+IEdQSU82OiBWYWx1ZSBsb29rcyBzZW5zaWJsZSBhdCBqdXN0IG92ZXIgMzAgwrBD
DQo+IEdQSU8yOiAtNDAgwrBDDQo+IA0KPiBQZXJoYXBzIEdQSU82IHdhcyByaWdodCBhZnRl
ciBhbGwgb3IgaXQgaXMgd3Jvbmcgd2hpbGUgR1BJTzIgaXMgd3JvbmcgYXMgDQo+IHdlbGwu
DQo+IA0KDQpPaCB5ZXMuIE5vdyBJIGdldCBpdC4uLg0KDQpJIGNoYW5nZWQgcmVhcl9jYW1f
c2Vuc29yIHRvIEdQSU82LCBidXQgbGVmdCBhdCBzZXQgdG8gR1BJTzIgaW4gDQpjaGFubmVs
QDUzLi4uDQoNCndpbGwgZml4IHdpdGggdjQNCg0KLS0gDQplcmViaW9uDQoNClhNUFA6IGVy
ZWJpb25AZXJlYmlvbi5ldQ0KDQpNeSBsYW5ndWFnZXM6IEdlcm1hbiwgRW5nbGlzaCwgU3dl
ZGlzaCwgTm9yd2VnaWFuLCBEYW5pc2gNClllcywgSSdtIGEgbGFuZ3VhZ2UgbmVyZC4gRmVl
bCBmcmVlIHRvIHdyaXRlIHRvIG1lIGluIGFueSBvZiB0aGUgDQphZm9yZW1lbnRpb25lZCBs
YW5ndWFnZXMuDQoNCg==

--------------H0BohUyAyRGKbi8hEbhSKGjo--

--------------UOqc5Wh3bge3NTajNydAHPsn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCauiAFAUDAAAAAAAKCRCOr0AybgKufeWj
AQC6bMozBSjMpiz13+tQE4l6j7IzqEmspS3fqYiRBWgZWwEAj2e4BQfdRcPZ7n2y819AWMUTHsoM
WHupSm0JNSWG2AE=
=kwDt
-----END PGP SIGNATURE-----

--------------UOqc5Wh3bge3NTajNydAHPsn--
