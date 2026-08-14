Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3380FC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9313F10E0E7;
	Fri, 14 Aug 2026 19:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="F5cANw2O";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B80010E0E7
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786736404; x=1787341204; i=deller@gmx.de;
 bh=l1Zlvqt5uKpJi+oSNqzNZjhNTIZc4WRtX7/0jhyuboU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=F5cANw2OT7duzZUZMmR8M5mJ3jWy0jk81qIZo2UGlEAEs3uVjYQjuHZ0/wJNvhyW
 8b9YxVSB4YSZlWKoX50WHgf09kV7sI1LiDsAYECKRx2a1kdE97xScj73oN9MekDj4
 9XwMh59mqKSp32+Eks5WGhZcl5Qzbx+VAOY8mEoL013/PDsCdZwY7ybg0/wBI0AG4
 XCA+lMrhdapAopmR9S8uVv+YemJTxJl+5RXSFCTuoUT/i+aSFSY/7IdduFNXzGxAA
 qJ8Xhe6vH/we6uXx0vaE8qnaqgkFcdN1A8KNOHF9EXJ1vOjz9kLDuJwAmWK+p+DC7
 E43KwXH45eI9ORkI8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1wt1wx1lkl-006ghN; Fri, 14
 Aug 2026 21:40:04 +0200
Message-ID: <72639acc-2285-47a7-9f37-2aff593e10eb@gmx.de>
Date: Fri, 14 Aug 2026 21:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: maxine: use MODULE_LICENSE() unconditionally
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20260814184234.3013510-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260814184234.3013510-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZNp+zHfw5tcpMV01ubJJOQ+aNmgq1ffjWe7V/22rxKXdJeTUKTZ
 23ieUKvzTfevA76ZHE593Sqer5yjXJlDp+OQnb94mRuTl3zIGTDAXh6vXWS0dbbfi5LJDy2
 z5GXP/TpiHrQyCG1RbmeIp8yC4sOnOEd6Z30hHD8uUef5UCdhC2NllSdXCNId4VpjQdstmU
 2mgIind3oTq9vVOW/Bu0w==
UI-OutboundReport: notjunk:1;M01:P0:+9MsiIKQxnE=;Wp88lprUkpCNiUMBF+VQA4sLyfk
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

On 8/14/26 20:42, Randy Dunlap wrote:
> This driver cannot be built as a loadable module so testing for
> "#ifdef MODULE" is not appropriate here.
> Also, MODULE_LICENSE() is always available.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
>=20
>   drivers/video/fbdev/maxinefb.c |    2 --
>   1 file changed, 2 deletions(-)
applied.
Thanks!
Helge
