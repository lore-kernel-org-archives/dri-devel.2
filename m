Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E73CC88E59
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 16:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C791A10E1C4;
	Sat, 12 Sep 2026 16:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="KjKv2GI+";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBEA10E1C4
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789229373; x=1789834173; i=deller@gmx.de;
 bh=r49S77oIQ/C/megs27fXXTJ6gjS9N4V4q1Wx+eoHlsQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KjKv2GI+bpzMls/M9Kgt4eEFS9kPqU2N06TZI9l+i/vtIpVm+/qrlN3hPVceXFgk
 KHFZnI652enongqubiKkwPSjgkcWlS3s0vdlvagfAhQpOuAXybaH7t7A3wP16/kgU
 Lt1s0wyYTAKebAc8AxDt2FZLDpyb+29NHD9sCbiSnEBXz1mowaTx0r+t1qHUA9jRK
 f9i8mWIkSmprNwcFS+thl2Uwb5PipDW5DVmH2XAsqASX0RUdxAgjAQwdqxmNc47Gi
 vGwMw7P9OmUQw0H+ZLNMqMzTinVRN6TXD5RcjiDDpJLgLfMrTFMYiO9dZrYnfARSO
 /fp4FCJV33JEghhBDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1xKy9v3hBz-00MiW3; Sat, 12
 Sep 2026 18:09:32 +0200
Message-ID: <6e0bea40-9c4d-4af8-89c5-c4850f9fae77@gmx.de>
Date: Sat, 12 Sep 2026 18:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: sstfb: use managed PCI device enable
To: Myeonghun Pak <mhun512@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260911000835.88909-1-mhun512@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260911000835.88909-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nogiiUgN5WOX28BaeGnVtxm+tib4Nvl4TJC7YcK6Rl5KIL1oWlV
 lCuagd7gqsoqIFoDg/YyUT0t1vT4dGjmo7ygVIBiTuhVitCNMqVTWEKB0ZR5SXr3SvjVhaG
 fXZ2Y6cPKinPH1HD7h+ln6ixLn5RI7KA9oh0UuneMsNVNWO+ZO8CpGiB16tFLqt6dDi3L0+
 lZVqmwiSOgoJMyPOJOkFA==
UI-OutboundReport: notjunk:1;M01:P0:TrCMc/lDpWg=;UZ/0Jsn8x6XpfapT5zFWbDag5ad
 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
 c=
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

On 9/11/26 02:08, Myeonghun Pak wrote:
> sstfb_probe() enables the PCI device with pci_enable_device(), but
> failure paths after that point return without disabling it. The successf=
ul
> probe path has the same imbalance because sstfb_remove() releases the
> framebuffer, mappings and memory regions, but never calls
> pci_disable_device().
>=20
> Use pcim_enable_device() so the PCI core disables the device automatical=
ly
> after probe failure or driver removal. The driver still releases its
> framebuffer, mappings and memory regions explicitly.
>=20
> This issue was identified during our ongoing static-analysis research wh=
ile
> reviewing kernel code.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/video/fbdev/sstfb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
applied.

Thanks!
Helge
