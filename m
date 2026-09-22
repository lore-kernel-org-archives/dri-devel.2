Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CB6C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D6610EB8B;
	Tue, 22 Sep 2026 13:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PldQqJJp";
	dkim-atps=neutral
Received: from mail-pj2-f37.google.com (mail-pj2-f37.google.com
 [74.125.227.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6E010E952
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:30:28 +0000 (UTC)
Received: by mail-pj2-f37.google.com with SMTP id
 d9443c01a7336-2d6ff2b8503so2441145ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790083828; cv=none;
 d=google.com; s=arc-20260327;
 b=fUEb6Dg/+B4AoRzAhUI0WiIIhAigmw/GOSpA4jbAwKO8kZlXfWm2Xgc+2ey0TSGytI
 sSOYPNiCZynJab2w6IirI0dcoTd511uOzBKcz4kHoxQQpa0xqS2qG+2jExN9x2qfvpxc
 yQs/gPg/5ohgke9aEFBBkkeMvzzHsc/VBbyB31I9PFzMBWo07fNL+RQXvqa6ttVN+j8c
 J09dz7/foIsTDuIqlQJeZbbPfKuPykdV3FfmiSYFFMQR6Gr6AxPObwHPNn4X5RdDR2j7
 bgDZHmtN60A/Q998f/IPFJinoDD00Vt5jVVmT0LnlgGjw8BLADG8q4nNZXeG+MG9cBLw
 lnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/wA0KBR683Rxf67wOoQaReSR/BOf+zjptaqpc+T3kfE=;
 fh=L5aj19wVw20/duBJsfYmluUmkXi1Qgq/S17jyF+cbaw=;
 b=F4LJTe9swmqHlcpEoIhcAotbqB2o1GwmzOFXUxUelislVON4ydRN3YF+zz7ki3kQhH
 2/5IiHDdyL7j/Ofwlo/871j7IUR5NhT6ywwHUm66puwGDYoJecrDOp7EiF8SFIYRG3Ou
 NG2PpIFgiH8VAx8/sK/mrWJmGsvGYGyWjRM+iTWtHfytOk9DDCsyT0JakO82tlkUerwj
 OqMXc4AglkAxfDHEWIB+Y64XN49zuLAVbYrHk3ofBIQqEsVdIIh/p+KvihgfHz4Vt1HT
 vr83tBQB6Obn1FEsgC++KMUB6Po6mc/TAdoM385aHzDbltAvFIBFpX2Axta7u7TSGijG
 /nlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790083828; x=1790688628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/wA0KBR683Rxf67wOoQaReSR/BOf+zjptaqpc+T3kfE=;
 b=PldQqJJpoAqcAqB50R0B+V4h+WzjI6Q4J2LmBEPGN47MrEOwrOFJRNpEr8Ewac9pFk
 CkvF7S/LrCDwCy5EllMmZ8BCUNWDkW8KQ+ogSuQ2bj92h68W391LMWWaeCFQkdx3p42f
 T2oqi0T3+AtS+UWHoMEDq97n3iuWOcnUQ7aU2cxlYV2hIFIOQecjqijNPR+7zXcPOrpd
 TVbIG1VIlNIntBwWbQTkTZOvbNDTnb8XnJoNlVdyCzpWgfPnhjrGd2Hg7NVSiMfvnREy
 gBgp6bQJJSnCHq+jcrgM3IgiA6HahbwrDyKjaXJZdigkOghvQqwKe96UmP0x4qSxFj4K
 2kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790083828; x=1790688628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/wA0KBR683Rxf67wOoQaReSR/BOf+zjptaqpc+T3kfE=;
 b=lIzY/UkwSyocwhrN3t2DYbzYrpjs8wRffgbtZuEU5dBvb/tloLuwKqG7ChCqC2xTBc
 dzwLzwCb8HI9sko38ul7fl4XicCzsLvgmG4fOucswR2daYuXLMIkvQeR6N/m6AI2vJhk
 m8rSpiYgfXH8wftXTo6T6YiOOUclD4V5G9rgjr61ER8b+o6hxuLpzWEseX947eXUmKfX
 QHC0J2Bs+QoizYV0PDdQaPNMPKHPZN+TSmqfCkv70qbRrstYZ5Vz/GR32JEDBlUty4sr
 SqcJ6HUfaGdK1ET/Z5BEKwwJw+v6ZU4ngfjCB4NFkUpJMkEf+p7MRsNpOiBdSUg5tYsB
 XqQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNU2siWqv5PDPG+oEIRtazUZ5mkMiykECq8zCCMhyHnXqwjwqk1szlI42/MrCZgMY16qjFiUC0eCQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNRW0AzTIAjbm+EcgUn3ivD3Lh7pO9hHzJ5kxhd3LvGYd1fNll
 2yZ8ahz5IZhc6QtptoHgE7rVDrjGn3youSjBkFRx6w8kwbJQN9i/E9RSBHYhwG184AxBtfVSCxz
 bb7LOC6b2Hu/9btwoCpNa9chtla/5yQk=
X-Gm-Gg: AYBFou1qOyYOhdz2UNAtTEwhARMJFLluMW2QFb/xeqFrd7/liNFNsq2kH9MpXYp9nJi
 QFsv5H/iQUJMDo1TGDamtySDgHt+AuKI5qcDNu9qItRcHD4JZYCe3fD97jSZCjHeGp+tlMKaCrM
 pSy2v5SWplFh/EeoBYSXwvZK34n56EAPixSEo8TI3VylTPY4QbcBCcZvb+KgFxGlZyexsPhViB5
 58Wvv+bT7YcnQiQv4Ji2CyphoPAdTsOtMXPNtT0kHX59Gx+p+pyQe8fq+EW8mVylXL4I5s1zImy
 8Ome327ufbVDAY6XdvyjySAhaquzUyU/TfaJlHE3A6BBlL2JE4GvFbfjqI9icIVtypP6YfecLB/
 +zXFSXq+KpRCSMBQ0YapRrxDGDfah4eZ1WHhFJoMlAvzE5rcVYoFF
X-Received: by 2002:a17:90b:2f90:b0:39e:2f57:67c8 with SMTP id
 98e67ed59e1d1-3a07333690cmr2055086a91.4.1790083827685; Tue, 22 Sep 2026
 06:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260922015411.116292-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20260922015411.116292-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2026 09:30:16 -0400
X-Gm-Features: AcwNN1Vh3Py1nkVejJCuQAOkulIvl34lmizTsCKnEe3GX6RsIUZUqrjredfWcos
Message-ID: <CADnq5_ObCd1rXewb4YXEZVTF4R_ZM5Vib_Rnr21sAbpNTfnqoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mario Limonciello <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Mon, Sep 21, 2026 at 10:01=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> The firmware requested in gfx_v6_0_init_microcode() is not released
> when the GFX block is torn down, leaking the firmware resources.
>
> Add gfx_v6_0_free_microcode() and call it from gfx_v6_0_sw_fini()
> to release the PFP, ME, CE and RLC firmware.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 95e939363db6..a5553d181d97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -322,6 +322,14 @@ static const u32 verde_rlc_save_restore_register_lis=
t[] =3D
>         0x00000000
>  };
>
> +static void gfx_v6_0_free_microcode(struct amdgpu_device *adev)
> +{
> +       amdgpu_ucode_release(&adev->gfx.pfp_fw);
> +       amdgpu_ucode_release(&adev->gfx.me_fw);
> +       amdgpu_ucode_release(&adev->gfx.ce_fw);
> +       amdgpu_ucode_release(&adev->gfx.rlc_fw);
> +}
> +
>  static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>  {
>         const char *chip_name;
> @@ -3254,6 +3262,7 @@ static int gfx_v6_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>                 amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>
>         amdgpu_gfx_rlc_fini(adev);
> +       gfx_v6_0_free_microcode(adev);
>
>         return 0;
>  }
> --
> 2.47.3
>
