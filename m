Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF6606A332
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=RmyqIRVA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B34B10EF4D;
	Mon, 23 Nov 2026 16:06:23 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B78E10EF4D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:06:16 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795449974; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:f2JPxuVtka2LtGPDbH+B3WVWuIEw
 aqp98FRnqJtJQcCwwNyYedOHn2dRuk+4YUHbsJVjRBPWIWyM5hwkjJNm/OGBKVdFDkva944aDkv
 Kue5jrPSzs5sEVxtZx8ZSNz5Gkj81oAVabvkNHHBoQtO887cvA5z76srZUPkoiVpvAxeH1zPXS6
 FTEPjtl8x0ZZpATUNbn5JpLlS5HNEkZ4evmw1jpGwMXAl/gtlR98pm+EmnZ3+F+7GyPa2XohG6D
 ST2DZjOFBOZespR+T9XgaqljG3z6P9TbIl+oZBxOuz8bMLOn8CnkLRulT/F7M17f+sL2PF0grpM
 laLYuSDVQkMh1w==;
Message-Instance: m=1; h=sha256: 8gOvv4PmWi6nSR0KcMqzd7R4I6NEmVpl+UNksq7vMt0=:
 wZfpaLfsQABbgX9FQiKxvFBqtv6nmva9GcSZkDc5IzA=, sha512:
 UIHxwIJkrsDNWL0EujF3IwK3dV/yfm3gQeuIIKcKGhlu/YNM9EITk8Sp9whm9W8lVGX5x2iKwa6Azk7IXkVCBw==:
 db3joJIIoRZ1+aYGBz1BCVONpq/xSb23S+hvy+mEG1y3Dqih/Sx9g9eKd64OU+l/v/JmqP2nAzgacvJ7XEAijg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795449971; x=1796054771; i=deller@gmx.de;
 bh=kQgn95AplkCvx919iJ6NA7ihA0R2Sn6ZnLUp6g1wP28=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RmyqIRVAY56ToKJSc+l+QDLNyOwqRL3GkD0BxL1Y6RFopZt/t+dNG+wEkGDhsW+E
 vNR2Yy5RPC8R825uA05rEEqLUFbVZwTcEXZ/hf6Fl7LqLgmGhpiWWTX5qkl0u3Rpz
 jnepwbDfXboOM3tCipgC8DjrZCr5SpweVp89qSB6gB8gbQaR0yKyUjGumw3Krj9Uf
 uzCQEnTRFqOod7V6WB261oDpScOoQEQgPiMxo8tqbo6CPei0r8iwTBfgrPQGksbMM
 eOSpmM8y+d9GhNCEtXaZ2TC7kabD8q/4Ndeuj5IIXmpyiHJn+IZlWEB1tQRIR8RpW
 KIyHt91rUUCD41Gz4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1xW4mn0J74-006xaj; Mon, 23
 Nov 2026 17:06:11 +0100
Message-ID: <669927fe-4a70-432b-9ceb-dfc920af9285@gmx.de>
Date: Mon, 23 Nov 2026 17:06:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] fbcon: Use unsigned char for glyph data
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20261123140554.1129792-1-tzimmermann@suse.de>
 <20261123140554.1129792-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261123140554.1129792-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jR6cl9R5V6dzukoUZmE4IPrBH0zLSuMsj1HHUD24TS5CW/x2u+n
 Esk0J5gw/Z5+9pbbpGDHSBj7B+pazUduVqVb50uP0hDOTv2rkJBTlbbjpT5s46nQX4J+wkP
 lkZBRe/APzXQ2mXW8QG01TSh1WGAVlzjxJFMniYtYdrXsUYAAOpKGnDIqiCHfLT3jJ9MGzF
 /1VyxuNR1nRV8nmTB+C7Q==
UI-OutboundReport: notjunk:1;M01:P0:1+TLvExPwKE=;ld2Xu5qYTiAFkPEGs6vjavQhYAf
 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
 +24BjpkndPnK/M3KmoTqOrF1y2YQ==
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

On 11/23/26 15:03, Thomas Zimmermann wrote:
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
I've replaced the series in fbdev-for-next with this new series.

Thanks!
Helge
