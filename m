Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB541FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BCE10E640;
	Mon, 27 Apr 2026 09:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="FoqdG2N4";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E42F10E651
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777281436; x=1777886236; i=deller@gmx.de;
 bh=BfOA4FQvRUwZCeY2J7oR6mn178jGDfjWZ6OdPSudT/o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FoqdG2N4WILyuu/BH1mBO77pQmtrfZSEZH5s0hRALgL35XnVJqR/heT0UXz8x+f4
 SBNd01zZABLbGDyrS3g7ovwynH/E0HEIZN91yGHxey3n/YwyNccNxNNZ12iqklS/B
 OffcjZBh0In6cECbDBZnJGH/iKyfrStWdOlz9hbmoAKHDCBJ0EJnZ1CpVQxAXLbxE
 rm49pw9WuaVnSfp3zTRBXBbNlVvV3MedPyAU9IvtMXbrG4nsUwroZX86C6aDFzH5j
 GsvXOcsb9foVjOdDmdrEneYpTRpbLilDA3kiPkBgtzZiYXLaaC227TXkI7gTTgNnN
 V78WXs4Sh6JLs2Fc7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1vjc9v02N1-00kOwt; Mon, 27
 Apr 2026 11:17:16 +0200
Message-ID: <7323c6dc-e9ed-40d5-a330-680ec1b90ff2@gmx.de>
Date: Mon, 27 Apr 2026 11:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of
 strcpy()
To: Ai Chao <aichao@kylinos.cn>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux@armlinux.org.uk, dilinger@queued.net, adaplas@gmail.com,
 James.Bottomley@HansenPartnership.com, FlorianSchandinat@gmx.de,
 alchark@gmail.com, krzk@kernel.org, kees@kernel.org, rene@exactco.de,
 tzimmermann@suse.de, rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-geode@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20260427090910.1940231-1-aichao@kylinos.cn>
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
In-Reply-To: <20260427090910.1940231-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NiBdn1m8zdTF0tpSG/SAcBVxIlczBfeHtB6jrAsL7vcBZxrYgdN
 uImoQ03FPlguplcr3MGCEjUKhoiECfwbX8JZ33jTOzmcZVuS5gtmSoGhvc3SCyLcN2s4Msb
 YDtqKuD4enwLChMwyfiBPaLDaa3InV2mEfJE7kpjWp6CZrZCMMTb2V/ETf+mtLU6oChRFhb
 oyQ6h6cKs0Dj1J+3XTYIg==
UI-OutboundReport: notjunk:1;M01:P0:GetH15Sl8Kw=;eX63qc3R/7Ln3qO5Yq6FPmgSSKv
 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
 RBmO2s/qbsyPmsg==
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

On 4/27/26 11:09, Ai Chao wrote:
> Hello David and Helge
> ...
>>>> -            strcpy(ivideo->myid, "SiS 730");
>>>> +            strscpy(ivideo->myid, "SiS 730");
>>>
>>> The compiler knows at build time the length of myid, and the "SIS 730"=
 string.
>>> Using strscpy() has no benefit here either. Contrary, the code generat=
ed
>>> because of using strscpy() is probably even larger.
>>> Don't replace such code with strscpy().
>=20
>> Both should get converted to a memcpy().
>=20
>> If you increase the literal to be too long I'm pretty sure you'll
>> get a compiler warning/error from strcpy().
>> OTOH strscpy() is more likely to truncate the string (I'd need to
>> check).
>=20
>> So leaving it as strcpy() is fine - and possibly even better.
>> The header files might get changed to error strcpy() unless the compile=
r
>> knows the source string has a constant length and the destination is
>> big enough - but that hasn't been done yet.
>=20
> struct sis_video_info {
>      char    myid[40];
> }
> I have rewritten the code:
> strcpy(ivideo->myid, "SiS 730-0123456789abcdefghijklmnopqrstuvwxyz012345=
6789");
> Used gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.3)
> There was no compiler warning or error.
> The strcpy copies the entire string into myid(causing a buffer overflow)=
,

Sure it would
But the compiler issued a warning that the string is too big..
So, such places will be detected at compile time.

Helge
