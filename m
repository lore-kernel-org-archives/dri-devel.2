Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A21CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6DAD10E2BB;
	Wed, 17 Jun 2026 06:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h6qu521a";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80C110E2BB;
 Wed, 17 Jun 2026 06:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781677182; x=1813213182;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BgQYrmR+7GcniQAhoX3so0VbrDhC8RCJSeENc8FMxMA=;
 b=h6qu521ad3b/FpfW0x8BQWzziSnE7v0kdTnNreCXeupHe0ezP8xFuK+n
 ztR+9PLIfx3r/Ite0FbDSzdJHVTf116rxnHpZAx6d3U83yJ4Xnwhf0caf
 1M7jx5pftqW7arHs2hTjdi74CnaPex0Pe6MdWdOQIb6xxS/TRlhxCAn0s
 lbO2VmlqDa6qIBY2rlPv5iz6wIXQidv10w2//oQr3WWHjDKt/6RAGKSK+
 pA2Tv4j3PbJLTzwI70PWtpDZkBUFZAQrxrx2/V4ZA0WuWP104KlPdVKaq
 cxpd+q06TgxVvMeHIynKPfAaSIFGigoLXsylTP6LG23a4htGhlVTYHH9H Q==;
X-CSE-ConnectionGUID: VXrbn9CyRcSVxEt8V1QDAg==
X-CSE-MsgGUID: 2vRuwWh5TSGFeB8Ku5IMxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82471802"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82471802"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:19:41 -0700
X-CSE-ConnectionGUID: TcktqaFDSh+9s/CfjFS3Sw==
X-CSE-MsgGUID: 3T/LFQhuQICRo8MgbNZDTA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:19:37 -0700
Date: Wed, 17 Jun 2026 08:19:35 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 dev@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
 rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com
Subject: Re: [PATCH v3 1/4] drm/ras: Introduce error threshold
Message-ID: <ajI8d4FlRH_CtyZV@black.igk.intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-2-raag.jadav@intel.com>
 <57e1f3a9-14b7-4bec-8765-deb70fe6b636@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e1f3a9-14b7-4bec-8765-deb70fe6b636@intel.com>
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

On Mon, Jun 15, 2026 at 02:26:05PM +0530, Tauro, Riana wrote:
> On 05-06-2026 00:16, Raag Jadav wrote:
> > Add get-error-threshold and set-error-threshold command support which
> > allows querying/setting error threshold of the counter. Threshold in RAS
> > context means the number of errors the hardware is expected to accumulate
> > before it raises them to software. This is to have a fine grained control
> > over error notifications that are raised by the hardware.

...

> > + *     + The driver can optionally implement query_error_threshold() and
> > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > + *       threshold of the counter. Threshold in RAS context means the number of
> > + *       errors the hardware is expected to accumulate before it raises them to
> > + *       software. This is to have a fine grained control over error notifications
> > + *       that are raised by the hardware.
> > + *     + The driver is responsible for error threshold bounds checking.
> 
> Can the threshold be set to 0? What should the behaviour be?

Some may want it to be invalid while some may want it to act as a "disable
notifications" toggle. So it's upto the drivers and their usecases, not for
us to decide. Will add this.

Raag
