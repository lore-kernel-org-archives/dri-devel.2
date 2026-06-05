Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A42CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1711911A4B3;
	Fri,  5 Jun 2026 15:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LU+sEXeW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9904E11A4B3
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykStheHWzMecvQlC8/orrpWH+CEGzXq9KPPg3CU9BFw=;
 b=LU+sEXeWuqSKukbnP0itPE9k1HupeeoK8NBEILy6vK4zFhix06eFeD61YOMbqgKwh+ngha
 TXhVbcnYj6L1p67owTQvZVWRahFMhdFpVcaDkSRwc2iB5e99hWkQmNxFF4ouf+wmF2neFl
 2k3YoQbc9sbg+oKtUdhoWEaH+bb2Odo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-429dvvwrPMSlAm4-QG3ySg-1; Fri, 05 Jun 2026 11:42:28 -0400
X-MC-Unique: 429dvvwrPMSlAm4-QG3ySg-1
X-Mimecast-MFC-AGG-ID: 429dvvwrPMSlAm4-QG3ySg_1780674147
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51771d41426so27887431cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674147; x=1781278947;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ykStheHWzMecvQlC8/orrpWH+CEGzXq9KPPg3CU9BFw=;
 b=BPVFAjswv4JFjWnSK8Us2FooAx6JcDXMFt2aH4yLoGTRaZWB8+1B5c2YB4wjGlfbCE
 JHlermY5qOKEUvJlZEdK3izkPOiyJJSgNeh+JhvVj2odTfFjjz4mMbC1ZRMnCXaK+Ax/
 G75HXWGg6fsFTuv7uKunU8Zw2DqqMlvTYCUSKKHoI8bLVdrC8maxKnQ0lrQDrC/xcJXi
 haARCuNLakmfRiTbX2gm9zzgEpjDkqY7B8UyJn6nGqG6BuOQCd3jrcRDbJB6iUt2m8lp
 IkL5q7tNRTMAS/OsbKmc117PAbnZYoWUF8opQ31RupVJoZYlJPx+PzAiWFHQygdmwubn
 tX0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hOt4huG/xLrwoLZosYimu5eorv3BeZB0ocWvdan6M7Nd1jRL24G0RwZtml3QxJvPysrqOJI54Z5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHOUhLdcd37iFMkKNvqXAmJWx4ySyX39Pud4x7BJZxWWGZy+Ai
 H2FX1/oryGHcHcikCbnHwmHTXisbqUROZi/x1OwX7LoVkJjo2qM6OuIcSNzZzeZ75SKSOP5U7M6
 kL1tHTdEo0RIQChlKb3ZmfdfKH3vlYCX8316EuVozdRVp0k3WyE2Ca998hbPEM6kDO4I08w==
X-Gm-Gg: Acq92OHlwBkoGCecmLLAu9avleta4yKHr8Jz02WaPpmno+4YPzJFuN3KOB8pE218Psw
 JV+gWCeEaeW7hPm55a11jEbHJqOY+BbRMXBm7S7R2i3Gp5TrSX6RJuwQXXRFD3AXHRtVrZWIn+w
 bEyBWrZNK6IvlHrwtbTj0ul0uE8UqAfmDLSNEFUM0jbRwJXLpTFwkwjrXe9ClQKEvrspRtl6uQR
 mHxDyPwYBeXag38bPNz3+Yzystnv3LyYiw0DTV1yfxsjulP+L8zQPuySJTdVszJaQOxrlZUE0z/
 6P/ZxpPp/E66bGaLb7MsIijjUXWqZ9DgoAu/C4heKoqq9Tt2Ho5tNOW7CIurN9EIlxqkqnnBBv9
 Np0ZS4y5/i2/qSdOk8y3BC8TRmm9+Qfg4gABgj0aKctArmmD73t/mLZEs7/HPgCHj4tjmnVZv+7
 BW
X-Received: by 2002:a05:620a:f11:b0:915:8f08:5f9d with SMTP id
 af79cd13be357-915a9dd4bd8mr792212685a.56.1780674147323; 
 Fri, 05 Jun 2026 08:42:27 -0700 (PDT)
X-Received: by 2002:a05:620a:f11:b0:915:8f08:5f9d with SMTP id
 af79cd13be357-915a9dd4bd8mr792205585a.56.1780674146859; 
 Fri, 05 Jun 2026 08:42:26 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net.
 [100.17.21.205]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3d2384sm921805785a.39.2026.06.05.08.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:42:26 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:42:25 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <aiLVbQPxK1qI1h4p@x1nano>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain> <ahXKFYBdCMDBvc_N@x1nano>
 <158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se>
