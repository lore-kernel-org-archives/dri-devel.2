Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC6C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56AE10E0FF;
	Sat, 18 Jul 2026 18:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="denuESjm";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55C610E0FF
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784400503; x=1785005303; i=deller@gmx.de;
 bh=HfI0ldd//OJJ5Bjsd9XGSKtVMExzQ2xjINEDZ4GiW+A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=denuESjmmqJ2EknTDX0aNKTBbyrjuw1RvrVb5794WKNGSRm0nYxFueXm23V5Cuw0
 GMW50w3wpyjEI9LhIZislQ6eKitA6/mK6jz3e8UXfBo0qwIQX9KLrS1Rvuwn2DHHP
 9s1k4Zg283CPS4L0UhGkNrlG87QU8fFBea8oiXEmQqAU6ZN1rSDu8r5yNBxW1CR6Z
 jvzjz0y31SzgAj3ZJkmpiSAKf4PLhOMw8TFXDi+aBqYHxs05+fPNMg1uFAYtb4W0/
 YLun55k8ocyWS4T7BujxGW0pip37VIUjzj29iiv3AOONk9XPdEycIQpSWCJrswc6r
 HjL5Tbovf6CSX5uMWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1xNZMI4ARg-00mZGC; Sat, 18
 Jul 2026 20:48:23 +0200
Message-ID: <14b6916a-5fb6-4710-9ad7-401305873a49@gmx.de>
Date: Sat, 18 Jul 2026 20:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: tdfxfb: fix PCI enable cleanup with
 pcim_enable_device()
To: Myeonghun Pak <mhun512@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260701112147.55048-1-mhun512@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260701112147.55048-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ujdAyaW6N2C5Jzqm8foeYHbpGLXaI0Y0FKFZyr+PD0pDMm2yGqi
 5Yb3pAHQF6YhICk0sCfswGVh/7PB/o+gMNvy+9Jmgl+7Ku8lbZgWJhJSJTM0SmWfzlsmvMd
 zXikc5LO6BKVQQpAeIq+0EmW++WNWbRfugMe9O3hvTJEnNSOCvM8e2/kyQY+2Bg0Oy0PNat
 YRKy34e2nT9+RJKahSCSQ==
UI-OutboundReport: notjunk:1;M01:P0:FXn0SpLCO5s=;qUFqgX1aaF77121lUMUK3nyXxJb
 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
 +7koNG1U1/L0xMUMRf/r+NZMfBPpxb
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

On 7/1/26 13:21, Myeonghun Pak wrote:
> tdfxfb_probe() enables the PCI device with pci_enable_device(), but
> several failure paths after that point return without disabling it. The
> framebuffer_alloc() failure path returns -ENOMEM directly, and the later
> shared out_err path releases the framebuffer and returns -ENXIO without
> balancing the PCI enable state.
>=20
> The successful probe path has the same imbalance because tdfxfb_remove()
> releases the framebuffer, mappings and regions, but never calls
> pci_disable_device().
>=20
> Use pcim_enable_device() so the PCI device is disabled automatically on
> probe failure and driver detach.
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
>   drivers/video/fbdev/tdfxfb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
applied.
Thanks!
Helge
