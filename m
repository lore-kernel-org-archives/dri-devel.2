Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEC8CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 06:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1359210E0A4;
	Wed, 13 May 2026 06:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYqbsXlk";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C336F10E0A4
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:56:49 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-67e9e343b22so8015148a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 23:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778655408; cv=none;
 d=google.com; s=arc-20240605;
 b=T6rMAs20KAoK9jZuB69F5uJP01UrECT2twiiGFJWReDXcT3E8ISaoMmjrcX4wPcRK/
 061/Hkjqoz5Hru3Nd8VSJZiGJGeOGvQnhTgckDVFL90mVWyMzzAcvmUyZJuopU7TDHHX
 UaovawLELorWwv5P5LHqcqGAnMGoMT6XhT6eBXVWlok4G4OqhKHD/7rVfTjZlf0HIp7b
 jUWzlRhE5prpcayTdFXgPPF9aMIDbAp8eA58uFqStlE93Z+S7fp4KDFfWwIl9S/kbvgr
 v6kBO5RdbTdjSLgim/T3RE/J9AcHaAtgY2i+aMLthj6vRPwl3sjCcX61sMc5hIt1sQZh
 tjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PhQrfUdoCB4sAIkMNxghhrLtB7UyCZQhzPzKjzBTkvg=;
 fh=xuB4Rkd8K3xlGT2A3y8fbILyThwHKzVEXY6MoBt3fHU=;
 b=MjdRYMkgizxFkdvvksS3SfqRSmaPrSeJCT6s/NBFq7yc9xDZNdDb+RdaAemZM8GdnX
 q8c8YL2u0jfMmrguQLZAlF5AhdzYM5UqalRxceGzYp5h8UWZh+OrvMRtK7NEwlwfhcBe
 LRLa9XD32cRpAaoV8VBXInaqiKADogJmraIGN/gLjN6p8VJ30Rucb7X0AS5tbhMdNM98
 hvDc6zN9xllEjVBZuAbBccLmFBKEiLfSxt8ueyLbZ/FzBdFlUG0bpihVtgdNuJrnzX0U
 4qJI1MQRrkay5/C+gyh90vAkolYFZjU5+94Fxa4siBfo351ZX1Kzl5K/SeCJVJ9NX7Pu
 b2lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778655408; x=1779260208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhQrfUdoCB4sAIkMNxghhrLtB7UyCZQhzPzKjzBTkvg=;
 b=UYqbsXlk3aFbwf3OlpKZdpjR/oe0SHaEUEnDOgN/gcthujXIPXgkVGTXqeCzUSarTK
 SpZ1+Bi95zMHUMenTvRd2776uT+JQK0rjOUiNDzx00t8j8/zoF5sd9KL0Aw43gVeUFqV
 +n5x2Hrsf2gllJZD0WirTt0cNLr7xJ9bTUjpIaZWcfrqcsGePlny6ca9q+MXac+bRAKx
 /cD8wKxuSsXvImVNGhpKAaHoWk2UyRXcVH6tVQyHaednyu7u8OUmVluziwKxsLiIQ+1V
 bhX9I+x/jjDDsk7PNpGwZJcqRiYBM7L4PsO6XBObEnEWrlI1PVlGOHXMT+LTIRfAH1lR
 ij/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655408; x=1779260208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhQrfUdoCB4sAIkMNxghhrLtB7UyCZQhzPzKjzBTkvg=;
 b=BsoDMaOoqz2jp6jJHi7mVFEA2TGJTPgN2qkiqvSKy5M6UDaiAjJQlUAwCjIvPf+d+r
 OxLHv4u3FM4o3Az5zRHaaGtILzgYPNyMCBgJezzOadcF6pjFd6bKsHDa1/RlJTQSSJ8/
 CLYI4C7JtNz+8acCWDQqs+sOGh/gWIME02iNoNsaBN3MmY2q3lKtdzyU0QfIkXg/2M1L
 nFAxDZ1wzmY6IoRnhNqOEMmiOjEweN2a+U2eu7CpYaW5cl0xJw06f1gvDVxRpOpavWl4
 /gcHIBNp+KB6f5vjoDrjv63jC1CvKRdNLWul22fHDbKJLL0Ei7VJRM2CBsAei01YswJJ
 fv8w==
X-Gm-Message-State: AOJu0YyRDI9j1SROQkhKHvjjxSci+lTVTcJpBnNIeFEGkY4TvTUgGnc+
 bNWJLFa111WVsLh1PN3FMvrXld3hAUw96y9GTLf11c9WaVACGFnBDlWTxXxCJf/WI9DQmsm2cCP
 3aZnAE/HpA1lLRZWaxWZWOjlSd5MXLw==
X-Gm-Gg: Acq92OHs/ejcKSeQeedP0o77cPS7jEccVE2DZCPXBQi/rP5jHrr3GiuzfF7/TYQxkGU
 EKCgFOjjxZUxLsmnS3/QX3u4u7glspE+jdU03sgQqF0FRXlPLNq5OBfjoUIE9/knLfkeNsAGL5J
 E8/8dxtoI553qPbEZkYAQZk3XAANHaXMtSgc3e/SSlXqXTzIr+RWbTYYxNOa6oBA8XTxkUbgz64
 XU21x6wn/bsH2es/UKiwtSUFoMu9+mmJEJf2aJ3oEje1lA1CoPdHkWrxe9PzPC/YTSdJ9K12lbm
 cwiHJvJ8gzFF0IPzdDapf3V32rqGH3J4SBOHywvgeGcWZnZ1Vw==
X-Received: by 2002:a05:6402:540d:b0:67f:cefc:e55e with SMTP id
 4fb4d7f45d1cf-682a6ffc412mr700461a12.2.1778655407946; Tue, 12 May 2026
 23:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260512063657.53100-1-mhun512@gmail.com>
 <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
In-Reply-To: <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 13 May 2026 15:56:35 +0900
X-Gm-Features: AVHnY4LvdNuNmbwJChRYGIk5bqxuPH0-UHkrhalvT-vYknhkMn5VdF1AEOsEtMI
Message-ID: <CAGEsz8E37y4+sk4kMVsZ1nHJ4e_qLbCWx=a5iK6-stG5KwtB0w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Huacai Chen <chenhuacai@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sui Jingfeng <suijingfeng@loongson.cn>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
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

Hi Huacai,

Thanks, I sent a v3 with the subject fixed and added the Reviewed-by and
Acked-by tags.

Best regards,
Myeonghun

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:11, H=
uacai Chen <chenhuacai@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 12, 2026 at 2:37=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com>=
 wrote:
> >
> > lsdc_pci_probe() initializes KMS polling before setting up vblank suppo=
rt,
> > requesting the IRQ and registering the DRM device. If any of those late=
r
> > steps fails, probe returns without finalizing polling. The driver also
> > never finalizes polling on regular removal.
> >
> > Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> > lifetime and automatically finalized on probe failure and device remova=
l.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> In the subject line please s/use/Use/g, others LGTM.
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>
> >
> > Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controll=
er")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
> >   and Thomas Zimmermann instead of adding manual cleanup paths.
> >
> >  drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loon=
gson/lsdc_drv.c
> > index abf5bf68ee..4b97750897 100644
> > --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> > +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> > @@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
> >
> >         vga_client_register(pdev, lsdc_vga_set_decode);
> >
> > -       drm_kms_helper_poll_init(ddev);
> > +       drmm_kms_helper_poll_init(ddev);
> >
> >         if (loongson_vblank) {
> >                 ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> > --
> > 2.47.1
> >
