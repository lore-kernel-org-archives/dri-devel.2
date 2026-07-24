Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96431C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7403710E2EA;
	Mon, 27 Jul 2026 07:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qP4RLgJ0";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4DF10E054
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 12:20:15 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so394779b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 05:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784895615; cv=none;
 d=google.com; s=arc-20260327;
 b=OHKjP6ZP/bw/lntwQy2aUDskM9BRGyb5UdRcPSMR/nbo/f6vyqaS8YYBfL+iYnQZTC
 p2dUceXbo8jPbSdsvSKta4un5Y40SZmBgCHnutkyxNs+z7c2YOtZIQLPDHq/3yJ82Qrp
 HexFZGkteg4JzBQ02VKcGCGN/6h7iWZkEnR4nHRcf1DMyOod1akeyNKejv4N1Ptw+rez
 uIKFuKGQ41jolfBJxTZN7gdgqw52BNoFTa7vLVzKWBW6SXScw+t7QXbBkmgnlxX5vrjE
 squi988KZ1F6g/HEuUuijltmuCae3MbzmcyrjpH6W5lQ05cVz9O7tflSTERLZxKVRTwI
 YqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=He9IylnwVU8PmFaikhcxjbNX9jpKW9Q6eph9elsXJ9I=;
 fh=hkonlULLIvIuVGMEYRlEapBqUO25i27+qunr3D/dz48=;
 b=qRoZaGAqVxUQCljohdGp4XIes7jbEIavfOokdNllkcDwb7ymqioE2G66fQy4WwyLLc
 UF2LAYOfXZgvxf6Na2/p39qW5ZalfGiG5RJEzMLtGS4TNZf4QIFgJ7tCksSKuE85mgOY
 PKxjbeDfjK0L3dzJzdNvbMfWz110wXr1n622+fljtHmg7yuxrDm+ho30loKhGlMyXF5O
 LlYx/tP+QF/A+7Pu3ant5KHVZWhJ3cr2wwOiRcO0TiZcMA+GNj3rm4hD5w25HaVrJZxn
 u3Lc5At0vf6q4CdqPOf15IyXwWHFX0nmlwVTEdUj517yigcVTRTHQSXFDrPThdV3TEIz
 AtkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784895614; x=1785500414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=He9IylnwVU8PmFaikhcxjbNX9jpKW9Q6eph9elsXJ9I=;
 b=qP4RLgJ01hEoU+H4klGX99/BKPRDosujuJ+Bvdh7udRH5xhC2th59hUEfPMAsnHXes
 MwaNwutna5KyOgFKIm+zOPz7nkib+5FAce6AvKp+aO0KQWGAbCzEs1/MgPwe+KZNj2mm
 Z0qIQXNU3ja1IxkbI6Qn6LggvncJ3gdajKq2K4Hu3jfIZDOJVm5Qdpex6zZJOvrDe4gC
 Y3/3y9rpWr8s2upLF675CYqO+bpIV9ErFVkMIHMMhTuTjmIQoetbelLOH4tFdG9Oy4SC
 FsTovKXzw5t8BW5Q/zuFq+RpZ45Jc028+cDAFcoN0rEutfM0e6YhICPq3Ga1WJ2qqugs
 2D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895614; x=1785500414;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=He9IylnwVU8PmFaikhcxjbNX9jpKW9Q6eph9elsXJ9I=;
 b=e+XpxsdtZjC1JKfi939APQRufdt5XbRrVSb9buIDIWfKf805SCPEHpEc2vT6rDYO6q
 jIR2DFMI9TDh1VtjcFA1IUvUTTBnPFVfVN+WzzTUjtMXo9paeOr0dAgbVdlW0HELy9zT
 5F1dd84LB04qlkEjd5GJIwJvHtrsEHpw9ddFkKnznTnL+of3kQpN2gesbgMM+fvzr2eG
 q0XpXpmrfu4DWq0953AGtEv5YkE7LUF+SKj0+Xcimfex0rsjtltPG+ToQhe6b+kF4SSg
 3cZtEGPJ7eicxJfkOwIMrnEMe2idQyBwq79t6b9mjsbNaW8jwutoCUfHGc4veMt9T/XF
 YF7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyU4+GN+FCsEDyUqbbZ/S0DwA40hmPeF8xMQqhKzrADpvNEDWqbiw6AL7hazg+48YBdVS7S9hbN6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu7gRPWZAf+SeIroh487aRL5n5d8SP0Q4DPzeH2rw4lJsXIVHs
 DEkALzfhj8k0w+jOFylal6PqrzNyLqTv0fa/xmjE1SiB/46tfcFCijEBP0t4DQFMoUL4AzX18mG
 y67JsSekle0vOlQgu9DZlo3PSe4zpQBA=
X-Gm-Gg: AR+sD13oh2418Fv/DKv8m7vN/oUorOUeKmawccsXbaEFzaXL84qqtv2BgM1enj5Uc1p
 SOuJk+nFcu52RsPRfhAoSMb4n8lPFMXci5oJXeJFxG/zp1N3L8F6TUude3/lxpyi/04W0/cVLf7
 xxfYBCUlWFDKFaTtg4k/N5O1mm1NHXqO8dSZNGxpKdC/SyHXAhy5S5h02SRCSMqxOQWvN9NJjzo
 kpXaKDSNA9SrSQZSBCK0M5UTzBcRVl62GypSa3dZSRLKnfnalw27XJs1wVheefL+jHMHdzJHKXk
 d4jaZV9arHpY5ZwsIGgNBqvy9CENiq+74ZSOlJw5ckaDN688Wo/XjCny/9XievRZdqapTYiYW6B
 Ue67d8NjXOdHYh2XkI4bgrB8Ceu8gqz3Q
X-Received: by 2002:a05:6a00:4b11:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-84e2b8336ccmr8195406b3a.17.1784895614595; Fri, 24 Jul 2026
 05:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260724103235.57577-1-phucduc.bui@gmail.com>
 <20260724103901.GA1051157@killaraus.ideasonboard.com>
 <CAABR9nHd9eSsu49zhzimr0NVSnb6NnxU-bR=3rkeK99K_7CHAw@mail.gmail.com>
In-Reply-To: <CAABR9nHd9eSsu49zhzimr0NVSnb6NnxU-bR=3rkeK99K_7CHAw@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 24 Jul 2026 19:20:03 +0700
X-Gm-Features: AUfX_myTbX55fcAEYedkvwfSBzfdrzs48vep1SE3KM8lISsyn7kckdQ4EGO5BNU
Message-ID: <CAABR9nFQTmKTCZV+Bif96VF3Szw4BcTyGUToNXJti27yX5gk2w@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/bridge: adv7511: use cache_only during power down
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

> >
> > Please give a detailed example of a scenario where that can happen, and
> > make sure you can reproduce the scenario and see the issue on your
> > hardware.
>

An RFC is definitely helpful for discussion, though reproducing it on
real hardware is always ideal.
Speaking of which, it reminds me of a DRM patch I sent earlier=E2=80=94whic=
h
also deals with register state
restoration across power cycles.
It was a real bug that had existed for over 10 years, fully tested and
verified on hardware,
yet it hasn't been merged yet.

https://lore.kernel.org/all/20260226051338.27460-1-phucduc.bui@gmail.com/

https://lore.kernel.org/all/20260707093004.987846-1-phucduc.bui@gmail.com/

Best regards,
Phuc
