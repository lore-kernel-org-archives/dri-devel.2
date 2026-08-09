Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69609C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E17810E465;
	Sun,  9 Aug 2026 09:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kQRtf0zs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C69410E294
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:13:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A7E0417B8;
 Sun,  9 Aug 2026 09:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4444B1F000E9;
 Sun,  9 Aug 2026 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786266799;
 bh=pUc1C9QZkacUAORx1qnkoA7rkSttAWi9kXdf9PxHkvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kQRtf0zswKeOYNjW0gkB2BeRnaYiIidJE9FeBywhF2B7jVh81eU/OsmBYySY6zhqo
 QCaO0LfkpFnev64QDq75Xawz4UPpCTKFs3VhLyEGmLs8Cx0cLdI5WPyatctmnURQR8
 MvP146n8nLLFuyeGmW2Hpbp7Z5D64ZxwsDKvw4jKGfnu3Qik/La1NMUcNjApMnnbSb
 zuDgC660qeBNT36I1QVGYiR5tjP+R9dmHjViLsOfQH/9mzF/fAkROfk4jYOB92K+wJ
 +ScvlyyCANiY8P8gRZno7HB4bkmPcpw70X9fAhui7B+HmEhB9ossQgW2K4CHyk1Gt7
 bpbUp4rc7KCJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] drm/amdgpu/aca: Fix off-by-one buffer size
 parameter in add_aca_sysfs
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809084735.9743-6-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
 <20260809084735.9743-6-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:13:18 +0000
Message-Id: <20260809091319.4444B1F000E9@smtp.kernel.org>
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
- [High] Invalid free of an interior pointer causing a kernel panic during =
driver teardown.
--

--- Patch [5]: [PATCH v4 5/6] drm/amdgpu/aca: Fix off-by-one buffer size pa=
rameter in add_aca_sysfs ---
commit 4e00dff410196f38991a5223ac5b71f0384ad6fa
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

    drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs
   =20
    snprintf() guarantees NUL-termination within the size limit specified by
    its second argument. Passing 'sizeof(handle->attr_name) - 1'
    unnecessarily reduces the usable buffer capacity by one byte, causing
    sysfs attribute names to be truncated early.
   =20
    Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysf=
s()
    to allow full use of the allocated buffer space.
   =20
    Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index dcddeb3816285..3da3d369a9187 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, =
struct aca_handle *handle)
>  {
>  	struct device_attribute *aca_attr =3D &handle->aca_attr;
> =20
> -	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", ha=
ndle->name);
> +	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle=
->name);

[Severity: High]
Is the handle pointer passed here an interior pointer that gets improperly
freed later?

Looking at amdgpu_ras_bind_aca(), it appears an embedded pointer is passed
into the ACA subsystem:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:amdgpu_ras_bind_aca() {
    ...
    return amdgpu_aca_add_handle(adev, &obj->aca_handle, ras_block_str(blk)=
, aca_info, data);
}

During driver teardown, remove_aca_handle() unconditionally frees this
interior pointer:

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:remove_aca_handle() {
    ...
    kfree(handle);
}

Could this lead to a SLUB panic when removing the driver module or tearing
down the device?

>  	aca_attr->show =3D aca_sysfs_read;
>  	aca_attr->attr.name =3D handle->attr_name;
>  	aca_attr->attr.mode =3D S_IRUGO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809084735.9743=
-1-sreekuttan2156239@gmail.com?part=3D5
