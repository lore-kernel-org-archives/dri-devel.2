Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B7D1075269
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 02:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B11410E24A;
	Sat, 21 Mar 2026 02:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="UOymTUMy";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7025C10E24A
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 02:40:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3AF90108FD3; Sat, 21 Mar 2026 03:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774060855;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kCrISU8qUqhXPQFXdM70vx2YEH0Zd5UhU/XwvPSjs8E=;
 b=UOymTUMyyQajREmRrKK96xJmXuv1p2B/7ypsxU+yvZOqmNQu7D7Uy746nt9UaVHFKJ9Xbt
 KgWCTYxpqf66Hi63yJZZklSAWUDNScESYl9YZ4WGtgUhtsU1ZNHxuIaeU+bOJHPZeZidE3
 QLG22x4lLAoeXkJCO8htwfA8O9z02zfkHMWfG6BKC6bjE5PvcJtIDZjskwNastBvbay6L+
 pOENrRmQ/ocNH1PXqLb8p0XOL3Z3kzeLXAOU+CR8YdFg56bNKmUeWC+wPnmGaVje87zzjk
 445qYaSYfHhhm93YPNA1bWRStREPhBx6n3ITd+BPjk5shE+WQo2mNXdbd6sLjQ==
Message-ID: <4e75f1d3-29ff-46a2-adb5-78a08f781834@nabladev.com>
Date: Sat, 21 Mar 2026 03:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Liu Ying <victor.liu@nxp.com>, imx@lists.linux.dev,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-1-bec5c047edd4@oss.nxp.com>
 <b7968f1a-c4bc-4bad-bcf8-407ff2d8db27@nxp.com>
 <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
 <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
 <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
 <xqy67fmh42k26iagl7wqrh2dbsn7c5fytwbkcksfzagefp327j@s5hg4lpuvy3q>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <xqy67fmh42k26iagl7wqrh2dbsn7c5fytwbkcksfzagefp327j@s5hg4lpuvy3q>
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

On 3/20/26 9:23 AM, Marco Felsch wrote:

Hello Marco,

>> The LDB driver was always written with parsing 'reg' out of the DT, so
> 
> Not sure what you mean by always.

By always, I mean since the very beginning.

> I re-checked the imx6qdl.dtsi which
> uses the ipuv3/imx-ldb.c driver. These platforms don't use the 'reg'
> property either.

Which is a different driver, although for a similar IP. We are however 
currently talking about drivers/gpu/drm/bridge/fsl-ldb.c , right ?

>> encoding the register offsets into the driver was a mistake. The LDB
>> controls two registers, which can be comfortably described in DT.
> 
> Sorry but I have to disagree on this. It's no about if it's possible,
> it's about if the abstraction is correct and IMHO the LDB is just one
> subdevice of the syscon. For i.MX6SX the syscon is the iomuxc-gpr for
> the i.MX8M and i.MX9 this is now a blkctrl.

Right, and the "reg" DT property specifies at which offsets are the LDB 
control registers from the start of that blkctrl. What is the problem 
with that ?

Look at e.g. imx8mp.dtsi as an example with blkctrl and LDB as a subnode 
with "reg" DT properties:

1938                         media_blk_ctrl: blk-ctrl@32ec0000 {
1939                                 compatible = 
"fsl,imx8mp-media-blk-ctrl",
1940                                              "syscon";
...
2003                                 lvds_bridge: bridge@5c {
2004                                         compatible = "fsl,imx8mp-ldb";
2005                                         reg = <0x5c 0x4>, <0x128 0x4>;
2006                                         reg-names = "ldb", "lvds";
