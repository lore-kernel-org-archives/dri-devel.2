Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3980DC5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 22:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B27410E041;
	Sat,  8 Aug 2026 22:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bf/OZQrW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1351D10E041
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 22:50:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F04543E6B;
 Sat,  8 Aug 2026 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFB31F000E9;
 Sat,  8 Aug 2026 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786229416;
 bh=6RbjhORfSbWb1r2z4FW2AGTSPopS5k7jGXyulzLvEgk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bf/OZQrWpwHdcrmX1Yi1LQf/2utOKRvJji3mK0z7GmRLE5tqy4gtVSHwe+SJypvS7
 TS7hXQPxgZjFDWs4xlS4JQVJBqfRt/OfpC+iMIR57EGScFJgbBF5/kCs9gfB8eTlVS
 b41DDIwVOCtbDm9M1ZquIYG7ZRAITVyDys/Nr7VWbrPPo+JjWvqYLHWMbI5wxmjn4G
 kCf20FuoqYMp5sIUWXTwEUnFW1rqJ1MheOtLnhy9pay2WCsl4H3YKzusm4FTDghsVG
 X1pUW75cLh+DRvVdJstLCTT91QV0jcR76sgBR9YlOm8umGJbV6qlZFBpn1J8j+66Ur
 fXsDTXqkzwtew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/amdgpu/aca: Fix inverted validation logic
 and handle cleanup
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808222742.2859-4-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
 <20260808222742.2859-4-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 22:50:15 +0000
Message-Id: <20260808225016.4FFB31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The logic change in `amdgpu_aca_get_error_data()` causes global RA=
S error count queries to fail with `-EOPNOTSUPP` for non-ACA blocks.

Pre-existing issues:
- [High] Delayed work `ras_counte_delay_work` is cancelled after ACA subsys=
tems are torn down, leading to a TOCTOU race condition and use-after-destro=
y of a mutex.
--

--- Patch [3]: [PATCH v2 3/5] drm/amdgpu/aca: Fix inverted validation logic=
 and handle cleanup ---
commit e884a156d93ba3896781b055b3f77054754fcf85
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/aca: Fix inverted validation logic and handle cleanup

This commit fixes the validation logic in aca_handle_is_valid() and its
caller amdgpu_aca_get_error_data() to properly process valid handles. It
also changes remove_aca_handle() to use list_del_init() to prevent a
potential use-after-free during device teardown.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index c76664af9902e..b4c1438a56d8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
[ ... ]
> @@ -599,7 +596,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *han
>  	if (!handle || !err_data)
>  		return -EINVAL;
> =20
> -	if (aca_handle_is_valid(handle))
> +	if (!aca_handle_is_valid(handle))
>  		return -EOPNOTSUPP;
[Severity: High]
Does this logic change cause global RAS error count queries to fail for
non-ACA blocks?

Before this patch, zero-initialized handles (where handle->mask is 0) would
cause aca_handle_is_valid() to return false. Since the check here wasn't
negated, the code would bypass the -EOPNOTSUPP return and fall through to:

    if ((type < 0) || (!(BIT(type) & handle->mask)))
        return  0;

which gracefully returned 0.

With the new negated check, zero-initialized handles for non-ACA blocks (li=
ke
HDP) evaluate as invalid and immediately return -EOPNOTSUPP.

Could this overwrite the return value in the loop within
amdgpu_ras_query_error_count() when iterating over RAS blocks?

amdgpu_ras.c:amdgpu_ras_query_error_count() {
    ...
    list_for_each_entry(obj, &con->head, node) {
        ...
        ret =3D amdgpu_ras_query_error_count_helper(adev, &ce, &ue, &info);
    }
}

If a non-ACA block is queried at the end of the loop, this -EOPNOTSUPP could
propagate up, completely breaking global RAS telemetry and preventing cached
counters from updating.

> =20
>  	if ((type < 0) || (!(BIT(type) & handle->mask)))
>  		return  0;
[ ... ]
> @@ -717,7 +714,7 @@ static void remove_aca_handle(struct aca_handle *hand=
le)
>  	struct aca_handle_manager *mgr =3D handle->mgr;
> =20
>  	aca_fini_error_cache(handle);
> -	list_del(&handle->node);
> +	list_del_init(&handle->node);
[Severity: High]
This is a pre-existing issue, but does this still leave a time-of-check to
time-of-use race condition during device teardown?

Looking at amdgpu_ras_fini(), the delayed work is cancelled after the ACA
subsystems are torn down:

amdgpu_ras.c:amdgpu_ras_fini() {
    ...
    amdgpu_aca_fini();
    ...
    cancel_delayed_work_sync(&con->ras_counte_delay_work);
}

If the delayed work runs concurrently, could it perform the lockless
!list_empty(&handle->node) check in aca_handle_is_valid() and evaluate to
true just before this teardown thread calls remove_aca_handle()?

If remove_aca_handle() then unlinks the node and destroys the handle's mute=
x,
the worker thread might proceed into __aca_get_error_data() and attempt to
lock a destroyed mutex.

>  	mgr->nr_handles--;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808222742.2859=
-1-sreekuttan2156239@gmail.com?part=3D3
