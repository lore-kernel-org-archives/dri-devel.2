Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FA8F5A8A6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942B110EB11;
	Mon, 20 Apr 2026 18:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f8/c0jf7";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8310F10EB11
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:19:11 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2df943e0a96so305038eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776709151; cv=none;
 d=google.com; s=arc-20240605;
 b=XgwjDw4WEITalS5bVKEsVhqk28d4oCuTp6YZYphCiu8eFjX2Ngd4lXueFiJ0EEivvY
 d5OEc776BvwXsainpRnyXJy67aa0yLd9Vgiic5MIO0wPVTz0otbIRo7M5s/HFxP8qGQl
 8sQabea9b9RU5amolvfVVZT92umMuRFJLBnqijgrRdWFHOl5QdHpMD2E+Z1XKFdiLltP
 kYcmiYxX8j8q/zRdPWlr0FrlSGEuYLATvvbalKbKGciQd2q+ydzBwuMPdhmRw+Pdizje
 GjxChY3eQqlhRi1gHexHS0ZyKbpwp0kjwanLk3UOJ7rmM1udjw0X72meGXN6bjjqevcD
 X88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fUhuWDIueHDOmZUOGkSQ3o+4DGa8DTvlk/gUMio5LIM=;
 fh=UiyS6cxKMKXFwbhcDxay0+PBPVHqohDCtexPibfv1Dg=;
 b=SVSVzc4TUYK2yUWE5IqnqGW/Uu4c7EyQ5eit/XLObPn2Y84Fjt4mDfFpO4nSEXrIC9
 x607EdWiYnXNfmMfcN42uuBZz3FqCJ4xKhfEf5gbhn7m7xa7uqWhvCXgo7BrGaXSe/b7
 hbBnuFZKPjEzOqzZuFmYdmQbQQ7YtHqJ1Oxg+/nsA29SHfFm5Fm5v1rBRrXahniOW5G5
 m1ujclpohHcjzVmEFku2sGFhkayXgWyGKS+vxRrhJrIRBtLJYNgVDVlaZfsAf4f4KAOS
 awGMbzvbSxLgIKNVh6jefleCDNk3hOd2YYQvPvMollHCEENt46n66OCkaUUxKQ3CxnU1
 6HTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776709151; x=1777313951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUhuWDIueHDOmZUOGkSQ3o+4DGa8DTvlk/gUMio5LIM=;
 b=f8/c0jf7s5JEpwVULGI+uBc4AiFqvSkW3pqD+2nQmR/xyrFViHfQzuSjfxWsbo6hUA
 m4nzHZI903p8MSazLzUAOCMYvUE1Ap76L+pKeQ7qh9h/gZnIc8hvRqq6JBp4iP+5wozr
 bgUpVt9P7yTLrPeXexDjtKLZcczhHZjHjAetc3hB51hnl/lsLtvGZgroGrJPIaVECj2h
 DST4S8cTzSfZsUlqJtLeDpQluw7JGRaGL4ySAZdXinLexj1idUa8y7KQ5LJYjOWmyn5M
 do/OuNCdPaLZ25cxSMrtf+NBatgZ/NKadKBGU8V8AEO5HDZslx/xMV+xIUI3NLEckV/M
 O0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776709151; x=1777313951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUhuWDIueHDOmZUOGkSQ3o+4DGa8DTvlk/gUMio5LIM=;
 b=mt+KK1zy9smNsOmTu3s9RuXGV0iqB9Aa3EUPa70edT+e3jyHSNk6gQM59y8K0m+yx/
 l0lC++MaN1EXBHP0ymOEo0VouvkJLG1TL+hfGwWjxK6inq8LghJTiGd+aoFc3iTNHFfc
 lNvM9TNmnz5FuW6SKZ6E2CjApG7jE+PGieWRUklB0XAKcQkJrus7RWUQNwPYezn/uen5
 XgCLzqxEjxZS59P4dq6PBmwJ90cu3UZzMHLlSmrJaUUcVqTY7GU8dRAu3wiz9CqbfwqP
 60gFk/sHM3yzNnBeEjwdzqKIXqST1ymVXXTp5nlLfwCuEBsWCp25UdJJGVzLXao9EVlI
 2Tig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aiKYfQyATxLQuxgwBp5pJJRtqtXIQjcGL6xTlKdfMC+vn7toqeIo/tTSCVls5JgWTxLCmZ8xCI7k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsGCRPpzbDrQ76lD+m08Qt76quTe2IKavcBjw69vEf8xGTHiRJ
 21CxvJf5YUbbVd0LMXiu878RFKl6r3noOLJSrYdlAhFgxK6hVreDaUrr2mI7X86pvdFVU467TJH
 6/f4K5PMVZpg2R2unKe76NgP9NwplYdU=
