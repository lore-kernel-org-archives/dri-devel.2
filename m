Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040B3C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 22:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E716D10EAB3;
	Mon, 21 Sep 2026 22:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQIYF63d";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8945B10EAB3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:01:43 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666e7c9efso268821a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790028103; cv=none;
 d=google.com; s=arc-20260327;
 b=ECV7vwW0dwix8tuElyIeMpWRQFZVRJc2upu0p8/y55Xc7eV1W4u5SCMPI2AR5s8kXZ
 Qbifqm29mHbJLlV/k08KLBsPKPcJ85z4JlacojvRkW5xTOTlfX05aoNNlyWYQCIbzPu4
 5n06bL/1VOzvHRf/A5WlEbptseLc7c6EOzpx867bFgfRWretudhEyMb+Wekc5rDknPwS
 g81/c2WTvs/ueKWhPwuX14iIDx9A00BSV6MGA+t1ttuD+DbsIbrRVe37U99nWdcnJaR4
 I4VZbBVK29pO9KxEqIgbNnvLzfvcE78BBezazmISgrm3/bnawcWKGM8JkYtkbkD+QC4h
 QWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
 fh=dBtiQeWlvpbZyj7bsBWvQ3+4a6xuxF9q1gdxYcNzuFM=;
 b=sv6o+O7QKqayJiB+yrnN9Ywu5QspBOCOFnO34WQuRplr196AVe0qthxOX5D+YlweC+
 ElS0XOgEKrV5XkpSTI2YCmErilkEpAd+S3yfQIQazZOPT6R3kulFGYa4LqGZ7aADoSRk
 d7NvJugCOzhglBhQ7z2crTW9pym80VBdNsmofUjIk/M5jDcN3Kqim8DYYfwFv+dycrZS
 n2IAYEQ12/u8WDZSZi/UN9BM6OJOZGuaNeJV6wt4VrMafziiQlrqSanHooY4OonrxEqh
 wJXbh0FDpA/GBTrjRP7HzbUV+VPKbculbs8MQrtnu0YYzWjWFOt7Ey+nYATO3AkYFH8b
 Vv5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790028103; x=1790632903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
 b=hQIYF63dSbEd2QPj1xyEcTl+DcqZnonuEzjl/01p1hpYHeT73CPQkRhcxzTAh+pOjC
 XL7gOlIV4u8FEsPAMxNzpWLWYLIGCm2DjLidlujtSsRZYQu8WQSAZIAIVqAYuc3e4ZGT
 2Ke2BKAx/2alzx8wxGvVquYZNlASmifvCHWG6p0N7EZ99V4DJNaoPvmH4MjfIKtcRy6c
 e9JFRKHHJhQXt/RDbUIQFDcY+QbrMug1ZAIKNSb1F7Han1V/K4AhSUiahPlCiItaLBzk
 VtwHha6xFo/BpHhZK9h+k3iGbBkdcza1aIFvFAnF41+/xRO+6kTt1VisDHnqz6Xr+YZe
 /OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790028103; x=1790632903;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
 b=WKBXDydgdq0xZX5SoT56lJ1jxHY8s6XmiP/nBMwHg9qks85fq0uCKzZAfXjQn9eGM9
 b6Mlmjwpt1lij5fbCHzsBel36BAPPylp/KW0xAKUkb6wWktNHIA35E+lduEM7hQmCKi/
 y0agoFcdoBxjZiyHmWrgEu2hg3zXjKcJ1ZpyIjKjlCeYgOLshSQHoolCxGnQk+dyGVVM
 JzwDHWz0ASWT7nY/AhlNEZScMgztzTzwe45RZMB/V5qca7b0K8i92H+QzdZz+cOZ4Hi/
 9eAwleF9MNhnIfXAAWHHTVVJVWBtVzb4MgcCHExPZ3aaS9GyuUwynhO17qB7G53xw3s1
 uOAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHXNI6CB4iwwSoBtvGL6b/BgmmFdBPxrGflQnO+AepKWL8v7js2h61bCUX9FsIWqKEPoDSdAArG6A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGvS6+zVnfAbHKZOJ/+OpxexQf6zoNu3vtiP0+JhYuJiki3KxI
 b7omNEW5TdsiMKj/8SrDRcKheoqAotypnXCDi8gC4GZJL523TTHThZ2sGsvBMhz0/GoPftAU/pp
 2NABfY2YE2vp0tsZyQtrDb4URjkFefdY=
