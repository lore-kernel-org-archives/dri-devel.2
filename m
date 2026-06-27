Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6FBC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 09:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB84410E489;
	Sat, 27 Jun 2026 09:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="DCwrv5D7";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8E210E489
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782553412; x=1783158212; i=markus.elfring@web.de;
 bh=VwFrM84IIW0ScsqmzakXCjPu5EYta+yPCspaEM0iIWs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DCwrv5D77qknXz1YD5xe28ibXPRSQsozJC3b3ryp+B0lNfvJGEKv6DBPpLyA8xUg
 lChP8awyS+drd3Hd7kNo8LhSwoTfQwj9XKmthMHZ6UBVG4B9azfri9zyvN9pXJKMZ
 PllkT/1A3PWgbq4Kg3DFHx8ctqj9ZM0u8QC+rlhwC1H7uvRN8LShhDHYfRfRSg9Oi
 3GE9AEDGwrUA9spZTIaxElBO7CQEfmtrsVJcjbgQdwzgdSkrlBPsfkcnzsR2zC62L
 uQYzpFJDTFfAfiCyog/XNzu2Vvb6a9L0Emnvjs3i9jAEySsz4tOVQ2kVfd3M1wVxb
 NBY3FNJUHE1QAIeqsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Madzi-1x9iBi0XOs-00leV3; Sat, 27
 Jun 2026 11:43:32 +0200
Message-ID: <dcc01255-8c9a-41db-80b8-e4482ec12789@web.de>
Date: Sat, 27 Jun 2026 11:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ziran Zhang <zhangcoder@yeah.net>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20260627092612.5282-1-zhangcoder@yeah.net>
Subject: Re: [PATCH] drm/amd/display: Remove redundant NULL check before
 kfree() in mod_power_create()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260627092612.5282-1-zhangcoder@yeah.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mLO3IeX7+Hca+FJxe+W2jIjNN7bs+PDUcU1XFopa3dzFPqfpkD9
 GOGAegJqZCDGbx1nWbbw6s/FMB4NubPAgyghs4iQf69I21wDju7VwGmkZnIY8etFu21Kvfj
 uBRPAO9u5UXNs7Phy83tllgeHDNmAIcsFo05YjAGbWVpaPGw6tilI8MmvQYLX/hJ0bDaxPG
 z8RtBJ8gCdNZm6DIqRzXw==
