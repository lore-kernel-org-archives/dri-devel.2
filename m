Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A6606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kwI2FvL+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C0410E624;
	Sat, 21 Nov 2026 17:37:19 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FC910E624
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 17:37:13 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795282632; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:g8bYUhJ6mbdMRNL+mxWRw3cTZEXM
 pwYVbhlzuK9nnOxeFXSGCiH9aM02LSyjXerp3s2Mn+Gs9Wjn4Z0BpyM0o9Tlf9wPo9ZpDPcJMxA
 mbVd4R3wyrNhxfaLMSoR/hP1q5ibrPzkWCOc+MtyFOiRYOS8Z40xoHoggKXmHEaqxwJkA8LNO02
 0pH2MRcD+g+Ukx6VBGGwi+B8qlf0BHvip9H9KJIC3skiwrNGJKP9WnnCCJhpxX1bwJWXWmUKZOt
 5n1NN8R3ZC3SWOAdU5Vwi1e24QPcDUtxXrs/K5yejm5wttRWOQ3DxF90jpdwfIe4DA2B62Obx2W
 +AFDCaLYK20snw==;
Message-Instance: m=1; h=sha256: k/5qBPnDXhxRgieaDnglhKEk8KbNFMc/u0ZorqhDwLo=:
 i1eUoTox/JI1ohFODw3UHeIqEZzHukHczz41/FiybPY=, sha512:
 E+8Y4Ni8QjcADV6f1HWtfevKZscUoJJviu/JDJlirDcTqEaTTihp43A5x2YOVYORR0OvMVmeyLjNYv+H5tN6DA==:
 gj2kezNGu9B02hY/QVWPz1wkp5+IxZi6Cv2YOpnUHDh5brXQ6mnQ4utk2b39EuVdOpcJHEghf2c7kj/8HFqIEQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795282632; x=1795887432; i=deller@gmx.de;
 bh=zYggfY97uOb+NW8AegFRAQHlqtkbZ26hOb970Ph8/VQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kwI2FvL+kWBhUe3+uqEDCFz3QhyRFXciSLCTXwYnwb8K3anfYlJbEMfRsuUKD7K8
 7IllZed7VVtMd8cbC/wWJbqOZIhASM0XBdwIR4Ap2TGyDgL/VP1fRgBlmhDtq242o
 4Tme7m9r/6o+GbWqgxhgpd5UDG48getcAZfci/p67h/1LtWY7rObuHctI9ornkzVW
 SPtUzWvkNlt1i87Zr5yaFxMwd5NZNnFq5wD4HPd6iDK//Rh4a8SOTecWoJwXaSOIo
 CdVEM3KV4iKRwu3Ejw0/eJrvm1M1Fzczj5VPhNmT9L75WYAEH7t7WzeBncs7LnA+i
 vAMNBaHQ/KpkcSY2Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1xd3Yv4BCg-001SMc; Sat, 21
 Nov 2026 18:37:12 +0100
Message-ID: <8c261690-a840-4713-905b-51b6dc51aedc@gmx.de>
Date: Sat, 21 Nov 2026 18:37:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] fbcon: Use unsigned char for glyph data
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20261120115215.52092-1-tzimmermann@suse.de>
 <20261120115215.52092-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261120115215.52092-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zpdv35lKqgmgLrIYwDiKz6OqMqd4iVJqVpfZyUCcMc8yn33tK8A
 4fd+wdfTaWFZCF9GJmeJmyDo6cEgH5p/9gCELnN4M51PJqj9zv/YtxhCVhIwTWE9brXA0XE
 hsneYtoc96TZ3HWyPaP39eWpjA742Pwo+LZrHyXLjm9FjMLr1wy9QQ3IM2rt65pni++TV5d
 sIo9voOAsKZB+E0HvfFzQ==
UI-OutboundReport: notjunk:1;M01:P0:p8Ce6VE9VcM=;L55DRmwfMU7PO+XyzevLSWdTV2L
 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
 Nq0MRFrjHrrlq2YvZwmGfiJwHVGY59D/+r8FA==
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

On 11/20/26 12:49, Thomas Zimmermann wrote:
> Represent glyph data as unsigned char, as done by font_data_t. Convert
> all related code. Also declare source buffers with glyph data as const
> because internal fonts reside in read-only memory. Avoid writing them.
>=20
> We still use char for glyph data in struct fb_image. The type is part
> of the kernel uAPI and therefore cannot be changed. Fall back to type
> casting in this case.
>=20
> Destination buffers for font drawing are still u8. This is framebuffer
> memory provided by graphics hardware.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/core/bitblit.c   | 25 ++++++++++++++-----------
>   drivers/video/fbdev/core/fbcon.h     |  4 ++--
>   drivers/video/fbdev/core/fbcon_ccw.c | 22 ++++++++++++----------
>   drivers/video/fbdev/core/fbcon_cw.c  | 22 ++++++++++++----------
>   drivers/video/fbdev/core/fbcon_ud.c  | 28 +++++++++++++++-------------
>   5 files changed, 55 insertions(+), 46 deletions(-)


For the whole series:
Reviewed-by: Helge Deller <deller@gmx.de>

I've added the series to my (upcoming) for-next git tree.

Thanks!
Helge