X-Gm-Gg: AYBFou3lF1kSjcs5DT3kZHs9DHJiXTyiaVJmlVcnjRs8xcpcHf9YfgjrjE/gVAPumjA
 Zoq6uMW5t+wPjyqsROaT+0XwokNwH6v0Vd/aclGTbu9kZkfNxOTI8IG/U2ZW36oP8gixTtHOb/O
 qVDrOsXaPlD3MiC/7u72RwjtwhkF7bSd7VgK/etJSYI8seQypALBAfoR78wTbXXXELw36ES8RN6
 tTw+Bs03kxN9vFJRSVd8WgF/6tbWvkIW2qurh7m3729nP+q/ZoS1T4JtRwPUdTNKYU9EC/QJsqp
 KOVFzJlaP/ijyEYqCRb7qx4alDGIjcjQoLJSpUxQzBd3epvH8DPLPE7Z3G7vkdUU0OfQPGlLYxh
 g9tZSRIFrdciPhMQcDyZaDrmWOEr04PO0lcgEXvrMmg==
X-Received: by 2002:a17:90b:50cf:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-39e591e3bd8mr22753640a91.0.1790028103022; Mon, 21 Sep 2026
 15:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260921103318.353216-1-lgs201920130244@gmail.com>
In-Reply-To: <20260921103318.353216-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 18:01:31 -0400
X-Gm-Features: AcwNN1WqVwSStsMay_gri4_rw5IDdLWdJymJyP5EtqkVYtYOv-9on_0dL0POVzk
Message-ID: <CADnq5_M39zRZW57prCham1JSmUEo1dZOaaannkAsTA=LeLz8Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix ACP MFD device leak on init failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ce Sun <cesun102@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>, Brady Norander <bradynorander@gmail.com>,
 Kees Cook <kees@kernel.org>, 
 Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Mon, Sep 21, 2026 at 6:51=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> acp_hw_init() registers ACP child devices with mfd_add_devices() before
> attaching them to the ACP power domain and initializing the hardware.
>
> If attaching a child to the power domain fails, or if the ACP reset or
> clock enable operation times out, the failure path frees only the
> source cell, resource, and platform-data allocations. The child
> platform devices already registered by mfd_add_devices() remain
> registered and are never released.
>
> Remove the children from the power domain and unregister the MFD
> devices on failures that occur after mfd_add_devices() succeeds. Keep
> mfd_add_devices() failures on the existing cleanup path since the MFD
> core already rolls back partially registered children itself.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index 9014678d75ab..be4d00ac96b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -318,7 +318,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
>                                           acp_genpd_add_device);
>                 if (r)
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 break;
>         }
>         default:
> @@ -443,7 +443,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
>                                           acp_genpd_add_device);
>                 if (r)
> -                       goto failure;
> +                       goto failure_remove_mfd;
>         }
>
>         /* Assert Soft reset of ACP */
> @@ -461,7 +461,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 if (--count =3D=3D 0) {
>                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n"=
);
>                         r =3D -ETIMEDOUT;
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 }
>                 udelay(100);
>         }
> @@ -479,7 +479,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 if (--count =3D=3D 0) {
>                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n"=
);
>                         r =3D -ETIMEDOUT;
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 }
>                 udelay(100);
>         }
> @@ -489,6 +489,11 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_bl=
ock)
>         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>         return 0;
>
> +failure_remove_mfd:
> +       device_for_each_child(adev->acp.parent, NULL,
> +                             acp_genpd_remove_device);
> +       mfd_remove_devices(adev->acp.parent);
> +
>  failure:
>         kfree(adev->acp.i2s_pdata);
>         kfree(adev->acp.acp_res);
> --
> 2.43.0
>
