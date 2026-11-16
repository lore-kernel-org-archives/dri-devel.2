Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB8606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=5b/oyWaa;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=VrGFOKpP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF9010EE26;
	Tue, 17 Nov 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="5b/oyWaa";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="VrGFOKpP";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B12B10E4B0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794871079; bh=4/nuy4QglgrM0BuUt/UjkZO
 K+tfyppGGlKpZpa4QVN8=; b=5b/oyWaawPhz2OCaX82yN+RXBcTgWyGG0jAnOuWkvocioJQR7P
 18uhC0WjZ94cmF96pMajDz0eYtziJS3lOFAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794871079; bh=4/nuy4QglgrM0BuUt/UjkZO
 K+tfyppGGlKpZpa4QVN8=; b=VrGFOKpPzJ0nHAqQRcbNSfi5bIWa4IwtOSfaKlUPckV/LFUq+A
 nlKp0AHxVBgbi9hFj3gB7xSScOnOi2QSFSgG+Rj3SrjtI+L+MZzpYgslCGRG8nksOIua5mcnj5t
 julvVmnrHiymKrf6ZIYlVnPPWbX51R6eIsZdzJtSSxsA7gfY0wYNScedmlqlVcD5+b45QkyN8u6
 pBcjrKG0bn47QuDIMlBkU98b67H5ybZ8rf/I3kXtzsLRtnbtJNvsBeSY7HflkC3Fgch0XBuNpJT
 sIh8t0eLZnMtDT7gsMBCAsNsCFnUMNi6WI04mza4nuLsqk+2cQkmUzu0xFtVfnyrT1Q==;
Message-ID: <164d15e2-0716-42b2-a0cf-24c01920c3d3@erebion.eu>
Date: Tue, 17 Nov 2026 00:17:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-5-7318a19806eb@erebion.eu>
 <sashiko-outbox-217853@kernel.org>
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
In-Reply-To: <sashiko-outbox-217853@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------t6p4sJ0DekhsS7Y0qI4CcHYM"
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:19 +0000
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
--------------t6p4sJ0DekhsS7Y0qI4CcHYM
Content-Type: multipart/mixed; boundary="------------0tZPo4lL8CnTFVY8TU3dQkrO";
 protected-headers="v1"; hp="clear"
Message-ID: <164d15e2-0716-42b2-a0cf-24c01920c3d3@erebion.eu>
Date: Tue, 17 Nov 2026 00:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-5-7318a19806eb@erebion.eu>
 <sashiko-outbox-217853@kernel.org>
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
In-Reply-To: <sashiko-outbox-217853@kernel.org>

--------------0tZPo4lL8CnTFVY8TU3dQkrO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAxMS8xNy8yNiAwMDoxMSwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4g
VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91
bmQgMSBwb3RlbnRpYWwNCj4gaXNzdWUgdG8gY29uc2lkZXI6DQo+IC0gW0hpZ2hdIGFybTY0
OiBkdHM6IHFjb206IFNpZ25lZC1vZmYtYnkgYW5kIEF1dGhvciB1c2UgaGFuZGxlIGluc3Rl
YWQNCj4gICAgb2YgcmVhbCBuYW1lDQpUaGF0IHdhcyBhbHJlYWR5IGRpc2N1c3NlZCBpbiB2
MiBvZiB0aGlzIHBhdGNoIHNlcmllcy4NCg0KLS0gDQplcmViaW9uDQoNClhNUFA6IGVyZWJp
b25AZXJlYmlvbi5ldQ0KDQpBY2NlcHRlZCBsYW5ndWFnZXM6IEdlcm1hbiwgRW5nbGlzaCwg
U3dlZGlzaCwgTm9yd2VnaWFuLCBEYW5pc2gNCg0K

--------------0tZPo4lL8CnTFVY8TU3dQkrO--

--------------t6p4sJ0DekhsS7Y0qI4CcHYM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQScjKa1EcO/2KYx++uOr0AybgKufQUCavuPJgUDAAAAAAAKCRCOr0AybgKufZkm
AP9tgOKyWc8RQ71BtYVkEtcfvOh48aXD5lW0M7yQ0k27bwD+K05Tukdd8+tnQNcbd7p7yYs7Ba5F
iNgokZsJVqEfwQg=
=uLia
-----END PGP SIGNATURE-----

--------------t6p4sJ0DekhsS7Y0qI4CcHYM--
