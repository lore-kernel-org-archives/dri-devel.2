Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA8C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F2E10E1CD;
	Fri, 14 Aug 2026 20:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3MTcF16";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A57410E580
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:20:59 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-836ccf53ef9so13229447b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786738858; cv=none;
 d=google.com; s=arc-20260327;
 b=cVUGFYg6okS0PfZjfNFQAMFvsgD7L/jaWwPlBc38kL5MzOEn7sRiv/jbwKUfc1KUTG
 yZ8z8Dj3m40eEARHNrQfyEZlARTNxjTJgXtVv/6nNSaMP8NCeTRpwj5wFo+A4JoalJ/M
 TiHHvgzSiXM5XOQEATNk46AqiUfWUYbuD05UXzUizyMBawpGxzmIOqnM+LXR9TC35INU
 nQbBVvnCvtLmgS3jJ9ZWsoYbywmfuxC5D9EtlNqHmBDvuQYpQSwouFe+7LV1ASETWaBM
 MNI48BfzV0VGeQ4C/rKklnCbVWGNFLMBlfeb6+eHK0ETEPi3C7VJQLzH40T1s/yQswti
 zjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gRAG93k1GVptmbdTCo0eE+L0lXLT9vpTHkArYVWzdM0=;
 fh=gfhM5tcTB20icenKgXNdkPPgRP3/PA7HBa9FVr5wHpc=;
 b=GBZRogN+OVYfJolAVJS3XCm/Lg000Rl6cU9yx42CPQ4GtBjP1twgGSj8icmMcbMMsn
 8yeAt6YMFYITh1AR+DdYcFRgCCSte+vDYeACo+SL4ortqflHT1iCcOaEEH/5IHHwwadY
 0QvRzPg0JodQEQpDoa9HQabiNL14sk2KMdkvFf6hov0B+aOoIATTiBbMRaJmuQxylluo
 uTo4Dw7SL0nzpGHPY87Hy7PfLC5KrquBz6Rj6RKstgAQUYSePhYYX3/aR6WKmnXQ850K
 UctFMPOxpYE0WufOO0PZZb9yuW6kDz1yrYcp7GjENp9Y9yzRuN+7gcEg/OuZTv1v0dvp
 SSKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786738858; x=1787343658; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gRAG93k1GVptmbdTCo0eE+L0lXLT9vpTHkArYVWzdM0=;
 b=i3MTcF16r8dVXiJdmang1+TiolcYTczpXGP8zSV4VmbD5bzn8klkQSr3p7QmcqGEoX
 7UMfPeeXL+72qKrEarIp6OxrCIQPBE5QGr47aZygDLVF7HQNB2bc5uq2youUC0N720SW
 j8DQ2GKoAEYXDHb9n41RjkMIDyB68Y8bZz87ddpw3xOhhcilVvRZnCw7KVP64+XxhJx/
 SFH+T5D1GeXlECCzMc+NWTHzrfZZdAciYvLsHQ29Ksyxg2v1m0WoEyLj9KI1/PtyjO0M
 tbxrULdJXtzMO2WlBTg84PUBj4QCa3XaP9k8nBH79unATKRrLodSADXZSKSiPdb3BiW3
 HtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738858; x=1787343658;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gRAG93k1GVptmbdTCo0eE+L0lXLT9vpTHkArYVWzdM0=;
 b=Xk283xY4Q44lPc/+bH4/C6m8W4AgE9dWrdmioFjWrh2TZIKb8xi6WdcTHNb2Qd4oEz
 KBIcRcjqSAprJjacLUczukO0sCR7U0+i8OeblIuvbONcT7HKR0vF/EW5W+4l+SnCt2no
 QWtZulkbJON4gK9dD/IvZSsr1o6f/GYlIWWsMqC8YBENdyMv4FtKKq+tQ8hdg7+Q2Pfw
 0b9uKa5xGi/nTXeSqTc++aZ+7vPkmTvHF8DvDAJ5UGadsX9YzOVT9G9i6yKxhSrlZcIY
 YWsKeATKBlvTMsivru5qviUgC3/Zr8D9I/xET6xZPc5EOEnWrVXenkXHTc6SEv8rHav6
 9WxA==
