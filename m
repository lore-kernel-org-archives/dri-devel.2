Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5327C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A8B10E3B1;
	Mon, 24 Aug 2026 09:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jhfieyff";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E6C10E3B1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 09:12:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE034415D1;
 Mon, 24 Aug 2026 09:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5B31F000E9;
 Mon, 24 Aug 2026 09:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787562739;
 bh=IJlPPqlU4MJdh9gSm2efnh8oSpYQLGtxOWNmZuY+SBE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jhfieyff2S9wnhr74JfrvL8sscPxvoswgMeJ+KrLvmiCZB4C7aEbsQOLQAe3rBWeA
 Nom4grWpHXATk01oBh1WxOG3d+9mfk2JmaGBXyxANd75s3wzOBxcKRmYjAjYkXYjWZ
 TLVG6eXTbPHYgP5Mp4LklpWMDJ98FxQHK1xsUqxb5ZCzm4IvMhnB2EHSnejNWIo06s
 ArwUkSH8e/imAuZhNXIKG2TZC13O9szG7jFYMAQq6eFF85Apb7mPWDGwp68XA3NvKn
 Bo3Ps1rhr3rkUdZ9KovV6ElR5eHyUaajtOX5Nfykzsv/wPEJm0WOKgVFFBNNfSCUrT
 WhJ9XVDXh/a/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: Fix memory leaks in debugfs and hwmon init
 error paths
To: liupeng <liupeng01@kylinos.cn>
Cc: linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260824090505.49913-1-liupeng01@kylinos.cn>
References: <20260824090505.49913-1-liupeng01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:12:19 +0000
Message-Id: <20260824091219.7C5B31F000E9@smtp.kernel.org>
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

> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the previously
> allocated drm->debugfs is leaked because the function returns the
> error code directly.
>=20
> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
> the allocated hwmon structure is leaked because the function returns
> the error code directly.
>=20
> Fix both by freeing the allocated memory and clearing the pointer on
> the error paths.
>=20
> Signed-off-by: liupeng <liupeng01@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824090505.4991=
3-1-liupeng01@kylinos.cn?part=3D1

