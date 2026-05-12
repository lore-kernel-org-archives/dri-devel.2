Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D094CCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC0C10E262;
	Tue, 12 May 2026 14:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EaESo/MM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8928710E262;
 Tue, 12 May 2026 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778596671; x=1810132671;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WYr5m3QewSCuYPj5Y8aDfV6V209VvUnkAHIIKUHVfUA=;
 b=EaESo/MMAMq15x0Lofbax/yHadViBIa1pLUJ0M+qzK8kc2siI94DWsvu
 7AMrUsj8N9qWo9k3Kyr6Ak2a8zudKVBHQ+MTy7emrJhJROP0RsIOJnZ5J
 /IoWXIB4YtIjZyxEf5Xfa7T7+WqudqwKP5+ec7izoGxrJtzTl/xYJh/9B
 bfYjYpvhwTrsG4byiKC40/XcppKB9/SfFBW+6LHrpDk/vyF3MlcMQglBh
 oFV1TJgYOnw/4R29VT92O5tAlc4g+pRU/iG5GojPVoMIv9iy0WiGXJzUH
 kr3nVNHrLgtd54/WrTJAmPVEyAIsqhQilTU8UEF9ECf4acoHl3LQn2ZWC g==;
X-CSE-ConnectionGUID: D6rC19f8TGOdjoZ1+JHMmw==
X-CSE-MsgGUID: f556Fi90Qj2gNDJKhevPJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83359919"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="83359919"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 07:37:50 -0700
X-CSE-ConnectionGUID: OGsVD7iCQd+npCT6CeFarg==
X-CSE-MsgGUID: qx11dIs2S0ShvIT9w6mrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="233481547"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 07:37:46 -0700
Date: Tue, 12 May 2026 16:37:43 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 maarten@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
 rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v1 08/11] drm/xe/ras: Get error threshold support
Message-ID: <agM7NzEdT5SsOi4f@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-9-raag.jadav@intel.com>
 <81b9b5f6-6107-467a-879c-c2906e8d1f58@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81b9b5f6-6107-467a-879c-c2906e8d1f58@intel.com>
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

