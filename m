Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C67606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=frqg7u12
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094401129F6;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35641129BC
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:20:07 +0000 (UTC)
Received: from hawking.lan (ntp.lan [10.0.1.1])
 by www.nmnhosting.com (Postfix) with ESMTPSA id 81CA04C98B;
 Fri, 27 Nov 2026 21:20:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795774802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4bRI/HlfaIFeVBcrXtuaps8yKtfTuJ9r+oTx9rX7+c=;
 b=frqg7u12UiCu3yQn8J4hgJpeBpHnc53t8X+L4mwl6fHURENZfSMgHu1IW7o5JroQ0hmdZd
 Q6k0MAQrAbufNql1iTN0jToGJcLfoa0375w4GoG0ATC/pnEYwNnL4PYJPKw69gBxo3SwHo
 cvH/QrMBgevZzgTov/Eg479W57ewjt+aPmqli15Au7+lMtvXkv9Q/SV/nkjUrM2fhaV0Qy
 IHge2OjJLy8/yRga0ljp/enQjvIWhUP1V5JYCi8joXVfENvF0EYCPQIvMVWxpa35CM61yD
 0JK74iDTsfYyUVUa99rlVa0XIIj+TRHWXlaAY2tbmNENi0Qi5T1ANJeK5yc6jw==
Message-ID: <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb
 HDMI support
From: Alastair D'Silva <alastair@d-silva.org>
To: Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hansg@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland	 <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
Date: Fri, 27 Nov 2026 21:20:02 +1100
In-Reply-To: <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
References: <20261127080649.1982883-1-alastair@d-silva.org>
 <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 2026-11-27 at 10:03 +0000, Andre Przywara wrote:
> Hi,
>=20
> On 11/27/26 09:06, Alastair D'Silva wrote:
> > This series adds boot-time simplefb HDMI support for Allwinner A733
> > (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
>=20
> Where does it do that and which U-Boot version does?
> I don't think we really want simplefb in the mainline DTs any more,=20
> unless there is a big blocker or delay for proper Linux DE support (like=
=20
> there was back in the A64 days).
> In Jernej's HDMI series he hints about A733 support being pretty=20
> straight-forward with the reworked H616 DE code, so chances are we see=
=20
> proper DE3.5 support in DRM rather sooner than later.
>=20
> Cheers,
> Andre
>=20

I think the blocker was firmware for DE for this SoC - it can be ripped out
of the Orange Pi OS blobs, but that won't be acceptable for linux-firmware.

I'm currently reverse engineering the GPU firmware blob, it's not very larg=
e,
and is a well understood instruction set (MIPs) so that may be a path forwa=
rd
without the vendor contributing the blob to linux-firmware themselves.

--=20
Alastair D'Silva
