Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC30FCA5FDB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3DF10F68C;
	Thu,  1 Oct 2026 13:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OcfhS1Sq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C889610F68B;
 Thu,  1 Oct 2026 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790861685; x=1822397685;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nXKoilSfFWDF4/K4PvmG8KxDr8EMs4iR0AwNfbBJKmk=;
 b=OcfhS1Sq+BflKngwPfQE+dl7aKSU6C2udi0A3Lq+OqWJdsN6T43Engta
 KAWOV3e9hPUQCzFQYmpV5JukojI7gmV6SKGF1rOmqwN6Jw6f38I2YpBw7
 vAgXXM1wvxac+pteljODHkuucYDlat98DFlnvjWXLLU1dasDfH2YWCt7J
 1mgJPROi063nl826/zPCC2H3jETkb/Cjf6N7VqFEF3YFYorf1xxNS+k3i
 86p5gIIgM4M9HkCfHbavyvzIueM/evPPL968JoJpp8S3Xz8W0jQYC/B7G
 OxsRELPFPzbgd+0a7XYtIsD0FIJ1YTgmlwuobuNq6XV82QIfViFeZ7378 g==;
X-CSE-ConnectionGUID: KbqaX4E3RWWqNIqu1kTk+Q==
X-CSE-MsgGUID: 4rIYxVOkTsetN3XuL8vGyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91716200"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91716200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 06:34:45 -0700
X-CSE-ConnectionGUID: VZ/5qvkBSx2KcpVQ9efMWQ==
X-CSE-MsgGUID: fiMP0bUuS36IDk6Yq8D25w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="279223548"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP; 01 Oct 2026 06:34:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id F1BAC99; Thu, 01 Oct 2026 15:34:40 +0200 (CEST)
Date: Thu, 1 Oct 2026 15:34:40 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, lucas.demarchi@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/xe/i2c: cancel the client work on remove
Message-ID: <ar5hcBKGhZDcNSKz@black.igk.intel.com>
References: <20260928013030.612592-1-fanwu01@zju.edu.cn>
 <artYHzEMGPu26x3r@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <artYHzEMGPu26x3r@black.igk.intel.com>
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

On Tue, Sep 29, 2026 at 08:18:07AM +0200, Raag Jadav wrote:
> + Heikki to comment on this.
> 
> On Mon, Sep 28, 2026 at 01:30:30AM +0000, Fan Wu wrote:
> > xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
> > schedules i2c->work when the adapter is registered under the xe I2C
> > platform device, and xe_i2c_client_work() then instantiates the AMC
> > client device on that adapter.
> > 
> > xe_i2c_remove() tears down the AMC, unregisters the client devices,
> > the bus notifier and the adapter platform device, but it never drains
> > i2c->work. A work item that is still queued or running when the
> > adapter is unregistered dereferences i2c->adapter in
> > i2c_new_client_device() after platform_device_unregister() has
> > released the adapter. The work item is also embedded in the
> > devm-allocated struct xe_i2c, so a work item still queued after the
> > drm device devm unwind frees that allocation runs its callback on
> > freed memory.
> > 
> > The bus notifier is the only thing that schedules this work, and it is
> > unregistered after the client devices. An instance that is still queued
> > when the teardown runs can therefore write
> > i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
> > clearing the same array, and an AMC client it instantiates late is only
> > cleaned up by the adapter's own child sweep in i2c_del_adapter().
> > 
> > Move bus_unregister_notifier() in front of the client teardown loop
> > and cancel the work right after it, so no new instance can be
> > scheduled and a queued instance is drained before the client array is
> > touched. A running instance still finds a live adapter, since the
> > adapter is unregistered later.
> > 
> > This issue was found by an in-house static analysis tool.
> > 
> > Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
> > Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6
> > Co-developed-by: Song Li <songl@zju.edu.cn>
> > Signed-off-by: Song Li <songl@zju.edu.cn>
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

LGTM

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> > ---
> > 
> > Changes in v3:
> > - rebase onto drm-xe-next, after "drm/xe/i2c: Disable IRQ on unbind"
> > - discussion: Link: above points at the v2 thread
> > - unregister the bus notifier before the client teardown loop and
> >   cancel the work before the loop as well: v2 cancelled the work only
> >   after the loop, so an event arriving during the loop could still
> >   schedule the work to race with the array teardown and leak a freshly
> >   instantiated AMC client
> >  drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> > index f4f3819..b82caaf 100644
> > --- a/drivers/gpu/drm/xe/xe_i2c.c
> > +++ b/drivers/gpu/drm/xe/xe_i2c.c
> > @@ -324,12 +324,15 @@ static void xe_i2c_remove(void *data)
> >  	xe_i2c_irq_reset(xe);
> >  	xe_amc_exit(i2c);
> >  
> > +	/* Stop the notifier from arming the client work before teardown. */
> > +	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> > +	cancel_work_sync(&i2c->work);
> > +
> >  	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
> >  		i2c_unregister_device(i2c->client[i]);
> >  		i2c->client[i] = NULL;
> >  	}
> >  
> > -	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
> >  	xe_i2c_unregister_adapter(i2c);
> >  	xe->i2c = NULL;
> >  }
> > 

-- 
heikki
