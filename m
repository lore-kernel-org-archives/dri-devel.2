Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DE51061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 03:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1CA10E1D3;
	Tue, 31 Mar 2026 03:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="OD2I7o/k";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB0610E1D3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:06:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D7CD4112865; Tue, 31 Mar 2026 05:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774926405;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mgMBTD9z6x6OAJbl8sZRaF9Qn7eVIlVpcZc5WYtqUoE=;
 b=OD2I7o/kdydIm4eYzKrEiv/Q5++qFkip8hBr5lxiJ3zA+4wdF7rHHmphP5cz8XMnIlBjgT
 Tuzn2tLAk6GtCGxeaw8rAcSOWKn5VSq5wazTky1An1Bd5yNOtBXE52PyfXKZLX2z+BFm4E
 qpt/9dNtclfUUYxmKgB2ugzJ7S0j77YaXYM9fe02SaxgjPA5wnUqW185ujwj8MkD+kxf+U
 +P9Jyhi9O7xtOZ4UIJwMCuId29XFJ1VSofTOfIompluoeDcvaVGgYmhH17jrm3nOGh0f9G
 zoI3nzMLDQWyOCDmTyN3Pos7ETu3ia8dD4WT58gwqHpOX+OGLa6SekA+jqojbw==
Message-ID: <bc7d5955-600a-48eb-b897-3928ace275a5@nabladev.com>
Date: Tue, 31 Mar 2026 01:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
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
 <0d7c7403-4b77-42f3-82d6-eaf2be8e5b1e@nabladev.com>
 <excxf6kxwx44kepc22smvvnirptc4kxpubioxoto7nqleqhoiq@ymch4y6dd5n5>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <excxf6kxwx44kepc22smvvnirptc4kxpubioxoto7nqleqhoiq@ymch4y6dd5n5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/30/26 8:29 AM, Marco Felsch wrote:

Hello Marco,

>>> On 26-03-29, Liu Ying wrote:
>>>> LDB's parent device could be a syscon which doesn't allow a reg property
>>>> to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
>>>> has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
>>>> without a reg property(LDB is also a child device of the Media blk-ctrl).
>>>> To make the LDB schema be able to describe LDBs without the reg property
>>>> like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
>>>
>>> NACK, we want to describe the HW and from HW PoV the LDB is and was
>>> always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
>>>
>>>> Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
>>>
>>> Therefore I would just revert this patch completely.
>> Last time, I pointed out the hardware is part of syscon, but as a subnode
>> and therefore with reg properties. What is the problem there ?
> 
> To quote the DT spec here:
> 
> """
> The reg property describes the address of the device’s resources within
> the address space defined by its parent bus.
> """

That parent bus would be the syscon, wouldn't it.

> The parent bus is not the parent iomuxc (i.MX6X) nor the blk-ctrl
> (i.MX8MP/93) device. Therefore this is wrong IMHO and should be dropped.

How so ? What is the parent bus ?
