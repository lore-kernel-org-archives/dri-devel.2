Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE081CD98E7
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125C910E770;
	Tue, 16 Jun 2026 13:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyfOQyY6";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E0D10E770
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 13:43:03 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-306f1213aadso408557eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 06:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781617383; cv=none;
 d=google.com; s=arc-20240605;
 b=cY2ACLELjZSl2kvaZnGZEdcIiwDCSvi9FtCHdnSsncj1Z28ROg6lupiFONz1TuNXED
 krsHJkEktgRwto3444N8pkL8HAWdpuP3jQt9dXu+IHhu77jmhNk4BhUrI+1WxS7djIBI
 HqpvBUehWWEIL1/hrG+bNodtDhsM5OZ8T33uHD165gHi7YBA68VxzR1JkZE76Es2kgEp
 yF9GYzEhK5yUWa+QVo0cJmKFZrlzV1XlL9hfycUOzXzP3aeTh1Ydf/Xaqst2NMBgPd8j
 /8DbraXVcy5vKO5k9YFftMXwoK6dLKAN7+kZpCrt2vPg+BcIuwyBxwc6HJWMdhU+pwEL
 8SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W+TMpqhNDrpSCOhtOJFDgnIMfyVz3H0yI9bEvZGS9fw=;
 fh=0EoE3nLG7zBfqGIXoPrSrtHuIPfURRvJQaSdg/lb0mA=;
 b=ExAFEztamzkFAnOrYMleDscGp65xa4UOq2MLNjXx5Hec4MSEDrepdap36NTPE76/ZP
 z/GIpu8ZOUT6Bvxz+FCyEbBV4j4YfUKchUfnW59FXiTscLqbFEiVYbEleiwuHf1/OP99
 52XJ+1pyeNeES975SOA/ORd5+x74V3rVS1AeADJWq0eOr5F8pvdd3LOizwbbuFP3lnCC
 iJYsDpNgIXxQD/kJeU+9uMAmkJE+bvfEm0okWKRyNK+Cjv30B5pyNoLdWs/TXt9Zzh5w
 MzwBzLaJx8pnPnyKiqm50yLE05K01kHL+c4mhhPmnY/ap+TstuF+gTRQXypVYnkcALki
 J1RQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781617383; x=1782222183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+TMpqhNDrpSCOhtOJFDgnIMfyVz3H0yI9bEvZGS9fw=;
 b=CyfOQyY6W9rBsXIoDjINZ5SR5q3f/Ov/oYY7obyM2Vo9k2q2WaGsdD0IiCy57Rupyb
 l//5dZkp9aDFopMfYOxpn57CMjyNMLNl3PJXJ+QbhkNKSLvo0VnHIRUY6rlj6WGlTpO8
 kpUdyFMdAy8NWy1HKcaL/PprIK+3r/oaaRT7V69pQQa3/jLnUSctGRY/L3wmgYXZDo82
 YlP0DvAUcZCiw2quAvwPUbVSHm5JFoD2SoP3J830it8FmScxl4180swblp6vFZgGwcVU
 Pv6Dgv/U12nVZ5gvhUmEFyMnYtsR2UAum/IlTZP0raJiB5vusAJJoJN1H4s7YZICFliI
 PcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781617383; x=1782222183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+TMpqhNDrpSCOhtOJFDgnIMfyVz3H0yI9bEvZGS9fw=;
 b=IWx6s6X2UU7w19XEMbftMVKEvBnJo56W5SOExm7UM9qBXj5WCfllz3PRETCyROI2Kr
 nrhQ+JYIZc7k3AvrFSng9PshhVOTa8ItVboxMEfjhYpnd1dbIj/FkOQePx5CMlcQ6Kyx
 z0YK2r26wUTbdxMfwKjs05OH7Rdz6u8AsgPvu9VVvedmraCJasmO5D+1WDYG9A6UTu8W
 fuawk+4g6L3ZrA33Q5aC95EAp9FohsPW/GkoMkCc2f4LBZ8LD8Vs7HVrnnGFE2HQ6C0T
 +wZ8Jo7fifFkvSWt+9qJrLBbQBKWdHJ5bv1EUIGhaERhbJsZnmb1+rfXbC6CIqcMrEVb
 m/0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bRn7T+YmHAdXkyZQwFVWNzW1r2kVD38ngJvhLiroKvcU0DJKDFLzBr+9vrA9cn5mAhTqmYWZJqEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyea/aT49SF7z2edn3lVTq4HCfSvsbGf3nKy6lPyOPNl3GZSYRB
 hALKwJDggH0EXGjrnnMOdMVWQ2+semcgVsRI6YCEkNbJfHdSNpXKWcPRhZ0nPUmCrm5jwv6PQh4
 Rhw62q/R3xzUPISFMFlm4rLLcC8q4E8Q=
X-Gm-Gg: Acq92OFo3ssXuZCxgAktwGg5BEWfnH4rvqhWB805p70uvP3oBFVDchWLkR24Rv3JsmK
 abmUmPrG7u0YVjY4+FL/k/Ek2b/FrnG/yn4FepSSOZJSCR2iq56CDgEN5cY/ERyTkd8riBZyt+A
 vlcY1nKE+x4mwCo1qcIFXHnMUFM9rURbbeUUZnc4tYiVKr3N8aBskCgIseE5BI1cfMB5FuJanEK
 rOAihr6ez7TB06kgunRZgnsiu6zHSQmsxNtBeVZDDs8LfTIXXpMsHpZwYavSkGvKpGtG2oY36R/
 t3DsieDc4oLXS8ln34XaZyu7P8HkH2CKQaFOJct98fbOk0YtjXUFovV74qoEXYRcmhPXiw==
X-Received: by 2002:a05:7023:a4b:20b0:136:bbe5:395e with SMTP id
 a92af1059eb24-1384bbb1e89mr2789479c88.5.1781617382781; Tue, 16 Jun 2026
 06:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
 <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 09:42:51 -0400
X-Gm-Features: AVVi8CfrK6K4H74bKw2lBz35LtUNNuuxNHtfu6wvLCZb4TbU4zW6J4w_SYn2FJU
Message-ID: <CADnq5_NgGCDKXLRmyu1_TCQkUfEUDnj0n1X2-Gg6Bg1Ya+o37Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
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

On Tue, Jun 16, 2026 at 8:51=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> When amdgpu_init_minimal_xgmi is used, SDMA engines init
> is delayed so amdgpu_ttm_enable_buffer_funcs must be
> called later.
>
> Without this, the check for num_buffer_funcs_scheds will
> fail and using ttm buffer funcs later will fail.
>
> Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for tt=
m")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 57e10afb4714..2e8954fa5c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2479,7 +2479,8 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
>         if (r)
>                 goto init_failed;
>
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> +       if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
> +               amdgpu_ttm_enable_buffer_funcs(adev);
>
>         /* Don't init kfd if whole hive need to be reset during init */
>         if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index faac80a8a6eb..c0dca209335e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1663,6 +1663,8 @@ static void amdgpu_xgmi_reset_on_init_work(struct w=
ork_struct *work)
>                 if (r && r !=3D -EHWPOISON)
>                         dev_err(tmp_adev->dev,
>                                 "error during bad page data initializatio=
n");
> +
> +               amdgpu_ttm_enable_buffer_funcs(tmp_adev);
>         }
>  }
>
> --
> 2.43.0
>