X-Gm-Gg: AeBDiev02d1S0pZ9MuHfm6RS6TGqWh/JMUvg1QvlmtXyB8Uqug9pL7X1yB355Tb9MPP
 PrhVsyX28qafvlSwNVogcqgnbGLFh8BwQIKAwFHnPpVm/wBCd/s5eMXAHqtw7lxkZCDxXeUSNsc
 nvc0oCW8QY64wq+Uqg4s/hG1OqHj844z3qz9PnFIb7SnLDvnVk0iZVBI3Vcf357AwPtpmuCgfNf
 gg1B4PSYSm/jQL7CNf7LkkOV2gADd5E/bWYr35fcQZAbtZSnGkwLAei44gglpSbtN0EsI5/J/0N
 h8GQiuy5qA3MeTYHcWk5EyP6XUpELJCx13drbiQibAvhci2J66k9B/ShlmReWu7AS4Dz9Cj22kP
 lY5Sy
X-Received: by 2002:a05:7022:b94:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-12c888baed5mr1468132c88.1.1776709150559; Mon, 20 Apr 2026
 11:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260420032858.10286-1-giovannauchoa@usp.br>
In-Reply-To: <20260420032858.10286-1-giovannauchoa@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 14:18:58 -0400
X-Gm-Features: AQROBzAvcxyrnRf8OWlITOMNY1-J0XR4u4JTJ0fGQZu6ZgvamyeYhJ-Rc25--HE
Message-ID: <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: consolidate SDMA trap IRQ handler
To: Giovanna Uchoa <giovannauchoa@usp.br>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Mon, Apr 20, 2026 at 9:09=E2=80=AFAM Giovanna Uchoa <giovannauchoa@usp.b=
r> wrote:
>
> Move the amdgpu_sdma_process_trap_irq handler from version-specific
> implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
> module (amdgpu_sdma). This eliminates code duplication and centralizes
> the trap interrupt handling logic, which is identical across all SDMA
> versions.
>
> Update the trap_irq_funcs in each version-specific module to reference
> the common handler implementation.
>
> Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +-----------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +----------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +----------------------
>  5 files changed, 47 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 321310ba2..4f15334ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device=
 *adev,
>         return 0;
>  }
>
> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> +                                    struct amdgpu_irq_src *source,
> +                                    struct amdgpu_iv_entry *entry)
> +{
> +       u8 instance_id, queue_id;
> +
> +       instance_id =3D (entry->ring_id & 0x3) >> 0;
> +       queue_id =3D (entry->ring_id & 0xc) >> 2;
> +       DRM_DEBUG("IH: SDMA trap\n");
> +       switch (instance_id) {
> +       case 0:
> +               switch (queue_id) {
> +               case 0:
> +                       amdgpu_fence_process(&adev->sdma.instance[0].ring=
);
> +                       break;
> +               case 1:
> +                       /* XXX compute */
> +                       break;
> +               case 2:
> +                       /* XXX compute */
> +                       break;
> +               }
> +               break;
> +       case 1:
> +               switch (queue_id) {
> +               case 0:
> +                       amdgpu_fence_process(&adev->sdma.instance[1].ring=
);
> +                       break;
> +               case 1:
> +                       /* XXX compute */
> +                       break;
> +               case 2:
> +                       /* XXX compute */
> +                       break;
> +               }
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
>  static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *sdma_i=
nst)
>  {
>         uint16_t version_major;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 2bf365609..ca4fd94ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_dev=
ice *adev,
>  int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>                                       struct amdgpu_irq_src *source,
>                                       struct amdgpu_iv_entry *entry);
> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> +                                    struct amdgpu_irq_src *source,
> +                                    struct amdgpu_iv_entry *entry);
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>                                bool duplicate);
>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/=
amdgpu/cik_sdma.c
> index 120da838a..1bf1af633 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct amdg=
pu_device *adev,
>         return 0;
>  }
>
> -static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
> -                                    struct amdgpu_irq_src *source,
> -                                    struct amdgpu_iv_entry *entry)
> -{
> -       u8 instance_id, queue_id;
> -
> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> -       DRM_DEBUG("IH: SDMA trap\n");
> -       switch (instance_id) {
> -       case 0:
> -               switch (queue_id) {
> -               case 0:
> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring=
);
> -                       break;
> -               case 1:
> -                       /* XXX compute */
> -                       break;
> -               case 2:
> -                       /* XXX compute */
> -                       break;
> -               }
> -               break;
> -       case 1:
> -               switch (queue_id) {
> -               case 0:
> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring=
);
> -                       break;
> -               case 1:
> -                       /* XXX compute */
> -                       break;
> -               case 2:
> -                       /* XXX compute */
> -                       break;
> -               }
> -               break;
> -       }
> -
> -       return 0;
> -}
> -
>  static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
>                                              struct amdgpu_irq_src *sourc=
e,
>                                              struct amdgpu_iv_entry *entr=
y)
> @@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amdgpu_d=
evice *adev)
>
>  static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs =3D {
>         .set =3D cik_sdma_set_trap_irq_state,
> -       .process =3D cik_sdma_process_trap_irq,
> +       .process =3D amdgpu_sdma_process_trap_irq,
>  };
>
>  static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_funcs=
 =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index 93ec52c1f..545077897 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struct amd=
