Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5C8C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B6910E118;
	Thu, 27 Aug 2026 22:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="am20LhpP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3392610E118;
 Thu, 27 Aug 2026 22:12:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C77CD41685;
 Thu, 27 Aug 2026 22:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093D41F000E9;
 Thu, 27 Aug 2026 22:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787868730;
 bh=w1P++LSizzBWSIX6AsfA6Nrb58hZEvkOILo0D0DsRA0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=am20LhpPHH4Zf39/LDXiXLkyHu4ipD3vqUzM4Xz1EZXAMB3R3xo3yB+1ALBQJehcx
 FTjyxQDUnioh9dVmhFdkAssb3UAGmZzd6oEGEjK0YCsN+pO0pjIMsBw0uKzDhE0amX
 HNOy41cn/bBJQpyfWj5zQF1JM/r1es1s6i7m1KEZEpirapNQRTYYy7LdpScIO6C9KE
 qoNv2AyWxQjfAqtnHxrZZvOhC7M+RejAqxKiLwTkIaEIQ0SwBEB9KB8os+9cA1KJLE
 aGhTB/NHhoOiTBvuf36LRLa5S+AXE23VtdAiY+GT6TwVxFQNHzrYQchuaOd2HA/dcB
 Hf5BxA+7f/AIg==
Date: Fri, 28 Aug 2026 00:12:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Arvind Yadav <arvind.yadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 matthew.brost@intel.com, himal.prasad.ghimiray@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: Re: [PATCH 05/13] drm/xe: Send wedged notification from a worker
Message-ID: <apC1T6XkNdVIywn3@zenone.zhora.eu>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-6-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827101801.1247654-6-arvind.yadav@intel.com>
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

Hi Arvind,

...

> +static void xe_device_wedged_work(struct work_struct *work)
> +{
> +	struct xe_device *xe =
> +			container_of(work, struct xe_device, wedged.work);
> +	unsigned long method;
> +
> +	/* Report at most one recovery method per worker invocation. */
> +	method = READ_ONCE(xe->wedged.method);
> +	if (method != READ_ONCE(xe->wedged.reported_method)) {
> +		drm_dev_wedged_event(&xe->drm, method, NULL);
> +		WRITE_ONCE(xe->wedged.reported_method, method);

I think we need to check the error from drm_dev_wedged_event():

		int err;

		err = drm_dev_wedged_event(&xe->drm, method, NULL);
		if (!err)
			WRITE_ONCE(xe->wedged.reported_method, method);

Andi

> +	}
