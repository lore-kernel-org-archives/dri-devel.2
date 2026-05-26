Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6CDCD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A56610E749;
	Tue, 26 May 2026 16:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IrQshl4Y";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1367F10E749
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779814750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73qJRcIVQTUMp+UCzOKPBNoPdNKc7KyWvvJbngzri24=;
 b=IrQshl4YLBEKVQSARTc1lqzl/wPCM635kGALBBri5JNqMDQvMAAYmG241r4s74vZh4Pp9O
 qGwIiLdZdIOxQ8YI+HlfK8RlRPlCWWbsoquKZI+4lyn9zZWCxwe0m07f5pA/xSfz5gRsfZ
 nvPDjr3bTS+KKgj4k0dlLP4VjAA+wnk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-9dykTCbxOuigI2mEuxqF9g-1; Tue, 26 May 2026 12:59:08 -0400
X-MC-Unique: 9dykTCbxOuigI2mEuxqF9g-1
X-Mimecast-MFC-AGG-ID: 9dykTCbxOuigI2mEuxqF9g_1779814748
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9112b2755abso2512703685a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779814748; x=1780419548;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73qJRcIVQTUMp+UCzOKPBNoPdNKc7KyWvvJbngzri24=;
 b=iCxC4LQk2CU10Jdz/hf9vxVLXdsYGxNOJyhizmSXegUn5ZQFEebCwWIX8b1xOsmoMS
 GqBGU7t3JeI4kW8uaXi1DNzFzamZYqgoowK111SEhA9go3S0JNgErurVMhiQQ4kgD8PF
 UVYfOEs2VJSfCwKCSHKn2UARRq77sbtjpPfTKwPbMmMy30Ymf24eDIpuJvpssbXpa47J
 9vfCU2T/9CT99+eD82PIAsp2torUiSHIKuHjgR2W4XeK26VFqxgVsBlAG62sJzRtdakH
 bnile1M9O/3/Gw83sravpgFr1LrbdB/2lq3xhr+I09+05f9mJRI2XBTbDJdAcRcRFKjS
 bK0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BaRb5UOizR0tHKYtOC5Qp9vWjohBuPPO/sXAv592CAZuBH7gst6cKt+GXobeP0yEC7oBEwGqC3Ao=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU25dSB9KUrj94XhSHnAh6RTvkOJvgJQQcb9gMOiAi1tLg34DW
 cvSZOq+in9Gz1jJq/3mB+XaPzcNE15/1QffR7e4vUSVRB62doPXJERfH80tF5zWnX5nYknWVg6a
 bQ9V/SHPOYEOYjO0POsPwEdxxIpq/tHCwc4Uz4oQVHu7tlI3o/2ZmBbK25aEZOf1B6N7HbA==
X-Gm-Gg: Acq92OG3nwYvMdlsi743WjAUccEEMMgk763ZFixsUtXnjzNjS0Zx5kzrZIyJe3Tu+6b
 WmNHHmbSVg0Fe+SM/aJ9vPasFTJmPbOYs8j5k/zy9Gu+1RMyHtji9ZIfAca686RqRiIj+Zk8Ie/
 A3N5M0DFhXo0Iu+ZUaui5DUD2jh+WaFIuxlK3a7lDosZ5nMwfNoSmTfYjDjMGbfUavGH/5Kq6Sw
 U+LWPtnZLkTKon9owjpBqUOnNXKXW+wBz+FzKOhlYZGG/JHIs0oeAOtK8SkMJCNHETU6Z6pnjjo
 3o9A7FCvQfFWcXM/PdY6h1MAHM70M/WR2gAvfGxn1arMOwpJCQvlAGqIpe++XIVhlel554oiQ59
 V47Oen5ecKiVHPOEjriCAuPEZmyoTUpUmwaMQ6Qfm4Cm0b6v/gIZ+k7MUOrIPTUDwLQ==
X-Received: by 2002:a05:620a:2718:b0:914:c0e8:224 with SMTP id
 af79cd13be357-914c0e80a72mr2780657385a.54.1779814748190; 
 Tue, 26 May 2026 09:59:08 -0700 (PDT)
X-Received: by 2002:a05:620a:2718:b0:914:c0e8:224 with SMTP id
 af79cd13be357-914c0e80a72mr2780650485a.54.1779814747523; 
 Tue, 26 May 2026 09:59:07 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net.
 [100.17.21.205]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f8806496sm245054085a.38.2026.05.26.09.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:59:06 -0700 (PDT)
Date: Tue, 26 May 2026 12:59:05 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <ahXKFYBdCMDBvc_N@x1nano>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <ahBxB5a9sX9DEWvl@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zidA7M6GZXXv4ZNLBxMoL9e2A7v6-VzkUw003ZW6_No_1779814748
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

On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
> Hello Eric.
> 
> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> > Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> > configure whether allocations in a dmem region should also be charged to
> > the memory controller.
> 
> This kinda makes sense as it is not unlike io.cost.* device
> configurators.
> 
> Just for my better understanding -- will there be a space for userspace
> to switch this? (No charged dmem allocations happen before responsible
> userspace runs, so that the attribute remains unlocked.)
> 
> (I'm rather indifferent about the actual double charging/non-charging
> matter.)

Yes, this is intended to be configured before the user space stack that
would start allocating things is started. Once it has started (and tried
to charge something), the configuration is locked

> 
> > 
> > To handle inheritance, dmem adds a depends_on the memory controller,
> > unless MEMCG isn't configured in.
> > 
> > Double-charging is disabled by default. Once a charge is attempted, the
> > setting is locked to prevent inconsistent accounting by a small 4-state
> > machine (off, on, locked off, locked on).
> > 
> > The memcg to charge is derived from the pool's cgroup, since the pool
> > holds a reference to the dmem cgroup state that keeps the cgroup alive
> > until it gets uncharged.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
> >  kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
> >  2 files changed, 178 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -2828,6 +2828,29 @@ DMEM Interface Files
> >  	  drm/0000:03:00.0/vram0 12550144
> >  	  drm/0000:03:00.0/stolen 8650752
> >  
> > +  dmem.memcg
> > +	A readwrite nested-keyed file that exists only on the root
> > +	cgroup.
> 
> Strictly speaking this is not nested-keyed but flat keyed [1],

Indeed,

> which leads me to realization that this is the first instance of a boolean.
> All in call, such a composition comes to my mind (latter is RO):
> 
> 	drm/0000:03:00.0/vram0 enable=0|1 locked=0|1
> 

So per[1] 1 key, 2 sub-keys (enable RW, locked RO), that looks better
and match the documentation, thanks!

> 
> 
> > +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
> > +				       size_t nbytes, loff_t off)
> > +{
> > +	while (buf) {
> > +		struct dmem_cgroup_region *region;
> > +		char *options, *name;
> > +		bool flag;
> > +
> > +		options = buf;
> > +		buf = strchr(buf, '\n');
> > +		if (buf)
> > +			*buf++ = '\0';
> 
> I recall there was a discussion about accepting only a single device per
> write(2) (at the same time I see this idiom is still present in other
> dmem.* files, so this is nothing to change in _this_ patch).

I would second that. When setting say dmem.max for 2 regions, with a
typo on the second, the first one is set, but write still get EINVAL.

Also, I just notice dmemcg_limit_write() returns EINVAL if the region is
not found (this patch returns ENODEV).

> 
> Thanks,
> Michal
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format



-- 
Eric Chanudet

