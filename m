Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50876C88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948BF10ED18;
	Wed, 16 Sep 2026 18:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ggRCgkYV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D60210ED0B;
 Wed, 16 Sep 2026 18:04:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27687405E8;
 Wed, 16 Sep 2026 18:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86C91F000FF;
 Wed, 16 Sep 2026 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789581847;
 bh=OkD2ZKM+WX8G8x36sG/PNn8k0bq4DArJkN9flkkkpLk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ggRCgkYVseEIKyWYT4PCzoYDqx7DmWZAwsZTnKsZh/yENcN05oj4WH4nfLzPXqN4D
 gy+JLQJldfSUH2+g0WVULTAddQOn2JFr74pjyzrx3s+yX4jFtuX6zAZk4fd+k1g+/K
 uFYDt/CnOjLYP+uo/YS7jrk1F99NnI59n3w1ucaBhIHSqu1nIbqnL0hWPL+XPl3rDf
 rS/KLcSBEyHDlvKSNz1Vj34D0grXNPnWvH8z+j17+onpdhxaQZIY8FAju75VGhkGL7
 KHgHDfCStLesUF72mkYaOAk/BXjm2M+R/+lDCNJJ6dHtEeBvkmkEpLenM2q0HsRngc
 pH5jkNtI/5eVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Fix mm reference leak in
 handle_g2v_notification()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260916173720.2088455-1-vulab@iscas.ac.cn>
References: <20260916173720.2088455-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:04:06 +0000
Message-Id: <20260916180406.D86C91F000FF@smtp.kernel.org>
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
- [Critical] drm/i915/gvt: UAF and Double Free in PPGTT mm object lifecycle
--

commit 01f0e076eca16f11c93a812eb503401ad6e94137
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/i915/gvt: Fix mm reference leak in handle_g2v_notification()

This commit changes the PPGTT page table create path to avoid taking an ext=
ra
reference for an already registered mm. It uses intel_vgpu_find_ppgtt_mm() =
to
check if the mm exists and skips creation if it is already tracked.

> diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/g=
vt/handlers.c
> index 22dd0179863ee..6b967da3a8836 100644
> --- a/drivers/gpu/drm/i915/gvt/handlers.c
> +++ b/drivers/gpu/drm/i915/gvt/handlers.c
> @@ -1505,7 +1505,17 @@ static int handle_g2v_notification(struct intel_vg=
pu *vgpu, int notification)
>  		root_entry_type =3D GTT_TYPE_PPGTT_ROOT_L3_ENTRY;
>  		fallthrough;
>  	case VGT_G2V_PPGTT_L4_PAGE_TABLE_CREATE:
> -		mm =3D intel_vgpu_get_ppgtt_mm(vgpu, root_entry_type, pdps);
> +		/*
> +		 * A newly created mm keeps its initial reference as the
> +		 * registration reference, dropped by the DESTROY
> +		 * notification. A duplicate CREATE for an already tracked
> +		 * mm must not take an extra reference that nothing drops.
> +		 */
> +		mm =3D intel_vgpu_find_ppgtt_mm(vgpu, pdps);
> +		if (mm)
> +			return 0;

[Severity: Critical]
Can this logic lead to a use-after-free and double free if a guest issues a
duplicate CREATE after a DESTROY while a workload is still active?

If a guest VM performs the following sequence:
1. Issues a CREATE notification (refcount=3D1).
2. Submits Workload A using the page table (refcount=3D2).
3. Issues a DESTROY notification (refcount drops to 1, object remains due to
   Workload A).
4. Issues another CREATE for the same page table.

Here, intel_vgpu_find_ppgtt_mm() finds the object and returns 0, but no
registration reference is taken, leaving the refcount at 1.

If the guest then submits Workload B (refcount=3D2), and Workload A finishes
(refcount=3D1), a subsequent DESTROY from the guest will drop the refcount =
to 0:

drivers/gpu/drm/i915/gvt/gtt.c:intel_vgpu_put_ppgtt_mm() {
    ...
    intel_vgpu_mm_put(mm);
    ...
}

This frees the object while Workload B is still active.

Once Workload B finishes, the cleanup path accesses the prematurely freed
shadow_mm and attempts to drop its reference again:

drivers/gpu/drm/i915/gvt/scheduler.c:intel_vgpu_destroy_workload() {
    ...
    if (workload->shadow_mm)
        intel_vgpu_mm_put(workload->shadow_mm);
    ...
}

Does this new condition need to take a registration reference when the mm is
found, to prevent it from being freed prematurely?

> +
> +		mm =3D intel_vgpu_create_ppgtt_mm(vgpu, root_entry_type, pdps);
>  		return PTR_ERR_OR_ZERO(mm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916173720.2088=
455-1-vulab@iscas.ac.cn?part=3D1
