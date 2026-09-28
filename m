Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65F7CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1035510EBB4;
	Mon, 28 Sep 2026 19:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="LIIrUs07";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A975710EBB4
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:35:07 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=6GdeS5J1nAEzAADIZpXQl1fwy/uaoTDl+7jyHikSKZc=; 
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790624105; v=1; x=1791228905;
 b=LIIrUs07PDS31P3GtcKlFbpeJkkJDwMH9Eiri2PUlYs4voOm4sgXuJOYt0i1aEyfj9Lu1dy/
 nMhpULR5eEje6W5Bf9CBxLmxwQbHLbDHn9UDbKOC91XMVsW83Nmn1ZIf4wtF/l9e03QiDmG86eS
 /ZBfHorgVd2A0XaZthh9CyANq0Fap0MN6JN9NkAjSq+dBLsLimJ2Cw4asZVdA5VNbjpuUzz0Xwo
 kzTpcChy8TA/I7ufo3g2DXizZZDABX6cF9jTtiae7x5bGlH5cZuhpHReu8YzTbkxBMQT7HJwoxF
 HCZrJZW764GMn6l1e4slkj2kBagZw7R/gl3y6utVK6bJg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id a3187ec75891e86d;
 Mon, 28 Sep 2026 19:28:51 +0000
X-Mizu-Trace-ID: a3187ec75891e86d
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 21:28:47 +0200
Message-Id: <DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com>
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, <linux-rockchip@lists.infradead.org>, "Detlev
 Casanova" <detlev.casanova@collabora.com>, "Jonas Karlman"
 <jonas@kwiboo.se>
Subject: Re: [PATCH] dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL
 kernels
X-Mailer: aerc 0.22.0-31-g5c1c510d2b65
References: <20260907020015.24719-1-kmehltretter@gmail.com>
In-Reply-To: <20260907020015.24719-1-kmehltretter@gmail.com>
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

On Mon Sep 7, 2026 at 4:00 AM CEST, Karl Mehltretter wrote:
> Commit 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by default on DEBUG
> kernels") changed the default of DMABUF_DEBUG to "y if DEBUG", but no
> Kconfig symbol DEBUG exists, so the option has had no default since.
>
> Use DEBUG_KERNEL, the Kconfig symbol for a debug kernel.

I wondered why since 7.3-rc4 when playing videos I got a WHOLE lot of the
following error messages, which weren't there with 7.3-rc3:

  [drm:rockchip_gem_iommu_map [rockchipdrm]] *ERROR* failed to map buffer: =
size=3D0 request_size=3D3956736
  [drm:rockchip_gem_prime_import_sg_table [rockchipdrm]] *ERROR* failed to =
import sg table: -12

Both come from ``drivers/gpu/drm/rockchip/rockchip_drm_gem.c``.

The value of request_size varies sometimes; I see ``request_size=3D8294400`=
`
the most. When playing a video (with mpv with v4l2request functionality, bu=
t
I think that doesn't matter), I see a whole bunch of these errors and then
it stays 'silent', but I get another stream of them when I resize the windo=
w
(ie I'm toggling between windowed and full-screen).
It doesn't take long before dmesg only consists of these errors.

The 'playing video' is likely important; when I just start sway I don't see
those errors. It's only when I start a video that those pop up.

My kernel (config) is based on Debian's and that has ``DEBUG_KERNEL=3Dy`` a=
t
least since 2008 and due to this patch/commit, ``DMABUF_DEBUG`` got turned =
on.
When I explicitly disable ``DMABUF_DEBUG``, I no longer see those errors.

Whether that fixes or just hides a problem, I'll leave that for others to
decide.

> Fixes: 646013f513f3 ("dma-buf: enable DMABUF_DEBUG by default on DEBUG ke=
rnels")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> This enables the dma-buf debug checks on every CONFIG_DEBUG_KERNEL
> configuration, which is what 646013f513f3 set out to do. If that is too
> broad today, the alternative is to restore the previous
> "default y if DMA_API_DEBUG".

My 0.02:
That change landed in 7.0-rc1 albeit it didn't have the effect it intended
to achieve. An -rc1 version seems like the right version to land such a cha=
nge.

I'm not in favor of this just popping up in 7.3-rc4 while -rc3 did NOT have
that affect. With an -rc1 you'd expect major changes, but in this case I
accidentally stumbled upon it while trying out something else.

Cheers,
  Diederik

>  drivers/dma-buf/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 7efc0f0d0712..e4f078a326a4 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -43,7 +43,7 @@ config UDMABUF
>  config DMABUF_DEBUG
>  	bool "DMA-BUF debug checks"
>  	depends on DMA_SHARED_BUFFER
> -	default y if DEBUG
> +	default y if DEBUG_KERNEL
>  	help
>  	  This option enables additional checks for DMA-BUF importers and
>  	  exporters. Specifically it validates that importers do not peek at th=
e
>
> base-commit: 986c24e0fe44f844b44d365b71ce831947f50298


