Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3260D9EAD
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gs1zLql8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943A710FEA5;
	Wed,  4 Nov 2026 19:52:52 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E72310FE9F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:52:41 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-7cc0afff8d6so31824137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 11:52:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793821960; cv=none;
 d=google.com; s=arc-20260327;
 b=p/mfgZ9ods6Flm6KZ5wSw/qbwzOHZ00LNZFISerwiS7b8oujuMSoyolnAInlwHTprg
 1yi6C84MBAmHdefSfqWqSDfhzY5S482HTGetJG2K+PNXZZT4lpWaStHxAM0ncKkQxlgK
 1hunMv4tS7nO+LFgW77dQUuc14SNL4SvoPcNUu2YB3r32Yb0oh4FVKokIXnOOkDeO4GF
 nRAOxs5vTXg8s908j+wCwXSjGstv3k+mD0hrMXfjyUjKrTEs8VhwpS5zBqBWOJ/a8eLT
 ZxdO4h2I5bm30kgsZOYyM15v+U0sF5Je0FBRi5PJny26eohCacOoZQeKIogyNYC1jUrZ
 UqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KGbQCndPm+NXMzmldIM5KKcRNjtbYMpkra3Vm9e0WZM=;
 fh=bBI6IVkGod3DzQsJ7bRU0hqwFh6S6tyZSqsHjfZeSsk=;
 b=LrLcQxSVySqPbMoRUO0tE3hLgUJHqD5gRSyZnb/dJVK7x518m+ZqgGcAOazW14HPmK
 g+VtQr35YoB/lDKK8KSny455cnEdJVUu2uORWtTOXFNVF7rPIMqjJhYpx/hk67fU2+AX
 h0IhlFeYyEQ/DC4oecd2ijeaT5kP4W5sKzFMft9rsv9YFU5pFwEGnCmHr0zcnspGWtxu
 RIwJa0PCBdN4lOYs6lSgKJjkrW68UL72MLgWWUH6uIib3F1MJPjdyn8l56ZnHU3pMBZt
 n+D6jjJrjOWlefoEtr5S60OaSjmWzT1rY6wGPaDbHoGwxLedhgNhXvvigtyNNX/+PA6C
 MAhA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793821960; x=1794426760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KGbQCndPm+NXMzmldIM5KKcRNjtbYMpkra3Vm9e0WZM=;
 b=gs1zLql8IISnhlNgLhwgcnYHPBDLLP3H65nMLeEoJoi4g+ODJ7a2zWQSujfJBoyIxT
 9mxZa10HdYV2DJxGYqeJIZBgpoGCg+qq1GVP7g6A56FjzI5VWBjReIdTQTkDiFPk1gxe
 nmG0XIfl+IIiQYRQKHd7E0nVeDAM4o0E8jcRJWBTJttR9asWIzyJURc0ehfbUuQC3rXE
 bcMRNcuupKBMFOkGXbXtMENvjatsTskqR9Tki08kMgL/9YwOHmmHM7kcXB/w43ut+biw
 gr+7EqNlqyyos44Xl1MNcEEJjdkJ3uJVySXm4bAyfnTIYZo/CJdBIbQoUEVh2HcXiM3V
 c1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821960; x=1794426760;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGbQCndPm+NXMzmldIM5KKcRNjtbYMpkra3Vm9e0WZM=;
 b=XmFhekJbxKwdE971fl9lcZIQHVPJ92W1KDZziu2m7vSRsxIm4KRaDlToCgSHzyGM9G
 ZPsx3LnmIa4G5Gkz3ktBLCsrzAiJm7sc/tpGwr0Yqa1FeJx4SB6Hn80JUw/QW47KdtXj
 C0kH+o9HiywY8iu/J/kiYfKkHhUMhG4MKxJYpKaXWsd3A6uHa58HGyYgn9TWIDyGMHPq
 LmI/4cwYsA/dLPmKEVDUolLMi/E3cR+3rjsKDxCoclSSf8vhA3y78QEQBwtWEs4mZrIZ
 Ryh001dF9oU94o1DR3rq6J0Kq4DCiLIP5901fnyLqD2GjUtzsZgMFSMqT5FRB0EZdPqY
 mTlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLSXxIHQMTqlIRf5kByY3DP/BgPZmmcVydRfoKy1Oc9LWMhIZ8KsinCSBb2S9xExk7bsZgf8a8/aA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/FebWfsU1dshQpRmz9ZtdaWC88xWe863ZqQ1wu5Ck+nFb2uP/0
 Pfo2hXXAbOz1h3iNgUFusG7TTD/pcgvCOaVsVoqorMsPdyReUC7Ydx9L0gkcOQ/LTGtQujSVXqo
 vceR5I3/DrK+B6045gsA7hf0M9G7cMrw=
