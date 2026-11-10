Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F8606A9AE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K2nc1TQK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7631E10E1BA;
	Tue, 10 Nov 2026 08:33:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8708810E1BA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794299598; x=1825835598;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9oN95ZA4jEjnzxdU9ScDVMSmvNyC8EvdIzAKDGnxVZU=;
 b=K2nc1TQKSJ3aBLr6BvOXH2s6fuW1JdirvB2AOP12IwQCqdDHdfAO71aX
 BIhsF2orxY6SSR6lthXgaFJ9bmO7cnpb1WP1Tf6wlb1inIs5fR3WEmmoN
 TrrPifGzPllSIgvVwzxO/vrIPqs448IftFU34drVEhP5gE3ZOK/NZDK3U
 w0ZZittbFLnEWhqXLCezMfGFI68NsO730DCt1CaKIOlobrz0Zj6uT+eT7
 nBxE7RgTS8WImrrfAKjTB8PX38xy9J8lxEF/9RjxSVZVzFBcQmLp3KLr+
 dLmMR0cbJvd1ogSLIWqndBRgW7+sLTmE5kmaZL8XYX9AamKeiZdlRDRIb w==;
X-CSE-ConnectionGUID: WkVIwFbUTHmFBcowdxDETQ==
X-CSE-MsgGUID: yrjxhj2lRES81KJLeo9CYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2917622"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2917622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:33:17 -0800
X-CSE-ConnectionGUID: syTa/s+/Slqv9eDthMs6PQ==
X-CSE-MsgGUID: k4afLezBRsq5gMKRWziD8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8101890"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:33:16 -0800
Message-ID: <f585562b-dbdc-415b-a493-475cf545a092@linux.intel.com>
Date: Tue, 10 Nov 2026 09:33:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Disable recovery work on probe failure
To: Daksh Sahni <swizzguy76@gmail.com>
Cc: jacek.lawrynowicz@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, andrzej.kacprowski@linux.intel.com
References: <20261107174215.15818-1-swizzguy76@gmail.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <20261107174215.15818-1-swizzguy76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 07-Nov-26 18:42, Daksh Sahni wrote:
> If the NPU raises an error interrupt while ivpu_dev_init() boots the
> firmware, the Buttress, MMU or WDT IRQ handler calls
> ivpu_pm_trigger_recovery(), which queues recovery_work. When ivpu_boot()
> then fails, the err_ipc_fini path tears the device down without
> disabling recovery_work and probe returns an error. devres unmaps the
> register BARs while the work is still queued or running, and the work
> faults on the first register access:
> 
>    BUG: unable to handle page fault for address: ffffcfc6680200f4
>    Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
>    RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
>    Call Trace:
>     ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
>     ivpu_boot+0x9e/0x270 [intel_vpu]
>     ivpu_resume+0xa4/0xd0 [intel_vpu]
>     ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
>     ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
>     process_one_work+0x1da/0x3c0
>     worker_thread+0x1af/0x340
>     kthread+0xfa/0x130
>     ret_from_fork+0x2b9/0x380
>     ret_from_fork_asm+0x1a/0x30
> 
> The work dies between pm_runtime_disable() in ivpu_pm_reset_begin() and
> pm_runtime_enable() in ivpu_pm_reset_complete(), so the PCI device is
> also left with runtime PM disabled and never autosuspends after a later
> rebind.
> 
> Commit 5eaa49741119 ("accel/ivpu: Prevent recovery invocation during
> probe and resume") stopped IPC failures during probe from triggering
> recovery, but the IRQ handlers still can.
> 
> Call ivpu_pm_disable_recovery() at the start of the err_ipc_fini path,
> as ivpu_dev_fini() already does, so the work is flushed and cannot be
> queued again before the device is torn down.
> 
> Reproduced on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware
> 20260219) by kexec'ing with the NPU runtime-suspended: probe in the new
> kernel gets an ATS_ERR Buttress IRQ during firmware boot. With this
> change probe still fails with -ECANCELED, there is no oops, and an FLR
> followed by a rebind brings the NPU back.
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daksh Sahni <swizzguy76@gmail.com>

  Hi Daksh,

  Thanks for the report and the thorough analysis, it's correct. An error
  IRQ that fires once ivpu_boot() has enabled interrupts can queue
  recovery_work during probe, and nothing on the probe error path stops
  it.

  As Sashiko pointed out, disabling the work on err_ipc_fini comes too
  late. By then recovery_work may already have run concurrently with
  ivpu_boot(). It can also race with a probe that succeeds, which you saw
  yourself in one of your runs.

  I'll send a v2 that addresses this along the lines you offered and
  Sashiko suggested. recovery_work stays disabled for the whole of probe
  and is enabled in ivpu_pm_enable(). A recovery requested during probe
  is not lost. If ivpu_boot() fails, probe unwinds with nothing pending.

  If  probe succeeds, ivpu_pm_enable() runs the deferred recovery and
  waits for it before issuing the initial autosuspend request. The NPU is
  then reset before first use, and the autosuspend no longer lands while
  runtime PM is disabled, which covers your second note too. The patch
  will keep your Reported-by.

  I'm running it through our internal CI first and will post it once that
  passes. When it's out, could you test it on your Meteor Lake kexec
  setup and reply with your Tested-by? Once I have it, I'll go ahead
  and merge.

  Thanks,
  Karol
> ---
> 
> Notes:
>      Tested on v7.4-rc1 (d48723711bae).
>      
>      Two things this patch does not address:
>      
>      The trigger is kexec with the NPU runtime-suspended in the old kernel.
>      The driver has no .shutdown hook, so the new kernel's probe sees stale
>      NPU state and gets ATS_ERR. A cold boot doesn't hit it. Whether that
>      wants a shutdown hook or a reset at probe seems like your call.
>      
>      In one of four runs that hit ATS_ERR, probe succeeded while
>      recovery_work was running concurrently. Probe returned 0, but the
>      autosuspend request from ivpu_pm_enable() landed while recovery had
>      runtime PM disabled, so the NPU stayed active until first use. Not
>      allowing IRQ-triggered recovery until ivpu_pm_enable() would cover both
>      cases; I can send a v2 that does that if you prefer.
> 
>   drivers/accel/ivpu/ivpu_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 247ed6b2ff62..4fcccf78ec5d 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -852,6 +852,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
>   	return 0;
>   
>   err_ipc_fini:
> +	ivpu_pm_disable_recovery(vdev);
>   	ivpu_ipc_fini(vdev);
>   err_fw_fini:
>   	ivpu_fw_fini(vdev);

