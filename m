Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB679CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4409410E33E;
	Wed, 13 May 2026 17:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Gf2aHnEJ";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD79B10E33E
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:51:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C499E115A05; Wed, 13 May 2026 19:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778694686;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3LXTTwyb/4IPwWWf7g8WjGMlPAqWhO3kCdoylPgOg38=;
 b=Gf2aHnEJ0B3SocHB1n5bPTGPtLv8OuBVC7J5y1iA+Opz9x5/m2JeZyKs+Y5CdMlLm0bb7A
 WT9DcGsVMy++QrL49aHyYBHXx+8JNtdhAAIGbqcAvk2qFe5CBFvYcqWXy0AOeUFsYcRKck
 Yn0Vv0yMdK7RdntS/Joh8BOYBP4G4gQIb5N70sclPUCfLcyxAq7+UXAYdFPkT9UbG8HgZ4
 FOp/dOdC6miY+MMKYSj7OgrDzmlDM/RIFC6rvJqIbIgYD9k8xZ/7C3XzEnRbasn55BcVP7
 FfEmq2rN0LiRGJWiwQN3ZYQO2SswIOij+7xD7kamapHI5fRxlK6XxITVNL+iZA==
Message-ID: <271d1839-e372-4f5b-84bc-29fe30b928a8@nabladev.com>
Date: Wed, 13 May 2026 15:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: display/bridge: lt9211: Add
 drive-strength-microamp property
To: Boerge Struempfel <bstruempfel@data-modul.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
 <20260513133127.376458-2-bstruempfel@data-modul.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260513133127.376458-2-bstruempfel@data-modul.com>
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

On 5/13/26 3:31 PM, Boerge Struempfel wrote:
> Add the 'drive-strength-microamp' property to allow board DTs to
> configure the LT9211 LVDS TX output driver current. Sixteen discrete
> levels are supported, ranging from 12 uA to 36 uA. Defaults to 25 uA.
> 
> Signed-off-by: Boerge Struempfel <bstruempfel@data-modul.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
AB goes before SoB line.
