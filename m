Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FBBC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6268010F007;
	Thu, 20 Aug 2026 11:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="CJO0Qnjx";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1532410F007
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787226957; x=1787831757; i=deller@gmx.de;
 bh=ZXueXN/MV69NRo6g2ZqcewBkd0pdSu0E9xYj8tX39Ko=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CJO0QnjxN/wHxFbXkuY3UQhBVSQuDjZfwvJ1DGgq0wGnc62kfzKwvJQ0N0TSZ3+k
 lfiMNG08fE/ay5eQN3c/bdFWC33q42Ot4F7KufaV895uwstDYVmWpXQbG3JoBF7GN
 JoAxnqvp+xQVZcEdM8OrJLxfb3F+YYS5oh7O63M4/AbFW2zdYN2iPErDDglYbRqTn
 7gOT14RnTU9X8NmXSYUp/eIwiwKPt6YOWb/NEkA07ovU9A5aLzgN7U16Us2UcicfH
 AC7TN0IStQSwv7UkqP95fE0WpJbo3T+G6TCnm3BhIEcix6efDZ82s7GviGV9+NHdU
 +gczJoDsu1u4S6Tm+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1x34qt0l1W-005ZtQ; Thu, 20
 Aug 2026 13:55:57 +0200
Message-ID: <7f281ef2-72d2-45d4-96c4-f5a4aa5f4792@gmx.de>
Date: Thu, 20 Aug 2026 13:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev: platinumfb: add error checking for ioremap calls
To: Yue Bing Kun <yuebingkun@kylinos.cn>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260820060026.217814-1-yuebingkun@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260820060026.217814-1-yuebingkun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MaLOVMaO13cVt2wcB4IrEkDSH9KcMJJGyh8JbFLA5puPWi8XwLD
 Qi+JiYNoNdWAW97zdGzXVp54upP7itAMn8xjVhwERORnjk87zJz8FNuotoZnx3B7xhWz84f
 f3ZmAZiURl13a6JSqfxEL85gr9XFBuFg3JbgtLXZdrDJyemaOlMRdn5aPRYkZ4QVMeMm3MC
 J/XveLZeT8X6XmYrGnXpw==
UI-OutboundReport: notjunk:1;M01:P0:ND6IoWP+ZW8=;ig2nmnoJ67vp4h1mJRf1zKT5Bz0
 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
 qbcbz5+MJOgiLeY2nFwg=
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

On 8/20/26 08:00, Yue Bing Kun wrote:
> From: BingKun Yue <yuebingkun@kylinos.cn>

You are using various combinations of your name:
- BingKun Yue (as signed-off address)
- Yue Bing Kun (in plain email)
Maybe you should decide on one?

> The ioremap() and ioremap_wt() calls in platinumfb_probe() were not
> checked for failure. If any of these mappings fail, the driver would
> dereference NULL pointers, leading to a kernel panic.
>=20
> Add proper error checking and use goto-based cleanup to avoid code
> duplication across the error paths.

This commit message has nothing to do with this patch.
 =20
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/linux-fbdev/20260819235918.GA2021182@ax162=
/
> Signed-off-by: BingKun Yue <yuebingkun@kylinos.cn>
> ---
>   drivers/video/fbdev/platinumfb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/plat=
inumfb.c
> index fdffadcc3e73..f74c937c839f 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -320,7 +320,7 @@ static void platinum_init_info(struct fb_info *info,
>   	fb_alloc_cmap(&info->cmap, 256, 0);
>  =20
>   	/* Fill fix common fields */
> -	strscpy(info->fix.id, "platinum", sizeof(info->fix.id));
> +	strcpy(info->fix.id, "platinum");

And this one is a) reversed and b) useless & contraproductive (I will not =
take it).

Helge
