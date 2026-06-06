Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD2DCD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 10:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDB910E312;
	Sat,  6 Jun 2026 10:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AKaOAWPv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1FF10E312
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 10:51:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 379AE601DC;
 Sat,  6 Jun 2026 10:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F31F00893;
 Sat,  6 Jun 2026 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780743082;
 bh=5TiXU1WwQ3JA8cb7sM3j9papb0cJYn/wDGIJnzEMlKs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AKaOAWPvktGVrgKQZlPnJSlRMBGX7aTaF7asSghyUrZmL/f0vZW6dKHQnXBYIcts4
 Bx5uYmexidub5vKZuTaETKGRjjnoOJQu7XU2qq+jl7Kp9ob48Wz2vLp+tZ1Sgf50T2
 QZG96U3ChuLAF5iUl5x6BfmbeplM4XcxXzr+weaiDvPmuwr5Amf4lvOh8ohTK721gx
 EsXhhXYk5WTT7mq8ZGsW03BHOfdrQa5N3k4v4m6WM7pBeW5kTF3iAV05jIKE8f7rNt
 fnc1zW66VZVbRPgzULKUijahVK6sbEkBS0wJRB1JlDwd8f8ejXY9RIYZ1TNJN/ATPm
 C9hYzBqteXFxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gvt: fix refcount leak in
 intel_vgpu_shadow_mm_pin()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606103519.57715-1-vulab@iscas.ac.cn>
References: <20260606103519.57715-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 10:51:21 +0000
Message-Id: <20260606105122.C05F31F00893@smtp.kernel.org>
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
- [High] Double-unpin of shared shadow PPGTT memory due to conflict between=
 explicit error handling and unconditional cleanup.
--

commit 4d9fa23878c7d84ea81831549d03a73dfab721d4
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/i915/gvt: fix refcount leak in intel_vgpu_shadow_mm_pin()

This commit adds an explicit unpin call to the error path of
intel_vgpu_shadow_mm_pin() when intel_vgpu_pin_mm() fails. The goal is to
balance the pincount increment that unconditionally happens at the start
of intel_vgpu_pin_mm().

> diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/=
gvt/scheduler.c
> index 15fdd514ca836..30d879b37c84d 100644
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@ -698,6 +698,7 @@ intel_vgpu_shadow_mm_pin(struct intel_vgpu_workload *=
workload)
> =20
>  	ret =3D intel_vgpu_pin_mm(workload->shadow_mm);
>  	if (ret) {
> +		intel_vgpu_unpin_mm(workload->shadow_mm);

[Severity: High]
Does this explicit unpin introduce a double-unpin of the shadow mm?

Looking at the workload dispatch loop in workload_thread(), if
intel_vgpu_shadow_mm_pin() returns an error, the thread jumps to the
completion path:

workload_thread()
    ...
    ret =3D prepare_workload(workload);
    if (ret)
        goto complete;
    ...
complete:
    complete_current_workload(gvt, engine->id);

The cleanup path then unconditionally unpins the shadow mm:

complete_current_workload()
    ...
    intel_vgpu_shadow_mm_unpin(workload);

Before this patch, a failure in intel_vgpu_pin_mm() incremented the
pincount, and the unconditional cleanup in complete_current_workload()
decremented it, maintaining balance.=20

By adding this explicit unpin in the error path, could the pincount
decrement twice and underflow?

Since shadow page tables are shared among workloads for the same vGPU,
would an underflow allow the GVT shrinker to prematurely destroy active
shadow page tables while another workload is still executing, potentially
causing GPU page faults or VM crashes?

>  		gvt_vgpu_err("fail to vgpu pin mm\n");
>  		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606103519.5771=
5-1-vulab@iscas.ac.cn?part=3D1
