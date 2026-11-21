Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BA606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYOcGKhm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD9C10E152;
	Sat, 21 Nov 2026 15:37:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E87D10E152
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 15:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F56A456E6;
 Sat, 21 Nov 2026 15:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17AD1F000C4;
 Sat, 21 Nov 2026 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795275431;
 bh=/82KGfCWW5UG41C19iL5virbHYRpL9AoNA3YwbosnQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PYOcGKhmprJS1y+gcgiH1ZiH+oZp2iI9w7bXYVymNkrrbZuqP9SM4PRZ8th7v2X/h
 r7XVzerCLukeQn8Yfk3pn9HIqNYMOnn0vde0tv0oJZIjIJRPznj7X+j6+bBawYuE4/
 lqrOGlHsyRkjnYx4OeyupOtgJDhVfuzwV1R3963wkKjX2mdjVO6AACW3k4DH4Uotkf
 139HZr3zod25PDyX3iDRBp6m2O5AF9GxULcCO8/gc14KhZQgdhL3PWK9632Gy/1Ut+
 9dcDukDH0PZTbKLPjyblXv1fzqJtV5npo+B+tBGQ9vg574vV/4q35pNWenZe6n1HOc
 np3SMKzRLFc2Q==
Message-ID: <sashiko-outbox-227129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Destroy the common FW object when HWRT
 data setup fails
To: "Suyuan Wang" <shyckless@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261121-pvr-hwrt-common-v1-1-784ce45b782a@gmail.com>
References: <20261121-pvr-hwrt-common-v1-1-784ce45b782a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 15:37:10 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/imagination: Fixes tag in pvr_hwrt_dataset_create() cites
  wrong commit
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/imagination: max_rts truncation in
  hwrt_init_kernel_structure() leaks BOs [1]
--

commit 7873fa00db9c4a0975eb336899ecacbc6e6d2863
Author: Suyuan Wang <stevewong@hust.edu.cn>

> drm/imagination: Destroy the common FW object when HWRT data setup fails
>
> If hwrt_data_init_fw_structure() fails in pvr_hwrt_dataset_create(),
> the error path frees the per-data FW structures and then jumps straight
> to err_fini_kernel_structure, skipping hwrt_fini_common_fw_structure().
> The common FW object created just before is never destroyed, and its
> init callback data is the hwrt that is then freed:
>
>         err =3D pvr_fw_object_create(pvr_dev, ...,
>                                    hwrtdata_common_init, hwrt,
>                                    &hwrt->common_fw_obj);
>
> Besides leaking the object, this leaves it on the device's FW object
> list, so a later pvr_fw_hard_reset() calls hwrtdata_common_init() with
> the freed hwrt, and pvr_fw_fini() warns that the list is not empty.
>
> Destroy the common FW object on that path, in the same order as
> pvr_hwrt_dataset_release().
>
> Found with a static analysis tool and checked by hand.
>
> Fixes: 6eedddab733b ("drm/imagination: Implement free list and HWRT creat=
e and destroy ioctls")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>

[Severity: Low]
In 6eedddab733b ("drm/imagination: Implement free list and HWRT create and
destroy ioctls"), a failure in hwrt_data_init_fw_structure() jumped to
err_free and called pvr_hwrt_dataset_put(), which destroyed common_fw_obj
via pvr_hwrt_dataset_release().  The err_fini_data_structures unwind path
that omitted hwrt_fini_common_fw_structure() was introduced by
f1f55ed3ffe4 ("drm/imagination: Fixed oops when misusing ioctl
CREATE_HWRT_DATASET").  Should the Fixes tag be:

  Fixes: f1f55ed3ffe4 ("drm/imagination: Fixed oops when misusing ioctl CRE=
ATE_HWRT_DATASET")

> diff --git a/drivers/gpu/drm/imagination/pvr_hwrt.c b/drivers/gpu/drm/ima=
gination/pvr_hwrt.c
> index 05c68c78da229..6057f8dd1eaf4 100644
> --- a/drivers/gpu/drm/imagination/pvr_hwrt.c
> +++ b/drivers/gpu/drm/imagination/pvr_hwrt.c
> @@ -487,6 +487,8 @@ pvr_hwrt_dataset_create(struct pvr_file *pvr_file,
>  	while (--i >=3D 0)
>  		hwrt_data_fini_fw_structure(hwrt, i);
> =20
> +	hwrt_fini_common_fw_structure(hwrt);
> +
>  err_fini_kernel_structure:
>  	hwrt_fini_kernel_structure(hwrt);

[Severity: High]
This problem wasn't introduced by this patch, but can
hwrt_data_fini_fw_structure() still leak raa_obj and srtc_obj [1]
when args->layers is truncated into hwrt->max_rts?

hwrt_init_kernel_structure() stores the 32-bit args->layers into the u16
hwrt->max_rts field without bounds checking, while
hwrt_data_init_fw_structure() checks the untruncated args->layers:

drivers/gpu/drm/imagination/pvr_hwrt.c:hwrt_data_init_fw_structure() {
	...
	if (args->layers > 1) {
		err =3D pvr_fw_object_create(pvr_dev, args->layers * SRTC_ENTRY_SIZE,
					   PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
					   NULL, NULL, &hwrt_data->srtc_obj);
		...
		err =3D pvr_fw_object_create(pvr_dev, args->layers * RAA_ENTRY_SIZE,
					   PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
					   NULL, NULL, &hwrt_data->raa_obj);
	...
}

drivers/gpu/drm/imagination/pvr_hwrt.c:hwrt_data_fini_fw_structure() {
	...
	if (hwrt->max_rts > 1) {
		pvr_fw_object_destroy(hwrt_data->raa_obj);
		pvr_fw_object_destroy(hwrt_data->srtc_obj);
	}
	...
}

If userspace passes args->layers =3D 0x10000 or 0x10001, srtc_obj and
raa_obj are allocated because args->layers > 1, but hwrt->max_rts is
truncated to 0 or 1, so hwrt_data_fini_fw_structure() skips destroying
both firmware objects on error unwind or dataset release.

[1] https://sashiko.dev/#/bug/linux-39ffd81d-e0f1-4965-a087-efaa05fc6db9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-pvr-hwrt-c=
ommon-v1-1-784ce45b782a@gmail.com?part=3D1
