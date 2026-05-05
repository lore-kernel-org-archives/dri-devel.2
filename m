Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B213CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 08:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A2B10E0EC;
	Tue,  5 May 2026 08:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZVEtgKED";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D82B10E0EC
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 08:55:10 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7b23713eac9so53805437b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 01:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777971309; cv=none;
 d=google.com; s=arc-20240605;
 b=F7SuBTU+mhDF+yn827wUi/xS2LTegxCMCu8ZH1ZU1lzNQNbAJgKUmMLLdXqMxnKQTy
 qNyRfRfslFQfPe3kaZOvIc2HzXFyhvTiZUNzaMoMRkRcchADCzi02IgeVu9E8LHtI7BH
 zMdJ1ryPhTGqFvu0wcYcWmoKSsksbt+s2yJ7QIqt/DnX5I9791MzbsRHNDL+WCm4pNZq
 OuaHwxHWRa5hnKp6FET12Sq+Dq1sgblxV5V3D7hXGVU6kMKM5Yx56Rq+o3vDWlkr2ynT
 sfOrVE562aqW58zDfFC0QTNa3hGD0TKMap5mIsfr2mZDVXl9GOcZnBX5NrxWFCjJfIhq
 km9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5CJiKZ0puXIp3Q1auWZfkkziQVLi6lqLtkGVw6xnCsY=;
 fh=wxSxyG5pFpM6Ed1gOt5H5Xs7qIP9RTGPtvGsqh2k4mM=;
 b=ccEthymiGJ0Oh2/4U59nEYHuX4ft+XDL2m5h7COHFINS/347Wtg33lx8xdSxTSK4y6
 cn60pbndcfWTFuYlRSdAb8sRWYbOzO6N+NmJm5IljI1DXSd6P1Wjo7/MWj5lR8aT3T5m
 T/tKWDWvRugYHW/mY6qIIGWL3LuUp9MlrMooSij2UHBcPAZ/s3w/fVHTsYHTwqj/R23p
 i/EbnHPx2YWky3ao8wh2py7IW8IqufCJNhhidpU0uPcls6H7CMThZbHh8V3GanO9k46K
 /UQC4gAvxlDUj6gTHK1SbbtE2WrSmXkVaQwkNWflVt7YlmbodhoR7OLWYR7SjlXawpdK
 gIrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1777971309; x=1778576109;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5CJiKZ0puXIp3Q1auWZfkkziQVLi6lqLtkGVw6xnCsY=;
 b=ZVEtgKEDOEnFD7Oxq8rVMN1mWrhNQSlSRL9a0AeMKiCCmBac6n4ODyGiJxGOhgTY03
 o+BMhl5EtNFHNKATmBjkkuOt3HapzIAcCUqtRNTAJqCUlCTJzzReOhNosR98ywgB0BrT
 qUZZ6x+68d7ttQMbwK08mNT2D/ega95+8AQaZNcWv3ZJ7MunESK6V4tnxyQEcnqPPC5J
 ldqVKT/93fDcsa49FpZ2rC1fe/rOxjbx3VxJEiuaFKm7181xYP/099WOYkxJhku8ndiV
 F16MHfCRc/7gVHYn9R4U2REHMvqKWu5XhIcENGdkVBet+nZYdQaboFmYajVWaahGE5ii
 q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777971309; x=1778576109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CJiKZ0puXIp3Q1auWZfkkziQVLi6lqLtkGVw6xnCsY=;
 b=KuWpNDangzrCFNnNK5+gvP/hVC6Ldgs+lg8rXWhzMbMPIHTKQPKIIN2h4V8qiI9fGa
 tUPH4z3sqSiW9WH3nXcHaNR6jrdL/Rpn2KGzINkZxhFxJ3ONZ6BEzrmXTh2nYAF8LHVI
 FxfPrYZkkre3ghjZl6LUHW0yRtHW39aQ8Oofw64y8P/GIvD7xTxYZ9kIBiPdh3fPR8dV
 CyXznC3Rgcnh3VHmJ1MD+FM8k71E1+jUmV4tbwIr3CghbEn9Fy03ZkJBs9qnN63q2IqS
 GoUnv0nqJrB/eP/G15GS9npEAHQUGqw2XTsVQ8mAlzEIXhnCUgBd3NnEMlqDpBk3ZU9Y
 Vc2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0yBO3SrLIvWFTgRf/1YIC3FbL8ao6cDcSW9VKf4z0H0GQFLRQJjFD5uGgnGgPTCX+wERbhr7vzTQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYDFDKe8eWaXzmvB3fKJ4mKBIR7/PwWb7P9P6cClUYYXoVmvdE
 dm0UwIFJRfYjDip8tIejDVnt3Ya/g0Nk3yGcAcuz55d/stFJlJZuY2qcherQTbQ0Of0rsQT22Zl
 SyIWSabe8ooVD+z9tyhyyhKvTsP5a6igu3aI+DbEwVg==
