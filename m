Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9010606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KPjpWMgp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3028C10FF58;
	Wed, 18 Nov 2026 18:59:29 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5342310FF58
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:59:22 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795028360; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:cxoB/WnN9STqfOIhcCI4Yyw5RNok
 5Rbh8UhtMiR/eCV0iN5MGW+FnLC/jI3lzgqVCYViddIOBbJVt09pFaBYDYBFqqdlOyxpueKu8WR
 ZbnaAcntvwD41EjTzc57BoF4g14I1vIQB3mSIoek2QjWN61mKjFDJYK7AeapU3BwQR6CFKUhgJp
 6UJluQ9LHvVzFsNPr2zVz3CLSZPC7pz7cJ7+KNaGctdqmGKJ+NPshTnKBdGpfqEmYVOKOJkQhzZ
 erot04XHhwhfQRnhYBia63u/3T6VaDMOAxpeV7Zrjr/AdGGnPUK/kuBHlZc8JYDakDAX9SDo2I6
 Sg9GEFSujYTp3g==;
Message-Instance: m=1; h=sha256: 6xvdCIlFB7Z9N0zsYBqXwYKRuGTaSAvxQdTROhHOnQE=:
 R1pJeWvScUlNzcf99gfFeqNFaqlfLFEHFF7sgX3NxXk=, sha512:
 pzrmyQDRHEf8uS2K258qF72Il/IUZMDGi5dUni9hNkMjUZmIuaTxs0fGG/fbpbjjQHJYxAhQYJlDwGWBYReDaA==:
 hVaUGylaCr+LNkjuggmsuqS4f5m4s8Egnt44h83qRBQRLbjgO9JcUIEFayId1YBgwtspfHpsqPCmnUGgFKR0yA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795028360; x=1795633160; i=deller@gmx.de;
 bh=11mQU1qsfOMN8alGksqIUiR4n0ugQ8XdwK18I5Ypzpk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KPjpWMgp+fNLeSFYuzEiIkXEjZX42aTwqDl01Az56sISREtQbFiwT8RpwAVvjzHf
 nxtWWgmDMR6dslnmwZ3xZ95Y3dAphc9ivQF6GGWmmvVnosgDeaciDkJeprVMeB+3U
 Z/6zI+7jnmBdvgQzHm2YJEo4UjMVvqT/3GFou0GLFoI/pzld0oYkDpYWKYOnxRcGK
 mXMSabfFMknNuraIe+HfxE65xfKqWrHx7k/1o4k5r79NXoQlPhvgFsZJ9BY2/YB0Y
 36/NaZD73G83ivC30d6VUbQnMDQBTjR+N1nG90SaJpOIaBWKR/d0byaG+pW0lg2ik
 rKgyCKMywz70pnNIVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1whil01uaY-00m0qZ; Wed, 18
 Nov 2026 19:59:20 +0100
Message-ID: <400c1836-0b68-4ff1-8367-f87c1a4a2417@gmx.de>
Date: Wed, 18 Nov 2026 19:59:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: macmodes: compare the pixel clock of each
 candidate mode
To: Tim Douglas <me@timdoug.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261118012557.79419-1-me@timdoug.com>
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
In-Reply-To: <20261118012557.79419-1-me@timdoug.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aK9fzFLLo8MOsu7BS75bXuanxj6BnMtYj12aR26eRzBwPpmEPjj
 CIk3OAPWuOA2IxVl18g3AdUv0jh8pbvNwl1WnGW37B28zeU6JRsx1bZ2vt3gitL/vIvfP3B
 EKNf4Ode5PPgK2SoHIsOBbW2jQs8aRkXyF9AM69c64QiP0nXtz/pg3xNKYvP1AcltRiuogP
 xGTk7MdXoOubtI5vXKgtg==
UI-OutboundReport: notjunk:1;M01:P0:G85kD0IDo18=;Ph+YBzqqw0LGCg3PVx1iRLWvrp4
 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
 oQbOHusKn56oIA5PTvixY0Nc+8+xXxmupAM5w==
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 02:25, Tim Douglas wrote:
> In the second pass through the mode table in mac_var_to_vmode(),
> the requested pixel clock period was compared with the first mode's
> period at every step. The last mode at that resolution was therefore
> returned even when its period was too short. Compare against the
> current candidate's period.
>=20
> Tested on a Performa 6200CD using a kernel with local platform
> support. With video=3Dvalkyriefb:vmode:10 (800x600 at 60 Hz), the
> measured refresh rate was about 72 Hz before the fix and 60 Hz
> afterward. At 640x480, 67 Hz was also selected for a 60 Hz request
> before the fix.
>=20
> AI assistance was used to investigate the mode-table walk and draft
> the fix.
>=20
> Signed-off-by: Tim Douglas <me@timdoug.com>
> ---
>   drivers/video/fbdev/macmodes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
applied.

Thanks!
Helge
