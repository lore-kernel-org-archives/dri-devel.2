Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ADFCD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 05:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5901E10E08F;
	Tue,  9 Jun 2026 05:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cZCuXE86";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C8910E08F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 05:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BF4842D94;
 Tue,  9 Jun 2026 05:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018C11F00893;
 Tue,  9 Jun 2026 05:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780984159;
 bh=HU6K0gCJnf9BDgwpMuiAKOR+8+urPx11zpTzz8jDc/8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cZCuXE86vMnCp4/2L0Q0cT4vpn8TU+9SaHH/zbgGCGqJ7nW7Kh9MBK5ac/0kh93gM
 dTR+jLYu2tG0HmsvRSNz/HJF2Zgvuxaop52vRg02RReP/jth08Wu3+AMREIYbZzXMg
 EKwZ6CZuF+zC6YWY6JZmBTiILywXyr/9S/y2rhM0JwyC8t/yBjfJ3D9uflunl1kaS4
 E4yJ06gC4rXExLIPi07YF0BNKNa8D+neeFxcjA8Gj+1SGiPCRnPqCejw6LdvWM39/N
 qwO9rsc9YNWxtJP0FZZbKswoDzKTmr4tGiDImn49ZNdo1erKq/7RY4qaQo8Rthck2h
 qjzp/VvUwBO0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/debugfs: fix dentry leak when removing files
To: raoxu <raoxu@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <D43FE6467BFBCD12+20260609053655.2406749-1-raoxu@uniontech.com>
References: <D43FE6467BFBCD12+20260609053655.2406749-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:49:18 +0000
Message-Id: <20260609054919.018C11F00893@smtp.kernel.org>
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
- [High] The backing data for the debugfs file (`i_private`) is freed befor=
e the file is removed, creating a Use-After-Free vulnerability for concurre=
nt readers.
--

commit 64c6e87c0ad3d93de1579c3c0f9dfebb4d738254
Author: Xu Rao <raoxu@uniontech.com>

drm/debugfs: fix dentry leak when removing files

This commit fixes a dentry leak in drm_debugfs_remove_files by explicitly
calling dput after dropping the looked-up debugfs file, as debugfs_remove
does not consume the lookup reference.

> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index ae1c6126c2c59..fbaa53ec2a4c7 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -285,6 +285,7 @@ int drm_debugfs_remove_files(const struct drm_info_li=
st *files, int count,
> =20
>  		drmm_kfree(minor->dev, d_inode(dent)->i_private);
>  		debugfs_remove(dent);

[Severity: High]
This is a pre-existing issue, but does freeing i_private before calling
debugfs_remove() create a use-after-free risk for concurrent readers?

If a concurrent process is actively reading the debugfs file when
drm_debugfs_remove_files() is called, drmm_kfree() will synchronously free
the backing data. While debugfs_remove() does synchronize SRCU to wait
for active readers to finish, that synchronization happens after the
memory has already been freed here. This sequence might allow existing
readers to dereference the freed data while they complete their operations.

> +		dput(dent);
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/D43FE6467BFBCD12+20=
260609053655.2406749-1-raoxu@uniontech.com?part=3D1
