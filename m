Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A0606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeNsn6Sp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C21910F33B;
	Tue, 24 Nov 2026 08:44:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EE510F338;
 Tue, 24 Nov 2026 08:44:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7728140A9E;
 Tue, 24 Nov 2026 08:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FCD1F000D4;
 Tue, 24 Nov 2026 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795509862;
 bh=Uno6cz/C9VCajFHjx36evDu1cZ1/XheOtk2U4mB1NfU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NeNsn6Spf/y3iyEUL0EqTqB7UsHG5oJW3KUSEl7KNocf9WaVp82h1ompGdEwwHsGi
 K8x5KJu3GKtmq6t59u6VJCKx7H7AVbyT1OaZm7fx3sUjxw5DlNRCoL6vXaFbFp1ngR
 rc31sWIQVUKO7kvm+Ip39RNsSGEROhhRgxP0gRWDqfkNcu/PhKVI9aspmvcLk+M18a
 emU1BBfwg4uH2TqsTq8iov72zG8uI+km0anLl1WBO4tQyuZxMcsK9L6vM4l8JVfEIv
 eQYvhqkWbdV2Jcun1eJfexDiuayugyqZem4CgXdTod7ABRbvbNTNJLrucomFGpDG6r
 D8ROX6LXLsB2Q==
Message-ID: <sashiko-outbox-230735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix wrong unit of vf2pf_work delay
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261123175513.2144018-1-ekffu200098@gmail.com>
References: <20261123175513.2144018-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:44:21 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/amdgpu: uncanceled vf2pf_work in
  amdgpu_virt_fini_data_exchange() [1]
--

commit a187e6fa4054f858fa9ab261be0ca76b1509f22d
Author: Sang-Heon Jeon <ekffu200098@gmail.com>

drm/amdgpu: fix wrong unit of vf2pf_work delay

This commit converts adev->virt.vf2pf_update_interval_ms to jiffies via
msecs_to_jiffies() when rescheduling adev->virt.vf2pf_work in
amdgpu_virt_update_vf2pf_work_item().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 915e2a069bafb..f93d5df51528c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -797,7 +797,8 @@ static void amdgpu_virt_update_vf2pf_work_item(struct=
 work_struct *work)
>  	amdgpu_virt_write_vf2pf_data(adev);
> =20
>  out:
> -	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update=
_interval_ms);
> +	schedule_delayed_work(&(adev->virt.vf2pf_work),
> +			      msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
>  }
> =20
>  static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device =
*adev, uint32_t *pfvf_data)

[Severity: Critical]
This problem wasn't introduced by this patch, but can [1] leave
adev->virt.vf2pf_work running after amdgpu_virt_fini_data_exchange() if
amdgpu_virt_read_pf2vf_data() fails?

amdgpu_virt_init_data_exchange() resets adev->virt.vf2pf_update_interval_ms
to 0, calls amdgpu_virt_exchange_data() -> amdgpu_virt_read_pf2vf_data()
without checking its return value, and schedules adev->virt.vf2pf_work:

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:amdgpu_virt_fini_data_exchange() {
	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
		dev_info(adev->dev, "clean up the vf2pf work item\n");
		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
		adev->virt.vf2pf_update_interval_ms =3D 0;
	}
}

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:amdgpu_virt_init_data_exchange() {
    ...
	adev->virt.vf2pf_update_interval_ms =3D 0;
    ...
	} else if (fw_va || drv_va) {
		/* go through this logic in ip_init and reset to init workqueue*/
		amdgpu_virt_exchange_data(adev);

		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->vi=
rt.vf2pf_update_interval_ms));
    ...
}

When PF2VF header validation fails in amdgpu_virt_read_pf2vf_data(),
vf2pf_update_interval_ms stays 0 while vf2pf_work is scheduled and
rescheduled here with a zero delay.  Because
amdgpu_virt_fini_data_exchange() only cancels vf2pf_work when
vf2pf_update_interval_ms is non-zero, teardown leaves the delayed work
running in a tight zero-delay loop, leading to accesses to unmapped VRAM and
a use-after-free on struct amdgpu_device.

[1] https://sashiko.dev/#/bug/linux-904ad1aa-33f1-44b8-a83c-632c07b49537

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123175513.2144=
018-1-ekffu200098@gmail.com?part=3D1
