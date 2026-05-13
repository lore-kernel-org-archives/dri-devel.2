Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1512ACD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A31310E2FE;
	Wed, 13 May 2026 11:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="b9lvXIU0";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502FF10E2FE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:33:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB83D106308; Wed, 13 May 2026 13:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778671986;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=j5ITm7R7s1aHVjiSOgAJ7t7iQ6cNC224p19NsnVO0qk=;
 b=b9lvXIU0g7qmVXmoOGL3PL/7ib44JYd41OxFzVVugFKsf8P43t97vGwb6Iouc536PMvLJ1
 zDbhJOyO+dATRbZ3LGtcDtHnGjPYMya+wPGG/VUoZwU2gk8i77AXzrI+wrcCsZy1sv/VsE
 WeaI2AqKY0wnG77Yp0WnmXQkMj0+PBhqHvkM2p3YVXaryghoGzmodey+YYpyt9MShDaPJv
 d1sQCHLbOY7eOt3pIoyxTfaEsZWuKkCa/UpztB3WsCfyhniRqFpZT52ufXktM+51RfTqH/
 WiClZL+8vZvNcrz2qRNXNhPV8dlm1hufborS4P05G03g72gHJhXpRDlMoLwQRw==
Message-ID: <eb0b8aa2-a728-4e66-80b1-4c7ef37d24dc@nabladev.com>
Date: Wed, 13 May 2026 13:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
To: =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <bstruempfel@data-modul.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512164609.3390700-1-bstruempfel@data-modul.com>
 <20260512164609.3390700-3-bstruempfel@data-modul.com>
 <dff39a7a-a25c-4565-ad20-48026995af11@nabladev.com>
 <agQ4pVGFEMGaMqgc@DATAMODULBOERGELINUX>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <agQ4pVGFEMGaMqgc@DATAMODULBOERGELINUX>
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

On 5/13/26 11:02 AM, Börge Strümpfel wrote:

[...]

>>> +	ctx->lvds_hsdrv_isel = 8; /* default: 25 uA */
>>> +	ret = of_property_read_u32(dev->of_node, "drive-strength-microamp",
>>> +				   &microamp);
>>
>> if ret != 0 , then what happens here ?
>>
> 
> if ret != 0, we will keep the default value of 8 (corresponding to 25 uA
> as written above), which is the behavior that the driver had previously.
> 
> According to the documentation, of_property_read_u32() will return 0 on
> success, -EINVAL if the property does not exist, -ENODATA if property
> does not have a value, and -EOVERFLOW if the property data isn't large
> enough. I think we only would need to give a warning or similar if the
> -ENODATA or -EOVERFLOW cases. However, I personally do not think that is
> necessary, as the usage is specified unambiguously in the devicetree
> bindings.
Users can pass in malformed DT, so a warning is a good idea. Thanks.