X-Gm-Message-State: AOJu0YyN+CVzvkEe8CB7qXDlzLyn6FYVJQnoafBP5/NPzvFUeQXP29P3
 Q5YUs+aRdsigRWTLAx8LwfdPH8sujTjrDZl03gjtIircNGY0pj+d+LJEXqU60Ge8Kj8JuPWyIGu
 hjbk1oCQF5ngwz3gqHUrZOWdDhXmSsB4=
X-Gm-Gg: AR+sD10VU61aOxjO21ZFicBb37+97G+DasirkDTbkDjAjQpKrkV8HzXAbNCBzepF29d
 diLBuWe8YtyiEfqFItqKv9DSCbZfFlatj1hILBfVoEXs06IWzbl8cGP2wg1x5p31DwrT+DrqdnX
 hbGWRgz4O2+P+U1LXYZkAEmPO6Mqt0LMsYiad5yGoSi5VsLTgfzpjTYcmwWGHnHEbD5OdbAoWdz
 W9BO0o4vWq0Y/o974CeRBTr95M737il/7foetYkp/J+T3LoSRnC6EXI1lWkcTJt5H1ULv7M9mRF
 X6yCL+kjcDxwXFdENzjq2pET3KFlRoot3AObJm7tifTe49fDXsmFBdpeZIAFyGfqh3ubFm4MusA
 e4AKQXc2V0Didy8oM+dUYHmUJuKcHaY4r3P/2KVei
X-Received: by 2002:a05:690c:e155:b0:826:5659:28aa with SMTP id
 00721157ae682-8371337ca5cmr27191147b3.32.1786738857781; Fri, 14 Aug 2026
 13:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260813204803.2097176-1-lyude@redhat.com>
In-Reply-To: <20260813204803.2097176-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 15 Aug 2026 06:20:43 +1000
X-Gm-Features: AUfX_mz3wwghJ9smyt2jMhsUrFoQRZdb1PKezt__6MAt6P8Xzp87ZulTxam3wao
Message-ID: <CAPM=9txMzUap-J3ddsUeHTYbWyEhHTzZHV1QxOJuTZuo+CG8mQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/5] drm/nouveau: Enable atomic modesetting by
 default
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
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

On Fri, 14 Aug 2026 at 06:48, Lyude Paul <lyude@redhat.com> wrote:
>
> Nouveau is one of the very few modern hardware drivers in the kernel that
> doesn't have atomic modesetting enabled by default, in part because when it
> was originally written by Ben there wasn't much in the way of good atomic
> modesetting clients to actually test things out with.
>
> Nowadays however, atomic modesetting is very much the norm - and support in
> userspace for non-atomic drivers is starting to bitrot a bit - leading to
> its own set of issues. At the same time, many of those issues are fixed by
> just turning on atomic in nouveau. Plus, I've been running nouveau with
> atomic modesetting on by default for most of the machines I work on, and
> I've already fixed quite a number of issues to the point where things seem
> quite stable (excluding a single screen flashing bug on my desktop, which I
> am not particularly convinced has anything to do with atomic modesetting).
>
> This patch series enables atomic modesetting by default, at least for
> NV50 and newer. NV04 is left unchanged, as atomic modesetting was never
> implemented for it. This series also enforces leaving atomic modesetting
> disabled on <NV50, and adds the value of nouveau.atomic to our kernel
> debug output.
>
> Previous version of this patch series:
>         https://patchwork.freedesktop.org/series/171310/
>
> (Resent, because of a formatting error on one of the patches)

Nice, for the series:

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
>
> Lyude Paul (5):
>   drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()
>   drm/nouveau: Print the nouveau.atomic parameter in
>     nouveau_display_options()
>   drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling
>   drm/nouveau/kms: Only allow enabling atomic modesetting on nv50+
>   drm/nouveau/kms/nv50-: Enable atomic modesetting by default
>
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 116 ++++++++++++++++----------
>  1 file changed, 71 insertions(+), 45 deletions(-)
>
>
> base-commit: 9b388fc3d0e63a4f5b022d326151e176e8d82e25
> --
> 2.55.0
>
