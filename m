Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4029C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF3D10F768;
	Sat, 27 Jun 2026 03:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dJNBeBuc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9746510F757
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:39:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CE03432E8;
 Sat, 27 Jun 2026 03:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4B51F000E9;
 Sat, 27 Jun 2026 03:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531566;
 bh=4i1ZsZPDRJqUWScl6S+Dh2OGo3YGAUDR69p7wM2oWKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dJNBeBucTBltTN2XC8geo6ONmaNiCxb5dYESfnMrzkDNfNOC+rGLin2448/7vT4sj
 vp42umnodEmRMkuXvc8Gd43U4AP7LPG5aXiAoVJtMDhTa+MmVT1CbyTU1CY2J23x6g
 anUyJidbZkodtD5nmW1EC8DxRBVl9J2XA6BjytobDibUw4F3yUQC0N3Zb7H8GhZ9Ul
 ZcsWYWaLq2j52sHrJvKdkXKpNdeabuTbZvwXTMqUQ231I+sUfFaVP+wXri8wu0Vk5S
 +8ETO5bD5CylkNEiWMI9w8UMsRglxLRMnw9AZRci9wvCPx049EbsEEgv5LVkLYcm8z
 0D6wSp8swL7rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/38] drm/vkms: Use DRM_ROTATION_FMT macros for
 rotation display
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-16-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-16-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:39:25 +0000
Message-Id: <20260627033926.0A4B51F000E9@smtp.kernel.org>
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
- [Medium] The commit message claims to replace 'show_bitfield' calls, but =
the patch only adds new code.
--

commit f7f78813e63d666fa8947019e26ece97d4eb3583
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Use DRM_ROTATION_FMT macros for rotation display

This commit updates the vkms configuration debugfs output to include suppor=
ted
and default rotation configurations. It uses the DRM_ROTATION_FMT macro for
formatting.

> Replace show_bitfield calls for rotation/reflection with the new
> DRM_ROTATION_FMT / DRM_ROTATION_FMT_ARGS macros for cleaner code.

[Severity: Medium]
Is this description accurate?

The commit message claims to replace show_bitfield calls, but the patch only
adds new seq_printf calls for supported and default rotations in
vkms_config_show() (in drivers/gpu/drm/vkms/vkms_config.c) without removing
any existing code.

A search of the tree before this commit confirms show_bitfield was never us=
ed
in the vkms subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D16
