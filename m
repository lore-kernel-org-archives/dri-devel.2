Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C16606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=sidspAq7;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=ahT0ov6n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC83410EBB4;
	Mon,  2 Nov 2026 08:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="sidspAq7";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="ahT0ov6n";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EAC10E4DB
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 01:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:From:Subject:Date:Message-ID; t=1793583195; bh=CpinM/IpytUfD9vGKaPrjPR
 QBHB3wnZR9UZpr2lYAok=; b=sidspAq7Ua9LmBj8CwRrD1M4QFrIWGJ53YFr+29KmQzfeYKdkV
 hbC0Vf/icpSpgk4xax26C3CjToVIB080dCCQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:From:Subject:Date:Message-ID; t=1793583195; bh=CpinM/IpytUfD9vGKaPrjPR
 QBHB3wnZR9UZpr2lYAok=; b=ahT0ov6nqjyLUKHAef1k8x0sRIU/i+lGhXll4QNocx8+NrNfiV
 GTMEaQHFHpHpau6iFy4ulg3/xe87k1T4074qLY2hIg32ftWwcOyd04rKQHbI/LaWVHKeDD0IDAG
 2fQVu+53HEwhtNoHBKcq5fBVLjPlpPmcic1xTrxuhwq9KrNkZ2aAzXIXs9dmMHsn7V8/propmbC
 vMdbhCbVVbU9gWTdo2RuGwiXpRkfCXSZ2d4mQtxoZAlF8d/alam8T0uUhuEvFRPiM3Q55g9XwUz
 J30n2xgNQjaa1PR6T2eb4Gh9z1VGVwawn31elkndpC2fcmR8EoodCo2uwfvlC7t+kxA==;
Message-ID: <c539ae6d-8018-49ba-b4fe-8e52306c93bd@erebion.eu>
Date: Mon, 2 Nov 2026 02:33:14 +0100
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
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <dc96c6bb-0ac2-4f67-84b5-2284d37afa44@erebion.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WErBOJk7ZUz3nYwJ3r0a4wP7"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WErBOJk7ZUz3nYwJ3r0a4wP7
Content-Type: multipart/mixed; boundary="------------Ys9oJY5YtjJo4H0mWezlvqzT";
 protected-headers="v1"; hp="clear"
Message-ID: <c539ae6d-8018-49ba-b4fe-8e52306c93bd@erebion.eu>
Date: Mon, 2 Nov 2026 02:33:14 +0100
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
Autocrypt: addr=erebion@erebion.eu; keydata=
 xjMEY7S2FRYJKwYBBAHaRw8BAQdAUf0YlT6sBQSunZeO44bgAPe+ndqTifGaNjw7vzJ2KPHN
 HGVyZWJpb24gPGVyZWJpb25AZXJlYmlvbi5ldT7CjwQTFggANxYhBJyMprURw7/YpjH7646v
 QDJuAq59BQJpWnovBQkHhhzbAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQjq9AMm4Crn057AEA
 j3didUIhbtAoppk2eNu6CbtMvkDisHWHVLaWF8YC1VsA/1P0ngBoVghELMachirfTinwBplJ
 qP7GGlSGRqSfnlAKzjgEY7S2FRIKKwYBBAGXVQEFAQEHQN6NPWcyqKdecGU1vN8FVXBwYEUd
 OAhF5jpmd7M0Ybx8AwEIB8J+BBgWCAAmFiEEnIymtRHDv9imMfvrjq9AMm4Crn0FAmlaei8F
 CQeGHNsCGwwACgkQjq9AMm4Crn075QEAoDqfm4OeAEQWMgfQ496u2S3rWJw1EMgTOP51FQbX
 rY4BAKn6AhEBh605uas3OTVtcwNIAJn1sHTA7HqqWniUe9sP
In-Reply-To: <dc96c6bb-0ac2-4f67-84b5-2284d37afa44@erebion.eu>

