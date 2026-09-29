Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AB6CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8948F10E0B1;
	Tue, 29 Sep 2026 06:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nOHBzoc+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B38C10E0B1;
 Tue, 29 Sep 2026 06:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790662694; x=1822198694;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GMlEVS63972OevcqapphLPcbwyDMo2NrK3/oGN2AKzQ=;
 b=nOHBzoc+hx0Fs4cfT7MR46koMlTgOmZA+rVu9pnHSDw1jP4bZOIkwaY4
 36c3jsuG6oiYKYNrY+WIb9eT4G/PZ+yaWK+Yg0QbOddylZCG2rfsRmkmN
 k8A3twzJsLLvm6Kfo38j09k2u9ZHW30IDmZNwsgR2DFu5/v65tcj4t+ID
 Yz/LDRrnqt4aAaluFC9IBcr66Sny10OsKz5Bz1V+fTpkYo5N66Lcvtvo0
 +wzFZfQCLPmqGygYrLIofSAxfr3dKTCaEDi0NLuUU8fRaCEZgIOkumtbh
 90PtlWJr99FUJN9pKvC7n9MpQzzkH/YlhX3CQBcN6g65nFkvHYYYyY0/5 g==;
X-CSE-ConnectionGUID: GnMycQGWS3WdXPbGCGtlyA==
X-CSE-MsgGUID: Y8YC4rmVSmmNP9wPnyltQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101537653"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101537653"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 23:18:13 -0700
X-CSE-ConnectionGUID: VC1uOa3NRiOvnA8f+1EgsA==
X-CSE-MsgGUID: LNM0Ojk6SjqNpluYlpkz5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="275302198"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 23:18:10 -0700
Date: Tue, 29 Sep 2026 08:18:07 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>, heikki.krogerus@linux.intel.com
Cc: lucas.demarchi@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/xe/i2c: cancel the client work on remove
Message-ID: <artYHzEMGPu26x3r@black.igk.intel.com>
References: <20260928013030.612592-1-fanwu01@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928013030.612592-1-fanwu01@zju.edu.cn>
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

+ Heikki to comment on this.

On Mon, Sep 28, 2026 at 01:30:30AM +0000, Fan Wu wrote:
> xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
> schedules i2c->work when the adapter is registered under the xe I2C
> platform device, and xe_i2c_client_work() then instantiates the AMC
> client device on that adapter.
> 
> xe_i2c_remove() tears down the AMC, unregisters the client devices,
> the bus notifier and the adapter platform device, but it never drains
> i2c->work. A work item that is still queued or running when the
> adapter is unregistered dereferences i2c->adapter in
> i2c_new_client_device() after platform_device_unregister() has
> released the adapter. The work item is also embedded in the
> devm-allocated struct xe_i2c, so a work item still queued after the
> drm device devm unwind frees that allocation runs its callback on
> freed memory.
> 
> The bus notifier is the only thing that schedules this work, and it is
> unregistered after the client devices. An instance that is still queued
> when the teardown runs can therefore write
> i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
> clearing the same array, and an AMC client it instantiates late is only
> cleaned up by the adapter's own child sweep in i2c_del_adapter().
> 
> Move bus_unregister_notifier() in front of the client teardown loop
> and cancel the work right after it, so no new instance can be
> scheduled and a queued instance is drained before the client array is
> touched. A running instance still finds a live adapter, since the
> adapter is unregistered later.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> 
> Changes in v3:
> - rebase onto drm-xe-next, after "drm/xe/i2c: Disable IRQ on unbind"
> - discussion: Link: above points at the v2 thread
> - unregister the bus notifier before the client teardown loop and
>   cancel the work before the loop as well: v2 cancelled the work only
>   after the loop, so an event arriving during the loop could still
>   schedule the work to race with the array teardown and leak a freshly
>   instantiated AMC client
>  drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index f4f3819..b82caaf 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -324,12 +324,15 @@ static void xe_i2c_remove(void *data)
>  	xe_i2c_irq_reset(xe);
>  	xe_amc_exit(i2c);
>  
> +	/* Stop the notifier from arming the client work before teardown. */
> +	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> +	cancel_work_sync(&i2c->work);
> +
>  	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
>  		i2c_unregister_device(i2c->client[i]);
>  		i2c->client[i] = NULL;
>  	}
>  
> -	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
>  	xe_i2c_unregister_adapter(i2c);
>  	xe->i2c = NULL;
>  }
> 
