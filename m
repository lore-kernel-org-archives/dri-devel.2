Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BB2C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350F610F5B3;
	Thu,  9 Jul 2026 13:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ck6zMEMw";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242E410E5CF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:15:57 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3800f0907d5so261752a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 06:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602957; cv=none;
 d=google.com; s=arc-20260327;
 b=HJ3KqmKrhbcYWO8/UEdlDXhzjQjdQsSO8jKOrISGo0YasdQblQqXKgVeuC4f5l9O1a
 21NXGDx6lIWFKrMoslai9bMiXgftr2sOdSwLa9a1UGdDIQmH6DdOermo6FVpq5Z2Zg6l
 suTifDMar3xFjh3zn4c2Tm6uAPgS255Y/ezFHjnuFz+C/4He3CzUH7JyrFMzaFlQEzdH
 tmbucBpCBgi4wg1bjeFB+q3NciQ8osaxupmTvupE4WRk8r+I0Ci41ImdvfduAiEqNeqM
 5zsehwawdgIQR2Gnut6A/BgI/qLpw4V9qUadFZYosAu7+UzexFzMoHMlJFwDaf1Z4iTq
 X2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YIZsiznXyuA8stA/yiugrCNPoREM/u5qAvGFIs/UyZ8=;
 fh=XCg1lYNjAjW3Dd04Yt3tqTKQ5wqbf/u+qYawxWECiA8=;
 b=eCryihdVtGCovbYqj24vjdmTk2ouI/EXULpCRfTcbnC83DzadBISAFI5i70TXM4jsa
 Ukn5We/paPYAFNzWCYEFicc28fBfD4YfhPytlh5vjTRsX1D1WD0vVI/MnkWrIe630Ccf
 u/TKq+s87g7zHCZLCHYMaZyE9nAuhGlSyG7uj2iUXz7s/guc+Iv8/ZQrXABdK74P138j
 7KHY97Lwrzh2nyZjrE9Z9sg4IY7f3n2Cbu8zr34fM1c3Q/mlDrtoenrMzgtOHHBM43Jb
 blektTCVqnKdQJo0O+bx8queh423kP6m9gDH/dR2aVugg5mH/Adr6xp79QVS6ULJsNij
 DBSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783602957; x=1784207757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YIZsiznXyuA8stA/yiugrCNPoREM/u5qAvGFIs/UyZ8=;
 b=ck6zMEMw0V79sPFcSwvT42lhFyke0BoyKcVhOByT49h8WXVHcd+wtrz4DAnI4ZRG0W
 mIQqjzapRYjupeZK0BJAOtloz+HfPuMyavDoGjbaYcnzPyTtBKMSKHyD+eOpklXXCWXf
 AgzCh9seVJZ4vUaXN3WJnyWrhry/dmiiLFtW/LbA9Y5ngJBfqDdtTFl4rzY09SQoMCkN
 6q0Sta1+Xz2MKKMGRxGxUND5BKp2jQaEYn0Dcmyxekl4LPlfOJeYzYrpCk1DtvLZ0o5c
 SroRubIKoaoU5hVIc1j3e7Vscc2ZkiTecIDvBqNoqIebtQtI9QorZC6vzdNRUd/gXO7n
 elQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602957; x=1784207757;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YIZsiznXyuA8stA/yiugrCNPoREM/u5qAvGFIs/UyZ8=;
 b=OLOSxDtIFJ0RibDnZDyJboVgmqYDEnTe3sm8LfdhLHVg+ryXgOBoXfzkLiAykNREkf
 cjr3xK70XJv0jdCFzhi8he9Tn3fBq+4g0Ftrt+6A/Sl7dLZ0tc4ircas6s9hxoWoPKgH
 Cn2ALkVkGMGGXQSjl7r14w/mw2UASBui89hBZe8VP9WyvSzPsrVfYkNftPhR/MAaiLBY
 OmvvBoBg7jhdTynbxz40i3m0t9rGuKXY5ecFiWlFVv6SrQiSh0uSmihF00KIhnRlFakM
 sAQpt4l7ys5ewiw29bf8b3kImMmUcDzU10w5bVdERQXawLwNUChJETbvemEyOswDXPlU
 46tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXzVrbZAyul3YDQGs2PFbklplvY/iOQ8u34XYfXQU4CgA/5ios2fEJggvNNz/yJshFJ/icCvsgpBs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqv4uWpBVKSnic0JL+4isKLTmArRaOmox8+NkO9XoKlc6+3Zg9
 4El1jTOMbvg3LlUSZERfP/JSxgkeXyzsucLHP2BZAs2xvb7nolTpAxoJq5V1pfk/hppPws/491c
 URB5njGolBOtibeUEbZD1azZAADTsJKI=
