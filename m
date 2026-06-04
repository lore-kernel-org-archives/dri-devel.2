Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91637CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E801D112AB9;
	Fri,  5 Jun 2026 07:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=velocifyer.com header.i=@velocifyer.com header.b="HI+tOx+0";
	dkim-atps=neutral
X-Greylist: delayed 530 seconds by postgrey-1.36 at gabe;
 Thu, 04 Jun 2026 22:08:48 UTC
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B6E10E3E8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:08:48 +0000 (UTC)
Message-ID: <8ee8911b-4853-408a-9f8a-a82f77ecdcc1@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
 s=key1; t=1780610397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6/Gd+hPO1hF2+/ExNJ9qqCOla0B377U0QOBDGGo+Wnc=;
 b=HI+tOx+0uAPHfFrtycIHxvqacLE/pBgC5KJoZWC9GxY6XgKDVfbqxQQPslzE3ljVDfjXk+
 3j91xiRGTioWFOCwNmebotC9k6B+ad6Wl6EawtZniIvM/05tkJpEB17uzxqYM4BsQyLLac
 fxNKwzuRq+Ne1cW8RLDVkFgNpJYB6PPVefrc5kkL16Bd58ELjdR8Fmc7XbrcoGL8E7j00C
 oLfAqs6ZR01ph3kwtQ3NN992XU1Vj4dPgwPckpwKL+s8KfSZaQg1ObRKcokW89PfoFjZm2
 3eSV4Gt1CjyIbEZi/ANDN00TJ7F72LBaZOXzHi4TFtTcKdVRka9S2nrQIN6WRQ==
Date: Thu, 4 Jun 2026 17:59:29 -0400
MIME-Version: 1.0
Subject: Re: Why do DRM_PANIC QR codes not use data: URIs?
To: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org
References: <b19f6475-49ca-4b5d-b1f4-7649423be731@velocifyer.com>
 <81912988-012e-4ec7-adf3-27fb69a0839c@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <81912988-012e-4ec7-adf3-27fb69a0839c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LtTgWyXkIKXJR90QVJF2Bik0"
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 05 Jun 2026 07:25:26 +0000
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
--------------LtTgWyXkIKXJR90QVJF2Bik0
Content-Type: multipart/mixed; boundary="------------Mf4WBEzBYmkhPmwC3wuil7U3";
 protected-headers="v1"; hp="clear"
Message-ID: <8ee8911b-4853-408a-9f8a-a82f77ecdcc1@velocifyer.com>
Date: Thu, 4 Jun 2026 17:59:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why do DRM_PANIC QR codes not use data: URIs?
To: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org
References: <b19f6475-49ca-4b5d-b1f4-7649423be731@velocifyer.com>
 <81912988-012e-4ec7-adf3-27fb69a0839c@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
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
In-Reply-To: <81912988-012e-4ec7-adf3-27fb69a0839c@redhat.com>

--------------Mf4WBEzBYmkhPmwC3wuil7U3
Content-Type: multipart/mixed; boundary="------------DAMM0h3Stax96x5GuCv90M3M"

--------------DAMM0h3Stax96x5GuCv90M3M
Content-Type: multipart/alternative;
 boundary="------------2xkUxyw6le34OMXi07Yi0q9u"

--------------2xkUxyw6le34OMXi07Yi0q9u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

