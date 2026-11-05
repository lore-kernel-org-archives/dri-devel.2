Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C75606B451
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYTWZRgz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C0411285C;
	Thu,  5 Nov 2026 15:53:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D3F11286D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8797542E87;
 Thu,  5 Nov 2026 15:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA81F000C1;
 Thu,  5 Nov 2026 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793894033;
 bh=SHBA1vqD/9luhzV9mQ1L/1X7uLuP80RiS5qXE97Uokg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KYTWZRgzcrBJ1sHB5lCHA2r5dI2XkE0TSPqUYZeHDdXZzGYL6SsmdyTDIGSon4i3i
 j08Gzjoefd1KE43zZb1HxSW5jzamd5JhzNMpFrVP4Ak5pb3Q13PEitWzEIb3d++/Z3
 1upOaqBZv8AB+UtFDGqek/gLtxJ9mYVkWmEh2a+wExJhtJELPNvVrWzRR8o8s2jFx/
 bElS9+L5WB6484jhosibgfe138mGNGMhzM0WLI5JA1iFDTNap5CYUVDbvrvAYyGEGt
 KsM4bCKtlMkUtfryLG97x+d9/vLMLhjEp9uyaV6+V1y5xeIm3vydNEZ/vUGqkTDqtS
 nbNBxpJuj9gSw==
Message-ID: <sashiko-outbox-199365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] drm/msm/a6xx: Reset the GMU state when restoring
 from hibernation
To: "Abel Vesa" <abel.vesa@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-b4-drm-msm-a6xx-rsc-restore-hibernation-v1-1-3250fd8eefb6@oss.qualcomm.com>
References: <20261103-b4-drm-msm-a6xx-rsc-restore-hibernation-v1-1-3250fd8eefb6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:53:52 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/msm/a6xx: missing RSCC/PDC and ACD reinit in a6xx_gmu_power_cy=
cled()
- [High] drm/msm/a6xx: stale static loaded flag in a6xx_zap_shader_init() o=
n restore
- [High] drm/msm/a6xx: unconditional PDC_SLEEP clear in a6xx_gmu_power_cycl=
ed()
--

commit 491412dbdff3368cc8067f8c98101632e337bedb
Author: Abel Vesa <abel.vesa@oss.qualcomm.com>

drm/msm/a6xx: Reset the GMU state when restoring from hibernation

This commit adds a power_cycled callback invoked from adreno_system_restore=
()
to clear GMU_STATUS_PDC_SLEEP and GMU_STATUS_SECURE_INIT when restoring from
hibernation so that the GMU restarts as it does after probe.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..1e6e47b635f08 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1319,6 +1319,16 @@ static int a6xx_gmu_gxpd_put(struct a6xx_gmu *gmu)
>  	return 0;
>  }
> =20
> +/*
> + * After a power cycle the RSC does not expect a wakeup request and the =
GMU
> + * secure init is gone, so start the GMU like after probe.
> + */
> +void a6xx_gmu_power_cycled(struct a6xx_gpu *a6xx_gpu)
> +{
> +	clear_bit(GMU_STATUS_PDC_SLEEP, &a6xx_gpu->gmu.status);

[Severity: High]
Is it always safe to unconditionally clear GMU_STATUS_PDC_SLEEP and assume a
cold boot on every restore transition?

If the boot kernel that loads the hibernation image opens the DRM device
(for example via an initramfs splash screen calling
msm_open() -> adreno_load_gpu() -> a6xx_gmu_resume()), it boots the GMU,
sets REG_A7XX_CX_MISC_TCM_RET_CNTL =3D 1 or REG_A6XX_GMU_GENERAL_7 =3D 1, a=
nd
then suspends the GPU during runtime suspend or
dpm_suspend_start(PMSG_QUIESCE) -> adreno_system_suspend() ->
a6xx_gmu_stop() -> a6xx_rpmh_stop(), which puts the hardware GPU RSC into
sleep mode. The same RSC sleep state also remains in effect when
adreno_system_restore() runs without a power cycle, such as during
HIBERNATION_TEST_RESUME or when hibernation_platform_enter() aborts after
dpm_suspend_start(PMSG_HIBERNATE) and rolls back via PMSG_RESTORE.

When a6xx_gmu_power_cycled() clears GMU_STATUS_PDC_SLEEP in those cases,
a6xx_rpmh_start() will return early without waking the sleeping RSC:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_rpmh_start() {
	if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
		return 0;
}

Additionally, if the loader kernel booted the GMU prior to quiesce,
a6xx_gmu_resume() in the restored kernel will still read 1 from
REG_A7XX_CX_MISC_TCM_RET_CNTL or REG_A6XX_GMU_GENERAL_7 and select
GMU_WARM_BOOT, skipping a6xx_gmu_fw_load() in a6xx_gmu_fw_start():

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_resume() {
	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
		status =3D a6xx_cx_misc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL) =3D=
=3D 1 ?
			GMU_WARM_BOOT : GMU_COLD_BOOT;
	} else if (gmu->legacy) {
		status =3D gmu_read(gmu, REG_A6XX_GMU_GENERAL_7) =3D=3D 1 ?
			GMU_WARM_BOOT : GMU_COLD_BOOT;
	...
}

