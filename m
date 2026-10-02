Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C67CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEF010F814;
	Fri,  2 Oct 2026 09:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WVhrEdIh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DA610F81B;
 Fri,  2 Oct 2026 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790933313; x=1822469313;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=sxgt4svY/TgU/8j1VAh62BCWuhGx/pOZGibuvtoS9gk=;
 b=WVhrEdIheFtNDH/ZlaZ2WCxXhH7K4B4NKvhhgzYd/UctG970vSRTI1u7
 wEA639CYzlR2KhhZk+Km+fg9qeJ9Pzv6R3uzGwUzaGehYawD98L5/3o8s
 kikvG/uVTX6Gx1x/7aeDFgnaVh03YbU68yTN6eiiIPZ3LRKaBg7ww9pKP
 H8TWQkgXrLMGjhYBzIBAABpJLLTQrVd3ZK+TSD09CvWGBY3+r1xWWDc5Y
 DfFuK3/2piuiC3w3D8ArxVUkvyerdd4o1tEWd7TXFmo2QOsw4pY1W2hX1
 h/ZFNQbuily2DCHhQi60Ef5dD2YOqaFUKSfRUjYlwwVVMQ5PwqEudYmTM Q==;
X-CSE-ConnectionGUID: umQwfF0vQImfr0+2Pv2MNQ==
X-CSE-MsgGUID: mfnOQ11ER8mjVGFREVK6CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94410617"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94410617"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:28:32 -0700
X-CSE-ConnectionGUID: FSPQd3BKQ9+5htSjEiZsUA==
X-CSE-MsgGUID: NSsIUt+PTVS3mdFueRNvJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="275762357"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.196])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:28:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: FNU VISHWANATHA <fnu.vishwanatha@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, FNU VISHWANATHA
 <fnu.vishwanatha@intel.com>
Subject: Re: [PATCH 2/2] drm/i915/mst: Force link address reprobe after MST
 resume
In-Reply-To: <44a15723fd2b9a9152c382dcf8df86e51bfabbe3@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261001215705.3891147-1-fnu.vishwanatha@intel.com>
 <20261001215705.3891147-2-fnu.vishwanatha@intel.com>
 <44a15723fd2b9a9152c382dcf8df86e51bfabbe3@intel.com>
Date: Fri, 02 Oct 2026 12:28:27 +0300
Message-ID: <0c60e374cfbeef12abf349b0750de5df8f4f1b9a@intel.com>
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

On Fri, 02 Oct 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 01 Oct 2026, FNU VISHWANATHA <fnu.vishwanatha@intel.com> wrote:
>> After resume from warm boot/G3, immediately force a topology link address
>> reprobe to ensure all MST ports are properly detected. This works around a
>> race condition where some MST hubs incorrectly report port status bits before
>> their internal state is fully initialized.
>>
>> By forcing the reprobe immediately after resume, combined with the fix in
>> drm_dp_mst_handle_link_address_port() that detects input->output port
>> transitions, we ensure that all displays are reliably detected even if the
>> hub initially reports incorrect port status.
>>
>> Signed-off-by: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
>
> Is there a bug report about this with logs?
>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
>> index 3a67990411b3..fceda523efa3 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -7088,6 +7088,7 @@ void intel_dp_mst_resume(struct intel_display *display)
>>  
>>         for_each_intel_encoder(display->drm, encoder) {
>>                 struct intel_dp *intel_dp;
>> +               struct drm_dp_mst_branch *mstb;
>>                 int ret;
>>  
>>                 if (encoder->type != INTEL_OUTPUT_DDI)
>> @@ -7102,6 +7103,23 @@ void intel_dp_mst_resume(struct intel_display *display)
>>                 if (ret) {
>>                         intel_dp->is_mst = false;
>>                         drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst.mgr, false);
>> +                       continue;
>> +               }
>> +
>> +               /* After resume, force a link address reprobe to ensure all ports
>> +                * are properly detected. This works around a race condition where
>> +                * some MST hubs incorrectly report port status bits during warm boot/G3.
>> +                * Ref: Sporadic second display not detected after warm boot/G3
>> +                */
>> +               if (intel_dp->is_mst) {
>> +                       mutex_lock(&intel_dp->mst.mgr.lock);
>> +                       mstb = intel_dp->mst.mgr.mst_primary;
>> +                       if (mstb) {
>> +                               drm_dp_mst_topology_get_mstb(mstb);
>> +                               mstb->link_address_sent = false;
>> +                               drm_dp_mst_topology_put_mstb(mstb);
>> +                       }
>> +                       mutex_unlock(&intel_dp->mst.mgr.lock);

This is topology manager internal stuff we have no business messing with
in drivers. So much so that drm_dp_mst_topology_get_mstb() and
drm_dp_mst_topology_put_mstb() are *static* functions in
drm_dp_mst_topology.c.

How did you build and run this?



>>                 }
>>         }
>>  }

-- 
Jani Nikula, Intel
