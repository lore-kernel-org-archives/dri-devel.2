Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10E6C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2783810F293;
	Fri, 21 Aug 2026 09:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p9Xlbrx4";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B9910F286
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:45:07 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 726751583;
 Fri, 21 Aug 2026 11:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1787305423;
 bh=GOS3Sfd6WsIo0/Gd4p9eZj3WYjUl1BAGLoVcofgedSc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p9Xlbrx4yRZeEr+M5OiXU66CzzO56nw+H+DlrS759vl6uYgxeUurwgANT46H0j8XX
 QJmph7g30madW4EG1Xd0G7Rle1Q855Qr6c7I9bCXncLCFQ2MeKXuRU8/bMg5Mfilko
 kCs+pn9JgRH8USzzwJcRTSkrO+2/jJE+Joxyx5Kk=
Message-ID: <5b90d713-ffe4-44f2-846b-cb42751310ed@ideasonboard.com>
Date: Fri, 21 Aug 2026 12:45:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
References: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
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

On 19/08/2026 20:19, Ivaylo Dimitrov wrote:
> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
> availability through the standard jack mechanism and audio policy managers
> cannot automatically route audio to or from the HDMI output.
> 
> Add an optional HPD callback to `omap_hdmi_audio_pdata` and invoke it from
> the DRM HDMI bridge whenever the connector status changes. The HDMI audio
> driver registers an ASoC jack and reports `SND_JACK_AVOUT` state changes in
> response to these notifications.
> 
> Also fix the disconnect path by taking a runtime PM reference before
> updating the CEC physical address.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/gpu/drm/omapdrm/dss/hdmi.h        |  6 +++
>   drivers/gpu/drm/omapdrm/dss/hdmi4.c       | 29 ++++++++++---
>   drivers/gpu/drm/omapdrm/dss/hdmi5.c       | 37 +++++++++++++---
>   drivers/gpu/drm/omapdrm/dss/hdmi_common.c | 14 ++++++
>   include/sound/omap-hdmi-audio.h           |  1 +
>   sound/soc/ti/omap-hdmi.c                  | 53 +++++++++++++++++++++--
>   6 files changed, 125 insertions(+), 15 deletions(-)
Thanks, picking up to drm-misc-next.

  Tomi

