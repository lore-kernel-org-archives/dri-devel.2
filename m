Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EC6FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E759110EC9D;
	Tue, 28 Apr 2026 13:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1b2DowR6";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F58310EC9D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:53:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D71B94E42B56;
 Tue, 28 Apr 2026 13:53:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A090F601D0;
 Tue, 28 Apr 2026 13:53:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C28410728C3C; 
 Tue, 28 Apr 2026 15:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777384416; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mi11yIAKIeUtq1BstSRzJLBfPBpY7CpkArje5as7Flw=;
 b=1b2DowR6+l483OumXJsOi9RuRKuwGfgpP6qQ9aP93gJb5bkBB1iEofOoFTFpEBHvtAg1aC
 F52wa8jZJxXmACT+s6pZgeAvRJ3ASqE/KD7AyBIjIJKJncz0iR2cmdWCPHeW/68USn6Tu6
 iyEwwGmUJOHPiVWnygRdTuir3lf1vlWx0nqNbrv2gZtGZNu7A7tw4fj5HQo/8sVFRhXiFR
 0pzr9osvlwr7UXb5yPlWgWdIBvcNbZVrO96eayX7rpZGKYHCyZJeo1rXvCEvIFnkmV+bzo
 o4aGLUXTsuXGJIh395YwzezFbNnKhSwdfTwTjpt8VohTmRU5TFN0NRH3y39nwQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 15:53:27 +0200
Message-Id: <DI4U6SPMW5GG.34DH11UKWPUEX@bootlin.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Tian Tao" <tiantao6@hisilicon.com>,
 "Xinwei Kong" <kong.kongxinwei@hisilicon.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "John Stultz" <jstultz@google.com>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Michal Simek"
 <michal.simek@amd.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>
To: "Gyeyoung Baek" <gye976@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 07/11] drm/bridge: lt9611: switch to
 of_drm_get_bridge_by_endpoint()
X-Mailer: aerc 0.20.1
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-7-4300744a1c47@bootlin.com>
 <CAKbEznt-PUvg48tegibw+0xYCCvK+1jwESnuHx9+MG0p3MD5gA@mail.gmail.com>
In-Reply-To: <CAKbEznt-PUvg48tegibw+0xYCCvK+1jwESnuHx9+MG0p3MD5gA@mail.gmail.com>
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

On Tue Apr 28, 2026 at 3:18 PM CEST, Gyeyoung Baek wrote:
>>
>> @@ -1058,7 +1057,11 @@ static int lt9611_parse_dt(struct device *dev,
>>
>>         lt9611->ac_mode =3D of_property_read_bool(dev->of_node, "lt,ac-m=
ode");
>>
>> -       return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &l=
t9611->next_bridge);
>> +       lt9611->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev=
->of_node, 2, -1);
>> +       if (IS_ERR(lt9611->bridge.next_bridge))
>> +               return PTR_ERR(lt9611->bridge.next_bridge);
>> +
>> +       return 0;
>>  }
>
> Hello Luca,
> Could you take a look at this alternative?
> ------
> struct drm_bridge *next_bridge =3D
>     of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
>
> if (IS_ERR(next_bridge))
>     return PTR_ERR(next_bridge);
>
> lt9611->bridge.next_bridge =3D next_bridge;
> return 0;
> ------
>
>  I think it reads a bit cleaner and avoids holding the ERR_PTR in the str=
uct.

Yes, but more verbose.

Based on this and the patch 8 fallback reported by Biju, I started
wondering whether the v1 version of this function, while being a bit ugly,
was leading to cleaner code... An example: [0].

Dmitry, your opinion?

[0] https://lore.kernel.org/all/20260413-drm-bridge-alloc-getput-panel_or_b=
ridge-v1-6-acd01cd79a1f@bootlin.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
