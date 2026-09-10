Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3F5C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6141210E323;
	Thu, 10 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="IrP24G26";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0EF10E323
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789073561; x=1789678361; i=deller@gmx.de;
 bh=n2nEvoeCUMsbJxYznaoiRp8eMkeLEENZoc7VuW9yLsY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IrP24G26u9908JLV3wz2yHxrsmUGyUm6CLT09zqZoz2BV0tlBg0tP3lqxF0aqT//
 HxYXQLvZ1R8lRp2ZOiPa6HD9MuH5gtD5GdIgixbSrFoRONP/C1iWykAFZFaplM8kt
 OakmulJgBLpvzABCx3OFX4PM5aYA6cHmXnYtHEzdER4/EANQLV5Kusxjc/rWXULjc
 BHl5AEu1W4XlYIvFQdjNvnA6QYQSwa4eTTKE8K/Tqlw+6Kw/AsAuv/ktT5MD5Us5i
 +pkLrUEbR2R6PTRhGmbzqyqmp8YIhnq5ewUNhov6HLORBayUg+dpD/SVvoSJ03dRp
 0VpUpsqQFAAzLbw1IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1xMzfS3qVC-00LTLf; Thu, 10
 Sep 2026 22:52:41 +0200
Message-ID: <8cb3dcb1-a654-44cf-b885-8855ae7798ae@gmx.de>
Date: Thu, 10 Sep 2026 22:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: vfb: defer cleanup until the last reference
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+c25629c98ba36ebe@bugs.sh
References: <20260909191022.847295-2-bestswngs@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260909191022.847295-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGX1Fj5uJvaIJN4nzoqNvgMo6ATr4j8fHvGPfg4FxbMhxVvoh9f
 0qACugkNeNOMp/iWjd12Hwt8F3p6Qsq+VfEh2edMdo+M534F5k93P+O1sKhj+0p+F/9MyCq
 TUEeDfcVksbowyjfalGqtqnNGqplnpI7QdrzcArzrgSFTSdgSI5t32upkq3hrp1ZzN9BOR2
 9Z/VdwIKwDccBmWn5ARgg==
UI-OutboundReport: notjunk:1;M01:P0:j3QB8mty8+o=;2SZ1XCkMzOj4xwY1x3N470r0UG+
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

On 9/9/26 21:10, Weiming Shi wrote:
> FBIOGETCMAP takes a shallow snapshot of info->cmap and performs the
> usercopy after dropping info->lock. vfb_remove() frees the colormap
> immediately after unregistering the framebuffer, even when an open file
> still holds a reference to fb_info. A concurrent driver unbind can
> therefore free the colormap while the ioctl copies it to userspace.
>=20
> KASAN reports:
>=20
>    BUG: KASAN: slab-use-after-free in _copy_to_user
>    Read of size 512 by task poc/125
>=20
>     _copy_to_user (./include/linux/instrumented.h:129 ./include/linux/ua=
ccess.h:201 lib/usercopy.c:24)
>     fb_cmap_to_user (./include/linux/uaccess.h:230 drivers/video/fbdev/c=
ore/fbcmap.c:211)
>     do_fb_ioctl (drivers/video/fbdev/core/fb_chrdev.c:114)
>=20
>     Allocated by task 1:
>     fb_alloc_cmap_gfp (./include/linux/slab.h:973 ./include/linux/slab.h=
:1290 drivers/video/fbdev/core/fbcmap.c:108)
>     vfb_probe (drivers/video/fbdev/vfb.c:459)
>=20
>     Freed by task 124:
>     fb_dealloc_cmap (drivers/video/fbdev/core/fbcmap.c:151)
>     vfb_remove (drivers/video/fbdev/vfb.c:489)
>=20
> unregister_framebuffer() drops the registration reference, and fbdev cal=
ls
> fb_destroy after the last put_fb_info(). Move the registered framebuffer=
's
> cleanup into an fb_destroy callback so its colormap and screen buffer st=
ay
> alive until all file references have been released.
>=20
> Fixes: 5e266e2e0e19 ("vfb: fix memory leaks in removal path")
> Reported-by: co+c25629c98ba36ebe@bugs.sh
> Closes: https://lore.kernel.org/linux-fbdev/f2Kf9GYn1lKR5S1dbvGVtykMxK1R=
lgP5z8sW@bugs.sh/
> Assisted-by: Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   drivers/video/fbdev/vfb.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
applied.

Thanks!
Helge
