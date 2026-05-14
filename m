Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469EDCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37C110E5E9;
	Thu, 14 May 2026 12:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="d7BamG/8";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E123810E5E9
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:42:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F18E610CF24; Thu, 14 May 2026 14:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778762550;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=jfgRv5pAT5KUi8yA/K4qBUoW9PFLUAs7IXTAEOVarg8=;
 b=d7BamG/83Fwznq8MDxUnMhZDJrFHWpFpnKbh6NUc9yAwHZh/YzKnV70njY7ZjDgDb0gqKj
 D7/CN4Eykq5uGCAdE/FKQyFoV8jWRHmlw8LYVujRGNyxOlXe7XlimYwRyzOfHNX8OUhfS3
 CsFp5AY/LewgFfUQ34PwQ/QhaEKbr+yv65c+U2/AR4AJH0npL0sNiggm+2nDHu1l+qRbA0
 aX1X7wm4lfegIhcDTEhUz4Ci1xEW5tv4SMKgkzMJASsd3BoZe+ytPKBEpr91nkyX1ue9TM
 f6jSslPqgv+qKepmNShDJVEX1Mru+BqEtXXQy7R4rg1DltU1ZddtTQ6po+a5Gw==
Message-ID: <6150ef93-16e8-41e1-8cfb-53313e2cb924@nabladev.com>
Date: Thu, 14 May 2026 14:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
To: =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <bstruempfel@data-modul.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
 <20260513133127.376458-3-bstruempfel@data-modul.com>
 <8bf05bf2-66a3-49e0-972e-4ab7ad9f0ff0@nabladev.com>
 <agWuyCxPqwZ4ztVF@DATAMODULBOERGELINUX>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <agWuyCxPqwZ4ztVF@DATAMODULBOERGELINUX>
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

On 5/14/26 1:20 PM, Börge Strümpfel wrote:
> On Wed, May 13, 2026 at 03:45:43PM +0200, Marek Vasut wrote:
>> On 5/13/26 3:31 PM, Boerge Struempfel wrote:
>>
>> [...]
>>
>>> @@ -666,6 +675,26 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
>>>    
>>>    	ctx->panel_bridge = panel_bridge;
>>>    
>>> +	ctx->lvds_hsdrv_isel = 8; /* default: 25 uA */
>>> +	ret = of_property_read_u32(dev->of_node, "drive-strength-microamp",
>>> +				   &microamp);
>>
>> if (ret && ret != -EINVAL) {
>>     ... error handling ...
>>     return ret;
>> }
>>
>> Then you won't need the if (!ret) conditional and can reduce indent.
> 
> Thank you for this suggestion. We will than need to do the lookup even
> in case of no value being supplied, but that would make the code
> cleaner. Therefore I am changing this in v3.
of_property_read_u32() returns -ENODATA if property does not have a 
value -> the error handling above would detect that.
