Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D89606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=f2kZooiu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239D510E84D;
	Sun, 25 Oct 2026 07:57:23 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399D510E84D
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792915028; x=1793519828; i=deller@gmx.de;
 bh=grHidBPutnkGDcj04bvMwuBcXQh8bAFQUwYSYbKKxd0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=f2kZooiuZ4odDfCsg8p62TYztStEx4/xoRc0pVa5a9vmnr/M8Ayce0O27LCngqEy
 P6n5PXjeu2Cdghh1ZvU5SxtjQF6+jY6GzLJ4CT/r0S6OFb2Vo1OvAm0kxydYSyV9J
 qWTHRL5Oq9XLQlVGNX+sT2956eOWqVyS4hVbHm6sZz+N4PipZNbk984AQtOF8PhEm
 BJKx/BNYpdauwvvC2i2iX/2fS3R6MxvoDqt6EK5yrshnYN7sq8dreE4jkdV2TkU7u
 q6L/UEfxAq3HRmqBEyRnlmGUHbY12niTwW1IUo3F5Q3eGO9LO2aULEA74ZYXtkx42
 scpJFxR5rfB3Tjs7Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1wdqBD3XTg-00qcoM; Sun, 25
 Oct 2026 08:57:07 +0100
Message-ID: <951c65be-d4bb-4177-8106-67a72960fba6@gmx.de>
Date: Sun, 25 Oct 2026 08:57:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: fix list_first_entry() on
 possibly empty modelist in probe
To: Li Ximo <lixicaicai@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Wang Haoran <haoranwangsec@gmail.com>
References: <20261023075611.3559095-1-lixicaicai@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20261023075611.3559095-1-lixicaicai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JwcaoKKuUJbJ4Rl7pJggY+gBoj19oXLv0sjk3Qod/3bHvye7noR
 lwdwm30QpwgD5PXRg3f+tx4F/NGLXQaHrPQsLX9CM1gRy36nwcAr3jHwS/xT3rpxQwQwZ1H
 GunFmFnhU44NDAtof+miJ1ifKPrF95l7WV5BEs0C+gLY99JLVGUpjqmgdV5UrXzVnhjSSkH
 JwZhrXn/Qyy4OQ7lVj3YQ==
UI-OutboundReport: notjunk:1;M01:P0:RWaIHFCHmnQ=;pW0Wwda0xDcQP28hUQEvfBmRtb1
 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
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 09:56, Li Ximo wrote:
> From: Wang Haoran <haoranwangsec@gmail.com>
>=20
> list_first_entry() does not return NULL on an empty list; it returns a
> bogus pointer computed by container_of() from the list head.
> atmel_lcdfb_probe() initializes info->modelist with INIT_LIST_HEAD()
> and later takes its first entry with list_first_entry(), assuming
> atmel_lcdfb_of_init() populated it. However, atmel_lcdfb_of_init()
> drops the return value of fb_add_videomode() =E2=80=94 unlike every othe=
r
> fallible call in the same function =E2=80=94 so if fb_add_videomode() fa=
ils
> (its internal kmalloc can return -ENOMEM under memory pressure or
> fault injection), the list stays empty while of_init() reports
> success. The probe path then dereferences the bogus pointer in
> fb_videomode_to_var(&info->var, &modelist->mode). Because the bogus
> pointer lands inside the contiguous fb_info allocation, this may not
> fault immediately; instead it silently reads adjacent memory as a
> struct fb_videomode and programs garbage timing parameters into the
> LCD controller. This was found by code audit; we do not have Atmel
> hardware to reproduce it.
>=20
> Fix this on two levels: check the return value of fb_add_videomode()
> in atmel_lcdfb_of_init() so the failure is propagated (root cause),
> and use list_first_entry_or_null() in atmel_lcdfb_probe() with a NULL
> check that fails probe gracefully with -EINVAL (defense in depth),
> consistent with the surrounding error handling which bails out to
> stop_clk.
>=20
> Reported-by: Wang Haoran <haoranwangsec@gmail.com>
> Reported-by: Li Ximo <lixicaicai@gmail.com>
> Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
> ---
>   drivers/video/fbdev/atmel_lcdfb.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
applied.

Thanks!
Helge
