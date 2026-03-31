Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2F109B46F
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14E410E969;
	Tue, 31 Mar 2026 14:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Hs4BUtIL";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF6910E1DE
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774968054; x=1775572854; i=deller@gmx.de;
 bh=wjI1KQkiwo5tm6CGOUflGkbuiLv9uJjSolVI6IM5j5Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hs4BUtILUl6kxxJJiIZO3ygLHvF2VEfYEXe1hQ7uuHk4wVFhKRDg1xp9w5+nJiZ7
 wiBVXy6pM4KhEx4lmzVsksKcRXUjd48hrHCXronoSi0L7GVht7QLIahQ5F+gFY4IH
 jipFOSGKmm2qAD7Gdr+v2J2Q3+zRYx2aacxRnL6NpALkQgqhzr65B7OVGepJ1fW6z
 kJ2m64kzVe+Id9gjV6DZAQe1X0tbJM7KGW7DxQHX6CWkcRgIVc+SrOfGxF5LGjCor
 zS1wNQCY86xQ6/7hPK2oCwPLWwFaWPSSYjuBYQNKylq/Z0dXWnSwJWJoiwURls3/Z
 azbwSXOUgPPQ9uLxZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1vNkm816n0-00smhV; Tue, 31
 Mar 2026 16:40:54 +0200
Message-ID: <5f0642a2-7391-45ee-80d3-043465482024@gmx.de>
Date: Tue, 31 Mar 2026 16:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atyfb: Remove unused fb_list
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <571a3e072a2eef5a587d768d74559fc549b03ab6.1774863796.git.geert@linux-m68k.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <571a3e072a2eef5a587d768d74559fc549b03ab6.1774863796.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kVDZ6VwCaI3rRSY4o0LG5dxn7JPjWxHdXQLIPicA2JlijTdcIwf
 f7tOGzMPCZyaIdMVhDiSESzINrVaLdgde6jDMtmUK6C6MQqvI6sH7SdZtvTl6GS7dY3J/Zo
 BC+vs3pQ7jakw/kqD69ie+JAj2RCI4iuvI3yWDLClCGfvSpS0QCulVAu2OmQ9PPnEc4igk2
 eCdjNBkRRCNaK+NSEZ5mQ==
