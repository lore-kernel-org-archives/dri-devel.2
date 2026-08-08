Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6BC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 21:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514DB10E06A;
	Sat,  8 Aug 2026 21:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LGFOJ2L0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A946010E06A
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 21:29:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E34440203;
 Sat,  8 Aug 2026 21:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB16D1F000E9;
 Sat,  8 Aug 2026 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786224557;
 bh=FT0NdAVLXilXDM5+gq7ch2NGBLpD9jxfu6G+9tHWN7o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LGFOJ2L0Yhk2nUH4yy9+fCLhYYXpdChqoV2TgHmiiAGRp5cnwN49kOQGl8EBMXeqY
 0RKohj/slVNohrAYtjd+EZxVctCPV69yCjk5KHf9FBZpeGu9BdBdSveRuZLxSa6RXT
 wISYBSNIdaThHlcAS1DLn8RVr8aofjVeCTo9oltGwBkOvY5ACx4ICpsUpgeNv4m1Ze
 NdtsjZhzGPGAKCmnz5ZPbEJfzaiU29qvu/c33bLo6IbCAyVgJAaa3edE8TXd7iTGhU
 eLjSxXPivS07wKdjX9k2px23Rd2fvYdtU8jc7sGtALCavUR/wGiOThZ8dwt+62RkIy
 0jZsvZhwvUkOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/amdgpu/aca: Fix inverted validation logic in
 amdgpu_aca_get_error_data
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808210852.2938-4-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
 <20260808210852.2938-4-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 21:29:15 +0000
Message-Id: <20260808212916.EB16D1F000E9@smtp.kernel.org>
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
- [High] `aca_handle_is_valid()` incorrectly evaluates removed handles as v=
alid, leading to a Use-After-Free and `mutex_lock` on a destroyed mutex dur=
ing device teardown.
--

--- Patch [3]: [PATCH 3/5] drm/amdgpu/aca: Fix inverted validation logic in=
 amdgpu_aca_get_error_data ---
commit c1268f69334da0d7e73d9ad9988d74c06033118e
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/aca: Fix inverted validation logic in amdgpu_aca_get_error_data

This commit updates aca_handle_is_valid() to verify handles have non-empty
list nodes, and negates the check in amdgpu_aca_get_error_data() to process
valid handles properly.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index c76664af9902e..1cddacb7c554c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device=
 *adev, struct aca_handle *h
> =20
>  static bool aca_handle_is_valid(struct aca_handle *handle)
>  {
> -	if (!handle->mask || !list_empty(&handle->node))
> -		return false;
> -
> -	return true;
> +	return handle && handle->mask && !list_empty(&handle->node);

[Severity: High]
Does this change cause removed handles to be evaluated as valid?

When amdgpu_aca_fini() removes handles, it uses list_del() rather than
list_del_init():

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:remove_aca_handle() {
    ...
    list_del(&handle->node);
    ...
}

Because list_del() poisons the list node, list_empty(&handle->node) will
evaluate to false. With this patch, !list_empty(&handle->node) now evaluates
to true, causing aca_handle_is_valid() to return true for a removed handle.
The original code correctly returned false for poisoned nodes.

During device teardown or module unload, if the delayed work
amdgpu_ras_counte_dw() executes concurrently, it calls
amdgpu_aca_get_error_data(). Since the removed handle is now incorrectly
deemed valid, the code would proceed into __aca_get_error_data() and attempt
to call mutex_lock(&aerr->lock) on an already destroyed mutex, potentially
causing a use-after-free or kernel panic.

Should remove_aca_handle() use list_del_init() so that list_empty() can
safely identify removed handles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808210852.2938=
-1-sreekuttan2156239@gmail.com?part=3D3
