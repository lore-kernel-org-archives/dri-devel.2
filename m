Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBC1C4450A
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 06:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23FA10E002;
	Sun, 19 Jul 2026 06:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="k2Vgcppk";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C93D10E002
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 06:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784443879; x=1785048679; i=markus.elfring@web.de;
 bh=lIps0HOHENxVGVif295u+dbj3hNezSiqmWuWj399Zoo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k2Vgcppk99pMmyoHRgavYV1+a8QbT7/xkDXx7gMuGNScxUBqlnFixTvJ9pV4U5Jh
 sdtMZteU7nZo7yggEBF9Ir7NRDM0ev1cHIoH8ejFV0AjI5u81/deMjAwPM/D+yGAs
 6zEVyLme9056LPuhlwATAc5phbmb9TSYOFL30ESwdKU84K1/myfWB6P2icA1ptYhw
 qaDMeD+d+dVkM7tDnX1fkBaT8G+hlxrWoUHvgF1kSfBIuXZsDgAlIrHcZh7vVcioy
 MyVN/0GtApLVX9bwlCyBsFpiaeDJ4VAj0LtRuNnEUcOrDwW5tZil1iEIYgK+D0CDD
 Aq/5OdnvFk+GCC6jow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1x9aHP2q4m-00rOwp; Sun, 19
 Jul 2026 08:51:19 +0200
Message-ID: <7a146cd8-76db-4e5a-ac34-43b19176e509@web.de>
Date: Sun, 19 Jul 2026 08:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition check
 in ics5342_init()
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org
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
X-Provags-ID: V03:K1:+RcRAEho/4XvAHHZdIFvYgCaFoICprnQhkqJYny1wNfoR0QJ79G
 3bw6WEQXdCSOL7CtESywXqtVzRe1arC/XpWKCjBwzZFQV135Het8j/rmtFWpsSzf/NLtJbJ
 ga1Wti1aRjdOGqwPVidvCEFIntI05s/PKcA9Jeqh/Wye8vJ09wqBHyPXOWL2qgpcM8sbtON
 JZLCyg+phiC1usUif+f4w==
UI-OutboundReport: notjunk:1;M01:P0:hn8EbyhDKjU=;fReC3GefOwhHejyCp/3U35jH7VO
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

>> Does your understanding of programming language details differ from the=
 view of
>> SEI CERT C Coding Standard (from the Carnegie Mellon University)?
>> https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-sta=
ndard/rules/expressions-exp/exp34-c/
> My statement still stands.
> Try to find the difference between the code and the examples on that web=
site yourself.
> Tip: The relevant part is the "&"

Which functionality would you expect for the operator =E2=80=9Caddress of=
=E2=80=9D?

Is it applied only after a pointer dereference attempt in this case?
https://en.cppreference.com/c/language/operator_member_access


>                                   and in doubt look at the generated ass=
embly code.

Can development interests grow also according to another clarification app=
roach?

Does &((struct name *)NULL -> b) cause undefined behaviour in C11?
https://stackoverflow.com/questions/26906621/does-struct-name-null-b-cause=
-undefined-behaviour-in-c11

Regards,
Markus
