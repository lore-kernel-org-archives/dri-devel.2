Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64851C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C786710E3A4;
	Fri, 26 Jun 2026 14:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q//ggRUl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E239C10E3A4
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:35:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1ABD6600D8;
 Fri, 26 Jun 2026 14:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0D1F000E9;
 Fri, 26 Jun 2026 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782484524;
 bh=PXSShUtVPVHsE86M0NUMvk7zjxFtwhmiCcLBFYhUzKs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q//ggRUlMlqLP3pn0jFNUJNSn1g5+wA8Ld55Dq9WGQ3/WLpU+E18hXPqsL2vIKZ5l
 nX47wmzCxiF/r4rppPRGy3YRoLD20w33dVALLt282jhy1l5qqydyqzqjNP+/XuMU1D
 7/C5N55sHAVFAU+e5wWnrghgYoXQuxjEL7mOVt6o1Wn+lwykDe3+P1MTpnDrgDguJY
 OYdF76JA3BY/eIK3b5HUBaSChj9aCRYugWgmZXiGZljSqYUEJ7r+UyITjX5glfGMS8
 iRxktr2LavsSkN9juCQL7yqkzKUa3+/KL9b//6w/7h+3W+fTBTqvwo1Pwo9cA35Kmj
 yinux+hEq0e8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/nouveau: validate_init: break paths after
 drm_gem_object_lookup   leak GEM reference
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626142631.48578-1-vulab@iscas.ac.cn>
References: <20260626142631.48578-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:35:24 +0000
Message-Id: <20260626143524.92A0D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing WW mutex unreserve and lock leak on `!vma` error path
- [High] Direct return on deadlock retry limit bypasses all cleanup
--

commit adecd1d5de2e904d8bd7b79540301f6e207076ed
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/nouveau: validate_init: break paths after drm_gem_object_lookup le=
ak GEM reference

This commit fixes GEM object reference leaks in nouveau's validate_init().
It adds drm_gem_object_put() on two error paths where the validation loop
breaks early.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouv=
eau/nouveau_gem.c
> index 20dba02d6175b..c654256f4081e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
[ ... ]
> @@ -523,6 +524,7 @@ validate_init(struct nouveau_channel *chan, struct dr=
m_file *file_priv,
>  			if (!vma) {
>  				NV_PRINTK(err, cli, "vma not found!\n");
>  				ret =3D -EINVAL;
> +				drm_gem_object_put(gem);
>  				break;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but does breaking out of the
loop here leak the WW mutex lock?

At this point in the loop, ttm_bo_reserve() has already successfully
completed. Because the loop breaks before adding the buffer to the tracking
lists (vram_list, gart_list, etc.), validate_fini() will not see the object
to unreserve it.

Could this lead to a WW mutex deadlock and a potential stack use-after-free
when op->ticket goes out of scope?

[Severity: High]
This is another pre-existing issue in the same function, but does the
deadlock avoidance retry logic at the top of validate_init() bypass cleanup?

drivers/gpu/drm/nouveau/nouveau_gem.c:validate_init() {
    ...
retry:
	if (++trycnt > 100000) {
		NV_PRINTK(err, cli, "%s failed and gave up.\n", __func__);
		return -EINVAL;
	}
    ...
}

If the loop hits this retry limit and returns directly, it skips
ww_acquire_fini() and fails to unreserve the slow-reserved buffer (res_bo).
Can this result in a permanent leak of GEM references, the WW ticket
context, and WW mutex locks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626142631.4857=
8-1-vulab@iscas.ac.cn?part=3D1
