Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D6C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 20:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C5410E600;
	Sat, 18 Jul 2026 20:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="KrOiHdBl";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFC010E600
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784406876; x=1785011676; i=markus.elfring@web.de;
 bh=PXgu0JgpqPwlJP549fXUF7cLSiyPSlQqGlsA3Ua5aLE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KrOiHdBlqXDbfd0pBP92DlMAkW7Y241oITDRAuVBdr+xkt3tddO4OzdT0WzrEEYX
 rc6ghwxcDj+JXFSu7wi7czlnrXGb3r+1umUaLdcMQANy2tmh8rQFLzXDl636zlsTK
 NFFwVa3LMIYzxCEoG90K0B85W1Nj034iOviUhaE9U/iMt3v2mwdRrb6+lNfD2UCny
 LumHyyEvInBadKV8wX0fFk4uSM8cLN0Djqo8TLjc6XVNeXHrvRcScj/epkVb/Fg/W
 46UtFEsH5jFT/p0S3uMQ5e31VuN7KWuUGll0MlrDqV4CYJRd5ymdEg+PkYp+j2Ean
 KBs24Dbd9+RPCBxRKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrbl-1wd77e3qNR-00OuoZ; Sat, 18
 Jul 2026 22:34:35 +0200
Message-ID: <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
Date: Sat, 18 Jul 2026 22:34:33 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A0JDhCOZFbZj3e6d5pI5/Y621F3JtcnTn7A+NN+hbJ0Sbonqr1A
 1re8gbuScjX4QHxCHeDJDGHzCcC2g59tkSUdOj7W8VsZdQGOuJODjMoOge5MJhDmLFLhBTl
 If1nxCK/Nl6cIk0O9eA2sOoans3iGx3zHlTgrytdUC/NR+LCA1EivkRUJb9G0uLEZ+8SgvP
 1qF+YYwzMGB0v/hfzXswQ==
UI-OutboundReport: notjunk:1;M01:P0:fBUEkqMD+IA=;FhbpjlML0w3jB9Rna3hLGPt0S5K
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

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Cics5342_init=E2=80=9D.
>>
>> Thus avoid the risk for undefined behaviour by moving the assignment
>> for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.
>>
>> This issue was detected by using the Coccinelle software.
>=20
> There is no "risk" here.
> It just adds an offset to a potential NULL value (which isn't then used =
afterwards).
Does your understanding of programming language details differ from the vi=
ew of
SEI CERT C Coding Standard (from the Carnegie Mellon University)?
https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-standa=
rd/rules/expressions-exp/exp34-c/

Regards,
Markus
