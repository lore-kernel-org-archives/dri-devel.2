Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA76CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF9A10F811;
	Fri,  2 Oct 2026 09:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mD27VtXp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1058310E424;
 Fri,  2 Oct 2026 09:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790932884; x=1822468884;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=4vYXbS5N0wrk0QB36Cvdfxop/53SZQBVGCH1DIOvIV0=;
 b=mD27VtXp9ZuCf59ZL3yNEBaKju9uGAMqSkBdo+UdR1cgikMDRl39QXq3
 o4sWeB4m0UJqV//7WMX+LwwlqChz9FqdDoPN9eB9j7ydgmgnqNidc42r2
 6xdcvgwz0WlMpm5JpCdWDURR4Ark9iIo63axVgHn7+G5Jr5BdZza9MO/Q
 m9I4A/gyPtaxSU9vDBjbXsalagsiLZyYdweL62Yjgpw8IZHBHPMcUwJKK
 B6LXsKuwPSUaH6wzu1Bbkto5TWANxesEkXUyWc2H9OwzSvlpsofgr10ib
 DUzLuEOzMyy1vQ9f0OBGyitBzfZIzGKKIONnv4genK6zIvmBiyF8hEFoc w==;
X-CSE-ConnectionGUID: 9/5AO1pvRg6e3/cZvsKh9w==
X-CSE-MsgGUID: CZCcF5dVT7S5hOTUI0uvag==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90728933"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90728933"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:21:23 -0700
X-CSE-ConnectionGUID: uhzSw154Siec8f0GPq9KxA==
X-CSE-MsgGUID: RSCYN8imRSWQtN6/P8aR/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="302464397"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.196])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:21:21 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: FNU VISHWANATHA <fnu.vishwanatha@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, FNU VISHWANATHA
 <fnu.vishwanatha@intel.com>
Subject: Re: [PATCH 1/2] drm/mst: Fix sporadic second display not detected
 after warm boot/G3
In-Reply-To: <20261001215705.3891147-1-fnu.vishwanatha@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261001215705.3891147-1-fnu.vishwanatha@intel.com>
Date: Fri, 02 Oct 2026 12:21:19 +0300
Message-ID: <3ddffda7b123f83a4dc94d26f299dec08da27fba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 01 Oct 2026, FNU VISHWANATHA <fnu.vishwanatha@intel.com> wrote:
> The intermittent detection failure of the second display over MST HUB is caused
> by a race condition in MST port status detection during warm boot/G3 resume.
>
> When a port transitions from input to output state during topology reprobe, the
> driver was not forcing a re-probe of the link address. This caused ports that
> were temporarily incorrectly marked as input ports to never create connectors.
>
> Force a link address reprobe when a port transitions from input (1) to output
> (0) state, giving the MST hub another chance to properly report the port status.
>
> Signed-off-by: FNU VISHWANATHA <fnu.vishwanatha@intel.com>

Is there a bug report about this with logs?

> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index be749dcad3b5..cc340e4235cc 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2377,7 +2377,11 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
>                 changed = true;
>                 created = true;
>         } else if (port->input && !port_msg->input_port) {
> +               /* Port transitioned from input to output (e.g., during warm boot/G3 resume)
> +                * We need to force link address reprobe to get proper port info
> +                */
>                 changed = true;
> +               mstb->link_address_sent = false;
>         } else if (port->connector) {
>                 /* We're updating a port that's exposed to userspace, so do it
>                  * under lock

-- 
Jani Nikula, Intel
