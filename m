Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0606AC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A39A10E208;
	Fri, 31 Jul 2026 15:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="MRI4kuyw";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277C610E208
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785513256; x=1786118056; i=deller@gmx.de;
 bh=Y1C4bh6780IpNuFOw449jeOj4dHZS5E6ItJ2EMqM4zE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MRI4kuywOPMEabwJgvJ7QsDF6LllkLZAmaGUSwNmw60QJsYKcy42nQL35ynFjmwd
 abgjxYSCUnRV+LnhkQ6ctR6HTLNdiw60yY1lycoW46VOohFgdzopx6hhW8wvFR1kW
 uempZZVpQF4C07WJAyounU6EUW+5KpAQw1SeTVw90t73fhGmOhqiErgqFdXp0pQgv
 p4ul57ty8PAYqeEfJDvbaR1Hd+SrHsLKduVzYUmTHo2BI5qJBNWsIhEuTm+Rcc3HF
 FP6E3YhrIBleu6bV1KSAbrVO/p5K9ZbjAsZR18IjRlmZboWwpNrTghLPt35B79xhe
 ZoB7hlOpKOxwb3O7MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1xSThl0Xrx-00o8N5; Fri, 31
 Jul 2026 17:54:16 +0200
Message-ID: <a90747ae-e2c0-4add-9fff-1ff473d1b410@gmx.de>
Date: Fri, 31 Jul 2026 17:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
To: Jakub Turek <jakub.turek@elsta.tech>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
 <20260731-feat-sh1107-v2-1-0d2893e44ebd@elsta.tech>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260731-feat-sh1107-v2-1-0d2893e44ebd@elsta.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oq6CNe4QaF9CnJcxUdaTD/ZtmifMRfKRKCgxz656msFVE15ukks
 fpPPeNTuluezRjBMSpMs3okl6PzTVavuSC17s8K8x1j+QMGaMKtt6HIMYt7rxBOWfYR0S94
 0l7kYk1Nl9C6wXydPh+48Ntq9WM6/XPwe08bLWN3cgKwTQAhIro3BEjGhNh46J5gexw5tAG
 GKazl0kZ8an4Ub/mBRoww==
