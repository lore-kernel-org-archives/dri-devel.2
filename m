Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617EACD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADEB10E1BB;
	Tue,  9 Jun 2026 09:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="TRzJhCy8";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211C810E1BB
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780995791; x=1781600591; i=deller@gmx.de;
 bh=rFVsV5BEEbQk0tYpyVsiDRqgIy0FzwHHqDslImdBpts=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TRzJhCy8hbHLE4ZMvzN24DAbkuFG2SV+mmWDm9ol2hY6A39L2+ps3WfpnjTvR+Jp
 ytQFJAw2bzYBa/Kj9XUlA9fc8rh06DWpfXtAFJ7LOQ9Waymj2U0RpD1BYiodRLYwJ
 GDFj2YJPjCYvDxOLRrMvpe8GPnnN6qiEcMz2nA5HHDN54T/7vYnACMsF0ZAoh/Vdr
 VO42U3vvolkiPwtoBX+4B6MLk503yZnaqcPvnh5AoDDH/hyomt7LQXF5y7EpjxEJc
 5ztsiqwTfCNqKyj4zoktbchGyK0GtSKHjlNXo0Wv6zRDwgExD+SRHftN5CgEcWFX+
 RGsaO43YraapesSzzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1whZjC0iNd-00Wy5Y; Tue, 09
 Jun 2026 11:03:11 +0200
Message-ID: <ddb4a7cb-848f-4529-a187-64e290a5f980@gmx.de>
Date: Tue, 9 Jun 2026 11:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller
 <deller@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260607210203.229613-1-deller@gmx.de>
 <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
 <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
 <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>
 <aiclYUfQvMokMu64@carbonx1> <aaf75c58-c9d5-464a-9651-0021e6784e09@suse.de>
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
In-Reply-To: <aaf75c58-c9d5-464a-9651-0021e6784e09@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fC9DzhwaafOcl7cqLMamO3YkvQICsuboZX2vWsztJIRreLSIIcm
 omXT/sSsf9MCG9tSEPKUGvM/fvPzW79u/Y1OzN9zBl3ykOv/1ZVoBTtVh0rG32aV5RuZkez
 0swVQEko2f6w5z+YMNe1TKH+6CceKezbKdn31kCNO9RNRYS/Ox0E6e9HkioxErC1ycFRSs5
 PZNLoUusQrHzu9LAZEJLQ==