On Mon, May 11, 2026 at 10:40:29PM +0530, Tauro, Riana wrote:
> On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > System controller allows programming per error threshold value, which
> > it uses to raise error events to the driver. Get it using mailbox
> > command so that it can be exposed to the user.
> > 
> > Signed-off-by: Raag Jadav<raag.jadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_ras.c                   | 73 +++++++++++++++++++
> >   drivers/gpu/drm/xe/xe_ras.h                   |  3 +
> >   drivers/gpu/drm/xe/xe_ras_types.h             | 22 ++++++
> >   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
> >   4 files changed, 100 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> > index 08e91348c459..3e93f838aa4a 100644
> > --- a/drivers/gpu/drm/xe/xe_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_ras.c
> > @@ -3,11 +3,14 @@
> >    * Copyright © 2026 Intel Corporation
> >    */
> > +#include "xe_pm.h"
> >   #include "xe_printk.h"
> >   #include "xe_ras.h"
> >   #include "xe_ras_types.h"
> >   #include "xe_sysctrl.h"
> >   #include "xe_sysctrl_event_types.h"
> > +#include "xe_sysctrl_mailbox.h"
> > +#include "xe_sysctrl_mailbox_types.h"
> >   /* Severity of detected errors  */
> >   enum xe_ras_severity {
> > @@ -49,6 +52,23 @@ static const char *const xe_ras_components[] = {
> >   };
> >   static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
> > +/* uAPI mapping */
> > +static const int drm_to_xe_ras_components[] = {
> > +	[DRM_XE_RAS_ERR_COMP_CORE_COMPUTE]	= XE_RAS_COMP_CORE_COMPUTE,
> > +	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL]	= XE_RAS_COMP_SOC_INTERNAL,
> > +	[DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY]	= XE_RAS_COMP_DEVICE_MEMORY,
> > +	[DRM_XE_RAS_ERR_COMP_PCIE]		= XE_RAS_COMP_PCIE,
> > +	[DRM_XE_RAS_ERR_COMP_FABRIC]		= XE_RAS_COMP_FABRIC
> > +};
> > +static_assert(ARRAY_SIZE(drm_to_xe_ras_components) == DRM_XE_RAS_ERR_COMP_MAX);
> > +
> > +/* uAPI mapping */
> > +static const int drm_to_xe_ras_severities[] = {
> > +	[DRM_XE_RAS_ERR_SEV_CORRECTABLE]	= XE_RAS_SEV_CORRECTABLE,
> > +	[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE]	= XE_RAS_SEV_UNCORRECTABLE
> > +};
> > +static_assert(ARRAY_SIZE(drm_to_xe_ras_severities) == DRM_XE_RAS_ERR_SEV_MAX);
> > +
> >   static inline const char *sev_to_str(u8 sev)
> >   {
> >   	if (sev >= XE_RAS_SEV_MAX)
> > @@ -90,3 +110,56 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
> >   			comp_to_str(component), sev_to_str(severity));
> >   	}
> >   }
> > +
> > +static void ras_command_prepare(struct xe_sysctrl_mailbox_command *command,
> > +				void *request, size_t request_len, void *response,
> > +				size_t response_len, u8 hdr_cmd)
> > +{
> > +	struct xe_sysctrl_app_msg_hdr header = {};
> > +
> > +	header.data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
> > +		      REG_FIELD_PREP(APP_HDR_COMMAND_MASK, hdr_cmd);
> > +
> > +	command->header = header;
> > +	command->data_in = request;
> > +	command->data_in_len = request_len;
> > +	command->data_out = response;
> > +	command->data_out_len = response_len;
> > +}
> > +
> > +int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold)
> > +{
> > +	struct xe_ras_get_threshold_response response = {};
> > +	struct xe_ras_get_threshold_request request = {};
> > +	struct xe_sysctrl_mailbox_command command = {};
> > +	struct xe_ras_error_class counter = {};
> > +	size_t len;
> > +	int ret;
> > +
> > +	counter.common.severity = drm_to_xe_ras_severities[severity];
> > +	counter.common.component = drm_to_xe_ras_components[component];
> 
> I see this is only for correctable errors. We do not have correctable memory
> errors
> Do we want to return -EOPNOTSUPP for memory errors?

Could be done, but I'm expecting it to come from firmware since driver
is more or less acting as a transport here.

Raag

> > +	request.counter = counter;
> > +
> > +	ras_command_prepare(&command, &request, sizeof(request), &response,
> > +			    sizeof(response), XE_SYSCTRL_CMD_GET_THRESHOLD);
> > +
> > +	guard(xe_pm_runtime)(xe);
> > +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> > +	if (ret) {
> > +		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (len != sizeof(response)) {
> > +		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
> > +		       len, sizeof(response));
> > +		return -EIO;
> > +	}
> > +
> > +	counter = response.counter;
> 
> Do we expect this to change?

Nope, but it helps with wrapping below.

> > +	*threshold = response.threshold;
> > +
> > +	xe_dbg(xe, "[RAS]: Get threshold %u for %s %s\n", response.threshold,
> > +	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
> 
> Do we need this. it should be visible to the user via netlink

It's for us, not the user.

> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> > index ea90593b62dc..982bbe61461e 100644
> > --- a/drivers/gpu/drm/xe/xe_ras.h
> > +++ b/drivers/gpu/drm/xe/xe_ras.h
> > @@ -6,10 +6,13 @@
> >   #ifndef _XE_RAS_H_
> >   #define _XE_RAS_H_
> > +#include <linux/types.h>
> > +
> >   struct xe_device;
> >   struct xe_sysctrl_event_response;
> >   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
> >   				      struct xe_sysctrl_event_response *response);
> > +int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> > index 4e63c67f806a..d5da93d65cf5 100644
> > --- a/drivers/gpu/drm/xe/xe_ras_types.h
> > +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> > @@ -70,4 +70,26 @@ struct xe_ras_threshold_crossed {
> >   	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
> >   } __packed;
> > +/**
> > + * struct xe_ras_get_threshold_request - Request structure for get threshold
> > + */
> > +struct xe_ras_get_threshold_request {
> > +	/** @counter: Counter to get threshold for */
> > +	struct xe_ras_error_class counter;
> > +	/** @reserved: Reserved for future use */
> > +	u32 reserved;
> > +} __packed;
> > +
> > +/**
> > + * struct xe_ras_get_threshold_response - Response structure for get threshold
> > + */
> > +struct xe_ras_get_threshold_response {
> > +	/** @counter: Counter id */
> 
> Nit: ID

Sure.

Raag

> > +	struct xe_ras_error_class counter;
> > +	/** @threshold: Threshold value */
> > +	u32 threshold;
> > +	/** @reserved: Reserved for future use */
> > +	u32 reserved[4];
> > +} __packed;
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> > index 84d7c647e743..a1b71218deca 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> > @@ -22,9 +22,11 @@ enum xe_sysctrl_group {
> >   /**
> >    * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
> >    *
> > + * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
> >    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
> >    */
> >   enum xe_sysctrl_gfsp_cmd {
> > +	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
> >   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
> >   };
