Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDADFF8855
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDA810EDAD;
	Wed,  6 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2hx//uJ";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D169C10EDAD
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:58:18 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso6918929d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 06:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778075898; cv=none;
 d=google.com; s=arc-20240605;
 b=PRu3TzbrELleg1hY4+Amc5QKV7r3DoVQb/up2uPKbGPj/HcmT8e8loZKHNMdMj0DJ3
 rTJZ9G0107JNp3j2IFu7b2NYXolMO1FmL4YYpIWEtvlbBuonGv6D9aUV6t2NSry4cQNw
 LFCoBST+HH0N5S2YCu0aeSk93xyKPLtCSdEg63o8B+HFzV5U4CeJtbNwsoUfxC9uYBEo
 jcJ5VaMLYSn1ZAytyYjplzNS0mXSt4Ivu8W5yP7Q24+iVkz0SNL7jpeTGh3qJv77KMY/
 Y2CiK8L4yOEeFkcSW1sK6IwOJU718mPW8LrGBXlreGj7E61p8qi5HCZd9P6ZblJF+t62
 uSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yAGZRzNWoj71eYuAlCwOROEzF/QQfxUQn3hZ1d0klWU=;
 fh=adaZZcUrLxItr91UlydpDLqJDOL93Sybs/s5omPMAu8=;
 b=NG7Bslu9EpqnYaVYleaU1IrNB0gNUfDPVm4CX074ukb31Ys5zSnoGMMcb8I7x6LOrg
 0KqQytdCoKImTe8urdUkveGcptgMIMSZu9LUQLMV+nisIZUx5KaCD4NQ434DhNv4Yd7C
 77PAqj9WRclXy8HEM84VagvZG7I6gFDueauqg/4J3CPZAvO5VCGFIPGUkeVAdJKEqUPV
 woM7A+L7Dnh8KqZDYAScIYnPsM9iTlTki6ShVKhj945a+iQP1dLSw1upVTaxXMbEG0JZ
 9dhUAyU5IqVHxEFF4/W4QcA7Luxc53wMBrnhBnAHPJemrDvzZ6pSzmMQ617g6he7Nhl0
 BOwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778075898; x=1778680698; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yAGZRzNWoj71eYuAlCwOROEzF/QQfxUQn3hZ1d0klWU=;
 b=d2hx//uJmFcaC3wGMaeo9kji2rwexwkbxtfHz6lkJ+rW32k2ocpetCw/RKv5Fgr4dZ
 wmGEME++XGrLSPcIwhrTZsrdtDe7SXbPjdfTapQRuz6z/QYHphooX96bNR+6qDldc30J
 fxGdLoIY7/symL9GJNKH50G7iTN84HjrfKS6MRmhrKE/DgReVoHtDruj6Ke1uJ62TI/5
 j21hXMYXc9mYtuVvwvfRQzkt9pRKxeuQlyLTp0QMwWqcsUVp+WPCscHoF3kDo6qJ6JJt
 koSmQmd8LQeYpqUW9hRI9RcB38yR2MVN4GVOnODlV9SjbSH0fe0yw1S5NrbH1xlDqxPm
 xWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075898; x=1778680698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAGZRzNWoj71eYuAlCwOROEzF/QQfxUQn3hZ1d0klWU=;
 b=K5KsT5VUE8eayNL6Jexb305roeFd78qZHr01YTsgbKPnBHbYxbyP1AUNZg6MoKpZ1S
 Ad73jdkqIBLq5p+nVMvA95TU/oRMslxHLQIzHkf0RR4D1Fg1XqsMkUiU+/a3zN6TMRR9
 YHlrnmvBb3P4Ue8M6TYoggaX4eBQPJ40O08KY0XTqnIvKC7i4jxPW2KVLxVDZaLdCIYX
 2WLIoM+odIjVOGjt2u6zjuVCJxf98xE7y5jikCYbSB3CFvm+d6ShlPDnMwCsFFPN9pjK
 HbdL3VSTuWfwIFrNQRsWog4K6bXYzPlW3cU1lv1FrIS6IqrCpLTVnVD+j8BMbxw1yhjH
 rRNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hZSeCnZCw4lpSE+nLfm8iHcJA69GDV1v9KE2e7L7n7uUTw4SBXqmvd5DgrDYbDY8Juy23VecnvkY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLsKaaFw2JM/PqNJh27CVkjaFem9FZGxoOXs8c/OLSYwa8EXQx
 v1tEZFviEOj8Q2hGiqmoaLuW1RaeuF5hrBlPL/juaNaFJrlh29p0Y3BBZ5kduWRC1gbxxspSuwi
 GL9bK+vS0Y+qET9wMxqk0+if060rWhuY=
X-Gm-Gg: AeBDieu9WRzUdXFz9lZjhJbMv/KbYC0iGwMhNHXVobrn7t+L9/4zpefWsQhE7yb0RiH
 ZTZ3u8A44FB3+dM2uIZpA1IvJH6e/+l57w60wM2/LR6KgF6CqFfYSBoKd9qv8NkIHkW+HAFfRoF
 xCYEeSBRllLXk5WYNpC/4iDjbneT1NyfjWB1hh4cNPCLBIHZ3ulU8X3cK4G9/0NxCFV3+bHIFkd
 BcxhhC/czA/tXKkZKGXeyGAQLOyZR4LTvT38+/huy+MU1sqpE+UShSY8e/b8prhi5y5w+OXB0H6
 /4rQRgfKpFEyJIJMLijPuX3Nf3a9ZQ==
X-Received: by 2002:a05:690e:1688:b0:651:be8b:e87e with SMTP id
 956f58d0204a3-65c799989cemr4075950d50.34.1778075897748; Wed, 06 May 2026
 06:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260506092324.635014-1-lgs201920130244@gmail.com>
 <afsO9TxVuz79FFQ0@raspi>
In-Reply-To: <afsO9TxVuz79FFQ0@raspi>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 6 May 2026 21:58:07 +0800
X-Gm-Features: AVHnY4IW3B6qWimauAAC6R2YoxAVTsxlXp2RYpmYRhFA5w6dajkgOR-Qizc8_E8
Message-ID: <CANUHTR8PNO-3hfEMCz4Zz_2ERLonE7OyNzPWtAaDtVpNB=YGhw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Liu,

Thanks for the clarification.

On Wed, 6 May 2026 at 17:49, Liu Ying <victor.liu@nxp.com> wrote:
>

>
> By "minimal" in v4 comment, I meant not to use __free(device_node)
> in imx8qxp_pxl2dpi_get_available_ep_from_port() and
> imx8qxp_pxl2dpi_set_pixel_link_sel() - please keep using
> __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().
>
>
> >   - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.
>
> No, please fix imx8qxp_pxl2dpi_get_available_ep_from_port() to make it
> return int.
>
> >   - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().
>
> No, you need to change it.
>
> --
> Regards,
> Liu Ying

I misunderstood your previous comment. I will update the patch to keep
using __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge(),
change imx8qxp_pxl2dpi_get_available_ep_from_port() to return int and
pass the endpoint through an output argument, but avoid adding cleanup
action usage in imx8qxp_pxl2dpi_get_available_ep_from_port() and
imx8qxp_pxl2dpi_set_pixel_link_sel().

I will also drop the unnecessary local NULL initialization for ep,
since the helper initializes the output argument to NULL.

I will send a v6.

Best regards,
Guangshuo