X-Gm-Gg: AfdE7cn6afVV0BMsYLGIr9noICl+wd/3b0hY938Xg6pRdZWI0Iv0PSpaKkkYngyuR8S
 chcqFBNRyFgVIAivjDx8RRoOK0ClnbDDUQkt6ZD2zIN3K9bTR9hH8QVtMzGfQeI4G6UIvVJOU8L
 718Z+ASstHuuDrgeaUjOFbhs254dqXMo047FSYbukG0usw2E06pqGzUfKHY8WG79fuU2Yq4qimV
 NbrJXsIXaYoZb8vrcWZxOXMkOWOJ4iUAmkcEpclLMMMxy0vlbyOPSA01OdlYn0SlRrmeOllxFGM
 SJCWEZOjc+BSQG1bMrvek542NygxnehtE7PuqwSoc5RBwpZGclidg0OZpzc=
X-Received: by 2002:a17:90b:4a45:b0:36b:3ecd:88d7 with SMTP id
 98e67ed59e1d1-3893f97f006mr6200488a91.2.1783602956372; Thu, 09 Jul 2026
 06:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
 <20260708-hpd-debounce-unify-v2-1-d214832551b3@haghiri.net>
In-Reply-To: <20260708-hpd-debounce-unify-v2-1-d214832551b3@haghiri.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2026 09:15:44 -0400
X-Gm-Features: AVVi8Cec8RlJQ1UoGdYyuRvf_qAdAsNCfBZ8vp-Sh2j51B3M72EpCj_RNT71OM8
Message-ID: <CADnq5_Ob5FuRwXJxpx8-hA_dnfx8MzbZks=Ugxx=Y3E=chCrWA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: unify HDMI/DP SST HPD debounce delay
To: Nick Haghiri <nick@haghiri.net>
Cc: Ivan Lipski <ivlipski@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Xaver Hugl <xaver.hugl@kde.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 9, 2026 at 3:34=E2=80=AFAM Nick Haghiri <nick@haghiri.net> wrot=
e:
>
> Per review feedback on the DP SST debounce extension, fold
> hdmi_hpd_debounce_delay_ms and dp_hpd_debounce_delay_ms into a single
> hpd_debounce_delay_ms module parameter (eDP and MST still excluded),
> and rename the shared connector fields, work, and cached sink from
> hdmi_* to generic hpd_*.
>
> Also add an apply_edid_quirks() case for the MSI MPG 274U
> (drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0)) that enables a
> 1500ms default debounce delay for that panel, overridable by the
> module parameter.
>
> Signed-off-by: Nick Haghiri <nick@haghiri.net>
> ---
> Ivan, generalized to a single hpd_debounce_delay_ms for both HDMI and
> DP SST as suggested, and added the apply_edid_quirks() case for the
> MSI MPG 274U (1500ms default, module param still overrides it).

Can you extend this to DVI as well?

Alex

