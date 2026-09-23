Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4302CC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C7F10F0F5;
	Wed, 23 Sep 2026 15:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k5bCX5vI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4599810F0F5
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:01:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0078F413E9;
 Wed, 23 Sep 2026 15:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D9E1F000FF;
 Wed, 23 Sep 2026 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790175708;
 bh=jk7MwJUlhXa/zaKf2NMoUCSCPoZ6UcubI2GDMpBHueA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k5bCX5vIpmSEvZOswD/d5Mb76irH/BforoHZWiDJl68C6gor8y1QwQ6+x0Wp6H9w2
 WiXQQd9ZaT2YE3jMygXA6aaEUfpIkzwsIcEN0psHy6jYBGKbprO8s9jBngeFVWbegy
 CuTwsGu4f1hfJTv04jDTI8tR7865VjrIGA52EgP6fxLjOSXDc7b9Pe+cSu6CLUXyYD
 WBAW3yh2HCRqhOY5zNjech/qkLeouoH0ulIdETWtVU0gIos7+TTOAZPvlQwqtebkiY
 C0tzVonUPp8E1k9bJc1St1eIV4s0FCPhKjwMthjhhsvWSYpn+vmYCkxQgw/IESp/gn
 FKNyD1WS3uPOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: use correct offset when stamping drawable mm_time
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923145018.1244740-1-qwe.aldo@gmail.com>
References: <20260923145018.1244740-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:01:48 +0000
Message-Id: <20260923150148.B7D9E1F000FF@smtp.kernel.org>
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
- [High] drm/qxl: memory corruption in command ring due to incorrect pointe=
r arithmetic
--

commit 4eafd1ab56e831f8f5645009fd6d47df82921e0f
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: use correct offset when stamping drawable mm_time

This commit attempts to fix the mm_time stamping offset by applying the
release_offset and a sizeof() offset when mapping the page pointer to the
drawable structure.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..e7594d14737ce 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -188,7 +188,9 @@ static int qxl_process_single_command(struct qxl_devi=
ce *qdev,
>  		 u64_to_user_ptr(cmd->command), cmd->command_size);
> =20
>  	{
> -		struct qxl_drawable *draw =3D fb_cmd;
> +		struct qxl_drawable *draw =3D fb_cmd +
> +			sizeof(union qxl_release_info) +
> +			(release->release_offset & ~PAGE_MASK);

[Severity: High]
Does this pointer arithmetic shift the base pointer past the release_info
header, causing memory corruption?

In struct qxl_drawable, union qxl_release_info is the first member.
The user payload is copied to fb_cmd + sizeof(union qxl_release_info) +=20
(release->release_offset & ~PAGE_MASK) exactly because the payload starts=20
after the header.

If the struct pointer itself is initialized with that extra 8-byte
sizeof(union qxl_release_info) shift, won't draw->mm_time end up writing=20
8 bytes past the intended location in the command ring, overwriting=20
fields like the surfaces_dest array and leaving the actual mm_time
uninitialized?

> =20
>  		draw->mm_time =3D qdev->rom->mm_clock;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923145018.1244=
740-1-qwe.aldo@gmail.com?part=3D1