Should this check the hardware RSC status (or re-initialize the hardware
state) and ensure a cold boot so that GMU firmware is reloaded and the RSC
state matches?

> +	clear_bit(GMU_STATUS_SECURE_INIT, &a6xx_gpu->gmu.status);
> +}

[Severity: High]
Does a6xx_gmu_power_cycled() also need to re-run the RSCC/PDC and ACD probe-
time initialization when restoring from hibernation?

The callback is wired into a6xx_gpu_funcs, a7xx_gpu_funcs, and
a8xx_gpu_funcs. When the kernel that loads the hibernation image has not
probed the msm driver, the hibernation power cycle resets RSCC, PDC, and AO=
SS
state to power-on defaults. During initial probe, a6xx_gmu_init() runs both
a6xx_gmu_acd_probe() and a6xx_gmu_rpmh_init():

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_init() {
	ret =3D a6xx_gmu_acd_probe(gmu);
	if (ret)
		goto detach_gxpd;

	/* Set up the HFI queues */
	a6xx_hfi_init(gmu);

	/* Initialize RPMh */
	a6xx_gmu_rpmh_init(gmu);
}

On A6xx and A7xx (unlike A8xx where AOP configures RSCC and PDC),
a6xx_gmu_rpmh_init() programs the RSCC-PDC handshake registers, loads the
RSCC sequencer microcode, loads PDC sequencer microcode and TCS commands on
older targets, and enables the GPU PDC via REG_A6XX_PDC_GPU_ENABLE_PDC.
Similarly, a6xx_gmu_acd_probe() sends the QMP notification to AOSS:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_acd_probe() {
	ret =3D qmp_send(gmu->qmp, "{class: gpu, res: acd, val: %d}", !!cmd->enabl=
e_by_level);
}

Without re-running a6xx_gmu_rpmh_init() and re-notifying AOSS of the ACD
state before a6xx_gmu_resume() -> a6xx_hfi_start() -> a6xx_hfi_enable_acd()
enables HFI_FEATURE_ACD on the GMU, won't resume after hibernation leave
RSCC/PDC unprogrammed on A6xx/A7xx and leave AOSS with ACD disabled while
the GMU enables ACD?

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86da..962b497868daf 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2796,6 +2796,11 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_de=
vice *dev)
>  	return gpu;
>  }
> =20
> +static void a6xx_gpu_power_cycled(struct adreno_gpu *adreno_gpu)
> +{
> +	a6xx_gmu_power_cycled(to_a6xx_gpu(adreno_gpu));
> +}

[Severity: High]
What happens to the zap shader state in a6xx_zap_shader_init() after
a6xx_gpu_power_cycled() runs on hibernation restore?

Before hibernation, hw_init() in a6xx_gpu.c and a8xx_gpu.c calls
a6xx_zap_shader_init(), which loads the zap shader via
adreno_zap_shader_load(gpu, GPU_PAS_ID) and sets its static loaded flag to
true:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_zap_shader_init() {
	static bool loaded;
	int ret;

	if (loaded)
		return 0;

	ret =3D adreno_zap_shader_load(gpu, GPU_PAS_ID);

	loaded =3D !ret;
	return ret;
}

Across a hibernation power cycle, the no-map zap-shader memory region and
secure world PAS state are wiped (even if the loader kernel has msm in its
initramfs, unless the loader kernel also opened the DRM device to trigger
adreno_load_gpu() -> hw_init()). Because loaded remains true in the restored
kernel image, the next hw_init() sees a6xx_zap_shader_init() return 0
without reloading the zap shader and immediately emits CP_SET_SECURE_MODE:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
	ret =3D a6xx_zap_shader_init(gpu);
	if (!ret) {
		OUT_PKT7(gpu->rb[0], CP_SET_SECURE_MODE, 1);
		OUT_RING(gpu->rb[0], 0x00000000);

		a6xx_flush(gpu, gpu->rb[0]);
		if (!a6xx_idle(gpu, gpu->rb[0]))
			return -EINVAL;
	...
}

Won't CP_SET_SECURE_MODE fail or hang on A6xx, A7xx, and A8xx targets that
use a zap shader unless the zap shader is also reloaded (or shut down and
re-initialized via qcom_scm_pas_shutdown() / adreno_zap_shader_load()) acro=
ss
hibernation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-b4-drm-msm=
-a6xx-rsc-restore-hibernation-v1-1-3250fd8eefb6@oss.qualcomm.com?part=3D1
