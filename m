Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BDCC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 18:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDCB10E210;
	Fri, 10 Jul 2026 18:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IH50Ibln";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DEF10E210
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783707979; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EwD8DDadIi1TDQG5EvLi6RO0Fl3SM8MUc3FuX06FXZe1BqWcdVaE2DyBmmrofvXcROUdBGTnNyozdF5+v6yU+g56nmiMNUVUg/ZdNI2DvfDSk5AqDj11qmXe3X0wxQ7pi0G4EHAgaT2YY0nJTJq90tcMDGpDxm8ZI2RaLU5C2pI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783707979;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=h9AOda6Ww2DmVQg/pYx7o4zGVJWWpKbAW9ltVZeQmM0=; 
 b=knca/cwa/hXKeI5CzrY7kA0f7+NOku+O7eU4C2amr5zOjiDa3xY1k255qnG7XCmuN3cYq1fT5RgjSjc+wFWSfrDyYo3+bA+hnajVg/ETT/RsBshB/oBb1BQ3cHlYNh6Pbd8e9UIBEwnOZlTfxMpgOqRROoqmjKRicgAIX9Cx2To=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783707979; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=h9AOda6Ww2DmVQg/pYx7o4zGVJWWpKbAW9ltVZeQmM0=;
 b=IH50IblnhRZ6cwgH/iQMWz5oVyGDySmpcR+H3A2VxFc2PcOcK515/wjULHHMcxp7
 ws8qfvUemvb/ZzzdTSLVZIraxE8paMxMMTMifLtiOY4hiqKlYQFdyW6ibBB+/IErrrG
 QieWuoV5H81jvQo7mzRdFFzAJcTeej43S+u6luFk=
Received: by mx.zohomail.com with SMTPS id 178370797901560.55875535023233;
 Fri, 10 Jul 2026 11:26:19 -0700 (PDT)
Date: Fri, 10 Jul 2026 19:26:09 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: include panfrost_drv.h for
 panfrost_transparent_hugepage
Message-ID: <alE5Mne8sys8b48D@sobremesa>
References: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
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

Queued to drm-misc-next.

On 23.06.2026 11:46, Ben Dooks wrote:
> The panfrost_transparent_hugepage variable is declared in panfrost_drv.h
> but the panfrost_drv.c does not incldue this header. Fix the following
> sparse warning by including panfrost_drv.h :
> 
> drivers/gpu/drm/panfrost/panfrost_drv.c:958:6: warning: symbol 'panfrost_transparent_hugepage' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
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
> -- 
> 2.37.2.352.g3c44437643

Adrian Larumbe
