Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A89CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E6810E9E6;
	Tue, 23 Jun 2026 08:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="gFoJCS+M";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3447910E9E6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782202223; x=1782807023; i=deller@gmx.de;
 bh=dpGVsb30prTR9fhD+l81XDxTBfN5BnL/lsdy1gwzXwA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gFoJCS+MYzngK3oR6m/V62rmXbkepcfxm/Xht/OdvRJV9W68oZpJQy3c/ZeTH41t
 ljPrXUYL+kC9dqyeTZSiEFTXOReFd4FE8Wjdsfjs/ttlJBe+ZMPEO8PF+jjTk1PuA
 RCoePFNQAI+dQkMk5ZPkUeidLlVGJxgD/0/ydIy+WzSlhxubFIOviPcr3AHy1DiMc
 kmTDIDmPXZdwwZN9p8Z01NcI/z424+I0paLRaGYI/3X4OhFHIH0OL3nt09oOFBMr1
 MBCsZwV/8BIAchy5wJtYfLqfuDZANxGOnckcEWuVhn6XdTgBddhF8YWNV/5z085x0
 DiGD/ru22PonYaNdyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1wqqQh3NT0-00QaIz; Tue, 23
 Jun 2026 10:10:21 +0200
Message-ID: <2d21c6b7-e7f5-476a-aed3-09ac6d89b099@gmx.de>
Date: Tue, 23 Jun 2026 10:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: hpfb: Unregister DIO driver on init failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260622064915.767194-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260622064915.767194-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G//Q3HB8udQE66W6jtU0hLQQZLPXW74YrgaopRzGApOnTEOZV8V
 DdGkpOnLwClIPdBY6flzAZL2xpGqbVmd+CRXo4d6dOMxgcx+Y7OVI9pHMogXPI+AV5a7poY
 MnA/+KAHeXSkHQhQXHPRQoBICFKknaGeimqpwQHtS5C3UYDRabeabsyYByzdoZyAIAICHcL
 2twrBXjxyNN5vnj7YMGRA==
UI-OutboundReport: notjunk:1;M01:P0:zPq0lgCt0eU=;8MyPr7XSZF2/oyUdznhqSckL2j5
 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
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

On 6/22/26 08:49, Haoxiang Li wrote:
> hpfb_init() registers the DIO driver via dio_register_driver().
> If a later error occurs, the function returns directly without
> unregistering the DIO driver. Unregister the DIO driver before
> returning from these error paths.
>=20
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>   drivers/video/fbdev/hpfb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Thanks! Patch applied to fbdev git tree.

By the way... doesn't the request_mem_region() below needs a corresponding
release_mem_region() in the failure path?

Helge

>=20
> diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
> index a1144b150982..1405712e5b4f 100644
> --- a/drivers/video/fbdev/hpfb.c
> +++ b/drivers/video/fbdev/hpfb.c
> @@ -407,10 +407,13 @@ static int __init hpfb_init(void)
>   	err =3D copy_from_kernel_nofault(&i, (unsigned char *)INTFBVADDR + DI=
O_IDOFF, 1);
>  =20
>   	if (!err && (i =3D=3D DIO_ID_FBUFFER) && topcat_sid_ok(sid =3D DIO_SE=
CID(INTFBVADDR))) {
> -		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
> +		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat")) =
{
> +			dio_unregister_driver(&hpfb_driver);
>   			return -EBUSY;
> +		}
>   		printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid)=
;
>   		if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {
> +			dio_unregister_driver(&hpfb_driver);
>   			return -ENOMEM;
>   		}
>   	}

