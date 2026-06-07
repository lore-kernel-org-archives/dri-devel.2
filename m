Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1C0CD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 15:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D697B10EAA3;
	Sun,  7 Jun 2026 15:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="F4bvby5Y";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FD310EAA3
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780847401; x=1781452201; i=deller@gmx.de;
 bh=LoeR+NfgkHUVmJktRPuSDFt7XIsZOfbx5/ygDF5NY8M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=F4bvby5YHK7trH6gtRpOCL+S8zx6ohyDQ47QS1KLC3VmdvoWo/BByy4zJSObRV05
 mwpUgIbAL7QH52rL+xxJqXgeyyQEdHoqliOvum42r9g5zV/JyIbYAx7zs9MIkfC2A
 gZsUzMoUTZCar7ZoQ9YjMTgZ7A/0n67wDrN7KddGvd/vV0UJMDrTpAkdyZ8ERw4FA
 /pYvyw3haSjnZuygXeYDvHuiTbshmAwKoYV11cPcfnK7PeF5trxr9qiIfRaxP/Xb7
 CVjmtlLxT4SMzzrQSeV0JGoBkPrbMnUlcfxwPsNlSrvKqfT3hWDd5+MaWx7jodGY7
 AEqsiz18X2ws6PZPJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1wpqyW2SWf-00VQqd; Sun, 07
 Jun 2026 17:50:01 +0200
Message-ID: <a2ed1741-f49c-4a16-8d4c-e6698bd3dd8b@gmx.de>
Date: Sun, 7 Jun 2026 17:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/video/fbdev/sis: Replace strlen() strcpy()
 pair with strscpy()
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260606202744.5113-2-david.laight.linux@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260606202744.5113-2-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rcwKPeJdyUCwFOSNY2NxezTzMKYHP3N3v4wUqRlM2FX7W5Nkicf
 kWZbo7EFXEOBe18BOFjxkqin71CNyipFNW6o30a+UvoWjwDWQxNtnGEtRTKuJnVZEc2qgml
 57N1YP9y+kCvlVr2MArp5jIzPGyADimYbCeVet/O9HLvuG17BxvyY5HyEMEi8ja3TCNC1D7
 22GyNSSP1oUSjIIkaNXgQ==
