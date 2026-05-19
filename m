Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54D6CD4F5E
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353C210EAE7;
	Tue, 19 May 2026 07:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="e3teWUX0";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE06610EAE7
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779176415; x=1779781215; i=deller@gmx.de;
 bh=XwaYJDWi4BG5VUcIRADrpsd9ChC6XaM1IrdVf7DiJhI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e3teWUX0EwppbKRdMr2i7MAZ1EY/+MaMjIy6C83hHNuT+LwzuBKn3kdM8ElMO6Y5
 ad+Fl6OIM6RjJzkzl5/L1T8Qj+ZjqHnWQOBsPMuVVdGcUhzBWb0VqnlXfj+mmkeG6
 yeG1ANrnhk2AzXGGkkzPc1UNdZbj0zltMe0Iw2T3+MxfT48O4VWME/HF3NbcLuUeq
 O7qVaIn4ycWbGWCD1cxbOgVkR5o/QqQQ7oGsNsfsMfZD4vQz769VC4Nmdyg3DwOqO
 T0PUkqaZWHyReuhQyBYRmQf86qzOtZwNd1+xLLxpQT4KSXfl5rl91vprIEjlqp9Fc
 SLeIsjPfCbgOM/m2Pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1xQimH0aII-00rIw8; Tue, 19
 May 2026 09:40:15 +0200
Message-ID: <2ca734dc-5318-4aa2-8436-217dcdd8cc61@gmx.de>
Date: Tue, 19 May 2026 09:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: sunxvr2500: replace printk with device-aware
 logging functions
To: =?UTF-8?Q?Rahman_Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2m2S37fXv1KJ81PqJ/r9vmfw2amqJBtY6feFFTmVru2ufhmkmtR
 lq7kkFh4j5hrmJeveDZCAO6Fow8moLu2X8K3O4J1vkTW7B7aHPyX1yuMznmUpVLMaky1plS
 lq4OCAuI+QjP/l5oCtCzXDDskG3ZSQ7oC89HgadmmIoATQSwqgKhtulKi6NFyqlEHWTnHPp
 QoZI8j0vdonUMJ/jBzh4A==
