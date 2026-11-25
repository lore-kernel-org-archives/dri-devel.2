Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D060606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFv3l5v/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC7C10FBF8;
	Wed, 25 Nov 2026 12:01:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A06210FC10
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:01:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E941433A6;
 Wed, 25 Nov 2026 12:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E062E1F000C4;
 Wed, 25 Nov 2026 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795608064;
 bh=N4joVoBiz/ir9vVc1V/rIpApgnqHdAUPXfgXv0EnXXg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WFv3l5v/1BvGLzQgEuB/PLroU3wEq1LUM3KLO69Feec7g4vuiCjCkh8QrGimsBPvH
 74tyqnjhsucM1AW8c8TqhF948a+DZc0azeTQ3Y5F0VcONtop4v3r+JSwT9CLYLLnLu
 /kbq5UwliZgD7ykjeHdUo5i3/MLdol9sxzY/Qj8kXDkH6IWVXYYUO2XUmS1g86hfHu
 fJ9aSjejqnKd1grZt4aO6ngjXk9kNTmVB0a+Z7mi1G4OroEInBf6f4B5hfud4jdLQX
 RI8jCY/PCmpDygCMTiWoqFq2sU9ga/EpkdKoReP+lVdjL1DNr/lxihcDM1Vk0QI0Pi
 WqR6R0WryqBfg==
Message-ID: <sashiko-outbox-233320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/imagination: Save metadata from firmware
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
 <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:01:03 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/imagination: undefined pvr_exp_fw_support and broken
  version check
- [Medium] drm/imagination: signed offset bypasses size check in
  pvr_fw_load_metadata()
- [Medium] drm/imagination: metadata leak on error paths in
  pvr_device_gpu_init()
- [Medium] drm/imagination: UAF and NULL deref of metadata in
  pvr_fw_info_get()
- [Low] drm/imagination: misplaced closing parenthesis in drm_err()
  format strings
--

commit 61d39e2fd09561a4d18973b66a4042a907478335
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Save metadata from firmware

This commit extracts firmware version and section layout metadata from the
firmware header into an allocated pvr_fw_metadata structure.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagi=
nation/pvr_fw.c
> index cbde54c7291c7..2a5dcd9aeed71 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c

[ ... ]