UI-OutboundReport: notjunk:1;M01:P0:Qj/s4AqT0lQ=;gfHHixdldKZRmp0wBz70F5t/zG8
 5+MZdSKaTwvDRB1UkHBroOM4JTB/lrn2CUfa4fbiAHUHYsKflyjQGf6Ekb0qGXvMuH8o1dtYH
 B3o39plzKYxjsvQmEFwqkNfS37dDsBzfIuBYY9LbSW/GtKLuo6jEfn/0q6XPlof4B2nzCrXk4
 LTRCgWNYwHPrAtNfCDJm1a+S7LZDpudEadPWAVXG5cv8sAoPnzfZ0BNJ3yXbIUTuAGdzTwKev
 ru0c5otb89gqzqbiPnlOu+gxcvumTM2OwWOw4Eq1RLn1SNmlHMMDpA5//Zl71jYPdP00fnMft
 bcP7sazVvktYAkhBGjZVvFlHKZNDvtu5l7GANA7qhCKoeAuWwaU1JXU+xEQ6BvqdjAWONM7Vt
 aCxPEgMsuzxyDuNbJvOaTpFMDFWRbCCjxSp0KRCyvkuxCimcJWp//kCLbYaJVhm9LJJHkx+b8
 kBYYrhRSlNJVHjh+7BWGWyXDH9QKfMaEn6s/I+0FUWoqT7Sd3GRRS+hXh8rpfCMKenz4qduH7
 VQreqXN7CW3fc/GgDoYVvpwoHhZz0pxtjr/6Q3yDTJps03+Ep5GxNQun7UOCRr3fpGa1xW298
 Id+Vyeq3lJbhQFGDhv4qFmgd2TD9tVW0IGK/amKoIUGVARM2Gau3QaqJxUq/E95wO/PsfYnRl
 nO0UPb8ZuusfvZK9aJCcKTQvRqRJjd8/Rhc+5oxBfM6QGTsskMS5ZfedWmE3cCsMcNVAATcTa
 49oWftfZROlXzFsG6c8X0bQqgMGEuABcNybPTfXMd7eNurlYNawTSbFoAyhUsZ9O61wGSdgkc
 j3KkDUQGR/7Wha0KsEuIQxKgqq2nmnPC5sB87weYQ8rE2qWg8TEHmDN/i4zWcpJtH/OkHJ37W
 Fra2zxGlYKLi9MyLBO3QztwIbfMFfxi6eY55jc2tEZZDLTMGbHXIMqXZI19k1SV37kOpsV0KF
 BiyIme4F4UpmKFd3rwnDtDZPZhdL1Cw3VTBjk9tXk87PZvLkwX58ydKhzehFNqjKAfxMkiHR1
 YDuVO40bfIIkO43LPPEsQfQHjkaOcY7aPcTTuSx7IGYvgWIGn5sQEJc4WAI4Py/kk604W27hM
 G/4X/0dkVQnYLsGxPFPTz2sr93OyOBaJH6oVTuxeuqBS4uUCU6GBV7epDQha1gUVZJkVBkwwi
 c26TB0++NADZ9zWYlCrDzBkqQi1VxglDd+RN8BCCEFoD3qytRHPEoJX8kwhkKJMsiKUqMyuUC
 EhF9dnFfQLNg86OLQFrGXshHEAmAx2e6VTyeny333xfXc2Xo9JvwTCgXDrbtaJaE+Y6iC9tyz
 WttrRqqReV8aGfRN792rWZx1HpCEdAqmA6HN2wMI7hqvlRXGsvqqg1VvI/3wNireS5BO4TFfB
 Z5P6/Ot0Otg+cqWmnHI9GtmnwehcxPNkWE/5sKa9Z1+DLRRwigrp4+m6gZE7xf6A1qyvd4CYR
 wUfRBN0tFjraGCdJGnLHuOXjHM29Mv8Cztrri/QDCR33dqm87oUoW00Ub82vNgs+1J3Q4+Ojj
 dtC2PcfNQdEweM2KVKHB0C7liUtAKDSD3ctqrOeCQjtlQa3Eegy1yseu+OZ+ZFgA+1+G70XHh
 ie5HLQ3+C5xElTEqg1hKTvgmOOMZDRFh9em03pbHplWSz2tbz/RIG6pFlynByDbsJhr/AHA9P
 U1boNuSxYOOd8UhgS0SRfzTGeXa8JDhaenJYhbYX6ef4UAfrXay+JbMO2Bqjj3z8Hen+8wiz+
 TpTIhziDMNsrZua4d7TymImJnhqr0hTHFo/4Z6XaN4xeI+QkKHaz9sRfdTkXEDPy+rcAxs5wC
 UhJxIm7ABrLu7RTPxhJHPQb7PbyO1Tj6BPpmjIn+pLmss9uNpkW2YTaDMMlSGIlRN0Kg7JEuH
 WW4fv/LjGTcUgixmfJq1Xbg/TyqKoEMMulEUv2i0+G6ctff1/lgWo/Bnf3O/XN6RKjs/203MM
 HSh2cR5TKu0LF+bsj4Jim1tA05Lxe7oheZ2EOkl4XzVCVGR3pIA0xrSVUMuHQlghT6uITazhR
 8gfjrCMA2YI8LcJ39Ad+BkqMlkt/PWnQ7sbC9N/CCfQRwpgwDkJMK1IINwI7nA+2TC/uhVXlM
 AEV8vpo1kDbiP2WZUjPdFfoRxm+uUNUeIlSYP0Pd3sml+9qlxlU2xK4y6DoztpdkL3IkmJjtG
 n9PhE2pMLw2h9GpMHrtgWm+or+oSphqcSGPK7gfqa8qmlGnKu0ilEuONky3XBuLEt40IOloI3
 Bj8CX6ud2YmmUetkCN9vUaJZiApSi/W1Uc/QI5URUjRcrVyQ2AtfQBnYZAI7odMMEpJEz7GPL
 suNvC5bZLqcShMt72IZJ6QYWohjJzfz9n6OBEwn/A8u5aO/YkhGHct0enU/VxaWhm+pxRV19X
 KB7yo+2DIaF6MO1RbNV38LMqm2aDkelIm0LXXFhIsn7k31IG1BSj/UgB3F76HcaGQHwwqSdyY
 SYyK6uGDip7EQb6Bmo6REsORMCqRPq6q7lIYF3OhEnSA2t8ZFgK+5CkBsQPIJq+nkUcZmHrcg
 uPpqzs0Va67JzMxUnWOm8xvVAWJ3y623pD/Vi15avI9R6gMrX+CeNjDC3ERWg1BSl81vdjCW2
 BYu+T4zFCWs5SDlVIclCkQITC3R6civP9/Vl91YZjVsl8XGtgLTcZ/qfcXMsPNcFgI6Nl1UPm
 /bFzndGlszur2ZwEVsjgoDj+KXCaUTnKwXLb5aQiHEGimUzlZ/smmQq5GEV7tLsdQyBuR0bJF
 INIykvVFfw65D6hZywTQCkCULDDNH37EuF55+ThC4OzHnpwYCsJuhxKoGVEVbbhen3Zlj0tXx
 PfoyPYL1Y5wwpbN+MecdUPAAA88Qi5k2SCPVVlU7INpGdS6v1+tGEORsvCemoHoi+nSH+IUKF
 lJYPhz04QC0waoOMrVo6T90DR28imSHtXurcKju9UqUq1vrGx4bVdfyqKS9KXiji/74uE9qEw
 VQB1pCJhIHPTg58p+4OVIfmxP5Hyjp2Wv2AEWWVNlBAqJKzmXOjmD9kYikxPvUWTj2wbtjjX+
 Q7tJxOUQWsSDGqkwTvmHUsAT4cJAdZfPP38NjkR3Fr1DwGjquqQr87TMtwfc5Kl3W1feiVEfd
 wPBurJwUg38qSwEfcaaDLTIwAl4XesYLjWUIorskvIionAmH87iKqn1akZOnsqt2rZf6Y/5S0
 Dh3+TBXpXwHq/SND+TTailmEkOvwiN104rATzUIPijA6t1XF4fWNrfpaczMBegGRM3by+y0ST
 6zBj1OM69crh0TJQBBnbXL96GsmEt4RmhFlD1Epw5jvxacd2DxUTgcIDCMPsFVEdwCyAu61DK
 4itH3qX8kdcX3bqGWrP28eACN/ryamroa8Mz+qjzwlTWvlKbGltLQNYTDZHRlbpBhJtkBeK93
 7+NrICenhj3QgK+Ch7l4P8h1LwNxWyZBS8tvxukDUEWt11BsJEFhi2LWf2oZeABimGExvgs4V
 8QfqfT8gsh2us+wLn6xu1bZwSOdR5YDmPm6vGrazT3h86VzfTIO5dghDZ1gYx6VRX3ulVXR6p
 /mqOz/Lx7Kv1GnBbtyvlXYrV05EEnH7HVlo9ro/QafVgS7odEwRnrB2hZoCf8mSLxtfTp2A5T
 qOlF9y2g9+ZbvoNM2s3mBWEYzgUzqNA308ibboMsjdB7XjsGSjH2PkCHaIWNcLL1Ic4eZNCad
 PhzMUdXFD6/a+PL7d8USpXtINHHjaZ925au/K5gPokPyxoxOfXCKeu9s91Sth2LaRQ+gRmahi
 EVXGpFoRVgQ54Z6zJ8QqMf1gqMM/M8xz3as4VdW+g0OpX6Tm0OEQBLry54/axchXPTm2h5BBN
 yd6AyV0LA3q8a/2zQsxLlsaerzJdWu/u66oQykpPGb3aZUm4oSnum053qvTp+OSZHYaCWl8NC
 UnGrHvQGtMuQlQ1CUdXn/ySRD6eoaJuGS7bf7MRyDbWtezKzSn1BlBdNM3zPjtGNb+T9CYgXw
 yF3VlKB0nsW+pW0n3kp3ppRdWt9/pgrEW8Xsz+AHLKE7jx0fFxtRQYFQRbMiDl9qhBC6Y82sj
 YTmSgV18yTPjGmMvqpFJvBF8IX1kqaHQmQ3QfJHccT+1r8DPB9iDxObNAt52MbQL7hgTM08Nl
 OOfgxtQfNXQclGIzYRUeyB1ZmNYo9C/7pxnWm5BoU/uEBTBtY0LLyTqgffkaHtXMPisRl9YSN
 vuRhYJGhjgWDFlV7IDmpyblihcvACLrKwQb4n78Bqgyq7KORTlm6lYsqr9HpfQi9B+CzWm9d6
 rhn2uMR6m56oAiviz/cnCmBrcrUmuLy8n7vXTkPGH8HjINSbfaYxscEUiwEK9rpgnTSClzx1S
 13ogULk9NTW9PXoommvkV3I0QRQPDJ617HWXjdJqa+NE0BR6w1m9N0GPkJLSbZ72CG/KbWREs
 q6r4VcvU4J49hCHbGHW2zzs9g6B3ZP6JeLoagGTo8j4Eps04BxEMMadqaKhloOyOsQYK08RiS
 Xg4Y7pxeGSCx+FqKuvbuNM+NFBxcOYw3Jz4nIDlUwcQ3KNVgi/AW/IiiSe0/JPj+3Iytgp3Rx
 0zynagn+lLl2GuCvSdMTIjixMTo0Mp3g2i3ILM2UFj+V18maHS6G0R1F9W++EBATR8fNm7oro
 oucs7jV/Idj4FWbA0uYupbyuiSNzglq45MEacyE23LU74y9DlFbce98YfGRz20OeSBVrhJKhs
 L6r7oedURPAUdvo0mPFfU/hnpKzpthh5g3g7GlGZzif4CNu0iu2vMJ2DnPndfi2vJZ2UZZ2pn
 eV1JK9K2K+Uof2d2G3iEb8EtAwcrGVS9nxNTH+UfHELDh7MY0Qq0seGs2k/dcEsnuSKtFXHWp
 jDpBOTnncGro+pXFDt8/XH3DpUz4+ex2vPRYGxKfIr8yWVZp2gbmRV0cKQagXFP7zmXLsK+YK
 LY7w4/yG7UleG8cntn4xWLwKNb1umZSoZTI253cnBzEcMC8IEd9KCcIllnj55DlrKoSvnVbld
 mcFHswzvQSXW4ht2FVZwloSiL3FK+DfUbPtiMKwI6k0ukNJpLRHdMY7F2yG/3jVsZGfmiuk5T
 G8wJPoasBbQ9JCsXRghkNte2IPxYgUUMeD1XPqMV6V5qNTBLUDSW6kttxhnQV+bpFj8rTNSoS
 TzzKJdloTXaR5MkXCtEu8nRhZRuVwxMdXNJbOwebScBgYMEKSIjaE7f32WahkLOJhOy9IWHIn
 C3YIp+hiPTDlFUegA2YZb0Cw7tDd0gX4At10+X2JYUSntLEAgs1YbzXtxEdX2ugNvVX7Vdzez
 /EEtE1Fry5rPPBO/IoBAiQLqLeJmRy51tR3fogwJCtfEUo0ghPaYWy0snSd2qI67cPeio7efD
 dax8znhxUmUSQdiKI79+CnPhck7DAkJV3FpiR0Rdw+1eZoYYEjloUOsOHOdD3oVLTeLktOqBy
 zbh1XZmtDE1haM7CRS+UTsBjD2ofeYOrduKj3QcHB+SqqiEVdEexRC0N2Rz8EYRZUq7RmkH/w
 nDk1btWlUf4NGREGT7xVc8oqO9BnPwRmoxcenndLm/it58ae6Z2yY45RsIAFpSTwF+A0fHX0h
 vVNgTOiyTDzV9KaAFr9h5tmhdoXRKA5yhasZlZwQG3kG95rKQFGZdXAdCWrbNzY2SeyP9Z/D+
 Hunl256JjNNHw51kD1p976ltXv7gsffEsyBvu8cBN5MjBHg7yMYdCU9tOF/nyq8j/txnLSai3
 d0otPFiYM=
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

=E2=80=A6
> +++ b/drivers/gpu/drm/amd/display/modules/power/power.c
> @@ -270,12 +270,10 @@ struct mod_power *mod_power_create(struct dc *dc,
>  fail_bad_brightness_range:
=E2=80=A6
>  fail_construct:
>  	for (i =3D 0; i < MOD_POWER_MAX_CONCURRENT_STREAMS; i++) {
> -		if (core_power->map[i].psr_context)
> -			kfree(core_power->map[i].psr_context);
> +		kfree(core_power->map[i].psr_context);
>  	}

May curly brackets be omitted here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.1#n197

Regards,
Markus