X-Gm-Gg: AYBFou1oUIghIC2cou+UdNnuPoBjWnXseIKLzUjH5hscYSleGYfrVZqJ+ua1g7ORJRr
 PrzoKh1gd69xfIp4k3hRORDKkTaPBMitAkBwnQkT+FikOY1MjF6Kx6AEG0wroyGnPXII7oowzd8
 dZcMSRqBrqTvs6TRlxUAEbQf/nEhk40YxaWxuoHargpVTbc5vUr1Wh/+Dfhfg1T4uY50UNeNsLt
 DemLaDfH/oJGJvSZ1WnTzw1VAQpr7RAsrsljfh8jt6DpdPocWozEy93naURSTv9pDE9r29Fet+4
 Ui8cY2wfd4QJoYDKLHkWptHcJ08/X/rj4BroaHfWQGOcEhB3adAIsNT3CdwuBh/Udcbp81a8+XN
 5AUKMuds0wzeGpS/ueK3KWloe2hhyM6nmXT4EpW9Norb0VsnUW4785us9Ck6b4N7ii9FdQFwlB7
 lT0TMVo20E3tLfI/82mpimxFRfonkBwpR9tq3Y8r7sHC1Z
X-Received: by 2002:a67:fb85:0:b0:7d2:7784:23b5 with SMTP id
 ada2fe7eead31-7d2778440a7mr1480180137.1.1793821960026; Wed, 04 Nov 2026
 11:52:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104193649.8158-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261104193649.8158-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 14:52:26 -0500
X-Gm-Features: AclHuK_rrAS-CKWpRybmZKsWRyObyWh8haU_OQpy2sZkpOQpHv1PlVESzUc-rpo
Message-ID: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 2:46=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> This code adds support for 5K in iMac20,1 and iMac20,2 with
> support of changing resolutions.
>

Please give a better description of what has changed here.

> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4455
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4895
>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 32 ++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++++
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   | 19 +++++++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  | 29 ++++++++++++++-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 ++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 37 +++++++++++++++++--
>  .../drm/amd/display/dc/link/link_detection.c  | 14 ++++++-
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 ++
>  .../display/dc/link/protocols/link_dp_phy.c   |  5 +++
>  .../dc/link/protocols/link_dp_training.c      |  9 ++++-
>  12 files changed, 180 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 890792a94..fc107e4fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -21,6 +21,7 @@
>   *
>   */
>
> +#include <linux/dmi.h>
>  #include <linux/firmware.h>
>  #include <linux/kernfs.h>
>
> @@ -3412,6 +3413,22 @@ static int amdgpu_discovery_set_ualink_ip_blocks(s=
truct amdgpu_device *adev)
>         return 0;
>  }
>
> +static const struct dmi_system_id imac5k_table[] =3D {
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,1"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,2"),
> +               },
> +       },
> +       {}
> +};
> +
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  {
>         int r;
> @@ -4026,15 +4043,24 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
>                 }
>         }
>
> +       /* TODO: We should enable 5K in EFI and remove this quirk */
> +       if (unlikely(dmi_check_system(imac5k_table))) {
> +               r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> +               if (r)
> +                       return r;
> +       }

