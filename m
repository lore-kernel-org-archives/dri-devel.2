Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D50AFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5DF10E1CD;
	Tue, 28 Apr 2026 12:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="jgwfF08i";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB86110E1CD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777378773; x=1777983573; i=deller@gmx.de;
 bh=fb8cq04O+0BRBhPwgPu2dVCOnEcL5uypE6n2Ad5f328=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jgwfF08i7QI0NmoedD9FsTqSDEb9iBEXtQom7dCxletpuOJAsCcF4gbs58Hq5eWB
 6g4iXcLn5IByzETZuTVDLX8J7jWM4enJ3XW3lbZgRv+X1dgRzqET90k8Lsk7oVyUQ
 4QE4/eMBlWDlSLzQKYDRJ9zmPIIzruhndz4uHiZjoow/vzJyBneChbFPzMQ9TROlM
 hELgxaoFjdaWxAEPAGAGXlPhYK9I9kGS8voHwVKaHV2i9kl7+qy69tBdOh038jCjv
 z45KrC8+TSS0gG/GkQg08JpbvX6Dtzfm167KGCE1miI1GpxnoX55XyRAHeH08IAcn
 T2iE516DiCoFAUujmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1vJMvp3vfh-00rBIB; Tue, 28
 Apr 2026 14:19:33 +0200
Message-ID: <5b1b611a-9139-4ebf-beb0-576ae8a1e270@gmx.de>
Date: Tue, 28 Apr 2026 14:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: defio: Remove duplicate include of linux/module.h
To: Chen Ni <nichen@iscas.ac.cn>, simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260428031725.1013103-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260428031725.1013103-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMDwCbUUKyP6Z+YBCIkoY9h+iqqPcfRPi5cz7EngLRO376TeBUN
 h4GUAtVDluFd60ZluL4Zm1ycPBG1kfkRcEvcz97VnacfPJpnIi1YN14UCMkqAMJyVlp//8r
 oTIE0fAa+/euQkhu1N+a/ft2ZcfrCQ20FAFwFTF1SjOxilE1mCeatYbD8Ya6ye8Gft9tQTS
 zH7EBR1z7isu97miNG4eA==
UI-OutboundReport: notjunk:1;M01:P0:0TAnZNS0O14=;9Buj2zxTr1jy7T1/Tv2whTN2RkC
 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
 ZwyelPqLQN9iAgg==
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

On 4/28/26 05:17, Chen Ni wrote:
> Remove duplicate inclusion of linux/module.h in fb_defio.c to clean up
> redundant code.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/video/fbdev/core/fb_defio.c | 1 -
>   1 file changed, 1 deletion(-)

applied.
Thanks!
Helge
