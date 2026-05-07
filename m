Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DEECD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 17:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4068810E58F;
	Thu,  7 May 2026 17:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Irkkow00";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653A010E58F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:30:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F0E610D27B; Thu,  7 May 2026 19:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778175020;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=StTiP0jxs0ZolzZJWzr2oxQAJ/7SfQsvCtzzIQA1nNg=;
 b=Irkkow00E7a/shmRGQSvr1Qxbfo3uvhf1Vd6j+dUBVfwL+oxEY9sC56BjNF0+Ysw+fe2UX
 NczjnGrx4QdaYaurwdD0crifnnfT8Ptr9DTyDCm6DCJP0rWD/sRBrY40vJKCellYK6wm2q
 l3mX+rsYCFOxXwmaXUdJFAGal6gBrv46QENgle9XPdtuWZPOxA8vKWXc+kIUq2q359zmdG
 PbrTuOwB55EuR3u/3vtWnHmZPivoxFyFfQqy6QJBBVZzUjwBcANeQnoTT7ArjftDUa9NIp
 cuj3cS4DmosMhByxnboeL1LlKaEweurm6VtrHGl4dTYxoXQ07EuJtuIkFBi+sQ==
Message-ID: <f6175aa6-7426-4545-97d1-cffb869e016f@nabladev.com>
Date: Thu, 7 May 2026 19:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: display: bridge: lt9211: Require
 data-lanes on DSI input ports
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260407203109.34302-1-marex@nabladev.com>
 <20260408-eager-millipede-of-aurora-6fcaa4@quoll>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260408-eager-millipede-of-aurora-6fcaa4@quoll>
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

On 4/8/26 9:35 AM, Krzysztof Kozlowski wrote:
> On Tue, Apr 07, 2026 at 10:31:03PM +0200, Marek Vasut wrote:
>> The Lontium LT9211 is capable of 1..4 DSI lanes per input DSI port,
>> describe the lane count for each input port in the schema.
>>
>> For example Linux kernel driver does already use that information and
>> fails to probe if it is missing.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Can this be applied via drm-misc now ?
