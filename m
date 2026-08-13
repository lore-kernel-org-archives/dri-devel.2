Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7431BC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA98010E4C7;
	Thu, 13 Aug 2026 16:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="QgTEELaF";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933C010E4C7
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786637488; x=1787242288; i=deller@gmx.de;
 bh=+ty+RJMFAkFme2S8Hcpdhma4jXJiRtENkIajXxicY7g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QgTEELaF/FE5+rj2qlflRiehgOcUMtU9YuTRSzk54vThyPwgObVG6F70Kadnk5Sb
 M47KHn+FlIsqfoYmewIslWXmKgmocyybKwDFXnRz7aHRbAA1RpC/1GVHnXWy7m1Fc
 k4O3hzDlzFbf5FYNLAe+7nZRo8Lf+6uGET1KhJQjVFrc8mylXKl8xs3LH3J1pei4T
 Mo6MzVmEYQ+njeAuy0ZDZ3GMht/EKial/Wx4jDUzaWQPLuhXF7uXOXLFCkf0NtYvt
 9nQK6ybiXCW91jplne3HqFx0OBIl1U8am9Rk4J9f5SoXIait9x6swK0ze4TVsU9Kz
 XoMJEocGdSX2xFpwmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1x8cyC1xrI-015Pnr; Thu, 13
 Aug 2026 18:11:28 +0200
Message-ID: <81ac11ee-772e-4024-b9e9-6a925344052c@gmx.de>
Date: Thu, 13 Aug 2026 18:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20260809234810.982500-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260809234810.982500-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j3tHv/2nz8AAAu2WPlhglHO5ktDabTArZmhwwR9zvPsYSN+evnO
 o60DQ2l5fNZPUDmoLy1h3SyvvdrEzojlPbmqzR4IOv//YklCsTr9Hv9jnfNvBeDCdf7F4F6
 EwJDkle35StjZSm0YlkC55x4xkm5V9+IE6wMaN06J7C6vmEN8ojsxsE8/jq1AozjJ9JabKj
 qieBSZKFymmLuDyLRbRaQ==
UI-OutboundReport: notjunk:1;M01:P0:n1dZL3hLIHU=;g6gzE4Sh+ytNbu1/t+mlP5tkvI7
 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
 D4isHhte6eRz9peQ==
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

On 8/10/26 01:48, Randy Dunlap wrote:
> This is all ancient source code from the beginning of git time.
> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
>=20
> Fixes these build errors/warnings:
> .....
>   drivers/video/fbdev/maxinefb.c |   17 ++---------------
>   include/video/maxinefb.h       |    4 ++--
>   2 files changed, 4 insertions(+), 17 deletions(-)
I've added the various comments from the mail thread to the
patch and applied the patch as-is for now.

Thanks!
Helge
