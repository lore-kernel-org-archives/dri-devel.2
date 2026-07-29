Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF87C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B47710E071;
	Wed, 29 Jul 2026 21:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kvd+jQH1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA05010E071
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=v3/MF96SGkO++1sr9/6ghVoTdlNTznRSle/d00MSUy4=; b=kvd+jQH1zomdHNu0rujF74s03l
 gl+1/u2Wy/8knwRZz6qnUSe/RsZIbjliIhSVOQKOrCdGTqOJE+xEf+InnRc1N4uXIWVHrFBKU1QZj
 JSNisutrCbrmPau/6oeKWUpIkZ9sEc1xeabwF+k6sHc+4j+O8CtTWDSU7avQam/JzJKNudvIcddOC
 /dnJU9k0mGLuO6j6Sb/y//GcRN37N02kvHLAKDOz7Y0lY/JT4PXLxCpAe4EDx7yv4n91Lb5s0E1Gs
 6gvtyggsFSb/CGfeGGrYq98RpN0yf3P7uKIz5ht24SCMU0tUtvehYaAE6lUGJYEpj2UT6Od2+lPN5
 JAU5iEaQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wpBtQ-007gdO-IC; Wed, 29 Jul 2026 23:32:49 +0200
Message-ID: <342e98ea-7210-40bd-b222-ae9b1ed1c804@Igalia.com>
Date: Wed, 29 Jul 2026 14:32:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/connector/hdmi: Fix out of bounds memory read
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: kernel-dev@igalia.com, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 stable@vger.kernel.org
References: <20260723220652.533345-1-John.Harrison@Igalia.com>
Content-Language: en-GB
In-Reply-To: <20260723220652.533345-1-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Ping for review?

It might be an unlikely problem but a potential accvio with a trivial 
fix seems like something we should get merged.

Thanks,
John.

On 7/23/26 15:06, John Harrison wrote:
> A helper function was copying a given audio infoframe into the
> connector's copy but using the size of the destination (a generic
> target, sized to accept many different data blocks) not the source (a
> very specific type of data block). Thus, it was copying 60 bytes of
> data from a 28 byte allocation.
>
> Fix that by using the source size instead, together with a build bug
> on the source size actually being smaller than the destination.
>
> I hit this running KUnit tests under KASAN (while debugging something
> else entirely). In the real world, it seems unlikely to cause an
> actual problem. It is a read not a write so it can't corrupt any
> memory. However, it could potentially fall off the end of a page and
> cause an accvio bug.
>
> Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Daniel Stone <daniel@fooishbar.org>
> Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: "José Expósito" <jose.exposito89@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
> ---
>   drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index ce17eeefc2da..d6669e36ca1b 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -1142,7 +1142,8 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
>   
>   	mutex_lock(&connector->hdmi.infoframes.lock);
>   
> -	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
> +	BUILD_BUG_ON(sizeof(*frame) > sizeof(infoframe->data));
> +	memcpy(&infoframe->data, frame, sizeof(*frame));
>   	infoframe->set = true;
>   
>   	ret = write_infoframe(connector, &funcs->audio, "Audio", infoframe);