>
> Went with replacing hdmi_hpd_debounce_delay_ms rather than keeping a
> back-compat alias, since it's only a couple cycles old. Shout if you'd
> rather I keep the alias.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 26 +++-------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  | 18 +++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 29 ++++-------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  8 +++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 58 +++++++++++-----=
------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |  2 +-
>  7 files changed, 60 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c085a6cc1..af1748984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -270,8 +270,7 @@ extern int amdgpu_wbrf;
>  extern int amdgpu_user_queue;
>  extern int amdgpu_ptl;
>
> -extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
> -extern uint amdgpu_dp_hpd_debounce_delay_ms;
> +extern uint amdgpu_hpd_debounce_delay_ms;
>
>  #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS         3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 78df53b8c..5ed415aa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -245,8 +245,7 @@ int amdgpu_damage_clips =3D -1; /* auto */
>  int amdgpu_umsch_mm_fwlog;
>  int amdgpu_rebar =3D -1; /* auto */
>  int amdgpu_user_queue =3D -1;
> -uint amdgpu_hdmi_hpd_debounce_delay_ms;
> -uint amdgpu_dp_hpd_debounce_delay_ms;
> +uint amdgpu_hpd_debounce_delay_ms;
>  int amdgpu_ptl =3D -1; /* auto */
>
>  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, =
0,
> @@ -1105,25 +1104,12 @@ MODULE_PARM_DESC(user_queue, "Enable user queues =
(-1 =3D auto (default), 0 =3D disab
>  module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>
>  /*
> - * DOC: hdmi_hpd_debounce_delay_ms (uint)
> - * HDMI HPD disconnect debounce delay in milliseconds.
> - *
> - * Used to filter short disconnect->reconnect HPD toggles some HDMI sink=
s
> - * generate while entering/leaving power save. Set to 0 to disable by de=
fault.
> - */
> -MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect deboun=
ce delay in milliseconds (0 to disable (by default), 1500 is common)");
> -module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_=
delay_ms, uint, 0644);
> -
> -/*
> - * DOC: dp_hpd_debounce_delay_ms (uint)
> - * DisplayPort SST HPD disconnect debounce delay in milliseconds.
> - *
> - * Used to filter short disconnect->reconnect HPD toggles some DisplayPo=
rt SST
> - * sinks generate while entering/leaving power save. Set to 0 to disable=
 by
> - * default. eDP and MST are not affected.
> + * DOC: hpd_debounce_delay_ms (uint)
> + * HDMI/DP SST HPD disconnect debounce delay in milliseconds. eDP and MS=
T
> + * are not affected. Overrides any per-panel default set via EDID quirks=
.
>   */
> -MODULE_PARM_DESC(dp_hpd_debounce_delay_ms, "DisplayPort SST HPD disconne=
ct debounce delay in milliseconds (0 to disable (by default), 1500 is commo=
n)");
> -module_param_named(dp_hpd_debounce_delay_ms, amdgpu_dp_hpd_debounce_dela=
y_ms, uint, 0644);
> +MODULE_PARM_DESC(hpd_debounce_delay_ms, "HDMI/DP SST HPD disconnect debo=
unce delay in milliseconds (0 to disable (by default) or use the EDID quirk=
 default, 1500 is common)");
> +module_param_named(hpd_debounce_delay_ms, amdgpu_hpd_debounce_delay_ms, =
uint, 0644);
>
>  /**
>   * DOC: ptl (int)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index abc17f547..530e63321 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -61,14 +61,9 @@ enum amd_vsdb_panel_type {
>  #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
>
>  /*
> - * Maximum HDMI HPD debounce delay in milliseconds
> + * Maximum HDMI/DP SST HPD debounce delay in milliseconds
>   */
> -#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
> -
> -/*
> - * Maximum DisplayPort SST HPD debounce delay in milliseconds
> - */
> -#define AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS 5000
> +#define AMDGPU_DM_MAX_HPD_DEBOUNCE_MS 5000
>  /*
>  #include "include/amdgpu_dal_power_if.h"
>  #include "amdgpu_dm_irq.h"
> @@ -878,11 +873,10 @@ struct amdgpu_dm_connector {
>         enum adaptive_sync_type as_type;
>         struct amdgpu_hdmi_vsdb_info vsdb_info;
>
> -       /* HDMI HPD debounce support */
> -       unsigned int hdmi_hpd_debounce_delay_ms;
> -       unsigned int dp_hpd_debounce_delay_ms;
> -       struct delayed_work hdmi_hpd_debounce_work;
> -       struct dc_sink *hdmi_prev_sink;
> +       /* HDMI/DP SST HPD debounce support */
> +       unsigned int hpd_debounce_delay_ms;
> +       struct delayed_work hpd_debounce_work;
> +       struct dc_sink *hpd_prev_sink;
>
>         /* HDMI compliance automation */
>         bool hdmi_comp_auto;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index c79a8ada8..798825ec1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1748,12 +1748,10 @@ static void amdgpu_dm_connector_destroy(struct dr=
m_connector *connector)
>                 drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>
>         /* Cancel and flush any pending HPD debounce work */
> -       if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_=
debounce_delay_ms) {
> -               cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_w=
ork);
> -               if (aconnector->hdmi_prev_sink) {
> -                       dc_sink_release(aconnector->hdmi_prev_sink);
> -                       aconnector->hdmi_prev_sink =3D NULL;
> -               }
> +       cancel_delayed_work_sync(&aconnector->hpd_debounce_work);
> +       if (aconnector->hpd_prev_sink) {
> +               dc_sink_release(aconnector->hpd_prev_sink);
> +               aconnector->hpd_prev_sink =3D NULL;
>         }
>
>         if (aconnector->bl_idx !=3D -1) {
> @@ -2828,20 +2826,11 @@ void amdgpu_dm_connector_init_helper(struct amdgp=
u_display_manager *dm,
>         mutex_init(&aconnector->hpd_lock);
>         mutex_init(&aconnector->handle_mst_msg_ready);
>
> -       /*
> -        * If an HPD debounce delay is set, clamp each signal's delay to =
its
> -        * maximum. The debounce work and cached sink are shared by both =
the
> -        * HDMI and DisplayPort SST paths.
> -        */
> -       aconnector->hdmi_hpd_debounce_delay_ms =3D amdgpu_hdmi_hpd_deboun=
ce_delay_ms ?
> -               min(amdgpu_hdmi_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HDMI=
_HPD_DEBOUNCE_MS) : 0;
> -       aconnector->dp_hpd_debounce_delay_ms =3D amdgpu_dp_hpd_debounce_d=
elay_ms ?
> -               min(amdgpu_dp_hpd_debounce_delay_ms, AMDGPU_DM_MAX_DP_HPD=
_DEBOUNCE_MS) : 0;
> -
> -       if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_=
debounce_delay_ms) {
> -               INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, am=
dgpu_dm_hdmi_hpd_debounce_work);
> -               aconnector->hdmi_prev_sink =3D NULL;
> -       }
> +       /* May be overridden later by an EDID quirk in apply_edid_quirks(=
) */
> +       aconnector->hpd_debounce_delay_ms =3D amdgpu_hpd_debounce_delay_m=
s ?
> +               min(amdgpu_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HPD_DEBOU=
NCE_MS) : 0;
> +       aconnector->hpd_prev_sink =3D NULL;
> +       INIT_DELAYED_WORK(&aconnector->hpd_debounce_work, amdgpu_dm_hpd_d=
ebounce_work);
>
>         dm->hdmi_frl_status_polling_delay_ms =3D 200;
>         INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_sta=
tus_polling_work);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 9c4e0a4e2..71c897416 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -137,6 +137,14 @@ static void apply_edid_quirks(struct dc_link *link, =
struct edid *edid,
>                 drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %=
X\n", panel_id);
>                 link->wa_flags.skip_phy_ssc_reduction =3D true;
>                 break;
> +       /* Workaround for monitors that toggle HPD on entering deep sleep=
 */
> +       case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
> +               if (!aconnector->hpd_debounce_delay_ms) {
> +                       drm_dbg_driver(dev, "Enabling HPD debounce on pan=
el id %X\n", panel_id);
> +                       aconnector->hpd_debounce_delay_ms =3D
> +                               min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS)=
;
> +               }
> +               break;
>         default:
>                 return;
>         }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 2a732d19b..e423dbe9b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1217,13 +1217,13 @@ EXPORT_IF_KUNIT(are_sinks_equal);
>
>
>  /**
> - * DOC: amdgpu_dm_hdmi_hpd_debounce_work
> + * DOC: amdgpu_dm_hpd_debounce_work
>   *
> - * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles=
 HPD
> + * HDMI/DP SST HPD debounce delay in milliseconds. When a display toggle=
s HPD
>   * (such as during power save transitions), this delay determines how lo=
ng to
>   * wait before processing the HPD event. This allows distinguishing betw=
een a
> - * physical unplug (>hdmi_hpd_debounce_delay)
> - * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
> + * physical unplug (>hpd_debounce_delay)
> + * and a spontaneous RX HPD toggle (<hpd_debounce_delay).
>   *
>   * If the toggle is less than this delay, the driver compares sink capab=
ilities
>   * and permits a hotplug event if they changed.
> @@ -1231,11 +1231,11 @@ EXPORT_IF_KUNIT(are_sinks_equal);
>   * The default value of 1500ms was chosen based on experimental testing =
with
>   * various monitors that exhibit spontaneous HPD toggling behavior.
>   */
> -void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
> +void amdgpu_dm_hpd_debounce_work(struct work_struct *work)
>  {
>         struct amdgpu_dm_connector *aconnector =3D
>                 container_of(to_delayed_work(work), struct amdgpu_dm_conn=
ector,
> -                            hdmi_hpd_debounce_work);
> +                            hpd_debounce_work);
>         struct drm_connector *connector =3D &aconnector->base;
>         struct drm_device *dev =3D connector->dev;
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> @@ -1259,11 +1259,12 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work=
_struct *work)
>                 /* Apply workaround delay for certain panels */
>                 amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnecto=
r->dc_sink);
>                 /* Compare sinks to determine if this was a spontaneous H=
PD toggle */
> -               if (are_sinks_equal(aconnector->dc_link->local_sink, acon=
nector->hdmi_prev_sink)) {
> +               if (are_sinks_equal(aconnector->dc_link->local_sink, acon=
nector->hpd_prev_sink)) {
>                         /*
> -                        * Sinks match - this was a spontaneous HDMI HPD =
toggle.
> +                        * Sinks match - this was a spontaneous HPD toggl=
e.
>                          */
> -                       drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after =
debounce, internal re-enable\n");
> +                       drm_dbg_kms(dev,
> +                                   "HPD: Sink unchanged after debounce, =
internal re-enable\n");
>                         fake_reconnect =3D true;
>                 }
>
> @@ -1280,9 +1281,9 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_s=
truct *work)
>         }
>
>         /* Release the cached sink reference */
> -       if (aconnector->hdmi_prev_sink) {
> -               dc_sink_release(aconnector->hdmi_prev_sink);
> -               aconnector->hdmi_prev_sink =3D NULL;
> +       if (aconnector->hpd_prev_sink) {
> +               dc_sink_release(aconnector->hpd_prev_sink);
> +               aconnector->hpd_prev_sink =3D NULL;
>         }
>
>         scoped_guard(mutex, &adev->dm.dc_lock) {
> @@ -1302,7 +1303,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_=
connector *aconnector,
>         struct dc *dc =3D aconnector->dc_link->ctx->dc;
>         bool ret =3D false;
>         bool debounce_required =3D false;
> -       unsigned int debounce_delay_ms =3D 0;
> +       bool debounce_eligible;
>
>         if (adev->dm.disable_hpd_irq)
>                 return;
> @@ -1329,13 +1330,12 @@ static void handle_hpd_irq_helper(struct amdgpu_d=
m_connector *aconnector,
>          * Check for an HDMI or DisplayPort SST disconnect with debounce
>          * enabled. eDP and MST are intentionally excluded.
>          */
> -       if (dc_is_hdmi_signal(aconnector->dc_link->connector_signal))
> -               debounce_delay_ms =3D aconnector->hdmi_hpd_debounce_delay=
_ms;
> -       else if (aconnector->dc_link->connector_signal =3D=3D SIGNAL_TYPE=
_DISPLAY_PORT &&
> -                aconnector->dc_link->type !=3D dc_connection_mst_branch)
> -               debounce_delay_ms =3D aconnector->dp_hpd_debounce_delay_m=
s;
> +       debounce_eligible =3D dc_is_hdmi_signal(aconnector->dc_link->conn=
ector_signal) ||
> +                            (aconnector->dc_link->connector_signal =3D=
=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +                             aconnector->dc_link->type !=3D dc_connectio=
n_mst_branch);
>
> -       debounce_required =3D (debounce_delay_ms > 0 &&
> +       debounce_required =3D (debounce_eligible &&
> +                             aconnector->hpd_debounce_delay_ms > 0 &&
>                               new_connection_type =3D=3D dc_connection_no=
ne &&
>                               aconnector->dc_link->local_sink !=3D NULL);
>
> @@ -1356,25 +1356,25 @@ static void handle_hpd_irq_helper(struct amdgpu_d=
m_connector *aconnector,
>                  * HDMI/DP HPD signals from physical unplugs.
>                  */
>                 drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling de=
bounce work (%u ms)\n",
> -                           debounce_delay_ms);
> +                           aconnector->hpd_debounce_delay_ms);
>
>                 /* Cache the current sink for later comparison */
> -               if (aconnector->hdmi_prev_sink)
> -                       dc_sink_release(aconnector->hdmi_prev_sink);
> -               aconnector->hdmi_prev_sink =3D aconnector->dc_link->local=
_sink;
> -               if (aconnector->hdmi_prev_sink)
> -                       dc_sink_retain(aconnector->hdmi_prev_sink);
> +               if (aconnector->hpd_prev_sink)
> +                       dc_sink_release(aconnector->hpd_prev_sink);
> +               aconnector->hpd_prev_sink =3D aconnector->dc_link->local_=
sink;
> +               if (aconnector->hpd_prev_sink)
> +                       dc_sink_retain(aconnector->hpd_prev_sink);
>
>                 /* Schedule delayed detection. */
>                 if (mod_delayed_work(system_percpu_wq,
> -                                &aconnector->hdmi_hpd_debounce_work,
> -                                msecs_to_jiffies(debounce_delay_ms)))
> +                                &aconnector->hpd_debounce_work,
> +                                msecs_to_jiffies(aconnector->hpd_debounc=
e_delay_ms)))
>                         drm_dbg_kms(dev, "HPD: Re-scheduled debounce work=
\n");
>
>         } else {
>
> -               /* If the aconnector->hdmi_hpd_debounce_work is scheduled=
, exit early */
> -               if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_w=
ork))
> +               /* If the aconnector->hpd_debounce_work is scheduled, exi=
t early */
> +               if (delayed_work_pending(&aconnector->hpd_debounce_work))
>                         return;
>
>                 scoped_guard(mutex, &adev->dm.dc_lock) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> index bccb5d354..66fb82961 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> @@ -113,7 +113,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *=
adev);
>  struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqu=
eue(struct amdgpu_device *adev);
>  void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm=
);
>  int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
> -void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
> +void amdgpu_dm_hpd_debounce_work(struct work_struct *work);
>
>  /* IRQ handlers */
>  struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device =
*adev,
>
> ---
> base-commit: c92b5b607c1c8ab786fccf03d62352b82f6539ae
> change-id: 20260708-hpd-debounce-unify-896ad367bf02
>
> Best regards,
> --
> Nick Haghiri <nick@haghiri.net>
>