--------------Ys9oJY5YtjJo4H0mWezlvqzT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMi8yNiAwMTozNSwgZXJlYmlvbiB3cm90ZToNCj4gT24gMTEvMi8yNiAwMDo0NCwg
c2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4+IFtTZXZlcml0eTogTWVkaXVtXQ0K
Pj4gU2hvdWxkIHJlYXJfY2FtX3NlbnNvciByZWZlcmVuY2UgQURDNV9HUElPMl8xMDBLX1BV
IGluc3RlYWQgb2YNCj4+IEFEQzVfR1BJTzZfMTAwS19QVSBoZXJlPw0KPj4NCj4+IE9uIFBN
NjE1MEwsIHBoeXNpY2FsIHBpbiBncGlvNiBpcyByb3V0ZWQgdG8gQURDNV9HUElPMl8xMDBL
X1BVICgweDUzKSwgDQo+PiBhbmQNCj4+IHVuZGVyICZwbTYxNTBsX2FkYyBiZWxvdyB0aGUg
cmVhciBjYW1lcmEgdGhlcm1pc3RvciBjaGFubmVsIGlzIGRlZmluZWQgDQo+PiBhczoNCj4g
DQo+IEFoIHllcywgbG9va3MgbGlrZSBJIGNvbmZ1c2VkIGdwaW82IGZyb20gZG93bnN0cmVh
bSBEVCBhbmQgZ3BpbzIgZnJvbSANCj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9paW8vcWNvbSxz
cG1pLXZhZGMuaA0KPiANCj4gV2lsbCBmaXggd2l0aCB2NC4uLg0Kcm9vdEBtb2JpYW46fiMg
Y2F0IC9zeXMvY2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUzOC90ZW1wDQotNDAwMDANCnJv
b3RAbW9iaWFuOn4jIGNhdCAvc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lMzgvdHlw
ZQ0KcmVhci1jYW0tdGhlcm1hbA0KDQpXZWxsLCB0aGlzIGRvZXMgbm90IGxvb2sgcmlnaHQg
ZWl0aGVyLiBJIHN3ZWFyIEkgZG9uJ3QgbGl2ZSBpbiBBbnRhcmN0aWNhLg0KDQoNCiA+PiBT
aG91bGQgcmVhcl9jYW1fc2Vuc29yIHJlZmVyZW5jZSBBREM1X0dQSU8yXzEwMEtfUFUgaW5z
dGVhZCBvZg0KID4+IEFEQzVfR1BJTzZfMTAwS19QVSBoZXJlPw0KDQpHUElPNjogVmFsdWUg
bG9va3Mgc2Vuc2libGUgYXQganVzdCBvdmVyIDMwIMKwQw0KR1BJTzI6IC00MCDCsEMNCg0K
UGVyaGFwcyBHUElPNiB3YXMgcmlnaHQgYWZ0ZXIgYWxsIG9yIGl0IGlzIHdyb25nIHdoaWxl
IEdQSU8yIGlzIHdyb25nIGFzIA0Kd2VsbC4NCg0KLS0gDQplcmViaW9uDQoNClhNUFA6IGVy
ZWJpb25AZXJlYmlvbi5ldQ0KDQpNeSBsYW5ndWFnZXM6IEdlcm1hbiwgRW5nbGlzaCwgU3dl
ZGlzaCwgTm9yd2VnaWFuLCBEYW5pc2gNClllcywgSSdtIGEgbGFuZ3VhZ2UgbmVyZC4gRmVl
bCBmcmVlIHRvIHdyaXRlIHRvIG1lIGluIGFueSBvZiB0aGUgDQphZm9yZW1lbnRpb25lZCBs
YW5ndWFnZXMuDQoNCg==

--------------Ys9oJY5YtjJo4H0mWezlvqzT--

--------------WErBOJk7ZUz3nYwJ3r0a4wP7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCaufoWgUDAAAAAAAKCRCOr0AybgKufVGu
AQCz0f0jMK0GnWAFp/H6WK+5cNCyhV2Lyb4MlysN7OAt9gD/erL2RUUqAkh027+zxA/9XyZhsYk6
U2Yy8LfTYaOONwk=
=QVpB
-----END PGP SIGNATURE-----

--------------WErBOJk7ZUz3nYwJ3r0a4wP7--
