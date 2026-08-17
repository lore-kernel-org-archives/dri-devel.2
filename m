Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D27C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447A410E3E6;
	Mon, 17 Aug 2026 09:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="MObPZKY0";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E7C10E3E6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786958436; x=1787563236; i=markus.elfring@web.de;
 bh=Da/aAndga0dQhjoefJG6gAAFX3CTUe3zoKIET1mqGmQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MObPZKY0lEl3dqwmBmJRbCQePfWcE3MB8OCKeaCWtg1440/QdbQT0tngE1Uqg5OR
 NSDJgA3i0HXDBhQmMQBAA0ulaYZ2mQZ6LqPmGjSXpKEEpFo98qcGPuiSeyDZIVqpv
 SjHn8OlO7ZC1WuW1Ojc0UKUM2kEFlDfrx1zteWZYa4x2wPk7PLOfE522N9jcLOG80
 eyRE/PUtftVc5R7GHNid1b6cmy/fjtoeyise49DHntqgzx6d4tthJUKTuvpLRDrZ6
 Dj0WjfAyT9bbr+RvzhdnEsgu9Vtr4JO03FSOPct608i1+UVyoM7DO6qBmo3Ekbcl1
 94/C/dgsHkRc2yg/yA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1x4jCu1u9Q-008hyX; Mon, 17
 Aug 2026 11:20:36 +0200
Message-ID: <fbc4211c-d98b-458e-9dd6-3c3ec867df3a@web.de>
Date: Mon, 17 Aug 2026 11:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Triet Hoang <triet.hoang.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260817072045.876042-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817072045.876042-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bnXHQmAPVOusXq6jLiIxpw/99y59MuiLhQo6Dd95eM04zqfLOjN
 dSzvxfWCWl7AVuUhNSgD81gFnP4FdL97tmQL+At27g4xJSg3s7IOXIOFb/NIBBrDZDR4+ml
 3VuHjhYOBceEQDe/SneqdH8YryjGKTfyf+8UrmNIvVvmZJsQHocUSUnhETNZwFwxuGiAOEX
 R1nTBF8coIrBnSgNH1Pug==
UI-OutboundReport: notjunk:1;M01:P0:OrkxXDKSgSU=;6//V3f6xZNiskWAK3+w8nu0lbjy
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

> Check the result of kvmalloc_array() in rocket_job_push() and
> kmalloc_objs() in rocket_job_open() before using
> the allocated buffer.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n669
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc7#n34


> Changes in v2:
=E2=80=A6
> ---
>  drivers/accel/rocket/rocket_job.c | 12 +++++++++---
=E2=80=A6

Please move patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n795

Regards,
Markus
