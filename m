Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C2606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bB59DYvC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1E710F791;
	Tue, 20 Oct 2026 20:15:07 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C0E10F791
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792527300; x=1793132100; i=deller@gmx.de;
 bh=Ea7e0dr0A0efw/0izD5fHfZwxSDHa2lqh6cctINYdzI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bB59DYvCHmrVV4di6Dn0SlkH1ZjpidmQ84W1wvHzP4Hsv3IgU+JMWW8H6/JkjcUH
 RMiRJtHKqO/CTAFnq7A5onqZMFycaOEhz4Y2080X7tS8lRyo3Fqd2ehBUuspeI9FY
 RRVVgFoQlFirS7f5V0wWJaTYcr63wXJ0SPAFQ2yEyCCCC8O4uySyjt3rnLVnEpK1T
 V254GB+WRPKbBssOOK//d/0Rf//kIBAP8I7T0bJkKa9Nupr30a0NVHeEdo8psjuPV
 rUlv3YY3avrl47F1ggsAqNn4kshg1hddrWMydOxLS6Fs5JxKMPnPRmrCwQbAHLVkp
 XgefutryemFobf8+xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1wYcpT0z8L-014E5L; Tue, 20
 Oct 2026 22:09:42 +0200
Message-ID: <cf9859c1-2789-4f4f-8d03-aaf1eb73ff74@gmx.de>
Date: Tue, 20 Oct 2026 22:09:40 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: bitblit: Fix glyph clipping when fbcon pans
To: Tingjie Zhong <catme0w@live.cn>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <TYYP301MB1525C5CFBFCE755C7F31426FF6672@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
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
In-Reply-To: <TYYP301MB1525C5CFBFCE755C7F31426FF6672@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XpOm91Lf0wzp/fR6llXhKtRATck8EZQvxZyVoT/J4Oetwt9f1w2
 9Z2pBSuDh4Gk1ZW0UsnbVJZD0d+b54v/8PV/aHnmfLNw16+OV9KeOYb/Nmr+aTq6lPGskMB
 neJLDqjD03HCGQlBGmy6Tr5cx2s0t05WhAD0NPNyTdE4oeRl8uHDLGdNU2rtSoq7ykPSuTI
 jLR432OmU+ZI4sEuFgdEw==
UI-OutboundReport: notjunk:1;M01:P0:+9Dtc7TbYb0=;GLGIHP/Y8DGVFBUUvsfodi2v4FO
 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
 GMyxCqtiYx5+SsWZzJy2ct3gFRS1P5eNjV+lKw=
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 18:46, Tingjie Zhong wrote:
> Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
> vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
> fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
> so after the first pan most new text is not drawn until the next full
> redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
> FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
> CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=3Dy.
>=20
> Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
> use as the drawing area height. When fbcon does not pan, GETVYRES()
> returns var.yres, keeping the existing bound. When fbcon pans, it
> returns var.yres_virtual, which the framebuffer memory must cover
> anyway for panning to work.
>=20
> Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vma=
lloc-out-of-bounds")
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Closes: https://lore.kernel.org/linux-fbdev/b8b52ffd-ecec-4fba-b432-ba32=
135c2f99@suse.de/
> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tingjie Zhong <catme0w@live.cn>
applied now to fbdev/for-next.

Thanks!
Helge

