Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21976F54AA0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7729810E6AB;
	Tue, 24 Mar 2026 13:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShoTM7G4";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F4C10E6A8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:19:30 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12a70b4de9bso246242c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358369; cv=none;
 d=google.com; s=arc-20240605;
 b=Yn12bBQ2C7B7xL0L3c+MCG0s9nx/OfWVmdoK0nhuLB4wgfZhoWLBKn0VlOuamw3eFv
 iGzroD7hr8WzSrLOmc/FZ8DJGb7V/n4O6FqZJsT5LIXgGLa7nZ9QKv8vXWdBbsdMG6iL
 HE68WrEJrvR1frluF1GOuh6Od85RORU+h16/sb/hRTWfFgJvKZiDBmbilRs4Trx9FMqb
 tEgGMGE54j/5Bme4EatAoXxaFJF1sxTqOXTIZJ3W/SIKxPmX5H5vwIDlyHPmd6atKEI6
 GpcFHHG2Q6Sy9vGJIOdCN40Ld3ctTCHp97Bg8MR6K/zRNcsBXeSi4GG3WZ5RWaWsVNap
 qcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BsRLgUtA5JSsXZ4xXw8vk1eoQqR+UCw1mR7ln0dyj1E=;
 fh=t13M0fC6mPDIueafjCVK8JG5F1SdBz3we8DYFJ6CoeQ=;
 b=CcG1MF4sh664DFPXxulOqKJSGbg87XOtYZmyhC/dMlKrI8kAQ5BobxX9A3GKDfLX2P
 rgUyxKJK7CxFbEm2dsQNSN0MOd31D+kqvCvw/biDjqcuU03CnK3NlC2dWpzMcz0aISum
 Q2692/+K7jrWRGlTiISDJlxm0eYFf5NT8fD2fKsutFf65totc+5tDM+9NLwZZGo/gVdq
 S9ryLI4Wey82VeqzraKLZgQxealeqmxQdhNvh79RTh4E6j5gB+zVwOtGCxILOTeZUzK8
 lWTbUhRhl4WmaxkQ52zhB49049xDd2vxbIAnpnsib1Rh7WtjpWEYOTeFsS+rn3Sb8Tbm
 WRtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358369; x=1774963169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsRLgUtA5JSsXZ4xXw8vk1eoQqR+UCw1mR7ln0dyj1E=;
 b=ShoTM7G40GOcdeRA93SYQ+pyvrjJd8Aavyl5JNHa1v+8h9F7EtVhR9zdGQ2wrZB7JE
 YwNupUct3+AJYa8dDZNLgTAMR3XFFf2XCoUH5pt0DVct1/h+tKFbOhXAzvowSClOfxb7
 6wTAp4ebKs/4sdPo4dUUlUNcwyD30EPqD8MEN4rnATZhf6G0fYbnhO06gszTDSvxy/QK
 jspjBb4VKO2nbFcJnVXrk4LCULJUY9lWTedTnGzvuLSg3n7BEkrAp0bCyW0p8kl2T7kq
 z3b4mKULjq+3yPaERJNv7raOOXY7HgmeTBKYtFYPUFiqlV0LYrUh6zISvEqFrikSRbxt
 TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358369; x=1774963169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BsRLgUtA5JSsXZ4xXw8vk1eoQqR+UCw1mR7ln0dyj1E=;
 b=NMOHi9S8h8M2U/G3tkqCvLN3M32xqtgEILpLIFEJC3hqVBLWCKhdnEvUhb/e3CSLGC
 lETlDePHoPVrZ5Reln4cmzlCmbijJLbSj/22q0UW+3uCp4EHwT8DkZJoUD7uwzi/kytf
 rFUfmWMrOitDD+SWrWvORl0xMX+YtKQjZERZ5yUW64mS5U9B6yXUH624ZK8XQh12hDic
 vb4XOVIl69obG9fKVMWjLoY7GJ9haDRsvtUZt9vrqnLRcBg8mgAyR5LtXcQ7QsLTx8LH
 TA+0TJ7tERvE5k3KHp9QknbJMo+At/oZTXYXKP1h/XZAS/2dAh/A/Y0rGDUlT3nJukKa
 xyPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/+5RZFa+7SRgze+l4fJqY8m+fPZCIZvRicgmMlE+lpjGP8V29xWjGX3wV1j5uYLA92kETldW3uXg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0P1xsicexBc4P4DP3Xjc1MPDU2lea4EGluu597Cqa35TV0a3S
 IlQKpWOqzGBsP9aRjJtda6KMkvgHvqNNObjvBkHwj7z2tQ3n9lwZqhDw7V+Qk5Q2PNXWpjRdx9i
 8j9xIilL3aSFIcahJtt1gk0dMVifW1K4=
X-Gm-Gg: ATEYQzyhx90IyEAgLEyPzXdmAUWdRwM+iVgo+ed8TRsUOEZav3BQU3AqWlD/VEC53x4
 6a/bVgVG5ac6tsumaJBzYDVrRgBXyf1N30T8PxFvEe83x+QrbqM6bpb5D52k9IgkPCGLquOLRe/
 zOA2RGIrNcfMxy1xIpDh0u3i9KfPgDbN6tKcq0zB2m7nPAy3tHEUdt+Oo+Nnu0UHJx7zRAwFWsT
 7sXli6z99FkdW0UofqHG6chlNEl2HxjYEzyUfNiKQp1m8zYZ0R8KoBxNUSU5D9jJXG4Ql5ggAKj
 2PrqlOKJK4y0uBRPHY2uxhazRjoxM60opoWqm5sFek7/QXszA1dGwFTUZSTT9iN3h76peQ==
X-Received: by 2002:a05:7022:f8d:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-12a726a9b6amr3506204c88.3.1774358369493; Tue, 24 Mar 2026
 06:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260321105728.6304-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105728.6304-1-kexinsun@smail.nju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:19:17 -0400
X-Gm-Features: AaiRm526BG_rM9muwvFrczqMS3-tFt9tDF8XTVojFBAC5700mXENfyNJwBxRyIg
Message-ID: <CADnq5_PO_Ns7=48ZOKa+08gwO038BzJm8K_KqE1Zz7XTa+M5uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update outdated comment for renamed
 amdgpu_fence_driver_init()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, timur.kristof@gmail.com, tglx@kernel.org, mingo@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr, 
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
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

Applied.  thanks!

On Sat, Mar 21, 2026 at 7:44=E2=80=AFAM Kexin Sun <kexinsun@smail.nju.edu.c=
n> wrote:
>
> The function amdgpu_fence_driver_init() was renamed to
> amdgpu_fence_driver_sw_init() by commit 067f44c8b459
> ("drm/amdgpu: avoid over-handle of fence driver fini in s3
> test (v2)").  Update the stale reference in the
> amdgpu_fence_driver_init_ring() kdoc.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 1054d66c54fa..37534f66c755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -458,7 +458,7 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring=
 *ring,
>   * @ring: ring to init the fence driver on
>   *
>   * Init the fence driver for the requested ring (all asics).
> - * Helper function for amdgpu_fence_driver_init().
> + * Helper function for amdgpu_fence_driver_sw_init().
>   */
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
>  {
> --
> 2.25.1
>
