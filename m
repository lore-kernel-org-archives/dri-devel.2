Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC96FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 15:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695A010E73D;
	Mon,  4 May 2026 15:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XkIKiM0a";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B0E10E74A
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 15:03:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 814344E42BB3;
 Mon,  4 May 2026 15:03:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 490865FD5F;
 Mon,  4 May 2026 15:03:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E428E11AD030A; 
 Mon,  4 May 2026 17:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777907024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2UgC8WCIU3g3zHl7eHsXA9bSH7zl0jYSgtkDdHvTGK4=;
 b=XkIKiM0aiss5klmOs9rA4cy7qNODpkMXkOD6DEJTfXTUPx3dV8Kk7o77Qs4bVgp1OgUu9X
 WT2B/fTXaV0AT/4e1o5QS7JICDJ7KT87zdrVDfUDzm7PE0UtdaQvbzwQNSl/ReZRAiXtYp
 qzBEtJeWMGMEM3pgNG925NDcvtAfuXqy0ueg/0bfiWwU9z9kJHWZZcs4eBnpDyLyEidgV/
 fob3dCiVjpaSUy/s156XUWMyxekxnvAIc8u/VMtHJhq3dwOu8yZU8OWnE2Mf6/iBRB6Q3+
 1e6iOkVWoIbkDrLC3OXrqRxzK+VOCoG/72PRThDii1kNsZUUXebgh+RQIA4dWg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 17:03:34 +0200
Message-Id: <DI9ZFQUNMSBU.214AU8467OK76@bootlin.com>
Subject: Re: [PATCH v4 02/11] drm/bridge: add of_drm_get_bridge_by_endpoint()
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 "John Stultz" <jstultz@google.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Michal Simek" <michal.simek@amd.com>,
 "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260504-drm-bridge-alloc-getput-panel_or_bridge-v4-0-b578c3daaf10@bootlin.com>
 <20260504-drm-bridge-alloc-getput-panel_or_bridge-v4-2-b578c3daaf10@bootlin.com>
 <20260504145536.GA1455860@killaraus.ideasonboard.com>
In-Reply-To: <20260504145536.GA1455860@killaraus.ideasonboard.com>
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

Hi Laurent,

On Mon May 4, 2026 at 4:55 PM CEST, Laurent Pinchart wrote:
> On Mon, May 04, 2026 at 12:45:05PM +0200, Luca Ceresoli wrote:
>> drm_of_find_panel_or_bridge() is widely used, but many callers pass NULL
>> into the @panel or the @bridge arguments, thus making a very partial usa=
ge
>> of this rather complex function.
>>
>> Besides, the bridge returned in @bridge is not refcounted, thus making t=
his
>> API unsafe when DRM bridge hotplug will be introduced.
>>
>> Solve both issues for the cases of calls to drm_of_find_panel_or_bridge(=
)
>> with a NULL @panel pointer by adding a new function that only looks for
>> bridges (and is thus much simpler) and increments the refcount of the
>> returned bridge.
>>
>> The new function is identical to drm_of_find_panel_or_bridge() except it=
:
>>
>>  - handles bridge refcounting: uses of_drm_find_and_get_bridge() instead=
 of
>>    of_drm_find_bridge() internally to return a refcounted bridge
>>  - is simpler to use: just takes no @panel parameter, returns the pointe=
r
>>    in the return value instead of a double pointer argument
>>  - has a simpler implementation: it is equal to
>>    drm_of_find_panel_or_bridge() after removing the code that becomes de=
ad
>>    when @panel =3D=3D NULL
>>
>> Also add this function to drm_bridge.c and not drm_of.c because it retur=
ns
>> bridges only.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>> Changes in v4:
>> - update function declaration in non-OF case
>>
>> Changes in v2:
>> - return the bridge in the return value, not a double pointer
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 41 +++++++++++++++++++++++++++++++++++++=
++++
>>  include/drm/drm_bridge.h     |  7 +++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 6fb71de6d22a..01f9e0426648 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -1582,6 +1582,47 @@ struct drm_bridge *of_drm_find_bridge(struct devi=
ce_node *np)
>>  	return bridge;
>>  }
>>  EXPORT_SYMBOL(of_drm_find_bridge);
>> +
>> +/**
>> + * of_drm_get_bridge_by_endpoint - return DRM bridge connected to a por=
t/endpoint
>> + * @np: device tree node containing output ports
>> + * @port: port in the device tree node, or -1 for the first port found
>> + * @endpoint: endpoint in the device tree node, or -1 for the first end=
point found
>> + *
>> + * Given a DT node's port and endpoint number, find the connected node =
and
>> + * return the associated drm_bridge device.
>> + *
>> + * The refcount of the returned bridge is incremented. Use drm_bridge_p=
ut()
>> + * when done with it.
>> + *
>> + * Returns a pointer to the connected drm_bridge, or a negative error o=
n failure
>> + */
>> +struct drm_bridge *of_drm_get_bridge_by_endpoint(const struct device_no=
de *np,
>> +						 int port, int endpoint)
>> +{
>> +	struct drm_bridge *bridge;
>> +
>> +	/*
>> +	 * of_graph_get_remote_node() produces a noisy error message if port
>> +	 * node isn't found and the absence of the port is a legit case here,
>> +	 * so at first we silently check whether graph presents in the
>
> s/graph presents/graph is present/

Oh, wow. I copied this comment from elsewhere, meaning the same typo is
there too. I'm taking a note to fix those too.

> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
