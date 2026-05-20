Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0737CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1816910F02B;
	Wed, 20 May 2026 11:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WSEdv/6u";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A1710F02B
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 11:38:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 46E1D1A35D8;
 Wed, 20 May 2026 11:38:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F2DF660019;
 Wed, 20 May 2026 11:38:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1B65107E9FD7; 
 Wed, 20 May 2026 13:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779277122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DiVd5MR6J1MMWlXr/gCL69huX1Ig2zwqr14X6tj3qzA=;
 b=WSEdv/6uN0d95Q0dPPLszDYgAcBSPKzvuLneFYazN9WKZ0JRV/Km/gQfgMFr1v+Lqk4b9K
 yP9LQd+v7+ylCmucfkyo7LbRViFPtkyxtBI1ImwqoOFed9ght16dAh6o8LoSDzaqhTvaLp
 xWxJI5hy6B/J6M33JoBOuEw8LQ4A2lEzsSyd8j3q8OfspCHFb92TLSkTK5jqkN1l0jDPFz
 RUR7f8olqDQbfQcv+QUmEgHUCraU/BSkk7FQXB+5PLmfQsW9zCX/Rv7dkH4DTzdRjXyR8R
 LBSmTYTKEyZpvrNOLEYNlCmyv9FQ5D1F4JP8EkYF6ReRBeKZYyXHaya+QICGwg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 13:38:36 +0200
Message-Id: <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
To: <tessolveupstream@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags
 for stable LVDS output
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <marex@denx.de>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
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
In-Reply-To: <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
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

Hello,

On Wed May 20, 2026 at 11:04 AM CEST, tessolveupstream wrote:

[...]

>>> We have not received any further updates from TI regarding this issue, =
and
>>> at this point, we are not sure if we will get additional feedback from =
them.
>>> As you had mentioned earlier that the patch could be considered after
>>> waiting for some time, could you please let us know how we can proceed
>>> further from here?
>>
>> I am getting some feedback from TI, but it is taking some time.
>>
>> For the time being I think it is clear that HBP and HFP are required, an=
d
>> so removing the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HB=
P
>> in your patch seems to be fully correct, even though this had no effect =
on
>> the panel I tested.
>>
>> I'm still trying to get some better info to ensure that switching from
>> burst mode to non-burst mode is not expected to have side effects.
>>
>> For thi reason, I think it would be great if you could send a new versio=
n
>> with two separate patches: the first one enabling HFP and HBP and which =
can
>> be applied right away, the second to disable burst mode for which I'd wa=
it
>> a bit longer for TI feedback. You can keep the Tested-by lines.
>>
>
> Thanks for the clarification. I just wanted to confirm my understanding
> regarding the patch split you suggested.
>
> From your comments, my understanding is that the first patch would only
> enable HFP and HBP by removing MIPI_DSI_MODE_VIDEO_NO_HFP and
> MIPI_DSI_MODE_VIDEO_NO_HBP, while keeping burst mode enabled, so the mode
> flags would become:
>
> dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>
> Then, the second patch would only disable burst mode, resulting in:
>
> dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
>           MIPI_DSI_MODE_NO_EOT_PACKET;
>
> Could you please confirm whether my understanding is correct?

Yes, correct.

> Also, from our testing, when using:
>
> dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
>
> we are not able to get display output.

This is the case for the panel I worked on as well. In the practice we both
observe that non-burst mode is what fixes the panel, but there is no clear
explanation of the reason in the docs (that's what I hope to discover from
TI).

On the other hand the HBP and HFP are clearly required by the docs, so it
should be fine to enable those without waiting for further info from
TI. This is not fixing your and my panel, but it's a fix, no doubt.

> I just wanted to mention this
> observation in case it is relevant to the patch split discussion.
>
> Additionally, regarding the Tested-by tags you mentioned earlier,
> should I carry them forward to both patches, or would you prefer them
> only on the applicable patch?

I'd say yes. People who sent these tags have tested a patch that is the sum
of the two future patches, so I'd say it's OK to keep the R-by on both
patches.

Thanks for your patience. We'll get to the bottom of this issue! :)

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
