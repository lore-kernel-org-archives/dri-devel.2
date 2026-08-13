Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED8C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1E410F397;
	Thu, 13 Aug 2026 15:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="pONo9s0a";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9075710F397
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:09:25 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso111915ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786633765; cv=none;
 d=google.com; s=arc-20260327;
 b=UgNg2dBzJ2nX48iKDNiq0sJ56lzBh4QJoJZDlgqVMjDVmSGDVhnNW8F9aLxFpmll+Q
 IFY5IrL3L8076+i6e/KJSh403X28rJLhLmgavPIDphCcJnm6I1yUxbUtwSAmSR2orwOo
 +QGTkufGMJ1Lh86McZRwg9SYuT+a0mM+5yfCfwchFmtbGHG4NjqoSj7kAZkqk1XN4ySR
 Y/PX7fJAJakVp8mehR1w8+NiQoOrI05cuI+30cv3fW3MrxLsV84bXmilAuGU8LQGtl5O
 Y74E6YEN05uk+JCotAQKZDKclxz5Xq4zBf9toGhOP0Pzcxq+b3ACMJehg4evNG0Fvctn
 Hf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sSfixZQMz0vR8g6mx6GBHkzMd5TjHfFJ5VTa4zkEMgM=;
 fh=UmQsttLvcwT5JleXt5FqSD7Q/6T11zjCqKtnyRfHabI=;
 b=ORbQ8BqhPPnLysix0oHEpb16bGmPPvwBfV8knYbiwUafWNYhGqCQT+wdB+GVeM/3D5
 XZqlzW5Mw6n5ZDhRtH5kda38zmChJUFva1aB/WrfC6rMLL89Na0RJYG873N/co3tcsHM
 iXOgFCABbl61+jciLshsVnzT1O5ZB0ik4ZBKKtsg8kc2Lk5HgxbnyWWqlnt2zBc/pDBo
 +9A39uyQ92ANJ4yN9mgcw3dDXz8CyygIH4Ada+zTpHl9iGVRMCRsQq7Rbxp7M/PsXhQy
 AJJXua+vGty5YB1v9n2rCecoJBw8Q6b3WWWZQ2xc0lk3cGrOn7nqjxgfMwKU87PwCPL1
 jI2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786633765; x=1787238565;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sSfixZQMz0vR8g6mx6GBHkzMd5TjHfFJ5VTa4zkEMgM=;
 b=pONo9s0aPLSxlFiPa6OOGiN0xjqlKvUP7bOAoXLLsPGlt0AYpRa8MC5bWcr6m0JQTL
 t1GWXlGzz7w6uW9JQGWl1JZv74MEJPJFQjgdvjzlgOs1REsuy9J/dxxec2vAGZErud6S
 EPvy+08cOpxzJT6S8sqMhs9waX2A6gTP7LfUdboBPSfXzxwcxIBqqV+UQ+n3H8F1bHAE
 JKU7QH5vqF+mI5AM0VN+BlKdTNDrIZdgEvvjKZiEH1kN/fxneQgGatgciUbTQsKEshOj
 tCe/NeUXawU+qN+WE9I0yzdt9NMWGO0fZPiUa8kgdATXZ1xOAGCN0JaZhNFlYUTesNx/
 NiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633765; x=1787238565;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sSfixZQMz0vR8g6mx6GBHkzMd5TjHfFJ5VTa4zkEMgM=;
 b=AyiZ0qK99lUrGIxaSZz4/qpTVTJt0eCQxkyI4+QXdY1ezMYZO//E8+/Tpen6y6i80H
 bxxX5LaXhDyOlzjjRLmo7auHP/1qTcbmzqzN01DkOqYDgzss6Gox0KPS7wz93uGRCwit
 vc1hBOQktoZh/ojTbla+DxfzyDKop2BoIA51lfjlm6ifQ0QkHjuWBISSGP1oM1agQ3yl
 eM5ZibjwdvyBo4pUl/OA90wxEBIYEeHcdneXsNZl49LOYfOoAbkg0W1Og91qKCpXKiqH
 0Oojz/VrXqW6B5NVYEQ37ZgRJzHXJRnhvlvCA+nV1jmTtnsBRuhVPLAjlH4eI2B5AUlg
 +Mtw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxHbFd/5cYS5tEHNgR5Y8GXyz857FoekPx7DYRcFP0DNIeH3R+sU1Msz/unJBhCm2tOwVKuEN6UsE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxS2TwvuLlYqGa2rv0n8gRGRBPY9Dpk4DvwSsrKd7UAtqvL8uD8
 SNnY703+uAIk8TJa5DP2bGc97pbRLzGw2kB+bWogDER5m674tPp0wLzjdgpfKNigfRcqT/cSKyy
 vPEw8G/ieQ9zyOxk/x1Fd/PuVpk8RZeCAXbjBKPJfpQ==
X-Gm-Gg: AR+sD13STrznyPps6IU6aSPVr1wsxnP2PtdgqfeUOd7uwUVm5ccJ1Ue7MFKAHgE2VVx
 HDR6PcixifNSUWtWnpgiPyIu2lD8aj1aV4olt/pr0Fi7QLOuWnMgZ770mX98mvnIkAL69cheDpv
 eQ3YT0u8qVybTrlEqYiR+rTKbaQQTuQPW6x7lg/IcxUkZ5oKnYnSBVTArx59l6RN9poLAZRPMA8
 XdecO4eRgQICMh8Qj9pGYdQoSxfSMh9Mpot4ruNWbvH64pPWcd1r/sgoKGB1Rxz6qT4GKfVJ8pR
 tP7lZfuNzgOIKgNpzrJW5DhOELjE/XrtS+kd/7Y8QbfU
X-Received: by 2002:a17:903:2987:b0:2ca:619f:9733 with SMTP id
 d9443c01a7336-2d37e9ae9a8mr80628175ad.17.1786633765124; Thu, 13 Aug 2026
 08:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
In-Reply-To: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Aug 2026 16:09:12 +0100
X-Gm-Features: AUfX_mwnT8mSX1TxP1zLMIDeonWHO5mTijXRqqeOSADs0LdjYAmb4n0gllJsz2E
Message-ID: <CAPj87rMNdbzebt0ovJcymRtBNunnQaVx_=aSUbcrXNTEZOPz9g@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add SCDC information to connector debugfs
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

Hi Nicolas,

On Fri, 24 Jul 2026 at 15:23, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> HDMI uses the DDC I2C bus for communicating various bits of link status
> out of band with the actual HDMI video signal. This information can be
> useful for debugging issues like questionable cables sabotaged by feline
> teeth, Enthusiast Grade cables made of cow fencing wire, and other such
> problems that ruin one's media viewing plans.
>
> Consequently, this series exposes various bits of pertinent information
> from the SCDC protocol in an HDMI connector's debugfs. To continually
> poll the link status, userspace can poll the debugfs file.

Pushed now; thanks everyone for review and testing.

To ssh://ssh.gitlab.freedesktop.org/drm/misc/kernel.git
   0d46312808f32..9b388fc3d0e63  drm-misc-next -> drm-misc-next

Cheers,
Daniel
