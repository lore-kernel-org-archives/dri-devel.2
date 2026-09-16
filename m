Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C1AC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6576210E04D;
	Wed, 16 Sep 2026 07:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qK9p9D2y";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4705810E04D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:16:33 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so455546a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789542993; cv=none;
 d=google.com; s=arc-20260327;
 b=WocB0kEG4tEwkdeZVtrR2TrdiTXfBa7CajlVfE6JGDgF36iPKDIdeTZCbzfg9f91Z3
 8GQhhS8OU9mGGMz36ljDnurynXJDZecJP4R9uUyzv3UKLnfbcbRwuoJnCCY7ZF8hHs/A
 1eLQghUEfuPLfvK73S+jyZnVuMqK60lbpQ7kePr/Bc8d0Yp7CgVcfT/JmnXxL4GpK8EG
 PYvMjtnRSBLPtLKp98J5+bejQWb5Zj6/YZwmCy/SdZasAj+4Zvo6phfWT7tqPpr56Ya7
 hb4ANDKdurkWRBjndYIX/ihGGRLelZlOCa2pPcGe5bMASSsuYi5ptFP+LdpXhb9bUnWo
 nmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y6wIAcEKWE9nqg7/k3qdRoBKRXzso0r5nn1/whrKqBA=;
 fh=e5jraF2YUcw1kVVvdXgxKhhzomdAXGP4Imhajdg5XUg=;
 b=X2YySs1gbBlNFcBiyohYZe0QYtZd1DXWsFSCsUsei2gOjMc6mYlnigbzQ1i1muwlCc
 6sMBtmVo/IhoxFo2b7N9U71v+8Md62mlC/8hp1xyjfqQb/8l4A74cINGBfKjBLDcaKuS
 cZuX0tx04W68E26SPa7QhkJmXpu4S6lS2Sv3zncjZe/w3GWEAA+7ZoluNIgPTu8Xnksq
 3iTbgqwI3bUfouw+PHViQ2VmSNsDri4XQB46D0uTwymKwE1ZZndahgCBXXqvgVRGKgoh
 9Wwsx2m9a16u6//uwMWggcE1LVhpFjGZ01amxfQTbu+5s/JLkO2958OZE+y7YxykEyEx
 o6qA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789542993; x=1790147793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y6wIAcEKWE9nqg7/k3qdRoBKRXzso0r5nn1/whrKqBA=;
 b=qK9p9D2yuwRb15TpJm6R+x8G9qiOkVjEv420HXVPq6STk2aiQWepUJrsd6xwtytFZ7
 2InOofGtpspc5BjX8pr3BC0U5ik+bIEo25YWnv02lq4DcsLWpeSBMniFwThnfccNE1c7
 8GWFaM1M9dqu5VuPzZDRJ5BguRDPJ/1GxXAHcp5FjfLT48E7j5rCBygHLejGdcOxoyqj
 Y0uMYFF5XY2n4ScHSh2N49uWfjAHnvDK2A3wkrQHS5fjJZ2sHet4rVMAxn8CYmpYT4bS
 9KOHtHX3+raNp3H5IiZq5SmHxwA8mjcoXhOTF4zRYY01l7SiIWt4XFV/NlVY/vUzL+Pl
 v7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789542993; x=1790147793;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y6wIAcEKWE9nqg7/k3qdRoBKRXzso0r5nn1/whrKqBA=;
 b=flSZ1GRHRpNAy2Wsa1VMPek4Dclg+5dcjB1oRGuMlYbF3O/mFSRy/wEKcJzneGZZLb
 ou5G7maxQStT4MhMBqrMeUmPUzod8pdD/ZcHhE7E7CcrNq7UJuMTM4o4Uac8uHVZevoG
 DKaLMFrELzu9ILy3zSdemU/6q+5Co6zRTkXtKY1He9DeHiyCMkY0rgS9E57PkrBNZHjs
 dSr4bbH1w44xzezavVVGbQjqhhgv0+G/mrVcF1wJZ2Bv7b39xqOXsBRPALl5cDkTezSk
 Utp4g8K8CONYCjNDAVMie/TzJVVXnxZ907zZZ7tmtDAcOk1DgKhmmb+4FNdU45e25XEB
 rsYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFVC6dXf/EaC48q8IKrse+8/771JBZCN8fnPD+pHEVQgPfanr4EiZzBYD3jSKhlhvnu59QXR242ns=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJBBBC6dHuMX8Dkc0dPmGKeS6ujp9/+bMYapqrFrOiW59BmhqH
 azPOelw9XTmSPxAWLltpFi3wqFAF4A15ad6Xa+CdZMdgf4eI5CtVHssZLGjSEMtue1g7BcfmfdN
 OjJ3bMVIdaaVawk+BtRQhgiqBVV0mVYM=
X-Gm-Gg: AYBFou3/ZH1vqlo2Rb7iuX1RQxXqKyVJKGOKAJwuZ0f13McABP/TlhHmpJe/gIF4NrI
 CG1NMhna/WmKDIMGASi5KkKQuMeBmfyc3pXWkf6VmDsvwtvNy8UIxdR/iVVsOmHfVN+BmRxEG5J
 wyONBYBk70c5u5PFcp9mUX8uzYneucWoit5EClFNHf7n4QxZ07pEa/BRwZaDkLa0gE7YI/vYwGu
 ZYEaT/l4FIGDmF0axsNJPD71Bvp1hYbiCJaZ6XsI86VyuhmzfdFg5M18BzQ6ArP66S6q2OD5+yX
 7FwgmYcCgksBSZm0vtpNJiEKyQ35pFrDN106q8XbE/0n4GBBQ8i8A8uqGXf86JKnhXo6/anwJW9
 Ch7C1/7BsT82RQAYSwaqrEsg=
X-Received: by 2002:a05:6a21:6b10:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3dd5f6fcf23mr4128744637.21.1789542992705; Wed, 16 Sep 2026
 00:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
 <20260915-drm-bridge-drm_panel-cleanup-v4-8-30401d9406f3@bootlin.com>
In-Reply-To: <20260915-drm-bridge-drm_panel-cleanup-v4-8-30401d9406f3@bootlin.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 16 Sep 2026 10:16:21 +0300
X-Gm-Features: AcwNN1Wu02WhbDbGzw2qQ55m0JlviTMXZEyfe2ujg7uZXtgVBYhdlrVFke0bQq4
Message-ID: <CAPVz0n3kwZJTpanbCFzYKj=ysXQ_V=+uXjD5hY_n6OcDvnrx1A@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] drm/bridge: ssd2825: select DRM_PANEL_BRIDGE
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
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

=D0=B2=D1=82, 15 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 19:47 Luca=
 Ceresoli <luca.ceresoli@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This driver uses drm_panel_bridge_add_typed() and
> drm_panel_bridge_remove(), which are enabled by DRM_PANEL_BRIDGE.
>
> Leave the 'select DRM_PANEL' because it is needed for drm_panel_put() and
> drm_panel_enable() which the driver uses.
>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 73e13ad59a93..92938df3b747 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -351,6 +351,7 @@ config DRM_SOLOMON_SSD2825
>         select DRM_MIPI_DSI
>         select DRM_KMS_HELPER
>         select DRM_PANEL
> +       select DRM_PANEL_BRIDGE
>         help
>           Say Y here if you want support for the Solomon SSD2825 RGB/DSI
>           SPI bridge driver.
>
> --
> 2.55.0
>

LGTM

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
