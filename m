Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2049CF94CB6
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4B210EDD0;
	Tue, 21 Apr 2026 22:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dp5FGQpW";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2D210EDD0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 22:01:59 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8acb3dab8dfso31244656d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776808919; cv=none;
 d=google.com; s=arc-20240605;
 b=VMImzGlQc5LnfMUhmzEr1aX+bnSl9i4JVCO/k6T5yWjzJkj5EaplQXY2zUlq72VVQa
 Mwc+kiGjpPvJGGr0IZkc3ASK73ZbIiay5l4l32ApdBgH5ngTDZEIxGSu2qEZXG1MCy1h
 hvUgV5ZiJeLi/pHvXT3lNQKJU89r9gogm1ckoSnn4QGpW9vnzjzNYz4TkXaK0zNLU1wB
 5diGDggDi3Wp945bt169XFD/tVTFrDkGDScImdYv/MMtbd/hqMACxoYjO2xMgzBdxsVJ
 7q7uUH9w10zL06T3N0Y3rK9W53O62I42m93vMHv+vcf5YIfu9Y3T3ioW2j2ioY71xZaL
 XLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SbqKq3y9Tr2xHGs7M0R5j0y31HJvYP2yGWtJcRaCjxY=;
 fh=xsGZ2OtuZZEbs9nCiRXV1VQll1eOyvFkWxw7L3bzVfg=;
 b=fMqqZzAZsPgxhTbAxJCltYnYG4DUfo8pd6xU8S4goeYakSlIU+c3axJ3k04h693VB1
 vUczd7zEIYtU9fMW4mfQXQI+mabJ0EbgUvc+fA0f6w7507XW4Oj7huM3Z+NibCrHh5HB
 qCZHg0qKLzjyKAkeug2WuW7GqMG8aoTpRjyLcIYFnT2PBk4f9qskmy2e7b5gUntNYC4a
 VuHgRquCt+bNNDfLj5/XFZCQ7d+IoKgZsMn9MsIe4tOrb19hTtNc2wh9NVIS5fVEcxOF
 113lSmq/xZVJxHuN1rQ+WrPgh5qgl08/pN+XVE9QsesNDjvRLmfgRbdKuNcuHEfBgtJY
 fb+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776808919; x=1777413719; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SbqKq3y9Tr2xHGs7M0R5j0y31HJvYP2yGWtJcRaCjxY=;
 b=dp5FGQpWPUk0jAxWbUHrVb2hGBOw2uefNFsMqrX1rHyrPxBfQuGTgCUoHgqGqCykin
 2cX/f3dqZZNYA0PtK0onTZGlXFzKJCA6OadfefMC/Mn0MeS8HA0/+ESAwrw1yPhcMNKu
 My2e/xwYIa4rc99GZqoQqR5rWEAsEl9c8aa3b7XklI+CeTM5UQ8bIN3R1v9FXnpzafrC
 xdFcf5wcYNp6lT+Yqeby2zB7Tfc0UUcnehlp8DeVCkuJFxAm0AZqlu23EiuncPgD66WU
 LCAdsoE35RK4QwxvtJErGvQkUKZrJWIe5R8f5dFPxNC2wEPbGeNj5xAlVA4n2KEI6zws
 I5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808919; x=1777413719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbqKq3y9Tr2xHGs7M0R5j0y31HJvYP2yGWtJcRaCjxY=;
 b=XpislHgOm8WdKyoCygbruNg5oukxeUaJJothOXZn5WhmxMlboCGzTJI8XDHHSWmEql
 eTW5zJtO8PEzL99u0MYnl2ANKASWPbMiYHBO1mOpkGCIHTWlfdTILMRm9AK9HBGmbM2U
 QbZG7EbWSWKsb6uWXUzTyp90ntfkVpvB0qFTnpdLyIH8NDIpP/iwzY3TTgnjDOqlTLw7
 J+lrQ7Pd3KdDRnyhBIDX76fgEFFbttbCqwjoOYhPto+Eqq38T6FWxeTkiahBsZoJNH9P
 CEftWO/eUK8bLVzKUHk6uYtUeFVJxEATuS9KsoVH8qzZmMwT8sVCNo3hKpF1ysD/glVq
 drig==
X-Gm-Message-State: AOJu0Yz5kIoXG2/vhH4r5NWrHZrfmWugeNI1PomI/K4DAn/+5jzGuK7R
 8PQwL4ryJDPOPY715avRf7IxG9huAZJDYRI5PodmC0FvLUMb4Lwk9aUjfL82J+WoV+wVG8VQEiT
 Tc+QGNKrKD7/RArFVVbavQ8LZ4IVaNCc=
