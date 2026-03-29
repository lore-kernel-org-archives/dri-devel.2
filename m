Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3670F3D60E
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 18:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDAE110E055;
	Sun, 29 Mar 2026 18:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Hn4DuNEE";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99EE410E03A
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 18:30:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DB00111DEF; Sun, 29 Mar 2026 20:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774809000;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=OKLfPcrbiTzD/KA37po52kxMaLg/n3Rjd1MI3Z8MQH8=;
 b=Hn4DuNEE5QITrI1FkuQkivurMWTftugoayrXrgCCf1NMegARtQYHRjGDWnur04fo7hwZhZ
 bm1saP0oXCY4rKPfbhYNCx3Bi0daXYg4fWFjwpBJw4F5w29h5C/JYVu1zpxf6YucvyLzjE
 DwDI65ojZdpVU1elWnFzDTy26OMsWguV5uMO5HTYjaz7XvO7FdJ9ZeIEcd9yBdjFnLoWtA
 xI9qcE5RxwJwDbxpP1raTXg/kKjg+PUrX0cBiqoJDFK1y7Y7d6FtnIz8CEtYpVXxWOPSxX
 BhRcZ8QcTU7NWUsrtSUdDjwUg108xeC5B9uds9mJVQ4WE5BOS1lyTDMpXR9pWg==
Message-ID: <0d7c7403-4b77-42f3-82d6-eaf2be8e5b1e@nabladev.com>
Date: Sun, 29 Mar 2026 20:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
To: Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/29/26 7:42 PM, Marco Felsch wrote:

Hello Marco,

> sorry for not writting back earlier, the last weeks were quite busy.

Tell me about it ...

> On 26-03-29, Liu Ying wrote:
>> LDB's parent device could be a syscon which doesn't allow a reg property
>> to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
>> has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
>> without a reg property(LDB is also a child device of the Media blk-ctrl).
>> To make the LDB schema be able to describe LDBs without the reg property
>> like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> 
> NACK, we want to describe the HW and from HW PoV the LDB is and was
> always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
> 
>> Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> 
> Therefore I would just revert this patch completely.
Last time, I pointed out the hardware is part of syscon, but as a 
subnode and therefore with reg properties. What is the problem there ?
