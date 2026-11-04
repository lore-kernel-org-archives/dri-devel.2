Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C4606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwPPyuZu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0753D10E08C;
	Wed,  4 Nov 2026 03:04:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7832310E08C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 03:04:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EB67601F6;
 Wed,  4 Nov 2026 03:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308721F000C1;
 Wed,  4 Nov 2026 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793761483;
 bh=fjiiK/BOh7q9k2Eggj/AwlqL00YcEd3G4AkottMfax4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GwPPyuZubJpaQ2WqQDMpuZDi8675P1OqTwtnyd6J7t3Q4ItWAhu6XqOou1/f43JBo
 VbPOqFuwL2AjxDHHfSQLOkS3WVbr/mSiWh/bRG5kNS9tdgavo/AxPiY66fVX0rGz+c
 08InzPiJgV55l7NyUmaVojLlclC5LBZeGxl/e+dsEvVZOYuiHryD/NrJIOd6T38x7T
 qVigSkKsU69du+mXAHdMsaJ24q93tGrheChDI6pzAlXswGC754G23zSfJ6A+47wd7C
 UXl2cHAY3UVYJJO7sOBRQrJEjpmpf7APp3ZFo4/Djg0RNECluBk5EKu623yYLKqy/S
 pjfG9s6cM+yLw==
Message-ID: <sashiko-outbox-196578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/jpeg: unwind the rings when sw init fails
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104025338.1527322-1-vulab@iscas.ac.cn>
References: <20261104025338.1527322-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:04:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/amdgpu/jpeg: inaccurate commit message claim about other JPEG s=
w_init()
--

commit 286291864ed14a6432cfeee63e75b0d8982f6065
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/amdgpu/jpeg: unwind the rings when sw init fails

This commit updates jpeg_v4_0_5_sw_init() to unwind initialized JPEG
resources via amdgpu_jpeg_suspend() and amdgpu_jpeg_sw_fini() when
amdgpu_jpeg_reg_dump_init() or amdgpu_jpeg_sysfs_reset_mask_init() fails.

>     drm/amdgpu/jpeg: unwind the rings when sw init fails
>    =20
>     jpeg_v4_0_5_sw_init() returns directly when
>     amdgpu_jpeg_reg_dump_init() or amdgpu_jpeg_sysfs_reset_mask_init()
>     fails, after all JPEG rings have been initialized successfully.
>     amdgpu_ring_init() allocated the ring buffers, writeback slots and the
>     vmid fences, and only amdgpu_ring_fini(), called through
>     amdgpu_jpeg_sw_fini(), releases them. Because the IP block's status.s=
w is
>     only set after sw_init() succeeds, the upper layers skip sw_fini() for
>     this block and the resources are leaked.
>    =20
>     Unwind with amdgpu_jpeg_sw_fini(), as the other JPEG implementations =
do.
>    =20
>     Fixes: 2b0ccf3923b5 ("drm/amdgpu: Enable devcoredump for JPEG4_0_5")
>     Cc: stable@vger.kernel.org
>     Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>     Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

[Severity: Low]
This isn't a bug in the code, but is the statement that the other JPEG
implementations unwind with amdgpu_jpeg_sw_fini() accurate?

Looking at the other JPEG IP block implementations in
drivers/gpu/drm/amd/amdgpu/ (jpeg_v1_0.c, jpeg_v2_0.c, jpeg_v2_5.c,
jpeg_v3_0.c, jpeg_v4_0.c, jpeg_v4_0_3.c, jpeg_v5_0_0.c, jpeg_v5_0_1.c,
jpeg_v5_0_2.c, and jpeg_v5_3_0.c), none of their sw_init callbacks call
amdgpu_jpeg_sw_fini() or amdgpu_jpeg_suspend() on error. For example, in
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c, jpeg_v4_0_sw_init() returns r
directly when amdgpu_jpeg_reg_dump_init() or
amdgpu_jpeg_sysfs_reset_mask_init() fails:

	r =3D amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0, ARRAY_SIZE(jpeg_r=
eg_list_4_0));
	if (r)
		return r;

	adev->jpeg.supported_reset =3D
		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
	if (!amdgpu_sriov_vf(adev))
		adev->jpeg.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
	r =3D amdgpu_jpeg_sysfs_reset_mask_init(adev);

	return r;

Also, since the direct error return on amdgpu_jpeg_sysfs_reset_mask_init()
in jpeg_v4_0_5_sw_init() in drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c was
introduced earlier in commit 96f0b56c34d2 ("drm/amdgpu: add sysfs
interfaces for jpeg reset mask"), should that commit be included in the
Fixes tags as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104025338.1527=
322-1-vulab@iscas.ac.cn?part=3D1
