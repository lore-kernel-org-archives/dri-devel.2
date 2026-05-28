Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F27CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 09:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE42A10EE4C;
	Thu, 28 May 2026 09:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K8fJmCyr";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A1210EE4C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:00:00 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso39024425e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779958798; x=1780563598; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KgapLk0U8W9ohmKNOKBlmGBZxDjWC3tsNDHbpGJHrbQ=;
 b=K8fJmCyrsn4rXoJ8KuvOIyePGUK/Us7OoJwcrQwaF7YpY/Jy6IuWisXHrZ4OaDMZa4
 i/h2zrLsoWIzCB7tktkG+5Y8dy2Zk2/AU9xR9N+erAgGSK6jptiwzhpXxSR9zx+S8fGY
 YObbkWVRBCEFX+oCCQUUHpFzx/OlR9Vt6vuC5pvqA3YrQo0Ac7a9ZKSWadOF5do5uafN
 bMfeqi191agEAGscNAX++tH0JGR62u9d6bEPWz5Kdg3MBSFISgpUQdMmc/VQUxJwhdxP
 H5sFkV/tRjquo3BldWMCjhpt/XIFXuDnzSxl5w9hlpt48P4bQdYYVx0tB0Bqddzj6IT/
 HYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779958798; x=1780563598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgapLk0U8W9ohmKNOKBlmGBZxDjWC3tsNDHbpGJHrbQ=;
 b=bELMueARjZfEJvIe2dzclTP/VLElpyGxX3vi0Tsi1njUNgovpWJM3fOfYbJB97GJj4
 nOTYi1P/hv63hIZYqHnDE9ZXts9V1bygi5Zsi8kDcL/Ld3oz5rPnnqx+bxCN+6IhtsJt
 p67cV6gBbwqqEXPItMiiH65a2gIUUHP4V4gUw4VtM8G7S0gL61kE4x6Gxw1bZcM3lhWQ
 7TS4T/TLepz6M2zN273reM+0k2Cqe0Gb9Yi+IbSKhXRxMR/zbxGFogWTZgKnE5khmPSE
 SNl3E9rD5JUGd6yXsTf6pxtOKLPkineM86PsiopTDMmJ/P6k0AHe1YvOsbINkfs8ATg2
 rUDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Q2mvWIURvHtacufUf3jKwZn+Lk7kmyZcnuq5nJS3jIHvkRX/5jO79dR5y8/67l4Wjo5Y9k776ee4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweMVCVpOcTdz5xoZuBKOzcMbpO8sNQcFXGP8iw7czH/VEuryU+
 9BhmDkBbvBpYPPYp+s+igBFesSWpZ4E10Tlv6oT8bUeUXBN4t4Rn/SdC
X-Gm-Gg: Acq92OGH3X8wvnXbC/7YkDn/AFs4rDSHKOFUjcTeCYg5RxPLvxsIJkBJoWAusxQcZUw
 F6cbrdZNwZrs4fqBSPIo+i9dcla4ZsHrArVNiPAkw6fd8ZHIwZ9gGaynfQ+LLnRmpA2xofH2Hy3
 pnU9BgnxvFornCq3oh647/0CQInnyCm3Bsr50ju9lzPWikClSEejKVeY7OLq5aOLH52qrZQuhn0
 3UtXNf++I5F46wWTNeP6VV7xfq1BkSylwv09Kly17w6z0pu2oxLNOuFAT4YSDmpariZ1Dy4F3Lo
 cOiMwGPqqER5tLaCwC5hBpvW9Iacu0B8t0vCt4zoMfyUVQ0cyBxedBVaFUpX1SsCbFymGDhAdhf
 47cy825Hrn7X8MwUFYTyYJ5c+osf647CXJfUoBTz5K0BfgvOUqDBf9Lce7Cm674Usvf/i+7O1Od
 v61VFUoaSQwHv1uY5oL5SUAVVaN2w/HsXSSA==
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-490426bc737mr484669565e9.19.1779958797723; 
 Thu, 28 May 2026 01:59:57 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49091d55972sm26972035e9.0.2026.05.28.01.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 01:59:57 -0700 (PDT)
Date: Thu, 28 May 2026 11:59:53 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: zynqmp_dp: Fix uninitialized variable in debugfs()
Message-ID: <ahgECVKG-djR9_l3@stanley.mountain>
References: <ahP3Xagt1LJrhmFl@stanley.mountain>
 <935aaec5-5417-3cde-f944-3c04ffbd3458@linux.dev>
 <ahfeOh091V3BuuaB@stanley.mountain>
 <9189701d-168e-1e63-8a6c-f6926029c336@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9189701d-168e-1e63-8a6c-f6926029c336@linux.dev>
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

On Thu, May 28, 2026 at 04:00:53AM -0400, Sean Anderson wrote:
> On 5/28/26 02:18, Dan Carpenter wrote:
> > On Wed, May 27, 2026 at 08:31:59PM -0400, Sean Anderson wrote:
> > > On 5/25/26 03:16, Dan Carpenter wrote:
> > > > If the *ppos is non-zero then simple_write_to_buffer() will not
> > > > initialize the start of the buf[] buffer.  It doesn't really make sense
> > > > to allow non-zero values for *ppos, so check for that at the start and
> > > > return -EINVAL.
> > > 
> > > non-zero ppos seems to be handled properly by simple_write_to_buffer.
> > > 
> > 
> > It's not an overflow bug, it's an uninitialized variable bug.
> > 
> > The simple_write_to_buffer() is designed to handle partial writes so it
> > leaves the first "written" (scare quotes) part of the string as is.  But
> > in this case, we can't handle a partial write and the first part of
> > buf[] is left uninitialized.
> > 
> > https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffer-is-complicated/
> 
> OK, that's a bit strange. Can you add this to the doc comment? I certainly
> missed it when looking around for appropriate functions.
> 
> And I like the explicit copy_from_user variant better, especially since
> we are setting the nul-terminator anyway.
> 
> > Also this appears to be dead code since fops_zynqmp_dp_pattern is never
> > used.
> 
> It's of course used in zynqmp_dp_bridge_debugfs_init.

Ah, yes.  I just did a git grep and the CREATE_FILE() macro confused me.
But obviously this wouldn't compile if we had an unused local variable.
Duh...

regards,
dan carpenter
