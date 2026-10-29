Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D2606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Id/qWIiq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1199510E5A8;
	Thu, 29 Oct 2026 15:37:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E304310E5A8
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:37:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC5C44390A;
 Thu, 29 Oct 2026 15:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691FB1F01816;
 Thu, 29 Oct 2026 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793288245;
 bh=XiWL48cwAtt0i4/ejVmoy6+HI3x6mYlikCBUXPMVz+E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Id/qWIiqVdP13KQV6YDDXjTkx4Aq+i2EB5xVGj2HnatGfqHPnXrLzWmXWbbR4WYlH
 hdFNvJcM7VVXK83tljkRcwEG/p8I5hbxVS71iTjvCB9vd62YiN0c/ponk78tavwyTx
 rOqeXp/5hAVz3BM9T4Bn2sgEgBrjoXZ2E8HdbJSR1bU0QRc3R0H3RVAFhratp8eZYp
 eNpLgLNEBt7ZWEbQGjsvML6v8QZ9E79Q8/eUgqWdVENqrhZzePtU3jEkatI52bp5Rq
 4z+XIs+VI8iuWhSgIbI1668+oscrIjxK1TDbaoqpKZnn1/RXKYJyndGlz0GNtHNhnW
 +ce41ph0CSUhA==
Message-ID: <sashiko-outbox-189620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add gpu_recovery_enabled flag to
 amdgpu_device
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029152000.22001-2-pierre-eric.pelloux-prayer@amd.com>
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:37:24 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: gpu_recovery_enabled left false in amdgpu_device_ini=
t()
- [Medium] drm/amdgpu: per-device gpu_recovery_enabled ignored in userq and=
 KFD resets
--

commit 86b9554fae60bb7deeb057b1bff4576f147cba44
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: add gpu_recovery_enabled flag to amdgpu_device

This commit adds a per-device gpu_recovery_enabled boolean to struct
amdgpu_device and exposes it via the amdgpu_gpu_recover debugfs file to
control automatic GPU recovery independently of the global
amdgpu.gpu_recovery module parameter. It also updates
amdgpu_device_should_recover_gpu() to check this flag.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 92cc0fa7ba33b..3658e46141ada 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4149,6 +4149,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
> =20
> +	adev->gpu_recovery_enabled =3D true;
> +
>  fence_driver_init:
>  	/* Fence driver */
>  	r =3D amdgpu_fence_driver_sw_init(adev);

[Severity: Medium]
Does placing the initialization of adev->gpu_recovery_enabled before the
fence_driver_init label leave it false when amdgpu_emu_mode =3D=3D 1?

Earlier in amdgpu_device_init(), the emulation mode path jumps directly to
fence_driver_init:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_init() {
	...
	if (amdgpu_emu_mode =3D=3D 1) {
		/* post the asic on emulation mode */
		emu_soc_asic_init(adev);
		goto fence_driver_init;
	}
	...
}

Because struct amdgpu_device is zero-allocated in amdgpu_pci_probe() via
devm_drm_dev_alloc(), jumping to fence_driver_init bypasses setting
adev->gpu_recovery_enabled =3D true. As a result,
amdgpu_device_should_recover_gpu() will treat GPU recovery as disabled
during amdgpu_device_ip_init() -> amdgpu_get_soft_full_reset_mask() and on
runtime hangs. Subsequent commits in this series do not adjust this
placement.

Should adev->gpu_recovery_enabled =3D true be moved after the
fence_driver_init label (or before the goto fence_driver_init)?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index bff2d38f3571a..c54ff34572b00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -980,9 +980,13 @@ static int amdgpu_debugfs_fence_info_show(struct seq=
_file *m, void *unused)
>  }
> =20
>  /*
> - * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
> + * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover,
> + * and control whether this device is allowed to auto-recover from a han=
g.
>   *
> - * Manually trigger a gpu reset at the next fence wait.
> + * Read triggers a gpu reset at the next fence wait.
> + *
> + * Write 0/1 to disable/enable auto GPU recovery for this device
> + * (equivalent to amdgpu.gpu_recovery=3D0, but scoped to this device onl=
y).
>   */
>  static int gpu_recover_get(void *data, u64 *val)
>  {
> @@ -1006,8 +1010,17 @@ static int gpu_recover_get(void *data, u64 *val)
>  	return 0;
>  }
> =20
> +static int gpu_recover_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +
> +	adev->gpu_recovery_enabled =3D !!val;
> +
> +	return 0;
> +}

[Severity: Medium]
The comment states that writing 0 to amdgpu_gpu_recover is equivalent to
amdgpu.gpu_recovery=3D0 scoped to this device, and later commits in this
series ("drm/amdgpu: honor gpu_recovery_enabled in amdgpu_job_timedout"
and "drm/amdgpu: add wedge event implementation") update
amdgpu_job_timedout() to check adev->gpu_recovery_enabled.

However, several other hang recovery and timeout paths only check the
global amdgpu_gpu_recovery variable and do not consult
adev->gpu_recovery_enabled or amdgpu_device_should_recover_gpu(adev):

1. Usermode queue hang detection and reset in
drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:

amdgpu_userq_hang_detect_work() {
	...
	if (!amdgpu_gpu_recovery)
		return;
	...
}

amdgpu_userq_mgr_reset_work() {
	...
	if (!amdgpu_gpu_recovery)
		return;
	...
	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
}

2. KFD queue and HWS hang resets in
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c within
remove_queue_mes_on_reset_option(), reset_queues_mes(), and
reset_queues_on_hws_hang(), which only check if (!amdgpu_gpu_recovery).

3. Timeout enablement checks in drivers/gpu/drm/amd/amdgpu/amdgpu.h:

static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device =
*adev)
{
	return amdgpu_gpu_recovery !=3D 0 &&
		adev->gfx_timeout !=3D MAX_SCHEDULE_TIMEOUT &&
	...
}

When a user writes 0 to amdgpu_gpu_recover while amdgpu.gpu_recovery
remains at its default non-zero value, should these userq, KFD, and
timeout helpers also check adev->gpu_recovery_enabled so that per-device
recovery is fully disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029152000.2200=
1-1-pierre-eric.pelloux-prayer@amd.com?part=3D2
