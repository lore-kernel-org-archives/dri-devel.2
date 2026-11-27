Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4E606A336
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=MqoaPRnM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B661128FB;
	Fri, 27 Nov 2026 10:52:21 +0000 (UTC)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49771128FB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:52:13 +0000 (UTC)
Received: from hawking.lan (ntp.lan [10.0.1.1])
 by www.nmnhosting.com (Postfix) with ESMTPSA id 7BF464C990;
 Fri, 27 Nov 2026 21:52:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795776729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U5UWhZwhfOwBecIRseR9hgdutFja5ObnqmEgqdaERIc=;
 b=MqoaPRnM0yPfNaJQzZcIEVJ57++JGsBpflZQeYs69AEZ8X427aH6Vw99pK9B0Y7axwNhxr
 rZDRbeRXw9Ue3Rsj4JwHC8nQ5njYKENG8LK4+Jik1KfutRKPKEgg0LoNDFmOEKvttuTGQj
 NC4g7QRorkjUoAkOVwPw6fnvfnl33EwGJudSb+IpFH8nB5QzR66WswHQqGympHi/kGBa3f
 Jx9HDq97s8kztWD6BSPlR8zkOTK9JMlSwMHcgee6yo0dQfqlRWA7vPhSDmMfTx2eVldyI1
 tR0U9ElwLqvQz9j9SPthD4pTFNSTOvkTu3ICgNCwRcdLj3dX82qw7lP0xQ9edA==
Message-ID: <de646ea81e92792caf6644716ac91399a8b6b677.camel@d-silva.org>
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
Date: Fri, 27 Nov 2026 21:52:09 +1100
In-Reply-To: <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
References: <20261127080649.1982883-1-alastair@d-silva.org>
 <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
 <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
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

On Fri, 2026-11-27 at 21:20 +1100, Alastair D'Silva wrote:
>=20
> On Fri, 2026-11-27 at 10:03 +0000, Andre Przywara wrote:
> > Hi,
> >=20
> > On 11/27/26 09:06, Alastair D'Silva wrote:
> > > This series adds boot-time simplefb HDMI support for Allwinner A733
> > > (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
> >=20
> > Where does it do that and which U-Boot version does?
> >=20

Oh, I forgot to answer this, this was going to be a follow-up on the
opi4pro series to U-Boot, once the base implementation was accepted.

It's on my Github, but I haven't posted it to the list yet.

Cheers,

--=20
Alastair D'Silva
