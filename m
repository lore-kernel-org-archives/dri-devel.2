Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B02C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D7110E085;
	Tue,  8 Sep 2026 21:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="X/WExNVc";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7A710E085
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 21:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788903110; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NziKeWl8kgQ6SF2M3WyXtmkRxAeoaNDzcQrKuXycIWx3lUpkOsQkxtHLPXqSFCX0FjfDq0sWZV+7C24PrFWszRRFKLLe9w5735MA2j0otUZtFTldc/9B/KzR2C6eotSNXgO5dKA4owIQZQ0Yd3QsNqQsD8OpgyARzDHT+yw6m8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788903110;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2QXAQIio73iU0NLTckEfw4ZRVouQugyIwuj++db5nPk=; 
 b=f71wMvrbWyrFsT0op7Td/62LDMTH2A1AsnB57bRgiNAJfPW0jv8iCddN3uvEuu77+4Rb4xMpxDLX4uSY4btFHb2fRRe9zrSYig4VxKqOF5kgte5auxbWiV3BS7orF99R2+0XMKx0FVpR70aj/cQVkRx0OvAa8fCV+H0Vd3j5Uls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788903110; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2QXAQIio73iU0NLTckEfw4ZRVouQugyIwuj++db5nPk=;
 b=X/WExNVcWcr6qVUs6RFMe0qwXmqt3b3mFhvpKrqUWHB+b8DVdVHyh2CMuR9tvN4A
 XtOG+wPp1BGER0fCRtdhM+N8LVlEZkyEp322/+w7jgzvbnXH5XozniALMe2ZrD/vXES
 gQmfqEmTbd5m1/YHWBQwNmXssaF3ZnwRXTOu7bjk=
Received: by mx.zohomail.com with SMTPS id 1788903108562380.78051531135134;
 Tue, 8 Sep 2026 14:31:48 -0700 (PDT)
Message-ID: <d252a015-f8c3-43ab-87b7-e078032054d6@collabora.com>
Date: Tue, 8 Sep 2026 18:31:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
To: Roshan Kumar <roshaen09@gmail.com>, linusw@kernel.org,
 dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, pimyn@google.com,
 linux-kernel@vger.kernel.org
References: <20260825105427.686619-1-roshaen09@gmail.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <20260825105427.686619-1-roshaen09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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



On 8/25/26 7:54 AM, Roshan Kumar wrote:
> Commit 860e748bddcc ("drm: ensure blend mode supported if
> pixel format with alpha exposed") added validation that warns when a
> plane exposes an alpha format without a pixel blend mode property. PL111
> exposes several such formats but does not attach the property.
> 
> The PL110/PL111 controller scans out a single framebuffer and does not
> blend its alpha channel with a background. Advertise
> DRM_MODE_BLEND_PIXEL_NONE to match the existing hardware behavior.
> 
> With panic_on_warn enabled, this warning prevents the syzkaller
> vexpress-a15 manager from booting. The change was tested on current
> master with QEMU 10 and the existing production DTB; the guest reached
> sshd and returned an SSH banner.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Link: https://github.com/google/syzkaller/issues/7805
> Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
> ---
>  drivers/gpu/drm/pl111/pl111_display.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index 5d10bc5..758b297 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -15,6 +15,7 @@
>  #include <linux/media-bus-format.h>
>  #include <linux/of_graph.h>
>  
> +#include <drm/drm_blend.h>
>  #include <drm/drm_fb_dma_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> @@ -596,5 +597,10 @@ int pl111_display_init(struct drm_device *drm)
>  	if (ret)
>  		return ret;
>  
> +	ret = drm_plane_create_blend_mode_property(&priv->pipe.plane,
> +						   BIT(DRM_MODE_BLEND_PIXEL_NONE));
> +	if (ret)
> +		return ret;
> +

Hello,

Thank you! Looks good to me from the blend-mode requirements
perspective. But I'm not familiar with this driver. So, with this caveat:

Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

>  	return 0;
>  }

-- 
Leandro Ribeiro

