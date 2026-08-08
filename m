Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B15C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0765410E066;
	Sat,  8 Aug 2026 15:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="SWlH1wFu";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8678110E066
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786202228; x=1786807028; i=deller@gmx.de;
 bh=LiCUaE5T1J9lQiLvuvh8UW35V68XRRHIArQyfw8kC5c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SWlH1wFuwVAU8w+DJTDGpM63THTikGGLLRFzh42NknbYTpCKtARvx3UD6a9e0yBP
 6kbHUZe+nccR8k3LmCPRg3T9jjz7o9dKipgchLRIxn6dLQnqxK7kPu3Cgf5hCqJc+
 auMwN4EEfOltU3c3HFIFbnXIcg5qD74URpKT6xwOKqj6IcrFbPQDSU9Xz0Y1JS5u1
 DtVsyiOGYDH2y+X2mhSe1PqM6K7nLy7urYv6IwMeDVe6QB3erHXvrzN3eT9ZkgxxC
 gn6Z0LyxgbXN6YkiYEQmVBazqUuyeErpHa6ZaSGKHu4WdZ3CNOcHhdeT4tqs5v9BF
 rnZedhPxJOaMpPAu0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1xJZ9f1ZoF-00mfUT; Sat, 08
 Aug 2026 17:17:08 +0200
Message-ID: <8097aa95-45a2-4a8e-bfb0-24e644576d69@gmx.de>
Date: Sat, 8 Aug 2026 17:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: clps711x-fb: Remove unreachable
 unregister_framebuffer() call
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260808144114.77505-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260808144114.77505-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v16MpcIWrZICJBQs70gXR/ShFfpunGNakOaTVHdG7oBo7GkY+ZY
 lcUIq7aC8YShxYRU9/2ZRZqCeMNqyqKqtJVshQHC9mRtu1UTXyobw3Ub9bDWd+qGrnKZapC
 IdGjnCs8GxJ4fpKegw4NkarRmrGw9+tsNzzoofEQWD5mQSGFKEFBkQytzDNBTxMgYzBMB8S
 BR1gijsTNEnN2on2S+wIA==
UI-OutboundReport: notjunk:1;M01:P0:no8Aa0WzXm0=;Ehc9yGeskGomnrVIkNBjJiVVVvW
 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
 7sIy4OQ==
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

On 8/8/26 16:41, Karl Mehltretter wrote:
> The unregister_framebuffer() call in clps711x_fb_probe() is unreachable.
> register_framebuffer() failure jumps to the unwind label, while success
> returns immediately.
>=20
> Remove it.
>=20
> Found with Clang's -Wunreachable-code.
>=20
> Fixes: 36462ac193088 ("fbdev: clps711x-fb: Replace check_fb in favor of =
struct fb_info.lcd_dev")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>   drivers/video/fbdev/clps711x-fb.c | 2 --
>   1 file changed, 2 deletions(-)

applied.

Thanks!
Helge
