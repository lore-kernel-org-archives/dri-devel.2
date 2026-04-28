Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49324FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A659310E32C;
	Tue, 28 Apr 2026 12:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="neTM6012";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6612D10E32C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777378795; x=1777983595; i=deller@gmx.de;
 bh=5RzPIji8EqdMzLohsKgC3B+xnP6oDuG+qf2TyNGIpNo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=neTM6012yZzQUn6//E6vrZmA4cwgM7x9NZYQ9YorCIlifWOdodn9+0jq82P+vORR
 mnKCwJfdxZHzSqDoO36bZGXKoJWKQmnbVghKGBE7IeUKVOAHVWITeutKVNHmvLN28
 7/R4jPtS2loEzlBu2ShLg8gDiw81z0QY0SL4/xhGewattEK5Feo2wpnmAZmNTJnZ8
 n1my80cSGHT6iZq2lg6zgOo1VUQeH9/3MuzvoqI+8zoQpUOUpCX/VhgQeHg+p9pEv
 P32mrS1+aUZZASNBTF/DiugJfVdQqnzRrJFzYABiREGwdCHGI42OxCa3Odo4DKLLw
 h8sdw7SE9C0V/QNcew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1vfu1s0ij1-00nF5D; Tue, 28
 Apr 2026 14:19:55 +0200
Message-ID: <ecc5e3c3-5afd-4c14-914c-8714b9278fa4@gmx.de>
Date: Tue, 28 Apr 2026 14:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/fonts: Fix bit position when rotating by 180 degrees
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260428083025.63663-1-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260428083025.63663-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pMF3H5Nh3oE/+KqTXLFCBrEnirZsM/IFn0+oa7KNZ5iJ4KtgsmA
 iQ4lYTAegulCno6+HXpyj6IwSETOS4RNQse0w+GJ5qQ3F7pko/ALPtQ/Zus2FjSgDnwRqCN
 U7n08KJXSpgXRtjVd49GDCdO02Cll5bYnyCB68YCieu22pq40fM7y6Vgig5B9pQGeRm6o5G
 Pht1eI2bnjdaG8+YPDGlQ==
UI-OutboundReport: notjunk:1;M01:P0:R/pygIvY/18=;u1CH+SdIY7zl6X/Yz33PV9zKXh0
 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
 qN1ZC3UIced4XfnD9n1oHz5Gq1pcOmOVpZvE=
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

On 4/28/26 10:28, Thomas Zimmermann wrote:
> Fix the horizontal bit position when rotating a glyph by 180=C2=B0. The
> original code in rotate_ud() rounded the value in width up to a
> multiple of 8, aka the bit pitch, and calculated the rotated pixel
> from that value. The new code stores the glyph's pitch in bit_pitch,
> but fails to update the rotated pixel's output accordingly. Simply
> replacing the variable does this.
>=20
> The bug can be reproduced by setting a font with an unaligned width,
> such as sun12x22, like this:
>=20
>   setfont sun12x22
>   echo 2 > /sys/class/graphics/fbcon/rotate
>=20
> Without the fix, the font looks distorted.
>=20
> Fixes: a30e9e6b018f ("lib/fonts: Refactor glyph-rotation helpers")
> Closes: https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch7=
-20260407092555.58816-8-tzimmermann@suse.de/
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   lib/fonts/font_rotate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.
Thanks!
Helge
