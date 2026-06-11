Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4285CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1634810EE74;
	Thu, 11 Jun 2026 10:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LBpC+kfu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E500210EE74
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:59:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A194B444F9;
 Thu, 11 Jun 2026 10:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ABE1F00893;
 Thu, 11 Jun 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781175553;
 bh=HGw1l7Ah8Iao+PhqyJK/AG+5wfg1jZv5IKBYHXx9hHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LBpC+kfuG07cbCBBXAfeNNzX/8DQw2o75kIqtMm8njJe8MZvmspdgcGB7pOAlKzhF
 NN/y0FQccOFIyc+9YfuHPHsbFNcbfbbx9vWO+UzFfzpJtvVARgGsfG5MTPz9gMGoIn
 khnfxDM0ATl7SiOlm5ti82TAfv5MhydhKJXf37LRzbGBzE4DFimsYO3QZgUX4YapS0
 II0XXv7aPbTLR0tTqopUmFNKmqY8lUMxa7YRnlnlJ8CEVxQicFzHlI2dt61mxkn9aj
 8XooU7IDR6DEUPApVAuHHYupZ0nwOQShuEHYxmgskee+qId5lOfE7EK4QDkPdNrK31
 LkQWGilkudUuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
To: "Andre Luiz Batista Bueno" <andrebueno.mac@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611024211.233876-1-andrebueno.mac@gmail.com>
References: <20260611024211.233876-1-andrebueno.mac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 10:59:13 +0000
Message-Id: <20260611105913.69ABE1F00893@smtp.kernel.org>
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
- [High] Missing bounds check on `entry->node_id` before array indexing on =
`node_id_to_phys_map` can lead to an out-of-bounds memory read.
--

commit 18102389ca6554c76ab0eea5128ed6304f9d3003
Author: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>

drm/amdgpu: deduplicate JPEG v5.0 interrupt routine

Both jpeg_v5_0_1.c and jpeg_v5_0_2.c implement identical interrupt
processing routines. To avoid code duplication, make the implementation
in jpeg_v5_0_1.c non-static and call it directly from jpeg_v5_0_2.c.

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
This is a pre-existing issue, but since this function is being exported to =
be
shared by other JPEG v5.0 blocks, could an out-of-bounds array access occur
here?

Looking at the beginning of jpeg_v5_0_1_process_interrupt():

	u32 i, inst;

	i =3D node_id_to_phys_map[entry->node_id];

The entry->node_id is extracted from the GPU's Interrupt Ring buffer using
an 8-bit mask, allowing values up to 255. However, node_id_to_phys_map is
defined globally with a fixed size of NODEID_MAX (15 elements).

Without a bounds check verifying entry->node_id < NODEID_MAX before indexing
the array, could a malformed hardware interrupt payload cause the driver to
read out-of-bounds memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611024211.2338=
76-1-andrebueno.mac@gmail.com?part=3D1
