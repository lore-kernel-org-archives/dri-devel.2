Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678DCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB1C10F330;
	Tue,  2 Jun 2026 15:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IUV7UxWh";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EB510F330
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:41:34 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-36bdda53d99so1709470a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 08:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780414894; cv=none;
 d=google.com; s=arc-20240605;
 b=AGICKE2BNpShDbaO4YRyv3zUcBQ6HZqwR2qohCO53jvnDVEj3cLAX1NZ2M12ph67Jr
 0pHswXWnR8w48ZMHY2aIwsdF1yns2nEsReRjMJ5YRv2jA1rH57h/7bejTEQdpuRPsZLr
 LW2cXlFlRwz9n6tp5R7ezA1/GhnLIEpXfNXMLVgZu2S8bh+9ppbSlESNLPuLXNND0bE4
 c/sL6ZkwA0H3BvVKBtGa6bK+s6EpglgeELJV0QUsX958i4NTy2JYVVcSY+KcIicb2qiA
 sn34170m1aeOiFi/5HYQm6lm2nIAhh6cEhDcTpEe7GZ3idGim4isFHRXmE2HZS5UD2Os
 1QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DuB5aq9eKeu207VyIAsxwpZln/RB5Nwc2vs7XjeZSso=;
 fh=KZEvLFzeo/odSQjKhW5sw5GfoWPRGAWAecQwBPXoo7o=;
 b=gDwNKe5iuWc256Tb0gwjn6kqMI7sMqwl7rUOqwmhiunaqbsCcarF3TkgPWqVk/mPh2
 CmHLHTbTiORaBbSASmVzqmc0QKSeb6eG8jPbb+rvPSptpIuH1zzB02kyZY6e5MCTADrN
 QvbvYYWgstXhuoz1vlUwi3K55+njz4EF6o0nAkR90yDavOmOmLyY/eqLmdMzBxPf/RlG
 y37E4Ksfp6ncelKmRO9taju9ZyW6pgdNgq8IA7g0hyxFK6LsREriloOHBDotKXbnjplq
 pv+f1h5Mco5NCcdD3I5GjiZXB8BODZlmrvW9Muh7CkhkG00tJDUKONZwOY5mzyvO9g26
 cr8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780414894; x=1781019694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuB5aq9eKeu207VyIAsxwpZln/RB5Nwc2vs7XjeZSso=;
 b=IUV7UxWh/z2qUiImOz3rHv6Nr262eGQ8IA5nWULs1t7R5TPRcE54yetEQulkDfRwKi
 B3UPGIeI/pwFrRH/rE2EH7XqHsmj2b7u7krvpy+QU1Hal8Z8dAYqapbPPUqgmU0TVA9D
 JhZ0A5OyMvHLG3RqRjgxDjy5YXdKOpc8FtVxRBqXVb3rY1FnSxQwb2YQN567yvVbBtTR
 3T3VrFYxK0srgde6Im4C/tAB/p+cH1CzyLwv6X8FTUZylH8zMBHCx4GEvX/N5ke8/ufZ
 Lk2rBisalhtwj8yqPnN4LxsSc/Ch8cXkWRTYhRdtGwP2Y72HzFPN1G+iswR7dGnXFKm3
 jByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780414894; x=1781019694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DuB5aq9eKeu207VyIAsxwpZln/RB5Nwc2vs7XjeZSso=;
 b=gIibyL3IY00nhU60i/N6yQNyNKCHQ7/Hq/npgIq2m15GdiCGfaglkhsIIUxzwfBYcp
 WnGwQAWip/SPN2hXJm6PHsTJTDSJu4FeA/XZvEQAa2YONPYqAnBuwTAVEdhg+FVUNxJ8
 H/n+yWJg85XF97s8TIlO/VwKAFlEdTofqSOwtHDGwvd+RZU/jty9YY5Zs3yvUAvcw+dX
 98/lexvPrQqzIPOVAZf7yfC3TwucqxOtgrh68Cf3dOEwFrn7zrLYFcbIquYdqBO0Dfe1
 UsLlSz9OsBM5bc5H1fhgDEWgDyyaCErl4sXod3bXUWhm1SBbwqtROks9bjM6gbP15MZU
 kFUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KKx/7hDy1lzAjEj9fpC+RvAowFa3P5NsTcc0KnJvpBIhj0oSxccHS7oPzoaidGnPmWrzfKK9e2Xo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9FGvKjFUUZGL93G6fahnEb3T+3RX5P/sBLWoE0uix/EnciKZ3
 Z3/aTikuyxemxuE0BBszA9iqRXzTIV3PDjDjanbm4Csu/kuGE4LaRxrPPevsqcRuULayM9PBxnJ
 6zhA6FJp4vJQX+TFMiCbVYGRuy0QAjPs=
