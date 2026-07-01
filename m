Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5CDC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1FF10E30A;
	Wed,  1 Jul 2026 06:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j4v9iG2F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FD610E30A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:53:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB4DD403E4;
 Wed,  1 Jul 2026 06:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0383C1F000E9;
 Wed,  1 Jul 2026 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782888798;
 bh=lZ+udqVIluSYBeOCKXukOv71mZNtvaTQQLcm7V1DnVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=j4v9iG2FinLdFar0grVOb2kDdfriPOXj/QhlWDM/mMRB1SfBTIBMXisCzuQD5HzJl
 5cJUOGONJQvlesk17pZtYfqiwq2i5zv5TBgLu0BtpIGaonS0Bi5CHDzkuP5OMUzdbN
 YFnhg9u6qEzRgJwH82rY2fyZWE714Tz/uChTjyQXI3DxBRYyYC3V0baAF6o6+GOLp9
 t8MdGh4t/r1WaDIM78tdBllOBTFjxzP2My32MQGH6EMA2lrjh1rMQhp/LzcJBQX4wz
 Uu4/jiVpke+gbXzGscXiDc1HRb6dKGxOdixTHUAXUIFLCROUiEZS4X8vUmAG3L6iQx
 7O9jKKI4jPTIg==
Date: Wed, 1 Jul 2026 08:53:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yashas D <y-d@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 luca.ceresoli@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, tomi.valkeinen@ideasonboard.com, 
 dmitry.baryshkov@oss.qualcomm.com, kees@kernel.org, xiqi2@huawei.com,
 r-ravikumar@ti.com, 
 sjakhade@cadence.com, yamonkar@cadence.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, u-kumar1@ti.com,
 devarsht@ti.com, s-jain1@ti.com, d-mittal@ti.com, b-padhi@ti.com
Subject: Re: [PATCH v4 1/2] dt-bindings: display/bridge: cdns-mhdp8546: Add
 no-hpd property to the cadence bridge
Message-ID: <20260701-red-nautilus-of-masquerade-8fea13@quoll>
References: <20260630102610.1849902-1-y-d@ti.com>
 <20260630102610.1849902-2-y-d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630102610.1849902-2-y-d@ti.com>
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

On Tue, Jun 30, 2026 at 03:56:09PM +0530, Yashas D wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> The mhdp bridge can work without its HPD pin hooked up to the connector,
> but the current bridge driver throws an error when hpd line is not
> connected to the connector. For such cases, we need an indication for
> no-hpd, using which we can bypass the hpd detection and instead use the
> auxiliary channels connected to the DP connector to confirm the
> connection.
> So add no-hpd property to the bindings, to disable hpd when not
> connected or cannot be used for hotplug detection.

Subject prefixes: There is no such file cdns-mhdp8546. I already pointed
this out at v2. This is a nit, but I do not understand why the same
feedback has to be repeated third time (v3 also ignored it).

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Best regards,
Krzysztof

