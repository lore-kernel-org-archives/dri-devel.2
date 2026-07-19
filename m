Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A81C4450A
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F4610E004;
	Sun, 19 Jul 2026 07:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="Bxru4u/B";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7F310E004
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 07:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784445852; x=1785050652; i=markus.elfring@web.de;
 bh=onGitjB9bFK7FtExgujzZ/tghhiAs8wVM+pp7Eyk0rs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Bxru4u/BuVKOBAy5xfaX65swBWSbCsER57NszYsNvd4Vars+eCyc2DHIXbuPkY4p
 ptfT2roi9Ac3wPOSUITa+hao6aF1JYjJUem6WGqEEmlmrKspcF6ygbUodGNVR/t2a
 pOzYclYBtR/g6xVIkIXU8tdJ5JxaUKQ5qNWaM81LzyvSjcINvdR6T4E2+2UGfwhj5
 dgyLg6lKPCLjHFV0Vq02SKV9dhExSxpqBPeUgFn9oWw1rywIkS06Voc98CAX0ptPP
 G3JPoqtDg/cKwZUcW1ohAGUqc+dLyiujPUi0/2SbGOMhaEe0IbjjSrIIBGRIyO2Pi
 0iCGdQur3cG0Bmwqhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX5T-1xSd7x33qP-00d4W0; Sun, 19
 Jul 2026 09:24:12 +0200
Message-ID: <b04526a3-41b4-4eb6-9f1c-3b0858ae3257@web.de>
Date: Sun, 19 Jul 2026 09:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition check
 in ics5342_init()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
 <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
 <550584cc-863d-48c3-813b-3a0cb45d9084@web.de> <alvzxjwBr1gxu3Eb@monoceros>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alvzxjwBr1gxu3Eb@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fE2R2L13o/pJg7zpEQYmGTif8wF3FkDoenvhwOqcOtNreUMt1Zo
 8iNI9e54ia/kQ1JfvhgFpEmBfQmmVSi1P5ptSxKPgUW/vq4kkaFzS6RWjpcLObSHVZOfwT5
 1gpd0fk9GXPmbBen4KvHwA8+ptT4Bx4c9VWzZ0yaCOb+z/JhCjgsjL0ZA7by69WLRjU0F6S
 BP5wfQVouwCDnqC4s8Rqw==
UI-OutboundReport: notjunk:1;M01:P0:PYo/cC2y05k=;xScmbihYUoLNoVXvA8rimrh4m8K
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
>=20
> We recently discussed a similar case where several people told you that
> the "problem" you fixed wasn't actually a problem.

We came along possible adjustments according to an application of another
questionable sanity check.


>                                                    This patch is in the
> same category and your reference doesn't match the code touched here.

Will development interests grow if bug reports will follow by further know=
n
source code analysis tools?
https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-standa=
rd/rules/expressions-exp/exp34-c/#automated-detection


> Please stop to absorb maintainer attention with useless stuff.
Do we need to start negotiations for allocation of a corresponding CVE ID
(as something happened for similar control flows before)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/cve.rst?h=3Dv7.2-rc3#n16

Regards,
Markus
