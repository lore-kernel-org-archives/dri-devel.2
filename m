Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EFEDB7D0
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 23:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6263D10E4E4;
	Tue,  7 Apr 2026 23:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gzwV2I2n";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAF810E4E4
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775604961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSte9vRO1TSshWcFHdBwTd4rL0Ri6sBQhlLf+reom5g=;
 b=gzwV2I2ncUaqe4+QeLgjoWkgtjPeLfmFpCTr4rwSDxK4lI4btnWMqUO++NzW1aPp4fp8Ow
 WP8R4m4Jnvezxs8mFvTp60v/XkbRv16gtk2CR58hFskdBBfdyVr21kon4pDLTIVBCGJhjL
 1wglG0RCTCdDy3ecrqUPW8SFVaGvM7E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-HR8mRNS1MQmYn3WPPE-LZg-1; Tue, 07 Apr 2026 19:36:00 -0400
X-MC-Unique: HR8mRNS1MQmYn3WPPE-LZg-1
X-Mimecast-MFC-AGG-ID: HR8mRNS1MQmYn3WPPE-LZg_1775604959
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so136738611cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 16:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775604959; x=1776209759;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cSte9vRO1TSshWcFHdBwTd4rL0Ri6sBQhlLf+reom5g=;
 b=lTjeY25VJQzcM+gnZElSE8o0jdNu45F45mjmeqNsZ+/KxM+gCmOeZxKMjCLjMcCc1T
 U498CSeYc5Rz4dRDYMUmTRypAcSi7TsacYF5fktx4yzcw+WudF/xh++O0gNvMD+mpWqM
 2UAtml33AM6E/bXFSR5/ESLbUdXZlpzvs1Xs1yr+cIQ9ho07166sK5Zgo3PJCyF+koRQ
 iU6/RZAHsroTp1GCZAT8/48dhkUVexLlhuGGCaEyt/SENljvPLnjC7pYIGXOVFKGMBs/
 Nv3/KcbvejdhrE0GbNsjwZMiM2SqAFyTH70Zz5kbSoCJziYaSXCNnhXOJN4grRsUKzCF
 wyLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXio1qASlSuohlNa/KVfSi34rEtEF2Zg0tS2OKeqWbDlCDK615kyy3aa9QpCQeyhAICu4HdngWyEqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn0//4YxjtA+YIX8tKQosViuTkFibdccNTVfNJkR3Jsgp9o8c/
 w7A7PqcxSQWt4tACMqUWba/yB4HmA4bTpK96V0qZNbJbJleYKR3EYzBdlFgUbe5XxZW2IilOExx
 tTkqy5wlqckMQIyCrOK5VOtyIwaR9n6cwkqo1sM2EFKGawHn4BgJAJOv4nuQQZlT/DFvBuQ==
X-Gm-Gg: AeBDievZTBgrjiOG0G1Kk4nCUsXoNa7jAHW/6dxZLGsETCXwTlsiG5zFj7DlNbYIZ3K
 BtY+af0VA6cthLI5tq3tRxqqbAFKbAh+GGs14dnME7fAn6C0LTF0ARgrZsKalBytOr73Im97+zO
 9f7/ylrFD6kZQiIK31bvxBUvWz4hLOd6s6Izjsd6pPE+UEQQ+oOEOHEIS/o05MW5L3J9oIQ++C/
 EwBQWGhoXUJM5m/sfFh1oWNbppN9l4XNQ6HYnpm/xcdV1YbbGjVZuv1iJZhueyNY/kVSYgluIAk
 sSV/EwsnM30L4CeYz1A0neRQQli3qsnOjHJq2zQAAwL5ct8Yq/z2rdI5Cnq6cNKM5fI2x++GciC
 lhDOM1y8Akbwj5e4ICQ7PoXCByL3b6qYkQYZkgVC5XnYPCFB3bL60abFhQuQc0n8=
X-Received: by 2002:ac8:7e89:0:b0:50b:41b7:d6c2 with SMTP id
 d75a77b69052e-50d62ad8295mr291700921cf.47.1775604959221; 
 Tue, 07 Apr 2026 16:35:59 -0700 (PDT)
X-Received: by 2002:ac8:7e89:0:b0:50b:41b7:d6c2 with SMTP id
 d75a77b69052e-50d62ad8295mr291700461cf.47.1775604958598; 
 Tue, 07 Apr 2026 16:35:58 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net.
 [100.17.19.56]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d5ea136a1sm129517281cf.25.2026.04.07.16.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 16:35:56 -0700 (PDT)
Date: Tue, 7 Apr 2026 19:35:54 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
Message-ID: <adUVZ-i3Ot3R07Lq@x1nano>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
 <auzxmkl5jxlvlxpryibtz7srdnssguiaylb3uisheclrqelcgh@owm2nve7axb5>
MIME-Version: 1.0
In-Reply-To: <auzxmkl5jxlvlxpryibtz7srdnssguiaylb3uisheclrqelcgh@owm2nve7axb5>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HF3QLv2ZyoQSzq2nujKwMEtBn8_g7aJcIdNMTk9-hG4_1775604959
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

On Tue, Apr 07, 2026 at 02:48:05PM +0200, Michal Koutný wrote:
> Hi.
> 
> On Fri, Apr 03, 2026 at 10:08:36AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> > Introduce /cgroupfs/<>/dmem.memcg to make allocations in a dmem
> > controlled region also be charged in memcg.
> > 
> > This is disabled by default and requires the administrator to configure
> > it through the cgroupfs before the first charge occurs.
> 
> This somehow dropped the reason from [1] that this should be per-cgroup
> controllable. Is that still valid? (Otherwise, I'd ask why not make this
> a simple boot cmdline parameter like cgroup.memory=nokmem.)

[1] argued it should be controllable per dmem region more than per
cgroup. For example, a cgroup configured +memory and +dmem with one
region charging only dmem and the other double charging memcg and dmem.

cgroup.memory=nokmem karg would double charge all or none of the regions
for all cgroups iiuc. So maybe just make memcg CFTYPE_ONLY_ON_ROOT and
inherit that configuration in all children would do?

> > @@ -624,6 +656,13 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
> >  		return;
> >  
> >  	page_counter_uncharge(&pool->cnt, size);
> > +
> > +	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(pool->cs->css.cgroup);
> 
> This is not necessarily same memcg as when the dmem was charged via
> current (imagine dmem controller to depth N, but memcg only to N-1;
> charge, then memcg is enabled up to N so this would attempt uncharge
> from new memcg at level N, possibly going negative).
> 
> There is a question whether dmem should enforce same-depth hierarchies
> with `dmem_cgrp_subsys.depends_on = 1 << memory_cgrp_id` (see
> io_cgrp_subsys for comparison).

Thanks! I'll look into depends_on.

> And eventually, if per-cgroup attribute is desired, it would make
> greater sense to me if that attribute was on the parent level, so that
> siblings competing among each other are always of the same composition
> (i.e. all w/out dmem or all including dmem). This likely results in this
> extra-charging attribute to be properly hierarchical.
> 
> HTH,
> Michal
> 
> [1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.com/

Thank you for the feedback,

-- 
Eric Chanudet

