Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C808310987A9
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB4D10E28B;
	Fri, 20 Mar 2026 16:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="nZftUD3R";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B0B10E28B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774025789; x=1774630589; i=deller@gmx.de;
 bh=LDOo/nkhW5I9qtRR3BJXqA+8t11PXHDovTSQyssd2Qs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nZftUD3RARpbNFJF2yssD+ICpuLkaEvsCqtOGJNjCx9OKy0wqjUdbqefffijpjCh
 FsXXDdeUqHWPnljfTOY+yb4Z1FKr76KPtC/NLBTHNhNOsJuU7Z1mm61dgf866g4ik
 KiZqpyAuFi7FjTuaVPxxQ/JCi8mW8Oa9M1OjlrCwaYJnmNSaLBH13I2ftuqc1jbdt
 Wc8XMHndqTyVGE3uCmRQO/jFu4zI+Xj+IjhfmCDR/UAH8apQUh7CJQ9g1LA8DzeQr
 /J+H7nEA2lPIy9JSiubnW+1OpuMtVkTU3XaJI08s0slvCATQi7qtjJb/J58qDotyA
 9TybpLWhZkeg16x5VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1vQQqE2qeZ-00itRh; Fri, 20
 Mar 2026 17:56:29 +0100
Message-ID: <3beafd0b-e97d-40b0-8aa1-a4e849bce526@gmx.de>
Date: Fri, 20 Mar 2026 17:56:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: update outdated help text for CONFIG_FB_NVIDIA
To: robgithub <rob.github@jumpstation.co.uk>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260312205507.70b9013b@hexa5>
 <034989df-cf86-4136-8522-6c48e5523645@infradead.org>
 <20260313203443.7cf0a8f5@hexa5>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260313203443.7cf0a8f5@hexa5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zWJ8TCq7yj5ygyeeLgpsxZxJUNwqFxiLQt3NaAr3VkdLpcf4Uy/
 LuPIxR4ijX9QzeYMoMk/cuAiYtlgDCSVkropp0qFNE//+2W62v+8/DaCltD77BMRuVSjKGx
 Fuvn9oTgg0wMTGbtPET7wE4tQCq1GkwIwvaNc8hy1CQ7fPTsfTrQUh2lFXWYhh6AiJEZrbY
 N9c1Hck6D3Eu8vhdAgt9A==
UI-OutboundReport: notjunk:1;M01:P0:S7MTcDxtioo=;tcXo7XVhKqthyvlO8nCjaiG7eB9
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

On 3/13/26 21:35, robgithub wrote:
>  From 688a061ba0db71fc2d5facd8344db7a4d5b1575a Mon Sep 17 00:00:00 2001
> From: robgithub <rob.github@jumpstation.co.uk>
> Date: Wed, 11 Mar 2026 22:14:43 +0000
> Subject: [PATCH] fbdev: update outdated help text for CONFIG_FB_NVIDIA
>=20
> The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
> incorrect default behaviour. This patch updates the description to
> reflect the current state of the driver and supported devices.
>=20
> Signed-off-by: robgithub <rob.github@jumpstation.co.uk>

applied with minor modifications.

Thanks!
Helge
