Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977FACDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F8410E221;
	Thu, 25 Jun 2026 16:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="hVwGguCd";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A97110E221
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782404997; x=1783009797; i=deller@gmx.de;
 bh=j6Jr+FKXj4NuhY0IpgT2pBiBexCSFeIBbagyNYZCpC0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hVwGguCdxl5gZYY3lOueaql8tq1JVOIuYSvan5lulfd/LsGHBKyirc58ALcHvR0i
 0by/O8OKK++JV0bVT11eMkcH/MzRcu/WK9tBgtjHizTeQ791fCGbN2PdmzL0unuHP
 lzMrBSAIV4Z10OWhpk+B+HOcEDwYDA1MGwpy1RnS+VVGAcTot2zeqoXWCn8UYe2L8
 YqE6FYjXL2TpuLadQISkh+C8p/DZnzI+ydNZqhd+jS+1z+ekiGUPWRmWCM0kmJQFd
 0ZYySLUmKs2TxxZseFNCGLwruT85eS2DWroHRc/CEwbVYfi4+jwsskqge4XdIMHiI
 5eWH++Bf6ERszkpGEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1wni972BPk-00W04P; Thu, 25
 Jun 2026 18:29:57 +0200
Message-ID: <2958cbbe-de8d-4156-ba7c-a500ff364cdc@gmx.de>
Date: Thu, 25 Jun 2026 18:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: goldfishfb: fail pan display on base-update timeout
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260625030102.79755-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260625030102.79755-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LAw2p+lDnNqefHQCaBER0/PsLbtZ5MEL6Y/rLbP7nBc0ESZoVYs
 8n7N4NH9Kssf979kHGHByA3L4DBsQWQjmYRMV+EWXkr3ah57dnN0PeYmq5EjmKDwMlytUQr
 f8jpq2BbY3N2OLrDdrzrY0lLqYBE/AXAnsEKzKignZDM7EzfL2JlO0kVesPEbdtg5aIU747
 bmG+UGe8TjJCW5xhqdH3w==
