Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DCFC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C30F10E282;
	Thu, 13 Aug 2026 08:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G0rGpXSM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309B110E282
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:23:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56705600E2;
 Thu, 13 Aug 2026 08:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A5E1F000E9;
 Thu, 13 Aug 2026 08:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786609385;
 bh=S0QwcmZYI7pJpaWM8SXgn74XQT5EU5EKwIDYoBEKlZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G0rGpXSMiSQzE3O4qvKxVOqftowq14uazFlydY4rNRzU/H8PCy/jN3gnQzzRI4J7D
 1+eB0RB34rGSkIYaXtMpljfEOOgKwYpt657wxjyc/5hjJDj6UFK1N4MNzr/01e604F
 9C7eIJnxD4w97fmfqt8jIco8HSqT3AAhWq66VIRWaC1Zg0YQdYdmzsxny95DjDvpOz
 J7pGINsixgAqM36zt7uy57MHfUO1sXMLFsE70fIX0x0Mi54HHAa9HWYjn7a56WcG17
 fo/DGthKzzxj3W0XfVEBCY+2ZtYVGQP47puSynHleOt2qIPfBc4gzdAYdJdDdYIQPu
 N2mhTl7QS4jbQ==
Date: Thu, 13 Aug 2026 10:22:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH v2 1/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
Message-ID: <20260813-amphibian-handsome-mustang-68aed9@quoll>
References: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
 <20260810-b4-lvds-panel-doc-v2-1-f2c2fe309989@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-b4-lvds-panel-doc-v2-1-f2c2fe309989@oss.qualcomm.com>
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

On Mon, Aug 10, 2026 at 08:27:29PM +0530, Vishnu Saini wrote:
> Add the BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel
> 

Drop blank line.

> LVDS panel.
> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Best regards,
Krzysztof

