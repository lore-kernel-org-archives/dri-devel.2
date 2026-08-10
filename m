Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D59C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768A710E171;
	Mon, 10 Aug 2026 15:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTC0cVXs";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAE710E48B
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:29:06 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso161715a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375746; cv=none;
 d=google.com; s=arc-20260327;
 b=mpgfnmxCU0fbXG4Re4o8quIQR6IqVMTUVDsUUNdoSCdWeVItTzcHvbpippd7XVzY9D
 WZnZMGvVl7QDHP/GgqZG/Z2UHZTwpRyVNvY0HEy8kMdNvaY917Y3FZwZHYg6G5ytgY5j
 WgE/QncwUh/osADAS0X+nnT3IXgj/oDb93dkK1FS9zE3Djqg0NJZ9fxEpIhjIgDSNllW
 S161yEvwBjOUOhWmsglT+GTVSBEOxWNzo7+KB96bMYVzmkPEB6rv6zbvGP4on213yMOi
 pQl5sEKH8VK9vWljFklnJu2SC3RlvSAMDGBNbsz35uvNxUU16+GSASqf6AGV0plY93mD
 Zs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
 fh=tBxD+UJuClRLVIadMc1I8jrUzhC1dDA3Aa4/DevIsp4=;
 b=NKKjAYH6JbKiS7UXg6NvTTcyXwQj7X3N2sHnAtwFWrKT6zq0uSKZtjIh7zfmOxPFtR
 PGZmUyWsZsVoKE7rLxhH0446oZfIxcDBzZ2Pv56cp7K87vD/kKGlSKyubmyYLi3kxxLt
 ucZPGQnduFe0ooPELVNumkpT1gnO8XgtTl4H8Mmu8+RT/MBoiF8jiMx8R5SYZlUHO/cB
 IqpPtF6PUTmaEYdNl1hnydjN8koZdl14W5oVc/ehEUgG3Q3LBJldd7oS9WOWPMO2lt5d
 1HqSW4l8KmXT1p0Q6fUUjjzvwAAHPNTbrWoD5c7fj3BifTv4BVArUUwpwMjIfx386yl6
 HCKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786375746; x=1786980546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
 b=XTC0cVXsdQdHDRqOr/kjnVyj/V5I7wga34snOvyNP4+0OKxYJ/KoTMTNOy6pRTS2Y1
 R/3KvDqIbAAi1SDxa1+d4n11Vf/S2h9y0kcXJZ+1kWI2/5pw8R1Kk8tQgX8IBZt0dyhj
 bcD7eW5uj1lM04S8GSjR/IL8/su49MHrdLv4oefZxYfDk7B8ZVH4z1IxV1qdDFJlegSF
 v0tHc3cnk3V0KnCQce5b65ppRsAJZmsYVy6XYwRnkPG3ri1aHiUYubCGw43CC8P/1NyG
 JTR/YKw/exVBeK2OQnq6jpfM7Oi7YCTveL9RR7qGCoRmGebMaMzJoj1HQVGSKi9SJSBp
 Z1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375746; x=1786980546;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
 b=XJY0aNY8gjD+blCRRGBYaxkn3wfl6If8XGkWkZanXjLjsHSJh7m5lua8h+EZBL4s/r
 N4IgRookUUuvMlzCClC4f63qJy4bjeyaxjQsSwU5l5ki1eEUn2uBcPa+kKIay9oRCRI3
 +CJlJ+25kr6Bxv01bKFaWxjkXdYnoPGrR3U1jAv7maB32CirQRHH8ix0SfLswp8ylFw2
 S5AxWftkB7dwV3W1o5CdHcqlWV+CbkaNt0WMsL/uGJqmrx4lWUzI681JoyFr7Jop8Rq9
 TGngNVo89hE6VUrG4Bj/+JVP0qDa6qWvYW/+Cz0ezXZ/nd4syG04TBLb8UE4G8wBhMlc
 mMPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9u5skZIoC5TgW+vBvSH4TLuUYy2jn2Ue1Zh8a+SKVBURlm8fksT0eAzL0yqGCaZcNzvH8/Zbj2n8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf6su/NAK6lscQ3XR/NagUKlEFXna8LBribCtax1tr0AjU/Naq
 ZeHpZbf9tBuWn+pfDh4xBCCjGAJ3u4DFIZ29PTkneFyouvv+/qrdXBsk07X0v3O49I60+OossWt
 vT9VHKdaZ7KuQ+OO/50pXtg23vxAtZVY=
X-Gm-Gg: AR+sD1316AmHk3RkhmM31ihbftGAmgCB9rCnhIdzB8C6300WQ5gC+m5DoY0oJwLV4qd
 82Xy/ou884Yl3pqzo9AoP15n1auTuezhMAT54j9+pa3VJ0mIWz4EJ+gQCSUVupF3vdvq8jfoan/
 M8CAv/QdE0eFVA/4Eahlpn+niMlAGdEV4obfeBKR9kiIxNUEyEJ4cyetwg+NARUlbEwt4duBY8C
 7/CI0tH8Ck5+pJzrchsJy72NdjDMh40z/NgMmrAqJBv89lHZBeuXt96QuVmDSglRCYa7cNvbk46
 MOUgU4hCALbFuAdydo2s0sPxRvI/XNVRISfrp8eSFaNnSZ7KPabidkkDViPl4yNv/rTQFFPehoM
 QNz0A/zizaCSZwjK34y51VjJf98ofhBc=
X-Received: by 2002:a17:90a:ec8c:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-3903c5c101bmr32377324a91.1.1786375745798; Mon, 10 Aug 2026
 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260808135942.2880971-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808135942.2880971-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:28:53 -0400
X-Gm-Features: AUfX_mzxEVWjyMA91yyuAHYgB82GBMnbuh99tfXeZl3LTUv9kt3twL5mx0BLoL0
Message-ID: <CADnq5_MTp9ZJw6f0Pu52kS-sP4xrntBj4kBvZtkbmcd1LC6ewA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix autosuspend cleanup during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Sat, Aug 8, 2026 at 10:20=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> radeon_driver_load_kms() calls pm_runtime_use_autosuspend() for PX
> devices, but radeon_driver_unload_kms() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
>
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
>
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> unload path.
>
> This issue was found by manual code inspection.
>
> Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index dc43fd790a9c..4a99c09f4164 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
>         if (radeon_is_px(dev)) {
>                 pm_runtime_get_sync(dev->dev);
>                 pm_runtime_forbid(dev->dev);
> +               pm_runtime_dont_use_autosuspend(dev->dev);
>         }
>
>         radeon_acpi_fini(rdev);
> --
> 2.43.0
>
