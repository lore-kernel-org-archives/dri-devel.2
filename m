Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08057C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D7310E876;
	Mon, 17 Aug 2026 15:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TfrzPhxZ";
	dkim-atps=neutral
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B723210E416
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:27:54 +0000 (UTC)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-97bed67f82bso67306241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980473; cv=none;
 d=google.com; s=arc-20260327;
 b=QtDAiM0YCRSDiWQhoVngl1oSQxALp61XbMtvqNcIKdr40o35QuVO/5xFNcO1eQVom+
 MR1WZLe6VWahGgZIcgiWp6nbC56AI2RZ0Nz8vssIgFqB6Qn5+SS2EOpb+4rm83jG5ZN9
 2as49QYHeA01rJg7UfAETnaHVmzJcO9/r2RtmksnO/t+bOOgD/UMfrNUENDopUcOQUEH
 gWrTwoa+hMi7Zf2jWAh26HuD0qnbKA4T95MFi+DLEzrrsGZyY4kWHEf017dWJqB2FGOy
 ricQT66HiM9uaUpkqBGue+1q5NQoygSjPZ5S/gUe0Pe6k1qGnkcUy/dIWGgTwXZ91gTs
 VPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j7Gz1gcwZac7xU6+dxpSqkGJeThcHsEFEecN33cuchg=;
 fh=PoSgSQP/5iCR1GM+AhQ9kc4RVGvcO0E6osSyrVHP/Cs=;
 b=NVOQ2wybm1BMMXabN+nGXDubSCBi1OhFHdve/MZAvn6I0PHHtrjskFXEFQNcHbIa5C
 1LwDapALG/grhx3MzNaogZUx84Lc3dOA5AfK2f8Unp2SBncZHQiQn35FtfWZIUvJoBpx
 52rqVuT2ISyKgn7EjnTNzMEhSt8PT3aHdJX4iinQTSVVgdlfExVlMTPSIo0nBzL1RrP8
 ndPNScjR+PNtwKYaQkXpH8ElDq6O04tB4Ec4vkJ/e2WkcGiX6Qs3SeaYG56lgOCnuQQG
 7/pi69h/YlZ8j4XTaSV3vapiG8U0fHnuWLAG4LYWW9zcgqnvhg9T+7FUrd33cjjga0Tu
 J4+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786980473; x=1787585273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j7Gz1gcwZac7xU6+dxpSqkGJeThcHsEFEecN33cuchg=;
 b=TfrzPhxZmMJjNn6UHE35Ni64FsKQXTfGcv0AuuvrsckEpZDshaCWerx6cO9TZydtab
 Vq0LUus8d7Kr8j/znMH9f2VMv45e/S7uTdCaeTF+cZvdjwSbuSzciibM7UbZgaAUJaOD
 i6AKgxn3xSbpf9mMyAc0FTVGd3JLfkxtW3+x2nGbJG6s6rlNzOt5X7ycoHclSy8ew+3b
 QgEflSfQi47K1QKCCtpu1SFX8+n14ucKb5SfNAekrmXSm6Ub/6MZi/ycDPexqWFBxoVi
 k7bQUdBa+tXyIYZsudrkWiWebUHxk9A8kkCoIBhb92l30TRkYQUJLsqQ9HejbzvJUUqn
 8zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786980473; x=1787585273;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j7Gz1gcwZac7xU6+dxpSqkGJeThcHsEFEecN33cuchg=;
 b=G1Ofpy5i4cGMmRFh4kLIb2SY3hK+oRv/LeEApblsb8c1BPeaMP4HGTT61qgSDa/9PH
 aVABVfrXX1Er4B0kuisz3275rbpoHoautRN9hcqZx/mha/5HKWXUBdV03na8CKfTQcP3
 ZjXhYjmNs/zptBrMiVn6UA5cAvFhVQZHauBBha1udYu/VJ3Lkz+UCI2K06ikHgR9n5tE
 HWVQzNBckNFpvOk9Gll9IDVjqmY7KT6QTx5lvQ/OhumexazYO7XxOmWiSXMp7wPF7qgI
 gC+Yh8UHsZRjCsA4jilbKJxEYatFQxppqq8T5Y2IzCnVpLMd3RE9kXzPi86QM1Dgx3iF
 7eYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYzuJNucDJUgfXRz+vIGm+z8CRFLGUXvV4XxGyS0+bTYtor9htTrawLJXoRVkyN8X6K4Mgg7+gPpA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAK3wFya9zNcLqXUL6X4n/5iaeOzhsbr1ZDNjDluzEDerzMHAg
 wM7fUbrIJnycThr4ki1KG7IvqfSpd9Gk4LoK9hRNSTl4qQmC5kgau/bZ9zsfDyWNy6VoUIKAxSJ
 k3tgjvvVUlJa6BYBqpSRsiOnH22kwo0dOkw==