UI-OutboundReport: notjunk:1;M01:P0:AejRG/svq80=;juZ22k9siFBa7fjCyDXOQiAD/8A
 AwrSPm43V3UJAkV8xNXc/ndadEoLCfvBdLONT9Wj6BArtPY5LtSQiGZ3BtilQlKfuyUSGBV3M
 wYcwnU6fE75Df0qlm4+7c1JQ4mmJOWlFGafDxXtmMeb2lBA9/Fg2Gm/J7SEnO9lpY/3CIaOlA
 9mmAfWDW2sBXRuanyMwcDFQ5MSAeQLZKec7MY/e4DnqHRsVpHkl9WxGfkkkNcklY5AoIH7Gyz
 3/fxoQ3gnZB5luA5u2blSV1NVSin+qShAsR47A/s5xXxZfcZVuq0O5a2Vzl1s0fJpPHx6mhOK
 gZ8x1ZixhKvXd2ARs3JzYDEgTaMT+lqjYRzGEYxsIUIpiMoorsxjKCDGs3y9j8ICH0crJ1ZOn
 jedm2LkBQDqtFIV++WVt73M154EIfPs5lx2hfc/iesItY5KKbTjCAKmTyq6j8JeoYaRLnVU+J
 z6Yd3aLkAD3/NGGyFz7wcFEaF98jQy+JftrNaowzR5VmxkA8jnaxdJXRxOuC2mWUVRYobzpjx
 Kc6baO5QkkRhbNB4FSnoHhAnJxmN/Zohy7a4Z1PObiu8SLiV6jwnQvCexqK0ZiqdNhW0Iy/5p
 HtYJ4egdO4sMpghghp5X0xv39IBn8bHS8iT3fIOj8V9apahily19Z13Al2gzWcu08pdjOXRDe
 IW4je+XehJEXmv0GtgJesVa0hoNMgTVpWsJCVLhWSCOMZI8ERzdBVuKpxaWjvNzkE0l/hClYI
 YQOy9Wpg5sqDM+h/zWDt1OPy4dEDKedKFhtMeVe3R3ki4qeYh7e4OgVxjIQhCxtVLmMhk0mvs
 hOoa1ME3HIpjK9fCdDehOxkr/rjlfbJQZU2SKqBgcTcBSKiOSjxj6hgAac/QA7Dg+qglcBnPs
 zB7mpe20tAgK6u8brCo8xvdsrLYm8zMnC7B4jdJaV6KbQ4h2wMipLE0r7N8YDkz8tSJoVsEse
 hCl+m5A2JedhdUirMA82IYVPolvtooZS48aVnHr1Dbv/nVT1qqrmocdr5FR9Fhs0l4JrkohUh
 lvektcRynccXalodMWFNXc0AsmAaPwIDyJsmuc83XLZdJp40cbWJi0zNAHO9mtEAIZk0p7LEs
 pnw7trYKh/EpGO52seEDA30My89OfBDZzqOfEGm1rK/9OtwRT1ErmiGzoFkhf37Q+3lmwuz9W
 EbdxEKZQtAWCzk13ZFCK4Gd2U9wNtb3p1ITdvwRsZZi/hi8ju+Bu4oeYBlZnpphZKdAMg3HlC
 dze2B0c3KZqUKEnITnNjWQsl94oNYtS9nKx1ir5ulJ7+RLbUcK5VSvHkeq5Bh1lKSlfrEZVl2
 zKMpLWaAYvW/0CLuWrSEe+UBUxqsATU5e5cgg7RVSLKUR+zrTyeQdC/7xj7ecv3w2ZHLKzbYS
 jTY1lJ448w+f75aCn5zQ00CAYmFrSHG+VBngje70p4NaVHuypXC8sDxE2El83QyC41X2jjN+P
 i1uSxhe0lnvzTjIeQHyw5zIWCQGHOBRYv83fS9JkVm4fTJaxyK8ZwwETvMX7u9LwTS4LytvAF
 NbDfrxck+GZ5xH85+9rLUNl64aJc20kLXjJsV5pCmsr1buHU7+r4GBey3fFwGUFqD3ncwXD7B
 DikJgCmWkHZi39usNa7Hw28NOpgM9CZDQ0nwlfb7NOHUTPpAdghk/L7yoQei7QMRLOcgIC24i
 N2GW4UY48QjjgwyJoC3cL42ZHeXJqui+kBgOzBNJ96rWWFdYG+Q8vIUynRGrVgf7XGud+04pm
 aHVVOli634jGZi1IRqErRPF10UJAY+K8+FQIpzLF8+m63we8oQDNfefMd8SotICbiMJ8zC2Or
 Nnl7OFA8hMPqR33SG+o/WkT2hrqPHftqlKFdPgwh1lAyYvhColKMoxlOyGXjlzTm4g5ry6DHd
 qoiOSVJ4X2DnM/Q7Je9miwqZ7Pglhz6koxZvwte9Nt2tzc9yGsfXeHrFzIfPwRKsbsXsBjOhl
 Nsmt6OGUE/U2CNZ9RFVwHPwCQffayWx1k8Su7xJJepd6ipF+nj7zbo58FxCV3W2Fb4LtRF1YZ
 WGWTjz2nc2xO0PGeD35Xky0NhmRGNNHjroDCuVC2F9Igqfaakvzocc12zt6wGNo8nSWGJobgL
 lOQ9FS6XuwU9qgs+YFyXiPgUM2yYPbUWlzSpJuAYKhmb6x/dEwBZ971xr+8RcWRxTwjaXzsqc
 D1PDKWeyRCZAANrpDIKmtD6oNoH3VXD+XVesMujVx0WwgWvN+0zOd+TCn0nciR/ohEdT9U3yf
 7lVOLjFCpIiuWTG1QVQyYC5xc8dFD6Cdqzo+hIeOi5WoIPcbjZxPgdUbH4qKVu2liXwyrwIiX
 QgYC/j67jnaRwEGovWUCBthwr38cDlAX2ytC5+YcYvgmS/57AtzgqxXduWIwGxkkx95Tw/+L8
 VzZdscq/5lCR6RCIr1OZLxoz91Ai0z6cCE80J/N4p/5t+8WC6swRPwfCVnkE+1NWrruESpZ+X
 SPAZ/uOGoFU6E7rKXXDgK+Qm6ZNi8w5qf5rHVyG92leRxaRsxa8keW2ZCFdzwjRKTI7hWki7c
 IsxfwJM/bCIIJnrGFXE3+2ZP6WW2o3TtKCYp5JVgovvZQxwvXMxBXqOOyIdwLaONItKDLHPlP
 qx4EDVooFxbMG4rFmJeb8qg2MKYr1VgGU7wQxuox9i6khmbaEZgO0NpL3AZ8gHETBK2v96FuA
 emY96F8hpJ8EtouNGmllp/ZK3DPDFGevkxac6OM8o8DSnWxM2kJdm5muRxCI/6KxGJ1I89tNi
 VMYmetx+yntxVJlhLqRJeVbnGPcQctlKBaRK8bxku1fU5Vv48xq/BBLo89ld/At4GzIQdqe+D
 RiVW3dNALX0ysQJ6xnWhYaH0pNSj3j9oikYRT+prPQVRUNQZDY5wlrV61wPLWlDrwWG3VOFoS
 DuSpItPpC7zIEXQYtpqgQBvnj020vQ4/E+VrmGtjQp4scyAG6hOz1bhi7GeINSGnnqMu3nAcM
 mnIQcW5CC63P6JEEEHV4OH8esZblDHO3IWjiubDERH7dfbrDz0Wf49mhv1GMFI0eU5S0os0Vj
 NwYJAjR+PFGVsKhLUcvjlHt0te5OCQP1K0O1GwRctIce5w9x10OQD4ADbHTMagtgkp6hBU27o
 Mcu//MNk1cxJ/aRKKFr0XtUY3pQ0bip2MDp8Z6ilesog9g3bQxd/RQ9ytZg6oqjHWcEVgr+sW
 nxKR/wLcZEA6igMQueoRr2Z0cb3LKa84IEjgUNd1e3ZOaWT0zQny7TQCUJ+6yRQiWHql8wheS
 6VrgOTHkme4/hjlG2uZMR79bOwfdsJ71ERqpLzC2z+pspalUUKvNdJajBU+7Hip80KkPSibbb
 oC1H0PNO9wVxgGipPLOfkMRmCOAYV7TIHuBQZoSLnlu6M6I0NQFx5mN/4xNnJz5ZQfIKXMYUx
 UQMRDuIQwYabWPLXYS36rObYI2hKKD6xsSIlkCVy9lC0+qwrKqdgqjxrbBmt9jBqMWBT3WgVE
 yKQxSWGi0U/ibPAx5Je6WBDmtf/mt4Z6yChTcM1Z2+nyHeCeHZFMoeEePf6Vi4apnxNZ14CIV
 8aPSAMaHhlJ7YOAaSLJX1h0bgeTJa2OdMsL0HyDcoFCuAYbcGJeNWPJ4cOItb3PaJuiGJlBix
 ivtdl1THNminESPCrQTofhPSl4DfCOQQrE4Xiny/QtPoG0xGhN5oUIOlTtH/KXvoAOAkz0S7/
 +xwWeKRBRTuqL1PIhAVl57AoLvDhYsJlpXw6Zi5nTAMe8l/CvQ6ioXwGeZ1ZmZaJ3Ae+ihigM
 k0jEudb0hARXK50i7ejDQFGz4wmRPt/ESYxGgniV0a8pHTxtInzMY1WBVfScd0b+M6606BaWg
 Tnj7GoeVF1tFtO3p8NGv0P2W3wRZS3DKTS2KI4xyP39xoVcJeTPM9OKOrseeFM2X9TcGCQpo+
 Uubcq74j+J82lQngnXQ4mjnZfAC8zTfknV9gqNg/UmmPzeXBLL7Ij6eiJpdIUkCnx60yphOC1
 AbJa/H88OtY48cgBsNAceTQo6wATR8fiZEwQAd15p0mNnXZX+JGKIjIW2DSTpvPwQ7PiXQKle
 dthKn8Qr8XbMySgzaG86yoBvi+3G1tUPkPVGNYRILw8KHmtooIl8H4npW6DtA2v+TZAFo1Jo6
 52+xXf6SIxZ+Cht3fnmb0Xb9NFi3kEkSgH8g4JNRFa7Ni5REnOQqMCNNoLoMgoOBevE2HDVgk
 N9vtoGIaWZCOuGNl6ryblhn/NI16fzFLPAPFrebo0dD9zg0aXFfSv4wp0PvwgI+DeRTYKa7MW
 or4BOoMVhYIoww+3fALuomB10bR3cr98HrUNKN7P2Vit4Swdn1axBOvlRifzjd3h1ppJOpONw
 v5x3MXT74+Nh2484pfI29reK5Fc1wQ2sydNNADSSHnmpS2vwJKuIHOGWvkN8RmKYcqWbV91df
 +HUyEP0W8AJdzZchrZcKwuK5CvFEC5hmRANw0yH2BrHQy/isoHvkGHGfO5Xb5uUX+0dsSm9vR
 f77VOVfR4k0bXseXwKxxvH/GHAHvY6rxt1g9f5gzJq7teCluCio9HJcG8J+8/1UoXyXlsOXao
 mE39n1KE62ZVUJ2pT77+etiJqaOcOA2SvniTYKCYoLryzOYGoufk0PZXC1ZwFVbcfgTXBTlcM
 80dhICLFtV7/QmAoo8XXNyTjkVkkDFFyTEQDz7Yxif3CljfPWzqfVIbvdBYNA+nK7/l7x7IKr
 ggcBoXylNMoXoq1kEm4vDXEO6SJR68IZM7jXhdcD0+B9C8fGxc8/0rOJeDqll7tcgOkRWbM5R
 xhyZrpJzP/cKrBbvFz+Rq6dbTSJ6NinemkieiuUz9417lchtw00GSNCcEFI/Ci0VThpyxlDi7
 ytnhPxXmvHamDT1P83SV7XXfPqjrxZW3GwrzxScgTZadi/L2yxPr/Lkc1UzJoqQgmHDfPIfj3
 rma/2XHjPW5iioCZSWdsJRWnD3AuJSKY9N+Yho9yWOVNN4sghnXZ7a0cDs3rBGwV3rMhU/ckW
 Grb/sR2/9/BhDCTEHdR4ggIM9y57f664K61IY+LwWtzou3OyHMOQ5Zl3M16m284lFEMzC12sp
 /9NNNSqEsI5ZtfrHkHJt2ZF+GGdByzakCy6yIr3Hm6NQ02DhTT46JgGu4vuOyTYUljecIefsa
 jVs8I+bgaQmbGh7LXyQ1I7vI9ly0ganpuvzKmED1MrM6u75oVubW5/gH1hMsIlIGFbEAqyQpG
 cpr+G8+gjDD2F++EXJK4aH039zpWelfHu22hWLEpjrRrwPO4Q6tAiN0fh519xBiCQKnj3M35+
 2MWrKSy+VkyFRvW4mKCgGisrUEflqcJ+jzjsy+vNq3/eLlnGbL0bNXCuu3PwoZHsRQ2jc0Bb6
 9tAKLxcxq0y+Zw0u9QrNGhC3GMAlE/6SSyUt/izjA7Ocu5G8w2MGEEhCfdMeJ3WEfjsAUuM39
 y3Bk0SMCpqYCuqHlhDvqZ/MwTWce/8uOPskIxPJDIMohPqteRRLqE5XFpo1HoWEzmOHprqC/2
 QIJn4MBNFrSXH60oNM4eweXHBsWXFQqCHPQreWP0qDfMW/9XAQmvyrUSb1c5p0x6VehVSVOED
 kPdDvA==
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

On 5/9/26 15:57, Rahman Mahmutovi=C4=87 wrote:
> Replace all printk() calls with appropriate device-aware logging
> functions to properly associate log messages with the PCI device.
>=20
> - Use pci_err() for errors where struct pci_dev is available
> - Use pci_info() for info messages where struct pci_dev is available
> - Use dev_err() for errors where only struct fb_info is available
>=20
> Remove redundant 's3d:' prefix and pci_name() calls as device-aware
> functions include device identification automatically.
>=20
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Rahman Mahmutovi=C4=87 <mahmutovicrahman5@gmail.com>
> ---
>   drivers/video/fbdev/sunxvr2500.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)

applied.

Thanks!
Helge
