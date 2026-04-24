Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750EBFB44CB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC4F10E15C;
	Fri, 24 Apr 2026 08:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DwDc9Q5h";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C17110E15C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:25:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 683754E42AB3;
 Fri, 24 Apr 2026 08:25:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 23C55604EB;
 Fri, 24 Apr 2026 08:25:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0AE7A10720728; 
 Fri, 24 Apr 2026 10:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777019143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5+BUx2qSA912qQYrUExSpogjXL6NTO1wukuwyeTYxEg=;
 b=DwDc9Q5hEqzM/vxv94h5vObNwrcBr5XkEjcPQ5JPIrSbkbVboj8JUgz6oVETrjJ3hW1U/x
 SNLhPho6dc+EX7nk3hmdjqig1a8MyNxCRfK3Ih+TQ0vhxwxDCBSs3nfKeHGCOLwteEslzy
 C4YyxnuMhk3jhsuA3I4Xnob+c4IgllgXxw3lAdsxPMlWpnVfRmMCc3sVYMYYDBi00A3fu6
 Xmu6DuSUbmR/FRjX5VLJcaeud7CxfD5YFhdS7eyU9ERo2YaI1ZqpQdGaRnBdx+PDsobolz
 Q9Comrv9svQ+fCNUkZxKVAfDTG5u9OfwzGL7rYe0fLJb9QF0BLpBWTKr8DFNIQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 10:25:35 +0200
Message-Id: <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
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
In-Reply-To: <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
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

On Thu Apr 23, 2026 at 11:16 AM CEST, tessolveupstream wrote:

>> I had reached out to TI for clarification and any related documentation
>> updates, but I have not received any response so far.Given this, it is
>> uncertain whether we will be able to obtain further details or official
>> confirmation from TI in the near term.
>>
>> I would appreciate your guidance on how you would prefer us to proceed
>> from here.
>
> I followed up with TI, and they pointed us to the relevant sections in th=
e
> SN65DSI83/84/86 datasheets covering DSI video transmission specifications=
.

Thanks for keeping on! I'm also trying to get info from TI, I'm keeping you
up to date if that will happen.

>> https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=3D1776924088430&ref_u=
rl=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84
>
> As per datasheet Section 7.4.7, the device operates in DSI video mode wit=
h
> fixed horizontal timing, where HBP, and HFP are explicitly defined and ex=
pected
> to be present as part of the video line structure. The timing description=
 in
> this section assumes standard non=E2=80=91burst video transmission with a=
ll horizontal
> blanking intervals accounted for.
>
> The datasheet does not document support for DSI video burst mode,

This sentence seems incorrect. Section 7.4.7 starts with this sentence:
"The SN65DSI84 supports burst video mode and non-burst video mode ...".

Even though asa matter of fact it looks like many users have issues that
get solved by disabling burst mode.

> nor does it
> mention support for omitting horizontal front or back porch intervals. In
> particular, there is no indication that the device can operate with colla=
psed
> or suppressed horizontal blanking, as enabled by MIPI_DSI_MODE_VIDEO_BURS=
T,
> MIPI_DSI_MODE_VIDEO_NO_HFP, or MIPI_DSI_MODE_VIDEO_NO_HBP.

This is correct.

We can still try to get TI feedback, but it that won't happen in, say, a
few weeks then I think we should apply this patch.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
