Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC36CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E5910E104;
	Wed, 13 May 2026 14:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ej3HW4OB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED0B10E104
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:44:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DFADE44527
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21D3C19425
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778683470;
 bh=AcQajWoyianxBFqe9+pwgEA3+MQbwflajHJBLxqkzsU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ej3HW4OBwPIi6rJmznPSDxDaw7Cb4pzfnyS5VzLoN8nWrOWAoEZQqBnyG6+xEn+D0
 7yQ+0yN0qvgc8YDVK5iwmHHmsRarF1KnWXlq5HRNnhf7FVJxsqatR2ZfNZ+bAEASX7
 20w9peYQWVBPhZVdOSboBcbVaxQJoNTGnGylj4nMQmItWMJ1zYAhV1GnO1dy83mqoG
 oYneIX9I6M1IyEGummRuPudQ4xwc2UdgaUrUuieMxPESU59WuaYuxFNEAQLkLAa21b
 zhtZklZgUnYEhUzZaiKi0bKGFtnqx742GrBbwSeN6oxk78OHZxBMrye10FYGKq1u0k
 /Dz8Lcjt0vzzA==
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12db2e415a7so4850062c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:44:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8eD6+EXpJUod4c+0i4cKIpvrdU8DBBUz8AGBoP5N8ldQZqd0TCj0GeOEbxzaybyQLOwccDsLhMx0I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yww5qoFFl9DWkgIqRDYodkjKcjPSRrJeh6tCu99whmBGDlPRqmP
 +EmRyBYHXL0F+OJaO3boK7vPu8V7lh+8hJvHLeXihmsMBjValawBy0vs2zQD6aTeo0s5Z03/qIK
 IqhUNLM52GpI/3q9/r3XfSWrkB/yXWw==
X-Received: by 2002:a05:7022:45a5:b0:130:a257:f723 with SMTP id
 a92af1059eb24-1349a703b38mr2163136c88.2.1778683469857; Wed, 13 May 2026
 07:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260420064544.266478-1-suryasaimadhu369@gmail.com>
In-Reply-To: <20260420064544.266478-1-suryasaimadhu369@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 13 May 2026 14:44:17 +0000
X-Gmail-Original-Message-ID: <CAAOTY__-A_LAaDG5QBMVAaWh0QYiNETvF_uhVevGLQr0cfxV6w@mail.gmail.com>
X-Gm-Features: AVHnY4KoaT4lFur0qX9u_4-uJObxdFb4r8bJVHNWvz9hHmWh3RXQFM5ONm8Jba4
Message-ID: <CAAOTY__-A_LAaDG5QBMVAaWh0QYiNETvF_uhVevGLQr0cfxV6w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
To: sai madhu <suryasaimadhu369@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Hi, sai:

sai madhu <suryasaimadhu369@gmail.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=8820=
=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=886:45=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> The DRM_ERROR() macro is deprecated in favor of drm_err() which
> provides device-specific logging.
>
> Replace DRM_ERROR() with drm_err() in the Mediatek HDMI bridge
> driver and pass the drm_device pointer via bridge->dev.
>
> No functional change intended.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: sai madhu <suryasaimadhu369@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 1ea259854780..4ddcdbf7bc8c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -981,8 +981,8 @@ static int mtk_hdmi_bridge_attach(struct drm_bridge *=
bridge,
>         int ret;
>
>         if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> -               DRM_ERROR("%s: The flag DRM_BRIDGE_ATTACH_NO_CONNECTOR mu=
st be supplied\n",
> -                         __func__);
> +               drm_err(bridge->dev,
> +                       "DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\=
n");
>                 return -EINVAL;
>         }
>
> --
> 2.34.1
>
