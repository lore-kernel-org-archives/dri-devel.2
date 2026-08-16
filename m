Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D201BC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 20:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D18892F2;
	Sun, 16 Aug 2026 20:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mNViS2r/";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1D1892F2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 20:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1786911663; x=1787516463; i=wahrenst@gmx.net;
 bh=8q4r+CxV8T2OpfAJrQVLivtJ+lvy7BRdyIs5z6tntkE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mNViS2r/HfI3F6H9gNpBH6CSXafG4ZbHwI0jRX05Muzo1rFs877RFeSMsioRwo9d
 ZFTdIydVo31iRC7/wIe4ZT8D2se0AyDacNYTfVQGcT2beOyEVa5m1co3WAz5BwukX
 ime6BINJKyxQudMhRLAZyfX0w6Y725cWF2vcgptMEsPb5eKhlYKk5suE+uJU5PKGh
 M3ojUkrN5wXbyYAjQYiTZT2B6Mq3BLketk0cBSxHLOy2FlQFXhC2GRk70DFVPf2Zc
 /QVgoihkN4JrWBUpY7vkdC9GMHY0v+n1jbSZWQJlfvyyycCOsWDuOC8nW+D4rW/Ab
 QqcNGu8RSkNGZXKOjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1xIIi90Rao-00Uj1H; Sun, 16
 Aug 2026 22:21:03 +0200
Message-ID: <1c0138d9-ed43-4d4b-80eb-6757491e9a98@gmx.net>
Date: Sun, 16 Aug 2026 22:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: display: bcm2835-v3d: Add an optional
 reset line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-2-896444373716@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260816-vc4-reset-control-v1-2-896444373716@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oA7RNTxRz0mixa+lfc6Ds+lN57ss1KUthwZjJapdjMfZibzsfjw
 MyN9oEbgaj6BX+Up1h83yG5N0qa8oXKav/DlCiC88HHhwQfsqbYPDki0cfhITGLXhDuNnKR
 3U5SyrTqxxKydgsAobXJm66rmtoKnLH1UFcDLTMztgKaX+Z8ount41AhFpVbvGfWvdj6ubK
 g4/68EdghvodiYxOCOasQ==
