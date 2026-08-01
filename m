Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D20C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 20:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52B810E023;
	Sat,  1 Aug 2026 20:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="rPS8vXVQ";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8BE10E023
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785617052; x=1786221852; i=deller@gmx.de;
 bh=NvrhWkw1lcE6D+/2NuFSPm+YZdUC3tVSowLVpSRgUss=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rPS8vXVQDHt/GEUJ2tEhUy+ZWUQgpo3vcLWMAOH+jEE3dso1wFxiP5was5xtArpV
 yY6yJYim19r15usewgTPDzbCOB0aAUqWT4wy0580ZquPKwAfzQZOP7beNEJsIPoj3
 ktUJrwFYtck4M3EtlZqFv56kOfcbBRpla4sr+iIgi1RZdduwj8bUyDlP4MyPfV/yx
 BhD00SRvV9f7+JJEHFPt+9Q8ZqfArqFA97wWhprAJJXcI8nM+sFmnAAiNPyza0puw
 Wts3ptNzlZQEbLrx5M2qPC5aRtRrFKSOPYM8Cg7cmJPlfXKtU4zz7DC+vyTunzlVX
 BLIwDFygHjQepKSW8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1wMo1R1eBh-00MBXH; Sat, 01
 Aug 2026 22:44:12 +0200
Message-ID: <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
Date: Sat, 1 Aug 2026 22:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Max Pedraza <maximpedraza@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Max Pedraza <maximpedraza@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <am2mvECnCcO9IxuI@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DZgpxvYNCqmBhloe22Jtfzvg7uV9+JQ0y6/5Xj/iFXayJ+7V04W
 YSpwyMEZBf95gI6nXT96FhEnqbY0eQio0AuNWmBO66mKB4bAH+fsee4fiY4HuUAZZYQPlyZ
 EatG7Mx7QTMxBrHxVmjq33flVb6Qw00xJk2DWmL14z4LnPvbu11VHk4HLjzDS5JJIcOJ5SP
 aXmsswjCtkQNHF3e3CAKQ==
