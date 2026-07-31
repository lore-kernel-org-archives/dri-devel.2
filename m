Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BBFC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F5C10E1F0;
	Fri, 31 Jul 2026 12:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="D0A+KbR4";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC67B10E1F0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785501487; x=1786106287; i=deller@gmx.de;
 bh=txIVdxV2KB3h0yOLvxRgDU/1ugqj+ZA+Un7K/JFghWk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=D0A+KbR4IVRLJOFMFnnz15dpHO43qjPXIpDLQcZrJynKLRq4smRBK2jjDtUzCex3
 zjxPtTwgb7yVB+D9V1MsaEmRSUd2UMCM6g220PQqsNdnd+GM8RbEA3mkyfnKLwf9k
 W/TAmGkdmJWD/EvDKWXRSvr+RcuLxDpswAyNUNtTvUU022Y15+2kqFClMiMHMv9TS
 htumyZ4yBKHIQ9Uot1ywkLeF6lZN7vAv6Sf2qs9GGvwYgNII8eomWFp1Xne4fOWGQ
 aleVuZI05Hd+++Ysu7UMlysfV5sPk6nYwlGlZ7aOXtyBuBcZuLujToeM+XSlmGoRv
 WeUElDDeOIHFJAhZhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1x57Yd30WW-012chR; Fri, 31
 Jul 2026 14:38:07 +0200
Message-ID: <a0fc8269-2516-49ba-8226-aa572d09a29d@gmx.de>
Date: Fri, 31 Jul 2026 14:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Daniel Palmer <daniel@0x0f.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260731121915.3362232-1-daniel@0x0f.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6y7CFWJF9+QwEe+NSxo8FwxGFGX0plXW3Ax1+YhEgbsvIIS70m0
 37IoYQQL4h1oAFqS6NCwYanoHf8NloV6PO5mr11YHokvSLezuRR7nTjZ6WO4O4Tu742v+id
 Fl+XsYpL2QORmge+dxv9QLD0fdJHZw8sJnwFagxHN9g466x1Yhe+E/u6CmD9GTJZGNx0JqJ
 nC7ryVvygYYeRu3NN4y0Q==