X-Gm-Gg: AeBDietp2dUzEn68SG9vCqD6t7pkIDD3L2W2u8xraNl9t2dnbqM8noRkiMV3HV661Qe
 lLaJfbUm3In9u6Peo1WpCFFsBFkWAJiSwJWVV0rOL6OCQU6fKD4H8RIS3R1vO7D7ejZ0xICiltz
 XMH53/DKhe6COl7MCq8U8g4Sdd0KKtHvc3MbtRPxuZp7yQd7ipve/X6A7XxuOwInhlrtfQ/s+JI
 XnUYYLRFkPvN/u/zof9ZCoXB7HRsg4lkAj282dEDHzOBCCsX7shBtls5T5luq9CnyVb9MlWAVIp
 q0AmBoDGl9Fgki5DYZiqnVk1znGPyMsbDhGA/tx7g89+EYcYO9XqSVstWbfoSk/BS3rcLulnmb2
 xcA==
X-Received: by 2002:a05:6214:410d:b0:8ae:3e38:54ca with SMTP id
 6a1803df08f44-8b027eb080cmr330754136d6.0.1776808918174; Tue, 21 Apr 2026
 15:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260407104951.1781047-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260407104951.1781047-1-laurent.pinchart+renesas@ideasonboard.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 22 Apr 2026 08:01:46 +1000
X-Gm-Features: AQROBzDL3CeWYqWsBsuIqR2gPqSb25AU6fqM5e_8QZPy_G9g9NCd8KP2o-HSXN4
Message-ID: <CAPM=9tzRz7u4=B-89pQVCQYdsN9gBhQvTzasVXGFTsa06ZWyZQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm: uapi: Use SPDX in DRM core uAPI headers
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Simona Vetter <simona.vetter@ffwll.ch>
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

On Tue, 7 Apr 2026 at 20:49, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
>
> The DRM core uAPI headers are licensed under the MIT license, and carry
> copies of the license with slight variations. Replace them with SPDX
> headers.
>
> Following a discussion with Simona Vetter on this topic, add a
> clarification in the drm-uapi.rst file that independent closed-source
> userspace implementations of software using the DRM uAPI are accepted,
> as allowed by the MIT license.
>

Works for me,

Reviewed-by: Dave Airlie <airlied@redhat.com>


> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> ---
> Dave, could I get your ack on this ? Please also let me know if it
> should go through drm-misc or if you prefer picking it up.
> ---
>  Documentation/gpu/drm-uapi.rst |  4 ++++
>  include/uapi/drm/drm.h         | 20 +-------------------
>  include/uapi/drm/drm_fourcc.h  | 20 +-------------------
>  include/uapi/drm/drm_mode.h    | 19 +------------------
>  include/uapi/drm/drm_sarea.h   | 20 +-------------------
>  5 files changed, 8 insertions(+), 75 deletions(-)
>
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 579e87cb9ff7..32206ce62931 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -118,6 +118,10 @@ is already rather painful for the DRM subsystem, with multiple different uAPIs
>  for the same thing co-existing. If we add a few more complete mistakes into the
>  mix every year it would be entirely unmanageable.
>
> +The DRM subsystem has however no concern with independent closed-source
> +userspace implementations. To officialize that position, the DRM uAPI headers
> +are covered by the MIT license.
> +
>  .. _drm_render_node:
>
>  Render nodes
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 495462e44a17..bc7ef7684099 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: MIT */
>  /*
>   * Header for the Direct Rendering Manager
>   *
> @@ -11,25 +12,6 @@
>   * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
>   * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
>   * All rights reserved.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the next
> - * paragraph) shall be included in all copies or substantial portions of the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  #ifndef _DRM_H_
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index ac66fa93b5a3..2caf8249f892 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1,24 +1,6 @@
> +/* SPDX-License-Identifier: MIT */
>  /*
>   * Copyright 2011 Intel Corporation
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the next
> - * paragraph) shall be included in all copies or substantial portions of the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  #ifndef DRM_FOURCC_H
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index a4bdc4bd11bc..381a3e857d4e 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -1,27 +1,10 @@
> +/* SPDX-License-Identifier: MIT */
>  /*
>   * Copyright (c) 2007 Dave Airlie <airlied@linux.ie>
>   * Copyright (c) 2007 Jakob Bornecrantz <wallbraker@gmail.com>
>   * Copyright (c) 2008 Red Hat Inc.
>   * Copyright (c) 2007-2008 Tungsten Graphics, Inc., Cedar Park, TX., USA
>   * Copyright (c) 2007-2008 Intel Corporation
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> - * IN THE SOFTWARE.
>   */
>
>  #ifndef _DRM_MODE_H
> diff --git a/include/uapi/drm/drm_sarea.h b/include/uapi/drm/drm_sarea.h
> index a951ced60ebe..1e38d028332d 100644
> --- a/include/uapi/drm/drm_sarea.h
> +++ b/include/uapi/drm/drm_sarea.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: MIT */
>  /**
>   * \file drm_sarea.h
>   * \brief SAREA definitions
> @@ -8,25 +9,6 @@
>  /*
>   * Copyright 2002 Tungsten Graphics, Inc., Cedar Park, Texas.
>   * All Rights Reserved.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the next
> - * paragraph) shall be included in all copies or substantial portions of the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  #ifndef _DRM_SAREA_H_
>
> base-commit: dc2d30e7db8321a6696d266838f7af7e9d1c7155
> --
> Regards,
>
> Laurent Pinchart
>
