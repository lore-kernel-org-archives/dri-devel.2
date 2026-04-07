Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB4FEEF50
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C4210E424;
	Tue,  7 Apr 2026 14:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hPIsFLyr";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9622210E428
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775572318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UDiNGg7oHctRKWHlUV1gXCd4Od4na5ntrKyJgT/gtE=;
 b=hPIsFLyr3W4VA+ne/yME1BuVFdvRCHH7xsvKEddcnwI9bJXKoKw+eGKfBwgxCP9P5RHUqm
 yuPicpsJNRdCJPgwhh/JZUa8WXmVa6nyw+AwIk59Ms4zby3KfYPFMVj+eVKrMeLyffs0aF
 fD9Mu+9jIyG34A1VxBl3pZeAN1Vtv4M=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-aZ94FgccN4yRKgranQWHTQ-1; Tue, 07 Apr 2026 10:31:57 -0400
X-MC-Unique: aZ94FgccN4yRKgranQWHTQ-1
X-Mimecast-MFC-AGG-ID: aZ94FgccN4yRKgranQWHTQ_1775572316
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-953d479ea6eso9230452241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 07:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775572316; x=1776177116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UDiNGg7oHctRKWHlUV1gXCd4Od4na5ntrKyJgT/gtE=;
 b=bFE0ptn6kgzYPHb6pLdODDYm+qsbx6j2WxA+eNNex5y9XhkAtrN416PtBYeHIoT3+5
 BR34Z8LK7rOTbJGEpDKZKLgjwbVYpXtPxT4zBQxvDkqg3DCg58AxydxaGVavq4SNR264
 SIz43GQT4jqIYupSEBr3iKhUct9heaO3JH/jfLfM8oZwyDp64VUDO6TslY8xftzKwguE
 9T7D5/4XTrrd3MMHIeIfpiwTm3k2QfRiH13zASjGixHIRUJ4UdargixaBuuL71rhrvVr
 CZKdR02S88W2uVoQ7YCdXAxmddoaqQ8u+bIHAjDn+66n4Gwue3s6MYyABSJ5Z1qIGoO0
 /hwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZUI43kBmyqAzNmHtP7r8FxnWkxJBtarswXUCkX4s9FhQXSlqowfc2H6yHrDG6B58wCmf78Fg9I+s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQyX9I+zbv2dP3ozw+k5aYOhGldZe/CpAol54HMxysLM+w+pxe
 +ZHd/KLziS9i7DsnVscX1hfxne8ijQFeXK0hTV97gbm9VFXSz04EXo/0XrD2y9zelm7gi/8RkJd
 C+m/F8angpZpCj322IiXRj4lQXNMAipMq0tHAI4cKa0jLtJCtYNi8465IU7bW+/hGDejFPg==
X-Gm-Gg: AeBDievaEHMEGIbkVb9A/hdDvtNowpN4eNdDTUmwbGhhq1BfZHh5P8KRKar5/KT376B
 CpKcHaNEdRDM03KG4yTShRYEd0of96JxWs8k1H5XOg6LGMKhFPrXgznHrep+O3/y3wo6lRW1B57
 hNPo/B1GRBEOMtHDSJQe1jZ7VvtPFe+yPOQu3Ae63fM5N5OBzWgWKMByCPdxiJI8mqyRVhHSYXj
 6fIL/Iz34z3pZyh8ZLjU3Cb59ZafmHi1s/em86SzyFnsIpFOpuImM5yoClHCUg4UJqcs0mX26JJ
 +5jd6IdfATvLkX/xCxeeC6xFfxFFQDdH8jKfidGMv0XhKbhi2Uhqr5lHd9BpSis2hXxkhMxz5lb
 JC9FULZE5R/706BTSF/vM/LmVfPDkClM0rSzwQZpZatAJqEYgvCRznNPj959YWU4=
X-Received: by 2002:a05:6102:1487:b0:602:b037:4de8 with SMTP id
 ada2fe7eead31-605a4cc6f09mr6384683137.4.1775572315639; 
 Tue, 07 Apr 2026 07:31:55 -0700 (PDT)
X-Received: by 2002:a05:6102:1487:b0:602:b037:4de8 with SMTP id
 ada2fe7eead31-605a4cc6f09mr6384602137.4.1775572314700; 
 Tue, 07 Apr 2026 07:31:54 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net.
 [100.17.19.56]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d3edb58da6sm1104864185a.8.2026.04.07.07.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:31:53 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:31:52 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memcontrol: add page-level charge/uncharge
 functions
Message-ID: <adPzsvwzkTCOh5RJ@x1nano>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
 <ac_1l4Fyrq1AhY8D@cmpxchg.org>
MIME-Version: 1.0
In-Reply-To: <ac_1l4Fyrq1AhY8D@cmpxchg.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3yB-wsAN4u-7RKjzV4xwXUxgRKh4_mkF_t5tuviYMOs_1775572316
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Fri, Apr 03, 2026 at 01:15:03PM -0400, Johannes Weiner wrote:
> On Fri, Apr 03, 2026 at 10:08:35AM -0400, Eric Chanudet wrote:
> > Expose functions to charge/uncharge memcg with a number of pages instead
> > of a folio.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> 
> No naked number accounting, please. The reason existing charge paths
> require you to pass an object is because there are other memory
> attributes we need to track (such as NUMA node location).
> 

Understood, thank you.

I'll change to using a mem_cgroup_dmem_{,un}charge functions and a
memory.stat entry as well, similar to what is done for
mem_cgroup_sk_{,un}charge.

-- 
Eric Chanudet

