Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A0606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3gpM21s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE3F10E325;
	Wed, 11 Nov 2026 18:26:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF7710E325
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:26:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB55A412BE;
 Wed, 11 Nov 2026 18:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C631F00A05;
 Wed, 11 Nov 2026 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794421613;
 bh=9Dud6zlerHNn9nz1xXrbob5GLigYIgMqoc3io1DJhSI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=S3gpM21s5nm/ByT5tU0sv5Zk0+LW8qfPEtBgBPr8EnhAccD+5bHlpKiMryHcrRAXm
 0oJn8wKkGcaSeTgZAt71swduiz0OgJAyMINgymtIhZm8eWCn1eIFAycySYzFfeeA+F
 IpsY3na8uppSKWQYZCn1y9RyNNxSwqX+bBMWLwpvvaNiYF3RUTy1nYWDKrUF8mr/Xw
 rELw0SXojQ/GyvUO4m+Y3RRI/JGPCAV88KAX/xaverjulVw/OOPQO0+nkasaULfOIX
 90SLpbgqWPaEq6ppcFh6rVrED3UDq5ijofP8rhC4rdfR2TziI50RpbG880P0V0zEuz
 WjeJrczE9UeKw==
Message-ID: <sashiko-outbox-209459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/adreno: Improve AHB error messages
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111171417.249152-1-robin.clark@oss.qualcomm.com>
References: <20261111171417.249152-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 18:26:52 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/msm/a8xx: status clobbering in a8xx_cp_hw_err_irq() [1]
--

commit 036d732e4c5bd970decdf064cde4d6ff621ef0a9
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/adreno: Improve AHB error messages

This commit adds A7XX register definitions and decodes CP_RL_ERROR_DETAILS
registers on A7XX and A8XX GPUs to log detailed AHB bus error messages.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a8xx_gpu.c
> index f892731cd3d3a..f2dcf62be861e 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -1232,12 +1232,18 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
>  		a8xx_fault_detect_irq(gpu);
> =20
>  	if (status & A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR) {
> -		u32 rl0, rl1;
> +		u32 rl0, rl1, addr;
> +		const char *mode;
> =20
>  		rl0 =3D gpu_read(gpu, REG_A8XX_CP_RL_ERROR_DETAILS_0);
>  		rl1 =3D gpu_read(gpu, REG_A8XX_CP_RL_ERROR_DETAILS_1);
> +
> +		addr =3D FIELD(rl0, A8XX_CP_RL_ERROR_DETAILS_0_ADDR);
> +		mode =3D (rl0 & A8XX_CP_RL_ERROR_DETAILS_0_WRITE) ? "write" : "read";
> +
>  		dev_err_ratelimited(&gpu->pdev->dev,
> -				"CP | AHB bus error RL_ERROR_0: %x, RL_ERROR_1: %x\n", rl0, rl1);
> +			"CP | AHB bus error RL_ERROR_0: %x (addr: 0x%05x, %s), RL_ERROR_1: %x=
\n",
> +			rl0, addr, mode, rl1);
>  	}
> =20
>  	if (status & A6XX_RBBM_INT_0_MASK_CP_HW_ERROR)

[Severity: Medium]
This problem wasn't introduced by this patch, but does a8xx_cp_hw_err_irq()
clobber status while iterating over pipes [1]?

drivers/gpu/drm/msm/adreno/a8xx_gpu.c:a8xx_cp_hw_err_irq() {
	u32 status =3D gpu_read(gpu, REG_A8XX_CP_INTERRUPT_STATUS_GLOBAL);
    ...
	for (unsigned int pipe_id =3D PIPE_NONE; pipe_id <=3D PIPE_DDE_BV; pipe_id=
++) {
		if (!(BIT(pipe_id) & pipe))
			continue;

		if (hw_fault_mask & status) {
			status =3D a8xx_read_pipe_slice(gpu, pipe_id, slice,
					REG_A8XX_CP_HW_FAULT_STATUS_PIPE);
    ...
		}

		if (sw_fault_mask & status) {
			status =3D a8xx_read_pipe_slice(gpu, pipe_id, slice,
					REG_A8XX_CP_INTERRUPT_STATUS_PIPE);
    ...
			if (status & BIT(8)) {
				a8xx_write_pipe(gpu, pipe_id, REG_A8XX_CP_SQE_STAT_ADDR_PIPE, 1);
				status =3D a8xx_read_pipe_slice(gpu, pipe_id, slice,
						REG_A8XX_CP_SQE_STAT_DATA_PIPE);
    ...
			}

			if (status & BIT(10)) {
				status =3D a8xx_read_pipe_slice(gpu, pipe_id, slice,
						REG_A8XX_CP_PROTECT_STATUS_PIPE);
    ...
			}
		}
	}
}

Overwriting status with per-pipe fault and opcode register values causes the
subsequent sw_fault_mask check, the BIT(10) register protection check, and
later pipe iterations to test unrelated values instead of the interrupt
status registers, resulting in missed or bogus fault diagnostics.

[1] https://sashiko.dev/#/bug/linux-69f62dbe-1123-4e6d-8506-4fc99ce6cd9b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111171417.2491=
52-1-robin.clark@oss.qualcomm.com?part=3D1
