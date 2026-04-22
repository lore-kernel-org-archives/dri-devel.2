Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD51FAD3E7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 03:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449E510EAE0;
	Thu, 23 Apr 2026 03:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VyC1jTh/";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE02810EAE0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 03:02:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6B2C9114A90; Thu, 23 Apr 2026 05:02:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1776913335;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xiFEKeCsdo+y2ee5HJM+LRR1fAE5qMPwg40kViy+gKk=;
 b=VyC1jTh/dJ4kXDxQG6/VyAsDkfcdE26VgkLNG90PIEdrIyozpD5hZvRRQmo+n4UxEjb4Tj
 f3Yj9iSs1ooXKcN1xkplUYbI1IukaXSeyMgUiZQR40kIu/f636g1S8iTgavgojWkFRup/q
 CQaMmJZnzMPqa6E37CdXplW+fycAhJgnXbIpl5pw9hv1iZXiNvqSnpETezGGbW4GCO31ks
 KGrFVHODvY8aQZAIdujQRTZajn057lw7N/OEWSWiX885UBy/cTCgmBotm8kQUF+a4/0094
 nJOTsirSYrDr+AEgv6/htl6oVHPHw3esAJDX5avH8yUfndLYwaxK1V6DC1SX4w==
Message-ID: <80f05d8c-ca09-4ef0-8e1d-f0f35436029b@nabladev.com>
Date: Wed, 22 Apr 2026 21:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: display: bridge: lt9211: Require
 data-lanes on DSI input ports
To: dri-devel@lists.freedesktop.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
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
Can this be applied to drm-misc now ?

Thank you
