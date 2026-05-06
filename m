Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511A2CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC7E10E4F4;
	Wed,  6 May 2026 07:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gD2bM5JA";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3398210E4F4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 07:55:13 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF58478E;
 Wed,  6 May 2026 09:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778054108;
 bh=c1/AoiVlEYG79xm3rIJLDAWWiIopLEoJhCEdl0A7TCs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gD2bM5JADF/XtIAkyDij6TK+gNJZEqyWAw6g+mPf1Gv6J6vMBWVdLyQhxsmoCQc5x
 zJynw1vCkdPVfMnRtZRWybCWK3ypcjFbI7MsPQ8ed6goQL+hegKUq7ttoMDVowFSmq
 nkt94/vmXyTRCQDCmON5haNI/Z3ECRwh/TCGea2s=
Message-ID: <cfc703b5-012a-49ab-a42c-ff99c3ba6256@ideasonboard.com>
Date: Wed, 6 May 2026 10:55:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] drm/bridge: tc358768: Long command support
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Dmitry Osipenko <digetx@gmail.com>
References: <20260311-tc358768-v2-0-e75a99131bd5@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260311-tc358768-v2-0-e75a99131bd5@ideasonboard.com>
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

Hi all,

On 11/03/2026 09:48, Tomi Valkeinen wrote:
> This series makes some small improvements to the tc358768 driver, and
> then adds support for long commands, commands that have more than 8
> bytes of payload.
> 
> This has been tested on Toradex Verdin AM62 board, with a ST7703 based
> DSI panel which requires initial configuration using commands that have
> 8+ bytes.
> 
> I tested the following combinations, by observing the panel visually and
> the DSI lanes with an oscilloscope:
> 
> - HS command transfer, continuous clock
> - HS command transfer, non-continuous clock
> - LP command transfer, continuous clock
> - LP command transfer, non-continuous clock
> 
> All except LP + continuous clock work fine. While observing the lanes
> with normal oscilloscope is a very high level and vague view of what
> exactly is going on the lanes, it still looks good to me: initial
> commands are sent in LP, and then video data is being sent in HS, and
> clock lane is continuous. However, the panel stays black, so something
> is not quite right.
> 
> As it doesn't make sense to send commands in LP during initial
> configuration, especially with longer commands, I will leave that
> particular combination unresolved. I'd be interested to hear if it works
> on some other panel.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v2:
> - Add reviewed-by & tested-by tags
> - Rebase on v7.0-rc2
> - Link to v1: https://lore.kernel.org/r/20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com
Any further comments from anyone? I don't see a specific maintainer for 
this bridge chip, so if there are no comments I'll push this to drm-misc 
in the coming days.

  Tomi

