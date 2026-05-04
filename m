Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A27BFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C3F10E708;
	Mon,  4 May 2026 14:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="AFI5Mvlr";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2A910E708
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:13:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 514614E42BBC;
 Mon,  4 May 2026 14:13:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 21DC25FD5F;
 Mon,  4 May 2026 14:13:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CCCB711AD27FB; 
 Mon,  4 May 2026 16:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777904023; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XsNmFR8dV4OacjfIioHdUGNm4L3AowKlSDqo2yTRzw8=;
 b=AFI5Mvlro/TMbUmDqfw6uuasM2l3dZYYZR9gYoQkon/fLCo3EvKUyNNFBC/QEdh3UsgPE0
 /7gYVYkc5TduLQZWOs7RLRZ8VBl/TUyIcFZNHzxezTrcn2J+YwTOpSLRnb/wM0M3ZcLrA9
 Lm2FueyC8nmzxUe1s1qWG5sbz1DvWaN/1LQ7cnLW6F7HbhXvVu6z9wO+ubYbEuQbNtRSvN
 LlAwzXp9TH/yhof4kNc4NJV2lcb8NApSHflSLMIdoi7+ItBAfw3SgF93mrkGrU99tsASNf
 dediVg4WLdgI85RyfhTmH6WWXJoKbLBbhcyb2krC+3W2W/beCnk+piqeWLU5YQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 16:13:32 +0200
Message-Id: <DI9YDFTUBA4R.3NBES5EAMOD03@bootlin.com>
Subject: Re: [PATCH v4 01/11] drm/bridge: drm_bridge_get/put(): ignore ERR_PTR
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
 <20260504-drm-bridge-alloc-getput-panel_or_bridge-v4-1-b578c3daaf10@bootlin.com>
 <20260504135300.GE1344263@killaraus.ideasonboard.com>
In-Reply-To: <20260504135300.GE1344263@killaraus.ideasonboard.com>
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

On Mon May 4, 2026 at 3:53 PM CEST, Laurent Pinchart wrote:
> On Mon, May 04, 2026 at 12:45:04PM +0200, Luca Ceresoli wrote:
>> Most functions returning a struct drm_bridge pointer currently return a
>> valid pointer or NULL, but this restricts their ability to return an err=
or
>> code describing the error kind.
>>
>> In preparation to have new APIs that can return a struct drm_bridge poin=
ter
>> holding an ERR_PTR (and for those which already do) make drm_bridge_get(=
)
>> and drm_bridge_put() ignore ERR_PTR values, just like they ignore NULL
>> pointers.
>
> The change in drm_bridge_put() looks good to me. I'm less sure about
> drm_bridge_get(), is there a valid use case to call get() on a bridge
> that is not valid ? Doesn't it indicate a clear error in the caller ?

Good point. Indeed I don't have a valid use case in mind.

I guess I can drop the drm_bridge_get() and send v5. Should there be a
valid use case it will emerge at some point and this can be rediscussed.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
