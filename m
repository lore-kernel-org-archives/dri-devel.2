Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDE606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=SQtlCjHn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A2D10FAF6;
	Wed,  4 Nov 2026 10:21:03 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9179A10FAEC;
 Wed,  4 Nov 2026 10:20:56 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48MHHC847975; Wed, 4 Nov 2026 10:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=U
 tP/w+8CZKUBmjiZQ5cF+a0XCQWIrkCl0ZsmQyevkZs=; b=SQtlCjHnqa7okZm9o
 XGDfa5QfS8BLddET2HKXATMXx5E5Pfh3WsTgc0dYuxSYW/9mXQNFTynD2yyVXsBY
 JsJ9LSaM+SsMDeI+31MNYWGSJz0oZs1ugkRrUJDE1JcwxLlTGf10ctlsnACBRUmw
 Vvkq/3Yctc/2i6gz3ZrE1jdVgKPn1CVd4g7IykgkaAx6NsuVMgkFo85vj5jDMGiT
 qUdRLNvjHDIjO9j4Tw+B8/VdkncCT19JtC9fc9T0aLbkSsNMhvMAB8g+XAprtQCF
 LoPFAxoI1g/7lNCAV6d0wQGAjlZPaOiPeL2wj2SpxDnEbTUdac6+IWHJwel8jwJA
 9++IA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99wk9be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 10:20:41 +0000 (GMT)
Received: from np-a-belle.kl.imgtec.org (172.25.6.177) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:20:39 +0000
Message-ID: <29aa2bc0079126a74a03385bebd8596a2c29d645.camel@imgtec.com>
Subject: Re: [PATCH v4] drm/imagination: Support for querying Firmware
 information
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Brajesh Gupta <brajesh.gupta@imgtec.com>, Alessio Belle
 <alessio.belle@imgtec.com>, Frank Binns <frank.binns@imgtec.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Date: Wed, 4 Nov 2026 10:20:34 +0000
In-Reply-To: <20261028-fwversion-v4-1-aca85735a2b7@imgtec.com>
References: <20261028-fwversion-v4-1-aca85735a2b7@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0MCBTYWx0ZWRfX0t64X0MXOQMC
 uXJGZfzWPrfIAS/29y09aty3GheqtwH777/op/kEoHMTS3CDHFKve+hnfU9qkmswvwOdhnBIumf
 IAhDiIlKrp8m675V7XelRBd3joHqiwDwxt8542/qBlzrJKZwfAys30j2S9NMPH1+uXCkBsQHOGx
 vXEnUIzUMmg3DYhSZu5Vza5WKvJ7++bQw9ZFwCibdeyl0KEwmgh2X1//dI+4+RG/FmXCj+cdTJI
 SEVz3IGmPI+9QU/FNoiqdxQoXjkX67sV+9McPNbtyAVxTi0Ayl1KE0uTyf4gqq5CuhE6xUsIN0e
 FBSegegPNHrzPqtpi5Hs6GF8603a+cw2mNEuM2egbSAmUVXUdFLXn/IanuiXUuUbxxzAR7azo/2
 594kdLUfKY52Rb0KfFNf3ixF+I8serDsf7jNdEheJmYa+XK/sxJIPwVghWza5Mq6Bb8jK9WvZXn
 ggzr2kOlyYSPwrbP+3g==
X-Proofpoint-ORIG-GUID: QjIClcvYnunD1WYKQnYtrnNjHTfOjgCZ
X-Proofpoint-GUID: QjIClcvYnunD1WYKQnYtrnNjHTfOjgCZ
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6aeb06f9 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=bUS7bm5r22WPVLDEJJIA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0MCBTYWx0ZWRfXzf1mGJJAfCgP
 SCh00wnvL4HCyZ8rTsUKe/qF0X/l+HypkigIFgkJjwPyfw5CnQWKUF0PjCcolxjB+byDvvnmQmM
 e4cI4yEUKKDQ3pV+jUUqv20nF3GfC54=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 19:37 +0530, Brajesh Gupta wrote:
