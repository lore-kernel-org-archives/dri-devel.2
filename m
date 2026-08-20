Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCA8C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76B910E207;
	Thu, 20 Aug 2026 18:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ioLn+UN8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAAB10E207
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787250206;
 bh=vZXBjt3Fuoeqwtrnxnm/xTajTsbgsBlWfNGZiZ+mJ3A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ioLn+UN86yM5Af2ne1bCjJrBktr38PrR6/ZDU1/otfzSqIwstDTdrjnkYMmJyAmoy
 ot+ZPf1vM7kyRW4DAzO/YnnOrqkj2RVaUtxD9rWeCmwM/vAAyLJnqwZsoj9Guv4C0J
 9XN6YbjwgsSDtxnWw64JApMWArqYFsxU+5HPZyG8rbUdszEZW+PMHA6KOvz7rFR/nb
 m2sLZlh4LK5LXRknB4DeqhlsVzzpLusU5LPIdDTQpVgGlzwksjQnEU9P/0EVCPJH5p
 8p4LZHpWhXZ6MqvjA5V9eN+x0izEppa156rezxvf4Jv/tiGUuyJAwOeGb6DuwRxDGV
 iXozIBTUd19zw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8517A17E038D;
 Thu, 20 Aug 2026 20:23:25 +0200 (CEST)
Message-ID: <4a2c5754-56f3-42d5-863b-bc29452f8eb2@collabora.com>
Date: Thu, 20 Aug 2026 21:23:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 43/69] drm/vc4: hdmi: Propagate -EDEADLK to the top
 level
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-43-294364b2cf15@collabora.com>
 <20260820-sceptical-friendly-panther-6cdfd4@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260820-sceptical-friendly-panther-6cdfd4@houat>
Content-Type: text/plain; charset=UTF-8
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

On 8/20/26 11:55 AM, Maxime Ripard wrote:
> On Fri, Jul 31, 2026 at 07:19:50PM +0300, Cristian Ciocaltea wrote:
>> drm_connector_helper_funcs.detect_ctx() is expected to propagate
>> -EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
>> perform the required backoff and retry.
>>
>> vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
>> drm_modeset_backoff() on an acquire context it does not own.  This drops
>> all locks in the context, including connection_mutex held by the core.
>>
>> Drop the local retry logic and propagate -EDEADLK to the caller instead.
>> This aligns VC4 with the expected detect_ctx() semantics.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/vc4/vc4_hdmi.c | 23 +++++++----------------
>>  1 file changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> index ba16e7944cf3..72042fad04c5 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -344,12 +344,11 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
>>  	return drm_atomic_helper_reset_crtc(crtc, ctx);
>>  }
>>  
>> -static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
>> -				    struct drm_modeset_acquire_ctx *ctx,
>> -				    enum drm_connector_status status)
>> +static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
>> +				   struct drm_modeset_acquire_ctx *ctx,
>> +				   enum drm_connector_status status)
>>  {
>>  	struct drm_connector *connector = &vc4_hdmi->connector;
>> -	int ret;
>>  
>>  	/*
>>  	 * NOTE: This function should really be called with vc4_hdmi->mutex
>> @@ -368,17 +367,9 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
>>  	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
>>  
>>  	if (status != connector_status_connected)
>> -		return;
>> +		return 0;
>>  
>> -	for (;;) {
>> -		ret = vc4_hdmi_reset_link(connector, ctx);
>> -		if (ret == -EDEADLK) {
>> -			drm_modeset_backoff(ctx);
>> -			continue;
>> -		}
>> -
>> -		break;
>> -	}
>> +	return vc4_hdmi_reset_link(connector, ctx);
>>  }
>>  
>>  static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>> @@ -416,10 +407,10 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>>  			status = connector_status_connected;
>>  	}
>>  
>> -	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
>> +	ret = vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
>>  	pm_runtime_put(&vc4_hdmi->pdev->dev);
>>  
>> -	return status;
>> +	return ret == -EDEADLK ? ret : status;
> 
> Don't we mask any error that isn't EDEADLK here?

Yes, per .detect_ctx() doc, implementation should return either a
drm_connector_status or -EDEADLK.

This matches what the probe helpers expect, and prevents ending up with
connector_status_unknown, which would be wrong, since the detection was
successful:

int drm_helper_probe_single_connector_modes()
{
	[...]
	ret = drm_helper_probe_detect(connector, &ctx, true);

	if (ret == -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry;
	} else if (WARN(ret < 0, "Invalid return value %i for connector detection\n", ret))
		ret = connector_status_unknown;

	connector->status = ret;
	[...]
}

drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
{
	[...]
	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex, &ctx);
	if (!ret)
		ret = detect_connector_status(connector, &ctx, force);

	if (ret == -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry;
	}

	if (WARN_ON(ret < 0))
		ret = connector_status_unknown;
	[...]
}