> @@ -1549,8 +1387,8 @@ pvr_fw_info_get(const struct pvr_device *pvr_dev,
>  	if (fw_info._padding_4)
>  		return -EINVAL;
> =20
> -	fw_info.major_version =3D pvr_dev->fw_version.major;
> -	fw_info.minor_version =3D pvr_dev->fw_version.minor;
> +	fw_info.major_version =3D pvr_dev->fw_dev.metadata->version.major;
> +	fw_info.minor_version =3D pvr_dev->fw_dev.metadata->version.minor;
> =20
>  	err =3D PVR_UOBJ_SET(args->pointer, args->size, fw_info);
>  	if (err < 0)

[Severity: Medium]
Can this dereference a freed or NULL pvr_dev->fw_dev.metadata during
device removal?

Previously, pvr_fw_info_get() read pvr_dev->fw_version, which was embedded
in struct pvr_device.  Because pvr_remove() runs pvr_device_fini() before
drm_dev_unplug(), a concurrent DRM_IOCTL_PVR_DEV_QUERY passes
drm_dev_enter() and can race with pvr_fw_free_metadata_and_device_info():

CPU0                                     CPU1
pvr_remove()
  pvr_device_fini()
    pvr_device_gpu_fini()
      pvr_fw_free_metadata_and_device_info()
        kfree(pvr_dev->fw_dev.metadata)
        pvr_dev->fw_dev.metadata =3D NULL
                                         pvr_ioctl_dev_query()
                                           drm_dev_enter()
                                           pvr_fw_info_get()
                                             ...->metadata->version.major
                                             <-- NULL deref / use-after-free
  drm_dev_unplug()

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_info.c b/drivers/gpu/drm/=
imagination/pvr_fw_info.c
> new file mode 100644
> index 0000000000000..2e7e9fb291b35
> --- /dev/null
> +++ b/drivers/gpu/drm/imagination/pvr_fw_info.c
> @@ -0,0 +1,338 @@

[ ... ]

> +static bool
> +pvr_fw_load_version(struct pvr_device *pvr_dev,
> +		    const struct pvr_fw_info_header *header,
> +		    struct pvr_fw_version *version_out)
> +{
> +	struct drm_device *drm_dev =3D from_pvr_device(pvr_dev);
> +	bool invalid =3D false;
> +
> +	struct pvr_fw_version version =3D {
> +		.major =3D header->fw_version_major,
> +		.minor =3D header->fw_version_minor,
> +		.build =3D header->fw_version_build,
> +		.open_source =3D header->flags & PVR_FW_FLAGS_OPEN_SOURCE,
> +	};
> +
> +	if (!version.open_source) {
> +		drm_err(drm_dev, "Firmware is not open-source compatible (found versio=
n " PVR_FW_VERSION_FMT ")\n",
> +			PVR_FW_VERSION_FMT_ARGS(&version));
> +		invalid =3D true;
> +	}
> +
> +	if (version.major =3D=3D 0 ||
> +	    (version.major > PVR_FW_MAX_SUPPORTED_MAJOR_VERSION && !pvr_exp_fw_=
support) ||
> +	    (version.major !=3D PVR_FW_MAX_SUPPORTED_MAJOR_VERSION && pvr_exp_f=
w_support)) {

[Severity: High]
Where is pvr_exp_fw_support defined?  It is declared extern in pvr_fw.h,
but nothing in the tree defines it, so building with CONFIG_DRM_POWERVR
fails at link/modpost time with an undefined symbol.

Also, when pvr_exp_fw_support is true, the condition
(version.major !=3D PVR_FW_MAX_SUPPORTED_MAJOR_VERSION && pvr_exp_fw_suppor=
t)
rejects every major version other than PVR_FW_MAX_SUPPORTED_MAJOR_VERSION,
preventing experimental major versions (> PVR_FW_MAX_SUPPORTED_MAJOR_VERSIO=
N)
from loading.

> +		drm_err(drm_dev, "Firmware version is unsupported (known range is 1..%=
u inclusive, found "
> +				 PVR_FW_VERSION_FMT ")\n",
> +			PVR_FW_MAX_SUPPORTED_MAJOR_VERSION,
> +			PVR_FW_VERSION_FMT_ARGS(&version));
> +		invalid =3D true;
> +	}
> +
> +	if (invalid)
> +		return false;
> +
> +	*version_out =3D version;
> +	return true;
> +}
> +
> +static int
> +pvr_fw_info_header_validate(struct pvr_device *pvr_dev,
> +			    const struct pvr_fw_info_header *header,
> +			    struct pvr_fw_version *fw_version_out)
> +{
> +	struct drm_device *drm_dev =3D from_pvr_device(pvr_dev);
> +	bool invalid =3D false;
> +
> +	if (header->info_version !=3D PVR_FW_INFO_VERSION) {
> +		drm_err(drm_dev,
> +			"Firmware version is unsupported (known version is %u, found %u)\n",
> +			PVR_FW_INFO_VERSION, header->info_version);
> +		return -EINVAL;
> +	}
> +
> +	if (header->header_len !=3D sizeof(struct pvr_fw_info_header)) {
> +		drm_err(drm_dev, "Firmware header size mismatch (found=3D%u, expected=
=3D%zu)\n)",
> +			header->header_len, sizeof(struct pvr_fw_info_header));
> +		return -EINVAL;
> +	}
> +
> +	if (!header->layout_entry_num || !header->layout_entry_size) {
> +		drm_err(drm_dev, "Firmware layout table missing\n");
> +		invalid =3D true;
> +	} else if (header->layout_entry_size !=3D sizeof(struct pvr_fw_layout_e=
ntry)) {
> +		drm_err(drm_dev,
> +			"Firmware layout table entry size mismatch (found=3D%u, expected=3D%z=
u)\n)",
> +			header->layout_entry_size, sizeof(struct pvr_fw_layout_entry));
> +		invalid =3D true;
> +	} else if (header->layout_entry_num > PVR_FW_INFO_MAX_NUM_ENTRIES) {
> +		drm_err(drm_dev, "Firmware layout table is too large (found=3D%u, max=
=3D%u)\n)",
> +			header->layout_entry_num, PVR_FW_INFO_MAX_NUM_ENTRIES);
> +		invalid =3D true;

