Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D08CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE9810E350;
	Mon, 18 May 2026 14:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vCY1AWCq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E731410E350
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:26:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 49E246001A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F408CC2BCC6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779114413;
 bh=hm+pya9FfihN/vfpg8++W+yWh8lnVDDOk1psXq+CI/s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=vCY1AWCq63YDIRhRIg8pRz68eEPzXnj0ZixhlTK9Nkbcs4CG8tTj1eQXlqnK4M6WL
 uD2pHi1p9nC5ZLUGNuJzz1OGTWx/oPnu0M6cl6yRl6GUxUdnTPTpXOy2EmS7xtY7c0
 nf1YhUicPLVgsnmX7OU+8ybYl4jXJyrG/2FhSgfp7gSWk/JOpRpMA7T8TiJKW67tBk
 aiP/JdY+E9w3Eptue1axz0XrPBskwuPxe4WRgF/JZx6JlCr0p7RKQY02EYDmojfBnH
 Fb9U082pOMXNSGzIvxzh0xM0ZySnGi4eEoOV+fBL5TDTf/xwd6HodDAccokFwigeGe
 Iz9jTy9wuuZZQ==
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1331e851faaso1067739c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+HnJ1PMi1y2OIvec5Fp0YOKhHLfd+WV+YIch7s/iHTMd+Dz4RmKMyoYQbOUNTYQ8F1ht1/RA8kQJQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEL1lI0XMUmlEp4buTHZFCFtkFmBAGEbsE2ydJ9ZvKz+pzPVVE
 6Kj2QXg8tVnB6PY1xDmVzl2ohlCNgpq62oFOPaC7f1xFazOW8S7ey6kRqfmBSxtwBMSUFPCpZ3d
 uPuXMFqlqsalRlTKJmlGYqdWzRrJPWQ==
X-Received: by 2002:a05:7022:128d:b0:12d:b8e5:5e2 with SMTP id
 a92af1059eb24-134c8d4f477mr8519239c88.23.1779114412312; Mon, 18 May 2026
 07:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
In-Reply-To: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 18 May 2026 14:26:40 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8ra9pD7CuJPP+KtP3keQmRBhy18ci+6tdCCmdzY_wYqA@mail.gmail.com>
X-Gm-Features: AVHnY4Ib1xGbXsskUH68KIQINuq9-DNUQmBWC2ptMW1dekY9PU2APVoyDwlBMvE
Message-ID: <CAAOTY_8ra9pD7CuJPP+KtP3keQmRBhy18ci+6tdCCmdzY_wYqA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/mediatek: fix sparse warnings
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel test robot <lkp@intel.com>
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

Hi, Louis:

Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2026=E5=B9=
=B44=E6=9C=8829=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:59=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> This series fixes in the mediatek-drm driver the sparse warnings
> reported by [1] and two others introduced during v6.16 development
> cycle.
>
> The series has compile-tested and is based on linux-next (tag:
> next-2040428).
>
> [1]: https://lore.kernel.org/all/202604132044.fcYjEcU8-lkp@intel.com/

For this series, applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
> Louis-Alexis Eyraud (4):
>       drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global variable
>       drm/mediatek: mtk_hdmi_v2: Fix non-static global variable
>       drm/mediatek: mtk_cec: Fix non-static global variable
>       drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable
>
>  drivers/gpu/drm/mediatek/mtk_cec.c         | 2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c    | 2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c | 2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_v2.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: 0f3ef35b0747832b58b97171bad99011d084c6b1
> change-id: 20260424-mediatek-drm-fix-sparse-warnings-7404de18204c
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>