UI-OutboundReport: notjunk:1;M01:P0:rJQwaVJJZMg=;YBjxDy7GoLcf/c/sqfTRi3GKEuU
 fBWQqERiBHlSMDs7CRNJJABOk01YUPgg6R21PKy8plAbp5M6t9N6qW3mIYjHjFfkY3bW8P8Y+
 nHJAWWR7l/Drug4TPxBVO8kTHKMN4E/C4oK7WrhpV5RyEcOMM2HDPG3iqU2lh6dghFcF4m7S5
 tmxHuRyhqBoeTJ0pHQdzlV7jyf/9Ed3gV8vFtJAltglwmBciGXAYICpV6oUZ++2v9VTQHLrMj
 4H5iWuZ84kJ4KI2fjIDFZ06THe4zZhmXKLbMTTKn15OS7/9R7QbUDScOb0Rf4x2m4KKrA6IN9
 ILr3Yh3FkkbzOgkfWRCtx5R9IdoYZMpTpHIu9Zu1hgJa5vyNn+zkYSnrFrI8tIKMz+LaOjEuW
 /58If5Px+qWF7Qc7laLzkKFRSNZMOiNoWYFACYLoygq5JdjS6TtcgAvmmFJB38igrgRvkyoUR
 sb4MTo41dEns9YLfuCHqm+6U4OB93OHjCR8EfpMLPcoQIEsFkmDLZX4CijWGun7M0NHWWIahx
 UVqsd0iE0t0JDcGBb0m9WrPGJRjFF0228n2DCSU1zMXMTdWxAisVqTToxnSGlKAgCZ8t3LHde
 QvQyx3IuEDr12M9WoNdA54l1CAyFxe/pMvRlOw7bKBjLNzko/HxAsKt0ia7VogFGsQzUopPiU
 ZHjJf/jbTPy9XLqGoCFcZAr/2/CbpZMUhhZjv+N9Tw3KNWKgknY1fi1yDrHpniiriltMflA1a
 8Fhg9eKVOAGnUhkm7sPczp7cfjWUFBK2KMf1ytiZHducCv78U4P7uPhzP+OIS1NmYnB0ubwSQ
 C3uQDC3ygsL6phSF4aDPO9x6+Sget9xK6JitAoNYx0FIP8Tc5oHE1yyKPohyGYg7tT8plfJS2
 +yFagk/138KEWEgvkdV+Krj/cISmVP6MMXjafXZZH9Kl49y5tqLL2RztipswFykZIGYEB/jDq
 zeEPRGB7JAEq+8wpxcbD2+8HYhMJVgMEh5xQIGF1AIyZTzAnnaLJSh3bWRrzPumniTKyUo8K8
 Vz+HtVepweKegHbpU6O5SfQtj1/V/3M5SnycZlZLaxAJbQ8T6pyUca6zPDCzZB3TzgxXqQDrS
 FaEn5DNo/7KSU1lwrXDo0i1FTsKuNuuhY0hB9/ofWvA/nfkNUUYgo+s2cTDnXo3HzGSOr7vT7
 f5aQLvOpmeLRRL+yL+erySErBlHUe5tVetldTVs0zcIOV3BOBboqLZXLglL601Nrm+IKKCVt4
 kjz8mtMVIAHSsGA1bAj5+gGvYBUeCB2JId6TIeccOHqnKePYGeL/iLsIpGKuq3V21ekrJ8rzR
 6mK2GmxADNawHwd59Yays9uhGjwv28j6nokRq8v8rmGZq6I4bwne0CcEWeuraBOFreD6i8+fO
 K4lImrGDZDv/sQGWI8wIJ7tNu77TA+n5YDBuR9K8avPDogarc6utRPAmvtLC1Z3gx0zXuKu6I
 XX4oIkM+6i97Sc9hzdQwx7TxHHy4YSCUuk+V6rvoqzVSIUfmKUEVpArpQhswZDsOBpPpUGdKU
 4rkxqsj8WTjK+4lfird1usiqvmboxF6YtnoRSfYUxT7tFrC2UnXMLuin8QwB2E3MWeRypTsYs
 LEn528B7aV24f7MwBOCy4ibs9CXl6Md7zIU0quVfZrVPicZM4E76dLyZs6lKp6Cwol8fE1uTh
 86si78870DjRjoBzrDg57Jpfy6nKBkF3i4diBSdPp9/4y7nS9ewoipsu848n+py2RXFmRq7+D
 eEO9LIl8bnSsil/ikDDHubuDT4qJruYsyNwzuvtVRX7lwomtxolvd+ldGHzWXxgxztvXejHnH
 f+tz+Oe4WqNF4tXSijkGa+EnPC0fxouknVLpiWfCNz/3kjuCejWjGHXp2dXLqbJFEybGyLrkR
 XlvByg17dxmPrITTUjH1j/sO9R+fUZ4NdSSm2HkdY7lyR1mE3rTh5H58E2iGn+jce5kwtCTBW
 ptVRjQ4REGq+OfnWtvEhuv45nnhIjNrZXt4O+orsFfW++6ivVwjSnPpG6vuFcKwglfj+JKGOd
 cR8qGJ8aPZkm++AZGs/Fq/HPfZbIHhQ4X+oIgpFEYss7UF3vBwW6gROI5Btee8nLUTtT6sfzU
 mdmR+y15KVcK6/LrcXFAYdFtwMqTsWJBMiUQIHmkrVmInD3qlquG+5DWTIXeHk9wKDoudzC25
 pfqUCGe7jDfi2nbiaVNqgszPRmgcLuG9ydq+mlW56xebZouOy6aL1UeaDdiu2/Dsv4ScUOrXX
 v1eT1sdzLFD0Ipt6b+yh9bBcX0aszUW03xfxl9uNsnoHx0Ha3DXZjpIU+UjEn+H2zyV17nDhl
 0a0OCyInU57PwoVsW7PEioyITTaPBGVNldAMVJgjKs0QhvC8M7e7qIQzaiLsmliSiqyv22h6M
 Qca6SoZxoliN74Wu9E/pM3sm5LNbac8KCMc7CgEnaRNsbVJwvP9zyF9I6l4F1qVuXM7Qhrmnp
 Hjq5SuAjzPFa6A3fs7pInhzuEq0SiIArGyALJ6NLLpAXQRSTuluASnhuWZhTBjxSc8YQ1RlT2
 wKWIaIVY1Dcqkj9VloSFtttTfsCreD2JUDpt2/TwUNFsnAYwPOpvh/KGBDbuYfmqHu6WrKSNI
 cAcO4O6vgu/vYbW9+PKD8rWR4c8UvDvDk1p6WakXRzDmUSyHE/FH33RVRlatK1N8Tp6LysO/v
 q8vxZ0PH9wmqV6KDlfmo4lhiYIBOcrK1cYui77CIa1w828BF8IsIeQPdglcGRcDfTt4pMKOrm
 S4lk9aZum7oCv10Sc+ji5xAl2CV92f26vAgMWtqpx5tdXMISXdVqGArPGivoGpd6e6VpnNLaQ
 lY8E5uu8GO2Oz6d/yRJOkmW6Sh+4QjR7b4OHjD+ioWzT7195MXwytPb6cUDb4phMlpXHz0Aqh
 WaT8KfIxOeahtPTrV3QSg/SQcHql7OZ2ChU1T2TqZOoW/w6hl8OAH4G7G0yrO+y/dOG1pE6Ap
 TvbjSj/9cln1J3lu7jXCzbPsP/dYT7kJUtz4WF9/g8TmD6Q8hcqj6At8/aCvA3EcKBwh0bxM6
 95ZG5AdDQHO34fvWbsSl31iSSRDhFKCE2765h3pJT0JFnSBcFmjCVPOXxPT4r73jGbz0FZBng
 E7LPxu3t+6K8zkWPYlAr9HPOkqBatkVcwUvq0+9Qc8ycxiPonqkJ3H/Ezvi/7US9QbpujmYUF
 OKjOkby30n0RtSr8lvaN+0tzzMsYW4Dj5dyiVzed3MJBh0VhlqYiM3mTpeGP2PT4wgP3D74hX
 lOtjNojWzG0Vaj/ASASDms7b05s68eh6apWI8eHiyDP8yaZror1whdERjzoYmSlvNvNyzGRyM
 h95MXggppeaEemGDEWW6njfOJcaPG9E446y59vyFNaNVbyQ4mn+9L/C0nkbQ9nw5vX9OjvRwo
 ftsXG3VciV3y/Go1ZYUdqEhDkLOqNFTl3ws9g56lh+dUaUP3NKzIBumeJ/Qsbmnk25gVuyf6D
 tsmR5RVAjotl6MmOTIoZ0mB7/Su9lOq+ceFj1G6ocuY6yFEkWp8SmqNzcqVSdPOzzwOljGJyp
 8XeoJyk6J6xJFwpEId+VXj+q9SjgrxoKMub4rY2hq2qd5DjdFa/uVEUlkTzo+06uu5WGp++yE
 chP80SIPuAfxoK0EgFzwIUjPRiUyYM6MlezJu7LGHySRZsrDo7JzJ0O0wziqWZjaJYij4zUdv
 pONBnoXu5eVAh4SaVjFUVNWTJnmy8Ec+HoDmBN/O9r1kkSxM8VwnMYfD/xq5aLUY4K0fDSsTe
 G4CiG8VKe6Uihm2fDKlNAsugwtYjMm+XyOtGJafNk48yeOckVX0RYpdrKfQr+zSRVdWVnNy8H
 t5QWit10RLjQ+X/YbLseSSAzvxygRX+ASV30+KaM4GRKGAcFBhrxb0i3EsVGZ93PJC/v6TR1r
 mfd1cXVSw0duXgyfxNJqeLffO9CMCZ0DONGgsWm3463WnaCFYzjA4e7o4er6rot6ycifTvhTN
 DNxtLxC+hbI9CedWzU0nrUQSInDuItKbq82mbHCqBpLAnQX6tZUMOYaZTmdrPBQVBEjMSMR1d
 I0l+ffJ2kAHrYpX52xZlTuXMK32d8pznNNylkLtC70TWL3HqXntafBivXMarC7Pq++fINQ71c
 v9E0u0wS/kRA36Ijz3vCQuP1RZxBjyCdbTLAuisaJoYgTkF39im9kuODNmEQcRsilxGbazfhg
 8PDysSWGtkIez5ZEvCS7x2cbKDYwQj08+nt/OfXbTQ39/VfrOSLRC9Y3hETGMMP8FMjw9bVY4
 F395mPQlsgXrvjHps7iytMiUaFY/RCBp6lRK9hr15llpTWaHi98xGYNhafasUJuRvZ+XkWab9
 mOr+KT9dA8sEcL+SeyaZ6UC/maLVOuEUVrIPgQiWQUOpk1vO2yiqhRMI+MF8ZTZsFJw9EZ1RF
 SwIzyqhKkKcGJG8+7ebONwqt30FDn8itqBS+eCYit5UgrUgfmaaO/MNdEIo1IyeYS9HaY6ahX
 1D7Q0jZm8S0LwyjnlFpGMt2JKf0+HQs0obvpsHsEsOvuIAZZpqUlG7jEV/+uYxomYCznSZaKf
 8UZfLjXZwvELt74vW4mo3GdYfc7zTs2x03UlGdSuD3YwJbpywy24pTKuD0mpA9lhdGjYY72AP
 tpozvJOAB1q+lcHjGymFsNuqh4nZZEFr1ydcOdZi+Y0yio+XhMizVgztF4nWDW2ud4PomPblg
 s78sGdHo25fFQ1mB+wpz8gRTZ+jRWk1KfbxBI1iaLxOaspI8QuGkRUPWr99eh9T/ajYT/efnB
 vBc7r3rkT2rCKyhpRwG0X8YebfQe8b6Rf7NcG1ptKuG2wPnHBuH9bjX9SQOnI8X6c1+uUk53z
 FQ5Um0lPz6pS7Sxux+TKCjMpvJSRbMODlHYK1yRx00cW42BiqnY2EVDTVAmY5VpKB94rdBjvl
 uRaHyInONWHTwKqYh9vsk51RRnIEwAtiTUMlru5gr03NZUdy64XzjfIY8PrGDpoLZjsBXUk4W
 OmHUnQfUpAhGAMU4pOhImYhvkhU93tFxV5PDV7R02kqRn0azX+KcL7veEVLu7lp21l0DxFuvd
 rDCotVGa9wuhMj4Uegma0QKy4X+Yy0UREXsam0cc3uWKCKvMPw2XYQs/xuqtc9NHjDQi5qoFy
 gB6+nQMxi9QIPdJc+safy3dzMZ+xwwkQjPyQw3d017mJ2qXbW86ruDXvwpmvfvAbfOW/f61HY
 tXIJb7rotxfBVJDlLMqtd9G8G/Sdx9ZU4DB7ZxO66xfTu3d5glSm4X82uWrmJV249sobbE/uz
 ElvipXTx1VaXUaBTy8O1+4DQTLaRG8PBVb1j/Es1siYQP3h0FIBlxJqEV3SiX2woVub17hjX+
 UMg4tBE+XnLpBlNOXsxjMIeqd3iF8tl2z5BdMSyFcV51YM9cmMHAtfRT5R9AVen1i5sFtwZRS
 QTUPYEi3e1CRZQcPBaRxS7/AkdJWSQqamdF/Tuu6deM8W9FkjZ6aAITAUeRjQRw3iIQIcteww
 WhCfFUr0jM3V20ZrXtKyU7ykXqS9xmRKedQbZeii3887a4zLep+JpxQaviifhg/jCfEpqJB8N
 0bRfksQbkEXXaZGPd/dM2WgG6oBXabWZTv4/6QzfeOnsZcqbzkNFHaY6qwprHL/mblSlIfWRR
 0Zw9+npL5g+Y5U16z/Gg/StE7KQCEfdugomMwFlfpPwo8pUd3ZTCVi7RnNe4rERD//aFinHMi
 NwSqv8err0NAiqNwPe4eog6xUMv3jqjHGphIDBldOKlG7Nnrju2S2+MA8xd5STDdaMKhQrKfq
 /5Mvof81KlzNU/8iKdZQt8bzvaZmG5+fbmSO+H22ESPMOq0lANRy56KHqqWZXvzDaQPCNzYYM
 L8gWtREGbaSv9ACoZFxGW5vYPCTldzGPuJbsXuCz1aGBrBgZBaHv0tXF9Pd1JXQ8Ou13LT5pm
 VBbPXLD0IgXB+AyPtcKEjyUfS8+YzIBLMsuzWDfKeQxV3Rc1eQokGOCzeMnUOPFHLnyVjnFhA
 fROafh+xSk9OgEPZzog6INNLsX4+Cjw+eGL5Hq3ozQbbgS18j4hNuVsP21muB/XFnaBnQ7/Bx
 wk+6BkPsHoM7PvxBtO5FPKk/9ZWgALs+3g7LOMZQDiheHk1wu
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

Hi Ma=C3=ADra,

Am 16.08.26 um 16:05 schrieb Ma=C3=ADra Canal:
> The BCM2835 PM block has exposed a reset line for the V3D block since
> commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domain=
s
> under a new binding."), which allows the GPU to be reset without
> power-cycling its domain. Document it so that the vc4 driver can use it =
to
> recover from a GPU hang.
not sure the last sentence is necessary for a DT binding. Except of this:

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>
> Keep the property optional, as existing device trees do not describe it.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>   Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml | 3 ++=
+
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.=
yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
> index c55a8217de25..1063e686647c 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
> @@ -27,6 +27,9 @@ properties:
>     power-domains:
>       maxItems: 1
>  =20
> +  resets:
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
>

