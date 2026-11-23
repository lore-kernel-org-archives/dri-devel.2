Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3097606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KbCv5PkL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AEB10E038;
	Mon, 23 Nov 2026 17:43:31 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D40C10E038
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795455795; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XwRh0w8yBHTIo/Akh/fC0++ZPiNmQWIlaFiZJnwrOexMOw2sYRgM70yOOj33iQ1AGnxYvIuCsv4gWMYs057d8lbDFUgLl8oQRiI44Yll9dVgFxv9Zk8aXD8N8yRHoPs4kH88NhC+rwSq/5aUYKsWA776cfJAxmLuXlrA2H1bgGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795455795;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aQvWImmPb1jRtzHePOoIeMXh67VwZlq7k/jh0nzU3SQ=; 
 b=liWq0l9xX/sWRaNGf2/TMp3zGl7LDQnaXUEpnMFBRAWk7/o+KlDiciM8a9/G0T2/iaQsTA7Qqxk8MiMKBDOo00+PRU+4B1IgJF8uWZCettXOxpWOK9p3lVZSYCnXd7Vi96Ajww6kfPQz/2JDYjKIdvknZJq59AWKjPutNBB4J7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=KbCv5PkLpno5QYvja57UkDq3SqUFiwOJJHn+yEKQRrfRZ/P6FV9BdwCxjxmnNcHP129PnEqewNn6a03XWeLkKAJL5Y6R7/YewYClRYQoiNXReHjYPKfECi2/Za/Kfz++OsnUuTNng79OlUzhbTOFU2e4z/POoFoKbrkteU9ppmk=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=aQvWImmPb1jRtzHePOoIeMXh67VwZlq7k/jh0nzU3SQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795455792185485.028439789156;
 Mon, 23 Nov 2026 09:43:12 -0800 (PST)
Date: Mon, 23 Nov 2026 17:43:07 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: iav@iav.lv
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH v3] drm/panfrost: Enable GPU_PM_RT for RK3399
Message-ID: <awR7G-dOM4zLempo@sobremesa>
References: <20261123-panfrost-rk3399-pm-rt-v3-1-04c7c58d1140@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123-panfrost-rk3399-pm-rt-v3-1-04c7c58d1140@iav.lv>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.448.99
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23.11.2026 17:33, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> The RK3399 Mali-T860 matches arm,mali-t860 and gets default_data, so
> panfrost enables aclk_gpu at probe and keeps it enabled until unbind;
> runtime suspend powers the GPU off but leaves the clock on.
> 
> On ROCK Pi 4A restore from hibernation hangs in genpd_restore_noirq()
> of the GPU when the hibernated kernel had panfrost bound and the
> kernel that loads the image does not. There clk_disable_unused()
> gates aclk_gpu, while the restored image still holds an enable count
> on it, so powering the GPU domain back on does not ungate the clock.
> With the clock gated in runtime suspend, as on the Allwinner H616 and
> the Renesas RZ/G3L and RZ/G3E, restore completes.
> 
> Match rockchip,rk3399-mali to default_pm_rt_data, which differs from
> default_data only in GPU_PM_RT.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

> ---
> Tested on ROCK Pi 4A, drm-misc-next c408466a4dfa with the rkvdec fix [1]
> applied: hibernation restores 9 of 9 with this patch (3 with an HDMI
> mode held, 3 right after glmark2-es2-drm, 3 idle), and the GPU renders
> after restore. With the GPU node left with arm,mali-t860 only, restore
> hangs 2 of 2, in genpd_restore_noirq() of the GPU.
> [1] fixes the same kind of hang in rkvdec, which otherwise hits first;
> this patch applies and builds without it.
> 
> [1] https://lore.kernel.org/r/20261030-rkvdec-runtime-pm-clocks-v2-1-8ff510a231de@iav.lv
> 
> Changes in v3:
> - Retitle as Steven suggested, say what GPU_PM_RT changes
> - Add Steven's Reviewed-by, given on v1 (same code)
> - Link to v2: https://lore.kernel.org/r/20261122-panfrost-rk3399-pm-rt-v2-1-40f1791aa1a8@iav.lv
> 
> Changes in v2:
> - Name the SoCs that already use default_pm_rt_data
> - Say why restore hangs
> - Rebase onto drm-misc-next
> - Link to v1: https://lore.kernel.org/r/20261030-panfrost-rk3399-pm-rt-v1-1-e94437159a9d@iav.lv
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index eeda113037fe..91acfa13ef42 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -983,6 +983,7 @@ static const struct of_device_id dt_match[] = {
>  	  .data = &amlogic_data, },
>  	{ .compatible = "renesas,r9a08g046-mali", .data = &default_pm_rt_data },
>  	{ .compatible = "renesas,r9a09g047-mali", .data = &default_pm_rt_data },
> +	{ .compatible = "rockchip,rk3399-mali", .data = &default_pm_rt_data },
>  	{ .compatible = "arm,mali-t604", .data = &default_data, },
>  	{ .compatible = "arm,mali-t624", .data = &default_data, },
>  	{ .compatible = "arm,mali-t628", .data = &default_data, },
> 
> ---
> base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
> change-id: 20261030-panfrost-rk3399-pm-rt-cea3fc1790d9
> 
> Best regards,
> -- 
> Igor Velkov <iav@iav.lv>

Adrian Larumbe