X-Gm-Gg: AeBDieuu4CQJZXDqLwgPnwaNBJEDo+Fc+DJ200oJAP5FVxbeYn6M9ncZtVdipoQiqXa
 2HU4I2UYvjBQlu1RJfaYgQ17/eBOQqlB+75tVxWplnomBGFjW86sMTrArcsyXf4SGYF4Tu3X5tE
 zD23QLWOT7Nii8aWroMQVarqmVByzOV1pkcKE2uCps/WUqm5mdJCar10jcwkNCeiB0rA/cSrrsj
 14dawCZVSI9JlVrLqqvgaAGUFiR9RCi2AqgpOoDE6+LSOBfqL2t1faEVGATYHpbsYq/MMx8rLYg
 zJJxGlzhsM3ulZKiXISHJugPBVVA7aIvbE1rHMjUGyAmEKs=
X-Received: by 2002:a05:690c:319:b0:79a:c40d:b701 with SMTP id
 00721157ae682-7bd76fa3ec3mr146040217b3.13.1777971309131; Tue, 05 May 2026
 01:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260502121251.39206-3-thorsten.blum@linux.dev>
In-Reply-To: <20260502121251.39206-3-thorsten.blum@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 5 May 2026 09:54:53 +0100
X-Gm-Features: AVHnY4JHEMwCFYtgbgcAbs-cm6Q_iZoV4kpejbmHYNcZDwD-WyLuqrs2o_jiYpk
Message-ID: <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Eric Anholt <eric@anholt.net>, 
 stable@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Thorsten

On Sat, 2 May 2026 at 13:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,

Mainline doesn't use overlays, so this description isn't valid.

Which generation of Pi are you using? Whilst they all share the vc4
driver, the functionality associated differs. If you're disabling HDMI
(and HDMI audio), which display outputs are you using?

> unloading the vc4 module calls vc4_hvs_unbind() with
> dev_get_drvdata(master) returning NULL.
>
> Return early when 'drm' is NULL before converting it to 'vc4' and before
> dereferencing 'vc4->hvs', preventing a kernel oops.

That leaves things allocated and clocks running, so bailing out isn't a fix.
I'll have a look to see why dev_get_drvdata is returning NULL.

  Dave

> Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index ee8d0738501b..9cb66f696fc7 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -1753,10 +1753,16 @@ static void vc4_hvs_unbind(struct device *dev, struct device *master,
>                            void *data)
>  {
>         struct drm_device *drm = dev_get_drvdata(master);
> -       struct vc4_dev *vc4 = to_vc4_dev(drm);
> -       struct vc4_hvs *hvs = vc4->hvs;
> +       struct vc4_dev *vc4;
> +       struct vc4_hvs *hvs;
>         struct drm_mm_node *node, *next;
>
> +       if (!drm)
> +               return;
> +
> +       vc4 = to_vc4_dev(drm);
> +       hvs = vc4->hvs;
> +
>         if (drm_mm_node_allocated(&vc4->hvs->mitchell_netravali_filter))
>                 drm_mm_remove_node(&vc4->hvs->mitchell_netravali_filter);
>