UI-OutboundReport: notjunk:1;M01:P0:ICURMcL0C2Y=;qVel1SbLfcAFMlAkPhitAqP8gib
 NppYahHs8ehmSarI9JRhc68VLrZF/AzeDYev4tbcFLy04wR8L0YA/VlcGgP6J1y52C74ov8WL
 3tLS0Lw5Wvhe7mLt1VkaZhGIYClpxFjbmLp/h9WcRZKTJTBHKhwPlNrVgHoL1SccbcUyPeZfF
 /L3ZD6e6UPhR4W82gq3Zq04Yv7uexHZKTWccxomtyutg+oNg2bto4liDeal8akIlmbmk74Fho
 NI5twCXY0FbMmPk/IvxQf0wxc37K4qhIcnFSZ+p9niXlDoFZzxNVR2HNBvevcsmiHT+zAYGM3
 gYf6s7LDjQATYd+OQ/qfdZZJOCFdyswqMw0o7IIO3C5kaqcNF/qMntQZUdv9u+xVwe0k2gFkJ
 p0NSfXSOq+jY5H56Q+UEtQlyYM5gMWd+WH938gFAQ3oiSijkX41R2xSQWKmj14O8QWb3cDpqB
 U+LZ30WVOArhmZ5jW1/0vJxpyGVpc0Zu28qpMWASXNh1UtFIcJ12ZdSdOCiZWEFQCfO159h4l
 RbVtkh1uzoqgnuivZuwLmBKpad3gTsh61ukvC3jbvjwXCnHsoG0hirMpLF1a45icYNRT0dVpw
 jYez+Ey57QKryexpQ+kZ6LiBZz/qIpyHSDJfCxXZu7Y7bi8y2YhVgJ/uYfNIcr6P34hUaJilp
 CipTudDIpTkDbRu5oGqDaxSX22eY3t8WZHIy+eIN2qCzm+cCnvfC9s8Mr8sOho4esiRW3gC0G
 6k2dqNS9GsMVVIk8aJhyfjKIg93UkCzBS8EnnKbDvW5PzFav1T09Dyu5Wh5Ty/fAZ6KqiPUTO
 4h2cMmNdQSlPmw+qL6oL3pAXgKGZ4Ofy0fdDtMapDvN/dZtG/w6+yRQF5E6jl5v5LMcYhjAKb
 +cCKO0JVeTVVuSLepjrUUbwbQ9Jj69lTohzOUYmquPoisPPcCQLzKbQ3Ivj8bfFRrndJFK7bO
 DJ+cEnmJqucqgeS4wkLBQnlkH9GQT4pesuF8AhM2L0UYfNs//nHBRqUEhF/ehvT5pg7eUFEyk
 baS4CqAFA+18YdethBvizDYJMvYy96w7oCRLgXVGLgU/lAxqzgk/A05E13qrM0QBnbfR6ZX/L
 qm5m4ek27ixV82uPpzDkiENRHG7cvn2LSE+WnRaveKg8kwEBNYMstA/6LR6fEAlMOZwm5B/Ni
 5KJI7ezLEM+SzYqhk6y872QISV0Lviktc9B8/ZmXTsAcY+XI+GsHkeCHDjwiA5bIQVA4vJvnJ
 nHIX5k7a/s1tsqvIBvOEnvNgR1mewytGiSf7oI9OQaCqGiNYov9XExu/jkKSzDDmzxLkAK9rd
 oZ3B8YHm7fP0luybTNsCZTBXz1PLsTdY483rsJhigNyO6f27TyHjh/KPmyKlEWVUzg1X9frA4
 5UGu+u26io/JoWr/jRahPlhIUaNX8eI+dQ6y/tQTuDkLBU67mGejl92NOqafv9wuga0woaKtL
 qKetsjQRi7wXCRKwi0J5NjJ/83p8fBNF7eF570T4yz3HLWswKQ+0qlWnfX7+UZdRs/jy01bqb
 gT9N/BQPJdfeY3K881vETxACh8U6ULElWrW3eRmNwxqX7cAEyduxUx+tn2r5HIA2F9T+vdW3/
 +h2LnetI8wcPMgE0RX+N6KmJbiudOm1wGGMeAPFFGP6ToEfTqVEu/99QJGF3zB0KW+4P53rZj
 HJE3dZkZivvHYayha6YyGL8yQawMOwHt/reQBrI+Qi7n0bZtKG9ScGuTrcFf9WlMTVBkFVjQn
 +HBjxlV7BWCwvcHSifngg58cSekHBxs+DcWh2XvjtlRMWHGm9kK5DPe/RqPBsXUErPBMKWFt9
 dq+sAJ41aE8DzNk53uZHLKtQMMmXthkfJVhmzPQlPnHVB4jH4uVir+YlVrAknQCsYeTSikF1M
 4gU9XSLvEz3p9TyT6yvBD8A4SdxNNndLysPqFPOPaElpnBHgIyMSkkVpx4saQ169j6DiDaTN3
 umwq9Yhfg7oF4jf3MYy/Cbe/uAQYTcqkyHEZEdIBBDAfbIaFwmpZkhyOrjQeBkcMNTcFzGFhn
 /xZy0pKB2wT7K8Umdrn8MtSkv0rCAP78RX4qmA+L0uMWHMwO8KQ8oAbbJbvZXBELbjme7R+PZ
 yHGkpL1pI68g619IGQdEqCiy9WSBS0oKJZsnHSvZleYws1VyfWD8DAEW04X/X+yknaj+klqjV
 UeTx+8ye7ox/6c9tdD2Nljx2OXR+jOBWQwYjdwASLa6MSAl5yS4BV6P7g2ycmhJL7Y/qe4IjS
 nXbTOGhMg8O69ed+TzX9kKcwVYENqUpe5KvabZ/s6KoPpp63Zil4cri2uubZlsj2CD4uB3VYf
 W/pPBydd0lvuTRGaVJrvXGgTBCnzr4N/A7lMqrES7WmToLB4OkAlGDFesYGuSB9MiaRYmaC0b
 YQDUrtScq0e8dJwnlIV8vyMQ/7Si9+nUWoBdxTnek7q42dg7QkwWuYAXlKaT8UCP9xjs0XclO
 zdhn9qFZraLWxw4AIUqTnal3mnICC6MiT/+dwrudBKW+dwdmdMwkZNDH8k5BY9/3X0CX+HNqQ
 FGBPD+VaPMk5M5pM3DY6qLLDz/q12GzVJZ8J2gpax7+PbRwQssc9UA5LxNZJJWa/x5HcMeaq6
 m7C7CUkX4VfSSNE+6hsbkVKsSpGsgqO/ZUVCDH4Pd3ZIjzMhIIXR6gNUQGTyRw5gU3I0Zofs1
 NWcKkHgcnliWOq42FM3EVwHC0d2Fo6E9HkBb8LxMnbvOLiBWj/jQInlU/puPmWyFXsdiTle2j
 snTh9nSR0m7Oqwi3N/BhhirAEpFslge73BuU3oKQPhcnR1C/QSbhHh5O2moCNC8M9i4vyGiiZ
 GbzrD+SLz/PTatD36Dky/h/do2At0hkscLWKfZXL+P4h/1xxpYErP1WtdyRixyE53Zp0W/AQb
 I6jUMLCXrQcuv/NYZykC3Qh3pO46Ekq3QbANSi1Ih8ny2edzgZ5Y0JKpUDtGKJ7DyD48eNM8c
 EjKMJBaaccGcBkkf9FCrk1QmBwHZzSyEvfrsdKY7Gb1KrtzV8vlOKdN0lNIAtSb+Qszz2optM
 OSw9Zzvtq7jcQ21qYkYS2wJUAeBowWujjVdV7cvjmF0gfP5vGCq/SBnzbJDg+Kn9299rDcEE0
 PGPHnSoXLDPETEnThPhpVVKTfVyRBfB4ZTrns8xBHgPrKeC2i54k0/5hEbj1jwGnVIVwjYOjv
 puc5USkhVl50B7jA+9Zdx1s9weqP79crrKspvJcJGzMoL6qQDwfECk3ZKJ/Zq7EOHjmT+Upl7
 14Z0mdx6K/4PUAMtcmooRXmOaETh4QGFlfz/zW4qW7AsuwGKiF/tugWMJZkR/T7JtOIbqkPBB
 9o2V7udxGc/EvouOrZdXruV6wgOyGGAxPMlz89T/i+xQTAkWYusFaFbxysLsrMQQPAUJpqWmw
 YXk7uwE4wvJm+994+Rke5FLZoM1Y9Mg5lGFxhgG2i30jpSHf15xgAXEDr2gihD4VJTgDXS2Na
 YIH1WIaR9i/ZEyU5DXvqLLQrHVWIhin5tBUkwd3Qs2Gyjv+0URynZiLResmcZPqh4cY9WCjT/
 uE3ur/kI0q4T3++FjZK9ibRzrwjvFhPiblsn1HGrSTgLouHjuaC4k5uqZL49gWkGE0PC4N2V0
 XT72Zt3Wjd9oDaYiEdCnN9PXoODnIwjArwCNMV40JKbSGBSebUb2P1Ss8rc1PgWAwx8WSmaLN
 xwqN2RTEesWBv9K1I5vB49h3iVD/drdLelP7oiM4FuhTU6aPX9TFTZQ4oeVMYhF7jqH2Rgx/I
 58458NeOy1j/OMFdWm2LICapB5nOAocHuW+qMlFL6qUGbNjCGRI6fmz4UJtQMIfkwGbNzby9u
 sKGJ6PP8ZgvjUEBOwvx6yYaJE+1nkcgv8QRU6YWTHtRlrvz31yehsPBtHjkH6kWY0u/A8CSbc
 Dy5i2aD1BQaTQ9iC2p2J1elh7ZuIIPzLFmlJBDDWikm0ekZkjiT1SjMk5B8TWGORkulp3W7aD
 MasCm0XA9Ys7rMIu+cyo+biyZQbPWRPfd8rzL8PzrrF3opHpO+Hvjl8dmFqc6oHp3wwPKri1T
 oZ1s/6Q9vpv4W7vZhWERHaSgUubEvfH222dyyViw5igo0QlhZJV+VlG1bonF9F9k+wZ09Qv3Q
 E42mQmfnm3XAauMV0WeeLKHc6oMbkFrLKVRpT2xAXfQCwqIuS/jQt/BwjyN86nAAMRdf2bkp4
 wk46AehoJG1cr/zoOZXavC1wllr40lxHyS/bp39FXv+giAMCmwfz00IXhyYieb9/hJ6PxKwfC
 rm+/jdYdINfV9Q92wDSmsQmBT4+2iylnEbQqceXJqPxOR5b3FoOCOlq6p/O8Vm+9Hq8taYP/I
 zU+HMNoOhVkq23auTq5jg1B2JK3j51G/w9zbyMpW/rj1o62h+w3QwcS5ZHogK/EgjnBvW0FBr
 qIjeha5lCk/8ZB0J7t1AeMkcpSo70R1fOmOe1iPb6xXdJ3DTm2SIsQGaFfzg6+IklYW/dwZLi
 Jfw7uSYOi8UHAKaNqdbHTIxZhgScw1L8vyq4feUstGVrmqwXn9MR/2C/iX7iP9GTlN4Ocfc6d
 Z6lSB8aexIJYfklEKem8sAiA68/BCoJrhhNmiuEHLhjDX4MejOp/VL+7G0aILYQTXJMf2Gc3p
 5PpYkKV8C2+hQGkQiEeZ8VAkKFA0ppyjR7/3NQdMeWdt1DGBvg4RABjtxfX5vlylaz0/T501O
 6FIHc9CNfL1zK5B18E+hqE6Ns21X6yhMxJxgHfZRl26kpDP2ld5tC8JdAD3osBaX2rbtyE5lW
 G82Xu1IdHdQm1zlpGdbi3NMOZHcufHLo9nE7g7rO1LX3QeNElo4FyV4jKlOdtUvJp1+X0Hinn
 RGzH0ZNTJEqb22Ks9wO9Hmc7xvp3cw4gU2pt8Z7D6K0NsibvkDUL58jCA69KxvyRJP9foJ1vj
 n0sf8PVS71gHhTMOp/ayy8AZZbdOCFC2L9NSsbwSgePdXqxU5qMQqrfCYHjVt2SLY0lcGLU1S
 LT4eI67gxZI6wcPh3xUipr0LNfI4eE84CVZOJa1EW9fDGwKUDsDAB0exfxjme8kH6rrS4wn+N
 hsHIkAwWiKACf1N1VCwhrXibUtkveg2YEa8PmUyotm0xYX1ZRI/tNQK1vE2x6gqoXEZd38USy
 XwkK7QDg5n5GHaMB5JzicoW5WsA75pwV0hnw1rTLlBj9+Pd812A8H2XiKZIrzm1GJkgAL5ltF
 t5K/FyWlnnVLXJi53auYL7Il1lHcLBxR6DhwnULhjjCVFb2U/z83bJNIHeZdAYu0hVgJOtXhz
 ppcU63G+gfBQMW+lHmLt5eXSPdM3dN87FGvFDEDwkrGd6Eg1IWkCIhIwSM4MKwEByuKlBBkvj
 9Ghj9dJeDa0zIXOaY8G9MgnxslKEAoxGrPsWR5nsvvEtBIHDeofXamHUfWvdV57ZffgCq3ET0
 T0yFi4Vhn8l98HQ86KhY15Q0srhL4gtiYgsXn06RrSYomKvlU4PJF1cKQnlWCxfqbmuy4nzws
 4iA/qcqYsTYOfXtviqcqxEXKrIFjqbnbkAzMlzMgYKAwfCwWZ67/wXUvuBmxb55frXSlvWOtH
 TI9/GafatwQaREc1rjpERsUwDUJthYBDTL+uQryZvevDKpwatgJoFk15e5ZFPF4lTGh7uA==
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

On 6/6/26 22:27, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>=20
> Use the result of strscpy() for the overflow check.
>=20
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Hi David,

I've applied your 5 patches to the fbdev git tree.

Thanks!
Helge