UI-OutboundReport: notjunk:1;M01:P0:qKoYbW9TcPU=;d/32VA538mfR/O9pvNmBzzFKi1E
 0kOL3oJw7/g5Z7eFOfSG9bnkeCt+3tOAYcRAb8e7TXrzyeIgG2HCHmalbGo86MEK3qozO2djP
 hFHzsXB/iN1w+m+cCswjXPyxyOSo5KDblXjm2+3InR5saBmOelFjqUAHyXv4zxSznZjBGBxgr
 1FvROvA16cDXKulBodPvE/dAlCdKFAFx2DSwx2YyhuZq+8pr8eFk1N8nUGPMPja/o71QEkJUH
 1ZhW2+VKvkak98RQdpNUOLLA8dFcVVyf14ELxPprZBi25GOP9ydiDrJYwDHEWKfvsaUNajnHs
 Tj0CcPz8ZwfLTndQ58IUt/xgphcN3HOxtHoMhrBv1J3SwpS3roadEETSKJnTWfVSHjDtJwIxA
 UOyGfjefKYtRV370Ze9qkXwzRE0Jave5Vk/dApeaVV9qhurIyvXXup/1I01CkZVP8LDmpqWeE
 8OnyTiC4TMlAaeeN+hQ0f1uH0ptIFRlMsJFSz02iJIG9uLlcMr7OVAVNOLv1NmosqFKR44/gN
 wPkd8jG+gVPJ22MQ4xBRH9q9ggILb71EMyy/vxanoQMLb7Oevv3Z7Rk0XNcDwk7VEUNX5EHhm
 gITouonQ1JkRQdOuWf1LjSmCeM0r88dfeWKhJBtTWs8ZMATgJPhzWcvu4NNOM6aUjRaAraXmh
 aziguPqUYg/NpnXowCpoofb6umFZzH7JMYoWyc+kBSumeyvTEHZR6bZjgT/xSmzGVk9CAldoq
 Qh4ev7NbrQm0KGuOm+0yaIkpgezlKxZ2fLAf2p2Ir+VBGIp6eINmoRXr1uX/eqIc30jPJOmpy
 gGK+G2WSUUacH1pIpArYSnHxmdZW1VAZLXI8HtaOkQuPz5eoB11yJoB/cobuWg8I7qxWYIb+K
 jDlL7QiEyhqsQPiEBa5ORJeefr/4m5OsAq2rHkqotoP5wnZ3qf7KdA0uPZGxcbzxgOe5hBl3y
 VQGB7OtkBQnGRJmV60OFePw1JL/jX2TP6KXynEE31KZPw6prYspzpvryCj+I5tR29LDxhmCKF
 rioMqFwUC3NrvvJx5JtzOpCxTiWveMP1OGwCAH9UZaNUdnjIlOM79hYzZZEOUk5jNZzbIg1Xc
 uzMlaAnOV6/stmA18yTwuRM8XNaPdu5xqXE3VVqFJ9QrgvwHGCpU8tmw8siE6rX4tbqAeEAJ/
 2uqOA8tK6wKiyGe7EV+Wd9SNDxNkm8p2aruJyrNDIMwbMTLchQlKbrkon3nj+Xg8TP5BxT4pG
 Qet/2Q1P9gtxG5dsxThnhrLa59NzG5Dky3DPXq1XXL0p0xi+SKNU0q3jzEVt3q/TXh7hu8H0v
 a0iqgOhxfX5o2b+ZRqCIzIKLxKbCIhIr+idxqM2o5g10g0tSeYlYNQOo5F1/9RTceIkW3D46Y
 skBzq86Ukgt/UZ2zZXTopU3TkaOviqxYwrZPb05dV+TZ3fy0kQCTk61ZlrSzZ3O7396qZpHTx
 awEIM9gBfAYjwb3jxPHsCvjca1Nnn2WtcbK8GPbMIxNaQPNEMqHiLy00dhCUV8I+sH/cO2Bqd
 hP5VTHnAHEhgV5zvEQXpd6tTGNFkhnb3Wu6f082dklBaNh7CaxUAnuK5PHHOKQ/yXxildGrKb
 o/Y1rT5EP+DavrgBQsA8pi06PLte1b6yHmOjV5qDuJcHTrCz4gQuhDyKsBDhYl8/x7pVkGW1c
 f7CjI+7KRbVumAig+AdlxTy9DBUKdgl6pWcDio7MmODwjz4UZo5RFKoN9w5KIGJShElCZRzD/
 HOTRJUHs3h9xgv6w0ImG5V1EUBzgcl9B4JRozfyhrRA/PBDR8+vlkKcmv8bwWBUItTMTNsr0x
 nsA7FkxAL8lD5tL7sCHuzVxfVEtDhQ0koIdOpoqI8Ac1sUUOOpNjdfDUiTaiRXxQamegoCBUS
 be4ajKACUQFOQ0hZPC9AcHRTaiC+2U/BeF8NDXe2O+uSDvQLPeGQgFdkdn/W07dP9mBYAYXk4
 OWCJUzx9oim8cyTUmEfNQgqMfqhQmHAuHo2gsMvKFXk7SwqZMaQ4yZKiqk/lPUZG+97Zqeulm
 NMTMrGPgmPSfkMfQWTTqxOyVVq1ztwt8DUeIE9pjSAE2lZ4IWBjjU2eRXSy6dBIpeAT2hwJtv
 AmVP1xjXdwq/aw+4YtSJNZi+5sa07ISR7yUbmItEP1kMWTaO/IkFMUxgTqRXUtkHjgtmoGz76
 5InPyNo0wskUWDahxIFHAs6t/n8QM70ifGwl+BFrA4/cBJbG4VQhQoGgNdla9iqi2mKAUUB1C
 s//iF5wy9dgYQi58H128xNiCgYPa/Cd3gE0ED2l5w28g7/4Mj5Afe43FSuJzRZTbUc0x+Z9u+
 2fHEoWVwWWvqaJzPl29RjMkyRhnQdFVpURbMUS/YTSij21UUUjtVp3f9ySxNz095chWoNwx9A
 F+Fd9ee5uK4AfmCPn9Uzb5y65ApCyNvdJTgPLhG5iRbdm8Pzq1gT1pXQUBICznof4mp4/XvxU
 Eqn3hJstIS2eKBngw0XWC+EuNhj2lx0yzRFEew0GlVhD0WhaVcYqBQgaCGA+svs/eVbWp4Upa
 Lr28CdWUd35cgMpxiKqlYcvKi41OZQdCHUFLrQ/3YiffznE9QRQ3ckG7HUuyYgFKwIOxhLawc
 PAGeGvEbCWhsngyP+5FbPWMhw3PNDAE9q3mo/9o3KxRHxgwhc6quFveqpO0+erOGrzhb+k2UK
 CgXM/CInxAgrXDugpnUzH2EfeX8eygmBnr21tQQJhPLlI6Aq+ZB96Hu+2XvDmatvxiKCkXMdp
 EueipAPEocoWkiahachFWHmgZOLOYy3TF7QcMZ1n0MwhD7RC/vldW+jU/EqqZSf8JgpeNwn6r
 GpS+ZM1N0RH4n2IF9VIzezB/nK6qHOymCp3tYBJEKaX6cY9ehj6WspdKruvxoc8EAHoIIEzAk
 MfexmtIxSZCwS6Tn8FlCBeUpMxgEOvf636yv5xH9oVqNk1C6+ctQbBF3Zh7VZrjVsJOqdWWX8
 lDxT0QyzCoyynGWvkbeNTlWRNXM7c1AwBc6Ahq7bgqCAgjX8L7edzoILNuCyV2pnyseTbhvjU
 sd0qEmpOqWa7fXU59iFPKMqGVAukKZhhYXIaraKhF2ryb1d+xjK3bRS6r+U5X0fAWmeFoO36c
 Nu2fwMtWZSy3o3r1wLzIYQib0zjy8JO/RYkcp2OsirnEyBtCERrQKQSb2VIJSmiDtf8+hsq2m
 4pkpl6fuYW6nAie6SCR4YA7/f9v/g5em437/m7Mf5OEgrux44SPz8435kFgXtxslC2kkxzx40
 a2MW2y/mO4UiXDMsjylVGnCm1yuWjfLNlyIudifLNXbIPGOejJlKgK3CQkB6m6c8ceVHZs84G
 GsoqzgYFAMvrhTgzvD/mjCQjcSOUVORDtICtN7bSI5sXb57AHZIXgkORlHxUWdthkA5/DxPfx
 /VTwzEwG5XEp+aeY3veSyagyBInHIjTJ2U9Nxdhn7LESiMDL0upox88cLDoGrmXhT8MsOms2f
 +/AK4u7VKptYSYuu764PCcfmPIAtEqj1jw8BTCdm3dBuCefopWXYkWNjJb8/IEXEmGf9qK3kU
 1B7/wukGC7zt02VK8lw0kCcIuc5SdmaRyZBoSceKqEkbNY+wGcwH4O/KdEOUdwDU3oZ1Ttw5R
 r5mA5rBmn07aR1BKSC4s1KV4xJJdbUkw4ToyVFBlCNBoKrykD2RlVX1yNUjOVkNkXoRljAkum
 QB/e0uKZWSsHJdYtwwS2qm+rw7X3Z8/dOngVwem1Z5+FMjVLfHZNn4DDF8gKcJ5NCVLT++3dQ
 cQjPA9gQlfoWWeocKvzz5pj8Ubncbm5vFvNtaj/zQPyw/5Q0y83hvkZy6oXNbHWYeL+Wx7yc3
 hHOqajiwHc6u5a2rwEuXwFqerJOrF7FJ2zADfAa4JHzczkpQTrtT8cBwQKdfUGpaDb1LFn4hG
 yDRo8D6n8+Lzs9b+4S64TpAkRjJxEpGdu5gL6OVLq6tBWbfVOO/FNmcOHRiU8jThk8DOkMxS1
 gFbmqb82Sn+7sC1HntTc3c3vnh96LVHrvAuTZ25k+6J3JXnBo0bQuoG+DSOywkWEVxu8yb87N
 a5Uts5c6s0bWw0MxL9dhuV8sOHZun6GtTsB/0KddGAMpqZqeJhKuSUAAPpYAIgsZlUA+OUqyg
 tFMkoEZkaPP5llXs4yFErVVq9fIFSxL9ySqjPj67eoKZWS6Wii2svd4rXGxV0Ff5jKCnU9XwA
 q0ir0Sg35e1ptZ5EcATc+KVvX7j+VM72ZhhlTy03nQLiIDd2TNjWmjsTaifCc/JszBwnT5SPW
 fgWTduSdsLLlL1lyMABhW1NJmvDdbYb1B8PnGPgUaHtUHOPjZEgpLl9htxNvQja6OginTNUEz
 HwMRUn9hzVoKxe+Adz6FNL+fH7ZECWbho/4HM4N2wKeuyy3PemLEa0kFWgnK8nfPiKBcZ4at8
 puXT1YQ8Xm/qOsusECUzfhLZdV19k72VTqluRjkFus7a3z00tgrwCu6vxi2J7MlU5oDAvyhTd
 zpeRcUhzwMambR+L0e9Drch3+1hIGqSeM1QUcr9qA2qDMd4l8tkuxD+7wq0tO9DHhX0I2Aje5
 oSXdHaHwNSr0Zd5meHwmI9A6I+7r8o8DWnNx/1X3dGk9XfDd4AW3ku5yVQ/+MLlMwO7DO+dcm
 5F7ZH/wQtFeFCMA832nwcyY9BUGZcZVC9AZHqtLU65hSy2Pq7EunClz4Dw/ZH5RnjhyBSYVOk
 5Zx0iRNNZqYBJzNYCx1b133hOzfiqRQ49z6Z9A5qvOBGqkSRts4Hz3/zvzFxqVzi9XORQbFmy
 nS7UUwvDgLN1Hvdc745bswd8FuP0yvC19M8KnnBgmRIrOsE3vTJ6JZJYATOw0RjsInmLH0D/z
 jt9VmWjqLmxUZ4hqweOk7oBIctsdkzsobtKY6MEzAsdRnOoSfZCr5/yrCnRJjn0CebDZ4mL/O
 jxe6xcprHJ/Xrm75HyhukmS6ZOFZyDt8X1oGX804mixEP3HpF+dfefE1sb9m2cWUVt/YtX7YA
 nSaLyhxRO85VminRvNXdKQPXFt+3rks0O1ztpIEeq6ji6JEIKTJXdavbBThl5Rq02TKUfK3LX
 yecGlFLoAx/ea/+UZoad4EOeOReoj55xSR7ODrBx0LOnwfwAO8DMn/6EAXyi+iJcxAEmEGluh
 l0QXSp0PQlTzFh1xdN34eKnbTeGkzn/npPMGWOzhAPdmRdqzBrWooIziM2+EDKzujhwFm+9md
 GGkmGZOV4zCbZY2luCC49jyBYCiECjVSQ3kEODsP1s+kw1pA9zB2Qwf2s72bZB+87l7cjbKfn
 2hb1W88AP4HFJ24kCsrWr2m4ByMNzpok/03xFR8puzdgrZ7yqXzPSJGVea/Zw633pTFITCkHy
 /p2rIutLhkATpKoTX8ayaj3YV0eRvWWxCWSqECc/QiIfADdTC0sLsdDr74r/Fsyfep1Evhpkz
 MQLNtN+CbXA3YGI0EfG7XFNOfTkl0SwzA6m1W9fUFoyJ9/I9GdtOCK9zBAVPaiMW+J4fiVnvA
 0fzoWnaWKGxdNbCZs3AEsxYtYfjZFmWZuu9mSqgnJ+oaMq2A5LEO89SSWEvZl1M8x8yLl6ydp
 47DGibAWS1ESO31jngLerQ5RrG82R3Rllnp203jx+wBowIHE4Fqe7MZaVGJr1OqUNXLa5//u8
 1raXCo5DpmDBdM5pDO4BfwCj2XuxTDiuG4KTtxz5yAMHPhrL4mJlZ+u0TsiIMtFQud9zTlAqQ
 GAMFCGQ3b3z6SplCmZ2/iypijwEkmA
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

