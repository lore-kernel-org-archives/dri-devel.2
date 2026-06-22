Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863B0CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231310E3FE;
	Mon, 22 Jun 2026 14:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ouI/zcY0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49DB10E3FE
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 14:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7F6F601F3;
 Mon, 22 Jun 2026 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736ED1F000E9;
 Mon, 22 Jun 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782138907;
 bh=7bkYaGeva5lqC0Wew15C66ZehNdtCbQyZ8DSRyoXFQk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ouI/zcY0V0xqUBJRUN+hqpfS/Gac1A/oYf3G6A9glE8mpdjkVjrdz8FFJq9eUIKtj
 S5BuX6PO8+o9LeQAuwwpitIOaY1q4us5GiSwcQZ17ARYVKyrcp5l8If4g9tR6ICSQ1
 dFB5TNqQphHt6PC9Fo6XDl2PQyawiiTE8wgVUaJTDYyGoc+Sswx299rZ5x62pprUdl
 4xN6Ib0G48ITr9g13lHnfKbNxfC5nNMRDhufdjKljDyvwrn9gtkJ+2YA3A9ukTLM1F
 BSkGXngqfoug3PUBUBT6gO+sUp5IToiM676D86/kEXNHpyq10F+aVEI+SnDNW61mnh
 7HLgmMLrPiIjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: fix cleaner shader IB size and entity
 cleanup
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622142305.45791-1-vulab@iscas.ac.cn>
References: <20260622142305.45791-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:35:06 +0000
Message-Id: <20260622143507.736ED1F000E9@smtp.kernel.org>
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
- [Low] The patch leaves an unused assignment to `r` after removing the err=
or check for `dma_fence_wait`, resulting in a dead store.
--

commit 24bfae44dd9f0251a61d22e1439ca564bf70d1a3
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/amdgpu: fix cleaner shader IB size and entity cleanup

This commit dynamically calculates the indirect buffer size based on
align_mask to prevent memory corruption. It also ensures the scheduler
entity is properly destroyed on error paths and removes an unneeded error
check after waiting on the fence.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b8ca876694ff8..2da917e18d93b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c

[ ... ]

> @@ -1686,8 +1694,6 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct=
 amdgpu_ring *ring)
>  	f =3D amdgpu_job_submit(job);
> =20
>  	r =3D dma_fence_wait(f, false);
> -	if (r)
> -		goto err;

[Severity: Low]
Does this leave an unused assignment to r in amdgpu_gfx_run_cleaner_shader_=
job()?

Since the error check was correctly removed (as dma_fence_wait with intr=3D=
false
does not return an error), the assigned value is never read before the
function unconditionally returns 0. Could this cause a dead store compiler
warning?

> =20
>  	dma_fence_put(f);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622142305.4579=
1-1-vulab@iscas.ac.cn?part=3D1
