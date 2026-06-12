Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46F8CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48BC10EB69;
	Fri, 12 Jun 2026 21:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="S22UVrPg";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1003610EB69
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 21:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781299377; x=1781904177; i=deller@gmx.de;
 bh=s+EqDGttNdP+IN6RGZW6US1t7Zs+ggdvfmTucD3SNZE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S22UVrPgazbczKU+/UVpsjEEE8rTafv5S1E6FDrzuawdBbjmSswRLuG07SNjz8jv
 OMrYpE8tVLXmF9C5e6F0AdS183dGJLwrvMe65Q1jeJZqUbhWb3W0fozGzEzquqyOI
 fmoTu6quGsaz31LiDyQ4yozzcSUKU1C5LfRq+H0iaUWphnTREAblReKwlIrTWh+y6
 /BQjsFtMhgQn4myxYA+BQYwJEd44gi4mthRHuDtb1xIprrwIcBE8rVRCLA/2ax0sQ
 TdqQekzGcHlwEh/noH0YJpJbCbOv3Wf1kUuI9+nvcTrc7BY64SMziuwFBX/M7dI3x
 jFzSixXSghOvz7ipjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1xP0yX1UQ4-010CXC; Fri, 12
 Jun 2026 23:22:57 +0200
Message-ID: <628300b8-ff6e-46e4-961c-222c93fbec3c@gmx.de>
Date: Fri, 12 Jun 2026 23:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: modedb: Fix misaligned fields in the 1920x1080-60
 mode
To: Steffen Persvold <spersvold@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260612164041.3652599-1-spersvold@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260612164041.3652599-1-spersvold@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j0GsLDbxFl5ebpGuOi3gZO4mdWg+AKKJhWHXoVqTcU6aeGuBkYX
 +5QxBb/MJSBPLnZV+8txTA06lNrTjF8XxIIRaamhgxIsChmkl8vxW7VjpEvEbzsD5fX4ogE
 0Bp8PgwZ+TL2nCe7RzB3b2QiouQvT491MADg4Aq9AGSyVkqlq2P4i1x6+/4GnCMC1w2PesD
 ZgS/Uz5/ImZ/y64ti0lsg==
UI-OutboundReport: notjunk:1;M01:P0:0BQG6eetHuM=;QL0naVldQvvYwqxrtZd2g15Sabk
 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
 2cP0Qd0NjCjxj+zvp06tlz8doyk=
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

On 6/12/26 18:40, Steffen Persvold wrote:
> The 1920x1080@60 modedb entry has one too many initializers before
> its sync field: a stray "0" occupies the sync slot, which shifts the
> remaining values by one field. The entry therefore decodes as
> sync =3D 0, vmode =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT (0x3,
> i.e. FB_VMODE_INTERLACED | FB_VMODE_DOUBLE), and flag =3D
> FB_VMODE_NONINTERLACED, instead of the intended sync =3D positive H/V,
> vmode =3D non-interlaced.
>=20
> fb_find_mode() then returns a 1920x1080 mode flagged as interlaced +
> doublescan with active-low syncs. Drivers that honour var->vmode and
> var->sync when programming display timing enable doublescan and the
> wrong sync polarity, corrupting the output.
>=20
> Drop the stray initializer so sync and vmode hold their intended
> values (positive H/V sync, non-interlaced), matching the adjacent
> 1920x1200 entry.
>=20
> Fixes: c8902258b2b8 ("fbdev: modedb: Add 1920x1080 at 60 Hz video mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Steffen Persvold <spersvold@gmail.com>
> ---
>   drivers/video/fbdev/core/modedb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Steffen, thanks for fixing the bug which was actually introduced by me!

This patch is now applied to the fbdev git tree.

Thanks!
Helge