UI-OutboundReport: notjunk:1;M01:P0:NdZ019In8xs=;V7P0oM4psMoKPYxVifBP/Zp6InG
 1SMn1XoY56iQ+kGP4ilyhthUnMV9EgNmMnDKoCI+fWx45LpJU+tOwQqNU0uR1YuNCMkh/4uQA
 iyJr2kts2ghf+qODpE6SP4ID5u5YyGZ9behQ3y4fv96rrS2IHNwK5P9T/XlTVLHqWAEVuhDZP
 dZbqcyvL5DrqPIhsOn8mjhVjpyop+U4o5qQf60cskcdYYYWTdffSihEFHWPWQsAQ/4nVsZ0gH
 xPIV27AU7q0xr+8nZ7wPgK3qQ+WJs9H/4JCRZTQW5uw35r5dKaNU06QyyNUvplxrPI7b4iRke
 YV+skNxb4yKO1bRylNRzAQvGaNN+IBv1yooXFtz9kvWJ2glAPi+/EkIxJYtrkPjSpstYyQM7G
 2CwHgf9r/e/wpB8uXWgAK7DKcrbF+XOLbR4gLR4qAyR6OZ6eTfRJWWrdbwrnfmb0rD8ago4oy
 d4yVUegbAV4b9EeAJnGjzrr3evWlG0rPJqCZgDHFQU/Ai84QMxd497ywz0OnP33wZ1iYIZPSZ
 BvUjqkrqnYiHCgUs2sUgJAWLpVIVN1xGfrADfIgayR1LckMhy8jIcAdpxg2TVZA5ju10vyQgs
 pEA8RK0tnDvwJCsmtODvA9WDYNwSMwzTkWuAFX6yglMwj9Eb0Mf/5SsDHnOK82+EcoGPU5QL/
 dp4X1MPY3DHwN+K9+jQSik8eVS1SGKw6REKpAzTTCkQ2vmFrqR+KTnzpTOg4h4/XrbEwM8Weh
 5tGyffCsPcg1t2Av1RLtJlOzcLUnrEzEfMkicOzczHoXVdHqXENxzwnGPWnM+WcQszRsTfccA
 /4cd7Nww5Pb7eLz2VihcvZDnEn8Ipgchjxyguu64M78bjm6HVmmyPK70+BY1Gkd5WqlZ2lGTG
 TxQcO41djgA6erBAPu369HxTSWRxbzcD7vU8Kjrg3uzi6umBoUjDf+RmkAS93wN/EwdNiclZ1
 IkFYRyX/Ov7IupUYuKkcez1e5FgamTacdrJDPHB+KrKI8mkpwem9Eybsan6FeBNEKTC4dCOOa
 SVvQgl4YvNg6jdyyvxa902e/mb1AHB1HmQ/Jyu6T0LfxUaV6kaPfWCqUKE9N0gQvLVTzi0FI5
 UlG3iSlAfyyww/NWaDkaB02HUT2KUTdENtGudYIVBNhtS7ck1/76M2uRRTH75Uumj+EYzF7vV
 7UbI19HDmiTus7Wgpzui83yxiMWFZfJG00VCtEAUTrWTa+gNpEeaMHk3NU//MfhKYd637mx4k
 RK4bSkkhTKFphyk3UL2cJxQw7My/m2n7xlCnpjl5cCK1e+FyuxZR+v82GSnJ4e1mFWEr0DjLl
 vcQODzqqdBhllzwG8QpAz4siqFtSB5ciPe1ONWuDNrSOmjK05zXDcXi9AR5tS0WaVQIt52Eb6
 C0K2OGVOkliseZN4YId4z34KVO/g74+ENW13syhE45qCoTdBhuvtR4X47xxxVEUxUYX3wvWQj
 cxjHqW4GSbK8Nt2sgnjepxg857zmmfNWHrtNNPAWFhG1bTNYJ2GwsXkVo7c9nUb7o+ShRuzee
 B0Lhq6fc/oI2HrNcFZP2o9JpNa5ISWL/s25YxoZ/Bv6tq4QGTAKyfc2BN7oo9UDtgXmbz9edQ
 4eI4bACjiSkaWvi5i5gheNuStci3dhKlfUFH6UKi5wg9n2NUYJtNPLso3ZRvEI+NUjr8C8q5X
 /ISVVqXGoca0PGu4tUj4ue1OPWIZWk6PpmKJFSbgdNPpZWdv45D/zXhLRQIx9hsY7BTVwWXGE
 kiXYWIYx24li5kf5TzK9eKXTrVspMjlvX9jxpHbj3NIe5R8w0UTW+czFL+VdjhVHB9k4fCnHd
 WAjvN4llFZ+BjhdWCxwGAGglDGZyEsxedY7NBCY+6MCzrziH4lVXwSQ5YxbHY2e9FN7/xREeu
 LzP0RiJaXw+1TSUgPPb2Gau2EQMrFbpo3FrhyEpgENSE5UWBxB0lAYdQ4k9watwzuAgeOZz1c
 ZL05baimAE9rhV1D4iyUtRiKV0zP76NHzEv5jY9ykXtPXxOjzTQ3KXi+A6I38l0BRT6rJ0wNB
 C4vFj6MaiuiS5SkUQv8a3VdmYSJyfa58BrRwRB0RfatNodgte5evnhUGeLkq7ZbKw7uyO7cFd
 sZnyyw/+btrx2q/hB5yuLoTFoYdhvPowkbQkhYz3yH+RyL0pqPhtKi53d/ILtw2t56wTOuMKW
 9qmnj2AZOJ5uOpLdepKpX2JN10LcjlL5koJpQZxBwaEvQtwZ6yWqp8+sAFls61OS/k/7+MNfI
 UoVYfSgN85AbDwovotKbXmpN5k02K3l8m8MjEE/ncausGnsDZUCTOPr960IbiU3jut97Wh57m
 iyCXVOMzsv7tQyrlIbEpTjomUEEAN5SHuhemZEiqSMIuLdvUFla3UpyM9uNjzl0yvCxSH1p+P
 p71+Z5a7CA7fwFW8SXEspnl1/qSekiEqyEbNmXV6emoVLh0r7WjkGENhDf9XLIRMvsISon0+1
 EQQq1GLZHIL+klPONtngzcfLkrj2gZ+dpj2dcfvicNNuG7NUv0/9+SSr7SLqU6o+RdehD9YY6
 5qUQWah2VP+KXo2APZNZsZrxcdl6RZnbkqAvl0oevwykHXJmKznIh3VzXwTvfgz5pCSVNPt1r
 e14411h75oksB/La1BTDK9RGbSpegisH1Bld+99QSrrIFzCITXxeAdm+Bei3TpeW0+qYk0kQv
 TybBheEDu6Qg5mYJ1aQuGvuz1hw2YrdWKxToMHwMvPj4TUpL4x/sM7D0MQqL36ZDQ1aM8cw8P
 E49OvtNEEKQz7TfUXpSquff50zBRSRN8DekUIJaBF8st4YAZM1aPqDdSpSQXPVfrC5WDxmkFI
 J7ySATZIPOBtuRoiL6BXVMYZksNG6t1vYtvRW02NWshOZQCJaoVBY6963BuQVfLwb8J8LQK9C
 0qVnaTcTX+Vb2RB1UAuxPg+rWqL7IEQRRuDjpA6COFXZsI0Iz7qbIUNOcAQzwO7JnZTgggobJ
 qb6UHt3mx7ccQVP4hTBGU3tq+Q9GVxuGk76PCZb4OSHZPs2BfOgJwsyxTHPovUfpQfopXnMdt
 Ir464SijU6XWe3rWjJZGCL/X7SjSRS617jLagMvx16oA84HFsdz+Tsg/X4N8Q81dmzV/n0I5z
 YFEWpUkQsXlw3Rh2dJQOWShXEtYybJj6WCv74xSB7lRR6ZN0WfmoN4i2rr+qm00+TuFltkgae
 KpUfbwFidd8qzl7P2chRrG9tDsVJlPFyntEmqfrZvX6F5rlhGvcrmkKSGPOnKNewJCWOhTVo9
 rDjyI2BaCVOu5GWQ9VpJonk5v/ODkNPqBLA+SxDxEvpI9e7i6Pp5djepWsSqDS2T/SgpWZSAf
 qttHzxZVQS0Mt8sDSuiMuPoqO/siJsaMiTiXzHaWJj/q0lfnD2HVmteCzCfJ2OB/hMwms2th0
 oCRk4cwt9jq+aq/odbMDDV4hTVZOhTHzBkUw7IBOiJkK2lSMXRj/JByKLDKuOAEJNIHanRuIT
 GQN7F75C/loSuLUAkvX+mkY0IzKJJxGPS9EjXHuuQMDABUSaqkqJqwEt0NNeEAd/Bb8OgJ/6a
 ST8/nFONe6fh5aUQIAXIfR7D5oKt/7fsTEriK1U10KXVnXy4HDf3XbF4yKEKu9AdnkqDTNelf
 7NVX/H+Q9quMtCksFM9xQ2HiycID/FM6uXbXq3H882q32/+11HaVFcQob80N/QFPN5H8EOTqJ
 f6opuH2NmJ710p/TudbPklveG8kajRcrl22EdJJ8ElcQ82Dn3vDxq2aEQOKxbjB0aL9lvPMee
 x8yv0OO1EwBv0Z5BZ3F9ZR3qsgsmAnnHLnTzvlpeUNMfsgJnbGGttjPX0bwA6u4Okrmfv6WTV
 ImN4984foXrHIPw8YYcOHzXDkKBtAtUiwpSkENyOj4ScsXBF4JMULUJf61ttm9YaDLpApd6Hq
 A2vL5bgpyZCbLxpQ7TE26UKwRCnou3+eTpNYj/TS/8TUqp7cSYYY+9SKrAVc1xwgvrWu464oE
 ewu+Pfvo4MVtkTrr249lUkbrfNxDXL4VAe/zoECOxBjSGaAhQQK2WXgp4kQ0a7hIbN3MUgJfB
 2LaK1uDPDUp0sr+UhHlAhwMbgXCmG9C2GMmBG7AYX75EbMP1fZfn0bRYr2J6EhlLRj91Q/TYR
 ryzUqcUQcO2zhNDp0/x49pwk/Mj94QR91iBUZFh0dklnv7daBQ8Tc5JBHR9JmFEOlz/TBHvwD
 cZq7AlGSnCKk3AFusT6Xguykg8eTsXO6+ltRag4gjB2bMtz8o3CklW/Z3VLbviTGOysklEbro
 ZxOtuOYBF8SODkODdjVU5Tw4d2pju9jWcsphD12deRsgAy7xvULbqY6WpNJjInlwB+H73bxh7
 H5SaeHTpMywV58xrYCQsDGcCIk57qdWn0H/lFmLj2LfN21iDeP8EVlTT5qaF66Fc2hcyGS3Hw
 LQGMnOFyd2qnwPUoaCrCdHWfu038g7P2K2lgrpmjFjwdLgHx93WaaWQbMkgXcLVFQYm/YcSvz
 Y3IfNBF2PWS5UgUzY+RznWl3UrtIiq/qxmvl88kewTZoNKK/uwR2cUmpzPWn+n8SUwPAoOOfF
 9FPeigUtXtRq62vJ7TojqOAQjU4/3eCjkTajSlW0TOVbtW7vNp4bwgu8qcec40RVvEcFl5d3g
 /vABxXXB/KlXJJU2/7Wjk+v1V+4pIdNlWc4vymEl4GSYiNw/Uvr7UC7jFHvQgzZFjGPtYPV2k
 hwf6xEjpL9tH+TtuNSQPeRp5n72EnZCsZwSydC8oQ01bl5O+8Yt93D10Z6+KRiwgJB0ERknpP
 tqivpoZYq6+JqdrhLWfOzF6ENbBHuUfE+BwlpuYmAcFC0ElHHBkUCIQrJ91LzgFhSfJmoOstw
 EQOMIMAhBNPtUI7h4OOqz94Ptxiz349M1+C6tyFXlWtvxpAtxzvv1hI2aLRo87SXdgMpM8L0W
 5z0sQRqHsHiaLBonEIWreFzhO28AtbsWQtKdT3TmyVNtYNYLG5MHbIMNyRS1gPpBE3NyateSF
 YAMgKH4FhJDtJDTCrdmRpxfUCCD/7ppQ3qDlnwNZsZyESikYJqwD1+WRuNNfXxZksUw/OkAK9
 FBem2Bt8fpbL8rcVrg4WDaWOdFxEH+IRhWIgdwGeITLe8zrwSQ3VRD8Gdts44Y4F1El2GR+ih
 sV/VTqeXFZJ8KTkZ2HdaueLSLfYDyi6gwKqr/k3/7+xCnIYIVyXbFUWyagHd/Dc7Wmu37bBbI
 PHCQYrYnCd2kzQvwqgK7affRsVP6T8Ht/WVK9I5AvcXOFUBy42DpnNDE8vZrit4AS538pv/qR
 j3/L7H5VM+D+7dOuvTg8db+drm50947CFSg9rD72pxooXpLixoik3L0CvbY2h53qc9WkrYl3m
 f3GNBspPBs2O6TWqb2lAwqDsnSXqaRs/Uo0T23iC8X5zAwOmi/RzIHRg/t+w6bAQXF1zSreO0
 v1rlhUjWBEUME3ApoATWIUqyw5EwFsk8iGvMq5L9ITQWDb3dkoS39X4mbg21sJkz1N6RZ1mbz
 lg+90/b/84DlIapK2qkZW4BJN4mN8kb8FM899Kx36EE4OJ8AzY1LBbbKdJeHgDa+3ERLkuaFC
 /nkGJuOepib+lvBWzyNgodjg3wb1VLheag9K6hviMz7hf0IGGnHf+ywIGbGev8Fh8pjF5BM2i
 ygWA34vxzgtVYf+VuO0A/8qgcD7hwO6D/UoeVX9aQ1aUjd264Niq6hADOZw+5rIyLzqcaNzO5
 g1ArlT4h4jBhzx7OeYNlxKK6U5yg/J+FzQ07puog1SXd4+dictP/rjxeW1nULYal2tz8e/ION
 paxhYKsnnvlZ6+J+yZlzUdcAFTi5Vri49NvMXQKvheDWOtLDccEdM+M/MfUmuQHpjSjId7Q3t
 0KfkRxG+xQaN70lXRL8iyn1jBBx8f2oYmSYOQzEvDNneGSi2CtZSo4oS9TvHC1nOwOnUGMt0Q
 tC6PTbWVyAj7Zpl7kFqRuI8SFaMYLNj3gotlyENQuKeOoiF/8JTa4JH1jrVpzAOLKUmCrngu3
 uKyADYU5zJ6mmhqiXxvtnohGZolqWiaWuGNmI=
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

