Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55C606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Poy43gBY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7100610FBF6;
	Wed, 25 Nov 2026 12:00:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFB110FBF6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:00:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BA9B6291F;
 Wed, 25 Nov 2026 12:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556011F000CF;
 Wed, 25 Nov 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795608014;
 bh=8xU8pe7v1ajfOGkshSSlloICMZKg//ySjf/N4Dymhs0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Poy43gBYUcZADQ3GCMwvZ9bYk4HJeJOGmTgSa5nm/J0E7ywtErYZwJPuTN7QgXNgf
 aXXyXDolqR62pFwBpma2neqoZqu1QlodTZcIDf+XJwyIXIYVQ4tyXEbKxZcZbEoU5z
 RY6azXGKFFWVIzbkp4KTJoMSQDp8k5N1dBZMfttoZgU0UMzVyQ73RUx+S+XKtsnOJ7
 QILlO5/B+Zgon7BSFbWtx6DlJRvsXnKI4s2nLBMretFWm113xSrFm5ccI/tjv/ovMX
 nbVCvQV/vMgjiANZhwI2GTC6BCQzXJSZRFP3fHWB91J8zmSZKLgzFk9Wm88mafduor
 0H9Hnof7BCoPA==
Message-ID: <sashiko-outbox-233318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/imagination: Generalize FW segment loading
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-5-69657fa52ac3@imgtec.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
 <20261125-b4-commonize-fw-segment-loading-v1-5-69657fa52ac3@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:00:13 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/imagination: missing pvr_fw_object_vunmap() on
  pvr_fw_process() error path
--

commit 77938768831abdc044ee8cfa1b2e3bb5e025c962
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Generalize FW segment loading

This commit replaces the per-segment firmware loading code and fields in
struct pvr_fw_mem with a segment descriptor table and an array of struct
pvr_fw_segment entries.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagi=
nation/pvr_fw.c
> index 4e082f83cff02..fbd46231f5803 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c
[ ... ]
> @@ -462,6 +426,76 @@ pvr_fw_destroy_structures(struct pvr_device *pvr_dev)
[ ... ]
> +static void
> +pvr_fw_destroy_segments(struct pvr_fw_segment segments[static PVR_FW_SEG=
MENT_COUNT])
> +{
> +	for (int i =3D PVR_FW_SEGMENT_COUNT - 1; i >=3D 0; i--) {
> +		struct pvr_fw_segment *segment =3D &segments[i];
> +
> +		if (segment->obj)
> +			pvr_fw_object_destroy(segment->obj);
> +		segment->obj =3D NULL;
> +
> +		kfree(segment->host_copy);
> +		segment->host_copy =3D NULL;
> +	}
> +}
[ ... ]
> @@ -492,142 +526,58 @@ pvr_fw_process(struct pvr_device *pvr_dev, const s=
truct firmware *firmware)
>  		return -EINVAL;
> =20
>  	/* Allocate and map memory for firmware sections. */
> +	for (int seg =3D 0; seg < PVR_FW_SEGMENT_COUNT; seg++) {
> +		const struct pvr_fw_segment_desc *desc =3D &pvr_fw_segment_descs[seg];
> +		struct pvr_fw_segment *segment =3D &fw_mem->segments[seg];
> +		void *host_ptr;
> +
> +		if (!segment->size) {
> +			if (desc->required) {
> +				drm_err(drm_dev, "Required FW segment '%s' is empty\n", desc->name);
> +				err =3D -EINVAL;
> +				goto err_out;
> +			}
> =20
> +			continue;
> +		}
> =20
> +		segment->host_copy =3D kzalloc(segment->size, GFP_KERNEL);
> +		if (!segment->host_copy) {
> +			err =3D -ENOMEM;
> +			goto err_out;
> +		}
> =20
> +		host_ptr =3D desc->create_and_map(pvr_dev, segment, private_data->base=
_addr);
> +		if (IS_ERR(host_ptr)) {
> +			drm_err(drm_dev, "Failed to allocate FW memory for segment '%s'\n",
> +				desc->name);
> +			err =3D PTR_ERR(host_ptr);
> +			goto err_out;
> +		}
> =20
> +		host_ptrs[seg] =3D host_ptr;
>  	}
> =20
> +	err =3D pvr_dev->fw_dev.defs->fw_process(pvr_dev, firmware, fw_mem->seg=
ments);
>  	if (err)
> +		goto err_out;
> +
> +	for (int seg =3D 0; seg < PVR_FW_SEGMENT_COUNT; seg++) {
> +		const struct pvr_fw_segment *segment =3D &fw_mem->segments[seg];
> +
> +		if (!segment->obj)
> +			continue;
> +
> +		memcpy(host_ptrs[seg], segment->host_copy, segment->size);
> +
> +		host_ptrs[seg] =3D NULL;
> +		pvr_fw_object_vunmap(segment->obj);
>  	}
> =20
>  	return 0;
> =20
> +err_out:
> +	pvr_fw_destroy_segments(fw_mem->segments);
> =20
>  	return err;
>  }

[Severity: Medium]
Does the err_out path in pvr_fw_process() miss calling
pvr_fw_object_vunmap() on segments that were already mapped by
desc->create_and_map()?

If a later segment allocation or defs->fw_process() fails,
pvr_fw_destroy_segments() destroys each segment->obj while its CPU mapping
in host_ptrs[seg] is still active.  Unlike the pre-patch cleanup path,
which called pvr_fw_object_vunmap() before pvr_fw_object_destroy(),
destroying the still-mapped GEM shmem object triggers drm_WARN_ON() in
drm_gem_shmem_release() and leaks the vmap mapping and pinned backing
pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-b4-commoni=
ze-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com?part=3D5
