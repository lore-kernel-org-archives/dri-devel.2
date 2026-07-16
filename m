Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5939EC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B490A10E380;
	Thu, 16 Jul 2026 17:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m6p+UC14";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38F710E380
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 17:19:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2E1A60A5E;
 Thu, 16 Jul 2026 17:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AFB1F000E9;
 Thu, 16 Jul 2026 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784222393;
 bh=SOknVJHD+yEFYoHGxcNe2g/ZLnUXpIjvhWPkghhD2KQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m6p+UC14O0mnPEIrOapuldldq4q0Fbo4FZtJQssu8Wfv9xr+7ncs+oYydvCd6ODn8
 xeMmscsRIQfs5Ah7Bavi4vzg5n8MWOz+hUp9mxeigf3SPPUM8TUE+RmRiIESG23eTZ
 OBXRCrZGipoucOdgORw62vm+G/MYnUhVs8ltI4WV/KXJqIhkx1ktlbF53Twsv3BNZW
 C2qzjjDCyXrl3qt0sKVT6AKsO0WoOO7osBRTz9YfQue1o4xTCRWeRwBvN1a/Ffw6+S
 TRZyaSd3VicALiypQgCRF2+HcusdK6lJianSuwoFEJ742EQW5pOcxndm2hORqd8u9H
 LaItgywIsYq4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] configfs: Treat attribute structures as const
 internally
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-configfs-const-base-v1-3-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-3-c545a4053cb5@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:19:53 +0000
Message-Id: <20260716171953.71AFB1F000E9@smtp.kernel.org>
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
- [High] configfs_create_file() and configfs_create_bin_file() use I_MUTEX_=
NORMAL instead of I_MUTEX_PARENT when locking the parent directory.
- [High] Incorrect subclass used when re-acquiring parent directory lock du=
ring symlink creation.
--

--- Patch [3]: [PATCH 3/6] configfs: Treat attribute structures as const in=
ternally ---
commit 02ad2fb78e37ee44180095f15441af685e40f465
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

configfs: Treat attribute structures as const internally

The configfs core never modifies the attribute structures defined in
driver core. This commit reflects this by updating the types used
internally in the configfs core.

> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index a48cece775a39..6460b000c5938 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c

[ ... ]

This is a pre-existing issue, but looking at configfs_create_file() in
fs/configfs/file.c:

int configfs_create_file(struct config_item * item, const struct configfs_a=
ttribute * attr)
{
	struct dentry *dir =3D item->ci_dentry;
	struct configfs_dirent *parent_sd =3D dir->d_fsdata;
	umode_t mode =3D (attr->ca_mode & S_IALLUGO) | S_IFREG;
	int error =3D 0;

	inode_lock_nested(d_inode(dir), I_MUTEX_NORMAL);
	error =3D configfs_make_dirent(parent_sd, NULL, (void *) attr, mode,
				     CONFIGFS_ITEM_ATTR, parent_sd->s_frag);
	inode_unlock(d_inode(dir));

	return error;
}

[Severity: High]
This isn't a bug introduced by this patch, but should this use I_MUTEX_PARE=
NT
instead of I_MUTEX_NORMAL when locking the parent directory?

Using the wrong lockdep subclass (I_MUTEX_NORMAL instead of I_MUTEX_PARENT)
for a parent directory violates core VFS locking rules.

This defeats lockdep's ability to detect parent-child ordering violations a=
nd
can hide real deadlocks until production.


This exact pattern also occurs in configfs_create_bin_file() in the same fi=
le:

int configfs_create_bin_file(struct config_item *item,
		const struct configfs_bin_attribute *bin_attr)
{
	struct dentry *dir =3D item->ci_dentry;
	struct configfs_dirent *parent_sd =3D dir->d_fsdata;
	umode_t mode =3D (bin_attr->cb_attr.ca_mode & S_IALLUGO) | S_IFREG;
	int error =3D 0;

	inode_lock_nested(dir->d_inode, I_MUTEX_NORMAL);
	error =3D configfs_make_dirent(parent_sd, NULL, (void *) bin_attr, mode,
				     CONFIGFS_ITEM_BIN_ATTR, parent_sd->s_frag);
	inode_unlock(dir->d_inode);

	return error;
}

[Severity: High]
This is a pre-existing issue, but should this also be updated to use
I_MUTEX_PARENT for the same reasons?


Additionally, looking at configfs_symlink() in fs/configfs/symlink.c:

	inode_unlock(dir);
	ret =3D get_target(symname, &target_item, dentry->d_sb);
	inode_lock(dir);
	if (ret)
		goto out_put;

[Severity: High]
This is a pre-existing issue, but when re-acquiring the parent directory
lock, should this use inode_lock_nested(dir, I_MUTEX_PARENT)?

Calling inode_lock(dir) re-acquires the lock using the default I_MUTEX_NORM=
AL
lockdep subclass.

As with the file creation paths, using the wrong subclass for a parent
directory defeats lockdep's checks and hides real deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-configfs-c=
onst-base-v1-0-c545a4053cb5@weissschuh.net?part=3D3
