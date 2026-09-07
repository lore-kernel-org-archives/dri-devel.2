Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD64CC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D71610E0A5;
	Mon,  7 Sep 2026 20:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DxWMvyuH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F6110E0A5
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:28:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D688A416BE;
 Mon,  7 Sep 2026 20:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FECF1F00A3A;
 Mon,  7 Sep 2026 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788812882;
 bh=prW/TBQELLYTHbiiGNRzi6rr0CJVUZ/XPDzUxlS5CyE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DxWMvyuHb3TFtySyw4ZqyhSGRfwa70EOr6yX9B2KGDAokUHbq2KGMxt6yUapRtM1u
 H57ylUkHWl6WIW+BdB9aJs4bXNTsfdbhhaiiw+EwVzi66H8nv+zjOmLxmTwBDgoDYl
 ZRHScUPIKM1B2r4NyTcDj5JROARqSVmbX3g1Kliu74wvqkB/V225RKbBj4piKMeelo
 nl9Yc0WbkeX0AC/L9erqkIWJcyMrvQKwVEFlLcGwBqboIsaWwZojG26FfxWk/pUu50
 BP0Xf7k4gUmxu8ycE8MQ4SQi3jUJga0iP9TlDleaYUvYp/8So9dkpDZW1Az+T+ORC8
 xfnv6BIktvV9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/16] drm/panfrost: Move debugfs initialisation to
 relevant subsystems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-3-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-3-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:28:01 +0000
Message-Id: <20260907202802.7FECF1F00A3A@smtp.kernel.org>
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
- [High] Use-after-free of BO label string in debugfs due to incorrect clea=
nup ordering
--

commit a176b75fb18c68d91dd9610fff6763a62e825a4f
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move debugfs initialisation to relevant subsystems

This commit moves the initialization of debugfs knobs out of panfrost_drv.c
and into the specific subsystems they provide information about, such as gem
and sched.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 383ac8cd56456..518f24549b9de 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c

[ ... ]

> @@ -756,4 +757,28 @@ void panfrost_gem_debugfs_print_bos(struct panfrost_=
device *pfdev,
>  	seq_printf(m, "Total size: %zd, Total resident: %zd, Total reclaimable:=
 %zd\n",
>  		   totals.size, totals.resident, totals.reclaimable);
>  }
> +
> +static int panfrost_gems_show(struct seq_file *m, void *data)
> +{
> +	struct drm_info_node *node =3D m->private;
> +	struct panfrost_device *pfdev =3D to_panfrost_device(node->minor->dev);
> +
> +	panfrost_gem_debugfs_print_bos(pfdev, m);

[Severity: High]
This is a pre-existing issue, but does this debugfs read path have a race
condition with BO destruction that could lead to a use-after-free?

When reading the gems debugfs file, panfrost_gem_debugfs_print_bos() holds
the gems_lock and iterates over BOs. If it reads a positive refcount for a
BO, and immediately after that the last reference to the BO is dropped by
another thread, panfrost_gem_free_object() in
drivers/gpu/drm/panfrost/panfrost_gem.c is called.

In panfrost_gem_free_object(), the cleanup order frees the label string
before removing the BO from the debugfs list:

panfrost_gem_free_object()
   ...
   kfree_const(bo->label.str);
   panfrost_gem_debugfs_bo_rm(bo);
   mutex_destroy(&bo->label.lock);

Because the string is freed before the BO is removed from the debugfs list
and before synchronization on the list lock occurs in
panfrost_gem_debugfs_bo_rm(), the debugfs printing thread could dereference
the freed bo->label.str.

Should panfrost_gem_debugfs_bo_rm(bo) be called before freeing the string
and destroying the lock to prevent this?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D3