On 7/31/26 14:19, Daniel Palmer wrote:
> Currently voodoo cards that weren't booted by the video BIOS aren't
> usable because the hardware is never brought up.
>=20
> This means if you happen to have a proper - non-x86 - computer,
> another card is the primary or you have a new BIOS that cannot
> run the video BIOS tdfxfb would probe but you will be staring at
> "no signal detected".
>=20
> This series implements manually booting cards using the
> values from the video BIOS' own table. Currently this only works
> for the voodoo 3.
>=20
> Debugging was partially assisted by Claude Fable 5. I could not
> work out why this would not work for months so I told it to
> create a voodoo 3 emulation for QEMU to compare the BIOS against
> my code. That made it obvious my init sequence matched the BIOS
> but the VGA core wasn't running.
>=20
> This has been tested on a real voodoo 3 in an x86-64 board and
> an Amiga 4000 with a mediator PCI bridge.
>=20
> I have some patches to add an interface for doing 3D rendering
> that are not included in this series and 3D rendering is also
> working so as far as I can tell everything is good.
>=20
> v2:
>    - Fix up some poor 3am English mistakes in the cover letter.
>    - Limit this to the voodoo 3. The BIOS layout is different
>      for the 4/5 apparently.
>    - Fixed the valid sashiko complaints - mainly clearing the
>      framebuffer memory before fbcon might have bound, retaining
>      the current behaviour if we can't get the video BIOS to get
>      the config parameters.
>    - Tweaked the wording of some of the commit messages.
>=20
> Daniel Palmer (5):
>    fbdev: tdfxfb: Add helper to read config table from BIOS
>    fbdev: tdfxfb: Attempt to detect if the card wasn't booted
>    fbdev: tdfxfb: Manually boot unbooted cards
>    fbdev: tdfxfb: Wake the VGA core before programming the CRTC
>    fbdev: tdfxfb: Program the initial video mode
>=20
>   drivers/video/fbdev/tdfxfb.c | 155 +++++++++++++++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
New series applied to fbdev.

Thanks!
Helge
