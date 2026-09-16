Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8E6C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1425B10E124;
	Wed, 16 Sep 2026 23:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JUun7hBa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C920E10E124
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789602517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnxlhPopZDA9jrGnXRXH2XzZuWhm3/u3li0L+5ojL0Y=;
 b=JUun7hBaw09j2WH54JtKiMqxDFRR/rr7tL8FTJuQMx6ZT6YSXGrPp7LQPeBhrsVBmn9MFi
 NmG2LieMrHCJFSeZDyQaKMq542+8ai8W1d3AW+ND7KYCaOvACaai75MbFZBtw1VIjn+E61
 YLDMZKqq5o94OOp7PzQtLbwwiledNZQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-jKEg-xTOOwqo-pPu1flsJQ-1; Wed, 16 Sep 2026 19:48:36 -0400
X-MC-Unique: jKEg-xTOOwqo-pPu1flsJQ-1
X-Mimecast-MFC-AGG-ID: jKEg-xTOOwqo-pPu1flsJQ_1789602515
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc51591102fso297703a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789602515; x=1790207315;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xnxlhPopZDA9jrGnXRXH2XzZuWhm3/u3li0L+5ojL0Y=;
 b=MK5rz19yx7G1TN+gQzNCDHlbrCsiO/pSbUplf+v+iT4mFhKWqVmvQZMEOaFf2PLrKl
 4kLlCTrFqkbIcWpZ6asB9mRB9hizkF0UoLG0crcUFrgI9nfLcoxUzRehi8NL/+fH2/4b
 qhGL2aEoufMoW9BLo3pCeT9EG/V1WVluP2Wh1dnEk08jmGVcc/c8d7OF6VJ5jhi5w7Fp
 l0zrDoQosf8SXbhJLnPH+FDzOSvf6BJ7nO6gF7WdMpVbQWvUVlxnvdT/UCxCV6qe9ZF2
 W856C66HK6lr9HqkTa2bpqGgSZ4RHIQZ+Yrk+hn2BuyXRotJwyigtEtBMyXILqPshtw/
 TCjQ==
X-Gm-Message-State: AFuF++n0iJEhQ+ciUbnCXxWyob/PCm6F5/Zkl5PAmuY+o0B2rKNSRGLb
 HSwVoqOc9uK96I9p2Ub7gYvr0l6v0E9PSmJsK2yY5Az7nWxgSoTdIDYvBMqqwW0f7t3LDO2qWGL
 d+3hSmRUExO+mc5CeIZCq9mtQh50krrVtcOMCT2gw/w+8hmCQB5J6RTS2NpC1/otIYhKF0kYuFj
 6RzLY9/5UcqsiLzfXXs+dsQx21w9kkwvgrO4BCSxW9o3S8
X-Gm-Gg: AYBFou0g7SBRnIn21E71LvipVAHa2+tIztPpHmmPwSM734Ht9m9QZXApuRKplwAn3/o
 mwS+X5k1PFWmvyB5BF90JoNu38PQA4s34spl7SRsBU78JO1VD9fmBsOUXo+PAr44KtgZC4DAUkG
 A8y4bAUkBNFfE0FiT5W47gHNdqPPgi0zm0+ZyrDKpe1HV5pTh4LvxGTrvrbnkNA1b6nmfinK4Dm
 /GNXGCGCrGBqD7d
X-Received: by 2002:a05:6a21:6b10:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3dd5f6fcf23mr11578375637.21.1789602515345; 
 Wed, 16 Sep 2026 16:48:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b10:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3dd5f6fcf23mr11578329637.21.1789602514925; Wed, 16 Sep 2026
 16:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260916223358.507351-1-lyude@redhat.com>
 <20260916223358.507351-2-lyude@redhat.com>
In-Reply-To: <20260916223358.507351-2-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Thu, 17 Sep 2026 09:48:22 +1000
X-Gm-Features: AcwNN1V8GFuFBGj8sz9eOODt6sJo4wkIs0f7lYVi3FbrfgfAjEUxRByMOdrQ3Zo
Message-ID: <CAMwc25pFFJ5vL4QajybiYrvyS+Dd_iohvQNEHTFZVTLjzJe0VA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Mel Henning <mhenning@darkrefraction.com>,
 Hongling Zeng <zenghongling@kylinos.cn>, 
 Danilo Krummrich <dakr@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2o_Ab0CXhKLIoPYAer-JlVAwn0FBAe-M0IrxlH3rSvw_1789602515
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

On Thu, Sep 17, 2026 at 8:35=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> OpenRM's runtime PM handling looks a bit different then nouveau's, one pa=
rt
> in particular that differs from us: OpenRM actually consults GSP to ask
> whether the GPU should be allowed to enter Gc6 and/or GcOff before runtim=
e
> suspending the GPU. In the event the card isn't ready, runtime suspend is
> simply delayed for a few seconds before retrying.
>
> Implement the command used for querying GSP about this,
> NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE, and check to ensure that
> the GPU is ready for runtime suspend in nouveau_pmops_runtime_suspend()
> using this query. If the GPU can't be runtime suspended, update the last
> busy counter of the device and then return -EBUSY from
> nouveau_pmops_runtime_suspend() - essentially delaying the runtime suspen=
d
> process by whatever autosuspend_delay_ms is set to.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---

>  static int
>  nvkm_gsp_fini(struct nvkm_subdev *subdev, enum nvkm_suspend_state suspen=
d)
>  {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h b/drivers/gpu=
/drm/nouveau/nvkm/subdev/gsp/priv.h
> index 71b7203bef507..b07797813b049 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> @@ -93,6 +93,7 @@ void r535_gsp_dtor(struct nvkm_gsp *);
>  int r535_gsp_oneinit(struct nvkm_gsp *);
>  int r535_gsp_init(struct nvkm_gsp *);
>  int r535_gsp_fini(struct nvkm_gsp *, enum nvkm_suspend_state suspend);
> +int r535_gsp_gcx_ready(struct nvkm_gsp *gsp);
>
>  int nvkm_gsp_new_(const struct nvkm_gsp_fwif *, struct nvkm_device *, en=
um nvkm_subdev_type, int,
>                   struct nvkm_gsp **);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h b=
/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> index b6683a5bf870c..fd1170037c030 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> @@ -782,6 +782,13 @@ typedef struct NV2080_CTRL_INTERNAL_INTR_GET_KERNEL_=
TABLE_PARAMS {
>
>  #define GSP_FW_HEAP_PARAM_CLIENT_ALLOC_SIZE      ((48 << 10) * 2048)   /=
/ Support 2048 channels
>
> +#define NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE (0x2080a7d7)
> +
> +typedef struct NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS {
> +    NvBool bIsGC6Satisfied;
> +    NvBool bIsGCOFFSatisfied;
> +} NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS;
> +
>  typedef union rpc_message_rpc_union_field_v03_00

you can drop this hunk if r535 doesn't have it.

Dave.

