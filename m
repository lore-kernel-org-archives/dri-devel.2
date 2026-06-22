Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14145CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752E810E4F4;
	Mon, 22 Jun 2026 07:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d6kRYcQe";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C24E10E4F4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:38:52 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72884B5;
 Mon, 22 Jun 2026 09:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1782113893;
 bh=xHky49DjA9hNfJeul78t0C6Wk4Day9cAucKSa+rFYvk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d6kRYcQelaZhy1Ja4XNKEw1o1JpF0DZphSUGCBdNf2XSLuuucX29EwwsK1ISsR528
 5ZeCCi+glIz9LQIu8TZlwVfxMumbPKKQg6+Y/pgrfSGnnepVWPCloBk4V/t6OTc0Fn
 1T4ZY0gDHwmORk4K4hKZYXKieWXFTw0vyoPuJgIM=
Message-ID: <95468a76-b702-4590-87b4-c507b696af5c@ideasonboard.com>
Date: Mon, 22 Jun 2026 10:38:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] drm/bridge: tc358762: Move tc358762_init() into
 tc358762_enable()
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
 <20260513-tc358762-fixes-v3-10-6698b55008b9@ideasonboard.com>
 <20260529212127.6cf70ac3@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260529212127.6cf70ac3@kemnade.info>
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

On 29/05/2026 22:21, Andreas Kemnade wrote:
> On Wed, 13 May 2026 16:10:19 +0300
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> 
>> The only thing tc358762_enable() does is call tc358762_init(). Inline
>> the tc358762_init() into tc358762_enable(), for simplicity and to make
>> it easier to improve the tc358762_enable() in the following commits. No
>> functional change.
>>
> 
> hmm, isn't video already on in _enable? I guess  before using high speed mode,
> don't we need to have configured the dsi interface relevant registers (lanes, etc.).

Sorry, I don't understand what you mean here. This patch just moves the 
tc358762_init() into tc358762_enable() function.

  Tomi

