Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8404BCD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41AF10E3CE;
	Tue, 19 May 2026 11:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Qh9AamLj";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7060D10E3CE
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:43:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0D5A3C5EF23;
 Tue, 19 May 2026 11:44:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC4E55FFC8;
 Tue, 19 May 2026 11:43:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4F660107E8D01; 
 Tue, 19 May 2026 13:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779191010; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=o8CSK94nGvC+BLSkTIRhi64XQs2+aXkEqcBe5xOhX9w=;
 b=Qh9AamLja30jeTpXTfW8ZQlc7z9+8l9SA2OBLD1beXTXIjSiOxqK6XiVc6dzY9DUx9nPyB
 femGoD1Elg3BGycFwHYJraBUOy/ceZsw5k9K+TxcabA2TViIRI6SbNIVtFGUqOUc5B/ZUR
 9LNKHvbdpjMVOka8At1cZ8oViUFH6R/YsRowiJI2LQYYnl29FWmRWZsiftvwtuaRkJHhXB
 eJVeD0XNE2mfWF1zdoK4fnNddP5jnN4MIiR9cy8VEZFDtqzsZbRmWaIebUXLR0dFQUQ+AT
 Z7DMldpxc0rqtiZ97TV140K4RhR/v0RF41WhsSGzlqFShLmGMpVPLZAHY+bpOg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:43:24 +0200
Message-Id: <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags
 for stable LVDS output
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <marex@denx.de>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: <tessolveupstream@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
 <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
In-Reply-To: <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
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

On Tue May 19, 2026 at 10:48 AM CEST, tessolveupstream wrote:
>
>
> On 24-04-2026 13:55, Luca Ceresoli wrote:
>> Hello,
>>
>> On Thu Apr 23, 2026 at 11:16 AM CEST, tessolveupstream wrote:
>>
>>>> I had reached out to TI for clarification and any related documentatio=
n
>>>> updates, but I have not received any response so far.Given this, it is
>>>> uncertain whether we will be able to obtain further details or officia=
l
>>>> confirmation from TI in the near term.
>>>>
>>>> I would appreciate your guidance on how you would prefer us to proceed
>>>> from here.
>>>
>>> I followed up with TI, and they pointed us to the relevant sections in =
the
>>> SN65DSI83/84/86 datasheets covering DSI video transmission specificatio=
ns.
>>
>> Thanks for keeping on! I'm also trying to get info from TI, I'm keeping =
you
>> up to date if that will happen.
>>
>>>> https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=3D1776924088430&ref=
_url=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84
>>>
>>> As per datasheet Section 7.4.7, the device operates in DSI video mode w=
ith
>>> fixed horizontal timing, where HBP, and HFP are explicitly defined and =
expected
>>> to be present as part of the video line structure. The timing descripti=
on in
>>> this section assumes standard non=E2=80=91burst video transmission with=
 all horizontal
>>> blanking intervals accounted for.
>>>
>>> The datasheet does not document support for DSI video burst mode,
>>
>> This sentence seems incorrect. Section 7.4.7 starts with this sentence:
>> "The SN65DSI84 supports burst video mode and non-burst video mode ...".
>>
>> Even though asa matter of fact it looks like many users have issues that
>> get solved by disabling burst mode.
>>
>>> nor does it
>>> mention support for omitting horizontal front or back porch intervals. =
In
>>> particular, there is no indication that the device can operate with col=
lapsed
>>> or suppressed horizontal blanking, as enabled by MIPI_DSI_MODE_VIDEO_BU=
RST,
>>> MIPI_DSI_MODE_VIDEO_NO_HFP, or MIPI_DSI_MODE_VIDEO_NO_HBP.
>>
>> This is correct.
>>
>> We can still try to get TI feedback, but it that won't happen in, say, a
>> few weeks then I think we should apply this patch.
>>
>
> We have not received any further updates from TI regarding this issue, an=
d
> at this point, we are not sure if we will get additional feedback from th=
em.
> As you had mentioned earlier that the patch could be considered after
> waiting for some time, could you please let us know how we can proceed
> further from here?

I am getting some feedback from TI, but it is taking some time.

For the time being I think it is clear that HBP and HFP are required, and
so removing the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
in your patch seems to be fully correct, even though this had no effect on
the panel I tested.

I'm still trying to get some better info to ensure that switching from
burst mode to non-burst mode is not expected to have side effects.

For thi reason, I think it would be great if you could send a new version
with two separate patches: the first one enabling HFP and HBP and which can
be applied right away, the second to disable burst mode for which I'd wait
a bit longer for TI feedback. You can keep the Tested-by lines.

I understand this is painful and taking time, but it's important to ensure
as much as possible that the change won't introduce regressions on existing
hardware.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
