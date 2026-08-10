Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A616C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D2C10E805;
	Mon, 10 Aug 2026 12:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JfFIodrL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C48910E830
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 12:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7D38403DC;
 Mon, 10 Aug 2026 12:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6D81F000E9;
 Mon, 10 Aug 2026 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786366346;
 bh=gFsGTycHNnJpZy32dmR3ubByfaxO+WQnrIDISFQiFH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JfFIodrLWfk6Gm2ge7ovXe6WEH56UGO+MVyNi0MWnDkqU91hI0RR67UEUUX9ZZBqk
 YphoworCN4joJrfcpUtJGcvDvYiZGCx4Ozs8ywz6NfpMWTDbexjJM6Sy2V06COatUN
 lYYmpTf/jaFVL4JNQ5MciUr74HgBAjsiuxNiG7KIQgqVr1kbpL5Lh3AidQS0JYFZ1E
 A+aFjKhZWp+T237YnXg7X+rDmwwdrbMrjPfATOLEzRDlsDta0XB9ZKja0R0F5KdRvo
 s5vU4EqU4Hl+jZEQtc/h5qUgtRwgdEzdsd8L9hA1Q3zdZjco8yFZdGWO+dDP53gork
 oklVb3kQb2OuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/amdgpu: remove useless enable/disable of ttm
 buffer funcs
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
References: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
 <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:52:25 +0000
Message-Id: <20260810125226.4F6D81F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `amdgpu_ttm_disable_buffer_funcs` during system suspend l=
eaves hardware-accelerated memory moves enabled, causing TTM to submit SDMA=
 jobs while the SDMA hardware is suspended or fence interrupts are disabled.
--

--- Patch [3]: [PATCH v3 3/3] drm/amdgpu: remove useless enable/disable of =
ttm buffer funcs ---
commit fbef8cb928db8ff229937f5e75fbde6b525226c0
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: remove useless enable/disable of ttm buffer funcs

This commit removes calls to amdgpu_ttm_disable_buffer_funcs and
amdgpu_ttm_enable_buffer_funcs, indicating they are redundant outside of
device startup and teardown.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1ec3162cb1750..e966e6f7d2fa6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3379,8 +3379,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_de=
vice *adev)
> =20
>  	r =3D amdgpu_device_ip_resume_phase2(adev);
> =20
> -	amdgpu_ttm_enable_buffer_funcs(adev);
> -
>  	if (r)
>  		return r;

[Severity: High]
Does removing this call in amdgpu_device_ip_resume() cause BO moves trigger=
ed
in earlier phases to hang? If enablement is not explicitly delayed to this
safe point, TTM might attempt to use SDMA before it is fully ready, such as
during SR-IOV late reinit where DCE resumes before SDMA.

[ ... ]

> @@ -4511,8 +4509,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>  	if (r)
>  		goto unwind_userq;
> =20
> -	amdgpu_ttm_disable_buffer_funcs(adev);
> -
>  	amdgpu_fence_driver_hw_fini(adev);

[Severity: High]
Does removing amdgpu_ttm_disable_buffer_funcs() in amdgpu_device_suspend()
leave hardware-accelerated memory moves enabled while the hardware is being
suspended?=20

During system suspend, resume, or GPU reset, BO memory moves can still occu=
r.
If TTM buffer functions are not disabled, TTM might submit BO moves to the
SDMA hardware while it is suspended, or while fence interrupts are disabled
by the subsequent call to amdgpu_fence_driver_hw_fini(). Could this lead to
deadlocks from fence timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810120218.2300=
0-1-pierre-eric.pelloux-prayer@amd.com?part=3D3
