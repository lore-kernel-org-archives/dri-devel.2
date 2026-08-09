Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D418C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 15:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1C210E11F;
	Sun,  9 Aug 2026 15:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ILalhED9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF0010E11F
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 15:05:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D2E060008;
 Sun,  9 Aug 2026 15:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7689D1F000E9;
 Sun,  9 Aug 2026 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786287928;
 bh=XuuhrURlO5OC0JB5ok3gEw3UoiEiZJExHQ1dQz2C11c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ILalhED9CDQ4Q8EbQyz0UsXIUSBTFKFJPtbwXY7H1tO0UtS1FvV2Rn7e7FZIE65Ct
 4kdNXGSB/sZ/YkmFRjEVd9GQPPOqvbHBdwi7hBfPFMcFR/tkDgviZJA29u1v2l6Uk/
 gRULdfAUnse/4slGHs/894KjmgZ33LDpSNLNAJcyCslBUnUN09UfU0PQ4ymzrZO4PB
 8QHVGu9twdxzO//d97csKF0VmU44lv1aoM8JhSEHlvDtj/7iNKa0iyJJIYkrF4KRiY
 ZuEL3PfqEcOwZHE8Sk3zuOmZCxNPLkTIudln1FOvTor9db5ZVH9j4W03g24i75b6Vh
 QZpMQSXOaBMIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] drm/amdgpu/aca: Fix inverted validation logic
 and list cleanup
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809144451.35431-4-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
 <20260809144451.35431-4-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:05:27 +0000
Message-Id: <20260809150528.7689D1F000E9@smtp.kernel.org>
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
- [High] Concurrent execution of lockless list traversal and `remove_aca_ha=
ndle` leads to TOCTOU use-after-free or hard infinite loops due to `list_de=
l_init()`.
--

--- Patch [3]: [PATCH v5 3/4] drm/amdgpu/aca: Fix inverted validation logic=
 and list cleanup ---
commit 2db17afc321c2a877e8d6ebfef5f2cce5ce3142f
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/aca: Fix inverted validation logic and list cleanup

This commit fixes aca_handle_is_valid() to properly check for valid handles=
=20
rather than empty nodes. It also changes remove_aca_handle() to use=20
list_del_init() before destroying the error cache, ensuring the handle is=20
recognized as unregistered before its resources are freed.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index c76664af9902e..d48f2c4d6c845 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
[ ... ]
> @@ -599,8 +596,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *han
>  	if (!handle || !err_data)
>  		return -EINVAL;
> =20
> -	if (aca_handle_is_valid(handle))
> -		return -EOPNOTSUPP;
> +	if (!aca_handle_is_valid(handle))
> +		return 0;

[Severity: High]
Does this lockless validity check introduce a time-of-check to time-of-use
(TOCTOU) race window?

During driver teardown, amdgpu_ras_fini() calls amdgpu_aca_fini() (which=20
eventually destroys handles and their mutexes) before it cancels=20
ras_counte_delay_work.

If the worker calls this function concurrently, it could pass this lockless=
=20
validity check right before remove_aca_handle() destroys the error cache and
its lock. This would result in a use-after-free or an attempt to lock a=20
destroyed mutex when the worker attempts to use the handle in=20
aca_log_aca_error().

>  	if ((type < 0) || (!(BIT(type) & handle->mask)))
>  		return  0;
[ ... ]
> @@ -716,9 +713,10 @@ static void remove_aca_handle(struct aca_handle *han=
dle)
>  {
>  	struct aca_handle_manager *mgr =3D handle->mgr;
> =20
> -	aca_fini_error_cache(handle);
> -	list_del(&handle->node);
> +	list_del_init(&handle->node);
>  	mgr->nr_handles--;
> +	aca_fini_error_cache(handle);
> +
>  }

[Severity: High]
Could the use of list_del_init() here cause an infinite loop for concurrent=
=20
list iterators?

When list_del_init() removes the node, it reinitializes the node by pointin=
g=20
its next and prev pointers to itself.=20

There are functions like aca_dispatch_bank() that iterate over mgr->list=20
locklessly. If a concurrent iterator is on this node exactly when it is=20
removed, following the self-referential next pointer will cause the iterato=
r=20
to loop on this node infinitely, leading to an RCU stall or hard lockup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809144451.3543=
1-1-sreekuttan2156239@gmail.com?part=3D3
