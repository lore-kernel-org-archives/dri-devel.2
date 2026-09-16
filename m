Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF61C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA4E10E202;
	Wed, 16 Sep 2026 00:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HWmUAYE/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2803010E202
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789519506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfPUYzlcgmsFLjqRxvjtuvi+F6kyqT67ipaEXy3hQRw=;
 b=HWmUAYE/1SWLkeqUAA9xE2FmFzXNV1Wsx+s/1VtjAyOizvU3YgEpnCkpVxIssPmYew+bJk
 17CE3bmMoQ6pm+VpnMdGXtv17DCZqTz6wTtxAkB9J/NdN3hejWNNZ622UipAdPkyRHW0qB
 lXBQ5V/EHbilk1NAfo8dHwXYne5vwnU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-npLxfYwuNqigM0fBX4fLQQ-1; Tue, 15 Sep 2026 20:45:04 -0400
X-MC-Unique: npLxfYwuNqigM0fBX4fLQQ-1
X-Mimecast-MFC-AGG-ID: npLxfYwuNqigM0fBX4fLQQ_1789519504
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so8670338a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789519504; x=1790124304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HfPUYzlcgmsFLjqRxvjtuvi+F6kyqT67ipaEXy3hQRw=;
 b=kvIj8w8diPbbFcQTgbE3luozghtvh2E02gTb+NpCzz/mLhlrJve68+T6Fguc5ITsof
 79r/II7C/R8Ujpm3cuzukwQPxvKEKvWLz9SoqmJ1xhlO0o1HjFHmuLJHaCnCUJuulxL3
 ju5YVQWLv8rDum9ckqzdchCgMVXuC41upL8UTSUjMVRhhlNgff1WPGbnM55riTdwrJy2
 nU3yb8znaPXUjDyAcqUScRNC9S4C0qxfULN4Wr2qv/hsnVg4K0+xrdyplDpYDn4R+hmJ
 oTJcs9CyQCFlodD5S/IhZEATQEBrOh8vVEkxra/69ZsHpoGWyqec0dm02xwzPzZroaP7
 IWqA==
X-Gm-Message-State: AFuF++mxLEfYJtceZrP/+SZdk4ykpvbD1iBozIsLbS8BewMBlljlcv/8
 eF8NQ/eOcxF2bcc9xBhYtiLckEV6u6PljJmddIWdq5ILiffU5uGhosk5if1JXaMR4PBIPgm/mUw
 2klzMdDd/X3l6gReVCvw1s/SRgdPr3LdUXz7nzCLYx06D/k8C0RPIz/kh5RL6jkk0Qi7E2xfCmr
 k13OP5rsPzyJUVQVoY9ZDW4ukG5a7d04R+GX4ailTtAzZh
X-Gm-Gg: AYBFou296VH8WPg3QDlDR5PAbceVYvtBj03X/zbIGx5UcO5dGND3++17DMWEYBWS5UA
 TdqKLCiwyqDTRSCr19EexScFz5b352K3Ts+QD+rRcLK237Rg/9ulkUQfO+9RdK9jdryum/1mne+
 Cr/S/XfH08BavOZBeG7nu0gzONmVswnuPbBJSgBC9iuObrJuqrb8L8ib4u8Roj+Zk1mmi9IgrUb
 oFfk+luSF4zi7Bi
X-Received: by 2002:a17:90b:5386:b0:398:dcef:c040 with SMTP id
 98e67ed59e1d1-39e1e4aa012mr1554343a91.19.1789519503340; 
 Tue, 15 Sep 2026 17:45:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5386:b0:398:dcef:c040 with SMTP id
 98e67ed59e1d1-39e1e4aa012mr1554271a91.19.1789519502710; Tue, 15 Sep 2026
 17:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260916001603.22394-1-lyude@redhat.com>
 <20260916001603.22394-3-lyude@redhat.com>
