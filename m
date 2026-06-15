Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9A5CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 21:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19C410E6CD;
	Mon, 15 Jun 2026 21:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="k/yBeLwq";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6A510E695
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 21:29:41 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-36c68964315so2123785a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781558981; cv=none;
 d=google.com; s=arc-20240605;
 b=G1Qsvo39RsV3/d3tUdqcVMx+8/CgyuQ10wY+jVzfOjduTFWl+AW4ROj1xjlDZM0vrv
 OVUKlhiSlFNK69Zab+qZA7BDDkQoZt+ICSAsUyVMwMW/24gvD6g7ynrzTNFf0F8WYQGB
 rsramaaAJI6Jm+l8bVEXExD9EA+In+eCZoXd9xgPiLWNe8IrS0XgMt+obCYk036z5GOb
 nksCaTiY6bMWHG/BqUjZ7Qz82wb5WSYrf7cTAUwztRYtHcSvBpVxQhR8f8KrDMrKJ3fK
 sMIJmXNzSrKtgprzgbmZjxE+GMxOqJ+VgsKSq9TqBG4hSKCHqAg3oSkBxyJgxAO7/w1F
 8yFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wgYo7VLpeFYmsBuL2Aaa8Uz9HGtMHARrdfAhOGMsVTA=;
 fh=53GiFqdY9riU1kicXHvkp60aDZQOg9oFBlqMfqLUSY0=;
 b=acQxfw10A0RPEV7iRFmq5MiPwUoP9DcVFzbJJWlNchup/ujVyJCf9biORr4mkAk/B7
 rwPrpDL/x1INRzu+BaNVQJ427T+CF955WidiKLZA5HUHqbf3RnN2gXi0RVTLbd9qjyos
 pyJF0sYdEYk82i4lr7a3E36RJelT4npyHIjsHQ3+KnOZrgW7mcQy937Okk69jsmmwBHF
 Oh5L0OTSl2SCFY1Fkpxfzd4fgGve4Qh7Tm//bYm+6m7Ygk+kwOacaYhpXCR7rgBrbW6w
 rUfo+BwFPAaU1YEa0F5Z2kYBvAGOLincOUPxWkhV8NzqCaVbgsfuSJPBkhei1LwWUyZ5
 u+7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1781558981; x=1782163781;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgYo7VLpeFYmsBuL2Aaa8Uz9HGtMHARrdfAhOGMsVTA=;
 b=k/yBeLwq+dpYwJHkJ+eXmPCZWmCO2Ir8TUN9cov+GJh4Qxg0zHCOatLhLNoSXD7puS
 OqZK4IvTLJ538OVm/Myjvv0a4kbAPGQimewgfg1DuFW6eU3ISw0aIdJB3fYMfMCzrGaJ
 bK3iZDjDMaIJOwjqvVQOFdb3NKuCXg157HIj8pn/ATxZMeBUfm4mepjw2MWaCOJi/DF7
 wkhbaF4S1hcDUbv9gx+HwRNTfXZTcSr4xDNrj2QKC5rMPxm+0XFf2a5ev6tGnRzTeC3T
 BrzAH0vTqYzrkp0qL9EX+TWI0gfjRFTLF+0C00JAIR+JZ6JpJduFtIE1qIHmh1o23NnX
 EJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781558981; x=1782163781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgYo7VLpeFYmsBuL2Aaa8Uz9HGtMHARrdfAhOGMsVTA=;
 b=aX5ISVDcLAuaLWZMyLWbP4fNyg0aLar55hypKW5yHSVBm2BdGRdOWoomXP9QMrLYks
 IvI1ooNC5E1Yr5ObnJYaDz9IPBylpeVzVOZBI5HvMWur7cSd5pOjxoJdPEWdNyp1O2d/
 mKJmuYQOhxFu3eBrrd2f6ZwhYPoLomsxQT2/ZA9dkl9a7Le8QghZ4MpgQa6AB1Y5JBxW
 v7melIkhxPRPI84o7fe6wytQs80Mzw5X6C60HtlVydJa6rUxtJgS/zhiW8GT4q9msnS/
 G213F2H/TKwoy4nRrI6JBv83ub/tv5LhO4F8FIc30wSy1P1xpk6bupJCWw4rGyZvc9Xq
 lUJQ==
X-Gm-Message-State: AOJu0YyCvhiZJhF1YpJADHksvm2g2QYTjoMWaRx4QLIUR2FQWW2KVbW+
 iNEISpf+M+Nzrgi5SidiY+GwY1Adq4U7FUfTS3JPdfY1Xd8yqUhROp2PMsHTimQXfTqgLlGbE5N
 /t6/Qpc5+1uv8RHIc3uw9WonoomPuAPfULNmyeviAhNpKpMv4W1J4
X-Gm-Gg: Acq92OEPhsImG4vahh1q8W4nQ5H+8lvBg5zWnl7M0Kj1wTzxn0QNgRHVoA9/dZ0SCVf
 JLzt/pw8W7aqrLnLaJnIsfwY0S1193Iau2p/bmYcXMp1nfrqb/OBgCPMPOEWw21MVAI6qn6Z8av
 sdIiKcqDfGqOws83W7fU3Ec+Alva2hXkdmBq/WVHLeS+oCa1pvVlzOZPDLYwDERtNY4Ni74rrsc
 4Ws6/KHZlkYxVuRsxKLMWw0+khU4JFtcSaRd/p4kspWbGKfKkHREPG2hHT73gjwPPetekQt+yel
 zBjPIGs=
X-Received: by 2002:a17:90b:4c09:b0:368:3d3e:efa6 with SMTP id
 98e67ed59e1d1-37c523fb93cmr1122216a91.20.1781558981034; Mon, 15 Jun 2026
 14:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260602191754.79047-1-derek.foreman@collabora.com>
In-Reply-To: <20260602191754.79047-1-derek.foreman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 15 Jun 2026 22:29:30 +0100
X-Gm-Features: AVVi8CddNKZCyvln3YagaRkOsAjvQ6tGtxnUWttjn63qXxcXTUItYaJMnXKD-gY
Message-ID: <CAPj87rOyM1_UFKbNLrZXDNHTwVQ-oK0kpUrhw6-04efJiD4VQA@mail.gmail.com>
Subject: Re: [PATCH v2] drm: writeback: Document behaviour for framebuffer
 size mismatch
To: Derek Foreman <derek.foreman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
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

Hi Derek,

On Tue, 2 Jun 2026 at 20:18, Derek Foreman <derek.foreman@collabora.com> wrote:
> Currently we have not explicitly defined the behaviour when the width
> and height of the writeback framebuffer do not match the width and
> height of the attached CRTC.
>
> Allow the driver to perform a scale operation to fit the content, so
> systems with scaling blocks in the writeback path can easily expose them.
> A partially filled buffer should never be returned, so failure remains
> an option for all the systems that don't have a scaler, or when scaler
> limits are exceeded.
>
> Cropping would make less sense, as the region to crop is underspecified
> without some other properties to define an origin.

Thanks, I've applied this now.

Cheers,
Daniel