What's the reason for this change?

> +
>         if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {
>                 r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
>                 if (r)
>                         return r;
>         }
>
> -       r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> -       if (r)
> -               return r;
> +       if (likely(!dmi_check_system(imac5k_table))) {
> +               r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> +               if (r)
> +                       return r;
> +       }
>
>         r =3D amdgpu_discovery_set_gc_ip_blocks(adev);
>         if (r)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5b634ae07..a88c86051 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -639,6 +639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>         retrieve_dmi_info(&adev->dm);
>         if (adev->dm.edp0_on_dp1_quirk)
>                 init_data.flags.support_edp0_on_dp1 =3D true;
> +       if (adev->dm.imac5K_support)
> +               init_data.flags.imac5K_support =3D true;
>
>         if (adev->dm.bb_from_dmub)
>                 init_data.bb_from_dmub =3D adev->dm.bb_from_dmub;
> @@ -1967,6 +1969,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_bl=
ock)
>                 dc_exit_ips_for_hw_access(dm->dc);
>                 WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
>
> +               if (dm->dc->config.imac5K_using_5K) {
> +                       const u8 value =3D 1;
> +
> +                       core_link_write_dpcd(dm->dc->links[0], 0x4F1, &va=
lue, 1);
> +               }
>                 dm_gpureset_commit_state(dm->cached_dc_state, dm);
>
>                 dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, =
true);
> @@ -4739,6 +4746,25 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>         dc_exit_ips_for_hw_access(dm->dc);
>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>
> +       if (dm->imac5K_support) {
> +               for_each_new_crtc_in_state(state, crtc, new_crtc_state, i=
) {
> +                       dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_s=
tate);
> +
> +                       if (!dm_new_crtc_state->stream)
> +                               continue;
> +
> +                       if (dm_new_crtc_state->stream->signal !=3D SIGNAL=
_TYPE_EDP)
> +                               continue;
> +
> +                       if (new_crtc_state->mode.vdisplay =3D=3D 2880 && =
new_crtc_state->mode.hdisplay =3D=3D 2560) {
> +                               u8 value =3D 1;
> +
> +                               core_link_write_dpcd(dm->dc->links[0], 0x=
4F1, &value, 1);
> +                               dm->dc->config.imac5K_using_5K =3D true;
> +                       } else
> +                               dm->dc->config.imac5K_using_5K =3D false;
> +               }
> +       }
>         bool frl_stream_found =3D false;
>
>         for (i =3D 0; i < params.stream_count; i++) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 1b91fe4c3..65a2330c6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -698,6 +698,13 @@ struct amdgpu_display_manager {
>          */
>         bool edp0_on_dp1_quirk;
>
> +       /**
> +        * @imac5K_support:
> +        *
> +        * quirk for iMac that support 5K
> +        */
> +       bool imac5K_support;
> +
>         /**
>          * @dpia_aux_lock:
>          *
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 2b81396bd..2269b91c3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -123,6 +123,13 @@ STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(=
struct drm_encoder *encoder,
>                                        drm_mode_vrefresh(adjusted_mode));
>                         dm_new_connector_state->scaling =3D RMX_ASPECT;
>                 }
> +
> +               if (aconnector->dc_link && aconnector->dc_link->dc->confi=
g.imac5K_support) {
> +                       if (crtc_state->mode.vdisplay !=3D 2880)
> +                               dm_new_connector_state->scaling =3D RMX_F=
ULL;
> +                       else
> +                               dm_new_connector_state->scaling =3D RMX_O=
FF;
> +               }
>                 return 0;
>         }
>
> @@ -3130,9 +3137,19 @@ STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes=
(struct drm_connector *connect
>         const struct drm_edid *drm_edid =3D amdgpu_dm_connector->drm_edid=
;
>         struct dc_link_settings *verified_link_cap =3D &dc_link->verified=
_link_cap;
>         const struct dc *dc =3D dc_link->dc;
> +       struct dc_sink *sink =3D amdgpu_dm_connector->dc_sink;
>
>         encoder =3D amdgpu_dm_connector_to_encoder(connector);
>
> +       if (dc->config.imac5K_support && sink &&
> +           sink->link->link_index =3D=3D 1 && !connector->edid_blob_ptr)=
 {
> +               const struct drm_edid *kept =3D drm_edid_alloc(sink->dc_e=
did.raw_edid,
> +                                                            sink->dc_edi=
d.length);
> +
> +               drm_edid_connector_update(connector, kept);
> +               drm_edid_free(kept);
> +       }
> +
>         if (!drm_edid) {
>                 amdgpu_dm_connector->num_modes =3D
>                                 drm_add_modes_noedid(connector, 640, 480)=
;
> @@ -3312,7 +3329,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_=
display_manager *dm,
>                                 adev->mode_info.underscan_vborder_propert=
y,
>                                 0);
>
> -       if (!aconnector->mst_root)
> +       if (!aconnector->mst_root && !(dm->imac5K_support && link_index <=
=3D 1))
>                 drm_connector_attach_max_bpc_property(&aconnector->base, =
8, 16);
>
>         aconnector->base.state->max_bpc =3D 16;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> index 259966703..8657dd972 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> @@ -33,11 +33,13 @@
>  struct amdgpu_dm_quirks {
>         bool aux_hpd_discon;
>         bool support_edp0_on_dp1;
> +       bool imac5K_support;
>  };
>
>  static struct amdgpu_dm_quirks quirk_entries =3D {
>         .aux_hpd_discon =3D false,
> -       .support_edp0_on_dp1 =3D false
> +       .support_edp0_on_dp1 =3D false,
> +       .imac5K_support =3D false,
>  };
>
>  static int edp0_on_dp1_callback(const struct dmi_system_id *id)
> @@ -52,6 +54,12 @@ static int aux_hpd_discon_callback(const struct dmi_sy=
stem_id *id)
>         return 0;
>  }
>
> +static int imac5K_support_callback(const struct dmi_system_id *id)
> +{
> +       quirk_entries.imac5K_support =3D true;
> +       return 0;
> +}
> +
>  static const struct dmi_system_id dmi_quirk_table[] =3D {
>         {
>                 .callback =3D aux_hpd_discon_callback,
> @@ -151,6 +159,20 @@ static const struct dmi_system_id dmi_quirk_table[] =
=3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 465 16 in=
ch G11 Notebook PC"),
>                 },
>         },
> +       {
> +               .callback =3D imac5K_support_callback,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,1"),
> +               },
> +       },
> +       {
> +               .callback =3D imac5K_support_callback,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,2"),
> +               },
> +       },
>         {}
>         /* TODO: refactor this from a fixed table to a dynamic option */
>  };
> @@ -162,6 +184,7 @@ void retrieve_dmi_info(struct amdgpu_display_manager =
*dm)
>
>         dm->aux_hpd_discon_quirk =3D false;
>         dm->edp0_on_dp1_quirk =3D false;
> +       dm->imac5K_support =3D false;
>
>         dmi_id =3D dmi_check_system(dmi_quirk_table);
>
> @@ -176,6 +199,10 @@ void retrieve_dmi_info(struct amdgpu_display_manager=
 *dm)
