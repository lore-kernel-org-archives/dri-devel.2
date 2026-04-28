Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B647FFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B3A10EB4F;
	Tue, 28 Apr 2026 12:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="tnUt4W9f";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A0610EB4F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777378950; x=1777983750; i=deller@gmx.de;
 bh=1GhGnkKditIL/l87bxaNLRkTxJM2aC8ulrCD7T7s9KM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tnUt4W9f0EV9ZsVbRqiRkqxaMDoS6v5NfkpqoguiziFbp4i2zDqgFdTb6XAHDgGQ
 17E1XNiDXnnqAPJvSwqrgf0++Wn2OSLlAg2pXYTTnodbkxZesAWm14BuYNeasf86P
 u+01XMltxSTm1SfZzyz46JxrBmoFaqGT8eYBU+WycCuyipiLM016BVVNBDRbjY1tR
 5PDDo7tmfRqPbSWcmqtV0tzsB18hWK1qqvDRXUquoHMEu8nNQ7jCe+1Y+bTR/mXao
 S4GLLkVK4xrthTw/1wzRV4qiSKXDK/0bPkasQj82/hUYrlhbSZot8RlVWuPc5rMoN
 ob4Gu3gf4+RiVVPvmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1vSCpf0dsL-010af1; Tue, 28
 Apr 2026 14:22:30 +0200
Message-ID: <f36e925b-939f-468d-92c8-0b63636ee955@gmx.de>
Date: Tue, 28 Apr 2026 14:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gpu: ipu-v3: clean up kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org
References: <20260427183236.656902-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260427183236.656902-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JnWASr+LpSZT8SoeNqcnoWYlmRUSxRyS10+hui5sAl26Us468nS
 TpWk5sF6RSGGkBVlb1JSt9uMCaKdOfh8+kMxFQv+GdqPZnL/gxxbckcqzjlu7DvPQSRToUu
 8sj5fWdT6TlteBIDDYf4P6dfbwCTGBey/k2IlJFuSDvWzppoW4ETl7TDKD3A1CN1i/iKQTj
 KqLuZYP4qJs15Vl2VeBtw==
UI-OutboundReport: notjunk:1;M01:P0:MItF3nY7aVs=;erSpluC/JxFSl/I9+jNk8o7Gnxf
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

On 4/27/26 20:32, Randy Dunlap wrote:
> Correct all kernel-doc warnings:
> - fix a typedef kernel-doc comment
> - mark a list_head as private
> - use Returns: for function return values
>=20
> Warning: include/video/imx-ipu-image-convert.h:31 struct member 'list' n=
ot
>   described in 'ipu_image_convert_run'
> ....
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> v2: add Reviewed-by, update Cc: list, rebase, resend
> v3: rebase & resend
>=20
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
>=20
>   include/video/imx-ipu-image-convert.h |   16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
applied to fbdev git tree.

Thanks!
Helge
