Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E794C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645C710EE2B;
	Wed,  5 Aug 2026 12:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Yv5qsfpz";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C015410EE2B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785934619; x=1786193819;
 bh=YzaFEyDD8H+zTknUcCTt8BeOjFG68msT6YLRjbHU41w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Yv5qsfpzIte4EVCdvFHk3NmcpU547ZmHh3lBm9pqFWdEN1TeUTNuuS4MWB4U90mHA
 CzmBS5wXgBrTBhLNMaQ5ptISejwUXnCthshFSv/FX6fOoHOLF+07HS283oBqWZUUHK
 lXCWKd4d1mPTlTdOOLb9r2VrPMDGsZhO33ypDd1XPM1iAR6FpOc89rhRigYa1icx1V
 iqozGyHAeaJacU4cULJbSnPIdhK45X0mWOCjsTtnmsOh4jplDQmr7vdFiCnQFfG2AT
 Phn2eJzJcfhJ5rhxi7eyNeRK38ftrsnUGU38IPiWMzl4kraho4eJ1NoqaXwdwCwB7R
 cEYmC90gmc+kQ==
X-Pm-Submission-Id: 4hFVmS65q8z1DDWb
From: Esben Haabendal <esben@geanix.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>,  "Neil Armstrong"
 <neil.armstrong@linaro.org>,  "Robert Foss" <rfoss@kernel.org>,  "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman"
 <jonas@kwiboo.se>,  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync
 override
In-Reply-To: <178591896149.480618.5962943390958440515.b4-review@b4> (Luca
 Ceresoli's message of "Wed, 05 Aug 2026 10:36:01 +0200")
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
 <20260803-nwl-dsi-fixes-v2-1-1809a0ac453f@geanix.com>
 <Jb_qvmYIj-0DFMeAnqaz2oCmBeH7K1Ky1b_-z9W3h561MIAMNCaMDgY5ECzYUMfIVuTFnCKcKqy3Z1ndSCswWA==@protonmail.internalid>
 <178591896149.480618.5962943390958440515.b4-review@b4>
Date: Wed, 05 Aug 2026 14:56:55 +0200
Message-ID: <871pccbu94.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

"Luca Ceresoli" <luca.ceresoli@bootlin.com> writes:

> On Mon, 03 Aug 2026 16:56:19 +0200, Esben Haabendal <esben@geanix.com> wrote:
>
> Hi Esben,
>
>> When using DCSS with NWL, overriding the mode flags to enforce active high
>> sync is preventing the use of active low with downstream bridges, such as
>> ti-sn65dsi83, which will not see such mode flags set by the panel.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> Is this a fix? If so, it should have Fixes: + Cc: stable.

Yes. I will add tags.

>> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
>> index 09992529f3d8..0fb10b686d1f 100644
>> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
>> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
>> @@ -821,10 +823,13 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
>>  				       struct drm_connector_state *conn_state)
>>  {
>>  	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
>> +	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>>
>>  	/* At least LCDIF + NWL needs active high sync */
>> -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>> -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
>> +	if (dsi->endpoint == NWL_DSI_ENDPOINT_LCDIF) {
>> +		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>> +		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
>> +	}
>
> In some sense, this patch is doing two things. One is the hunk above, doing
> what the commit message says...
>
>> @@ -1103,11 +1107,12 @@ static int nwl_dsi_select_input(struct nwl_dsi *dsi)
>>  				      "No valid input endpoint found\n");
>>  			return -EINVAL;
>>  		}
>> +		dsi->endpoint = NWL_DSI_ENDPOINT_DCSS;
>>  	}
>
> ...and this is a somewhat orthogonal change, changing the way the endpoint
> selection is stored: either as a bool (false = LCDIF, true = DCSS) or as an
> index (0 = LCDIF, 1 = DCSS). No problem with this change, I think it makes
> code more readable. Just I'd rather keep it as a separate cleanup
> patch.

I will split it into two patches.

>>  	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
>> -		     (use_dcss) ? "DCSS" : "LCDIF");
>> -	ret = mux_control_try_select(dsi->mux, use_dcss);
>> +		     (dsi->endpoint == NWL_DSI_ENDPOINT_DCSS) ? "DCSS" : "LCDIF");
>> +	ret = mux_control_try_select(dsi->mux, dsi->endpoint == NWL_DSI_ENDPOINT_DCSS);
>
> The code here is not formally correct. mux_control_try_select() takes a
> state argument, which is an integer, but you are passing a bool. It would
> still work just because bools are mapped to 0/1. Looks like should simply
> become:
>
> 	ret = mux_control_try_select(dsi->mux, dsi->endpoint);

Fixing, thanks.

/Esben
