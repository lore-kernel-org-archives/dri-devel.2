Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75125F9EDD8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE3110E2B8;
	Wed, 22 Apr 2026 13:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Bmko8VzL";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D929F10E2B8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776866226; x=1777471026; i=deller@gmx.de;
 bh=EnLKal4CwKTUhT9BKWlfN6PnlBZ3r4rPhdA4ygkym7U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Bmko8VzLrS0ScNSzDwDR4Kv/Q0K8IJ4ejeUPMkFVu5q9dVVSd+R0lbmk70RZZDA4
 7lp+ee+h/Nrvldz58szxijqODZ957sv986cpBTORbNFldwsx+CWogPnpQoC5hzK8S
 UbH/kJGGsE/sW4rGhK2codKxKM6J1rT6QaQC+wE/bn7p/u5kP5ZburUtm4PpFEhry
 rmuDqUMmynbs/bmS4GTlLxKQaIbDN4r9q/fAwiwEViotf35WIyQMjtql5SEiaVEBo
 p88AxD+D/+TfM16xrkZ9qviYIO2ju4I5MeB86UHYL1m4E5CsWy/K09N3YoTJXGTWS
 kVHjfOkGHNqdnSCtSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1vb17E43eX-00g80t; Wed, 22
 Apr 2026 15:57:06 +0200
Message-ID: <3dbace4f-9a03-44ae-85e4-aac403a5ed1e@gmx.de>
Date: Wed, 22 Apr 2026 15:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: aty: Fix spelling mistake "enfore" ->
 "enforce"
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260418-radeon-typo-v1-1-8e075365089b@ethancedwards.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260418-radeon-typo-v1-1-8e075365089b@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:39OOf+w5ooiFP33rWBTuMCnoBGcKx9mGc8X0eGuujPN9/7YOvM0
 WHKtU6Bk+5aO8oqGNgR5bi8c46tvAjGCDc2wzgzVuvS4V+j1zgA35eTV5t9+IH1S3e5MzuG
 rp1diHbD+oW9QinrhQqJgMnLd7dhQ2qJq+2mSEjzH2AoD4Sei5bKaKbH9/5FCjwTCSHtSbp
 CNDUFq0TYqmAIaCifiPag==
UI-OutboundReport: notjunk:1;M01:P0:eHnYPl9P0sE=;k2plFLtnlcCehLIxyaLPUfNe79S
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

On 4/19/26 02:45, Ethan Carter Edwards wrote:
> There is a spelling mistake in a comment. Fix it.
>=20
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>   drivers/video/fbdev/aty/radeon_monitor.c | 2 +-

applied.
Thanks!
Helge
