Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35693F34C65
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 856B410E4C8;
	Mon, 13 Apr 2026 15:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GedZnhB/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9343810E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776095595; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NLUtMYbmgECZYfWfaXRo+dxXgOi3MfM+oPXpiIorrwXPrCqDe7rZqsVFciXfcJmOhh2MBM8c77uAerF1S6WlIdHdedVZFkrsPtx52oWy57dvrFxBCoj1nCxYIdptnjUnUJmBSdZebjdB8Fz224IY5WA/U3Lmz/ZVT4mlwjQGz7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776095595;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=I6DQ0vYPJ7ac4o64pgQkVxvLcCeNatTbss17UFduNBg=; 
 b=IQhMcqqnoSVsGx6rWcWxUWa4yVG+c+vF3IT5jaKNnxBgsJNRkckGQVDouwV3gNWIL/BfdkociVCBvJ8p9u994m8I8kEzAbfu5ejEUhZ5nKJUceYFSpcuVPR9AG6hHzFby27ZxlZfHVhzjR/ZA/2pKkkfGGly0j/VE8MaacNFqN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776095595; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=I6DQ0vYPJ7ac4o64pgQkVxvLcCeNatTbss17UFduNBg=;
 b=GedZnhB/f+Lo5Ksg+aQkUT9K7zIEbFAMW7gaFK/k7vnSW6Fu9zqvrhc5ceKsAO/A
 2MbUXEKV1wHL6hwFLu6QbBDCO7SDJOS4BdiSU8D6m5b4/WZM9OqPhMuZcWvObRgooWT
 ABAfAtcS6O6BtlsyVnNwjibiWkUd7Jn5qzZ04xqs=
Received: by mx.zohomail.com with SMTPS id 1776095592323461.8737533352952;
 Mon, 13 Apr 2026 08:53:12 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:53:08 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 1/2] drm/panthor: Extend VM locked region for remap
 case to be a superset
Message-ID: <ad0RVR9YgSrvmWNP@sobremesa>
References: <20260408191228.537625-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408191228.537625-1-adrian.larumbe@collabora.com>
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

Queued to drm-misc-fixes.

On 08.04.2026 20:12, Adrián Larumbe wrote:
> In the event of an sm_step_remap() that leads to a partial unmap of a
> transparent huge page, the new locked region required by an extended unmap
> might not be a superset of the original one. Then, if it leaves a portion
> of the initially requested one out, the ensuing map will trigger a warning.
>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fa8b31df85c9..bd41c892beb7 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1709,6 +1709,25 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	    start + size <= vm->locked_region.start + vm->locked_region.size)
>  		return 0;
>
> +	/* sm_step_remap() may need a locked region that isn't a strict superset
> +	 * of the original one because of having to extend unmap boundaries beyond
> +	 * it to deal with partial unmaps of transparent huge pages. What we want
> +	 * in those cases is to lock the union of both regions. The new region must
> +	 * always overlap with the original one, because the upper and lower unmap
> +	 * boundaries in a remap operation can only shift up or down respectively,
> +	 * but never otherwise.
> +	 */
> +	if (vm->locked_region.size) {
> +		u64 end = max(vm->locked_region.start + vm->locked_region.size,
> +			      start + size);
> +
> +		drm_WARN_ON_ONCE(&vm->ptdev->base, (start + size <= vm->locked_region.start) ||
> +				 (start >= vm->locked_region.start + vm->locked_region.size));
> +
> +		start = min(start, vm->locked_region.start);
> +		size = end - start;
> +	}
> +
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> --
> 2.53.0

Adrian Larumbe
