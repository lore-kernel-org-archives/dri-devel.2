Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AD5CC6B33
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A389D10F11D;
	Thu,  2 Apr 2026 08:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VY5WM8Qj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A838910F0A7;
 Thu,  2 Apr 2026 08:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775118677; x=1806654677;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=W6H4vpJGXBNWpsK/BM6SICbh2E4VQe05xQI/bmBa/ys=;
 b=VY5WM8QjSRecSorjgCtRYn0jjcJxgGX8iYU1pX/3k8xdqJDLhav7zB77
 GNPDSob0ASHlnyF5lslyCrNScfFZa8nIsd2YXpegDEyeX62pktYyz+sjX
 aQpjGxFjyVLOv7cS/gLzQkR2/A7qJ8mg8jalKQRbxEF8OQQ9mpeYarqut
 YciYOMjtyM8sArqEqnvKCTmQA4aiuOXBjYoQaME5Enx0C5RVdU8FcpmTX
 ScUqVCVdzndGZqGI6gKWpF7VgRaknlOcnsFjh0NUyccTkWyPO/nv+pp/9
 dxpmibtrUsMykM6fehpb1r5l5VPiXJI5ys/31L2fTfrdOdJax5USVm1k0 A==;
X-CSE-ConnectionGUID: QTViJJ4ZSeemAh0WafbKCg==
X-CSE-MsgGUID: pZnjIHWOQJKsbKKSt0w/Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="63722650"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="63722650"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:31:16 -0700
X-CSE-ConnectionGUID: iIV0kCAJRfaXJJK06UkhJg==
X-CSE-MsgGUID: Dr/fuwnpRyu/q44FWvhL9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="228532285"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:31:13 -0700
Date: Thu, 2 Apr 2026 10:31:10 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
Cc: "Tauro, Riana" <riana.tauro@intel.com>, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com
Subject: Re: [PATCH v2 5/5] drm/xe/debugfs: Add interface to trigger power
 management unit error handler
Message-ID: <ac4pTtjVZ7nxEsag@black.igk.intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-12-mallesh.koujalagi@intel.com>
 <ab3e5dcf-d259-4a29-a70b-071bcdd24ec2@intel.com>
 <227a4bce-b3dd-4633-a2ae-8dceb82a6653@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <227a4bce-b3dd-4633-a2ae-8dceb82a6653@intel.com>
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

On Mon, Mar 30, 2026 at 07:10:33PM +0530, Mallesh, Koujalagi wrote:
> On 30-03-2026 10:25 am, Tauro, Riana wrote:
> > On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
> > > Add a debugfs interface to manually trigger power management unit error
> > > handler for testing cold reset recovery paths. This is useful for
> > > validating the error recovery mechanism.
> > > 
> > > The new debugfs entry 'trigger_punit_error' is located at:
> > >    /sys/kernel/debug/dri/N/trigger_punit_error
> > > 
> > > Reading the file displays usage instructions. Writing '1' invokes
> > > xe_punit_error_handler(), which marks the device as wedged with
> > > DRM_WEDGE_RECOVERY_COLD_RESET method and sends a uevent to userspace
> > > indicating that a complete device power cycle is required for recovery.
> > > 
> > > Writing '0' or any other false value has no effect.
> > > 
> > > This interface is intended for development, testing, and validation
> > > of power management unit error recovery code.
> > 
> > Would fault injection be more appropriate here?
> 
> Here we need a deterministic way to invoke the punit error handler to test
> the cold-reset
> 
> recovery flow end-to-end. Using debugfs interface, we directly triggers
> wedge/reset status via a debugfs write
> 
> rather than using fault injection.

I think the question from Riana was, since fault injection can provide
wider coverage of all different kind of error flows, would it make more
sense to reuse it for punit as well?

Raag

> > > Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_debugfs.c | 38 +++++++++++++++++++++++++++++++++
> > >   1 file changed, 38 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_debugfs.c
> > > b/drivers/gpu/drm/xe/xe_debugfs.c
> > > index 844cfafe1ec7..390bbed9c1af 100644
> > > --- a/drivers/gpu/drm/xe/xe_debugfs.c
> > > +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> > > @@ -18,6 +18,7 @@
> > >   #include "xe_gt_debugfs.h"
> > >   #include "xe_gt_printk.h"
> > >   #include "xe_guc_ads.h"
> > > +#include "xe_hw_error.h"
> > >   #include "xe_mmio.h"
> > >   #include "xe_pm.h"
> > >   #include "xe_psmi.h"
> > > @@ -509,6 +510,40 @@ static const struct file_operations
> > > disable_late_binding_fops = {
> > >       .write = disable_late_binding_set,
> > >   };
> > >   +static ssize_t trigger_punit_error_show(struct file *f, char
> > > __user *ubuf,
> > > +                    size_t size, loff_t *pos)
> > > +{
> > > +    const char *msg = "Write 1 to trigger power management unit
> > > error handler\n";
> > > +
> > > +    return simple_read_from_buffer(ubuf, size, pos, msg, strlen(msg));
> > > +}
> > > +
> > > +static ssize_t trigger_punit_error_set(struct file *f,
> > > +                       const char __user *ubuf,
> > > +                       size_t size, loff_t *pos)
> > > +{
> > > +    struct xe_device *xe = file_inode(f)->i_private;
> > > +    bool trigger;
> > > +    ssize_t ret;
> > > +
> > > +    ret = kstrtobool_from_user(ubuf, size, &trigger);
> > > +    if (ret)
> > > +        return ret;
> > > +
> > > +    if (trigger) {
> > > +        xe_punit_error_handler(xe);
> > > +        drm_info(&xe->drm, "PMU error handler triggered via
> > > debugfs\n");
> > > +    }
> > > +
> > > +    return size;
> > > +}
> > > +
> > > +static const struct file_operations trigger_punit_error_fops = {
> > > +    .owner = THIS_MODULE,
> > > +    .read = trigger_punit_error_show,
> > > +    .write = trigger_punit_error_set,
> > > +};
> > > +
> > >   void xe_debugfs_register(struct xe_device *xe)
> > >   {
> > >       struct ttm_device *bdev = &xe->ttm;
> > > @@ -550,6 +585,9 @@ void xe_debugfs_register(struct xe_device *xe)
> > >       debugfs_create_file("disable_late_binding", 0600, root, xe,
> > >                   &disable_late_binding_fops);
> > >   +    debugfs_create_file("trigger_punit_error", 0600, root, xe,
> > > +                &trigger_punit_error_fops);
> > > +
> > >       /*
> > >        * Don't expose page reclaim configuration file if not
> > > supported by the
> > >        * hardware initially.
