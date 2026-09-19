Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7833C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102B510E698;
	Sat, 19 Sep 2026 22:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JTODa3BH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C8A10E698
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:58:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8230B40A60;
 Sat, 19 Sep 2026 22:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519591F000FF;
 Sat, 19 Sep 2026 22:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858695;
 bh=d0j2YpggEjxvzB5uX/GBkHryXZzC0iXFCEGyTbisHgY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JTODa3BHP7YGXJmMc4zdcxKXA/0vWblPcT+qtSKuAuABqOvOm0Gtmi7omgAQvHvu5
 1w3pHVetwzAIVeRORyURjL8W9vaWqXOJ8OWiMXpcU9lYATfSQeQVsxEK+jT+2bmpqD
 XP5Fy8eFT63AH5m+4QgesG0l3cI+DidMRTD9MEaFZ1ScIe0SOEB27O2IPBbvn+vKce
 ritkTi3tRZ0yznwHN5Q17QAxfU6j40p1ERMyVHcQBa6SoqnbhbGRMLXXsU2yX39qmV
 B6gx5HbKJ0LEeQMscmdDc1K718bZl0EvBrong9fDtPjayvToyRRTKEYRD4xlvrf74B
 /4BzhiIpqFlxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ast: validate framebuffer VRAM size in ast_mode.c
 and DP501 firmware bounds
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919223516.3889946-1-benquike@gmail.com>
References: <20260919223516.3889946-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:58:15 +0000
Message-Id: <20260919225815.519591F000FF@smtp.kernel.org>
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
- [Medium] ast: commit message and code mismatch regarding DP501 bounds che=
ck
--

commit 7c7f87df86011f4f2e1f7815297b6468c2302228
Author: Hui Peng <benquike@gmail.com>

drm/ast: validate framebuffer VRAM size in ast_mode.c and DP501 firmware bo=
unds

This commit adds bounds checking for the primary plane framebuffer size
against the vram_size. It also updates the DP501 firmware copy loop in
ast_dp501.c to prevent out-of-bounds memory accesses.

> In drivers/gpu/drm/ast/ (ast_mode.c, ast_dp501.c), verify that the
> primary plane framebuffer fits within ast->vram_size and bounds-check
> DP501 firmware headers.

> diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp=
501.c
> index 6d6ccfad14154..d9ca8760e5b51 100644
> --- a/drivers/gpu/drm/ast/ast_dp501.c
> +++ b/drivers/gpu/drm/ast/ast_dp501.c
> @@ -250,7 +250,8 @@ static bool ast_launch_m68k(struct ast_device *ast)
> =20
>  		/* copy image to buffer */
>  		for (i =3D 0; i < len; i +=3D 4) {
> -			data =3D *(u32 *)(fw_addr + i);
> +			data =3D 0;
> +			memcpy(&data, fw_addr + i, min_t(u32, len - i, 4));

[Severity: Medium]
Is the commit message accurate regarding DP501 firmware headers?

The commit message claims to "bounds-check DP501 firmware headers", but
ast_launch_m68k() adds a bounds check to the firmware payload copy loop
instead.

Since the driver reads DP501 headers directly from mapped hardware memory
rather than the host buffer, there are no headers in the host buffer to
bounds-check.

Could the commit message be updated to describe this payload copy bounds
check instead of firmware headers?

>  			ast_moutdwm(ast, boot_address + i, data);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223516.3889=
946-1-benquike@gmail.com?part=3D1
