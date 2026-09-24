Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7311BC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950AF10F4D1;
	Thu, 24 Sep 2026 12:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJEpZnC0";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E73910F4D1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:55:18 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-340f45daf45so19009eec.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 05:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790254518; cv=none;
 d=google.com; s=arc-20260327;
 b=B0bN+oSY8QH4W0Y0fJ5xrsCTgbkUaljMBWQ0eP0tcW9k+SUR629If/0dPSE+tcv/T0
 7VAP7QucNJj+Dl0FVo7uKVi57lDRSSAj8HksdPWJs9RKo+WwL3sKSZGv+LhaEqCwtnHV
 QqESH+3MLbCNaBOJLOh6ofwi4KgqVwRs6wR20lJUbGI8T4tcwq58q8zKxzP/YNLg9RaS
 DdDRNPjWRM5bOUgu33av9h+5kHXEcfNcHBRUyHiHCOwoOovt2AExALxiZ0neFpKnoLeN
 oUvQi4hG5o9F98zb9pEK9ABvXBig4i5NEDwkb77RIutgc988dTEus1KCEAvt5tASrLvR
 UmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6rCToHssiWETE8fAeMLU9/8ZLT7uDkl37EA8Ng9jTuk=;
 fh=Leq+ul1J6/Zdd7UkqrYOQnXn+Qlqh2i2mmtB5K+dPIM=;
 b=Bg0SGuTEpU6FVVAGuFC4pLNzcDSltidqr9+l85yTYTTIUIkgu1T9UOSQPTtvYe1c7e
 E11vUFZH8Mar3EXxKZXimWjnT7jY1TWEW/gilvwm1FGkMw15ZHmUOSS1I9d9EPMljpTU
 dTiLgdzj4faPVwkztAFO9ROwRTvkar9UBmfTUzW0Iu6HRdg9HXZ/TPFrN0+uadVghECY
 Z2Qli8GI/LOm0z9Ed2SQfya3lh8iRVItBB6p5mVu5mcJb+QZuKu4RfFDtxdMklWf+NA0
 7HtY5iqYhia0NkcPh3DU0bR8hRLpFuJNKOpeKVZ4lANEP0+7k11uOuDP0UBut8VmbRn0
 cfmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790254518; x=1790859318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6rCToHssiWETE8fAeMLU9/8ZLT7uDkl37EA8Ng9jTuk=;
 b=kJEpZnC0gnpJ3ZfY3qBq1f0dsepi+/86XCRqXOSHK7Nnd4GSCNYerbLjtJxlTUryJo
 s8Ww4PLeyw36YBUxNESNECorGOB+2wj4g53s1fNuygwsMsOv/mKSvSmwtvenyBRnZ4fw
 sRk08jVKGe/eH0KyyeDLz52j1lMZ/AqrTGmuvN+yhrc82nR6lklDJqwEI00gQLi+mb4i
 F++QQYokbv2Y6HUPtjmihzWApLXCjovyrL6Og9CE9yNz438XfCr+qeRrJW8ZbBfZ8Gmu
 3a9EFk69pWZNZwP1OKOQ2LhmCIW3RperUVhGJ8OkQ4ltfbGP+na6jTK/VjJ+atBheL3q
 rK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254518; x=1790859318;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6rCToHssiWETE8fAeMLU9/8ZLT7uDkl37EA8Ng9jTuk=;
 b=bLmQTJmtP7WfCUf3SPExi8pZHPzP5AlUDLASwoK2/39ehJY6FY4sY/o/7reH9XDM4V
 ySD+Q1rL4iRhYk2C3ohyotL7s2c3AZDgRQAD/lPrELmfV9RG9mLXRr5xRRVjvMksLwzf
 JVnVilYsAsULFccoT+fcVJudfrZ5wrZyKN5HWXL1bEvqNsokvHw7ndpB4Nly6GjZbgVF
 HU40YnRslihl489CaImUyj67L7kCfDgiisktMwTQQjAFgoZVJ2pi3KomzdeW59zMPZa/
 M/F5qlpn2xyMVD9cKvF7G0RkDaQ26GQd7Pi+DgOzmezzmBzUev6VMiqGrGtc0x+/6mfU
 Yafw==
