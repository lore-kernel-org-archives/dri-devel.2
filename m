Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF07C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 20:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A1310E24D;
	Sat,  1 Aug 2026 20:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="qEjIjsqP";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89A610E24D
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785616496; x=1786221296; i=deller@gmx.de;
 bh=Owr7sMTX2aLvpgkSZWADmRcTqAKxWCI5ldS5tgT1Bnk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qEjIjsqPBguOgtTfqCWDMRiBrsCnAMi5P+pM9NEyvXuWU5JlAEfJgUfZ1ey1/Xjp
 ct1wy7X0lizQh1ytng26ebE7KXIy8Tqi+4+Z34W6Sj8XpmT5xp1LBNtZCso5qLa8G
 deWymW87bEM7JXN1XIsKwZBH8XpMrRd/iy4r7dEy1Ej+pmJi2JKnjdUvOmxiS5ZTG
 JuuzNucgKgbU0/b/DEzmfrVL2EOUixSdpWBTlueR+NWtejXSulnuqVo9UrD/5eYZg
 LQLTzS60e9M7dxmLUlXnq5SdrwgHOcAWTGxvHcFVvSZC5vjuh3DHCjzupttPIyI/H
 eZJtBmf0H0aaG5SvgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1xMqLq0iK2-00ZNCm; Sat, 01
 Aug 2026 22:34:56 +0200
Message-ID: <283b960f-7835-427b-87c2-4892d1e028cf@gmx.de>
Date: Sat, 1 Aug 2026 22:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: au1100fb: drop unneeded semicolon
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260801191002.1383835-3-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260801191002.1383835-3-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K1wBEUTlEbNWlEqoCK1mNVezJ0fTCdmZAoU9lMBrr+mB+4olBjy
 FNodo24r29kUE0XoursK8q4gNZvNkdCfL1ioj/pDvZShCVRqWobP5hG89nOxj52NCNlTyQy
 Mi1muxOf2NaXl4AYFL2O/BnEaQOVieCyt+bTjFIK401DJ76tuCafjpG0wH7K4DywciQQ5d3
 BE1NGJ3zWNDokkBAOG8WA==
UI-OutboundReport: notjunk:1;M01:P0:/D2Y3tw6lKI=;uiYlNikJa3rUFNq4ThVFrfLagRy
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

On 8/1/26 21:09, Julia Lawall wrote:
> When a function-like macro expands to an expression, that expression
> doesn't need a semicolon after it.  All uses have been verified to
> have their own semicolons.
>=20
> This was found using the following Coccinelle semantic patch:
>=20
> @r@
> identifier i : script:ocaml() { String.lowercase_ascii i =3D i };
> expression e;
> @@
>=20
> *#define i(...) e;
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---
>   drivers/video/fbdev/au1100fb.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
applied.

Thanks!
Helge
