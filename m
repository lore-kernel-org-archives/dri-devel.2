Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A0606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=YEb/vfRv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A560210FAA0;
	Fri, 27 Nov 2026 06:06:50 +0000 (UTC)
X-Greylist: delayed 359 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 06:06:43 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96AD10FE16;
 Fri, 27 Nov 2026 06:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1795759591;
 bh=W5orpNQRwzUsBFtBd4lKgk0noKXsQvGISmKxvFmwlXQ=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=YEb/vfRvf1b3fqTE+FxhigroNhRGfiUpWpCuVo4FK4SC434MFHyEXAE6Q6YWgHZI0
 QSx4yHK9eKQLBBQ90ATa0Bp/visi2GxUFD3rZdEidqf5pcRMUOimSXXRcAJAImzLuu
 TUUnXcQgHbEiuRajxINRE1rSAGdcRAYtL5LcEt+M=
X-QQ-mid: zesmtpgz6t1795759198t02bcd124
X-QQ-Originating-IP: CyiqXhML3xAjxSMuZRfc6KNxWUfRG9AMsUIeo1bcios=
Received: from = ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 27 Nov 2026 13:59:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5876352062716450279
EX-QQ-RecipientCnt: 25
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d1ae752c97959d5b8d8cd87d8f8f5410d469b0ecca2088ec5a8e5567b25f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 27 Nov 2026 05:59:54 +0000
Message-Id: <DN5RI93NOUY6.2TXJX73EU84KJ@linux.spacemit.com>
Cc: "Alessio Belle" <alessio.belle@imgtec.com>, "Luigi Santivetti"
 <luigi.santivetti@imgtec.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Troy
 Mitchell" <troy.mitchell@linux.spacemit.com>, "Baihui Liang"
 <liangbaihui@linux.spacemit.com>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>
Subject: Re: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Mah=C3=A9?= <frederic.mahe@cirad.fr>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
 <20261122184434.545341-1-frederic.mahe@cirad.fr>
 <CABdCQ=PnfXRd2=b6_yEN94RCRvPnWx-WFfHZDC+jhHv_UFZ1ZQ@mail.gmail.com>
In-Reply-To: <CABdCQ=PnfXRd2=b6_yEN94RCRvPnWx-WFfHZDC+jhHv_UFZ1ZQ@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OfSYiviZO9YdSw/fraq/qCz5X8J9mfHRFdElKL3Juy9tNfBq7vBSM9S6
 dYah+jNfYfKXywlzpSbyRT3HzWQ6DVLcJeyLIOpyoIzv/shflOcLlQ8c4dnzFZt/Pox1GZ1
 Bhf/n0B3J3UcfLqw0a4098vN2AD1KcHqMvSy/oPvKyU0KytpMGddbdNb+dBm/OhVjPFtYOC
 yBOdyp6XSJLsvd9abL6Hvj7uCw1aAukwe3K4lscjOE8R8EucSXKu5ybTrLGRgaM/PiRICY/
 RyYTJIeXkN+AbFfnUI6D2aP2CGOzPCrAVhOe/0yyGL7sHQNUo7jMuYmB3qEDlOsuXww44D5
 gpISBgx7JLtKm3w1jU1zfCmza2n6GzbFbjwdJVXUAdtqb2avKkg1xQ3O65Z+BAri59+L9DX
 K6eF7ObeKgeaYeDZdjInmxjBm7NQs28OVuJv0AZBaMSNc8XjofiQl3PwOafSKDU5UZPYMEA
 FfNDe3TeTGV9Z5V4I98iwPPhLVt/P6WC7V0qEGX3bIXFWNjrI4H7yrCbWvH9W+FKVNOraBX
 aBdmoCAcXZjg7hqP9KyGV7YN7JBuwJkRldLcxr6dWd+LWUJgNulQZOPsGiXw3OBmHZuaWig
 Ovv2lF6HYNf5fzT+IaPRV6pmfbIc20bwfKf0N5xOgfzUEyfX0VXR+ctYBHUithmsKgRIqGh
 0gIagM2TIGL1Mn+tf7q9DTnB/PzQ68eQNcGR5yRJboLFXUCDTAdNZfTeO5DN8ZleoP4GG+Y
 tkVF6WqOFV0seOa4iQFpHiqgNY1x7+iXEMD5GzcjHkobzxS9Bit9h9AatUQhT1pCKIqJqWH
 gMNImzV53aMyWf1zqKnOy4j/K0IVXiTkaKlTazuDL97yFvs4d1zWgIUpU2yljOZ0tpD2JT/
 +/oYbpvfDAzWgV/UmstFMU8HkbKb8EJ305KuCUw2p9Jb7y4obkcRiR9T7erUksLYmPlnl9n
 ztF8M+YFruxLZAfuNMrnsCWTlf6VjnDUcee4QyTxE3ItfyE3XaTzV3iOmZYW78DZeZP6qkM
 KLOaNbwQ6xF1DrdVEYGVBC9P9JNgyFTq/OQyRfNB71qeprEOPwIIWjSBpyiEzWjZmnAiihu
 Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--d1ae752c97959d5b8d8cd87d8f8f5410d469b0ecca2088ec5a8e5567b25f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 23, 2026 at 6:41 PM GMT, Iker Pedrosa wrote:
> Hi Fr=C3=A9d=C3=A9ric,
>
> Thanks for testing this on the BPI-F3!
>
>> Two notes:
>>
>> - On v7.4-rc1 the driver refuses the GPU ("Unknown GPU! Set
>>   'exp_hw_support' to bypass this check"); with
>>   powervr.exp_hw_support=3D1 it works as above. Is a driver patch
>>   adding the K1 GPU pending somewhere?
>
> You're right. I forgot to mention in the cover letter that I was loading
> the module with:
> sudo modprobe powervr exp_hw_support=3D1
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--d1ae752c97959d5b8d8cd87d8f8f5410d469b0ecca2088ec5a8e5567b25f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCawkcWiEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9jPwEAkEDYQ/DUZqdM
7fO73JXCHzzyxH2RSvNzzjPHVh6TJCAA/jY1bbDX9rE04bGONDjWVzwEHNrfpRKP
pCll1aV1PnkD
=NZI6
-----END PGP SIGNATURE-----

--d1ae752c97959d5b8d8cd87d8f8f5410d469b0ecca2088ec5a8e5567b25f--