UI-OutboundReport: notjunk:1;M01:P0:EfwDcZzvDj0=;7DywxcAafqAJAGC6qjiYD0ulpTd
 tIrmxW12XEojyMUgrmWZr3ap9NkS2BXBkspddox0MzBoM9kc2uwXZtmpiHdppmRjbDPQADyrs
 mAmhOMl1+blkWOMAMaz+F/USnJluoss9If7Qje3eb8nV4wgBFpFuWKJn2haRGucXnTRoeW/tF
 AH9NYQS+pTwzol8CLTjb9Bl1hVOFtCaaLZfVCRqrcM0a3A4eKwHpIGY2+8602juk1V4kAg5mM
 iEj0ptaabEhwIjorI9ANP3VE+tSRboW5oLl/ciEL76M/jHFopqOF0DdtZ4X9F/mO7x4tUO6DU
 icmPF1p6vDZzrHUAW30WhXuF22qMiKu0+FigXJaH7Y7P+c+0/6ugrQ9F0qnLahuG9scT9s3IY
 g6bxj4Rbx0Zt4Hy7bJmoPce/Q1yO/Sp5wKBnakC1DW+Ax24viDOmzOY6yzXLogCiSbhcWUUnC
 cKZSmh9wXpYxhnIYxSAJvekjw1/2aC2Ih7k3nGSWPzLVBXixMwIzyllk+LYoMK1ojTvpcK5qL
 JwMnVv7GjZiMitKvJKV7t2uRM7ro6XEpjjM7XuJSWbW4PqzG9/cU0Ld/T5p6lOLE8HHoSwjt3
 +zqJCtt4BNOooQuqoN/pZqEHzoYP+vNz6Ao8HWYscE72TzKDMxLinU2EIJEnx1QJ6T8lc3fg4
 6d7+VhYmAg3H8jO1W/iQBwPZlV+Kf2MACwhMnyBpV+K0odJMbsLC5llne014WZ3P8KDCQED3M
 qQfnddcXI/6sa6RYC/1rcLYF9DHTRVegoeSBvkMtqu/3dJ1nlSabjNI+hE81Z3aIi45UL9s0m
 86ATtYNFAmuD+mQhnbjB/Nz4U9n3d/uXw/G3TKAe4j9uwNkieVyV6D4K1gcq7l1BxK+GuqFea
 Dd+PDPURICKqwXw01UZ5ZOyRGS40a0tSARD1EB5JlxRBNQdBpwzc0uGbjqwSOS3za6d0FR2Lu
 0jKwSlO+BPTQOyXRnCABQWZUAWLWW9ubSkre0908oSX84tJD8Yl4WtdGaymWIHR1FuWGIogRq
 7zB2hvnzHqAdr8WPyvdsWZVgyQYjdf8XGVE8NiYCEeukIMgWhNPgl3hRau7SyvpfSeHV4/9qd
 uF3+Kf3EfGh6ARnTau00Rihs+wqcZb+rw517dZn73/AAo2m6y/N6RRAMf7BJoCOBbtoWj8oeR
 UopkeaWXzbCny6Gw8F1PKDzX1PCb9wb4rUpgnaAwJDb5VBI1vdSUlKsQeTkHoNOK30bXDv3dT
 7GeVw8D3ObUEzK3CtqfQQvRIv5AFCQzySyFJfGvUowdnEPLoWOU6YjYUGANyrOpt3ZNfc4QmS
 lQamdL6tWZQqAg0bvWprzY51qSakjMjmdaKh0kI3zIBu/naqK8+ut4mmnHjdWtGFcpGleHGxv
 s+6b6b44zX5rMhqimFDgzRYfDiqVrPldT62fiAHlXqlH611jLKzHRtkt0yDFffLDzF0KzgUWa
 1H/A8wfKNOPo8MdfPWo6xZVeU5a0E4323RMynsQMQyakMHsV43iMiaHzpv0P9NRn9jnZDtSav
 nADQUrR1rBmnhOBZKd4IujYudCiEgtOLSa0/08HNeMFdaF+bcWNz8fdgMGsH4JAmoyiG9h43B
 xqNYcghz8f+VnalZdiML7yAmWooHHhlELeV8e6cRjr8gyWDxVQVXDB5mqHjuElTEHRdPPp1lN
 o4SHJm4obqkPxyBeS72dLMyGkiLKZbLFxSXGkM97BcGzmHk4Vk8bNp59sSHx4IrKHLug3d6zO
 1PFrg2whlylrbcsQNhYm5q+D3DGuGk4v+MZPxnOmZNwX7AOjPBrE+9QNMpz6crNb1RTi2rfRh
 Wf0cE9MkcXLMyjJjAmBy7xRWBuyXWRVb8h/AJ3bJPjNmk0zqzAwBEU8hr2wfTWhc512ahbZLN
 MzIEovNPKdP9xYCMJZbEvLLI1+2wG+fARdvAQQaI7EodbjfpI3BCbwPOqw5WgbsRtQkWti+jG
 Rb5BF1tOIotgoeX/f/58CRRMHSUPhlzOxh7yMjeU8+2mEym1Dj1yPdoYC4PMt6cYeLpK4peqj
 CgF6zrqgNWRfA/J4pPnBeAA3jJQUhq0GDdpFLygENFi2zMX2Lf9haPaWxRRz7VZV2SQRMhpMd
 +8zNi2XCkRXwL2+QrF+/K6m553xBPHsPFASJbRuwxzF0oUBfQ1nLwTe4g/q6w+ckbp4nLTsDa
 4xpgfRHkfdwWJQfk9EMzAqNSOFpZQtz1K46tFYFc9wMBL2hQsFJhLzsBbHXKRaJboRDm7peTP
 HIO2kCjeuHdByIbZg9wzXoApitMTNtWEuqqrPVVCEYW950kdgQy9yBk8HYJXm8aRpzpVI2MbQ
 umXFqbHikQzd5OOzlKKsug1K/IUtlYVGAawTC+DfPbfEJnumhd5rYyTfaOXLbzuL5R5V+GWn9
 XVKYn3ozkFSWryRlSn7f7oc7nJkhwTLSgf3/VZHSK75W3+j4XfFQty4x6PTi76vWejh/rQ4g5
 ZhefliTCAwUJHZf0xlUCMp3IElIB7Xv7DhuRu7zRUuHCskzWNIG6BMGuRQBTjhG8pX3xucJXu
 WqCZJvhMNejsdZ8A5Gv0ES42LrDz0qL4ZFRubPGP95DS0uGMOQYWpTHv/6a2dVbV9s7ItDOHZ
 qn0Jcb+LFYvBR3CZtbPduceVU4J8wjn+h/aaXIHVkNZCfwm5AZITPJL1t/4GFYQDHb3mDDyY1
 AikwQDRi6XGXWAmVw3VFy9BEj+BWtu899e0lCkwbVq1UVsEoNy3KKyYcwhJcdM00ch/2TscWx
 u0WI9TVp5zrTtyZE3edAClC/+2bsEBHOxoTE29WS2DYLHih82uFI4HMn9KGcENvPjA+HtHXHW
 HwJIKzxtZKdzuBVq/uYuGoomCLGF6RX/geLN4WO4nAeybyYM/d2D5Df9iiU74J9pu6lM2qe6h
 Obfx1Ou1Etr/OcvWdVXyclbeoV8hE66gx26VdnGie7tYp+mz81EJEF9KMVrFp+0bqzDwo5e+1
 9iZ0Qc1A03HXd2GRY3eTHGitW9sWZLf/0JJ1iVzZYiT3QXerOME+QmBMatgnXOgbvzE875jKs
 PI/p+RSUbl03yG+EJnovlhoSoiIxtEPleYb3g1Iy7KO7qRdOWcw3+jeAcvlI45/j0SuXU/MqF
 /4cJq64PaGoF1eUx/Wo1Mih23Wd7YPB/fYJ+Rb95pt6k4qGFHfbjhiTkgm3xhRFdwBR7EVkyO
 OT8Jlnpuj/tDRHSewf6WZcIY5TwCefBQosJo2saLFCY/DbWt7vnUAGyWSp80C/IKtoSskFpBq
 7Rvi7QT3yrvynUa1XaHclaWhhmR+UezxHBYqahck0HHmpVxwg/d3BDTTVNc+LA2JmAgU1+b6f
 /VlJb8FmdZI0DdKLtt6m277ZISZHD9YtNLWPbU6/mH2GA7+sXF12N3bkBGrk4z/8iNS4AERr4
 LSwmkBFmp+7tizqBwK5JasETi1Nd2012C8M+FrVKVe/8oJxJ0uktXRy6jgcBkmOCdpjpbsxfz
 eLi3UUQKDffHL2vocE5h18w6g9ToPy5IhwHaRSH5HEEnWT0S9JN0Nqt0PUOvtmK8EdqlTchj9
 OnlnWWUOSaQitasOLJggXIJUy4Duf+ViawHRKMYQZssV+0GGgCB8VqqF3Xu8iSlR6vVthcEs6
 JwkMajGkuFsHGDigp/fbzrn3b8y62ZYjGlBVKrqwSNL2y8irfwhsQoAOUo+ytFu57PI2a1tkC
 /07tsJVH6REeHprf/eKHlNcV9/v4z1YFZ+ripEMKZlkE6y670p/aVxGOR2/GuQSeGtw3cRfP0
 CbNGybB4ciNglwGK4nyk80RObN0/CFmQGZUxjZPGvSxy1/iKoF9vwtRLhGX64nbTzIQx8oIWj
 ivP0zaTGQb6CcjBNXofSQCWtq7mCW/v9MQEI+ZkbT3Sz7OfKqDG9+4mBU1NF0nnWKQXovkmDu
 Njbro/MHCRTJKT0yCx843OevcFCHmI9po3gop+CQ/EIVzXY+v+BEYUru2+Ff9IXC0FnoErtyR
 glTzPWukWaj1q32y5qGNR0H6QXlOiRjIoupJYutbOFIlPLPbP5eUw9uUN4trOSqO3QRJr/mJS
 zu4U02HEHkXctY8glGQHJW1+835KUk3V8xG/v/YgSlbUBYAbZMcIL5y76E2GpkfGsNhu/C4IZ
 kxX+sH9uUCoXr+QZrVmXU7OwIrMXooX/9QJR5oFlJGkY6jl0VlijQIbkqQ7npYc/IRTgB+6Lm
 6aciOKUmvCqww1Y9f6M2F0iXQQYtg82w80XVflZhvVw3ctu9odAglXV0mgKlLo2zMsXXw5UxG
 VQmn+NXUW1J45n/81omSCqkrFT5AiK3k5G/222zzCWEZrMYRtm67H471uau6r0yRd0YvWF6ue
 5XYaz6446rKan5Fop9qqbbNyYMWKuA5JwTZaVwm9b2UJdaihv2Vkq+Y1/e/kIqQAGxZV5Pqua
 mHMsxQ7FlqAU+OB8DlgkcY9Uru/3okVWN/rMBa3E0ZQV/aTA37uRMUF55aS0ScAO6zA0lokzY
 GzUh5ol3ctu6LRYADElMtqIisCQ63kFu0GGi6g5HfI0ukUyefc0vaoQ2THeKedWTsrP45kyq7
 MOk3NiLsdQuuI52VWznKetbM4MKNtTQNIxpaLIC+hSv4I7sjO+7tKLy0o9Z9rZFvN6Re0FdYx
 tBYMsxibjVDOH8XEgvil5Qca9UjY5g9y4QsAQS0IFHTjIZYSEueiKfi+YUlATPGrSPU7ueV4t
 RVU4I9yKx7HKrZVRtowvH5lum9WVV7VJ/X4uALkm4teE5j+FPn3ma0Dftxfou/wc0ycfazt+F
 YEr5s5M9s5dRzz01jeGuIJYfrVZdsd1l6p4u/+Yu7dLm3WkeTsnqkGaf8HE+P6dhK8kmu8kHL
 SoG7giMZaXIX+bC1y7HIsVQUev1At5NTL8CEr9gE/UOZrtNuhIebax1sPjI6mXgZxAmc9yKgF
 z0dRGpwAjX0yDrlb63VkgqvsHW8putjMzgklf4il1E31afcrActXdIl4B2G4t5zGxeor0SfSj
 a1Jf+7iKTet7WOT2/9+9MPpR1FqEFvLi4N5Oh6Vsa+QPch1mzaZKyrOYQiyqCDQMvnW65OUmv
 Ko5yEBu7c0DgCoD00k2gqLAa4zO2RczFXsSbiJArn3lE6loKEAjEvjkAjEGgmqmL/h6oakOwY
 yvEojZx7HIyxe5lqelPC5xZRSRDBZl/wQR9fmM8HrW4sFZwpH00dhDDgJqLG7zTezj1j02eCz
 oedmwIJzmhptqeJVzv6mukmdO1ozw0u51OuzE4dZBEuyUqi90V77Ctr1QLhQUGWpF4nI7R6vc
 nfrCJYP/s5bdh0J9jC9vCkJegUSEkclGnlXcSqYrEK/IlVxMEf3eBl+WNfGh8j/m8ZPpikpww
 wRZKOCy4k1S
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

On 3/30/26 11:44, Geert Uytterhoeven wrote:
> With clang and W=3D1:
>=20
>      drivers/video/fbdev/aty/atyfb_base.c:2327:24: warning: variable 'fb=
_list' set but not used [-Wunused-but-set-global]
> 	2327 | static struct fb_info *fb_list =3D NULL;
>=20
> Indeed, the last user of fb_list was removed in 2004, while the actual
> linked list was removed in 2002.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603300931.osMYxYZ7-lkp@=
intel.com/
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drivers/video/fbdev/aty/atyfb_base.c | 4 ----
>   1 file changed, 4 deletions(-)

applied.
Thanks!
Helge
