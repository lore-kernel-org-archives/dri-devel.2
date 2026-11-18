Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE147606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=PEtIbn4T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B75F10EC29;
	Wed, 18 Nov 2026 18:38:14 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6875010EC29
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:38:07 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795027086; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:V6h+rUhzj5lrZ8ySh5ew9XL2cVF2
 vljXiweR7+I9RCsT5rum9GmZvCIwTXWnE3a+x1Rk9Vv7dAG1BZcQizDUDc6ndN4nZpqKat5Jn0R
 ieNJ6jhCJ7RY1PtdZ2qVDqefqUPyb8Yq9nRqWN7yvCxeU4gSiahHk92u4mhhxYpTbse10quPPqT
 VrwMeji9TYShUJBklNOnbsGSZ64KqoDwnawHKp2hgxIYaS5zOhF6Q2R8zx+IoJG3eMW+p5xtvGm
 gzQTK5+y1Olmt1nijvJ2pxvBFWP9N3RP9o2vZo2n75LL5b9nNpH0g2pe9IZ3ZZz9I3X/WObrL9z
 DRu9XHSis++vgQ==;
Message-Instance: m=1; h=sha256: vZqjGBqbe6s+2YnhwJkxbZnR6Uuc3eEmbAT79JdKnR0=:
 VTzi9DKM0oaZbfWWhKEfVe5kAE61ohwNnh65ZuxF1E4=, sha512:
 t4lu1CHMCIrzgjRvQ2cdn7sL2tNuVrjbU3Z+15MVkG6e8sVEpBcdNwYvLSSJOzFkan5FsQtU1662vv3ok7GDWw==:
 qm5G6pQ9ohrZYTo/ztelG7YPar9d/t5XY/xFU/l5c8hnA8VAxK7qha5FtRyHqQWK9xhIM1rXqmAiGfNPq+mJFg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795027086; x=1795631886; i=deller@gmx.de;
 bh=yLJTxUNKFMg2WoF9M7+sj5CM6AojWeVvApuL5kbm5R4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PEtIbn4TAl4TlxBbiNj8lUKVamNF8NHFnkvtWUbcYT1KrHwayxng/iDj0omhFOMo
 r7pyZVnHxtiQuc3GiOoIWhycvB2nDABNXqqqEcqFsjA667QijcRRQQ4X9sf7UfYke
 wShXoUCIyZ/erf41pdx/sY622/f79mauZJYgPuCqdjpnVAD5ho3IbfW6rJ/wR7rsN
 tMTi0pFJFuX3aklzdPJYXUf9MkFvxhPDByx3MShrnjhBS12b2YrphJQe+dlWmeLjP
 Kk6oksJF/LcAY4KBgD0zX7lKnTPiTeh0ou2+UYjjrln705h+Pj0T7LeLrrKv4tmlC
 fLwGuKD1ki6QsOnWYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1xNh4R3QaI-000MHo; Wed, 18
 Nov 2026 19:38:05 +0100
Message-ID: <248e818d-8af8-4068-92db-c06c10ce6e58@gmx.de>
Date: Wed, 18 Nov 2026 19:38:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperVidel handling to the Falcon
To: Miro Kropacek <miro.kropacek@gmail.com>
Cc: geert@linux-m68k.org, schmitzmic@gmail.com, lilinmao@kylinos.cn,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20261113005616.402721-1-miro.kropacek@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261113005616.402721-1-miro.kropacek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:drJh1brGcaue/N0yn5FD7RJ9Q5Fv2nn7vUEhC9KYL/YPA2cKE7t
 4+wHYTIZ25U/tZDn8hNhaRFFT7nSLc52slf+KOeJYzoJIGqsUPz7c75h/yweeLS2afjY3j3
 4jZ6iRjAVDwgpf5pHT+C1VvAcgqU4Dx28EC3R17NVb6fgU4dansrexnvCEpV+vtCSbyxHYt
 9ua2eAx0BXRdB6KjuF3TQ==
UI-OutboundReport: notjunk:1;M01:P0:5yJhME/bSZo=;Bn6f9BqG5nkTqh5+VdH+ThHleEz
 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
 QKC69VU5oFRs4rhT8QS7hf3+c6dAPgE=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 01:56, Miro Kropacek wrote:
> A framebuffer at 0xa0000000 or above is taken as being in SuperVidel
> RAM. A TT with a VME graphics card such as the Nova has its framebuffer
> there too, so in 8bpp it gets the Falcon palette registers instead of
> the card's VGA DAC, and in 8, 16 and 32bpp the SuperBlitter, which it
> does not have.
>=20
> The SuperVidel exists only for the Falcon, so check for the Falcon video
> hardware as well.
>=20
> Fixes: 51df976c3268 ("fbdev: atafb: Add support for further video bit de=
pths on atafb:external")
> Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBl=
itter")
> Cc: stable@vger.kernel.org
> Reported-by: Christian Zietz <czietz@gmx.net>
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> ---
>   drivers/video/fbdev/atafb.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
applied.

Thanks!
Helge
