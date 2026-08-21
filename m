Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E363C5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2251410F3F5;
	Fri, 21 Aug 2026 19:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EXlx5jNA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (unknown [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543DC10F3F5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787340543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNXf/dJ9hBuXVYCJeUCVP8nSk43isZcQqKrxyAyY8Co=;
 b=EXlx5jNAwH0W5FwKV1xg94yptOpo6j2xVrzh/TGAv2MXXinln2qO3h64CvL8gJ0kUtmVyI
 d7QUaCb3UzLWbUk4CMGT8K/cC9u63vND+/NAj4tF/bk7K//QTNVERukF1o0pZbjx4ov+ZC
 oM0SOUi4z56Mb4dIjZz98fBxAm6MTqM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Kyop_bTsMMieJURyWyJuzQ-1; Fri, 21 Aug 2026 15:25:42 -0400
X-MC-Unique: Kyop_bTsMMieJURyWyJuzQ-1
X-Mimecast-MFC-AGG-ID: Kyop_bTsMMieJURyWyJuzQ_1787340341
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8db414c7so20341031cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 12:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340341; x=1787945141;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XTWvZVA7JaArjs8Zd1HxJ0CjIfwAygH13+3hEPTRLdA=;
 b=lcaMYPH2qTmEBRv+z6do1sX+tXOvRO2q3eFq4kUPdCB0GgqLqGgVQBcaJxclKvtB78
 XNjf8a40fnTmX+4ZcVdnPnbmErfKM1AmKFiEJxls25OU7KQcuAl0aEcNcgXDInNquGXD
 NKjWnraWNwKbQTb2RmCWJBX2bQFGy1PrKVIhby9Mgi3AF/mAOA5Z9fW25Z77uh+g+J3n
 6MPVwufVfEJpvrsBwyp/7+UM2nlNogM7rN1R1hW56AhwQlGVw0gBmUFltuEValhkmwEE
 ZFjDwAlayhCnecJvPk5YjctRxivHdtSGNY7rHp+WAiQVn3n2NJFyqZb1ZtRrFD9p9W0l
 Tryg==
X-Gm-Message-State: AFuF++nOfM2SpKgM7AHV+OFlYt5SexVu9gmJ+y1Gin1K/vguIqUHbjEB
 FRYyXi372uVkuIJhb8fy1yqBylYPgVJzY+qI0J8u7FQVhClW97rjLSBJSw0B0HsljSI5CfiD2Qz
 OoQZnOBANc5pXLQb8aLpMyD8k5jUsMI6cSBU7pqxjfMhM8g7ogTj3eUalFP1vqYZ5x0VwIg==
X-Gm-Gg: AR+sD10LxXfvOTKACAM+tU5TM64DNVSwqd5UK8FX3oaJIoiHxSlYLhVw78mJvxoM0W+
 5jm0zzq7f4VVp2gSs/cc0/XHxpOSqj86WtYUXA/XT/rlOYnA1dZAJVH+cwq4/aKqswYomKxjdfb
 i4WbvR0w/mCVmNP4OF+lhHhqXb9ng7UqV2YXEd4mb6H+8i+/+0dhTlzfhR20lp0viQ/e+3QQ94X
 F2KjGvpHG0y7jDtYlxxTEti7shPFEiQrAStB7WCbOsshmEmobngKJYvhC+D/WeiGHvgfIUFpfHL
 ODXkUe8TslX+bfX+ADf7TJmqhkZZrMj4sIM/Dir2bwyIalAa5AVrmUBH3n8GcaMF46ww3fwF
X-Received: by 2002:a05:622a:481a:b0:52d:78c9:9377 with SMTP id
 d75a77b69052e-52e09ce9a34mr4129321cf.36.1787340341450; 
 Fri, 21 Aug 2026 12:25:41 -0700 (PDT)
X-Received: by 2002:a05:622a:481a:b0:52d:78c9:9377 with SMTP id
 d75a77b69052e-52e09ce9a34mr4127511cf.36.1787340339927; 
 Fri, 21 Aug 2026 12:25:39 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09ae930fsm1418381cf.27.2026.08.21.12.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:25:39 -0700 (PDT)
Message-ID: <7509463d112de8807ba8be03a00a178a37891a94.camel@redhat.com>
Subject: Re: [PATCH v2 02/10] drm/nouveau/disp: move the GSP HDMI GCP AVMute
 write to engine/disp
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 15:25:38 -0400
In-Reply-To: <20260820164929.17117-3-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-3-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kcwzq0CgikS9OyFJ_XQOrj5N3kF-QWiKzHnho5wJNmA_1787340341
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

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> r535_sor_hdmi_audio() pairs two RM controls (a SET_OD_PACKET carrying
> the same General Control Packet, and the audio mute-stream toggle)
> with a direct write of the GCP AVMute bit through the SF GCP unit.
> The controls are RM and stay, but the direct write is register
> programming and moves next to the other per-chip display code as
> tu102_sor_hdmi_gcp(). No functional change.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c=C2=A0 | 15
> +++++++++++++++
> =C2=A0.../drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +--------
> =C2=A03 files changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
> index 3ba04bead2f9..5d682a774f2d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
> @@ -194,6 +194,7 @@ void gv100_sor_dp_audio_sym(struct nvkm_ior *,
> int, u16, u32);
> =C2=A0void gv100_sor_dp_watermark(struct nvkm_ior *, int, u8);
> =C2=A0extern const struct nvkm_ior_func_hda gv100_sor_hda;
> =C2=A0
> +void tu102_sor_hdmi_gcp(struct nvkm_ior *, int, bool);
> =C2=A0void tu102_sor_dp_vcpi(struct nvkm_ior *, int, u8, u8, u16, u16);
> =C2=A0
> =C2=A0int nv50_pior_cnt(struct nvkm_disp *, unsigned long *);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> index 7b70b466fa36..6cfd52c9056f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> @@ -30,6 +30,21 @@
> =C2=A0
> =C2=A0#include <nvif/class.h>
> =C2=A0
> +/* General Control Packet: bracket an audio enable/disable with
> AVMute
> + * through the legacy GCP SF unit. Used by the GSP-RM path, which
> sends the
> + * equivalent packet via RM as well but keeps the direct write in
> sync.
> + */
> +void
> +tu102_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
> +{
> +=09struct nvkm_device *device =3D sor->disp-
> >engine.subdev.device;
> +=09const u32 hdmi =3D head * 0x400;
> +
> +=09nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
> +=09nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 :
> 0x00000010);
> +=09nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
> +}
> +
> =C2=A0void
> =C2=A0tu102_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8
> slot_nr, u16 pbn, u16 aligned)
> =C2=A0{
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 8e57bb6519e5..cd4451e62512 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -545,16 +545,9 @@ r535_sor_hdmi_ctrl_audio(struct nvkm_outp *outp,
> bool enable)
> =C2=A0static void
> =C2=A0r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
> =C2=A0{
> -=09struct nvkm_device *device =3D sor->disp-
> >engine.subdev.device;
> -=09const u32 hdmi =3D head * 0x400;
> -
> =C2=A0=09r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
> =C2=A0=09r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
> -
> -=09/* General Control (GCP). */
> -=09nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
> -=09nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 :
> 0x00000010);
> -=09nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
> +=09tu102_sor_hdmi_gcp(sor, head, enable);
> =C2=A0}
> =C2=A0
> =C2=A0static void

