Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26884606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmW1vQ9Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5EA10E7D1;
	Mon, 23 Nov 2026 13:47:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D7810E7D1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:47:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F0FB43E5C;
 Mon, 23 Nov 2026 13:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12091F000CA;
 Mon, 23 Nov 2026 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795441647;
 bh=h1J6ES90Ui+125Ezoufs+mkbEvU0WCcZ9YzsdwLAzoE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=MmW1vQ9Q4pdQkjWW9lb+wCVb4gcyLaNlXdoA10AwwnUA67osPbBz5DOAhtYckaaxC
 RV4rKalLyusYVtFXAn4DAWC9OybQy3gAKdLtYIL9Z3UuAO+uh416ST5n2sW0hgk/q2
 V3ToKN4LssUKS03V3P8EXALS0bVUZrehPE/S3Q1fOE5eKqhiszSm4xePw+NHZx4B1d
 sDAJ7Bl9kD8Ryi0+VV0YYzN8JNKPFBXMQu6I5hLTiLFMJUP9PGSCLWBBM0chgzRUbt
 AAhMGDdSqzX0PM5ot5nM24kRiO2rkk5NcYZMef79+mWndVBgdi4COftMokBPeDr31L
 jOwxzg1HHITaw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 14:47:24 +0100
Message-Id: <DN2MY0QDBWUK.2F9NT145RIG9B@kernel.org>
Subject: Re: [PATCH v2 1/3] drm/nouveau/nvkm: fix device leak on ctor failure
Cc: <sashiko-reviews@lists.linux.dev>, "Dave Airlie" <airlied@redhat.com>,
 "Lyude Paul" <lyude@redhat.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
To: <sashiko-bot@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-1-5e8c27aa8555@redhat.com>
 <sashiko-outbox-228586@kernel.org>
In-Reply-To: <sashiko-outbox-228586@kernel.org>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 23, 2026 at 4:14 AM CET, sashiko-bot wrote:
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers=
/gpu/drm/nouveau/nvkm/engine/device/base.c
>> index a2ed8c4fe52a0..625bb019736af 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
>> @@ -3152,10 +3152,19 @@ nvkm_device_ctor(const struct nvkm_device_func *=
func,
>>  	unsigned chipset;
>> =20
>>  	mutex_lock(&nv_devices_mutex);
>> +
>> +	/* Set up the state that nvkm_device_del() relies on before anything
>> +	 * that can fail, so that a device whose construction failed can be
>> +	 * cleaned up by the caller with nvkm_device_del().
>> +	 */
>> +	device->func =3D func;
>> +	INIT_LIST_HEAD(&device->head);
>> +	INIT_LIST_HEAD(&device->subdev);
>> +	nvkm_intr_ctor(device);
>> +
>>  	if (nvkm_device_find_locked(handle))
>>  		goto done;
>> =20
>> -	device->func =3D func;
>>  	device->quirk =3D quirk;
>>  	device->dev =3D dev;
>
> [Severity: Medium]
> Should device->dev =3D dev also be set before nvkm_device_find_locked()?
>
> If nvkm_device_find_locked() returns an existing device on Tegra,
> nvkm_device_tegra_new() now calls nvkm_device_del(), which runs
> nvkm_device_tegra_dtor() -> nvkm_device_tegra_remove_iommu():
>
> drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:nvkm_device_tegra_remo=
ve_iommu() {
> 	if (tdev->iommu.domain) {
> 		nvkm_mm_fini(&tdev->iommu.mm);
> 		iommu_detach_device(tdev->iommu.domain, tdev->device.dev);
> 		iommu_domain_free(tdev->iommu.domain);
> 	}
> }
>
> Because nvkm_device_tegra_probe_iommu() has already attached
> tdev->iommu.domain before calling nvkm_device_ctor(), leaving
> tdev->device.dev as NULL causes a NULL pointer dereference inside
> iommu_detach_device().

I think Sashiko is right about this, but having an API contract that relies=
 on a
struct being partially initialized on failure isn't great at all.

I think nvkm_device_tegra_remove_iommu() should just not rely on struct
nvkm_device being initialized. struct nvkm_device_tegra already stores stru=
ct
platform_device, so I think we can just use &tdev->pdev.dev in
nvkm_device_tegra_remove_iommu().

More generally, can't we keep the semantics of nvkm_device_ctor() to clean =
up
after itself and not guarantee partial initialization to reuse
nvkm_device_del()?