> Add a new subtype DRM_PVR_DEV_QUERY_FW_INFO_GET under
> DRM_IOCTL_PVR_DEV_QUERY to query Firmware information. This allows the
> userspace to detect any bug fixes and features present in the Firmware
> and take appropriate action.
> Currently it supports querying major and minor version of the Firmware.
>=20
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

Acked-by: Luigi Santivetti <luigi.santivetti@imgtec.com>

> ---
> Changes in v4:
> - Add description for the new interface introduced.
> - Link to v3: https://patch.msgid.link/20261027-fwversion-v3-1-f363de5920=
5b@imgtec.com
>=20
> Changes in v3:
> - Add missed check for padding field added in v2.
> - Link to v2: https://lore.kernel.org/r/20261026-fwversion-v2-1-bb025c93a=
04a@imgtec.com
>=20
> Changes in v2:
> - Add padding field to align new FW query struct to 64-bit.
> - Link to v1: https://patch.msgid.link/20261026-fwversion-v1-1-3ed17c65bf=
4c@imgtec.com
>=20
> To: Alessio Belle <alessio.belle@imgtec.com>
> To: Luigi Santivetti <luigi.santivetti@imgtec.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: imagination@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/imagination/pvr_drv.c |  5 ++++
>  drivers/gpu/drm/imagination/pvr_drv.h |  4 ++-
>  drivers/gpu/drm/imagination/pvr_fw.c  | 46 +++++++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/imagination/pvr_fw.h  |  3 +++
>  include/uapi/drm/pvr_drm.h            | 21 ++++++++++++++++
>  5 files changed, 78 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 5c965ef0274f..2d522a8e46ad 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -6,6 +6,7 @@
>  #include "pvr_device.h"
>  #include "pvr_drv.h"
>  #include "pvr_free_list.h"
> +#include "pvr_fw.h"
>  #include "pvr_gem.h"
>  #include "pvr_hwrt.h"
>  #include "pvr_job.h"
> @@ -658,6 +659,10 @@ pvr_ioctl_dev_query(struct drm_device *drm_dev, void=
 *raw_args,
>  	case DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET:
>  		ret =3D pvr_static_data_areas_get(pvr_dev, args);
>  		break;
> +
> +	case DRM_PVR_DEV_QUERY_FW_INFO_GET:
> +		ret =3D pvr_fw_info_get(pvr_dev, args);
> +		break;
>  	}
> =20
>  	drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imag=
ination/pvr_drv.h
> index 7fa147312dd1..4e058a6fdd5c 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.h
> +++ b/drivers/gpu/drm/imagination/pvr_drv.h
> @@ -13,9 +13,10 @@
>  /*
>   * Driver interface version:
>   *  - 1.0: Initial interface
> + *  - 1.1: Add DRM_PVR_DEV_QUERY_FW_INFO_GET query
>   */
>  #define PVR_DRIVER_MAJOR 1
> -#define PVR_DRIVER_MINOR 0
> +#define PVR_DRIVER_MINOR 1
>  #define PVR_DRIVER_PATCHLEVEL 0
> =20
>  int pvr_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32 obj_size, =
void *out);
> @@ -68,6 +69,7 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *=
out, u32 min_stride, u32
>  	PVR_UOBJ_DECL(struct drm_pvr_dev_query_heap_info, heaps) \
>  	PVR_UOBJ_DECL(struct drm_pvr_static_data_area, offset) \
>  	PVR_UOBJ_DECL(struct drm_pvr_dev_query_static_data_areas, static_data_a=
reas) \
> +	PVR_UOBJ_DECL(struct drm_pvr_dev_query_fw_info, _padding_4) \
>  	)
> =20
>  /**
> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagi=
nation/pvr_fw.c
> index c6c77b152342..d014a34b4f1f 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c
> @@ -4,6 +4,7 @@
>  #include "pvr_ccb.h"
>  #include "pvr_device.h"
>  #include "pvr_device_info.h"
> +#include "pvr_drv.h"
>  #include "pvr_fw.h"
>  #include "pvr_fw_info.h"
>  #include "pvr_fw_startstop.h"
> @@ -1496,3 +1497,48 @@ pvr_fw_hard_reset(struct pvr_device *pvr_dev)
> =20
>  	return 0;
>  }
> +
> +/**
> + * pvr_fw_info_get()
> + * @pvr_dev: Device pointer.
> + * @args: [IN] Device query arguments containing a pointer to a userspac=
e
> + *        struct drm_pvr_dev_query_fw_info.
> + *
> + * If the query object pointer is NULL, the size field is updated with t=
he
> + * expected size of the query object.
> + *
> + * Returns:
> + *  * 0 on success, or if size is requested using a NULL pointer, or
> + *  * -%EINVAL if args contained non-zero reserved fields or
> + *    if the input object is smaller than the minimum required, or
> + *  * -%EFAULT if local memory could not be copied to userspace.
> + */
> +int
> +pvr_fw_info_get(const struct pvr_device *pvr_dev,
> +		struct drm_pvr_ioctl_dev_query_args *args)
> +{
> +	struct drm_pvr_dev_query_fw_info fw_info =3D {0};
> +	int err;
> +
> +	if (!args->pointer) {
> +		args->size =3D sizeof(struct drm_pvr_dev_query_fw_info);
> +		return 0;
> +	}
> +
> +	err =3D PVR_UOBJ_GET(fw_info, args->size, args->pointer);
> +	if (err < 0)
> +		return err;
> +	if (fw_info._padding_4)
> +		return -EINVAL;
> +
> +	fw_info.major_version =3D pvr_dev->fw_version.major;
> +	fw_info.minor_version =3D pvr_dev->fw_version.minor;
> +
> +	err =3D PVR_UOBJ_SET(args->pointer, args->size, fw_info);
> +	if (err < 0)
> +		return err;
> +
> +	if (args->size > sizeof(fw_info))
> +		args->size =3D sizeof(fw_info);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagi=
nation/pvr_fw.h
> index 4b25291135b6..7e18f3e7d4be 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.h
> +++ b/drivers/gpu/drm/imagination/pvr_fw.h
> @@ -496,4 +496,7 @@ int
>  pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *=
fw, u8 *fw_code_ptr,
>  				  u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr);
> =20
> +int
> +pvr_fw_info_get(const struct pvr_device *pvr_dev, struct drm_pvr_ioctl_d=
ev_query_args *args);
> +
>  #endif /* PVR_FW_H */
> diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
> index ccf6c2112468..1179c1e7d92d 100644
> --- a/include/uapi/drm/pvr_drm.h
> +++ b/include/uapi/drm/pvr_drm.h
> @@ -434,6 +434,21 @@ struct drm_pvr_dev_query_static_data_areas {
>  	struct drm_pvr_obj_array static_data_areas;
>  };
> =20
> +/**
> + * struct drm_pvr_dev_query_fw_info - Container used to fetch informatio=
n
> + * about the GPU Firmware like its version.
> + */
> +struct drm_pvr_dev_query_fw_info {
> +	/** @major_version: Major version of the Firmware. */
> +	__u16 major_version;
> +
> +	/** @minor_version: Minor version of the Firmware. */
> +	__u16 minor_version;
> +
> +	/** @_padding_4: Reserved. This field must be zeroed. */
> +	__u32 _padding_4;
> +};
> +
>  /**
>   * enum drm_pvr_dev_query - For use with &drm_pvr_ioctl_dev_query_args.t=
ype to
>   * indicate the type of the receiving container.
> @@ -476,6 +491,12 @@ enum drm_pvr_dev_query {
>  	 * a pointer to &struct drm_pvr_dev_query_static_data_areas.
>  	 */
>  	DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET,
> +
> +	/**
> +	 * @DRM_PVR_DEV_QUERY_FW_INFO_GET: The dev query args contain
> +	 * a pointer to &struct drm_pvr_dev_query_fw_info.
> +	 */
> +	DRM_PVR_DEV_QUERY_FW_INFO_GET,
>  };
> =20
>  /**
>=20
> ---
> base-commit: a8fe4e162ba8212b7e51fdb024b37800f36b496c
> change-id: 20261026-fwversion-95a82a91f9f7
>=20
> Best regards,
> -- =20
> Brajesh Gupta <brajesh.gupta@imgtec.com>
>=20

Thank you!