UI-OutboundReport: notjunk:1;M01:P0:x3PammOOOZ0=;Cn29xv/ub6w2+UrNDW8+oXlkr0v
 ODNH593gonotLFNpG8niKhm9dw/spk7Vc41NORCINpHkzRo9Zmmh4qSzmWFqru3L9Mb+lTlSX
 Lm7fE1A7LZoAaRcX5lZJUgRx4kDY49BmEDb1JZL8+Cw9GnI0bJdohZm8IXRFgF8JNxRsI914O
 ogIW0rlk1S3qAFYfA7YWL3gNk7UJNlom3HzPSr/7477wHb/6zZsVPvSSG/ma4uiIH/ci784s3
 CDYSQ/X9rG5pgDAteZvPIP3p/zwHUUclRrglSn8SocmfTL3xEjZH6DDTUJU8TFuhgdBxHKQiB
 E2k+qKpOcd4ClIJXc0aV3QHqJtw/C1yqRMVv+AtobChX+6GqLzku0YqOGLx4w6JWG40FJ4yh5
 J9uN84gwPQLPU9k5ljB1+7zqniynI/75a2tYSPsmVmBoYdk5CLmDCYNMtxMq7qXEVi75HTv+g
 1i9PSM4uTrEdMqhPHjSmlDTiezPrdkrTsNx4SUgXN4QzEJGgDbaQwQY/+x9tKxz9PV7PT7R6x
 QFc/gRKNUTm/m0bXReZtHd4K+0a5Zv2giD+e1d3Na5Me3iYptaCLN6zW3RiHpI0Zt0BnlQd1N
 VsGwUBX+jRpR6dsG5irkVV/6/PRv+IfNr4ypiIWY+STa2TCrtiiKJ09LT2k44OqoK2E5rb1v5
 poNvRKI+uQa7mQSzaN7CCuJ0fYexHZL/Q0XDriHduDIyA3p7d3sCBFSicYMFT8kzStb2deWkf
 0BOhV4AgcSvkjbSY4zc4bhftWYTPnZrrrJJiqHT2084ijDXhFxALiqUdJV3xviNG77qbKhHzi
 vvuXBgA51mt0Hzze/2l14rm/0vHOtlQ6O3+3b+25m6Dolv7sd7iOmYsO2uP0vUQ0SC4sNcHx5
 xsbx9dEVKpNFTsa1kRl/VHm0LnxqT2MLPZ3PnoO8LG1fwoIUfrbCHghDxbaqIi9bP+qGdd7i6
 es8RIT0Ia64ctvwe0oUpyle3mO3zG4g2t4SAUWqygja1/ovMowWx+fRW5vGslVTsfv9DJmF8h
 omwyK9C+P+dqu/AJ57G++L6LR5kQZkChpbFU9yiTbAMF4BvOvpE2YChRSRtEaRCNLJcYLHV3C
 5m5yuSw76qAhT4XxpRxtLnp/io0HRFpq/fv0lT/yopiwOCltvWJq8Plrt5IpMUAGkabtKLIkk
 f4KkzjQms4CAKqjXi9/HlLb+z2KRU9hHkExD308IZj9u58hsnz2G6Y6SOZoWHsxj2yesEVtOH
 VsiIEh5VYGpQ1T9V1TPj5JdMFLg5RAH+eWmtEsJ/N4jSw/V2l4+qbbcE3PiP98O7w97i6zojO
 93MrcSEcI9pIT9P9Q6jSMmyxxPnoHNxa4IoXRq3yhgGPNq6epmysstfy6hob/kFLqTWy+o79S
 50wde3sof6A0VKfuQNM8t/EnfUi9Ic1ayhiT1hJxSZdV9Ppl2Asqm8kjm74NWPEHRgt9kKbip
 jGFlVDyaWJAGZ2TSvMyTxlGE6EyAHFztHsNwP/wIIHEw64c1bYtMAEy9vaVLxMnSw7SuT4Lgh
 6x+viNMNB6QsynNfAocTfT1WDKyRvfns/QOe+3ToQqL44nJd19hpUW1JZQbgBQiVdwi/bJQhL
 sRm4wnOh+G/07kO3jJocJmy1mXf0XbqbHP0vB285K3sG5FfMstT52QiXatTYTdCykQaq1KCNY
 2d9G7oXSl0Zi4sDryisRnYKinIXD+msErY94ZuNJqzMP4o2TmnLsMqHNdSKOYsjg0WAOaO4s4
 x5PY8iP0te/B9nUmWyVpnhxJLFNe5bgKcQCbyzhi9+tdSwkQT6l48R61GzyV/rBCcKOjGrsGH
 cphdzKyFZWwv0FT2B8nUg+TBXbFWYQbB7pDzIbj0i8RViB2Rfju3zeqRZC2/aAAFRJZkAmFQS
 9+T7PCedp/K//hdsiPQONiR7DMzQfDz/RKzDc6R8cLNNNLqm3vg1hPiBeIipkOYhehGcPazZT
 J3aJwViXaOvSOp2yuTiwVruN6osG2gVRGeelnqXbpshObWeJeHru19SrietGFBgzS2KxoYc3Q
 owEZuf6lDU+ub6jJWHd4IZIZ8eaO9VvqjXthk0Nl2B8+UGnbyeq5zwHCqnkTcrug5IVw2lYqN
 l5iNid8iT/DPxWMTEwAC60qWmJCTEFaRAEWRiu4i2T0gajfQc7nIhTzuM4P8LGjcpbx5IbbiA
 UWUgXghvrw3y9s82MzKL9hhsMaKWkiwtwFcJhQEdvODElvgOygt7mLpae28pZHMv/wIrMm1DQ
 9gMTapGGvrZ4Q1X3CxR3c5NfV26TElL4k6RiBjgwLTS4ets8w7o8itAuHRS2NCeK/8nyJyamM
 CmUo8saKEhwkETFkvdSSAwTCwgSPjnmcTfW7IjfCrCojl/f2Vz7029ludxhplBlnEjX2fH0gZ
 7u/Y6A03wLp3hqK33JeLrKFU7G63ZsV4S1S1xYG97znKhzogoSx56FyTqx/yVbIbCwI1/GCdz
 gYSDAE7TM9Obgd845hsUzXG4tsEf4fg1MUe2Djqwy4yfhz0+OUwLKsQIshVwSygQx9LE0eELY
 QCGvWp7MjYKFWrN4RPS/cKGA4tEG5pGpR2EDPOvJo+PzSkDMd137rO6TUj4ABFlFizxmc1G3s
 5WA5BV9YvzNKjo2LcKaXlErzz/EjVnPTTPmqQOIol5T0I9JmMFGwBnu1nBOf6gSrVaESsRQl8
 AmWWgoEjsCnBcKx5RsK4xVUwH5j6MPfgksCU7zxZlhTiiM8sfTf9k6kdeZgJRWnyrq9wAfIqg
 SgCFAX+9XnOqiDBVnzlY0tidgFpJuhMAWYrVCONEcqntR7fhfN+2IbItVbhMaicy9423oOoIL
 p+80FCMX211FBAVvUsQpazqw2b2y3Epg5QxCCkMwFQm6CjFbWe1Z6BSNeTnkC8mJUG2VWP//i
 DTnbCFce9dyCSC97COl/ydgxJDrSQsYswSqCOCe5V/FRCwSlzSfM4x5mr9TvSpifFgBMPyvU/
 AwD8aZOBSc1xu5za606OX9ry7XAzFrXfesudF7qe2AwAM4e34wBVkNvMplZmqXdTodJPg9yr5
 uLJLPWi7/iVGEeA8xKsBb5EMGVHOk8JLjZPLAVD1MXVHflDjbCCyleUGQWrSAIJJyF+LkYCLI
 SK22k9zJmfykrdjL+V4jMajwFvu+ems+0LoXxBL8cRjVUA6sC8IzaZz25nYZ7Li21dUw6UQkn
 eBK2xDpmt4R0BdakzYdi6WP3EY6aGCeMbQkVwV1zWBpvQtefn2ztFPQJKh+w24A3YoSQCfs1B
 rj+ottMBZDS+m90EHWbcZRtjTP8YQI9GXHeFKxEOzag4lZ+xNSnyZu35EgAbGpW7+d3gW9L9T
 6OQxrmEt5af1eJT3Eq58emmXGnQ9yAQLUqSNMzEiEfE4WMuKTkEF80p51igZBRdZpbrzXJkw3
 wXw7fJMcZTCEI0sUMd9O+QgwEzkg/D2Ey5uYFDEb3kzs4sWDkAoxaq86OLNMJZDb9qQQ+HJ/3
 UqCDec6h6yXgJNHRuza3gCKua+a9TRpXx43c6QFSMvtBJdvJHLYqcY5CwGYuYZuFfWWAtH32j
 bGCUx7c5oavEDLJoQTDJeiTlZ81eWpfaHSyS7JAPpR5QQh47KA4gc32s1NM5eN6ycx3pfjHH1
 wNTnQtyqxNiGNRudyQ8jtYGOPsQK6TzCKTiE7WMXzbTpCYCwGkeSc4clf3FPEvujDiumIV6wu
 SEw6HuWAfA5B+fojY0A5sNCp8RaaKpjsDzpXBBYB1OlC5pBdBztk54G9wQ66ut+HD2v4D3pHr
 ctcopVFO3X8GiOPB3PmucqKG03vPcjR//pK0sobeXSJyZrjxqZRf86XQztSDPPKejK2aCJsY/
 HLWDwiFH3ISwls1gHWg231MnnRvwdeT55Z99R+lrwSxJp09+Lscrc21oHQBZ9ZN9UzQDzKuG2
 dthSwKmoFAJ099VgJKCjonDzOjTV8p6ld7SZdq7WJ1fXnUnm6rANb94BxgXdlFXS5CIRXilCf
 qdtPMFpRzHoI3K79gyo7hOLBaUVO6IuaFEHQUpB2cSqH45pNuNGj5E3tMH/ovcHOYYT5T4OiB
 wEeNfJc7KnhRHyUJx3RcuWE0yX0zTq96G3qNdDUCwccFrXO6KSYErjgKCePFnGNBMdXm3bZjQ
 16e0bgKJboTcq4Kg+wb0dLt2u7qNSijh82tCLRc1I8wMleN9qE7P7/zyGYR03ZROKe9XXHhum
 mRqaCocSWCahFtwebmVKT+VM2Tjy3WDTS36jZkJyGhZjLBNzxj4naBeN+K7sJwDFSEDjBqFvf
 BRshIK7WTQpz/un2LSQDknWhRXquRj4Z740KCS8nHMxObPVAdojCdBTawBrgfOlXcqKtucRVo
 r8UGEAnfgAlD3+e0cbtBAgpG2HVIhz3VSA2DGVPSm9AH6UPfoAYx0SPAlaNbHE5hHqfitIhVi
 5M5YHcay+M29wTGoCz5RhByqOxuegdDoR3m+JU4I8MLW75K86+tFtQud9qCL/7SMptzDYJbT/
 9szIa2ayiE2/AVqjrFK+RrJJGBT9hIaYf6SGAZIjkl4IffvZ2PhEvqLV28tp2QC5fagpe8kWP
 FjZaUmvOAQ8Fl1bq4fmXQsHI66OW7lRxcKTdtTFm33v0+eLJTi0b6D6SR0ymNWe3bhx+CJAqa
 n5AHuoGzxjHT6h/cXL3CSBBOH+qFswmhpCb7HeVBOStf2R0wEm/jHeP/BKk8Kxp0ZsenL4V3n
 7fZSi3KKJinr9AnHDkJ3MRChEEvDfRCLJIknBS/uSANcNXpJkGxORmfrz1JPU59/pAe+wSeNu
 fBSkaMsjfGgt3865fQ+mFCSPtiORHyVQYtw17urWLyiSeTJugW8dFaSw6Mu8f5zTm3fS3++R9
 vchVSfF5ojNUFoL2fepj4gSdSbHbAywM+iMaTmAC9rgdj+9QjQ7GVBqFXWav1ob6wiJzd6hcq
 sNgsZVgmCYT7lNdUUXJ2Q8bl677HHRxO7QzwG3HM+04PqZBPVVW1r6JinIZr3ZwprOq7csVQd
 rT2xAV7dhAfRsOdaTTZAZJYlLtmn+iPyqzALPaJasjIHZ1lJ14xt0QiLhL/bwEEJxkGkQm5IX
 mUivQDOfLvn6/1PgDfjEnOxCPfxNFXoEo98yzhPo+MNLbYD9XN1KUdjTVchHP6/ht16vhCMlE
 0yPkcVB6P/aM0N8fKH1CjQKZEVteW+bM4iRVNzs2vSXKMmK9z0nuDbV4s03lVIRHxQKw3oSYx
 5fvzmoUnOEQIhM5m+W0gKHsAaeSuHzcCzLQhmYL9eiNX6HNf6+a9XRwOb+lnhY4SRwug9delR
 ulLBEhfQuWNUM88pMCUpFOYkNUB8f6dj6Wjj135jnExEWc1M8A86F+68aJafA3b6FwoPI8YHv
 NSudNcOaprlN7ZL9u2ncpVSQ66ocdmA3cSd8JPPUm4RgyCxX6ZjLfoOpUD1xwRIUcFCmgxQ1d
 WTCn/B0gOuDUbQfPiL85cDxzCz3+o4UkBPSwi1QyO1NAjfQgpqCu5d9kh9L3dAhK3RYyRj/Yp
 XLVvXFbqTfTiIKRdY7hBs2/TWKFrdmlk6AaQ6AiWrKHQbky7qlU9p5EhT54IYflEVyZs3+gIB
 IFh+MLSnK0YK+It81hKK2L8oTko+RV5OEm4NDd73mFWrMdqbVwyyYDVVDMeV6VzBI5ggGg==
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