IMKgSm9jZWx5biBGYWxlbXBlIHdyb3RlOg0KPiBJZiB5b3Ugc2V0IERSTV9QQU5JQ19TQ1JF
RU5fUVJfQ09ERSBhbmQgbm90IA0KPiBEUk1fUEFOSUNfU0NSRUVOX1FSX0NPREVfVVJMLCB0
aGVuIHRoZSBkYXRhIHdpbGwgYmUgc2V0IGluIHJhdyBpbiB0aGUgDQo+IFFSIGNvZGUsIGFu
ZCB0aGF0IHdvcmtzIG9mZmxpbmUuDQo+DQo+IFRoZSBkcmF3YmFjayBpcyB0aGF0IHRoZSBk
YXRhIGlzIG5vdCBjb21wcmVzc2VkLCBhbmQgbm90IGVmZmljaWVudGx5IA0KPiBlbmNvZGVk
Lg0KPg0KPiBTbyB3aXRoIHpsaWIgY29tcHJlc3NlZCwgeW91IGhhdmUgYWJvdXQgfjc1MDAg
Ynl0ZXMgb2Yga21zZywgYW5kIHdpdGggDQo+IHJhdyBkYXRhLCBpdCdzIG9ubHkgfjI5MDAg
Ynl0ZXMuIA0KDQpZb3UgY291bGQgZW5jb2RlIHRoZSB3ZWJwYWdlICh0byBkZWNvbXByZXNz
IGl0KSBhbG9uZyB3aXRoIHRoZSANCmNvbXByZXNzZWQgbG9nIGluIHRoZSBkYXRhIFVSSS4N
Cg0KDQotLSANCkdlb3JnZSB0cnVseSwg8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/Cd
larwnZWW8J2Vow0KSW1wcm92ZSB5b3VyIHdpZmkgcmVjZXB0aW9uIGZvciBmcmVlIA0KPGh0
dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9TFk4V2k3WFJYQ0E+IChMaWJyZSBKUyB2
ZXJzaW9uIA0KPGh0dHBzOi8vcmVkaXJlY3QuaW52aWRpb3VzLmlvL3dhdGNoP3Y9TFk4V2k3
WFJYQ0E+KQ0KVGhpcyBlbWFpbCBkb2VzIG5vdCBjb25zdGl0dXRlIGEgbGVnYWxseSBiaW5k
aW5nIGNvbnRyYWN0DQpNeSBPcGVuUEdQIGtleSBpcyAxQkEwIEZDNEIgODBFMCBGMjFCIDAy
NjkgOENFRSA2MzRFIEJGODcgNDBDNyA0OEJFIA0KPGh0dHBzOi8vYmxvZy52ZWxvY2lmeWVy
LmNvbS9wZ3AtY2VydGlmaWNhdGUuYXNjPi4gUGxlYXNlIHNpZ24gaXQhDQpSZW1lbWJlciB0
byByZXBseSBhbGwgb24gbWFpbGluZyBsaXN0cyAodGhpcyBpcyBoZXJlIHNvIGkgZG9uJ3Qg
Zm9yZ2V0IA0KdG8gdXNlIHJlcGx5IGFsbCkoSWYgeW91IGFyZSByZWFkaW5nIHRoaXMgaSBm
b3Jnb3QgdG8gcmVtb3ZlIGl0KQ0K
--------------2xkUxyw6le34OMXi07Yi0q9u
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">=C2=A0Jocelyn Falempe wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:81912988-012e-4ec7-adf3-27fb69a0839c@redhat.com">If you=

      set DRM_PANIC_SCREEN_QR_CODE and not DRM_PANIC_SCREEN_QR_CODE_URL,
      then the data will be set in raw in the QR code, and that works
      offline.
      <br>
      <br>
      The drawback is that the data is not compressed, and not
      efficiently encoded.
      <br>
      <br>
      So with zlib compressed, you have about ~7500 bytes of kmsg, and
      with raw data, it's only ~2900 bytes.=C2=A0</blockquote>
    <p>You could encode the webpage (to decompress it) along with the
      compressed log in the data URI.</p>
    <p><br>
    </p>
    <div class=3D"moz-signature">-- <br>
      George truly, =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=9D=F0=9D=95=A0=F0=9D=
=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=F0=9D=95=A3 <br>
      <a href=3D"https://www.youtube.com/watch?v=3DLY8Wi7XRXCA">Improve y=
our
        wifi reception for free</a> (<a
        href=3D"https://redirect.invidious.io/watch?v=3DLY8Wi7XRXCA">Libr=
e
        JS version</a>)<br>
      This email does not constitute a legally binding contract<br>
      My OpenPGP key is <a
        href=3D"https://blog.velocifyer.com/pgp-certificate.asc">1BA0 FC4=
B
        80E0 F21B 0269 8CEE 634E BF87 40C7 48BE</a>. Please sign it! <br>=

      Remember to reply all on mailing lists (this is here so i don't
      forget to use reply all)(If you are reading this i forgot to
      remove it)</div>
  </body>
</html>

--------------2xkUxyw6le34OMXi07Yi0q9u--

--------------DAMM0h3Stax96x5GuCv90M3M
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

--------------DAMM0h3Stax96x5GuCv90M3M--

--------------Mf4WBEzBYmkhPmwC3wuil7U3--

--------------LtTgWyXkIKXJR90QVJF2Bik0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaiH1QQAKCRBjTr+HQMdI
vrwNAQCNjJ4GCtioKvH7JDZRJdKBilhaW4zBZ30nr3lGJuv0LQEAvqUD930JE+au
HllAqePd/M77fckAVKyofbTnRQWYSAU=
=9r/u
-----END PGP SIGNATURE-----

--------------LtTgWyXkIKXJR90QVJF2Bik0--
