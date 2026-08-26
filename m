Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E22C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AF210EC53;
	Wed, 26 Aug 2026 08:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nNHU8FkN";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7049D10EC53
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:13:21 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-66b32bb75beso1000051d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732000; cv=none;
 d=google.com; s=arc-20260327;
 b=kztdMIeMGudI+8hGjcfnJw+dyja+07hb+DiCwtIFUhvsCZEVg5DI7JALWg1Itvm94z
 JyGQjmAl53OWB84bHc+EA4QPNvHC0GMbaUldBu2XfWN62VHkC0pUND0LlBx+X2gOstOO
 l61uCYyeE4lTt2WrZQJeil3ExS5m2ouU9XeipFUpAlNAXDAquoquv8L+WS7O2QfxVjGu
 GKO2/NYUqwlxSs/6xJt9XH02Y1GbnvDy1BHBL8eN1ZZ9qRovg+4ghTcxNQeiPr8ANJji
 uVdRK9UkNUbs1ruVSS+zCmHsgM9xPfQNkXakKJnmYihfcgJw9E4VswBVZo/bQeJVOV4E
 sRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
 fh=4g0mNN4UbrGhfJHx78HX0DUh7F+1s1Dw14N//c4syK0=;
 b=lJD0DQqn2b7LdJMiaOyAQW4/vIRFLUUkmhuPt4hcQewjhwwXXmSvQssG7iuLvSFZeR
 LR4DKr21JEenUJLys5IXe4WjJaG+5N/vR74agkMitIDpNhtE4dQAaRMIqGJeZDYDgsOQ
 Zp0gqBflj6zI0Y+uV2yPfuLg2aP8/Nd/cGNOcx7GCub2dlaynSiWvrM0r2M4S5xTag6x
 OV4zRVjnxs7Reht7sMtELmiATunxad+q920W2XRmdhtLKj4kiFZMKS2erGfK0CVb3yCd
 A/AFRG7efD7LY74p1UHi/W1OdiDQgXf2pFL8Rv6M7kWiaqOdc5w3v1ATHQmAbmLdXfy5
 lVbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787732000; x=1788336800; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
 b=nNHU8FkNbclY7Me/y8TXaNunrHJJv9CEa+vuWAwfQp38f9qF1bETyoG8xFKcHWwTh6
 ot5H3D+gNTWl3OdHv30Xwu0DZT1cThKpvnIUHW7K/fydDuGXR82f7JK8FbiI1/Z8Padm
 wQ+SvfRar9X6kalZ1FCfYjjkGdH4gUpnPtmfeSEVl1yqkLn+ZuXWkskEblTJkPLi4Rbl
 N4eKYrQKjV0I8FfVY4XJ3u7dQUUjawyAynlGlmAehNHddnhJ2HHkeivf24w3Ta9yKi2p
 y/EbX/QeDPmh7BpCB8iMpMsLUrZ0lss8kFFIJGsl/GrPsMUvNFUx8vAiz/8J5TL/jEgq
 j3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787732000; x=1788336800;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
 b=IwAwWFjbGvO6Kc6AlScJb+PTu5EwxdhU8qP70zMr4nLVpf1EbxXATKYjMaDL/D3qxY
 kwrO8u3VafRFbnyGi477Ybx7hZiP/eW/RYQZ4SjbaU2w9UjR6Alg6C28GmdJJO4vlB36
 YnmSLeewQvaFfvnTeyhcQ56G/O+NsL9xbjF8ACyYjG1PS2+W5fo35PweEW+WTWD4nUXa
 CLJ6ThjQqkdXtUrjjxI9nlOpAALRZpSTLYmhNA8zWmgOOYLUKU+mAcjD0aArLVlL6TEY
 iJgB8FGS7JnodLAViOhpZ60tqJorYcSUe0LqnkyDX/+gggK9yhOpnpRGil1vj7ZNEv38
 +kBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5YEU8LGwV3SA+eL0QDzf3h5msYJYgCR7uwvu2JK+CUGY2+niUv3hm8EE9BuYXyy5RGbL2MZh1mnA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mLpZymo8aazkeycjJp0Q+F50naQSGVLG3V3xCTq9kaiSyk3EKY
 HZ6WL7fftwjyQyJlniMYSJqW8jLu0JgqIey5r5PoUdarWxxteAZ06138AV0TYuThUeYwQa/bAsv
 DSaGeZF9EbcR1vsadhNZb+2toiI5bnnE=
X-Gm-Gg: AR+sD13cjbp4LRvrbuUfTN2NJeVs+H3bCWej7OgpiUowm/ZvifkTdQ0jnwmRYlmXKCU
 F0chwOQlMnp2majLG7ggBRcOlHb2Mftb9zsrBU9ecUraYYBNmX/P22PvueWxz/WPstMo1uMc72Z
 Ueek1Z8JbfUBZiJR9jfDNtsx4bUY9OVtc/uS9Jz0Gq8Lk0Wn/Kd97LB1jJmOTptTBpxClZ+waMb
 g8u709I/KNLZjsPAXBbhExZEyDqbFWGazN5LVeg5pglCv+6sh/iMFlES7UnfhzQTFX6y5oBF6uN
 oqvx95qErGRIQhCg5e208jP+vWMDwBUPxHpmfzSt+znUq2E=
X-Received: by 2002:a05:690e:249b:b0:66c:e866:c4cf with SMTP id
 956f58d0204a3-66d257afd3cmr1372322d50.31.1787732000271; Wed, 26 Aug 2026
 01:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260808125953.2842241-1-lgs201920130244@gmail.com>
 <5174855b-fe2f-4a6f-8390-959e9d624cf1@kernel.org>
In-Reply-To: <5174855b-fe2f-4a6f-8390-959e9d624cf1@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:13:07 +0800
X-Gm-Features: AcwNN1U3dbQoVXJ8NkGWFYebcVrAhiWh0QN8QowH-mZ_7LABkMoZbkQnxy1lirs
Message-ID: <CANUHTR8c2+LPRWOPwD=_dG8WqFyuTCg++BZFQ37gzgoEKh-hnA@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, dri-devel@lists.freedesktop.org, 
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 14:59, Guangshuo Li wrote:
> > lima_pdev_probe() calls pm_runtime_use_autosuspend(), but its failure
> > path does not call the matching pm_runtime_dont_use_autosuspend()
> > before disabling runtime PM. The remove path has the same issue.
> >
> > In particular, lima_pdev_remove() explicitly sets the autosuspend
> > delay to -1 while autosuspend is still enabled. A negative autosuspend
> > delay can increase usage_count to prevent runtime suspend. Without
> > calling pm_runtime_dont_use_autosuspend(), this reference is not
> > dropped before runtime PM is disabled, leaving usage_count unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> > failure and remove paths.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 50de2e9ebbc0 ("drm/lima: enable runtime pm")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
