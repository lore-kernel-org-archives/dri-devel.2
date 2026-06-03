Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E00ECD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36CA11270A;
	Thu,  4 Jun 2026 07:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=velocifyer.com header.i=@velocifyer.com header.b="GwivcvDl";
	dkim-atps=neutral
X-Greylist: delayed 350 seconds by postgrey-1.36 at gabe;
 Wed, 03 Jun 2026 14:26:47 UTC
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [95.215.58.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BF410FF11
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:26:47 +0000 (UTC)
Message-ID: <b19f6475-49ca-4b5d-b1f4-7649423be731@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
 s=key1; t=1780496455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=iKq3J5FR2e+kOfwHPoIJCB8F9ZhdjmFwpVq4uP2+JRk=;
 b=GwivcvDlDzKaEshIQ26T0jNkdVf5fJowh5boI3klNcMbIRvISTG9w/apCd5YuZGq6uU9Xk
 W9fISk2UGlaiihAZBSL2IJDOVdZBqGqBw+MlI+ogMbZ5zhlMAAGe07Gwh7/ltfrzeIUwlT
 ObkEMBKRv5chjcqwJrBZlsRzZhcZEAs9U/BGDJi949yMVfZFlUrbCgudNvwwGkir2XcS9R
 osRvDBeIeT91p2qs/mq3k7GjkpMpLAUf/9FszBfYWVe5VOMta5IWwhUAG9W4e1iHMs/gJZ
 b8X2h6oEg2hzWBb+Z6ByLlfTDC0xwckbvcN3cF84LEesY7MCUmTfGiqHIJ32jg==
Date: Wed, 3 Jun 2026 10:20:32 -0400
MIME-Version: 1.0
To: dri-devel@lists.freedesktop.org
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Subject: Why do DRM_PANIC QR codes not use data: URIs?
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------neuqi9w0f1eFtSa0nlhC5RJy"
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:30 +0000
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------neuqi9w0f1eFtSa0nlhC5RJy
Content-Type: multipart/mixed; boundary="------------ZJ6s11GSBs8xDq1IlHz2haYh";
 protected-headers="v1"; hp="clear"
Message-ID: <b19f6475-49ca-4b5d-b1f4-7649423be731@velocifyer.com>
Date: Wed, 3 Jun 2026 10:20:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org
Content-Language: en-US
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Subject: Why do DRM_PANIC QR codes not use data: URIs?
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
Disposition-Notification-To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa?=
 =?UTF-8?B?8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>

--------------ZJ6s11GSBs8xDq1IlHz2haYh
Content-Type: multipart/mixed; boundary="------------Nqd7vhW3c4LQz3GYUjXYdBI2"

--------------Nqd7vhW3c4LQz3GYUjXYdBI2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

V2h5IGRvIHRoZXkgbm90IHVzZSBkYXRhOiBVUklzIHNvIHRoYXQgaXQgd29ya3Mgb2ZmbGlu
ZT8NCg0KLS0gDQpHZW9yZ2UgdHJ1bHksIPCdlY3wnZWW8J2VnfCdlaDwnZWU8J2VmvCdlZfw
nZWq8J2VlvCdlaMNCkltcHJvdmUgeW91ciB3aWZpIHJlY2VwdGlvbiBmb3IgZnJlZSANCjxo
dHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PUxZOFdpN1hSWENBPiAoTGlicmUgSlMg
dmVyc2lvbiANCjxodHRwczovL3JlZGlyZWN0LmludmlkaW91cy5pby93YXRjaD92PUxZOFdp
N1hSWENBPikNClRoaXMgZW1haWwgZG9lcyBub3QgY29uc3RpdHV0ZSBhIGxlZ2FsbHkgYmlu
ZGluZyBjb250cmFjdA0KTXkgT3BlblBHUCBrZXkgaXMgMUJBMCBGQzRCIDgwRTAgRjIxQiAw
MjY5IDhDRUUgNjM0RSBCRjg3IDQwQzcgNDhCRSANCjxodHRwczovL2Jsb2cudmVsb2NpZnll
ci5jb20vcGdwLWNlcnRpZmljYXRlLmFzYz4NCg0K
--------------Nqd7vhW3c4LQz3GYUjXYdBI2
Content-Type: application/pgp-keys; name="OpenPGP_0x634EBF8740C748BE.asc"
Content-Disposition: attachment; filename="OpenPGP_0x634EBF8740C748BE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mx
aYk/dyrNJlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8E
ExYIADcWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgH
BRUICQoLBRYCAwEAAAoJEGNOv4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78Z
qEwGegVCRerWry8RAQC3MJUOiyQ062Ol/3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44
BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/yXp135G4fhWjJH7VQkPIFo8/M
sZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dAx0i+BQJoKkSFBQkF
o5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9SpvhlveEFpUMP
aQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ=3D=3D
=3DtVgn
-----END PGP PUBLIC KEY BLOCK-----

--------------Nqd7vhW3c4LQz3GYUjXYdBI2--

--------------ZJ6s11GSBs8xDq1IlHz2haYh--

--------------neuqi9w0f1eFtSa0nlhC5RJy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaiA4MQAKCRBjTr+HQMdI
vt6VAQCm0LxML6oBswd1dPFFbc/Ys+fNgnvhvyoOC1MNP1iflQEAvwg9a35Lfu8/
kToOd3q/JXVUW3uZkWVKmq5ebrmrgQU=
=iD7A
-----END PGP SIGNATURE-----

--------------neuqi9w0f1eFtSa0nlhC5RJy--
