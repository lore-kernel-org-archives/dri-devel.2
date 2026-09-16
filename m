Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A375C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB3710E142;
	Wed, 16 Sep 2026 10:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZJmhRjYE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CB910E142;
 Wed, 16 Sep 2026 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789553813; x=1821089813;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sHZq/+hwwyNlQNbAViJguD8cSDqTRYGs0NnMZi4IZDg=;
 b=ZJmhRjYEVOqU6lb8zuj2TDGT5oDqM6+pMJlLnxmsMnWS0FQIs1PXeD3x
 nQwsrac85t9EWtx7jrNop22CMpVPSrK1F9EB05KqFW9mO8SNHquDmVvUF
 vWtTKc42wDl+AAHa85GID6rG5kBx0yJrr8kYuhyFm4EmEyeYg0uw4mcDN
 RHRoo9NvwUTW8g6NGihh7TU33dq7KdH4RW2j4khvXR/tDNcqjZQ+HH2d7
 Fc/fFhEHhb+fDy6dB4ZvuN9oexOJzt6ddpSHJlM53N4oZZkOh2vPEB7XE
 9mSiOhyFmuTIbeorceRV9xNzAUCvC5G6Yma8stiiH0EjTBBZuJaxhYJBp g==;
X-CSE-ConnectionGUID: 4oqn7Gk+RW2DOHYTX1/e6Q==
X-CSE-MsgGUID: P05EtQPSQzq13+MFN7K+6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115465294"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="115465294"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:16:53 -0700
X-CSE-ConnectionGUID: BIzbzQCESKWB3QE+lWwhjA==
X-CSE-MsgGUID: kiS3hSZbTteNTkDkdzYvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272821872"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by orviesa008-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:16:51 -0700
Date: Wed, 16 Sep 2026 12:16:34 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 steven.price@arm.com, liviu.dudau@arm.com,
 adrian.larumbe@collabora.com, samitolvanen@google.com
Subject: Re: [PATCH i-g-t] tests/panthor: skip sparse VM_BIND tests before v1.9
Message-ID: <20260916101634.y76mihla7uhetbc4@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 steven.price@arm.com, liviu.dudau@arm.com,
 adrian.larumbe@collabora.com, samitolvanen@google.com
References: <20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com>
 <20260916075741.zeu3k3bd7ynwdrju@kamilkon-DESK.igk.intel.com>
 <20260916103922.1180951b@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916103922.1180951b@fedora-21.home>
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

Hi Boris,
On 2026-09-16 at 10:39:22 +0200, Boris Brezillon wrote:
> Hi Kamil,
> 
> On Wed, 16 Sep 2026 09:57:41 +0200
> Kamil Konieczny <kamil.konieczny@linux.intel.com> wrote:
> 
> > Hi Deborah,
> > On 2026-09-15 at 17:13:26 -0700, Deborah Brouwer wrote:
> > > Sparse VM_BIND support was introduced with Panthor DRM driver version
> > > 1.9. If a driver isn't advertising support for v1.9, then tests that
> > > call DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE should not be run.  
> > 
> > Can you just call that ioctl and if EINVALID skip?
> > Checking version of a driver seems strange.
> 
> That's how we check feature-support in mesa, so I'd be tempted to do
> the same in IGT, unless there's a strong reason not to. If we were to
> check against EINVAL to detect when a feature is not supported, it gets
> hard to know when it's an actual uAPI regression vs when it's tested
> against a driver version that's too old and doesn't support the extra
> arguments/flags.
> 
> Regards,
> 
> Boris

ok, thx for explanation. So just calls with checks for feature
at each subtest which needs this should be enough.

Regards,
Kamil

PS. Deborah please subscribe to igt-dev mailing list or expect
delays with your e-mails reaching it.
