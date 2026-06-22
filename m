Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BB6CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CFE910E4F7;
	Mon, 22 Jun 2026 07:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EQofUDfM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E3210E4F7
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:45:22 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2047E1E6;
 Mon, 22 Jun 2026 09:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1782114283;
 bh=IkTPCHvEioAxfxsxs7ThkxHSAlmvNwLjgp44PquHBQ4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EQofUDfMG6gszVwnDP+Jsvb5vJrKsPutcRFm4tPP7I65STlFhtfQUOyLXhBrsWVVc
 hLxXUua1NGJD9zJMRa1xxYSIvd4ul3tf+icIpclAOl2sjWJiOwf5yt1jjdj0iNLV8t
 IStb4/Pwge9/5zb3xHaL9izot6OJZtYn238cpok8=
Message-ID: <25115d05-5868-45d5-9110-695347948a1f@ideasonboard.com>
Date: Mon, 22 Jun 2026 10:45:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] drm/bridge: tc358762: Drop SPICMR write
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-5-6698b55008b9@ideasonboard.com>
 <20260619082350.2ebc0cf7@kemnade.info> <20260621084150.6ea494ff@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260621084150.6ea494ff@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 21/06/2026 09:41, Andreas Kemnade wrote:
> On Fri, 19 Jun 2026 08:23:50 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
>> On Wed, 13 May 2026 16:10:14 +0300
>> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
>>
>>> Drop write to SPICMR. It's unclear why the write is there, as SPI is not
>>> supported in the driver, and it's mostly just writing zeroes to already
>>> zero fields (reset defaults). None of the zero bits written disable
>>> anything wrt. SPI.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>   
>> Comparing it with something out of tree where SPI is apparently working.
>> It does not touch SPIMR,
>>
> ok, looking what that code really does, it sets bit 1 called SPI_SEL_CS0,
> apparently in that register. But that belongs into an spi_init function.

Sorry, what sets bit 1? The write removed here just writes zeroes to a 
register that's all zero by default, so it's basically a no-op unless 
someone else has touched the register. And as SPI is not supported in 
the driver, I think it's better to drop the write to not give any false 
ideas of SPI support.

  Tomi

