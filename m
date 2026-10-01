Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0572DCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CEB10E3BC;
	Thu,  1 Oct 2026 22:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="TWa34CTK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2DA10E3BC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790894327;
 bh=Ce99go+3vupPq2f3UCVbyFhLf2s/xrWTlRWZdehqMnE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TWa34CTKCuZSwmN1O0YAQHIEvIZY0r45I2EIdRU1JUqdNL8avwARylakkbuzTnbzj
 KH4woYCgClPxhoITigAJ4R06VgAapQXiC5CxUz3QWkpSY9nh+0p9LkWBbXmqT0VQ5v
 ojjslwFpq0AXibSg23JF/o+9598W9Zdy6Udxy5mjYgXCDO6mQpU5xNtBx7Mp+tYoDQ
 EHcghK8Q2Ht6xCD7bpP9GyZ+Aw2TG5+q986MZ/02A2NefAaurafElr9hjk/Vp4ATlT
 vTYpzNSerGkMr+8uChrk0zipzwkWMoGSq8eM1yOwC2RLKI1qQstBv8NQJQe6j6YNbV
 m2ZYSpTCJOELw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E2C9F17E02EB;
 Fri, 02 Oct 2026 00:38:46 +0200 (CEST)
Message-ID: <b7e5e5bf-f1ce-4a4e-88aa-fde929ff6ee1@collabora.com>
Date: Fri, 2 Oct 2026 01:38:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
To: Dan Carpenter <error27@gmail.com>
Cc: dri-devel@lists.freedesktop.org
References: <arJo7A7L5hud3tyc@stanley.mountain>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <arJo7A7L5hud3tyc@stanley.mountain>
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

On 9/22/26 2:39 PM, Dan Carpenter wrote:
> Hello Cristian Ciocaltea,
> 
> Commit d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling
> management helpers") from Sep 1, 2026, leads to the following Smatch
> complaint:
> 
>     drivers/gpu/drm/display/drm_hdmi_helper.c:663 drm_connector_hdmi_sync_scdc()
>     warn: variable dereferenced before check 'connector' (see line 657)
> 
> drivers/gpu/drm/display/drm_hdmi_helper.c
>    656		struct drm_connector_hdmi *hdmi = &connector->hdmi;
>    657		struct drm_device *dev = connector->dev;
>                                          ^^^^^^^^^^^^^^
> Dereference.
> 
>    658		struct drm_connector_state *conn_state;
>    659		struct drm_crtc *crtc;
>    660		u8 config;
>    661		int ret;
>    662	
>    663		if (!connector || !plugged || !ctx)
>                      ^^^^^^^^^
> Checked too late.
> 
>    664			return 0;
>    665	

Hmm, wondering why Sashiko didn't catch this...

I submitted a fix:

https://lore.kernel.org/all/20261002-hdmi-sync-scdc-fix-deref-v1-1-d99b4f544dd4@collabora.com/

Regards,
Cristian


> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter
