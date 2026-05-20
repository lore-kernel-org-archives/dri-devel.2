Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AB9CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 17:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A891D10E130;
	Wed, 20 May 2026 17:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ULpO1BRs";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06E710E130
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 17:48:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0E6D94E42D06;
 Wed, 20 May 2026 17:48:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D48B360019;
 Wed, 20 May 2026 17:48:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 67AA9107EA37F; 
 Wed, 20 May 2026 19:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779299318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tD1a/JPJxpioI0aTNTe7Mcgt0N1AuDGP+Nnn6f05D7E=;
 b=ULpO1BRsFYLQ/Usb++wi84bJIOQmzLZjh2Fxdpz18iQbig80PcW4BowWBurNRmA8Wzzp4A
 IiqUZUwfQWfaqAoaMEAWo2nDoZ766boo3rezihWzLZb/hqK1V3yiRhSwnTFpfpJdNqnoAN
 unZCxUmd+jJwJfBR+GOjP1l/8NdW8TgM4T7jzVQLMN3XZC4z0j+buDFdgNpauyHrmoXyy/
 iucwUBW73KEgwBUJoQe6iFP+XHqaoOTBqMtZBPa+bJExeXh3MG7g0OKchVjdkx0+0PDKA4
 xGRmaFebPe1uV9lucSKKCjnt7Vul0+9+dKMHRxswxz4wQso4mwvR45blNur53A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 19:48:31 +0200
Message-Id: <DINOYRHFLDMD.1TD43L37DHA0T@bootlin.com>
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <marex@denx.de>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: <tessolveupstream@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags
 for stable LVDS output
X-Mailer: aerc 0.20.1
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
 <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
 <8a78aab6-918a-4bed-a913-05ecb559da4f@gmail.com>
In-Reply-To: <8a78aab6-918a-4bed-a913-05ecb559da4f@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed May 20, 2026 at 2:29 PM CEST, tessolveupstream wrote:

>>> Additionally, regarding the Tested-by tags you mentioned earlier,
>>> should I carry them forward to both patches, or would you prefer them
>>> only on the applicable patch?
>>
>> I'd say yes. People who sent these tags have tested a patch that is the =
sum
>> of the two future patches, so I'd say it's OK to keep the R-by on both
>> patches.
>>
>
> Okay, I just wanted to confirm one point =E2=80=94 when you mentioned R-b=
y, are you
> referring to the Reviewed-by tag? I wanted to make sure I understood it
> correctly before carrying the tags forward in the next version. =F0=9F=99=
=82> Thanks for your patience. We'll get to the bottom of this issue! :)

Oops, I wrote R-by but I meant Tested-by.

I don't think you received any other (Acked/Reviewed-by) tags.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
