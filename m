Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C024C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7E010F688;
	Thu,  9 Jul 2026 19:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATfLuWkD";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D84010E2DD
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 19:41:31 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-37fc02e660bso419110a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783626091; cv=none;
 d=google.com; s=arc-20260327;
 b=EHfbl4uRJBpJU8rvS8LVCsxTWuOamviApxySTwCemfUUG1PrhRb3LgCOVXqPBXhxEM
 thmKAsLvNOQXc499ErBvfQ/omsh7bemIaLgU2WvrwnUkQOYXffdDSnbjzJa1grNKjvBA
 D45R8Qvd3Xer34oe9HYRQiK61a5+ek1C82vrPKfEBRbQnJFT06pt9AFNqRQuW6ya2vP7
 0Ew/On9n2uRbn3UGdPDn3CmyXqtSmGMl4tHcfH7XSNwEidLBdK5L/q2eNjm8Vlhgp08T
 SAGqyeiKBW3OCueqLaDUg30RjKf3mpE40v48Ey1MJsvRiGFlLDh+qg/l2Exfq0yHosE9
 S18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zHfbWvceYtNCdDOquHNIwQRMo++yUsptvvWFceb+UlQ=;
 fh=FmdG5kTC07Bml8gu62jON/Q1T0Oq7JzQYnb84ZKTqSU=;
 b=mjYHjnYeKgpxE1gyMfJ150DqBM/rdktcrmXG5K/QzDxUyVOmyv9o5kwPp443ckAQWU
 CMSqOprMaUaH+ckOEufSbKW00diIGNk5jyd1NwGtvPsbTRnhShkU5VB92pTHAZb9oRe8
 2+uS+WVQEMS7WNCcASjXAPmQcVKuAAvATt15UvFVRZlCE+Yt0Z0NNou1JPGO3j49h+Ef
 VxS86qqv6m4EfPuK8vQJu4Vv+54gp9MZsB/gFhU1/HC6/9J4Jzv4m8rYmOMon7k2wb+X
 q0zR0Bcuotb8Iwl9xwgV4O1/+/qdC/OlTvUprr24EohN45wj97Ow6sp6OiSBnyXduvGC
 Pjmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783626091; x=1784230891; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zHfbWvceYtNCdDOquHNIwQRMo++yUsptvvWFceb+UlQ=;
 b=ATfLuWkDjZ8BB//UAVVK3hLXTyBt+TsVOoT5UQUAkq1QxcFzmdRH9k4t7rbzXXjCHb
 BprEOH2lnTtyERxW0p9bXwbO9BlFcSvWf8Hi/Z7QNuRVRU9KyL0EUlXHKsI7P+Hxdqag
 +ergJcYK2N+aJOB1p8wZMRVt6Gwy4KUob24RqXx5i8wPEW4QHmiA8Yhbqo0q67bVGTAm
 +bLGYIzd7B1L6cpLV/HWESvH3/z9zuewCBiV+XJinBdxxY+daaDZna1OO1Nlq3FeAOTb
 s5+8pyptXHxCCjGg8sHGM3nKxmaGJ15Os+zEheWeyh92Ikp/1wxIb9HLlfV6ldC7CoPo
 ieQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783626091; x=1784230891;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zHfbWvceYtNCdDOquHNIwQRMo++yUsptvvWFceb+UlQ=;
 b=ZuZ/A/yC86UFPPWK9kiV67mXvwBZFkLgSRvw3C2uHzdzJvTLrrn/MShWS563ateXGp
 lHG0glqy+AOocTUtAZoOkhJxOerQomS60PC5Whl6c+PW04bzkNRJMmYBrPqU211KN+lS
 +FwoKkjP5JJquA8ai0V8tg+l7Xs963cAnXaxBe/eZw2yOoWCo03y2RF2iI+tp9hQXyTc
 YOgf9lkGgPYt+jxi1a0KTh/URJ7G0m8ZiBVfJX+uM1u5OQW32mNnEX9hnDj72nd/Id+8
 2CWZrTKLnk/R8kKl90tuEcHqRZOpy2dOBdX/u6KCcKexUe+y4qVEQTPk8ChYek0eXA08
 5U6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpG+E9aAcROU+H9F5cLzt+qdJcRQzwyZ4HLn+8B0dG4sf+38n4mJOUbage8DjJwtoj3YfkzB6cWFkw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbBiTFwJVLDLXvjdTDc2jeyp2V4lyxkPLpXVed54tf1lvfY9Z/
 GfZKkGE0wTXk7a64t8OdrPzZeYIzhixMvRdabPZ+R6tPKW7YPsrJtXpGTUVqSpa20KsdNJ7WnWt
 SpO+q5sykkXSxZ0sSF5OHJ0HsZj4dRu1NHiSap9w=
