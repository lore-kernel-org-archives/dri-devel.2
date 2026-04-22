Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CDBF9EDDB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEED10EA49;
	Wed, 22 Apr 2026 14:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="ERvnha5i";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8129710EA49
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776869013; x=1777473813; i=deller@gmx.de;
 bh=jhwf76iMDxV3XoIWNkOvD17T6eGIKmdPzXlVLPdXhY0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ERvnha5iBp34WnMVYVh2H1KNQjv/WWBHFJbHEZ9dRrTdo7UDNNdM+xsCNzwmLa6B
 uNlx4ePRo86n3bgZ+D0vNb1k2GHKk+uRnK5gOiLjVEGrDGm9/jip3CkFSfi2MruMi
 86AfnEwRUtCpVhluuZhNV5t8Bcg5O4zpYZl6sbgHDTr84It3M0Kow7VAM2yxRoDNV
 tX3bdb/3YOwbngPjIyS0CxfNSiuttKCAZIJzEdLl0O1yS+9mO4UEP90rVSs4yOr+5
 fiYLf7/VxyIISVQNQJMStcO7fCfl8NpFMUgtzZMJBBTCMumP82YGYtphe5bG/4k+Z
 /1A14/oXoMRq3HmUvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1wCY8815wT-004sQq; Wed, 22
 Apr 2026 16:43:33 +0200
Message-ID: <3f29ffc1-16dc-46c8-bbee-c84ce0680d24@gmx.de>
Date: Wed, 22 Apr 2026 16:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fbdev: goldfishfb: Request memory region
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
 <20260420134424.77494-4-amit.barzilai22@gmail.com>
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
In-Reply-To: <20260420134424.77494-4-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ZrtV724ox+bw0OKiK+Towy87T1Ws6opq6phRqupFgQKVlEv3eu
 EuQLs9OWhKIrS3jGN3bCIodu8HzYJLCWglJBfc0ccsjsYSNTHqm8vpkq2E1wxBs/NURyDXW
 AEyr0VAKH/ef8gNR2tT/vDB4j7sQJ6zSGswjM8ZMAwSVJFLIli2HxRflE4fRADGUKsOipcK
 K6Pk09RIoiux5D4DE4tHA==
UI-OutboundReport: notjunk:1;M01:P0:ya95Vvj5zCo=;GHbEEBdzlCRcpvt6DHTYaDP+wST
 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
 A+6fctqbqFzL++uOPvHiWWYw==
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

On 4/20/26 15:44, Amit Barzilai wrote:
> Use devm_ioremap_resource() instead of plain ioremap(). The helper
> requests the memory region before mapping it, which registers the range
> in /proc/iomem and prevents another driver from mapping the same
> registers. As it is device-managed, remove the corresponding iounmap()
> calls from the error unwind path and the remove function.
>=20
> Assisted-by: Claude:claude-sonnet-4-6
> ---
>   drivers/video/fbdev/goldfishfb.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

It was alreads fixed by another patch upstream...

Helge
