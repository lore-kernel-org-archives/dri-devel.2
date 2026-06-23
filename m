Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E18CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A613610EA97;
	Tue, 23 Jun 2026 11:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lNCk4oxP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EC610EA97
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782212412;
 bh=JtBRj9jn2+17pDsCSBhda0YXUBmEIAodCkZOMofrRlU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lNCk4oxPku+YLBYyPTi+JMg8hUJ+4mfPL7DG0MntH92NiMLEB1nfCPgdEJBuY+yUo
 pBLkYchqFNzRAfSUDzOkH/vxe0lfBmyUCbIjG7Z+dtihcI15nFK5Ptie2+yzH1Q1VM
 E3sz38+VfAicsWhtUCDzXey1yQ0UNAtVxSy4QMnhbWx1IaxeEPR0bzbrURvPtzWVq3
 ZOafNjhaRAegBNwNtcJMRhn0gfwMUZO1SE3GqtRLWWFdnNauYkMKABk2HYZb23xGAJ
 fTyZpQOQjxUmYJ7xmhtekVklnzsvEEKVJOjIuJN5CSwLQHKmxhI2rCofRkauk3siQC
 7nkYTF8vNuSww==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2540817E0853;
 Tue, 23 Jun 2026 13:00:12 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:00:05 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: include panfrost_drv.h for
 panfrost_transparent_hugepage
Message-ID: <20260623130005.77a3d669@fedora-2.home>
In-Reply-To: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
References: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 23 Jun 2026 11:46:17 +0100
Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The panfrost_transparent_hugepage variable is declared in panfrost_drv.h
> but the panfrost_drv.c does not incldue this header. Fix the following
> sparse warning by including panfrost_drv.h :
> 
> drivers/gpu/drm/panfrost/panfrost_drv.c:958:6: warning: symbol 'panfrost_transparent_hugepage' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 784e36d72c2b..36cc2e67a308 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_utils.h>
>  
>  #include "panfrost_device.h"
> +#include "panfrost_drv.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
>  #include "panfrost_job.h"

