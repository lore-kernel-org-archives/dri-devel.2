Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB40C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CCF10E0B6;
	Tue, 18 Aug 2026 09:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Ae+zQHgx";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75A810E0B6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787044284; x=1787649084; i=deller@gmx.de;
 bh=2ycK0V7RzdseO1wPOcA5kgdw5e2Y8iPzJa+LHOjij4w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ae+zQHgxnRMSp9jVSokvJY/VdbQxqqO44YocIDiASV4Pj9b1eg4UyR6wN3idGVX0
 WXQOi1kmWfe7VpSe4DKKg7AtvjAojeGvQxZKsBjgxHQ1xCiPzSsgKQw4zlCOmmm1B
 67yFXIP8HJsO31R/IxwjcQ1wXkEM/GT+rBfh9AFATuZ/DgLXAY8EGRD18WtunGWwi
 WVRnTaVDLh0MWxJsXBgXkcfm2f1CPgFZ+f0+lfbAfRLuhIP1wsfZGU3jlld1pI2cT
 uJr8mUr77Cqj+WvsiMAcli4vIdAbbi0qbtqwBrjlL+Mjl9RCk7e3+Kc5w4ZweyAjF
 77VMrglYFzM8vLJl6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1wXtiO3Clr-00b806; Tue, 18
 Aug 2026 11:11:23 +0200
Message-ID: <fb011f12-ae50-4f41-a03f-ba587aba4bb2@gmx.de>
Date: Tue, 18 Aug 2026 11:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: maxine: use MODULE_LICENSE() unconditionally
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260814184234.3013510-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2608171800240.14132@angie.orcam.me.uk>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <alpine.DEB.2.21.2608171800240.14132@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hDZ0FtX6t7MP1B8ad0VxD0YQE5JNowK95jo13E3ma5r23tp55BN
 R/zjyqn6oCz3b1w//ZhGn4UCc1DBVArkwrwCHZaE3jUz6uDSK/ELJ4P9HYeLXi0OvcJT5Fg
 6ClAJbq4Z3duJKmMQyFPYP72G3eJ0rg5+JKgRJWJBrHTrks2nRREq/JL3zDDlqWbAfgNIbS
 76jwk97ID6SsCW8qo/QDQ==
