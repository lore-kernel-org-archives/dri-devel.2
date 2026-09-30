Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC221CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7B010E2A1;
	Wed, 30 Sep 2026 19:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PCy6hWuK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE2710E2A1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=2g0cjhGriLrkX3tBvCDi07tx8riYD3KZxstlX25rJD0=; b=PCy6hWuKBeAHwEskgI9mMFRixl
 sSwd/z9XIx09zW1uerOfdmJZiZ/92Tx2Bz01KqlJJ+TH77GENgGbDlVfEzJeAVgpuy2Ctgv3p+rZn
 aZeY/Zy/xnUzBxaMsPIh62Khx8BFUe1zKGuqlSPal9Q+Hm8UHBeXzjfd6UIz4BqO6VBWUvROVW4to
 VWTmdmSJ++fIa4JYquk9tgML7XKw1qIL7S5qpZzEeYbIiSPlgq5mxrpAlPqzd2T7HshU6T7Tk0x1M
 USWen/O4xDZ32+6L57WCP9zXLukawLgGPa632+kvOsX0v4hp37iqrljZpcqCqafTx0bPDFWf18zw8
 YGk5nmgg==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xC0Mw-009arU-0x; Wed, 30 Sep 2026 21:53:34 +0200
Date: Wed, 30 Sep 2026 16:53:27 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 1/2] drm/vc4: Free the BO cache size list on teardown
Message-ID: <ar1ot9ceOqmyNrg6@quatroqueijos.cascardo.eti.br>
References: <20260930190721.1897264-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930190721.1897264-1-mcanal@igalia.com>
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

On Wed, Sep 30, 2026 at 04:06:50PM -0300, Maíra Canal wrote:
> vc4_bo_cache_destroy() purges the cached BOs but never frees the size
> list, leaking it on every unbind.
> 
> Fixes: c826a6e10644 ("drm/vc4: Add a BO cache.")
> Assisted-by: LLM
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/vc4/vc4_bo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 49ea2ed0996b..ea1be891ac78 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -1052,6 +1052,7 @@ static void vc4_bo_cache_destroy(struct drm_device *dev, void *unused)
>  	cancel_work_sync(&vc4->bo_cache.time_work);
>  
>  	vc4_bo_cache_purge(dev);
> +	kfree(vc4->bo_cache.size_list);
>  
>  	for (i = 0; i < vc4->num_labels; i++) {
>  		if (vc4->bo_labels[i].num_allocated) {
> -- 
> 2.55.0
> 

Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
