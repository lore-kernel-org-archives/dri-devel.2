Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D418C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6898010E527;
	Sat, 18 Jul 2026 05:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iNGyrNJS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E4C10E527;
 Sat, 18 Jul 2026 05:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784352424; x=1815888424;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nZV8SHUwGVzCabLmhH/NnI+MtPu5E7IO8adSdE4qMQY=;
 b=iNGyrNJSW8br9eBGriy20Fm6IAqD2mSfoYVom4IToof9MRgcbfI/H+/z
 cXo2eobFYNFFbCrbA19ytk9TycQNnmeOlCExYLC2QeRgsphYDmPIsqXBj
 kM6m76OWqG7zhxmz6P428IJggxMzeIUfiV88dyy+5OsnoIWuHWvYlyDMM
 9yih2W/nlv8XiOcFJdUCtrhYaXfFQvujOGVZGKUT5Oqb0SA+hKOFuGnBj
 fT2ichUDxpxFpW/zCALdD8QY2Nmz9mehsLJJ6BMacKctI7sUiUFKaZDvA
 qmN0XcsjdrsxfROMqUtIpv6PllB/lHJE9TgCdcUsl+o53l8jqjuQ4Kkfp Q==;
X-CSE-ConnectionGUID: nFyUrpbxTzeFpFpSulXm2A==
X-CSE-MsgGUID: EZ8OhvlgTFKDwC9gq98TYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85042289"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="85042289"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 22:27:03 -0700
X-CSE-ConnectionGUID: IcI6DVwbRj2M8hyENn9wSg==
X-CSE-MsgGUID: K1lI7xygRZOz6lEKbOXWIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="261230655"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 22:27:00 -0700
Date: Sat, 18 Jul 2026 07:26:56 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 dev@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
 rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com
Subject: Re: [PATCH v4 2/5] drm/ras: Introduce error threshold
Message-ID: <alsOoFEuSPSyCMTB@black.igk.intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-3-raag.jadav@intel.com>
 <0769389d-e73a-4dda-878c-2bc9e59deff3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0769389d-e73a-4dda-878c-2bc9e59deff3@intel.com>
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

On Fri, Jul 03, 2026 at 10:43:06AM +0530, Tauro, Riana wrote:
> On 23-06-2026 15:39, Raag Jadav wrote:
> > Add get-error-threshold and set-error-threshold command support which
> > allows querying/setting error threshold of the counter. Threshold in RAS
> > context means the number of errors the hardware is expected to accumulate
> > before it raises them to software. This is to have a fine grained control
> > over error notifications that are raised by the hardware.

...

> >    *     + The error counters in the driver doesn't need to be contiguous, but the
> >    *       driver must return -ENOENT to the query_error_counter as an indication
> >    *       that the ID should be skipped and not listed in the netlink API.
> > + *     + The driver can optionally implement query_error_threshold() and
> > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > + *       threshold of the counter. Threshold in RAS context means the number of
> > + *       errors the hardware is expected to accumulate before it raises them to
> > + *       software. This is to have a fine grained control over error notifications
> > + *       that are raised by the hardware.
> > + *     + The driver is responsible for error threshold bounds checking.
> > + *     + Threshold of 0 can mean invalid threshold or act as a disable notifications
> > + *       toggle for that counter depending on usecase and the driver is responsible
> > + *       for handling it as needed.
> 
> I know i asked you to add this in last rev. But after reading this,
> error-threshold bounds checking at driver level
> should be sufficient.  It's upto the driver on what behavior needs to be
> implemented.
> 
> Some may notify on reaching threshold or crossing threshold.
> I think we should drop this sentence here. Let me know your thoughts.
> sorry for the confusion.

I think it adds more context and good to have in case someone comes up
looking for the details.

...

> > +	/**
> > +	 * @query_error_threshold:
> > +	 *
> > +	 * This callback is used by drm-ras to query error threshold of a
> > +	 * specific counter.
> > +	 *
> > +	 * Driver should expect query_error_threshold() to be called with
> > +	 * error_id from `error_counter_range.first` to
> > +	 * `error_counter_range.last`.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> > +				     u32 *threshold);
> 
> Add a blank line

Sure.

> With these fixed
> 
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>

Awesome.

Raag