In-Reply-To: <20260916001603.22394-3-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Wed, 16 Sep 2026 10:44:50 +1000
X-Gm-Features: AcwNN1U2rMYqd8tDZTEqUV094CLCyp-28AzSPzCe3dT76HzOjLGKJxyGK8p2h-Q
Message-ID: <CAMwc25pBOU62TV77ZSSyH6DP=K4FMCpd9i98L4H+QWQ0=--FOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] drm/nouveau/gsp/r535: Add support for
 MEMSYS_GET_STATIC_CONFIG
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 Mel Henning <mhenning@darkrefraction.com>, 
 Danilo Krummrich <dakr@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 06sDAqguwSYS5BngmsRO12QNFUKpMguM_CXoIHmUvLQ_1789519504
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2026 at 10:22=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> This is a GSP structure describing various characteristics of the memory
> management system that GSP provides. Start by fetching it during driver
> load, but don't do anything with the information we get from it just yet.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V3
> * s/nvkm_gsp_rm_ctrl_get()/nvkm_gsp_rm_ctrl_rd()/
>
>  .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  4 ++
>  .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 17 +++++++
>  .../nvkm/subdev/gsp/rm/r535/nvrm/gsp.h        | 45 +++++++++++++++++
>  .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |  8 +++
>  .../nvkm/subdev/gsp/rm/r570/nvrm/gsp.h        | 50 +++++++++++++++++++
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  1 +
>  6 files changed, 125 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/=
gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> index 64fed208e4cf8..0e193baaf9bbb 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -156,6 +156,10 @@ struct nvkm_gsp {
>                 struct sg_table fbsr;
>         } sr;
>
> +       struct {
> +               bool use_raw_mode_comptagline_alloc;
> +       } memsys;
> +
>         struct {
>                 struct nvkm_gsp_mem mem;
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 09b17b85dc1ac..5df5365e744f5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> @@ -1808,6 +1808,23 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_susp=
end_state suspend)
>         return 0;
>  }
>
> +int
> +r535_gsp_get_static_memsys_info(struct nvkm_gsp *gsp)
> +{
> +       NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS *ctrl;
> +
> +       ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.subdevice,
> +                                   NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_S=
TATIC_CONFIG,
> +                                   sizeof(*ctrl));
> +       if (IS_ERR(ctrl))
> +               return PTR_ERR(ctrl);
> +
> +       gsp->memsys.use_raw_mode_comptagline_alloc =3D ctrl->bUseRawModeC=
omptaglineAllocation;
> +
> +       nvkm_gsp_rm_ctrl_done(&gsp->internal.device.subdevice, ctrl);
> +       return 0;
> +}
> +
>  int
>  r535_gsp_init(struct nvkm_gsp *gsp)
>  {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h b=
/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> index fd1170037c030..fee5418a72a68 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> @@ -789,6 +789,51 @@ typedef struct NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQ=
UISITE_PARAMS {
>      NvBool bIsGCOFFSatisfied;
>  } NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS;
>
> +typedef struct NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS {
> +    /*! Determines if RM should use 1 to 1 Comptagline allocation policy=
 */
> +    NvBool bOneToOneComptagLineAllocation;
> +
> +    /*! Determines if RM should use 1 to 4 Comptagline allocation policy=
 */
> +    NvBool bUseOneToFourComptagLineAllocation;
> +
> +    /*! Determines if RM should use raw Comptagline allocation policy */
> +    NvBool bUseRawModeComptaglineAllocation;
> +
> +    /*! Has COMPBIT_BACKING_SIZE been overridden to zero (i.e. disabled)=
? */
> +    NvBool bDisableCompbitBacking;
> +
> +    /*! Determine if we need to disable post L2 compression */
> +    NvBool bDisablePostL2Compression;
> +
> +    /*! Is ECC DRAM feature supported? */
> +    NvBool bEnabledEccFBPA;
> +
> +    NvBool bL2PreFill;
> +
> +    /*! L2 cache size */
> +    NV_DECLARE_ALIGNED(NvU64 l2CacheSize, 8);
> +
> +    /*! Indicate whether fpba is present or not */
> +    NvBool bFbpaPresent;
> +
> +    /*! Size covered by one comptag */
> +    NvU32  comprPageSize;
> +
> +    /*! log32(comprPageSize) */
> +    NvU32  comprPageShift;
> +
> +    /*! RAM type */
> +    NvU32  ramType;
> +
> +    /*! LTC count */
> +    NvU32  ltcCount;
> +
> +    /*! LTS per LTC count */
> +    NvU32  ltsPerLtcCount;
> +} NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS;
> +
> +#define NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG        (0x2080=
0a1c) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID=
 << 8) | NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS_MESSAGE_ID" *=
/
> +
>  typedef union rpc_message_rpc_union_field_v03_00
>  {
>      NvU32      spare;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index b45781cd0dfdc..5a51fe7e5ab98 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -137,6 +137,14 @@ r570_gsp_get_static_info(struct nvkm_gsp *gsp)
>                 }
>         }
>
> +       ret =3D r535_gsp_get_static_memsys_info(gsp);
> +       if (ret) {
> +               nvkm_error(&gsp->subdev, "Retrieving static memsys info f=
ailed\n");
> +               return ret;
> +       }
> +       nvkm_debug(&gsp->subdev, "memsys: Use raw mode for comptag alloca=
tions? %s\n",
> +                  str_yes_no(gsp->memsys.use_raw_mode_comptagline_alloc)=
);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b=
/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
> index c458569af9d72..e2d9d1949e4e1 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
> @@ -494,6 +494,56 @@ typedef struct
>
>  #define GSP_FW_WPR_META_REVISION  1
>
> +#define NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS_MESSAGE_ID =
(0x1CU)
> +
> +typedef struct NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS {
> +    /*! Determines if RM should use 1 to 1 Comptagline allocation policy=
 */
> +    NvBool bOneToOneComptagLineAllocation;
> +
> +    /*! Determines if RM should use 1 to 4 Comptagline allocation policy=
 */
> +    NvBool bUseOneToFourComptagLineAllocation;
> +
> +    /*! Determines if RM should use raw Comptagline allocation policy */
> +    NvBool bUseRawModeComptaglineAllocation;
> +
> +    /*! Has COMPBIT_BACKING_SIZE been overridden to zero (i.e. disabled)=
? */
> +    NvBool bDisableCompbitBacking;
> +
> +    /*! Determine if we need to disable post L2 compression */
> +    NvBool bDisablePostL2Compression;
> +
> +    /*! Is ECC DRAM feature supported? */
> +    NvBool bEnabledEccFBPA;
> +
> +    NvBool bL2PreFill;
> +
> +    /*! L2 cache size */
> +    NV_DECLARE_ALIGNED(NvU64 l2CacheSize, 8);
> +
> +    /*! Indicate whether fpba is present or not */
> +    NvBool bFbpaPresent;
> +
> +    /*! Size covered by one comptag */
> +    NvU32  comprPageSize;
> +
> +    /*! log32(comprPageSize) */
> +    NvU32  comprPageShift;
> +
> +    /*! RAM type */
> +    NvU32  ramType;
> +
> +    /*! LTC count */
> +    NvU32  ltcCount;
> +
> +    /*! LTS per LTC count */
> +    NvU32  ltsPerLtcCount;
> +} NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS;
> +

Is this used anywhere? if the 535 and 570 structs match then don't include =
it.

Dave.