UI-OutboundReport: notjunk:1;M01:P0:c0ct84hSxbQ=;kgEBeOjik7968L07PkY+kLd6No4
 lHMq7aQ1Mgxkuo+LCh4kOyYt2dAbPgLupW3UAerg3NpxK6xikGv9y/Jf7iLPkPStjBlOkF0LT
 fyqOQ4/KAS927Qv06K3cQ9deaSBcnwMX5FTouxjs74NWvJLdzRrMc/xEq61YjIut/O/opexME
 46TP5dnsvL3FkbGejHR0+GchIThyaY6TE1Gg3IdalJp3GlTJQZxhWgD7rE9z79StRn5V3kdlx
 sN0r1oQTiw54LqArrIEBk3EfPrT1TjHEafUSiOlO6QSA3lrcVvJ4/xAc8S/rwJrLsEQKgtpMg
 62ZReF0p8ilL/2APRcqLOMaqVSpeA4klNCCQ1M/A42Lpb9tR+zfl40Gh1w70iz3pWo7tNTLMH
 bUxgkSnL2jLOaKOn34kqfFTMZiZRdDpDdmLVKFldUPB4b8h5MGiR8ErBJBX4ASFABJ2eHTpLR
 Kb1DgQdgie4NQ0bfF7zwSxcUxaMwZ8/AZY0s9rbxGw1RrX8H1j900uemyKC1gWxlxVy9gXgwA
 Fz5+A6o6er41Lh+nLhVrTpfQaG9G7vFGmXYM5eKVqWuIskEKyXT7hEuH0N1bL631v/6nxryGR
 5vnsfgjQjx2Bv1n+jh/WfiMZl8h9xA733238UOL1s8nVO6mvpw9dWkc4kKnOsVLX3uYdGAeFh
 LDIC+EXH9WXOILzOdvH2N+ELCEfAetNvtUzYMY3rvbfvIswKscCa6KKBecnkmSJ/1tu4nrsdK
 u2WxlswGb8eiPXPLdaNePGI2UXaOKYh+rCvoNy3S+HLnZY1KaTcNsPxVcIlnvWAzx499IrJAF
 CybqryFbUVbX0/77bC8+5zuKn5YcG87TWiLnVcXEYMvucHN/qWZM/GJzTOrbzFbHAu+kXPPYl
 xypSJNVm+06N1g2OzG2cN6/nBZz5bWN87uWBaeipaoHBvC6ZUQ/4H3YRQfu92j3QhHycJQr9m
 5ouUKUJ5eAQJQuoI9gqn5I8On1j+K7LAm4O6PduGXEtmGzgy53wH3gjvEo0Tqy7831noFRlH3
 QElk8EeeVJrDAIdPc+qwkFD985azcb/sK2RNqOuQAqax0toB1JpgiLgx/2fPB27Z9Af+7KXP0
 E4Wjal1tLrh2t/xW9mvPzUHDZGX+fvZTwPzhmTulV2YrDdjBurDy0aKEQ752n5rOQnetnMhZt
 Xntd3+pgXAXCFu515ZhT0xNXIUJK6Pps1asAZAaD7+Hcu1LHoe1K9HVE0UiWE209arcsf9PYh
 X7OUcu2mBFQ0trcFd09+3Tws0cC/N4/mGGn8SEL2kl3iX4eNWWtGw5jq0Yf5U8hrV6ZbOaSw6
 MYS8J5pBbnbehG+wlpUtqS3EkR7GlKAfnd3has7CCKyvK9x0VKdE9Ktl8DXzY2/xIUn6ACuar
 FpPZg+HjWG3JN78TXJPkvsEOE4m1RHEuQ3U/LuviJfZ/bCkWVU573fLDqNN/YP+NUEJSpvERX
 3g0hBaNM4BIJO/QCsAvAUQUEuYfu3j/OFOpelRF9CYmFYp8XMhLJ/ksO3UTArqdDqoZAFu73E
 WJm6JZI7UULGE9twI5/YSij5+Ndf9MrOGsQcbeTVMxhV9a4jgSf/XG8T8z+dAWT2Hkt1mIbvy
 kNYE+qW/m8cBufqlzzKSMHBZKR/nRpo6actJ6zrGLXSx3HUtvcDsEeGzv0pP0ZnSHx0Zpv5z9
 8Rk/FToUOAt6MamAV+QSKp0BJYpvtl5CCBdMvyXCjKfL3A8LzYAVqoiyxBZMKndV9PJ9gUcSs
 GtSF+j8wv5uLfS58iWgUbwMBH+gxlgFw2jx712mbyS8DTeW1a6hK136rPb9PFNiaOLcOWcrGA
 gIi1038rgox6FDJn672i+AIcFXv9lNByHnn0nOASfAbOdHwU9fqRHhdzX3TOINnecuPvecyUY
 /oOpTeInCU6EE6YLwVMZtyqMRWXhjb/n6j9fyI80swqV7rD6rG/HRi/483cdhG5jci2HPoLXK
 2SEPEExeaXPnSAV8LDkLi8biX5olHS0YDguOxi04/xdzZyhqxLBOVOtkwFizH4Z9sh26GzhAe
 /P38DmlcxlcKfRTPbqeLeCruU00Ij05rUzLU/WtLClwosOOJhJDmkD6wZuBOf7rCkcYsmOBeM
 rJRxpNf0Fr4dXDeAc1b1cyIsJW15DTF5Y8xMQnP7d5GVSzmbsQi1ZbgdivxgJKuA0aZlXNQqC
 X0COu4xG7tRFfE1oqqHxyYTI3eLKnQevBvJyJST1XjbHZpTGWastYzGCObnJrDbj0vxnEFELW
 k6+hRkUaYUklPc4/WJkb6fGFZPaHiP/l+5/n4C02N+Ab464mSIMcTzv/Pa8k170ndZ4QG78Sa
 SFBZdZdC1GRTsIUdlKxlpF7pvu0WVginuRCuPNrt5dOJP/tZ6HEldiOQaGbDZAPd9PUFFxJK0
 BTxkx6Lr4kCHXJMkZmz+vfRnXJ/cBwGCPgl7SinaGOunakv1WDx3A4v7TemSiUMFyUvui8+g9
 2U+Oq0FfZ1txkeGyvvJWygzdCeO8vA1fFPz9mchzMBVU2iKuYLBTLkM0Bp4xpevWFkzqvQU4S
 9KLC2HP+uZmwjH4rXh9f4+4XPgWmC9Iq2w3L0AnsMr7pJ8Tbeb3fvjexvzhfKS7J7LMhSOg1A
 nFbBCVXCoEkEtFAGCgS43psrboemnxdwTqYip/YTn/vtf4itiaRXhCbt+vGGm0wINc9pYnV0V
 6jpWsF+MmUtm1S23TFlA7DoQoqAFdwcQXQ6hpBSeGvSMBuWtOXBzpUdw/c/bg4q3Y+u/Zcbdv
 sSTcdF6pbvBqXFJPFK+1NVS+4+45O+ItjqoGvWs9l+dsowNVHhvS4aWV8Xn84HZnKSEPiD/4p
 hnfMBRdR4FlLPV1hj4OIA3M/Yx4utj+3svbObWvmCx5EAYSbVy26EZxMfPouPjNerpbKPdElp
 ro2QrwhvOateE12YaT8bGexWn4Qz0MeulYVQVt1W0Uk33MB/b+UqG6Vz72dAJr55vWgCVjFmC
 m5DIHuyZQry+3OdSICVG3ygLflsFR6t+yFgWj6NjJGntABgSLhMjPm7BJ94zOVFDJWYABxlEV
 zctVo1mlQx+reHsVWnKoeQrDb4ZU4V76I39HMlQqgHhEoueF9fuYd4wM4iAmjYKRyYlTnlMDv
 YPRpQ9kvVZ1TkJpm0PCuXu4wNrZQQepYfCmVdaNl1eKV3Vh4Cgs3XORLKzt1+P7fYQSHkCC3t
 fqAX59pOYzFREIxGWiHHfW75igAI8qWs1fhRVkyruJzNC/zOmk3XR3AAkCuBMhllEyyXldpKW
 ypqBpL9gKRM4eCRYLDbasQ3ne5PSj5EDuGb22CEqxZoy2gzmxXFtcRGiV57s/hpCS51fzlhLk
 O1dKnNSjFa2fNhfQLVGuxo0LC8hESMYyRjmAJGAzdfb25ghCPr9ZfGRIP0eNGZWGGljb+3Rxf
 wmRLOKOJumupnmv0WcCzlBgZryYOyTomeJS69o1FJYrB7y1x+G6r47zg94kdFiRX6dIlgcNHT
 J3bBd8ziJ9NF6g+Wa602DNIHdDWAbN/djqfRIKIodrDkWuLY9dqGkct7/YIezehGOZwWPO8GZ
 /w0AqA00PupAhVgYbHYrvHEVgEodb8iOPlGa8gJydntA3RGXVjUQxnnrwXuAvy2mt4M3MRjLY
 jMTq9AMAu13CSS0D/7n2nR+02T8tCeOpJbwueL5meFW5+et3oTw/IdoigKznkfCEz0iUha4a1
 su2fqcpKFYo+WCkBVfram4LJmLlcieW866iOxvnDDAkYZwQs7QEVYngNq9lurMZqD91yfATw6
 RQISBQVmTCJ37O5nuHDGWTczGg7vJ6P2+GOcLNUR876r5RHl2VcUsycGvQzVyxWGv4+shT8k5
 u5PQ8sXGE+6zFq8g8fxxwrH5PrQkqjzSmJTf1cYNuswsRvgXs6H0rDzdsJoxnNUYUalsDsNjo
 RzmTLZ4rKI6zdT2sMjz5mcz4BZ1kFBAw4MbtDUjS0hiKWZpzqO4Sbcs6wq9AcmnrJmk8sZQLj
 Ei+++JUPanHDRUlObH+0/287KLms1gWCq8AXpCtL1dI6myYQSkmVzqodVI0ownh+GfFsVq0hE
 O5dX1L9U7Dibj+5VmnZbLTH1wOn27f4v/f6ASqTj/pVVO54DjnzEpHNuaQWVjXVVs+NhHg/Vt
 BPt44lIFaDCOYi5utLf/sbQgaAM3fSt0pnPf07HZ0xSa505OaoCcKEi5rw+0SGFy6vTQqASTI
 u4ZHZL4rcvdscSqKAmSPeb1wZkhmfBTQLyCRk0WyQF1d6gyK4iCpHkdWigsWYLJpalnRkJP1V
 b70kjsAlenKMx/qWlA3YerBBBUmSuJ+PP7sjjER9DDzMRazIv6LLhDfpAetYWtAekNZd2nT43
 99bQuF1GzDaiPi7JdSmR3EfPClSGCyPrHZlCwDFMPdJmTpRZ+U5Qowgd6DzAGlRfzBXn2QPwQ
 tAFompwl17LjEmgLLTCP6sjahp197Xuy8fq/FUzEx6ON58yAuV6lUFW/jSgueI1yU9//oSRj0
 EsX2GIr2LDBzRAK2SfswtICcxvDWb2odGlJyXQYT7B+7riKOMP1sYgYSH/nJhFNdi+EqVsbID
 QrlLvjsJIwbXQmSaD1qiNnlZPxSD7h7lWviVKYhk0qJ1k3B4vSwSAqO0TG66BSkvGWbI2XlPL
 o4fD4LkInhIg8YBmWomUE+fB0UMTefjw0zT2AddTUidPKflrwEkHcYjbrh/Kr6aKW4d7YiD4v
 +6XPUQj/h5nkAIAaazpPi72ghcsCjRql8JMzbJgHuw838I+hJawmXYlf7Q5u9Bw+EDoNnZAhd
 RNL3Vy5ka1OYGJC+hoKIuerukTXURLyV0QEc7I15W1h8su63385UTVvDhtqN8RfsPnQjaaQVI
 ctKatRHmz6ETHc+KlHvhq2eBZnCeRoBDCL77c/bo3DD3xKYJEi3ysOeFmVLxY0mMDnbgxNGzX
 uQp3350JNVhjNauca/vK+7VfYUaNt+fFJv+/m6EixC4nUNKQhNDUQSdsNrZT0DnaOhOZOeQvq
 9xcGnN/l83dYapNq4eyD1EsRHJXk+MCrd1jCRdC06bozQJsn1yx+JxdAOXUfFuXJXyQ6n+9ZQ
 608eMTUE2ACCQrQT4ijICVR5wmrHHE5i4kdIpmRS+2p45S1ogu+Lxpf2XmQwemmkWYgvnEkId
 fM1oPVA4SSGEOspJt38TPZ9GtQ/bPuxSRjZgwXDfgcbOgGVIsTmorQ/o45MMTTEi1Q90ry18G
 7npfYrTexkVwUc0e96+e5Tnf+VCQmAB/ml4RKFVtwil0nhpEaFozF80jynYLDcoIvYllFpgmG
 wvzpxCbROhROCpD5u12I8Q1DvsuSef7QN0ay+OdH7HS+LSe539ecDcP9USTqJ1ON56Jq3wKOz
 EqXl1njuSTb4UkgnDVjLVsS38iO80UHOtSgxAaNy+Q6zFPWpbziB4Xv9f0Y8+JdT7en/BokUu
 O1MOWVFZrI3q3kcQsnRUSabNHwhXWNCUyfF0lWAiCASDp9iBi84UQc5HM5gQQ9Y5JHtqBCvMk
 Y/WaVwFxBk7gMDbp0gkAfkTdWrleh2g2vlN0tKHvjwCNZVGN9ue0ZTtxkxYsMWnQxYQ74OOtZ
 izGeMoY1xiwb+dnNNgqjculToYM+sthzwV9Dng00gsMR4Xa/sGLuJOHUHueLtNRapY6ndMerL
 BCx4ftW1jMruVbhwqM6KXtDJCdnJ2kcBQcpMMkdrhKXeFLfBQZalN7K9a192M81IKrhVb1ua9
 xI6dCUbj+mki5TEWs1c7gly5oWuQ2n4Melh2pkBwT26ETVp5ORmie1BP0Il4ZKgg2KdJSZeb/
 hgz5KiDNy4k8qk97b3h3CuJstNd7O6QvjX1TxMaVQrmo56s7t6WEGLRL41kkq9DxSLXIVY1Qz
 T+t1OKbSWJM93sQFSlmPuAaWifn4Wuvv/5M52tH4Zryzh2Bzon9gJcOrSgNwKP5SctGyZpWY9
 jpq/dHWLt92FixskaN9i99e63sYVpD3t9naQ8OGRqx1rzVHxQIC7JTaoNv6c/bc1aQMvVjFhH
 n90bnc4YhP8lI3Ks9pGPBtbMN3pbiM4dtYIAXIFjuoCJ0PP6Zwh6DpvMXlUuCUTt6+3d6lel2
 WzykDFoPxyEbuQtd3tKxtauERof59twQci64tqZ5U5HLh9Gn5gW2eTIHQY3pOvLOAEkQI2Cw/
 VDloVyjuuBnUw5F1F9WdFCVHMDmLYPt3jOo2zhcVgMtRcrKHLfaiO6y1hGL1hEhis/HLL+GGQ
 iTE/UstMqMzC0jtspsdEWuyw3Z2sZCmV3STQihZUYsUmnukPddfxo8jp6/0tIh98uLnzVl+ba
 M6UniW2w+3lmzB9Cj6XwaAruw5g9ixmX67eLDbLeF7VhHHyVX7vPfbcal9ZUf14ZL0OoZiuMQ
 F8t/m5R0Vq1vktMltV1vertIlwqxo8Jsb7Eq6i/sk4QPPOixRR/JkzPo2SXReCsBX90yoHNsd
 +k9h
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

On 8/17/26 19:09, Maciej W. Rozycki wrote:
> On Fri, 14 Aug 2026, Randy Dunlap wrote:
>=20
>> This driver cannot be built as a loadable module so testing for
>> "#ifdef MODULE" is not appropriate here.
>> Also, MODULE_LICENSE() is always available.
>=20
>   It might best be reordered to the end of file, cf. pmagb-b-fb.c, thoug=
h
> I'm not sure if we want to be pedantic enough to do it with a separate
> change.

No need to send a seperate patch.
I've fixed it up accordingly and pushed the updated patch to the fbdev for=
-next
git tree while I added your Acked-by tags.

Helge

>  Anyway:
>=20
> Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

>   NB making the driver modular ought to be trivial once this has become =
a
> platform device; I have converted all the TURBOchannel drivers already.
> I have hesitated poking at this one without a live specimen though.
>=20
>    Maciej

