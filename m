Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4133C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A4510E601;
	Sat, 18 Jul 2026 21:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="IJAxBnav";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58E910E601
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784408399; x=1785013199; i=deller@gmx.de;
 bh=cp+ejSmcreetY3vhsf1Qpsd5Wo0/GvZsLVAHER2EavA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IJAxBnavyOS9ziLS8lz0ZfYzU35FGwPox3zYDMEIdr0YlHB4H33wLmiQ7dK0UyMD
 Bqn2WPKBhrPh06wm1OzdPFEKxMLjol5RZT9G0VBwYHboqyy2aFCRkRez/Zqrd039b
 tFC42vncEpeQvNH1FQthe3WBqnf7KfO6wKoT/HCTeqc7xjVOyR8rM3Z8nNn0lCNHK
 JxIhR64TS7aR8a4vSMB8tDZ1xukgr9mg57ahLaUEcTk8RDIX1+D6lc8aiDczEsoiW
 ToMt+o4PGF4mdby6cq1p4/IpJ1eO3ee8ogxqauJ+b7WHnHWR3exOueh+hqMFFczZj
 Hq/gYIXUV4JLXpBCNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1wXuSV1160-00RcfC; Sat, 18
 Jul 2026 22:59:59 +0200
Message-ID: <5a13f19d-4ba0-40d4-b061-0d17156b1686@gmx.de>
Date: Sat, 18 Jul 2026 22:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition check
 in ics5342_init()
To: Markus Elfring <Markus.Elfring@web.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
 <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
 <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R/mohCcezEUKy5lzI7Qvsaz6oiIepmV7InmVUL9AqT2CJIQeB1A
 54kucwfsPJrBEEiVarkRaTXruOAG0p3ZPRULR1q6Y6W+evh/WN6INzn0Xu6iKh/KrPTARjE
 RLi0EZJbBgxgUsQkSGhx0Wk3jrEyx1fB2rAtlIHG+cSWHLIvuk6dKU9pRqjXFORw3gQ+kZ8
 Bt8RmnXjCKRW+qgT4SGlQ==
UI-OutboundReport: notjunk:1;M01:P0:lfpitq6PJ9g=;E5z/NJir3/8ODhUQ0Y22MFdjR/T
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

On 7/18/26 22:34, Markus Elfring wrote:
>>> The address of a data structure member was determined before
>>> a corresponding null pointer check in the implementation of
>>> the function =E2=80=9Cics5342_init=E2=80=9D.
>>>
>>> Thus avoid the risk for undefined behaviour by moving the assignment
>>> for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.
>>>
>>> This issue was detected by using the Coccinelle software.
>>
>> There is no "risk" here.
>> It just adds an offset to a potential NULL value (which isn't then used=
 afterwards).
> Does your understanding of programming language details differ from the =
view of
> SEI CERT C Coding Standard (from the Carnegie Mellon University)?
> https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-stan=
dard/rules/expressions-exp/exp34-c/
My statement still stands.
Try to find the difference between the code and the examples on that websi=
te yourself.
Tip: The relevant part is the "&" and in doubt look at the generated assem=
bly code.

I will not discuss this further.

Helge
