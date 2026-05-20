Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D575CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953C710E32A;
	Wed, 20 May 2026 18:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="mExeoTGz";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC2810E32A
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779302979; x=1779907779; i=deller@gmx.de;
 bh=F35kee9xljIjjs+QrqI9vWZzAxuDXiLBx+EoTCwdTOc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mExeoTGz8sKkrrxHCA4XosvmqEMMkWpr5jpyoxnCm5UN+v7nBYLKS8m/vIPKyRYs
 YhSbpkTqmLeuL+2DsNJSGh2hgcT+J9XcHxZ4+OayTR/u32W29mzwssF128VumLJtc
 fwhtemNPcmejNKj3nTPU3C/TolGUWIJGbWo6FS0wyF3B1O6MI41+K5Pjkj8JSSvqE
 SA633K7T2t9V5mREw4k+od/T8lANaa7SulT0Gj0IVF6KGJ44Z6Hr3nMnkhtvoDkbe
 CSZStG6R8VmpAtM13CifDHIjbDruac2CAeR40cz0cKX8bePTfVgWveRQbiKTYMhaf
 TqxEHxxFLbZZPlSYyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1x7OHB1cP4-00pRbB; Wed, 20
 May 2026 20:49:39 +0200
Message-ID: <a727f5cc-df21-4952-a24e-7d065abbb47c@gmx.de>
Date: Wed, 20 May 2026 20:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in
 helper
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-4-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260520160744.130841-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P7vQ+mxKVjb4yokUnXgbJdgAsnePPvVB9BDP5k4q8ysHz7ESqUa
 711LWotZfynYvbvKuwEkNRV9HVhQfLCqbB6RM/t7UJtazI5/RxTjzmeAW8gZ4vlEKPqDYoj
 bd+oltPb/71Gz4QV/XgS78vcEclpik8PFJ0VyESx+9iveTmoiwK2EKBgC2xmQV2YrJRMtdO
 FHFuW6z9K0xklTew07zIg==
UI-OutboundReport: notjunk:1;M01:P0:eBd5+Z6hIKY=;l7kBucA6nhG5y1WnvzNW1di95tR
 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
 s677wCaUITnft+FEgkbWAXIwXE3IhQ9e0PzdblU
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

On 5/20/26 18:00, Thomas Zimmermann wrote:
> Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
> invokes this functionality before switching physical outputs to a new
> graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
> implementation details.
>=20
> Vga-switcheroo is used for switching physical outputs among graphics
> hardware. This functionality is only supported by DRM drivers. A later
> update will further move fb_switch_output() into DRM's fbdev emulation;
> thus fully decoupling vga-switcheroo from fbdev.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/vga/vga_switcheroo.c |  6 +++---
>   drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
>   include/linux/fb.h               |  1 +
>   3 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_swit=
cheroo.c
> index 8fe1ae3c71bb..805953d0b941 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -31,11 +31,9 @@
>   #define pr_fmt(fmt) "vga_switcheroo: " fmt
>  =20
>   #include <linux/apple-gmux.h>
> -#include <linux/console.h>
>   #include <linux/debugfs.h>
>   #include <linux/fb.h>
>   #include <linux/fs.h>
> -#include <linux/fbcon.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/pm_domain.h>
> @@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switchero=
o_client *new_client)
>   	if (!active->driver_power_control)
>   		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
>  =20
> +#if CONFIG_FB

I think this should be
#ifdef CONFIG_FB

Helge
