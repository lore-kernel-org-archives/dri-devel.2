Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F276C44509
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F4D10F478;
	Thu,  9 Jul 2026 09:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EOFWGblf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2637210F49B;
 Thu,  9 Jul 2026 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783588971; x=1815124971;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9EdaGAvYJ5tbCvOjl8CHeOoyPtBqGPgNsT9qMmRu+Es=;
 b=EOFWGblftCXfNbrmxDmle7XjP41HUteard0EEe7e9Lth5MV41zWRl8EH
 cduy1InMVOWhk3xD5keLy83r/Y+HTCZaII7k2klxwnUQHHZcLDqTrWf+O
 L5tSvmot/PEKOvbtTArvyW6TkTZdgSkrL63uyn1G9JLjuMc5r5JbhPlnc
 zCPSiY9HQMFBW+T6nZnT8hv2k2EIVawLEWqZ9gyK4NAlQNAAeRheYdgFf
 asdsCCuKg6bx/CfRnA0rKIC9uZdkqoLzuOOC2Is3tuhLhJbbLK1VuUkl3
 O8U7q2OsGGU35DZ4HT+kaDap77WsoWPajxXuoZ19GLoPia1NrDGTVHXVu w==;
X-CSE-ConnectionGUID: LVQ6BNVMSjeAdW2NvDnHKA==
X-CSE-MsgGUID: 2D7hpTO7ThuOuEYNiRyppQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101693416"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101693416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 02:22:34 -0700
X-CSE-ConnectionGUID: ReNFUb8JR7iKxKlmK8LGyQ==
X-CSE-MsgGUID: /O5vCSJFTeWSIIutLaS32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251884450"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 02:22:29 -0700
Date: Thu, 9 Jul 2026 11:22:26 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, kuba@kernel.org,
 aravind.iddamsetty@linux.intel.com, intel-xe@lists.freedesktop.org,
 anshuman.gupta@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <ak9oUmZ8sS3aF6jB@black.igk.intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
 <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com>
 <ak6xThf9qeB0wqgK@intel.com>
 <d96a4c3f-e0e7-42d7-bb8a-994b2f408dea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96a4c3f-e0e7-42d7-bb8a-994b2f408dea@intel.com>
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

On Thu, Jul 09, 2026 at 10:45:27AM +0530, Tauro, Riana wrote:
> On 09-07-2026 01:51, Rodrigo Vivi wrote:
> > On Tue, Jul 07, 2026 at 12:02:11PM +0530, Tauro, Riana wrote:
> > > Hi Rodrigo/Jakub/Aravind
> > > 
> > > Please let me know if you have any feedback for this patch or can you please
> > > ack this if it looks good to you.
> > I looks good to me, but could you please double check the sashiko's comments?
> 
> Sashiko has a comment regarding namespaces
> 
> [Severity: Medium]Since the generic netlink family explicitly supports
> multiple networknamespaces by setting .netnsok = true,
>  will hardcoding init_net hereprevent listeners in non-init namespaces from
> receiving error events
> 
> .netnsok = true is auto generated not explicitly added in code.

Because that's what ynl_gen_c.py does without it being parsed from
anywhere.

> But from what i see, drm device is present in the host and not replicated
> across namespaces
> and most of the non-network implementations use inet.  (ex: Binder)
> If this really needs a fix, we can drop the has_listeners suggested by raag 
> in previous patch.
> I don't think in an error path, allocating a new buffer would be a big
> overhead if listeners are not present.

I don't know enough about namespaces to comment on this. I'll rely on
Jakub's disposition if netnsok is relevant here, or needed at all for
our usecase.

Raag