UI-OutboundReport: notjunk:1;M01:P0:HR1cIPI39Sk=;K0m5eq2HvrLDTijGcLk0UUkus4N
 zlRhqbtH9JWXXiQ0a96sQsCxz63LJvz3vIeuGdQyRjdPzIkTp5Ff+fYuDngytm/82nXYaco0L
 5TPFStfUQXS2tx2/GYzxL7sbfWtiLidxeySEJsZIRZRQUtVzf65yvD4Q9Yowk6yBG83P4ECh3
 GkFC9SINZs4eYP4gPpGj1uR1StWAOOkUhcz+VCI6Zn3WNSPlqFj/sDB0JqPHMyGsHwZxG+2L7
 lv74PAacgcwvwFOdHAZirYe9BTSiHr0GI4rvM0K73mDjjF48QLlKw6nWnsypF4qAfWXTR2Kst
 1MxxU2B5aA4TzOSkKjhUQttTlaXc3nYjsgUp/C6AgAngEetp2mdxDzfM2BwW6vM/Wbzh8K3Fw
 wn9+kzJMxfIlXWhCpODLPdztLnGo94k4OPiyNBh7Dkk+Lzlz64gfNf1gkPMB+otxlplnPZs0f
 wKOYZRkdIlg+ivTkfOFk4zeUjH5l8StWMqxC5SB2OHgF9fsct0KgcbJ8fZSDMMBDQ0DrCvmtc
 zTLONHUD+H/cHgnnfeAvgEj3PoPCnUzX9o0gUwkgKdIgI53BQ5LMiZMio/i8rTdz2lwr4VXmP
 rTeTZA7Lkktr6sPW+jiFEnXUsP4Oi4yv+SIVnU7S35LQ+kB54FEo4MNZcBm+5RkK7nroziVVu
 N8VNsv4u4GX7z54S/j81xIMiA2Q8Rp3XxRZwOhU9jYaOW+KAx6PGA9ayun3PMQFRDXQy8vBuV
 oeI0l9cG4B48YcUD1JWdyl1UMhvys9HRfxbQ9ysFctg8JcmhMe+gKk1uRT8sepQVfKTvg0PDT
 +dXNfGMqaJXmS+wwxtXzJ04ZU3WnIxd4U1pKHFy1jMaan4+12xdEscRBBGRifUC0vC+2pikWV
 gL0ifj+RzrXBBa+PUYD/3UzL0p1dvdfCLAjUjr4HKaefWyfRz1y+w5+YJ8RIbZdlNUB91LDPi
 0PDjDX5hzfoCUxmG4MG4ntu1WUzaUj+CyMN6LQmyTG6XcVQqwWY9kLBC8rNx4+KK72owMC1aY
 N59Aaa1yqIPrhB3Y6XEgyuYoaQvi2mSsYDcElV4uKWNj0uFDRYxXutB3k825fbAGJ0U9AHxzm
 5nBW2siB2+bqSKhzhsp2U3m/ThvUlKe0RWodp+4U95qGFHoOrNz7TjThZbf8SdF2INpX+WKWM
 2H/onKD/nrJgGkjXO02pykik6g3KmmakehbKRVrvATyUfQNqyhCxdrMPLHuXfX6Kp3AwW+oQe
 LKWwvMuoQlW4r1cNMgtAK2LFo53wvUr18r0AtHZfxk1/+HabisWBbv+1skI44HFTujzEIPI6s
 v3R67mzzlmUby3ujSYY7rwBHeLbQp8hFPfr//BhmIlSq7mMbpukdy/2goE8nrMdJzagOAHYbT
 2dJ0iL0dpGv7uR9ULos2E4Vb48WKZbj5Q29QaIi8ZOTL9ZmEKbLce+qKIGkDrvp3TgXrqaB50
 4gTs8MNS+jW4+xq/EA3ob9KcqGh1rQQvCPyNPsDKfu/+kAQFfB1JWkXRNTgF2w8UuEr9GSsGR
 Gqv5HIJepiQoaCr8S22gnEgoqiHrLYIKwCCHLKuyhYZXRzSRCm0rYmzZVPCTRMovdkfh+VJyV
 nNJpZXJWE+utx1vfhLH7C2Q0LDpzWVKaPUDT1UFxC/8IJUZeDu2hX7iRJ6kaxKqaP6+57zY96
 MfNrylYY3cLXa0cucrH1xsPYkcswpg3SBDHSBE/I1/UWovrKZFZd8mhZV+TW8AzYrfSqa4mMv
 VH//qDs3eIZ5i4k+iH6l9i1y1izsquDyCpGi4fj4VfZdFyvwjJCg5mJecn6oe308NTJoYN+Pq
 brKmT+/JnNNSRdAFN0OVhAi8pJS25u+7z8Ddm6a0OWKUUd5K2r2FKYZfvZqrR3Vsgx6StAo7v
 8gC+ReLry84WdVberbSMtoRofKiivmfiy9Lmhc1BVQRYNdgmFKmQG+Z+3zl8DWQhqCejQlaPC
 OERTvEstTk6ezmCvJ3yxqMKJ3j2+N3fcYDqU1OK65H9m1cdpNBjkVwVhDcVX/oU/ygVxTRzmT
 4tPd6oGBv8Sq8d+tNBwvbdFDlvmeg29fZRF8Vxbh10cElqByGkYYp5aVLfwqPn6OV6Ozysr1H
 HO8W3VQHT4DBmOWM3yrH50F/HQnR0hZAbQIdFho/TOxzGZlGc7l6Ct3NuOCcqe5YPDi62wK6h
 Nf5sqbc0EwZRdk7a3/wsFk9gKvSCh3QfIt6HIYthaU0xNjoOhqszvJqX+CfEQx2UjNAqYKnda
 7CaRJh5I+4RNkO5zrbfUw4g2ACEMM6oKNQ5KNb2zYC5+deo0Wh2xr6UFEAG8WWGkW0xNU9WP7
 YHx/atXjuG1aXXYKwQHhRnigad4t86vKka/d8PgSuXhoW1RUv8kMV1H2H2J2rIX9CrRwxbnV6
 DjqS8CNBVeV8M8ZlNwO+VAe9dnvIo0YIFY+tP7QOGJKYGeHsoZWKOOL/JUJbWiGmcrVV4+CE1
 sx3YGygaknEcWWv4ciofF/sgs5JJOOpdgUzlnv7D9YaOUp2NDP6PsPgTMmUNvlNx5UlofKOhb
 WKxaLiN0Y2WY1qrZSwvxnxtX8Bx4LNFVIMJee6Zyu8VVz8pdoKcO7z8VDdoTvmK5aaIxds8O1
 8BOt6rrqmvWBz7zgEoT+t0N6OCgp6ZGmv3MAOpWsnAwrU0AF5h/T3/hIIzxLcDQBFgPUSGtQI
 w8swSTx8IEglg9kq2TelrGVOGnQJqkQPib7jmX1T3dEL4vGmBroarn98ORc1CI1P52lyQiw2M
 VjfYscy1SLYELp7o82qLqmzjudb0RkwNfwiY2pNmnnaGGaQhjYj0xftC7B5sCywNkMxhtgwHS
 5lhS7l6WE5XS7kmUm8T3ko0IK5FCmXjygsBhlZfqdh6V2n6dWdIrfVZrXl2QzpAycNkqUelge
 8GgxefCUVDRxgPBniKywLhPyBv3skknhlaBimvEwrsWPrrJfg56JQUQM1IXPotirP6/044VgG
 qCTH54/C1qi/wLej1IC75LKEHU+a9u8rUZjRhmOlhtnIi/IC9APyq+QXaVc2gayIhRHFHIBdo
 hGWWPiWcEvG0cXzXUIivOs+zpD+A/wT+IDjNxiSUnnbdPN6ziIUgl/9OoYkJL6HuKBIKozU8B
 GtpSKze5rDNMhbcfi9OOwz5nYs4wKj/VFLDAy8Eqp1kc3mTq4web/4sisd6xtfQ+PW/Ii7Q7D
 x1AdyqgrG4U0eN1iCq1K9thDqQIVSMQtWbizfVk62jFQUau9Q0Q6idtL9kMnZEIMha3MZ/3jx
 NncFIUTecBJENhXgFT2KfIE4n0BT9ncrzs8Bnimo4J4TlVON0h++PRBI+UF1Yp1n3uXMZZNyB
 0J98DHv1XueYCOpyEMdisWBIS5NglSuGTJhqPmQP1Jlk9/Jz3ff7z2eAbr8vlx9/u4a/1NR/2
 41GA/yRhmhN2m+FhNA59wIHYuLQ5fftj4nd8OdnUBNCIrq024F4Z2ETKJ08erHXTRNgwpeeb9
 59H/WCrpqf2oeKaeOl8sJXCYl0CD8Iv1hhWA2/FR1tyY6kWNwt8bfaI/HA1Hfknvpgw4qVuQa
 BowGmdqlnbi9/6ZYR7id2rWlHJZ3FMQMzVQgA2vbWQRETnbx5ssYLyiT3mOR54xuP/sSfPmo9
 sdJxiWCaJDwMJbrLsVuvsljSLvG3FdWEyGwpV8WOKSidGvD0Tflj5C7TPxIWBHn7KQYvECywB
 nX7e1mQE/74th7fyhJj0ZT4aq1jsKtgjs0X38DfxCHBqmEwGXwQcMySEdi/jR7uobf0pJVfa9
 x8fjtY4AcEbahlyopKOkEoFDYbvtO64dFi0u6RRX19h940Y2zHaaYTbh9zJbwbg1r+wIJQGSU
 KdYTlyH4rJNni3xFu+shsq/FgGIOgR0jCzEgGnMjs4H2IOJ+tc8oV+ZefzvbN/BzaTcKyL3J8
 nLxmuLBvSORNNNBqYxucAS1NC2DVJTkj8ChRFzBvT5/fNCb41O9+yO2htpvQ9tlFLh5Xf6G8Y
 ONe696rBl0fPcfV6KjMBuuMvBj89ar6QBBCEpIU7IAmxE73ij69jz7AnFwez2GT5qx6TBI1wn
 cZsnLprsqGsJrnCdAPaEFtM2a8Mccncs1L+WtHrMDtQr0VhtTmV40F64KZ/L8Owo6VfCSS75M
 5cqH9tNS2FFaWwlV2680Bt8K+Zqq4UcLyzZt/51Jd+7kQrNnIBawZETvorojWW6HW5Rtt+ECr
 kT5jUdbZgVpAqLjSjH0Ftzt3nhSJnPNAa3XDlEuhutVJHL16av5H4KhVcqlrfGHGYKWampbeT
 WsH5Ya2elRIczH64E7ED1MvC9566KRf1qcOCODER5Rgdk69y6c9DF3GDHxZdXYnm07ugO6E4u
 Jb5qnhOVLt4PzjSUOM1zDiHR/2TGmJtuNdhBaKtbCJu6Wg2mQ8NmKJUTxMCCIHEWk1AHwD9dv
 YxRnh4KDHEJzYijqbD6SbOBFUPw1zoxXo3DWK7XLqYNtH6cO3KXyrlRQgv5laRkBm6nfPb77r
 42f6PiHsP5GGK1NIkOLgebcgjx+1Wu4MDpcYxFo08rkRURLedMG03tsx1NGrWIPmRZpGCM4xc
 YIeL5dyQb9cD5h7KQhWZsOPvCaMyPtS352sLsSuYwI7L8MhwPb//aiuc9sTCKlCyh2cGUmxU+
 XMnOTRYY2biiVvN3R9keYqFssdQsN6G4V1N3ykOpkgPXi0wL6XQuqynsBu4eE7XVw2aOKKDBo
 TSWYG/35tnn1axJLPN1e7Nd4eH+eXg+BMoCIcmwX3mkFeUb2FI9jGcGKheJYpmFnvPnBueES7
 M/40iuBt6zgvQqFrkQFfLOUrapNTuV12ECcN4VTuv9nGX8S7lmOpEknTb+iDuPlv/89saEyoK
 ojD21LBPcvNPIIZ/hFj+Sdbjy4paJiSIUbRzJYt/QuXZ57yRYHDFl3k9FSv8fFcC+pyD7nAYH
 jqTX+5an+gw6E17aGpZzIiokd+i+JbR6esfX6V0WpllvtsVuI9feqVtvcC9SgFSpScs+Lster
 omfMGmmwda8S21PmmtuHAGg9cytbcTmpb+mUBj854yFP5vWuqF+lpXrmifJF7uXjThnPyXFx0
 oVtkV16jawl+wyiZJn5QCzCu7qjQE7opcO2P89MmNGWy3JNKejqMkuwpMhALyuKogUd7NGg0p
 cXOCuuxCg8WxkznOIWucEp8GvvlkQYSSSOdx3dqMRTbtCNUvkX5kVvb73NKQnefkJsBvkgebV
 Qljx8uyp7mpwHeCsEC4JG88gJwA+X35y+bB51ZoRTYZsFtvDI4YvESq8ammcDZ8ocOim11qSF
 RVv3NogbX4Y5sOIjreefCAt1CGSpUl33z++xaJVgpKCBJr3jmFLwDtPqOekRW+tndjEk/SbmC
 ApywLmNxqJYSUomCzpIL0rZhw8lk4S32StfuIZvBfH/c4skHXsk3t6STQtFe11aAqjcC/GVUC
 w/6VN3MOCB7JPRIyXWYYcFFsypy+mqHpXUw+xjyrA3to10T9VtVwzIJ/TkvaPnNtYkvQhBCkv
 VBSCeHICRMqZ1iJdyQ6XBTtgIOEd6hjmAcf7+hTXbw7aaQ9ih9G73HS9GMwMYA9CooGAV7qgh
 oabsKr0w2oruNqV425ML6pq+zt7AjcNsk9/tIr8ufssh06s9xCeKko4wB1gn4vhMwxNdEmA+Z
 1qnSHjqmtT9rwBcXBjEQpRGxEXhBZM1YqbXauP9iXwms5GghysoxP2R2BNo9BKSeF5ro+Ifkt
 dNsikhdeEa4fsd8rdZQyTPei5aGSXJueZloQ3vVHGX1oQnPOeWYbFdYnSGVkDfdPWjIRmz20e
 4wDjDaByCqGYutAUKU8JwsvyBywBh1yihw0aL0R3XSq1LjKfA7lYIVdyBlIhefecjF3lE2eHY
 P48/CNvpr4f1jAjK/Gk9C7KM638tjMLgS6FDlA4vBBlnNI0QpzfCvQ9C1TyQzmPmYWxFZ4EYS
 OOUkadXr9xKMJsGeHxF/EP0ZJJ+XNiILTwjX0LMqm3IxRq1YQuICyKgBGpWIQ0zBOIg
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

On 7/31/26 16:45, Jakub Turek wrote:
> The SH1107 display controller is very similar to SSD1307 but the main
> difference is that SH1107 has different memory layout and uses page mode
> adressation only.
>=20
> The SH1107 relies primarily on vertical page addressing mode where the
> internal 128x128 GDDRAM is split into 16 vertical pages, rather than
> the horizontal/tile addressing modes natively utilized by the
> SSD1306/SSD1307.
>=20
> Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
> ---
>   drivers/video/fbdev/ssd1307fb.c | 87 +++++++++++++++++++++++++++++++++=
++------
>   1 file changed, 76 insertions(+), 11 deletions(-)
series applied.

Thanks!
Helge
