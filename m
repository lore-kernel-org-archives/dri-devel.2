Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF5EC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6371510E263;
	Tue, 11 Aug 2026 21:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="c2F2SqeJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDBD10E2F4
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786483622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyjTfJ6M6WhikLFiddpAGC6DAl6KdSUSHU1hQ6sGp+U=;
 b=c2F2SqeJBjBuTqgCP8FHmHO73V0kc1cuRjJY+568JAEgIFnwkAG+ENxSPmHsIK+RRdZBWv
 y89+MRtnwr0yUsTT2H7C55XuUKGUb745Jb2FuIabiw4zWAsqT/pU97e9LuVJb07Qc6epfo
 EtH1sTleuTP7ARFdNWTc+xVRKk3OQVk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-9IzfZPsAM0-t8i9xg8Alxg-1; Tue, 11 Aug 2026 17:27:01 -0400
X-MC-Unique: 9IzfZPsAM0-t8i9xg8Alxg-1
X-Mimecast-MFC-AGG-ID: 9IzfZPsAM0-t8i9xg8Alxg_1786483621
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso5461981cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786483621; x=1787088421;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rTYFSNNmHE5Ej6nfI5EPC0KoXgMH1Yho7tZYF93ZSko=;
 b=EkL9fcA0mSXV2n5xfNkjBdEUxlL77jkrYbTgYKp1M6pKHodtQZ5qLDZmIs5CcFpPkf
 6wKrfeG8aWIBm9N4R0F9qFn77D/+TVZlulTTLzPDLyUkNeZUiI85aHl+hRa4gE4EQHIQ
 SDO0AE2owONXUCCsegxsz/Ck34cQGFrO2gpA5zbExZ28/ywfEfcm0d9ciBm5W59dr/4I
 Ekyn466gXa8qQ20ujeORKba/yrDYoopBvSuz14lCuwH2fGjGI/czjBjsst0RDjhnZy/h
 Ae9+GG9SrMP72brZY3WAfBGQl/GiQto3Mi3UF4tOmjyyH1Erj2L1pOHPCeWBYXfKet7O
 WMow==
X-Gm-Message-State: AOJu0Yz9dYvc9QU/SOnfG88Bey5S5ovyjPHUBHHzdtfIPVAMcebgkOgg
 +LOzgSkfsY8iC5jY7j3atjgXz8LCgvSE2g+vgCdxIRIoccd2hTjn2NK6kHJt8IGZsJJWg4kePKO
 HXa9Lyx8LiMwDXXI4UeYia+qvJYLKtXSLmpP68PuFFweK2LieRHqStgcbkiMkvn8b4axn4w==
X-Gm-Gg: AR+sD12bPGEGIykcu/xgxJ0UWgYap89mfmeiFdUAz+xANt+gQr7NIpS5ZP3CYBGBX7D
 8QDvNI7YTs3JIeXVbyLnvC1Kwx+Lunp9tlsgLjt8Ep8nWwKugTqiW+b7C86jO9m1bkUlXyhr4Tg
 zgXmNHMmKuILPqaLHmznD5aDMypsZIYd5xYAIULWJ+cLOugwBfQ5qOUPKsD7y3Q7X9oPdXvtg+w
 0mLO1thE7tIqW7ZJmyx+THuzsAX4fNjVNCe1t/qmdUSG4CU5OW73wt+Djqiyt/LqPANOFcY2DBE
 riIw/5fe5DU/w/+8jj+s/D0DWC4OzGJ1UPs0DjfXdBjR/srcHXQMBDxA6W7B6dMsNZLbbXgd
X-Received: by 2002:a05:622a:1cc7:b0:521:934c:bcf with SMTP id
 d75a77b69052e-52d64838801mr2843851cf.41.1786483620642; 
 Tue, 11 Aug 2026 14:27:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1cc7:b0:521:934c:bcf with SMTP id
 d75a77b69052e-52d64838801mr2843391cf.41.1786483620229; 
 Tue, 11 Aug 2026 14:27:00 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d91199sm4729021cf.14.2026.08.11.14.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:26:59 -0700 (PDT)
Message-ID: <3449a374543614d15655576d13d87c3822e29896.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] drm/nouveau/uvmm: fix NULL deref unwinding an
 OP_MAP_SPARSE op
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Tue, 11 Aug 2026 17:26:58 -0400
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
 <20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EGk46m5z_ccP_OoOacXf3PFEpX-Qf3bOxBCj6SenSMU_1786483621
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2026-08-11 at 16:46 +0800, Zhenhao Wan wrote:
> Each bind_job_op is zeroed by kzalloc_obj() in
> bind_job_op_from_uop(),
> and the OP_MAP_SPARSE case in nouveau_uvmm_bind_job_submit() only
> creates
> a region, so op->ops stays NULL for a successfully processed sparse
> map.
>=20
> If a later op in the same job fails, the reverse unwind loop revisits
> that
> op and calls drm_gpuva_ops_free(&uvmm->base, op->ops)
> unconditionally.
> drm_gpuva_ops_free() dereferences its argument right away
> (list_for_each_entry_safe on &ops->list), so a NULL op->ops oopses.
> The
> path is reachable by any render-node fd holder, since NOUVEAU_VM_BIND
> is
> DRM_RENDER_ALLOW.
>=20
> Guard the free with IS_ERR_OR_NULL(), as
> nouveau_uvmm_bind_job_cleanup()
> already does for the identical free.
>=20
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index 36445915aa58..849bf42c124e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1489,7 +1489,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job
> *job,
> =C2=A0=09=09=09break;
> =C2=A0=09=09}
> =C2=A0
> -=09=09drm_gpuva_ops_free(&uvmm->base, op->ops);
> +=09=09if (!IS_ERR_OR_NULL(op->ops))
> +=09=09=09drm_gpuva_ops_free(&uvmm->base, op->ops);
> =C2=A0=09=09op->ops =3D NULL;
> =C2=A0=09=09op->reg =3D NULL;
> =C2=A0=09}