X-Forwarded-Encrypted: i=1;
 AKwUvByObBoXT/OzTeOxgRISZ/uFcSnnVIWPcJn9tfK0vKwqCG+eLsvi7HBiBQ55AU1EpIs8F2XU/nzBvKs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLJ4oSWZDb11QkOkDHA0an+xw+YVyi/07Gg4bpE2X5odLzXJXH
 mgQUraFm6sYvTZb9PhZ265yHQSktG26KAHaqnW69Avs04IFthWcK6pElCgkE8jfNiDVwgLnCmZz
 APZhUVfpyM0E5CH7Y8BSz3BbxiMrgjpk=
X-Gm-Gg: AYBFou2Wgk7w/fcukIaxf5QQ549HKF7wRmBQ4hZqbPeUTVzQghGJCDcCxUplB9J26xa
 QvwjGTSUpRnfWedHjorv3bCY4OhhGGwTs8kzINb4RdgRR7R+nQEmHmGHaMD2r9StDnTOSbPUQwy
 BRejz/Q0fc9CZNi+KcCZ7ifRKGE+hnBXJBl70D+Kuz8ioMCLJiY5fJAYCex6TVxAtEhz/njg18G
 OCzl3EWEgZy5UBygWRSHQR+fFi9gl4p6yJTn9+t7GR+hU1Vflf1TJCdalLR+FtH+XaLGG8ZzOWp
 LQREE5cVNlHp9W2FulehbnNQoPDpeWoAc+wsLxnf0OMFUE+u3EfIZkQijYh/PheXX67KNqp+bRz
 EDoWzkXQE6ZKN3z+0l+7UgyddKBy4lX8mzedDuLJSrA==
X-Received: by 2002:a05:701b:450c:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14503f1814fmr2776445c88.2.1790254517596; Thu, 24 Sep 2026
 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 08:55:06 -0400
X-Gm-Features: AclHuK8rawtFh8RIfYGUl6NWaHxeKlnzIhQDBr80jpvjqrvakm50HhNAyVvXVcE
Message-ID: <CADnq5_MFzY4EQBeDQcR+Ca9y5GXXseKbuKyLgvu_wcmpHLaPaw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: implement workaround for sdma dcc
 corruption
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
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

On Thu, Sep 24, 2026 at 8:44=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> For unknown reasons, on gfx12 using multiple entities can causes
> random corruption of BOs with DCC.
> This workaround seems to prevent the issue until the root cause
> is understood and fixed.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5663
> Fixes: 3a6f6eeb3db5 ("drm/amdgpu: give ttm entities access to all the sdm=
a scheds")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 3d620ec2937f..a826e091ea58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2392,6 +2392,11 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_=
device *adev)
>
>         num_clear_entities =3D MIN(adev->mman.num_buffer_funcs_scheds, TT=
M_NUM_MOVE_FENCES);
>         num_move_entities =3D MIN(adev->mman.num_buffer_funcs_scheds, TTM=
_NUM_MOVE_FENCES);
> +        /* TODO: workaround for DCC corruption when moving BOs from mult=
iple queues at
> +         * the same time: use a single queue until the root cause is ide=
ntified and fixed.
> +         */
> +       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, SDMA0_HWIP, 0)) =3D=3D=
 7)

Probably just limit this to 7.0.0 and 7.0.1.  sdma 7.1 doesn't have
DCC.  WIth that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> +               num_move_entities =3D 1;
>
>         adev->mman.clear_entities =3D kcalloc(num_clear_entities,
>                                                 sizeof(struct amdgpu_ttm_=
buffer_entity),
> --
> 2.43.0
>