X-Gm-Gg: Acq92OHKL+H5ZJrPYaZQ8OR+Sq1jGktogl8tY8IPHncu70mZYV33iM7hZHAj+gTu7Di
 miP5ngtXv2dQXOKjgt5rmLwSH+v5vEowmHUJXxre7+NL4uY5gYWkOW8NMxC5EEPxj7+6S8p0T/m
 bnwc15LNB4n1cXzotPXHem5QT1SB8eY/l5ZGGYNXc6dqlItweIQ1kBdemIrgmAk6QuICqrncYdx
 BxUcFUZazHdj5ORQ25qsdd1Luh6k0VhCILS0GCDHu7NeZfk7myyVNJDT5BzYJ3zOenbO1LyvVo0
 9NuD2tGrbX8C7w==
X-Received: by 2002:a17:90b:5704:b0:368:b01c:85a0 with SMTP id
 98e67ed59e1d1-36c501db7b8mr16243474a91.14.1780414893981; Tue, 02 Jun 2026
 08:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260525140422.1545327-1-aha310510@gmail.com>
 <9956a72e-57ad-4bad-a3f6-87710eb4924d@igalia.com>
In-Reply-To: <9956a72e-57ad-4bad-a3f6-87710eb4924d@igalia.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 3 Jun 2026 00:41:21 +0900
X-Gm-Features: AVHnY4I0_jOc9FccwbCyX5X8rcZfR5ER5QJnDnBTcP1bMKaXPnYiuiyVra6NARU
Message-ID: <CAO9qdTGB=7K0SJCiCpP9TYOk_3Z6wETM43m49FqvD6iw9ApOEA@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: fix to avoid cleaning up uninitialized CPU jobs
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ma=C3=ADra,

Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Hi Jeongjun,
>
> On 25/05/26 11:04, Jeongjun Park wrote:
> > The CPU submit ioctl checks cpu_job->job_type before the CPU job has be=
en
> > initialized with v3d_job_init(). When no CPU job extension is supplied,
> > the check fails and the ioctl goes to the common error path.
> >
> > That path calls v3d_job_cleanup(), which expects a fully initialized
> > v3d_job. However at this point the CPU job has only been allocated,
> > so the embedded DRM scheduler job state has not been initialized yet.
> >
> > Initialize the CPU job after parsing extensions, but before validating
> > the CPU job type and BO count. Keep pre-initialization failures on a
>
> Considering that this is a minimal fix for stable, could you explain me
> why do you believe moving v3d_job_init() is the best solution?
>

Because according to the implementation of v3d_submit_cpu_ioctl(),
v3d_job_cleanup() should never be called when v3d_job_init() fails to
execute successfully, but it is currently being called.

Therefore, I called the init function before the job_type check and added
the missing v3d_job_deallocate(), which should be called when
v3d_get_extensions() fails. However, upon re-analysis, it appears that
adding the fail_init label is unnecessary now, and I have discovered
another serious issue.

If v3d_job_init() fails after v3d_get_extensions() succeeds, a memory leak
may occur in the memory allocated by v3d_get_extensions(). In such cases,
v3d_job_cleanup() cannot be called, and consequently, v3d_cpu_job_free()
cannot be used either. Therefore, it seems necessary to add a separate
helper function to handle this case.

I will quickly write a v2 patch reflecting these changes.

> Best regards,
> - Ma=C3=ADra
>

Regards,
Jeongjun Park
