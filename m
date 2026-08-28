Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2F9C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F268210F259;
	Fri, 28 Aug 2026 06:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCIwzbBD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DA610F259;
 Fri, 28 Aug 2026 06:18:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08CF96053A;
 Fri, 28 Aug 2026 06:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E23D1F000E9;
 Fri, 28 Aug 2026 06:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897897;
 bh=NMwZIS5imxbbIV1H2LX7uLI9rnRWoPcfk4lNbbznKjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UCIwzbBDyaPSeWWibf/Qi1sTPvOlR2RlRL1fIH3hmyXHpChCk0EfwjpC3hNnOFmKq
 SFzad3pnT64i8BGEaHDpffO/sqgGTYqR0eNLzTOHzdmfXyl/6zNu7eGzSJGgriHCtH
 XcIPguCy6xKJ9teQiKSG36rTNnKn82sxaa4BbXagW4NAfVjHvsuawwTibCtYjl3ZCE
 lPWd3BstUFvpRsz7nttQhL+jkhYBvwB/wmQe1U0Xp2b0T05f5ByoCs8NJe9J/d8YKw
 dKL0PzAaz78TP7vltnyEhASE+tjonOWkM+QyP9pKrHfnZFrKiy9AFurqFg37ve3BrA
 wmi7z0GZBd4lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/oa: Remove sysfs entry on idr_alloc failure in
 xe_oa_add_config_ioctl()
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260828060812.163548-1-yaolu@kylinos.cn>
References: <20260828060812.163548-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:18:17 +0000
Message-Id: <20260828061817.7E23D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The resource leak and use-after-free vulnerability fixed by this p=
atch in `xe_oa.c` also exists in the closely related `i915_perf.c` code, bu=
t the patch does not fix it there.
--

commit d832610ac618deeb81c1662fcf62f5c12fbe835e
Author: Lu Yao <yaolu@kylinos.cn>
drm/xe/oa: Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioct=
l()

If idr_alloc() fails after create_dynamic_oa_sysfs_entry() has succeeded,
the error path frees the OA config without removing the metrics sysfs
group. This commit fixes the bug in xe_oa.c by removing the sysfs group
before releasing the config.

> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index b460fcdfca15c..d0625fb7111d9 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -2435,8 +2435,9 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, =
u64 data, struct drm_file *fi
> =20
>  	oa_config->id =3D idr_alloc(&oa->metrics_idr, oa_config, 1, 0, GFP_KERN=
EL);
>  	if (oa_config->id < 0) {
> -		drm_dbg(&oa->xe->drm, "Failed to create sysfs entry for OA config\n");
> +		drm_dbg(&oa->xe->drm, "Failed to allocate id for OA config\n");
>  		err =3D oa_config->id;
> +		sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);

[Severity: High]
This is a pre-existing issue, but does this same resource leak and=20
use-after-free vulnerability exist in the closely related i915 driver code?

It looks like the bug fixed by this patch in xe_oa.c might also be present
in drivers/gpu/drm/i915/i915_perf.c:i915_perf_add_config_ioctl():

	oa_config->id =3D idr_alloc(&perf->metrics_idr,
				  oa_config, 2,
				  0, GFP_KERNEL);
	if (oa_config->id < 0) {
		drm_dbg(&perf->i915->drm,
			"Failed to create sysfs entry for OA config\n");
		err =3D oa_config->id;
		goto sysfs_err;
	}

If idr_alloc() fails in i915_perf_add_config_ioctl() (for example, due to
IDR exhaustion or out of memory), the error path jumps to sysfs_err and
calls i915_oa_config_put(). This frees the oa_config structure without first
removing the sysfs group created by create_dynamic_oa_sysfs_entry().

A local user with sufficient privileges could trigger this by adding configs
until the IDR is exhausted, then read the dangling sysfs id attribute. This
would trigger a UAF when show_dynamic_id() accesses the freed oa_config
memory.

Should a similar fix be applied to i915_perf.c?

>  		goto sysfs_err;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828060812.1635=
48-1-yaolu@kylinos.cn?part=3D1