[Severity: Low]
This isn't a bug, but these three drm_err() format strings end with "\n)"
instead of ")\n", putting a stray closing parenthesis on the next log line.

[ ... ]

> +static const struct pvr_fw_metadata *
> +pvr_fw_load_metadata(struct pvr_device *pvr_dev, ptrdiff_t *device_info_=
offset_out)
> +{
> +	const struct firmware *firmware =3D pvr_dev->fw_dev.firmware;
> +	struct drm_device *drm_dev =3D from_pvr_device(pvr_dev);
> +	const struct pvr_fw_layout_entry *layout_entries;
> +	const struct pvr_fw_info_header *header;
> +	struct pvr_fw_version fw_version;
> +	const void *fw =3D firmware->data;
> +	struct pvr_fw_metadata *meta;
> +	ptrdiff_t header_offset;
> +	int err;
> +
> +	if (check_sub_overflow(firmware->size, FW_BLOCK_SIZE, &header_offset)) {
> +		drm_err(drm_dev, "Firmware is smaller than one block\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (firmware->size % FW_BLOCK_SIZE) {
> +		drm_err(drm_dev, "Firmware size is not block-aligned\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	header =3D fw + header_offset;
> +
> +	err =3D pvr_fw_info_header_validate(pvr_dev, header, &fw_version);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	layout_entries =3D fw + header_offset + header->header_len;
> +
> +	meta =3D kzalloc_flex(*meta, sections, header->layout_entry_num);
> +	if (!meta)
> +		return ERR_PTR(-ENOMEM);
> +
> +	meta->version =3D fw_version;
> +	meta->num_sections =3D header->layout_entry_num;
> +
> +	for (int i =3D 0; i < header->layout_entry_num; i++) {
> +		err =3D pvr_fw_section_desc_for_layout_entry(pvr_dev,
> +							   &layout_entries[i],
> +							   &meta->sections[i]);
> +		if (err)
> +			goto err_free_meta;
> +	}
> +
> +	*device_info_offset_out =3D header_offset - header->device_info_size;

[Severity: Medium]
Can header_offset and *device_info_offset_out become negative here and
read before firmware->data?

Because header_offset is a signed ptrdiff_t, check_sub_overflow() checks
whether firmware->size - FW_BLOCK_SIZE fits in a signed ptrdiff_t.  When
firmware->size is 0, check_sub_overflow() returns false with header_offset
set to -4096, firmware->size % FW_BLOCK_SIZE is 0, and header =3D fw +
header_offset points 4096 bytes before firmware->data.

Similarly, subtracting header->device_info_size from header_offset into a
signed ptrdiff_t without checking header->device_info_size <=3D header_offs=
et
lets firmware->data + device_info_offset underflow before firmware->data.
Making the offsets size_t (and using check_sub_overflow() for both) would
catch both underflows.

[ ... ]

> +int
> +pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev)
> +{
> +	const struct firmware *firmware =3D pvr_dev->fw_dev.firmware;
> +	const struct pvr_fw_metadata *metadata;
> +	ptrdiff_t device_info_offset =3D 0;
> +
> +	metadata =3D pvr_fw_load_metadata(pvr_dev, &device_info_offset);
> +	if (IS_ERR(metadata))
> +		return PTR_ERR(metadata);
> +
> +	pvr_dev->fw_dev.metadata =3D metadata;
> +
> +	return pvr_fw_get_device_info(pvr_dev, firmware->data + device_info_off=
set);
> +}

[Severity: Medium]
Does this leak pvr_dev->fw_dev.metadata if pvr_fw_get_device_info() or a
later step in pvr_device_gpu_init() fails?

pvr_fw_load_metadata_and_device_info() does not free metadata when
pvr_fw_get_device_info() returns an error, and on later failures in
pvr_device_gpu_init() (such as pvr_device_info_validate() or
pvr_fw_init()), pvr_device_init() jumps past pvr_device_gpu_fini() without
calling pvr_fw_free_metadata_and_device_info().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-b4-commoni=
ze-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com?part=3D3