>                 dm->edp0_on_dp1_quirk =3D true;
>                 drm_info(dev, "support_edp0_on_dp1 attached\n");
>         }
> +       if (quirk_entries.imac5K_support) {
> +               dm->imac5K_support =3D true;
> +               drm_info(dev, "imac5K_support attached\n");
> +       }
>  }
>  EXPORT_IF_KUNIT(retrieve_dmi_info);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 187486d97..98f74ffc2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -689,6 +689,14 @@ bool resource_are_streams_timing_synchronizable(
>         struct dc_stream_state *stream1,
>         struct dc_stream_state *stream2)
>  {
> +
> +       if (stream1->ctx->dc->config.imac5K_support &&
> +               ((stream1->signal =3D=3D SIGNAL_TYPE_EDP && stream2->sign=
al =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +               stream2->link->link_index =3D=3D 1) ||
> +               (stream2->signal =3D=3D SIGNAL_TYPE_EDP && stream1->signa=
l =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +               stream1->link->link_index =3D=3D 1)))
> +               return true;
> +
>         if (stream1->timing.h_total !=3D stream2->timing.h_total)
>                 return false;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index d3c484f45..a0b746250 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -635,6 +635,8 @@ struct dc_config {
>         struct spl_sharpness_range dcn_sharpness_range;
>         struct spl_sharpness_range dcn_override_sharpness_range;
>         bool no_native422_support;
> +       bool imac5K_support;
> +       bool imac5K_using_5K;
>  };
>
>  enum visual_confirm {
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 7b3aa02dd..aba1dc9b4 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -2656,7 +2656,8 @@ enum dc_status dce110_apply_ctx_to_hw(
>         struct dce_hwseq *hws =3D dc->hwseq;
>         struct dc_bios *dcb =3D dc->ctx->dc_bios;
>         enum dc_status status;
> -       unsigned int i;
> +       unsigned int i, n, enable_order[MAX_PIPES];
> +       int primary =3D -1, companion =3D -1;
>         bool was_hpo_acquired =3D resource_is_hpo_acquired(dc->current_st=
ate);
>         bool is_hpo_acquired =3D resource_is_hpo_acquired(context);
>
> @@ -2664,6 +2665,32 @@ enum dc_status dce110_apply_ctx_to_hw(
>         if (dc->config.use_pipe_ctx_sync_logic)
>                 reset_syncd_pipes_from_disabled_pipes(dc, context);
>
> +       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> +               struct pipe_ctx *pipe =3D &context->res_ctx.pipe_ctx[i];
> +
> +               enable_order[i] =3D i;
> +               if (!dc->config.imac5K_support || !pipe->stream ||
> +                   pipe->top_pipe || pipe->prev_odm_pipe)
> +                       continue;
> +               if (pipe->stream->link->link_index =3D=3D 0)
> +                       primary =3D i;
> +               else if (pipe->stream->link->link_index =3D=3D 1)
> +                       companion =3D i;
> +       }
> +       if (companion >=3D 0 && primary > companion) {
> +               enable_order[companion] =3D primary;
> +               enable_order[primary] =3D companion;
> +       }
> +
> +       if (primary >=3D 0 && companion >=3D 0) {
> +               struct pipe_ctx *old =3D &dc->current_state->res_ctx.pipe=
_ctx[primary];
> +               struct dc_link *right =3D context->res_ctx.pipe_ctx[compa=
nion].stream->link;
> +
> +               if (!old->stream ||
> +                   pipe_need_reprogram(old, &context->res_ctx.pipe_ctx[p=
rimary]))
> +                       right->link_state_valid =3D false;
> +       }
> +
>         /* Reset old context */
>         /* look up the targets that have been removed since last commit *=
/
>         hws->funcs.reset_hw_ctx_wrap(dc, context);
> @@ -2705,10 +2732,12 @@ enum dc_status dce110_apply_ctx_to_hw(
>                 dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, is_hpo_a=
cquired);
>         }
>
> -       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> +       for (n =3D 0; n < dc->res_pool->pipe_count; n++) {
>                 struct pipe_ctx *pipe_ctx_old =3D
> -                                       &dc->current_state->res_ctx.pipe_=
ctx[i];
> -               struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[=
i];
> +                       &dc->current_state->res_ctx.pipe_ctx[enable_order=
[n]];
> +               struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[=
enable_order[n]];
> +
> +               i =3D enable_order[n];
>
>                 if (pipe_ctx->stream =3D=3D NULL)
>                         continue;
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index b4546f93a..a92399753 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1205,7 +1205,10 @@ static bool detect_link_and_local_sink(struct dc_l=
ink *link,
>                                 if (!link->dpcd_caps.set_power_state_capa=
ble_edp)
>                                         link->wa_flags.dp_keep_receiver_p=
owered =3D true;
>                         }
> -
> +                       if (dc->config.imac5K_support) {
> +                               const uint8_t val =3D 1;
> +                               core_link_write_dpcd(link, 0x4F1, &val, 1=
);
> +                       }
>                         sink_caps.transaction_type =3D DDC_TRANSACTION_TY=
PE_I2C_OVER_AUX;
>                         sink_caps.signal =3D SIGNAL_TYPE_EDP;
>                         break;
> @@ -1634,6 +1637,15 @@ bool link_detect(struct dc_link *link, enum dc_det=
ect_reason reason)
>         bool is_delegated_to_mst_top_mgr =3D false;
>         enum dc_connection_type pre_link_type =3D link->type;
>
> +       if (link->local_sink &&
> +                       link->dc->config.imac5K_support &&
> +                       link->local_sink->link->link_index =3D=3D 1)
> +               return false;
> +
> +       if (reason =3D=3D DETECT_REASON_BOOT && link->dc->config.imac5K_s=
upport &&
> +           link->link_index =3D=3D 1)
> +               msleep(100);
> +
>         is_local_sink_detect_success =3D detect_link_and_local_sink(link,=
 reason);
>
>         if (is_local_sink_detect_success && link->local_sink) {
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gp=
u/drm/amd/display/dc/link/link_dpms.c
> index 2aeb9a0e6..3d7d1ddc4 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2084,6 +2084,9 @@ static enum dc_status enable_link_dp(struct dc_stat=
e *state,
>                         !link->dc->config.enable_dpia_pre_training)
>                 do_fallback =3D true;
>
> +       if (link->dc->config.imac5K_support && link->link_index =3D=3D 1)
> +               msleep(100);
> +
>         /*
>          * Temporary w/a to get DP2.0 link rates to work with SST.
>          * TODO DP2.0 - Workaround: Remove w/a if and when the issue is r=
esolved.
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c =
b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> index 49521ac4b..e90164a58 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> @@ -53,6 +53,11 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bo=
ol on)
>         core_link_write_dpcd(link, DP_SET_POWER, &state,
>                                                  sizeof(state));
>
> +       if (on && link->dc->config.imac5K_support &&
> +           link->connector_signal =3D=3D SIGNAL_TYPE_EDP) {
> +               state =3D 1;
> +               core_link_write_dpcd(link, 0x4F1, &state, sizeof(state));
> +       }
>  }
>
>  void dp_enable_link_phy(
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_traini=
ng.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index 3be36d106..4eca11169 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -1540,8 +1540,15 @@ static enum link_training_result dp_transition_to_=
video_idle(
>                  */
>                 if (link->connector_signal !=3D SIGNAL_TYPE_EDP && status=
 =3D=3D LINK_TRAINING_SUCCESS) {
>                         msleep(5);
> -                       if (!link->skip_fallback_on_link_loss)
> +                       if (link->dc->config.imac5K_support && link->link=
_index =3D=3D 1) {
> +                               uint8_t lanes;
> +
> +                               if (core_link_read_dpcd(link, DP_LANE0_1_=
STATUS,
> +                                                       &lanes, 1) !=3D D=
C_OK)
> +                                       status =3D LINK_TRAINING_LINK_LOS=
S;
> +                       } else if (!link->skip_fallback_on_link_loss) {
>                                 status =3D dp_check_link_loss_status(link=
, lt_settings);
> +                       }
>                 }
>                 return status;
>         }

I think the rest of this can be simplified quite a bit.  I'd suggest
rebasing this on the other 5K support patches and see how much of that
code you can share.
https://lists.freedesktop.org/archives/dri-devel/2026-November/610011.html

Alex

> --
> 2.55.0
>