Hello Max,

On 8/1/26 10:08, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Jul 31, 2026 at 11:50:37PM +0200, Max Pedraza wrote:
>> Embedded products routinely need their own boot logo. Today the only wa=
y to
>> get one is to replace one of the logo_*_clut224.ppm files in the kernel
>> source tree, which bakes the image into the kernel image. Two products =
that
>> share a board support package but differ in branding therefore need two
>> kernel builds, and rebranding an existing product means rebuilding and
>> requalifying a kernel for what is purely a cosmetic change.
>>
>> This series lets the logo be described by the device tree instead: a no=
de
>> compatible with "linux,boot-logo-clut224" supplies the image in the sam=
e
>> paletted format the built-in CLUT224 logos already use, and the kernel
>> prefers it over the built-in ones when it is present and enabled. If th=
e
>> node is absent or disabled, nothing changes.
>>
>> The image can come from the node itself (patches 1-2) or from a reserve=
d
>> memory region the bootloader filled in (patches 4-5), because the image=
 and
>> its placement are independent axes of variation. One board sold to seve=
ral
>> customers wants several device trees differing in the logo. One custome=
r
>> with several products built on that board, with different panels, wants=
 the
>> same logo placed differently on each: there the image belongs in a shar=
ed
>> binary and only the placement belongs in the device tree. Patch 3 adds =
that
>> placement.
>>
>> We have been carrying a cruder version of this downstream on an AM335x
>> product since 2020, across a handful of board revisions, and it has rem=
oved
>> a real maintenance burden for us. This is an attempt to find out whethe=
r
>> something along these lines is wanted upstream, and if so in what shape=
 --
>> hence RFC.
>>
>> I am aware of the contentious part: a bitmap is not hardware, and the d=
evice
>> tree is not an obvious place to put one. The argument for it is that th=
e
>> logo identifies the board in the same way the model property does, it i=
s
>> available before any filesystem is mounted, and it is per board rather =
than
>> per kernel. The argument against is presumably that this is policy and
>> belongs in userspace or in the bootloader. I would rather hear that
>> explicitly than keep the patch downstream on a guess, and if the concep=
t is
>> rejected I would still like to know whether a smaller subset -- say the
>> placement properties driven from the fbcon command line, without any im=
age
>> in the device tree -- would be worth submitting separately.
>=20
> My 0.02=E2=82=AC: Usually you want to use the display using drm and not =
fb once
> the machine is fully booted. If you're using fb during boot to display a
> logo, it's hardly possible to switch to drm later in the boot process
> without flicker.
>=20
> So my recommendation for your usecase is to not use the kernel boot logo
> stuff, but something like https://github.com/pengutronix/platsch.  Then
> all the configuration is in userspace and modifyable using kernel
> parameters. Or you create your own application using libplatsch that
> selects the image based on the actual product derived from the dt
> compatible or some EEPROM's content.
Max, is this a viable option for your usecase?

Helge
