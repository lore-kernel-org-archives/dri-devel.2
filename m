Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22442CD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863EF10E06B;
	Wed,  6 May 2026 09:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sgIiYta0";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640C410E06B
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:09:59 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-65c37eafcbeso4537759d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 02:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778058598; cv=none;
 d=google.com; s=arc-20240605;
 b=Q8BnIoubYtTb+ekLrOUQm2NJWBg+uwnbO/VZr2/fGOCGmzn1maGoIXFZbmfeLuCaug
 Icgq4AJgnuDFk9AryOq+A6rigS7ZgfqY8UKGY5uqNJbQQlI4vqa4w/9LyCxWrp96K0Mh
 FxTghWW8xrsEMpogbMpFj62nIUV5xSkIoEBgWiuLloq2O92bZ+RfoE2MjgdEmVG74ro8
 aVKDHevh5+6ZysAG7J/oeSHw3Uwnehk1ZbjbhLGfPZ/kDI9TBL+FW5oCGQWx+e4DUfMd
 eSQaKYit1S8Kv5reEf0Nd24A35Z600erZGbD64NNlYp5d0dOm3UXBJt1Hfb3gGnlayym
 StCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sE63xfK9tF0qLxfLTzfosY8+mfJCa4vX8lI44vR4HdI=;
 fh=6JYSPYvhWAzmUFLR8LOF93KD9LevKpWtP4fvT45Vvzg=;
 b=Q9Xd2wSww6ovgElBL/CaeIdwkmPawOvrMi5WzGEXbQPCSya3YP5OZ7Fa/JGsvv0ia0
 xY86EuhUBM8kvpW1IIN6O90K0KKdV/hHrsQCXPiIZtvY3a8gdtKXjmElKlCPmlyu1yD8
 RaKi6fn5T0e+j2+h+bZ55veogLfkyy0gFBhT6OVI3LlAaH8Qy2VJI6gCKtEjqERmLbkK
 WtBUlzGwyM77LRCMzfpC8dRsW/Tidwln/kWqwFD3kQd7511rA6UdtdvnXUM5HnKujs7/
 PXDYKPXYxXzb9GfB7jNHhbkTuN94hqV7sf0xEbvQwfO6QtxKDPJbjOtpCljkbYf0RwO4
 icdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778058598; x=1778663398; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sE63xfK9tF0qLxfLTzfosY8+mfJCa4vX8lI44vR4HdI=;
 b=sgIiYta07xHWEED7IE73uKleb6o7/3iCYC8a+kUuVQBjlrRubJtJNN08k+NuQLKXeW
 n1NiNbTQw7Y8ICjjINYkHtoQClFpej7ItpqdL88E9Lr9pwcavB7J23NPiGz8NJ5wub3c
 0fUPdZSXDxxr1bb8F5xQFoeykLKl7QAVAEcaqjrUzwLuSQ7M9LRtDBMRPRwQQrsRMxfA
 vzgGM37oxBhDJwc+XAwX5ZAvjE0UmXesyz/heai/w/2V9s1vBOd/hhPpnk5DIYiqaEpo
 GHvpylCtPf2aFcPmzmvhHdvGKLnUCFxar7v4JTSKcTLNQXHapnh0C8Avx8OH3wxO9tX1
 YmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778058598; x=1778663398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sE63xfK9tF0qLxfLTzfosY8+mfJCa4vX8lI44vR4HdI=;
 b=sNjv77cmASckFzuEQH1bCWKrRPn5/n5TPkhR7+YLx382Kcy7l+MwPm4tNjRHgPYHGI
 DIc9cfz2GG79PiNKRl6BhziNHcrklZv26hfWasvXRAdCqg90A6SszZhCbZ0VHdHKgLjj
 ORzLeaNmZnFq1bn+qDoWguREEo94YN6OTFR3KkzMDcVheaPAkSws0w12xJKzVNXAbCDx
 KLdCZk9zriR6R2sbMmCMjJEOzJJgHEw+JWsAmmSMoRpkKlYBVN/w1rCVIHezFXtcCNoU
 3knTVsaBZYBXlCspaEqR5A3BaFK+gzkiEx8MMGGSSWn8u5jS2C06Hyd7JEX6glldMeuw
 lCwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9htxxCxPhwodO8nLywb/ELfvkYFvX08NIttj4SayYB6PEYhyYSjYgKTaGVNTO6x6eY137LDpZFcsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3Y+hxtOmRnJeCj0BmgCRxihD1B0Y6+h7QoK5K7uSlGI7kzwUB
 cQ8qmfFTbGo8QClJiaMcvPZBwLu4A9xMVlyw6v5Lzp3Q7GlU0aIeT4+bOpBwrLYh++7/nDLK2FB
 KqlSTAKjEUa/QFfYCOp2wp6mvvk50hEI=
X-Gm-Gg: AeBDievbw287Ia5sp5j8HQNic4gS5qjyAFMewbcDDdCsfHRCfc0o9FaB4Yb45FpDiS1
 hvJQQxQQ2NxZeO/H++ZQlLrRlBHIQsS2X5cx9EGtzh7RmV80sxvKLG1kMh9AkpsjJPIJWbmc6YN
 r0XQ1B6pKWTCRWukV8wplsapWGjEDfzEipCaMa0Ffll6qjXGmKk//kEUkfrsrHXBqCyOt3FHSIa
 TG6rBhex46J1wW/dCHYr5jYYIUpkx3yF5l6M935/kLnRoLs2JIdxKZ+gcGwgF2Z5IoSyAbWzu/w
 1ri/161bsevR1YxBALUpe56/ZUulVQ==
X-Received: by 2002:a05:690e:1447:b0:651:bed1:19ef with SMTP id
 956f58d0204a3-65c79a4a569mr3077966d50.62.1778058598028; Wed, 06 May 2026
 02:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260505082145.603262-1-lgs201920130244@gmail.com>
 <afrn-zcfiRpJzIcO@raspi>
In-Reply-To: <afrn-zcfiRpJzIcO@raspi>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 6 May 2026 17:09:47 +0800
X-Gm-Features: AVHnY4Jk9YyDPydkL71fov0bFSSu9j0Lq1UdfKpQsP_hQX1hR4bNL4d9pygNLng
Message-ID: <CANUHTR8OD=uNMC3aVDc2oNeUwAWcsPsCRda+9RckpaUOhwHSqw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
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

Thanks for the review.

On Wed, 6 May 2026 at 15:03, Liu Ying <victor.liu@nxp.com> wrote:
>
> Can you provide a minimal fix for stable tree by not using the cleanup
> action?  You can add the cleanup action with follow-up patch(es).
>

Yes, I agree. I will make the stable fix minimal by not changing the
helper function pattern. In v5, I will only avoid using the cleanup
action for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge() and
release it explicitly with of_node_put() after
of_graph_get_remote_port_parent().

> Why do you need to initialize ep to NULL?
>

The NULL initialization was only needed because v4 changed the helper
to use an output argument together with a cleanup variable. With the
minimal fix, ep will be a normal pointer, so the NULL initialization
is not needed.

I will send a v5.

Best regards,
Guangshuo
