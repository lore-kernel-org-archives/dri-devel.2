Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20293F34C67
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC7010E4DF;
	Mon, 13 Apr 2026 17:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FAthUWkY";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB42C10E4DF;
 Mon, 13 Apr 2026 17:07:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2B6D51A31EA;
 Mon, 13 Apr 2026 17:07:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E42B45FFB9;
 Mon, 13 Apr 2026 17:07:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D876A10450150; 
 Mon, 13 Apr 2026 19:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776100046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7WhJV/dSWPhYZ6I8oCEn+1gY0fZt2y2fO4rItoVzHSg=;
 b=FAthUWkYP3onPAjkaVdhEkowM64WlLaovRGOEKVVYVlDIIxl1jy0QIhBPcrZAkGVX1XGB3
 68NsMnuFgEKyarOAkggZ9Q/mVJFT/0grRcj2UEIlJqw+b4/maFxBlEqOGBmsN83WXQx3sQ
 O/Wj97KDGpbnaLFBUBNUXU4Z/ewKqcYE2iDllMv0neZ3/YBd/UjuCgceNNDBbpTfsDg00b
 fvk52HkNhzPYI/ns2RoNU7jsja2/gO+/7butSZ244ROXKIeKkn3pFd++cEYgNsyFOD7XIr
 8VClfbu9wRVqChpcY6pZrGScJsYc8QIwKnocm2Im6J+MFhNg6YskhjYaGYjsCg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 19:07:14 +0200
Message-Id: <DHS6WZRYGWZQ.1X6ABU4UWF730@bootlin.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Xinliang Liu" <xinliang.liu@linaro.org>,
 "Tian Tao" <tiantao6@hisilicon.com>, "Xinwei Kong"
 <kong.kongxinwei@hisilicon.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 "Yongqin Liu" <yongqin.liu@linaro.org>, "John Stultz" <jstultz@google.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Michal Simek"
 <michal.simek@amd.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 01/10] drm/bridge: add of_drm_get_bridge_by_endpoint()
X-Mailer: aerc 0.20.1
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-1-acd01cd79a1f@bootlin.com>
 <u2awvqh2uoc2acuuvyavwwtuvtiaidhbkkj5a2d2wwph2s7j7g@b4j73kwzblgk>
In-Reply-To: <u2awvqh2uoc2acuuvyavwwtuvtiaidhbkkj5a2d2wwph2s7j7g@b4j73kwzblgk>
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

Hi Dmitry, Maxime,

thanks Dmitry for the quick feedback!

On Mon Apr 13, 2026 at 4:58 PM CEST, Dmitry Baryshkov wrote:

>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -1581,6 +1581,52 @@ struct drm_bridge *of_drm_find_bridge(struct devi=
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
>> + * @bridge: pointer to hold returned drm_bridge, must not be NULL
>> + *
>> + * Given a DT node's port and endpoint number, find the connected node =
and
>> + * return the associated drm_bridge device.
>> + *
>> + * The refcount of the returned bridge is incremented. Use drm_bridge_p=
ut()
>> + * when done with it.
>> + *
>> + * Returns zero (and sets *bridge to a valid bridge pointer) if success=
ful,
>> + * or one of the standard error codes (and the value in *bridge is
>> + * unspecified) if it fails.
>
> Can we return drm_bridge or error cookie instead?

(while replying I realized there is a design flaw in my implementation, but
see below)

I initially thought I'd do it, but I don't like returning an error cookie
for functions getting a bridge pointer. The main reason is that with bridge
refcounting the __free() cleanup actions are handy in a lot of places, so w=
e
are introdugin a lot of code like:

  struct drm_bridge *foo __free(drm_bridge_put) =3D some_func(...);

Where some_func can be one of of_drm_find_bridge(),
drm_bridge_get_next_bridge(), drm_bridge_chain_get_{first,last}_bridge()
etc.

Such code is very handy exactly because these functions return either a
valid pointer or NULL, and thus the cleanup actions always does the right
thing. If an error cookie were returned, the caller would have to be very
careful in inhibiting the cleanup action by clearing the pointer before
returning. This originate for example this discussion: [0]

[0] https://lore.kernel.org/lkml/4cd29943-a8d0-4706-b0c5-01d6b33863e4@bootl=
in.com/

So I think never having a negative error value in the bridge pointer is
useful to prevent bugs slipping in drivers. For this we should take one of
these two opposite approaches:

 1. don't return a bridge pointer which can be an ERR_PTR; return an int
    with the error code and take a **drm_bridge and:
      - on success, set the valid pointer in *bridge
      - on failure, set *bridge =3D NULL (*)
 2. like the above-mentioned functions (of_drm_find_bridge(),
    drm_bridge_get_next_bridge() etc) return a drm_bridge pointer which is
    either a valid pointer or NULL

(*) I didn't do it in this patch, that's a design flaw, I'll fix in case
    approach 1 is taken

Clearly option 2 is the simplest to use, but it loses information about
which error happened.

What do you think about these options?

>> + */
>> +int of_drm_get_bridge_by_endpoint(const struct device_node *np,
>> +				  int port, int endpoint,
>> +				  struct drm_bridge **bridge)
>
> Nit: can it be drm_of_get_bridge_by_endpoint?

Argh, this convention is changing periodically it seems! :-)

I previous discussions I was asked to do either drm_of_ [1] of of_drm_ [2],
but since the latter was the last one requested I sticked on it.

@Maxime, Dmitry, I'm OK with either, just let me know if I need to change.

[1] https://lore.kernel.org/dri-devel/20250319-stylish-lime-mongoose-0a18ad=
@houat/
    -> search "called drm_of_find_bridge"
[2] https://lore.kernel.org/all/DEH1VJUEJ8HQ.MIS45UOLCPXL@bootlin.com/
    -> search "What about"

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
