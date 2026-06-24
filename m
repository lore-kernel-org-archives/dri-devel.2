Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973A1CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA4010EDE7;
	Wed, 24 Jun 2026 07:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C2qMJW5T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385B810EDE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 07:57:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 489A5601F6;
 Wed, 24 Jun 2026 07:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17921F000E9;
 Wed, 24 Jun 2026 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782287820;
 bh=/zEGBizExwf0ScgWKx3+GL1ilzf49B8iqlIJ5bw3GS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C2qMJW5TOb4vKKpvhbGOHfocPUOYEYYoTLsp6pF4UOEVQAP/FDQV13B4dcKlfk1G3
 DMHLOp3LHwlkmWXGfERUDf2aw18eggG0tbm4UvtqI/JgaTmKpQTdX5ufNy23efEBiM
 OZPzzRLegnM9uQXuTRlHtQpmr2zYGZjmEr0UDCwmj8I5vjzRFyZpk4rYJzJNc2Ii1T
 ugAl9PDC73FXlZ3t7RbVtcgbHUalJbvn5hzpJXIh/ULhleP3TWNKJbf0qXJeUQxgQT
 U3tiBQmgn2cBoi1wSGBC3UPwVIECquzbVOVzGLhHSDOr0lO/b32kPwC47kkpmtkMQZ
 9pKHZoiHOH/eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 RESEND] drm/amdgpu: deduplicate JPEG v5.0 interrupt
 routine
To: "Andre Luiz Batista Bueno" <andrebueno.mac@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624033134.145561-1-andrebueno.mac@gmail.com>
References: <CADnq5_POUhiOuusWBXgZMLCUhoRutMoH0NaLJgjWqapXd0eRcw@mail.gmail.com>
 <20260624033134.145561-1-andrebueno.mac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 07:56:59 +0000
Message-Id: <20260624075659.E17921F000E9@smtp.kernel.org>
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
- [High] Potential out-of-bounds array access when indexing `node_id_to_phy=
s_map` with unvalidated `entry->node_id`.
--

commit 9ee6645118b792b4fedbe83c62cc09cc3bce36b1
Author: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>

drm/amdgpu: deduplicate JPEG v5.0 interrupt routine

This commit deduplicates identical interrupt processing routines in
jpeg_v5_0_1.c and jpeg_v5_0_2.c. It updates jpeg_v5_0_1_process_interrupt()
to be non-static and calls it directly from the jpeg_v5_0_2 interrupt
handlers to avoid code duplication.

> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index 250316704dfac..2b8d8f4ca30d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -755,7 +755,7 @@ static int jpeg_v5_0_1_set_ras_interrupt_state(struct=
 amdgpu_device *adev,
> =20
> =20
> =20
> -static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
> +int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
>  					 struct amdgpu_irq_src *source,
>  					 struct amdgpu_iv_entry *entry)
>  {

[Severity: High]
This is a pre-existing issue, but does this function lack bounds checking on
entry->node_id before using it as an array index?

When the interrupt vector is read from the hardware-writeable IH ring,
entry->node_id can be an 8-bit value (0-255). Looking at how this is
handled inside jpeg_v5_0_1_process_interrupt():

int jpeg_v5_0_1_process_interrupt(...)
{
	u32 i, inst;

	i =3D node_id_to_phys_map[entry->node_id];
        ...
}

Could a malicious or malfunctioning PCIe device supply an interrupt vector
with a node_id >=3D NODEID_MAX (15), leading to an out-of-bounds read of up=
 to
1020 bytes past the end of the node_id_to_phys_map array and a potential
kernel panic?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624033134.1455=
61-1-andrebueno.mac@gmail.com?part=3D1