MIME-Version: 1.0
In-Reply-To: <158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VdAW17HOYEy1JEpXrlW0U0LpdzCwxX9J7zx5O75W04c_1780674147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On Fri, Jun 05, 2026 at 01:27:09PM +0200, Maarten Lankhorst wrote:
> Hey,
> 
> On 5/26/26 18:59, Eric Chanudet wrote:
> > On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
> >> Hello Eric.
> >>
> >> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> >>> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> >>> configure whether allocations in a dmem region should also be charged to
> >>> the memory controller.
> >>
> >> This kinda makes sense as it is not unlike io.cost.* device
> >> configurators.
> >>
> >> Just for my better understanding -- will there be a space for userspace
> >> to switch this? (No charged dmem allocations happen before responsible
> >> userspace runs, so that the attribute remains unlocked.)
> >>
> >> (I'm rather indifferent about the actual double charging/non-charging
> >> matter.)
> > 
> > Yes, this is intended to be configured before the user space stack that
> > would start allocating things is started. Once it has started (and tried
> > to charge something), the configuration is locked
> > 
> >>
> >>>
> >>> To handle inheritance, dmem adds a depends_on the memory controller,
> >>> unless MEMCG isn't configured in.
> >>>
> >>> Double-charging is disabled by default. Once a charge is attempted, the
> >>> setting is locked to prevent inconsistent accounting by a small 4-state
> >>> machine (off, on, locked off, locked on).
> >>>
> >>> The memcg to charge is derived from the pool's cgroup, since the pool
> >>> holds a reference to the dmem cgroup state that keeps the cgroup alive
> >>> until it gets uncharged.
> >>>
> >>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> >>> ---
> >>>  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
> >>>  kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
> >>>  2 files changed, 178 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> >>> index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
> >>> --- a/Documentation/admin-guide/cgroup-v2.rst
> >>> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >>> @@ -2828,6 +2828,29 @@ DMEM Interface Files
> >>>  	  drm/0000:03:00.0/vram0 12550144
> >>>  	  drm/0000:03:00.0/stolen 8650752
> >>>  
> >>> +  dmem.memcg
> >>> +	A readwrite nested-keyed file that exists only on the root
> >>> +	cgroup.
> >>
> >> Strictly speaking this is not nested-keyed but flat keyed [1],
> > 
> > Indeed,
> > 
> >> which leads me to realization that this is the first instance of a boolean.
> >> All in call, such a composition comes to my mind (latter is RO):
> >>
> >> 	drm/0000:03:00.0/vram0 enable=0|1 locked=0|1
> >>
> > 
> > So per[1] 1 key, 2 sub-keys (enable RW, locked RO), that looks better
> > and match the documentation, thanks!
> > 
> >>
> >>
> >>> +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
> >>> +				       size_t nbytes, loff_t off)
> >>> +{
> >>> +	while (buf) {
> >>> +		struct dmem_cgroup_region *region;
> >>> +		char *options, *name;
> >>> +		bool flag;
> >>> +
> >>> +		options = buf;
> >>> +		buf = strchr(buf, '\n');
> >>> +		if (buf)
> >>> +			*buf++ = '\0';
> >>
> >> I recall there was a discussion about accepting only a single device per
> >> write(2) (at the same time I see this idiom is still present in other
> >> dmem.* files, so this is nothing to change in _this_ patch).
> > 
> > I would second that. When setting say dmem.max for 2 regions, with a
> > typo on the second, the first one is set, but write still get EINVAL.
> > 
> > Also, I just notice dmemcg_limit_write() returns EINVAL if the region is
> > not found (this patch returns ENODEV).
> > 
> >>
> >> Thanks,
> >> Michal
> >>
> >> [1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format
> > 
> > 
> > 
> 
> Perhaps a bit late, but before we start adding this UAPI we should enforce a
> single region per write?

I can send that separately, although that is a UAPI change. Is there any
user that would be affected?

This series is hung on charging memcg using memory objects from the
context of dmem, when at that level of abstraction it doesn't have
access to the underlying pieces that were allocated.

Best,

> 
> Kind regards,
> ~Maarten Lankhorst
> 

-- 
Eric Chanudet

