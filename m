Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40574606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JizsqHyG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B287610FDA7;
	Wed, 21 Oct 2026 11:51:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE05110FDA7
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:51:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC08760AB6;
 Wed, 21 Oct 2026 11:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0441F000C4;
 Wed, 21 Oct 2026 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792583463;
 bh=/GLi/Y19ebO5Wqeo9afSVmfNL5Rer6QdLvPXY5m8LPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JizsqHyGBd32BQgyL30RQoXUc30n0syWQj/LkIUk7yegB7K7fnt4IqzSdvh5lGL4d
 09/fLgarnQuC3W4a3ahO997DZfeaowy5284RSS5eXlCytgtL8nlSUv5zsPsJnHSnm8
 BV+t7nYuHNm9Uu9aLQQoUnEHCXKKnMqi0+X8s27imQAavpS+OSqGSGkDqhslVF2qzg
 XttWWX7mHzbljRj4zRpf26dXqoLY66xrA4vhXYRx8Rr2M9/XLy5/NC6UEQ1gZyEHZu
 E8i7iiRzV0XOmrNj1kMAWJPhamGo9uQCxTD/mXJXcaU+4g5Xd3IdJnGvSjVkKZPKjq
 dWIp1MER1DRSA==
Message-ID: <sashiko-outbox-180189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/radeon/vce1: enable the VCE trap interrupt
To: "Matheus Tagliari" <mptagliari@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261021114122.94008-3-mptagliari@gmail.com>
References: <20261021114122.94008-1-mptagliari@gmail.com>
 <20261021114122.94008-3-mptagliari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:51:02 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/radeon: vce_v1_0_start() writes VCE1 VCE_SYS_INT_EN offset on =
VCE2
--

commit 081ec1fcedbbac29c36bb9a81a87f74e67af09fd
Author: Matheus Tagliari <mptagliari@gmail.com>

drm/radeon/vce1: enable the VCE trap interrupt

This commit defines VCE_SYS_INT_EN and VCE_SYS_INT_TRAP_INTERRUPT_EN in
sid.h and enables the trap interrupt at the end of vce_v1_0_start() so VCE
fences are processed by the interrupt handler.

> diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.h
> index f9267b026f8de..ba322de844b3b 100644
> --- a/drivers/gpu/drm/radeon/sid.h
> +++ b/drivers/gpu/drm/radeon/sid.h
> @@ -1878,6 +1878,8 @@
>  #define	DMA_PACKET_NOP					  0xf
> =20
>  #define VCE_STATUS					0x20004
> +#define VCE_SYS_INT_EN					0x20d00
> +#define		VCE_SYS_INT_TRAP_INTERRUPT_EN		(1 << 3)
>  #define VCE_VCPU_CNTL					0x20014
>  #define		VCE_CLK_EN				(1 << 0)
>  #define VCE_VCPU_CACHE_OFFSET0				0x20024
> diff --git a/drivers/gpu/drm/radeon/vce_v1_0.c b/drivers/gpu/drm/radeon/v=
ce_v1_0.c
> index bdfbcf14b8640..0866e7fb0b0ef 100644
> --- a/drivers/gpu/drm/radeon/vce_v1_0.c
> +++ b/drivers/gpu/drm/radeon/vce_v1_0.c
> @@ -350,6 +350,10 @@ int vce_v1_0_start(struct radeon_device *rdev)
>  		return r;
>  	}
> =20
> +	/* enable the trap interrupt so that VCE fences are processed */
> +	WREG32_P(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN,
> +		 ~VCE_SYS_INT_TRAP_INTERRUPT_EN);

[Severity: High]
Does writing VCE_SYS_INT_EN unconditionally in vce_v1_0_start() access the
wrong MMIO register offset on CIK (VCE 2.0) hardware?

In drm/radeon, VCE 2.0 reuses vce_v1_0_init() and vce_v1_0_start() during
startup, resume, and dynamic powergating transitions:

drivers/gpu/drm/radeon/cik.c:cik_vce_resume() {
	...
	r =3D vce_v1_0_init(rdev);
}

drivers/gpu/drm/radeon/kv_dpm.c:kv_dpm_powergate_vce() {
	...
		if (pi->caps_vce_pg) {
			kv_notify_message_to_smu(rdev, PPSMC_MSG_VCEPowerON);
			vce_v2_0_resume(rdev);
			vce_v1_0_start(rdev);
		}
}

Because drivers/gpu/drm/radeon/vce_v1_0.c includes sid.h, VCE_SYS_INT_EN
evaluates to the VCE 1.0 byte offset 0x20d00 here. On VCE 2.0, however,
VCE_SYS_INT_EN is at byte offset 0x21300 in drivers/gpu/drm/radeon/cikd.h
(where offset 0x20d00 falls within the VCE 2.0 UENC register range), and
VCE 2.0 already enables VCE_SYS_INT_TRAP_INTERRUPT_EN at 0x21300 inside
vce_v2_0_resume() in drivers/gpu/drm/radeon/vce_v2_0.c:

drivers/gpu/drm/radeon/vce_v2_0.c:vce_v2_0_resume() {
	...
	WREG32_P(VCE_LMI_CTRL2, 0x0, ~0x100);

	WREG32_P(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN,
		 ~VCE_SYS_INT_TRAP_INTERRUPT_EN);

	vce_v2_0_init_cg(rdev);
}

Should this register write be placed in vce_v1_0_resume() (matching
vce_v2_0_resume()), or guarded so it is only executed on VCE 1.0 hardware?

> +
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021114122.9400=
8-1-mptagliari@gmail.com?part=3D2
