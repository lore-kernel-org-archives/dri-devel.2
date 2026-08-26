Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7EEC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF0210EC51;
	Wed, 26 Aug 2026 08:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cPetaliH";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3352510EC51
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:13:08 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66c7127a73dso883244d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731987; cv=none;
 d=google.com; s=arc-20260327;
 b=bdr1NotPEp2zMhoVu9y7CjEpDbO5ZwtoyOpj6UqM11Qnj8O/Lr8ZdhjGMgGG/M5Jqd
 rdUEweNVnoQ0pBrthg5PwyHYWALEp7+q5WAP8jViQlsywATHMFyxQPfLbpshRLBwynQj
 rg8PmnZoK9jQPRIMQAJhQYBqcYzZIOy46zYcMh2VEtSBqm6ME77WafEfM/hWyF8vtY8y
 aat3b2psJ7RRD3rhTjiOLZSkIYiiCIiIkiyUp6Olt+ll5txOCTP9a+1s12Y9ZsP5C1Ph
 eD+2qd2dg+f/TZPEzqtaI8Gkm19lx6J3o6Gn+HTBTZATr4j73rD2ESGm1vkEe3kZ+GZ6
 Xh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
 fh=yiR31S1JRCM0KBTVMlUxIFZomRwtInydEtUxUpNdyzc=;
 b=frrSb0rYJXVLXpoPggw9sxGgGxXeUvv3Gw+rCXOYTDpCjG7EhNC3h73ucGQ2xJ/Pk0
 m2QJMvOc1wTRTZelU8kd3D/Cxgbn470k8TfYRa3+MZsbqxvUU6lTfbhkWq7sFZyDp3zm
 rsMA44lRNiJ8SqM8JbsPzVMKGGNva5lcFynaxJL+Hz1oT/sbxPayva4ma1iMUeUZxwgx
 xuN9RmueH8H7iHxA1gEiHxvZN57v1shFcrtcG3hmX6VkTjS0qF4hZPyq5YVqNRjUIYVL
 vPkhweCEjww+Va5v8g6VL8sxGDaBzqdrAwWoFk1HrYiGacMHCaM9LSbpMtESdbJWiutb
 Wm2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787731987; x=1788336787; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
 b=cPetaliHxKhLIl7cQWWX8M3BeSBls4ZUWHy6P8orZ/gcFzMDowz0Dp7cRwTsbho8iv
 K8hRvW8BREfw4DVxszjq/uNPwOBa+fsMBhlRzr4UXzn8d31Axf1a0V7JlKiDrLT2u1Ug
 cMwbyGPmg9Abkz6REeRaiVeOfwYNvJdZTld0JMdSKf2f94OaqrH9fofkC5b9wNxHNUbz
 mkx90QPzzpNthDuhpiS8NdnLlTK0o30bixz5amMjgPt4qEDIRQEig4/yf7efr4S4PR0/
 4hy3DBjCOvH/eXm71sAlE81OSSHmqLJJZeMTv7J6s6yGFLjBpuxZp4SeGSv1YGWEAY/n
 6b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731987; x=1788336787;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
 b=PVAVj/I13Z+lsXU6a7icDglG0ruFyz0Q+C/ilG/rQEdCy4ley6wAeY+zeIldiLoZbg
 Ya8FUZs2g9xNZg1vENkgiqfB5qHHEg8ujcqmjtuYBP1lJjhXL1LlgYX/inhexRqMc7Xi
 CavbID73srP4T4uM63n+/GTvv7boCgZYZwpqc+QzNzZ9WnkVK1/fv9pUZA21UkwOVtNN
 ELgj3oXqVVQgFTn89f7bE+uMDZXlL7ekxiyoFv3myKeDoGyuNOuD+0Sh3r+CvMdPDfn0
 UTWGND2mUnY8SypDSIJ7GCUjH/x2rTYbv3FNoxZ5TUhFcPFFiD6XmeNT3RWyYt8z19QD
 4sNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOhk2D2SGNBP3ufnkCXI6w1gRpWO/Lp0YD+PZNCV1GkIpKSR6bBX+cNFYFA2AuBiKmNWx2J0sJIMg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kdzITdcAjIQ2zJAERzTGB1SmLxff568mpKo6/c1b16eirhTg0h
 oshmiDMTHTMzrxWrJi/kJaQoWoMVr2jkh4DWVgE5LdYUebxOxhbpttZsmnOVPhii5OOWAysD8eW
 KjZzParJqwiQOE228eCXEtHla3SLy8Bv/dmow6sz08g==
X-Gm-Gg: AR+sD11hIbOdx+6OtMnARduAIaMwORAKCD1eVXbtzgOMjNbHhWE6Zi7ud3rtpiCQZ9a
 vne/KY+6SMH9sXTmuQWZ6izWpJfOG8V0ZbdGkHhCraCFyjzR+ipAJ6PCeEhPm1z0WOLK/Hf0Li/
 MsLaZr1jjWtkL7F6Rgb5vxGGu20ebUstBn9UsJut/zX8HbkApJF5rYK3iHn3WIHycRDy4vfvgHp
 Oav64a5QwnjkO5GvVkDsKjYJD51/ah82HgIVvwR+XMQ7F/Nyjz9eKTlaposZ3QtrTcbaW9z3P6k
 wkl3UgAeG9TfhI6ZuhChrY5DusEr2mCROcxZBqy/abnUL5YM
X-Received: by 2002:a53:c643:0:b0:66c:486c:aa07 with SMTP id
 956f58d0204a3-66d257632b5mr1226829d50.35.1787731987131; Wed, 26 Aug 2026
 01:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260808142217.2893936-1-lgs201920130244@gmail.com>
 <400c3d0a-97ca-4c76-909c-0c09d534cd41@kernel.org>
In-Reply-To: <400c3d0a-97ca-4c76-909c-0c09d534cd41@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:12:55 +0800
X-Gm-Features: AcwNN1WiakOYjCu3-MZaTlXfcEIIF1SEVa43x_3CROHSyWNzCBcShiqF2n9BY7s
Message-ID: <CANUHTR_Sr49S5JwGE_wzTFed6weW_8MMo8o+20vf=bZE3Xhc-w@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: gr3d: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
> On 08/08/2026 16:22, Guangshuo Li wrote:
> > gr3d_probe() calls pm_runtime_use_autosuspend(), but gr3d_remove()
> > does not call the matching pm_runtime_dont_use_autosuspend() during
> > teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> > remove path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
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
