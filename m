Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D092CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9633310E36A;
	Tue, 19 May 2026 07:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="fcJ+47qf";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8488810E36A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779177160; x=1779781960; i=deller@gmx.de;
 bh=W7e/42Y9XiPFxo2eyxX7k4wyDNkoBnVaWYZk8arMDDs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fcJ+47qf1Wbxsk5sXgaBh0rUGByKlG8B7pYM5bVO648TtJ35HzHJSbJg/KkjEj+m
 aY9qLtqbrLKbFD9d2r1GODJmAZEUSnLc9t21t3q0oE4s2rJGmIvev/IMs34y8fomz
 BHCjMYM1YfICLdAQfMA13gjDw7p7Vm8nvE2GK25KTMTvKyZCP72PlOAupfjKuQN02
 6KyyS3kS3DK7KM9bVjVlet3MHSsWoW4nxIiouOY4En45EN+aDJrsXukL9HZZUo1Wc
 nFk6syPGSA0Eimik7BRh9UBlqHdYH79e/gey/D2WNmOrF50LKya8JQmR0Z2gcnsvU
 jy1oi/E6M7EKNzz39A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1wbdKc2WiT-0052HD; Tue, 19
 May 2026 09:52:39 +0200
Message-ID: <50b05994-5315-40e6-aba9-b776f190bc31@gmx.de>
Date: Tue, 19 May 2026 09:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: imxfb: Use of_device_get_match_data()
To: Rosen Penev <rosenp@gmail.com>, linux-fbdev@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li
 <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "moderated list:FREESCALE IMX / MXC FRAMEBUFFER DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20260518211303.10777-1-rosenp@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260518211303.10777-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HJxIG63k41+/GPO0l/+ClQ1PE72sYurv8HuJ2o/qI4v+hfZF5ZQ
 oPVQc41kfOoSn2xOHUofmEv90QHSHEGRFcq9f5aRBK9FhdZCMRHXMsBGxG75PkLYaxDuNNX
 q3yCle7+HeQFN3ZBB5pqLSdhiogU0aT4ukpr3snEvO1swFoBaLF8URPcD5UuB2UHXJshp7b
 3YuU5fD17qonG/FkL2RTQ==
UI-OutboundReport: notjunk:1;M01:P0:arsk4+orS14=;0qrLIKcSi2MKldpQR9V6uOMyVaF
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

On 5/18/26 23:13, Rosen Penev wrote:
> Use of_device_get_match_data() to fetch the platform ID entry directly
> instead of open-coding an of_match_device() lookup. No NULL check is
> needed as every compatible string has a corresponding data section.
>=20
> This also lets the driver drop the of_device.h include.
>=20
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/video/fbdev/imxfb.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

applied.

Thanks!
Helge
