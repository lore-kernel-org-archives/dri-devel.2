Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52368F459E9
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AD710E971;
	Fri, 10 Apr 2026 14:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Zvi1VE8h";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C92910E971
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775832950; x=1776437750; i=deller@gmx.de;
 bh=ttO0qjnAOVbyK0S9kyCkSIGPJYX/PRaXt0sR/V7ISak=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Zvi1VE8hbs5rPH4xYTpKZmcztixeKE8HFUtxZLaePp/qCvy5OjOXRRXzkNwGRENz
 +6l9UBPFmTAt4R0Wsufdm1pfMZPVyCFguOZ3dYjBpGqaSmck/nTxDrtLg2wn9KyGd
 INlseq0rRDqOVQgSPsmLEEOFhS8M+CaZlVOqQvmbHzaoeIK4/xBVwbhQSh2Ce9FzW
 5cO0H7Gz8zyBb8Gozp76+uHJwg6BPbJ/G6LohXjRpMRAly2XoaIqWwkzrhYp0rWxi
 HvjnSGXzsBVheNd/ehBAZb3Y6asFfTw9XU1rrN166esCD7qtyEqoqhuKuduAXcZxG
 ABFeHhfRXJpjB+BwHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1vyPCf12Qd-00UfVC; Fri, 10
 Apr 2026 16:55:50 +0200
Message-ID: <58503b21-93fb-4e13-bb1b-374507eb6a74@gmx.de>
Date: Fri, 10 Apr 2026 16:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>
References: <2026040945-glare-devouring-f242@gregkh>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2026040945-glare-devouring-f242@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7XNgKzVhuZakm+Z7nJ2w0NEm9AehXwEeP2JGERijKxrTDHFQAZB
 dxiJ1wQHWWBcvG94Xeman+ysC77DvmZYPv/8KgGXc9NlegyvoarPmA3RK147v4RiJzz0Xdn
 56wzR/9L38M0rEDYpVnsesEom8bxzQnhCYxECoQFxn3bmxAXNKmnxUdCCVTDWY6/WQfaXXK
 fwxLBMyO/mjMv0huYcA0A==
UI-OutboundReport: notjunk:1;M01:P0:m399cuAK+rI=;sAae2mTfPwz0dFXz8juyzLzKjY/
 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
 fOwF+TifZkB6LZLPjUjT4/Lw==
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
> Cc: Bernie Thompson <bernie@plugable.com>
> Cc: Helge Deller <deller@gmx.de>
> Fixes: 59277b679f8b ("Staging: udlfb: add dynamic modeset support")
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/video/fbdev/udlfb.c | 3 +++
>   1 file changed, 3 insertions(+)applied.

applied.

Thanks!
Helge