X-Gm-Gg: AR+sD111CHHzGfJcICkaOdHyEWzEHCjoRXPOj6md5fFRmYNickhTvf8UCWoTO2M4UOR
 3M5WbBNDJdir6LqnZfiFnxXXxZg1+hMySLDjF/ixkVq8MiYeMeR4JOkrDnDx2+NDVSFCdq51K+s
 i1lvbdaBngOyUZqrnGN4bH8LaxwGHQNpg65Zvm0Mmg1ZVZ4LQZzXAWyA1l2QuO4ki823E1E+joa
 2upjUk9xmIZFe/rK57+7n6XBgH5xe5h3jBDE41zoxjgkn0dYkEJNhGWJPbu1sDTyVjIzelQ0Utp
 pSbZwzy72DuZuP2m02fUf1Un2hfdUDgi/HahZeFmzQqQPnaGMHamtZ/vLNuakOjYo1n1UR7ekes
 kYQ2Y9JlqLZ/LpGy/bacFpBnypadp2JE=
X-Received: by 2002:a05:6102:6888:b0:745:17b0:10d5 with SMTP id
 ada2fe7eead31-76f2cd6ba90mr1573367137.3.1786980473456; Mon, 17 Aug 2026
 08:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260815180033.8958-1-linux@treblig.org>
In-Reply-To: <20260815180033.8958-1-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:27:41 -0400
X-Gm-Features: AcwNN1XHUDt8s6mDwjoJ12PTOsnRJxLYjVl2DsSChp_Cj9bjnQi-HFN67HAYlHE
Message-ID: <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
To: linux@treblig.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
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

Applied.  Thanks.

Alex

On Sat, Aug 15, 2026 at 2:22=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The is_idle method in amd_ip_funcs is never called, however
> there are some functions assigned to it.
>
> Remove the bindings to it, and if the functions aren't called
> anywhere else remove the function as well.
>
> Remove the kunit test hook for it.
>
> In many cases the wait_for_idle code either calls the
> function which was wired to is_idle or duplicates the
> code (or curiously kind of duplicates it with changes).
>
> Based on drm-next-7.3 0d710af8e4abdd1fa500bddbab7c0ee47fc98143.
> Booted on my Ryzen with RX560.
> (That is spewing some warnings of the form:
> [    9.680879] [PLANE:44:plane-0] pixel format with alpha exposed but ble=
nd mode not setup
> [    9.680881] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode=
_config_validate+0x3c2/0x4f0, CPU#4: (udev-worker)/538
>
> but I don't *think* I've gone anywhere near anything to do with pixel
> formats etc)
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
>
> Dr. David Alan Gilbert (4):
>   drm/amdgpu: Remove is_idle test case
>   drm/amdgpu: Remove is_idle (trivial cases)
>   drm/amdgpu: Remove is_idle (non trivial functions)
>   drm/amdgpu: Remove is_idle
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  6 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  6 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  6 -----
>  drivers/gpu/drm/amd/amdgpu/cik.c              |  7 ------
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c           | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c            | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  6 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  6 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  6 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 11 ---------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 ------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  7 ------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  7 ------
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 13 -----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 ------
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c       | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |  7 ------
>  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |  7 ------
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |  7 ------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  2 --
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  7 ------
>  drivers/gpu/drm/amd/amdgpu/nv.c               |  6 -----
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 13 -----------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 13 -----------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/si.c               |  6 -----
>  drivers/gpu/drm/amd/amdgpu/si_dma.c           |  1 -
>  drivers/gpu/drm/amd/amdgpu/si_ih.c            |  1 -
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |  6 -----
>  drivers/gpu/drm/amd/amdgpu/soc21.c            |  6 -----
>  drivers/gpu/drm/amd/amdgpu/soc24.c            |  6 -----
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  6 -----
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 12 ----------
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  8 -------
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  8 -------
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  8 -------
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  2 --
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 16 -------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 23 -------------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 21 -----------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 23 -------------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 23 -------------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       | 19 ---------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       | 19 ---------------
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |  7 ------
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |  7 ------
>  drivers/gpu/drm/amd/amdgpu/vi.c               |  6 -----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 -------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
>  .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 10 --------
>  drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  6 -----
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  7 ------
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  6 -----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
>  87 files changed, 639 deletions(-)
>
> --
> 2.55.0
>
