Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E12C5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FC210E029;
	Tue, 18 Aug 2026 12:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="GSSAapZq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8350910E029
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787055901; x=1787660701; i=deller@gmx.de;
 bh=nm1wiok9d4BtsKSfzBSReeUs6Vx31cuinQLxNwg6kuU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GSSAapZqElc7Swm4PgzH77EIWRasa2KB8Cwf1MZUYurpJXH26mxbNDBl4Rrx1EW1
 FxAWN1yZpZ3PpCOJk3Rp+MZFUb7Z81BFJ0RUL+QLSN4NjcQVurqvkj8aSqtEVHRzt
 WjXaPICPsOdWnAORSpWG5kY7EkrxPS8/wGj0nPuJNjgM0NFsX808Orwf9KanmtJj7
 lL6S0b9+SHlKrX+1xzVsrTLrhUHcx+mMLETmmxWmku3l/QWrNY1FKxbU1qigK1Yco
 ug2EvnnRHZqnwROxwl8ovK2Wy6zw6nv8QT66b8gzzw3B2x36BfOdEe0bIrFertUz1
 gd9EgjFca2Fh1oLN3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1xMwRh3f7Z-00XdWm; Tue, 18
 Aug 2026 14:25:00 +0200
Message-ID: <53d1fe59-dfb4-4eed-b6a8-8d7a40119923@gmx.de>
Date: Tue, 18 Aug 2026 14:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] video: fbdev: via: refactor strcpy and viafb_name
To: Ajith P V <ajithpv.linux@gmail.com>, FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260818111722.471340-1-ajithpv.linux@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260818111722.471340-1-ajithpv.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kBqxAHJ6wsBXlblMhbNceEJsYshs4YuQkZ4OtOjOxtcquBbkYcP
 1jPa1VW2UZoqHjrku/BLKJo+Wr6qg8WMP05rQsLtvY6UXmeJ+pMk9A+3VJYQr8syb+bbFX4
 RNFJtp4QGPEP/SaSCzrWZirwjv+W/vFGJlEXPFtlffYIkHnNt38D21ZVW7qTORsycDfyhWB
 4FMwoTic83viLb7UDfj/Q==
UI-OutboundReport: notjunk:1;M01:P0:KiryaHgWdUg=;fBiNVNv7V0AlG8mYqhaalh8FGD1
 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
 5fC8ZpHzd4Qs5QuexLGWPEKNtkI1SsiTvofos=
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

On 8/18/26 13:17, Ajith P V wrote:
> Eliminate the single-use file-scope variable `viafb_name` and pass the
> "Via" string literal directly to strcpy().
>=20
> Since "Via" is a literal constant, the compiler safely executes
> compile-time bounds checking during fortify verification. This satisfies
> the security initiative requirements while minimizing code complexity.
>=20
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ...
>   drivers/video/fbdev/via/viafbdev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
applied.

Thanks!
Helge
