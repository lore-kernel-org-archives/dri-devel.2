Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CCBC44525
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F8010E158;
	Mon, 20 Jul 2026 09:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="ScmwHF42";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBF610E158
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784541146; x=1785145946; i=markus.elfring@web.de;
 bh=j+GFna9NRb2HuBvQJD0oUM/Zix3uuE8dlGpVy5zxZdU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ScmwHF42c5aisGOGN3N9qaLT8tKNm0mcDRjSbhVtq+X4TyQc+RLXI1CXRG2yKdQB
 IW7Pwhac2w7ZsycgjzniiWkIGphYkwSIklY9sG51/JiJjtMYFCNCT4W6Uxburjp9o
 z1i4Mx6R6x/ZGP1uE3d0wfMmp71pY81H/Fsm2VOSNllpXDNGO7Z8bUwCPffvg8/Wk
 MCUrMU2VHEcKLDd0E7wOm8xosZFDXMXAU0GfQc2og+PksjiPaqjSLxIc8QuFRYOPU
 xNXdgswsMT24WiU0AEtkj7qbNbziVGH5pT1e+MKMqe0pMEWPBFs5EV1VSQDrQNIlg
 Pj9FsXDo9r+MshLwGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZjd-1xHDs72MHd-00n4f6; Mon, 20
 Jul 2026 11:52:26 +0200
Message-ID: <e624499c-7fff-4c77-8f4d-0fb8c0d0814c@web.de>
Date: Mon, 20 Jul 2026 11:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition check
 in ics5342_init()
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
 <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
 <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
 <5a13f19d-4ba0-40d4-b061-0d17156b1686@gmx.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5a13f19d-4ba0-40d4-b061-0d17156b1686@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CMHwCFXVNXhc75th/O8NH0ABCwkICIAYrj8Oh1kjoXjgdxrS6aQ
 vL38EbVABf3H8LPIFc64u/rGNLVnpaTpOcB2i07Wpuv6wyHtMQo3B9U7JiYRXQRclabjYGp
 x+17MAt8atlNS4LW3NGzzEo4T2GOZi215WbNSnsze+msZ3fW6G3zN7vkNhPrnz8nfGasep6
 UOCjPJAf1SvPqGHmVqgjQ==
UI-OutboundReport: notjunk:1;M01:P0:JQOQTvrWW5o=;zL8YovSRSPMCYZbSe/CkuYIIZzn
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

>>>> The address of a data structure member was determined before
>>>> a corresponding null pointer check in the implementation of
>>>> the function =E2=80=9Cics5342_init=E2=80=9D.
>>>>
>>>> Thus avoid the risk for undefined behaviour by moving the assignment
>>>> for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.
>>>>
>>>> This issue was detected by using the Coccinelle software.
>>>
>>> There is no "risk" here.
>>> It just adds an offset to a potential NULL value (which isn't then use=
d afterwards).
>> Does your understanding of programming language details differ from the=
 view of
>> SEI CERT C Coding Standard (from the Carnegie Mellon University)?
>> https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-sta=
ndard/rules/expressions-exp/exp34-c/
> My statement still stands.
> Try to find the difference between the code and the examples on that web=
site yourself.
> Tip: The relevant part is the "&" and in doubt look at the generated ass=
embly code.
Do any more code reviewers take another look at results from undefined beh=
aviour sanitizers?

* https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html#introduction

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/dev-tools/ubsan.rst?h=3Dv7.2-rc3#n6


See also:
https://stackoverflow.com/questions/79662603/why-do-compilers-not-warn-abo=
ut-this-null-dereferencing-even-when-they-detect-i#answer-79663272

Regards,
Markus