On 6/9/26 08:14, Thomas Zimmermann wrote:
> Hi,
>=20
> thanks for the fix.
>=20
> Am 08.06.26 um 22:26 schrieb Helge Deller:
>> * Ethan Nelson-Moore <enelsonmoore@gmail.com>:
>>> Hi, Helge and Thomas,
>>>
>>> On Mon, Jun 8, 2026 at 12:58=E2=80=AFPM Helge Deller <deller@gmx.de> w=
rote:
>>>> On 6/8/26 13:25, Thomas Zimmermann wrote:
>>>>> Why is there a 64-bit division at all?
>>>> Not sure. Might be platform specific.
>>>> Maybe, because you add two integers and divide by an integer, that th=
e
>>>> compiler then chooses to use 64-bit integer division by 32-bit intege=
r.
>>> Actually, I think the real issue is that
>>> arch/arm/boot/compressed/Makefile defines "static" to nothing when
>>> compiling its copy of lib/fonts/font_acorn_8x8.c (via font.c), so that
>>> the font array is available outside of the object file. I assume that
>>> this causes various unused static inline functions in the headers it
>>> includes (such as <linux/math.h>) to be included in the object file
>>> because they become normal inline functions.
>> Does this patch fix the issue then?
>>
>> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compress=
ed/Makefile
>> index a159120d1e42..e3f550d62857 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -157,4 +157,4 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
>> =C2=A0 $(obj)/piggy.o: $(obj)/piggy_data
>> -CFLAGS_font.o :=3D -Dstatic=3D
>> +CFLAGS_font.o :=3D -DBOOTLOADER
>> diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
>> index 36c51016769d..3327aa6d161d 100644
>> --- a/lib/fonts/font_acorn_8x8.c
>> +++ b/lib/fonts/font_acorn_8x8.c
>> @@ -5,7 +5,11 @@
>> =C2=A0 #define FONTDATAMAX 2048
>> +#ifndef BOOTLOADER
>> =C2=A0 static const struct font_data acorndata_8x8 =3D {
>> +#else
>> +const struct font_data acorndata_8x8 =3D {
>> +#endif
>> =C2=A0 { 0, 0, FONTDATAMAX, 0 }, {
>> =C2=A0 /* 00 */=C2=A0 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /=
* ^@ */
>> =C2=A0 /* 01 */=C2=A0 0x7e, 0x81, 0xa5, 0x81, 0xbd, 0x99, 0x81, 0x7e, /=
* ^A */
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for review!

> I do like this better than the other patch.

Yes, I'll drop the other patch and re-send this one properly.

Helge
