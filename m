Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260D606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nm+sxaTl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A71910FF9C;
	Wed, 18 Nov 2026 19:16:59 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1BE10FF9C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:16:52 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795029410; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:Ls7BKAjRIIyMSh2t2c+bxnKXwT1k
 lmZY80Nx97wnJ9aoTpnYtOr3wQ+9y8yWFIlCp2L9qeW8v+yap8i9oXhowvflrTMrsxxYY6eHw18
 RuI5LSAG5UvAejiTXebDkTfQtht05V+UiEQWfNg/uPAuxg2oy1lBzrCPMvD7dYyPERTD6cGrB1k
 qMEWMI9zVFw0utCwL81ZhkVosIJ0mk5UaFL9lSBnpOeOOGPvKoRElvy9hkdA1EQxMl6+lnuRf2+
 L+Fmuap70I7kEXFnQh/Q97exBD0kew7LPLF0wCjVCW7jAa9b5vh7SxGwncJp8EVoSp7cJL0T32A
 mi2UjOzvvRDeMQ==;
Message-Instance: m=1; h=sha256: irpcGwrO0fzGzPRQJ3qMT4N/cOvEtV40oQdfBHhK0Uw=:
 q7nmSr++XsZmNFdmOcEE/FaEj6yuO8BQ2xgPQ0N7HX8=, sha512:
 bxUBrvtqIGD8RL98jrxNnyZawF69sN5EFtYX6JilVbW4GAXHsQ6F3ACOuoyZGKhFxyfuerW3YgoKh5tagJ/nxQ==:
 BjPd4x+CYHFKRxr6oXvFpGUdLNwVyqcoJESWw+7f4KzyvhlSsj0+5m9yxpVXJwH8Ec1P0xhLvMeT2fvMJxoCXg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795029378; x=1795634178; i=deller@gmx.de;
 bh=P7kP4v/0jKujn0+Kg30mkAo9ue3/5g86RDnIUDD5ABs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nm+sxaTlhjLXzj78rSM9yk4AgMVvaVHMzYVj2EIWW6ILFc+wDvEOP+GNV5fZudMS
 dHCo8P/bRJf4ClXK3uajEmsKn5z32TsBTTzuKtvkcg0wrnu4uikBHmZJVWgwFc8+1
 fkg8drJ7hLOYPteNvRAyEJg8zWkdr2eiTSkcxAXg/MhuXS8ey1SclXHtJfCQ8PuEt
 Vc4+wqwm+5FqL6r+/xsq2rq2ZZWZQQJdYDqKVBzMAweJurt5tGq6OO/JdSZ9XwHvg
 diY9SCxK4Zbi/+IH3/H8cxPQPNRO08mHNgti8KR/ktk6IiZyWDx+rC9yXEFNnEnn9
 aZrTjL+/xA2CTL+obA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1wy1Q51cvP-00TjbP; Wed, 18
 Nov 2026 20:16:18 +0100
Message-ID: <d40ce597-6c87-4272-b70b-e964531f9fc9@gmx.de>
Date: Wed, 18 Nov 2026 20:16:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: smscufx: allocate the size advertised in smem_len
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261102092925.18027-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261102092925.18027-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hyqSCxuM4WbBAet2B56O00cyau/yJnE4h9v+VFAyTCi/lGNo8tm
 Sy3P7c4FNGoeWyjWxcho8F+47TUPk2cyw1Y7yH37UU4gKf35cTAUFs3TntH/w0/3v9jNmG+
 W7aqLpBnzyDhq0ucRk3Ja3XJbAPkMFW74dBrLUsgAkkLCTa49HuqmutPEDiS5jmX3eVBPhh
 dIOzU4MfY7mMqhCFP4CBw==
UI-OutboundReport: notjunk:1;M01:P0:QnD3GWaMVPM=;0HqWtPAVlW0w6gzQwB+CMAH29qJ
 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
 pGmOeUurGkQq4lPMk3gQnqPB1Dg==
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:29, YuanZhe Liu wrote:
> ufx_realloc_framebuffer() allocates line_length * yres bytes but records
> PAGE_ALIGN(line_length * yres) in info->fix.smem_len.  ufx_ops_set_par()
> clears the framebuffer by writing smem_len bytes, so the write runs past
> the end of the vmalloc() allocation whenever the mode size is not page
> aligned:
>=20
>    BUG: KASAN: vmalloc-out-of-bounds in ufx_ops_set_par
>    Write of size 2 at addr ffffc90005518600
>    Call Trace:
>     ufx_ops_set_par
>     ufx_usb_probe
>     usb_probe_interface
>=20
> This runs from the probe path, before any client can open the device: wi=
th
> the fallback mode of 800x600 at 16 bpp the framebuffer is 960000 bytes a=
nd
> PAGE_ALIGN() adds 2560 bytes that were never allocated.
>=20
> Allocate the page aligned size that is published in smem_len instead, so
> the buffer covers every byte the driver and the framebuffer core can rea=
ch
> through smem_start and smem_len.
>=20
> Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adap=
ters")
> Cc: stable@vger.kernel.org
> ---
>   drivers/video/fbdev/smscufx.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
applied.

Thanks!
Helge
