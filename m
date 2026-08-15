Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC14C5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 18:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEE610E231;
	Sat, 15 Aug 2026 18:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tq2aoOnU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AB510E231
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 18:37:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89BD6600B1;
 Sat, 15 Aug 2026 18:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F7F1F000E9;
 Sat, 15 Aug 2026 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786819069;
 bh=5YbeIeq7XR7E8m+t8xCNVcaTjOMqXD6LTBKYc361DvA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tq2aoOnUjWglKtGQcMrFoQ5Yu7D747x8MOMZTQwvNP93X5EyFbC1rZ1OAE9gLKHNI
 DQzcu/xVMszgpBRwK5pgDD2Ck+dpY7UjUhsnDRxKpP2cfmr5oS1EuLw6O8Bt+l+EbD
 H+qHGbRI7BUAN/jwvP2FAyQnSwmoQGUmtgd/WylMoZrYhgSmD5nT9+lxUE7IVibbwh
 0P6fxyt1LJQuMXjoFLbQeFNpCWwQUpBf0cpZ8ol60VVsF2JgRq2wR3VJHS74nhfC4e
 6clhOXXAhGYz3az0du6ypQICHahISDldpCVebwY0E38H9l9+nhscDg92EpANK9yFIu
 b9is5uUltEP+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/amdgpu: Remove is_idle (non trivial functions)
To: linux@treblig.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260815180033.8958-4-linux@treblig.org>
References: <20260815180033.8958-1-linux@treblig.org>
 <20260815180033.8958-4-linux@treblig.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 18:37:48 +0000
Message-Id: <20260815183749.21F7F1F000E9@smtp.kernel.org>
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
- [Low] Incomplete API cleanup: The `is_idle` function pointer remains defi=
ned in `struct amd_ip_funcs`.
--

--- Patch [3]: [PATCH 3/4] drm/amdgpu: Remove is_idle (non trivial function=
s) ---
commit cf17e80a1ef9c0d7e6925465357af056c949e840
Author: Dr. David Alan Gilbert <linux@treblig.org>

drm/amdgpu: Remove is_idle (non trivial functions)

This commit removes the various is_idle implementations across the amdgpu
driver since the method is never called. The same logic is mostly duplicated
in the wait_for_idle method which remains in use.

> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/am=
dgpu/cik_ih.c
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
[ ... ]
> @@ -435,7 +424,6 @@ static const struct amd_ip_funcs cik_ih_ip_funcs =3D {
>  	.hw_fini =3D cik_ih_hw_fini,
>  	.suspend =3D cik_ih_suspend,
>  	.resume =3D cik_ih_resume,
> -	.is_idle =3D cik_ih_is_idle,
>  	.wait_for_idle =3D cik_ih_wait_for_idle,

[Severity: Low]
Since we are removing the .is_idle assignments across the tree, is it also
worth removing the is_idle function pointer from the struct amd_ip_funcs
definition in drivers/gpu/drm/amd/include/amd_shared.h to complete the
API cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815180033.8958=
-1-linux@treblig.org?part=3D3
