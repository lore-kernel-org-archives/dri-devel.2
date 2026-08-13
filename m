Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92222C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36C510F3CB;
	Thu, 13 Aug 2026 15:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Tm//CK4Z";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4DE10E4F2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786636519; x=1787241319; i=deller@gmx.de;
 bh=jhvMbE6D66gN7ouXu5XnI/kv3uwP9+K4RoM6cqiK8jc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Tm//CK4Z/EsPwvm8aY0VF+LQ3OoWtuN/Hg53Zfi0ON4qNC00pFFtVFLPI/V3q84I
 kncq0y+liRkv7mA8Nxjt8W9ien0kRBdHz3KgNcc3laPedHS/LSInD/v/8lkp3DPVJ
 DDFIGDmd901jWC5vIykJWA+GDvOHgirSFxOyIgMRyDflRM+3YhZDzSmV6S6DApvob
 VVJ8eeDEMXd8RBQWovM6kKZ2itBdqjF9rUPShVFrFQkSL49dngq41EA052FngehTk
 +1w/lBr/f2pgm7nTSZj5bbm16IeK+W+snPqjuT/nKCgavJ2ThTdvU8tMKOwMGab5Q
 53yJJ1Yimo2yRq7hcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1xBw4E333I-017nsC; Thu, 13
 Aug 2026 17:55:18 +0200
Message-ID: <3f3c8baf-1409-4fe9-a8a6-c64a7e5f5a4f@gmx.de>
Date: Thu, 13 Aug 2026 17:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: via: refactor deprecated strcpy
To: Ajith P V <ajithpv.linux@gmail.com>, FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260810121908.31307-1-ajithpv.linux@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260810121908.31307-1-ajithpv.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZmGOFPtXLpv5pFJb8TRTy/Q0v1Krz7+sW3/1J2YxK0bI0P40Nm1
 42cpEWkzyVI5vlwrP94QV7kBFOlov9XcHXBBJuVj7Jv6icQ0iCIZbDvZisWHADliL3hQwsJ
 zNBsuAaurUSGYmItRryRQMe36Bmj/ai3bA0SpB7LRPyEBOEJWWelHz6bm+mXVI+U5NAq9v4
 1Bzgu9+oYhCByvDdQQ1rA==
UI-OutboundReport: notjunk:1;M01:P0:mfBIe34Zw84=;Y8XdmcFi2ADZJUyUl9+/e+bi86Z
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

On 8/10/26 14:19, Ajith P V wrote:
> Replace the deprecated and unbounded strcpy() function with the safer
> strscpy() alternative when setting up the framebuffer fixed screen
> information [1][2].
>=20
> The destination buffer `fix->id` is a fixed-size character array of
> 16 bytes. The source `viafb_name` is currently a static global string
> literal ("Via"), which safely fits the destination and poses no active
> overflow risk.

correct.

> However, replacing strcpy() with strscpy() aligns this driver with
> the ongoing kernel-wide security initiative to eliminate unbounded
> string copies, hardening the code against future modifications.
Compilers often can optimize strcpy() but not strscpy().
So, why not simply dropping viafb_name and replace it with a constant stri=
ng?
Or even make it 'const char viafb_name[] =3D "viafb";' and use this?
Then the compiler can detect any issues at compile time.

Helge
