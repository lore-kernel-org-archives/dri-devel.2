Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00674CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DDB10F253;
	Thu, 18 Jun 2026 10:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hq+PwJ12";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7090010F23F;
 Thu, 18 Jun 2026 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781777183; x=1813313183;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cvwVzsEL9xApN4x9ItSHnV9jxXJ6wS2ecG7KMdHfUC0=;
 b=hq+PwJ12Q+4cwqlz5pih7gbY1dTOq30y/vQsmyYAgx0/HjHXqGnRoomD
 flN/4TC+5uaZloXiOJfW11pEeq9GakH9XwxLi7m2W1wB4VmFbVeu4Fvhz
 z6FevkwcQZsHQay8nyznGJ0rPVbOGMj1OJNTosIJSXe0uzxF8jtpbQa6w
 O+tgMO5d9aNRwLE/mOFH5BjbnDWLIo5M/zNvMuknfk+1P7UVKTm/I4mQh
 dZn3PB1pQSluFV7QKzV8XDMtIR+vVFK4bRCDaObBy2Bf1tSlbNBO2Rvgt
 CFhIfmCupMVselUZny4Gw/yyzaGpNInTx2aqLyfkOXDpiskWyjkvPc3ao A==;
X-CSE-ConnectionGUID: sQbQa/dUT/uhBdpkCi/IxA==
X-CSE-MsgGUID: Gkj1vzJLQX+YDYgAC5vfvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="94107380"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="94107380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:06:22 -0700
X-CSE-ConnectionGUID: bNBJ3vr6R6+G3IpaKhn9Rw==
X-CSE-MsgGUID: Zf3jdA2jQ7a4TI+NVtAOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="252226229"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:06:16 -0700
Date: Thu, 18 Jun 2026 12:06:13 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <ajPDFcp36k1mGcdB@black.igk.intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
 <20260611052144.784969-5-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611052144.784969-5-riana.tauro@intel.com>
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

On Thu, Jun 11, 2026 at 10:51:46AM +0530, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-notify' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
> 
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-notify' to receive 'error-event'
> notifications.
> 
> Usage:
> 
> $ sudo ynl --family drm_ras --subscribe error-notify

...

>  operations:
>    list:
> @@ -124,3 +151,24 @@ operations:
>        do:
>          request:
>            attributes: *id-attrs
> +    -
> +      name: error-event
> +      doc: >-
> +           Notify userspace of an error event.
> +           The event includes the device, node and error information
> +           of the error that triggered the event.
> +      attribute-set: error-event-attrs
> +      mcgrp: error-notify

This looks much closer to "notify:" property, which IIUC it's not. Looking
at some of the existing examples, a better name could be something like
'error-monitor' or 'error-report' to make it a bit distinguishable.

Or perhaps it could be just me without the coffee :(
so I'll leave it to you.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

> +      event:
> +        attributes:
> +          - device-name
> +          - node-id
> +          - node-name
> +          - error-id
> +          - error-name
> +          - error-value
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: error-notify
