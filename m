Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C62C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79D310F4AC;
	Tue, 15 Sep 2026 12:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q+UaHd3T";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1881C10F4AC
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:34:54 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F814C3C;
 Tue, 15 Sep 2026 14:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1789475591;
 bh=dmPmbxFLODVFL5XWc57oIrnAam0mXnpkTtzl26pfK+s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=q+UaHd3TdQWA2/71zEVK+M9BFar1Af0JUHr/9hLhKZ6lsFg0FL2m/0DDJQcDiNALY
 nYrSkPY9dBWSU58VW8gZA/OyrBr5c3CcD09lKCIZT/Fnm0uV9bS0O8CyapUU9kE04d
 Q13zofy5OZp/Sw3VlAtsk9zIc2KxAVHsYL6+97R8=
Message-ID: <e7ad2d09-f84b-4e69-b0f5-a7409ceb4c14@ideasonboard.com>
Date: Tue, 15 Sep 2026 15:34:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/33] drm: Implement state readout support
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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

Hi Maxime,

On 07/09/2026 16:23, Maxime Ripard wrote:
> Hi,
> 
> Here's a series that implement what i915 calls "fastboot", ie,
> initializing the initial KMS state from the hardware state at boot, to
> skip the first modeset if the firmware already set up the display.
> 
> This series creates the infrastructure in KMS to create that state by
> relying on driver specific hooks. It also implements some infrastructure
> to check during non-blocking commits that the readout helpers work
> properly by reading out the state that was just committed and comparing
> it to what was supposed to be committed.
> 
> This relies on another set of driver hooks to compare the entities
> states, with helpers providing the default implementation.
> 
> It then implements the readout support in the TIDSS driver, and was
> tested with the SK-AM62 board. This board in particular is pretty
> interesting, since it relies on an DPI to HDMI bridge, and uses the
> drm_bridge_connector infrastructure.
> 
> So the readout works with the current state of the art on embedded-ish
> platforms.
> 
> Unlike the earlier RFCs, it now works fine: the state is picked up
> properly, doesn't trigger a modeset if what was programmed is the one
> the first modeset tries to pick as well, will switch properly if it
> isn't, etc.
> 
> Let me know what you think,
Thanks for working on this. I tested the earlier versions sometime in 
the beginning of the year, and finally found time to look at this again.

I'm testing on AM62-SK, with HDMI and OLDI (separately and together, 
u-boot enabled and not enabled), and I've found multiple issues.

Some of the issues are quite obvious, like OLDI bridge and panel_bridge 
missing the SRO support. Some are related to using tidss with multiple 
displays (or just one, but the "wrong" one enabled in the u-boot), but 
the current code expects just the HDMI to be in use. And I think there 
are a few on the framework side too.

So far I've been just hacking through the issues, so I don't have 
anything to share. I just wanted to tell I'm working on this, and 
hopefully late this week or next week I can share my findings, or 
perhaps even proper patches.

But I can already see that it's (almost) working, so good work =).

  Tomi