gpu_device *adev,
>         return 0;
>  }
>
> -static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
> -                                     struct amdgpu_irq_src *source,
> -                                     struct amdgpu_iv_entry *entry)
> -{
> -       u8 instance_id, queue_id;
> -
> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> -       DRM_DEBUG("IH: SDMA trap\n");
> -       switch (instance_id) {
> -       case 0:
> -               switch (queue_id) {
> -               case 0:
> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring=
);
> -                       break;
> -               case 1:
> -                       /* XXX compute */
> -                       break;
> -               case 2:
> -                       /* XXX compute */
> -                       break;
> -               }
> -               break;
> -       case 1:
> -               switch (queue_id) {
> -               case 0:
> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring=
);
> -                       break;
> -               case 1:
> -                       /* XXX compute */
> -                       break;
> -               case 2:
> -                       /* XXX compute */
> -                       break;
> -               }
> -               break;
> -       }
> -       return 0;
> -}
> -
>  static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev=
,
>                                               struct amdgpu_irq_src *sour=
ce,
>                                               struct amdgpu_iv_entry *ent=
ry)
> @@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct amdgpu_=
device *adev)
>
>  static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs =3D {
>         .set =3D sdma_v2_4_set_trap_irq_state,
> -       .process =3D sdma_v2_4_process_trap_irq,
> +       .process =3D amdgpu_sdma_process_trap_irq,
>  };
>
>  static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq_func=
s =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index 3fde9be74..b3eab4e11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struct amd=
gpu_device *adev,
>         return 0;
>  }
>
> -static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
> -                                     struct amdgpu_irq_src *source,
> -                                     struct amdgpu_iv_entry *entry)
> -{
> -       u8 instance_id, queue_id;
> -
> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> -       DRM_DEBUG("IH: SDMA trap\n");
> -       switch (instance_id) {
> -       case 0:
> -               switch (queue_id) {
> -               case 0:
> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring=
);
> -                       break;
> -               case 1:
> -                       /* XXX compute */
> -                       break;
> -               case 2:
> -                       /* XXX compute */
> -                       break;
> -               }
> -               break;
> -       case 1:
> -               switch (queue_id) {
> -               case 0:
> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring=
);
> -                       break;
> -               case 1:
> -                       /* XXX compute */
> -                       break;
> -               case 2:
> -                       /* XXX compute */
> -                       break;
> -               }
> -               break;
> -       }
> -       return 0;
> -}
> -
>  static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *adev=
,
>                                               struct amdgpu_irq_src *sour=
ce,
>                                               struct amdgpu_iv_entry *ent=
ry)
> @@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct amdgpu_=
device *adev)
>
>  static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs =3D {
>         .set =3D sdma_v3_0_set_trap_irq_state,
> -       .process =3D sdma_v3_0_process_trap_irq,
> +       .process =3D amdgpu_sdma_process_trap_irq,
>  };
>
>  static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq_func=
s =3D {
> --
> 2.53.0
>
