Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08871C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 19:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AA410E5F8;
	Sat, 18 Jul 2026 19:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="uRXFq8aU";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CBC10E5F5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784403232; x=1785008032; i=deller@gmx.de;
 bh=gNhqwx56AnSHGfbipTfNdbLbLM2PGc+dL5OS9Nu4LL4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uRXFq8aUNwMGkvjCzM9nH/BYZJyeBFmzqXeh4N4E6s1gp6Fdf8R+X7X5wi+smRrH
 w5OHwpjVghZ1mRkco4uvKavYJqeocGwxv1EBIIBpKHLL4yIMKM88tyAlUFdnmVueP
 QF92qpFLDj2OFWpwZn+YxQGuNDnFAeO/l61MNfdne3FvnR1KLwFnmEXmfpOBs2Q3i
 7hq8Z/bKh9pHnCcagclj/g9L62J4/OoYQi9tQRl+sWR2H/GWtRhOnzx358dyfLSrz
 Yi30M6O12dMkBFsP7ajo0EOZlOfJnJK1q7bVmujLNqxn1bU/3giQrlbXEyCg2FxEq
 MrWKH6quU2IuM61UOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1xRQMQ2ljS-00ihKR; Sat, 18
 Jul 2026 21:33:52 +0200
Message-ID: <10cfb695-a662-4eb7-924d-472502ec9d27@gmx.de>
Date: Sat, 18 Jul 2026 21:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: pvr2fb: correct user pointer annotation and
 sentinel initializer
To: Florian Fuchs <fuchsfl@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260713101638.600333-1-fuchsfl@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260713101638.600333-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qIwTxSlQA6nFTCV6wSlxMraauAGYOazMAFu/iaFzE7nbcBzD1Tz
 p1NGCAVlgpWhEHi3R2yNYf9tx4hXdoS7+QpsJH9YXrVgGDra9QOujyXz1323iEZ95gzk3lN
 vKrnfJUfPpai3/hDzRsyF9JwnY4wCOiAAutsNqTzMeiVuqMPal9GsHXkm0VfS1CMU4+pWV/
 tC8DiLr94cWBOHCeRajnA==
UI-OutboundReport: notjunk:1;M01:P0:eaBqmx+4v60=;VrtBph418TuNJdgThiccow1NxTw
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

On 7/13/26 12:16, Florian Fuchs wrote:
> Add __user annotation to buf, as it is passed as a user pointer in
> pin_user_pages_fast(). Use an empty initializer for the sentinel
> board-table entry to avoid initializing a function pointer with an
> integer literal.
>=20
> Fixes: 5f566c0ac51c ("fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR=
_DMA_CHANNELS")

I think this Fixes tag is wrong.
The problem has been there forever.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607131247.fpQ6eTc7-lkp@=
intel.com/
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> Not sure, if we do such changes, but as I received a test robot email, I
> leave it up to you all :) (I also compiled and tested the change)
>=20
>   drivers/video/fbdev/pvr2fb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Patch applied to fbdev git tree.

Thanks for fixing!
Helge
