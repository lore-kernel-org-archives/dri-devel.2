Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4CCF459E9
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECCD10E96F;
	Fri, 10 Apr 2026 14:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="VMZIdbFp";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E853E10E96F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775832930; x=1776437730; i=deller@gmx.de;
 bh=XLNPUTTOc3ENYI5tBSEqexcD7IyqdPCLPE0x2mQnRWQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VMZIdbFpkM9xXdSuAGzDp8jI61mcONmtzsHH7Yt6gWqsGZ5DfKVQpKD/KIp4KNCI
 MkAsigcJuV+qjeW7NG1FIj0ithOgpF4xPVHNwtad+Sih8Gis2BzmhJkmGC3B6iLU0
 e+tSovgvCRon6DzBS3ghXDvBxVtdRuEaCo2dBToSAc8S+Lr97fp4YSDweJe0I8qB5
 Jvq+vFSe1Y6fVD5IhWqY6YSdXZiGwv2TyB82J143C+mx+tZ9qi0ZxAHejjGIu7W5u
 F+qVNd4boN0WfwogED5KOdvOKyyRZ2Th1zWaQmzWGsC4PPYNTpQvwMZBdnUu8gZZd
 kyN3W/8mVj3jC2bZWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1vHKti0HMy-00t2lE; Fri, 10
 Apr 2026 16:55:30 +0200
Message-ID: <fd2b39d6-5075-40c0-9d89-70e9ab8bf44f@gmx.de>
Date: Fri, 10 Apr 2026 16:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable <stable@kernel.org>
References: <2026040913-despite-entering-a017@gregkh>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2026040913-despite-entering-a017@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pvr+ZCSt3mMcLlQ9YSb0gmW2HMPgIq3AID9Fs2j5cN4WXdBDOip
 IftDOUonQCjS2xKffoBk2eqbZEFOChxSBIusAEXMTz0ot8l2YXOoBWr/Gib/NY8sh9GoQb3
 PJJ0pGgdBxcSTcvtmzO922E6ekZ6Ncpj4Bxb+azcZF3tQtrkvgu6VCw0irsn1fB9L4J3fma
 i7NxfhK6l6QkCekcqGLBw==
UI-OutboundReport: notjunk:1;M01:P0:+CwEzKhmJG4=;Tmx1yaMnUXBZlODXPRJ9sckKebH
 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
 osQ8vcXk/D/W9C5Z2q1wGgFcP4GOEyVeg==
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

On 4/9/26 15:23, Greg Kroah-Hartman wrote:
> Much like commit 19f953e74356 ("fbdev: fb_pm2fb: Avoid potential divide
> by zero error"), we also need to prevent that same crash from happening
> in the udlfb driver as it uses pixclock directly when dividing, which
> will crash.
>=20
> Cc: Helge Deller <deller@gmx.de>
> Assisted-by: gregkh_clanker_t1000
> Cc: stable <stable@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/video/fbdev/tdfxfb.c | 3 +++
>   1 file changed, 3 insertions(+)

applied.

Thanks!
Helge