X-Gm-Gg: AfdE7ckotoFnYMwMylTB6XayOsnON8nOaaKin4PXQc/my1Uck71Ku/Sxgqcg0QaRrSf
 V1BjdzYh2ufJcJhSVF8srKWDo9ONFr5QWPHqmLoCbeL98lIqHXvnWrd/zy+DsixbwX4WxNo+f3V
 Qspmm733OSA5wBzItjSt8IK9U6d78XM2ybVT8BdgtcNcWLy5o1l0YvLp3aXc/WAHOodz0DUQlEl
 /h+VJx5pCH7MN0Ro/vWeuHkbcj4RC2QN6h1trrAMEGOYouVAXkxKhoOZU56ewwwpI6/LfRLbTW/
 aq+mg3l5P9Z8qVImBCgvlsfhd2o=
X-Received: by 2002:a17:90b:1cc6:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-3893f694da8mr9270487a91.4.1783626090656; Thu, 09 Jul 2026
 12:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
 <20260709-etnaviv-reset-notification-v1-2-64c617496958@igalia.com>
 <bb5b8c8ff15f8d8b9ad9a61e4887c14b9f77f3d6.camel@pengutronix.de>
In-Reply-To: <bb5b8c8ff15f8d8b9ad9a61e4887c14b9f77f3d6.camel@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 9 Jul 2026 21:41:18 +0200
X-Gm-Features: AVVi8CeFeKNUemL2fppBxdxfNYVr5yohb1CGwVI71F0h_5DHOML4Od8oL69mxy0
Message-ID: <CAH9NwWe9gDjg-6_e1KHdUQ8_Pi2sjhfDizZGzWavQAnnuymQ2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/etnaviv: Add GPU reset counters
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Christian Gmeiner <cgmeiner@igalia.com>
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

Hi Lucas,

> > The OpenGL and Vulkan robustness extensions let an application detect a
> > GPU reset and check if its own context caused it, so the application can
> > drop the broken context and build a new one. The kernel knows both
> > facts, but etnaviv has no way to report them to userspace.
> >
> > Add two counters and expose them through GET_PARAM: a per-GPU counter
> > that counts every reset of that GPU, and a per-context counter that only
> > counts the resets this context was guilty of. Userspace compares the
> > counters with saved values: if the context counter moved the context was
> > guilty, if only the GPU counter moved the context was an innocent
> > victim.
>
> I don't really agree with the design of exposing this through
> GET_PARAM.
>
>
> First it assumes that each etnaviv_file_private can only have a single
> context, something that is true today but which I would very much like
> to change to rid of false dependencies when the application uses
> multiple GL contexts through the same screen. I have a rework to do
> this in the pipe, which I didn't get around to finish, yet. While I
> don't want to block any of your work on this rework, I also wouldn't
> like to see UAPI land which bakes in the single context per file
> private assumption.
>

Makes sense. I only picked it because msm and v3d expose their fault
counters that way.

For v2 I have replaced the two params with a dedicated ioctl:

struct drm_etnaviv_reset_query {
    __u32 pipe;            /* in */
    __u32 flags;            /* in, must be 0 */
    __u64 global_reset_counter;    /* out */
    __u64 context_reset_counter;    /* out */
};

flags must be zero for now and is rejected with EINVAL otherwise, so
your multi context rework can later add a flag plus a context field to
query a specific context.

>
> Second, with this design each userspace query incurs two roundtrips
> into the kernel, as userspace needs to know both counter values to tell
> innocent vs guilty resets apart.
>
> My vote would be on adding a new ioctl to query both reset counters at
> the same time, with a flags argument baked in, so it can be extended
> once I manage to finish the multi context rework.
>

One thing to note: the global counter is per GPU core, so a context
that uses more than one pipe still needs one query per pipe. I think
that is fine for the robustness use case, but tell me if you would
rather have a variant that returns all pipes at once.

Will send v2 shortly.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
