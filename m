Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5239DC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B197D10E09E;
	Fri, 14 Aug 2026 07:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="jsUAX/t8";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93AE10E09E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786693160; x=1787297960; i=deller@gmx.de;
 bh=vVmvEbjJhFB9WmxxfgfG99J4R4PuDxNShJucSYr3rew=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jsUAX/t8hVqEKRvJQ9R1cPT9VFgCdnLm1kKq/Uty/lQ28Uk6GgKv9FC8NTgMG9h8
 xfLCn7nzPyv6b+qm+noRkDitR2TfSqOxMaB6g70pLzXPjvWersrrJ3pMBVnGTJz/w
 2ZQVh9Unz4w6YMR5HXnPxwTCPsUi4hxpFI2UQeI3EhI1ozWJRNJb/yzBhWoy+GbId
 sRRgIbia6OnMHhofNVIm/gEWarANX7hVRO7w+cwgpixhZTl1EysBgxd/2Hxh2Olip
 FTQKUirv9NfTYzTSMC+OyiLw3KfOFFLY5Euu1/gqUJMzFdCon+jYq6bxlPiF2IW2r
 mWN7W5fdISIFioCWvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1wZooO1CTU-00WLzt; Fri, 14
 Aug 2026 09:39:20 +0200
Message-ID: <2c453754-64d9-42eb-8006-21ec003a2575@gmx.de>
Date: Fri, 14 Aug 2026 09:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/03] fbdev: maxine: clean up build issues
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260813232934.2718291-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OQ6I8ICmZrjPJRTxPyYNBJEMs9hnB48E4DtMKRCi8Sb1bdCcuwb
 nb/gtWXmD4QHpweWxIQFngVZEVTjhCafcUwJlBB7YJ8JKZaPVfs9TTq01iWpgFiDi3sou00
 HdqZ7OPS+tCsGkMfdctXOAV0XNdrtJa6pvsrNtnZ/VNDwUVYF8wOhrLiS86qHj4BzmsVvhk
 5c/6t632Z05/+tC9U2eGA==
UI-OutboundReport: notjunk:1;M01:P0:hgf+ZLUh4vc=;sTFPxLBtH0slSXtuVdMal/YxYGv
 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
 IwClhGw==
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

On 8/14/26 01:29, Randy Dunlap wrote:
> This is all ancient source code from the beginning of git time.
> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
>=20
>=20
> Subject: [PATCH 01/03] fbdev: maxine: make functions static
> Subject: [PATCH 02/03] fbdev: maxine: elide an unused function
> Subject: [PATCH 03/03] fbdev: maxine: fix 64-bit build error
>=20
>   drivers/video/fbdev/maxinefb.c |    9 ++++++---
>   include/video/maxinefb.h       |    4 ++--
>   2 files changed, 8 insertions(+), 5 deletions(-)

Thanks Randy!

I've applied all patches (including #4).
I'll add upcoming Reviewed-by/Acked-by tags too.

Helge

> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

