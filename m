Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95944C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A332F10E524;
	Tue, 22 Sep 2026 03:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="WHsDsWt0";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC5110E524;
 Tue, 22 Sep 2026 03:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790046514; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RrB978wScXs9iSrZOO1nRdUbVB6bf6fJuTze2rhnRmxL8WsxbWHQqefT3M1Q2QAJY84WpTZOyadqGRPOQBP4bsciliz7mRK3WW28X30WYtSjtQM29K2EW8sNLozi5O0vGNPJbFDJeYqs9WDS6uF6KnxkY1vQLmirvXZp1YOFRo8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790046514;
 h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=6BV4+6rgsOvQNz5synrlXOC46LAjc6YISArfVG1qGcY=; 
 b=HpDZhVNm622QiVDWP0CN7Md4zkKMKyfEVTBPehs66HGo4ao6C+oez9zzHp1e9h2BQdB52ahEgnE//NnjLePQH/c4kZCY21GfXss9CKn2asxdXhKQ6dOdNfYu43R9POXmAThyxJBTzjZ+TlQMm0H/5d07At/D2fj6LySHMpQeB24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790046514; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To:Cc;
 bh=6BV4+6rgsOvQNz5synrlXOC46LAjc6YISArfVG1qGcY=;
 b=WHsDsWt0KvcCbzEsFJx3WeNuc1pH7vZ7jf+a70k4slCwKA6LljCFX28hVnqPmvKR
 o8ne4iEIWVMMeCGI3kH6/QKvUkGYxU1ucw0XhK0GPz1gpOXCHKocHn/mUoP1+Ad2SwW
 2CYcW868hk0J24eBqO+tzYXe9wG0pBbxO4u1mZkE=
Received: by smtp.zohomail.com with SMTPS id 1790046513340494.0176577767853;
 Mon, 21 Sep 2026 20:08:33 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:08:32 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com, samitolvanen@google.com
Subject: Re: [PATCH i-g-t v2] tests/panthor: skip sparse VM_BIND tests before
 v1.9
Message-ID: <arHxMAOmIUUBZCEe@um790>
References: <20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com>
 <20260921152240.4j6paghgr3vktbuv@kamilkon-DESK.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921152240.4j6paghgr3vktbuv@kamilkon-DESK.igk.intel.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.25.6
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

On Mon, Sep 21, 2026 at 05:22:40PM +0200, Kamil Konieczny wrote:
> Hi Deborah,
> On 2026-09-20 at 17:59:09 -0700, Deborah Brouwer wrote:
> 
> I have one more nit, see below, and an ask for you or other
> panthor developers to look into igt work item on gitlab:
> 
> gputop does not work with the panthor kernel driver
> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/work_items/209

Sure, I was able to reproduce this gputop problem today and will send
a fix separately.

> 
> > Sparse VM_BIND support was introduced with Panthor DRM driver version
> > 1.9. If a driver isn't advertising support for v1.9, skip the sparse
> > VM_BIND subtests.
> > 
> > Use the advertised driver version rather than probing for EINVAL, since
> > EINVAL may also indicate a uAPI regression rather than lack of support for
> > sparse VM_BIND.
> > 
> > Add a shared macro igt_require_panthor_version() to check the version in
> > case other Panthor tests would like to use it in the future.
> > 
> > The Panthor version macro wraps the igt_require_f() macro so that we can
> > clear the last errno. The last errno is irrelevant to the version check
> > but __igt_skip_check() will still print it like this:
> > 
> >   Starting subtest: vm_bind_sparse
> >   Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
> >   Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
> >   Requires Panthor version 1.9 or newer
> >   Last errno: 2, No such file or directory
> >   Subtest vm_bind_sparse: SKIP (0.000s)
> > 
> > This makes the log noisier than it already is. So set the errno to 0 to
> > suppress that line. Skipping the test will now print:
> > 
> >   Starting subtest: vm_bind_sparse
> >   Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
> >   Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
> >   Requires Panthor version 1.9 or newer
> >   Subtest vm_bind_sparse: SKIP (0.000s)
> > 
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> > Changes in v2:
> > - check for version at each subtest
> > - make version check available to all panthor tests
> > - use macro to suppress printing the last error
> > - Link to v1: https://lore.kernel.org/r/20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com
> > ---
> >  lib/igt_panthor.c          | 14 ++++++++++++++
> >  lib/igt_panthor.h          | 18 ++++++++++++++++++
> >  tests/panthor/panthor_vm.c | 18 ++++++++++++++++++
> >  3 files changed, 50 insertions(+)
> > 
> > diff --git a/lib/igt_panthor.c b/lib/igt_panthor.c
> > index 11d8ec342..0f8c408d5 100644
> > --- a/lib/igt_panthor.c
> > +++ b/lib/igt_panthor.c
> > @@ -385,3 +385,17 @@ void igt_panthor_free_bo(int fd, struct panthor_bo *bo)
> >  
> >  	gem_close(fd, bo->handle);
> >  }
> > +
> > +bool __igt_panthor_driver_version_at_least(int fd, int major, int minor)
> > +{
> > +	drmVersionPtr version = drmGetVersion(fd);
> > +	bool supported;
> > +
> > +	igt_assert(version);
> > +	supported = version->version_major > major ||
> > +		    (version->version_major == major &&
> > +		     version->version_minor >= minor);
> > +	drmFreeVersion(version);
> > +
> > +	return supported;
> > +}
> > diff --git a/lib/igt_panthor.h b/lib/igt_panthor.h
> > index ba4a9bf1e..626e5d525 100644
> > --- a/lib/igt_panthor.h
> > +++ b/lib/igt_panthor.h
> > @@ -37,6 +37,24 @@ void igt_panthor_group_submit_simple(int fd, uint32_t group_handle,
> >  				     uint32_t stream_size, uint32_t syncobj_handle,
> >  				     int err);
> >  uint64_t igt_panthor_get_first_core(uint64_t cores_present);
> > +bool __igt_panthor_driver_version_at_least(int fd, int major, int minor);
> > +
> > +/**
> > + * igt_require_panthor_version:
> > + * @fd: device file descriptor
> > + * @major: required Panthor major version
> > + * @minor: required Panthor minor version
> > + *
> > + * Require the Panthor version to be at least the requested version.
> > + */
> > +#define igt_require_panthor_version(fd, major, minor) do { \
> 
> Can you make it a function in test? Macro seems an overkill.
> Also, it could be moved to library when there will be more
> users in other tests.
> 
> Regards,
> Kamil
> 
> > +	/* igt_require_f() reports errno through __igt_skip_check(); */ \
> > +	/* clear it since errno is unrelated to the version check. */ \
> > +	errno = 0; \
> > +	igt_require_f(__igt_panthor_driver_version_at_least(fd, major, minor), \
> > +		      "Requires Panthor version %d.%d or newer\n", \
> > +		      major, minor); \
> > +} while (0)
> >  
> >  static inline void igt_panthor_vm_bind(int fd, uint32_t vm_id, uint32_t bo_handle,
> >  				       uint64_t va, uint64_t size, uint32_t flags, int err)
> > diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
> > index 9011df25e..bd8f14ecb 100644
> > --- a/tests/panthor/panthor_vm.c
> > +++ b/tests/panthor/panthor_vm.c
> > @@ -293,6 +293,7 @@ int igt_main() {
> [cut]