UI-OutboundReport: notjunk:1;M01:P0:ojMlTszBU/o=;bPf8zKQ2YvqqB6GwYtWdRkWQ49H
 saT7n3NtcyzCA9rdW0RsG1siHkwro4BaHwS9NPEVrlIdY4z6uScYc++mmYFcAsAx3WVGJdTeh
 sIQegdc8+4HVAgpTFcKesQ0GGzQUDR0D+QMGkuXxjgcTR9O64AEikzae8YRt2trq9eQgA+/Rz
 vW/Sl5NwYizzcgfHYK0UPeNxaPsfzx0P5Tt85z6NFHxKqiGcl1WIn5nhjVwvpQTxv96/iBrv/
 tolGlQi6KVOMkKXaM8RJQghB8m88QL+MNt8FCpLlUmxmMNpgmN5w97nN0ldYEmkV57cIfVfMJ
 nD6/ys7iduq5pie7LVduTtwQULsyk/x/ATPqdAleMXT3opz4gLDxPN8bOENWpMnzOQv3S39py
 PVxRzEGQj2byuclbDud385c2cbTAD1GXH+0Yh2Ei31TQawY2O3iu6oCXEsOmO3pTD4Sv+8Z5A
 cbg1E/YHEAubo/ld6olRcwtOy371JfyR/cIND3SIbR6WDxEazZgmytUeca3CI738AlYuBYyBo
 rkkD8ZtmyzKdsciag/N/JDMMDtc9iyio8yI+K/fZ5T9owITVRYyun2p3pS4LBTEJmY10zx51C
 6pE1p9HtEvLefJa9Mw1zDxzPEPAk/V9raINdclZVjxMIMwTb+ENZWrgRcYaFrACcLON1yaPTG
 M18vfGpdsCP2X80DjKanDiznQ02tMS2nTXDAVrI83HWT8ZPbs1brXLz+oUZHhvUQoHCm2uITk
 RHNAxKva0DAZY8hYChpR3IB9BwAHVCy+Ir1m+0ykb3btTRMWE9J2hWIiAmn0LkJ3IxMXlfitg
 TBuyIZIIQ5N0KlUmOMLHaqkqXoX2raUHAN0k+t5pgX1juWqONqjgW28mUfYzgpaj36Ov32syl
 K53jO5OesjGdP3eV7PQy1nS6cfRHyNCLy0YL4OMN/rWHJdNzMD9uGOpOk9lGhSHLT0ZUh+of/
 Kde72WV9DeQJXXRO4Ta83zX7ZQcd1cQ3JH/mPR2oWE5lB4yVPK3f5JSf+XQerHWienK6rlmF1
 26TuVXkTry1IQUZufjJ1Y7t09GEMQNI133yb3aDCYt+RrfsZ7NmxSQAM41Wxwg708odpwxDar
 rM6Z6vBaPDSN12IfWh84ttF19/tUoHHBoTLZB5outMqN7+lwmI/tdc8qH0Ue4eXWa/+a7zHGw
 VQyzr/LwXyFCRDJvOq2p7ZvOPjQ/8g7as4VWnIThQmUxtGVwXBKL3RRq6KvXkRZB3/aW6eQ1O
 EpYCZZ7bpuJvLCaYr9O97IwosUtj3eAE0tojB/UYcgJJDHqZyZ43ZXcAk8adH0zYFkpf7Jhig
 4ZrijtMhfiBF0gIvRT9AnwXdZbAZIYIC//Ob8N8pkazpmJde/BE1/cY9/byC7uCettoERclTI
 5urP+oIgjWtVe2js452KUxq2zc0qTOalBRccNxeAPabf+r53LpMLVOzoz6JbA5SVBnuTndw8+
 QutVJbMzR0U8Cg+opIXCsK3l3c+nwGAiXgzzPt0IFr8B8HPEsZVxRMusXv8GfbzJNMR1sVZ4x
 LSVSzDKTvrV8DjIMwP/F6vLQTYRCwI6TRumI0nXoyyhsFxa7Zs7gCX2fEmsNj1AlYXPgVXMIo
 kpfXPhu0Ko3JLD/Rs1Euu4Ubm3TqfEaVW89mBg52rSp9+YZ7bo72PriZGzby54ruqPxO0um64
 h8fFoAi/vKvKIn6ne20HbXaLRTlOJVu4nsyxspZ4NOdcKrSugVLV2TpfFNuM44LuW693HEupV
 QHSQ3/khA3PfQYyU0anXU//B+hEyxP8DOreqOrRZlX2zw6LeW+ey4Tq5EgMwJerafXduotZCc
 j21YyooRmde03FzNcZ/UWABCo9ecIOsx8tSltG8C7/VgH6IEQFKyTZZjiO0oR7PDs8Y97go+U
 nHOt6d8SG9zxgMjy2+EhGManuVOkNwgT+VUudQP/HXkemrIpRZQlqn4r1aF+JtKvN3tAw43NH
 CoV5ja0RwgORqB9EVPx9eEeooIVoz9u+HBcTVSYJoPbJHjALZjB6wjNCZWxS/+yAox0YJS4yH
 DuvbR54pkmzvY1XvJIfVwfDoRhMioxvAum6r/YT19FRS9chs4m/lWmsROyPiIH7Ya9GUjkUL7
 ipwwKyoY0rGLwRR5VpSrCfmtVA5wqDXAv9XRp7dJFSQ8pWeoMDEAZJcZ8avV3crqKnYWguaNG
 4b34E0BhwWMYrY8DJUSqcSLb2K2kWnJHmORLg7egXeAl+TTcQ/dbDEXBdYnUFbKW6EE/Ssn3C
 DcOssP6LnPCZUNtqc9mZ/PMWIFd8YDoLP93e15/CLJF5kRRfC9wRtSkAHj/7m6dlzVT0mcgzN
 9t67O/G5ThUMeYPdSACRsU/VpRXZ7CRXEQYr8BO0diNwMLKchFYl+bO7Qkxfx1eF/doBbzjL5
 f+H6zVhOJtzcn0G1KBAHYo1+NZOs6tyUxKpxWXlfg9u6CyifWm5yr0Hl42oaAOZ+iJ5hEhwiC
 mxKgXgHEnpyWLwAC2ZyrMhNMh+HWIf7js9ZeNsTs1OLjQa8xbLCFBW1LwQBknOFjzYRHrq4T/
 W6vUXffIMAjPY8UUlODdtl21Ozjv1TlWtxpEAO89d+gQS4x2TUGYy/IM2P0iPpkK8YvXom0M0
 6xfy4HLH1uFGeCjiqxvYppn0fZUC5AjZ7oW4+Jc6ofaKnPFE4JpBasfvKN1Q3x3vBq+FwA1O2
 3fBfT5ayfPEIfjD8MOD5Amipr98yz91kpKW5Qq++EL/baPNwZoE0PINbR6mUb55koUkm0/IlQ
 WwuhXlvMpPIQ2w6/psiaYQIRjw9AoJ+DePTXA/7QBB1MqqSqUctpsXRn6kbsT3h6XRiPwpQeo
 eLbZSOF3bMQOts9TJrh+W5VGiW3tcm3S1hzbfq27lBmoLz18nfNv+b8QRcVIJxpWmBaSslYZz
 ZFGXYadUeG08ACMluGI00nBKB0FrR0SWS9i9cqCKnCmfyr8q5gxRtzGKEJBSGy8rb/rGkvvTd
 lcK3GkTjvEEP/31rof4I6ovZVykuyhKhx9tuiHkMRI1aIpl876F3a+hVgzc4as2EDnHQueaKE
 z+U1zSgMQ9wzKX4ctbKMpEFghXzqgTuZ11cnkUM0NtKm8qLdC5iwpmXoCehNF1yrqvFGWl92E
 ziSUp0tJBxl63WM9G4ZUur46fMrDeEANOaUwErFM6HKclMoJSGVD2ZCYeyiqAabuUgiWtnLI5
 n+7ERFWNx+kFalX9SjJ5+ZApPcsqddnaKODkDz5kTnCd9aJjhyessfdFkkRy3+RK1KCFBMYA1
 +HbOvHJUn6tFTxn8388Y64qa4QbZLvuDVI7KhJXACDrCl6+0pKcXp15NzoEK7FQQgaAAdLaRv
 bF5ea3+fuEY0RRxp2BsF7LRhw5LEGoK4mXIEPDOr8WnTsFSyPcL6BV5LBhgAEXGD8om/YbCPh
 Q8hCoo4h7fc3E/KpjDZnNTsfsJHkuzbXcrjBnuuXMxHVtOn25ntYAgARRjLXnStTXlUtDDiA1
 r9B+1NLZPoQuWKJCjYayuM3ZgH/ezQ6bu6Zy5wIhjtSrTHPrP8shRFFZLyI+zbqqF0E6isBf4
 XRsY69hPzqpAwCCMBs+uuPpxujHac/nwP7hdnp7Vv7TjgO8SOv7FJ2v4+sVLko4lZqXHhYwgd
 nxYnYHwt+bBBjwKE113oXUj8dLwOBkNhAPhp5D6gJ6qygBeSBn/++97K5fcSRqlAjJwSutllJ
 B/00wwb/DXpWDwvTn/lxyhcC3z+Wc/uHCDa4dSitPxOcKGH3IrCVWp6WM+umjG+kMz6WBkDxI
 4FbkX7GkHrmF+dnyq2DuiWicOzvwo2yRO3mF3GO//T3KMoY10kvsnIM+DER9J76d20KPz9yWS
 iYTNW1TdmIRpu0HP09bX48VCLlMt8rtg85u0TGfMOLREuGg/eI9ufEKqeYQoo0WMLZ5MFpCCH
 qNou7dSUob0pOlw+pvToldMY3ScImsblL/tb6cI1YqJgsORY+yc4EzUQ7uOUI9skxDI9Wa3kH
 f/brZhbiaK2xnI2/pWmQRQD8rDLLg/KQ3IaoDOeoDBxFhqc4pq9tqcZIaPwf+PxcHXk+RqlLR
 h8qAkofyU7ROLK1XLy/e5F/0/t4BKkDdrcUPbC5yfftGWC6bJA2Io8SxTzkVFT0fJ9dThWks8
 ZJHo6FSr1X6XZ3DMAAGWmuNGl1Mt1/DiOnSzHLxIJYAx4hIiemOehsormS3P+KhzsTrZqZLVq
 syEIecHW4PUSn7JkYLfo6U+AcOD69EkG+y5h8bVvhTVM/zwE2QrI1K13RPdxSxmgfTW8zCMX5
 AEom87hQb+uyDLYrtKPvVWaetIWSjhOMeAUk05bOsdNVJIXsk0I9plxFXNWJMXwh3Hq/B0+lh
 zDQNdUAVZamBlQNrCBwaTso9IuANPDwX15cfVmq7l5Nifv7mnejhcBNMVsa+1vB7PntNSJT52
 VpJZivVTnzY0Hky2v+BZ5sLqG3h34dJ6mZ4WYka2Fueivi5JZ5QxBh96UNGibuPdyLRjmh2W6
 PgA5wW0B8nM+4tCdJscq6qO13m31Bp9BCDXkyjGMgzWenjDtRfaRZ5tL4DH3nvCfNNo31BiP0
 rxDgGsgcW7b0IETxWXa+P8ahzBp8FFpyhOtwnt/8ygKLr4R3TCSUvA3QPVFy6qrxtz7okqRnU
 ZKg19BJ9ym9Sp4kRrAlQcvbLN6A9k0q9TNi5XDQMfDDTuiHemIfRCCu7c4NV89tV1OP3b1J+S
 kMYpKU6s/1+LjUfVwHPHeRSYZLHPqvIXM9MeRcLxKEPDy5cdui60ZXIl9Anj4vB+2vwDznHAR
 XVovYLgevHhBFdEZ4NyFsPq0nxQXIvNjpvaJdmE3oZc8TUApIuGv/hZVGBBNiauxNlLK4NAQw
 feRzG/vo8bX2S+K3vxAGi4e0Txej+aF1Eco6zNbUev2uA9N9T26iHMPWi4MSfF5K02DMNsfBz
 3DJg8MZfzsQw9hpry7dhRWmSaI02YKg/976TdbVM3SECuBppdSH4g3etMrRS+F+1hyI9sfHzV
 ItVegIHBDG+nzA4eil33duLl8DQfwETXVhpccM0PrWoaN7pvraWF8a/QydJvco/iISTDJIKoS
 WGOyH4Gfvkwst6j5+z+LGl2FjqyeaI0wUi6WssBZCPG94lLT8jnFFPeM2upJVSLdDbZE4o+6c
 1QMXkKZA6eqnijmxm+NN32Yb7PPQhRXZp7h29AHq/qwoydr8ibUC/4e0MuO119X7KAMS33juN
 Thp7nN4SXxYVNVeLtoPUiS5UyxjZHGDHPwbiGimErkSrEIov7tl1uV4hvluU3/S7XkJ8yawxo
 7+iShx+7LClXIJm8/7lNEUCX2TaDUJkorm2TP8SNKjwDCjUXyAxuTg9UvGYgLS6HVqKteCWlW
 1X6coHPSnQxuTcSziS8JdqBrltMvO1oCwRxi9mQ9B12X/mu5eJor2zp6M0BZ1IN70HIPy/jVg
 ERmNy7EbPYzf7JsMDkgVWkDejZ8avKyl7P0/2NEyGat32GGSsCpfIeXu+p12wkehqmkFGYZlK
 DA9aidb7RhZX3NPsqi+dH+Z64R085etE+CF77zBbSmDS2MsnFPb5q7zkUp8XMMDt5sPtKfsnH
 xmWXZnA4yO+hQYca4bdhUQNaZmg=
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

On 6/25/26 05:01, Pengpeng Hou wrote:
> goldfish_fb_pan_display() waits for the device to acknowledge the new
> framebuffer base, but it only logs a timeout and still reports success.
> The probe path also ignores the initial pan-display result before
> registering the framebuffer.
>=20
> Return -ETIMEDOUT when the base-update acknowledgment does not arrive,
> and propagate that error from the initial probe-time base update before
> the framebuffer is published.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/video/fbdev/goldfishfb.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

applied.

Thanks!
Helge
