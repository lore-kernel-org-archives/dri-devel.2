Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B99E85385
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 17:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2FA10E0DB;
	Fri,  3 Apr 2026 17:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="WZMlB/l7";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C1110E0DB
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 17:15:07 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-506a747448dso16049161cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg.org; s=google; t=1775236506; x=1775841306; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NIb1V/U3iyEpQy5G2ZO1niSW/i2jfqib/HV9z8tr9R4=;
 b=WZMlB/l78kG0THUiTj5NZkSGQeCvyYLALugl30rqucRssHbH5TO16y487G6WkQhd+i
 0T8DsySijSMtfAexdsGZFc99Df3f+W2VHCiNTOF8zrZknR0ZVOYSpq17LhkAyHNpIVBa
 IzY+Yy9YlOx2EcNEkZlgrMYCzHHdjR/vDg9j7Qi+UA8JYWvLGawF4ljKI2QgP3UyAAuh
 QAK95SitePclE/2rKIKfpPncTfmOLYtyYGHpS7NyZyHimDpv/ohF4yvZrUZSALieIHOj
 RMkkJxHNGzLMiPQRb0DhZmVtNsWw7s7eU6kgrwX3OicE1uwK5/EdHjk5I9zSiy/DX/rR
 nL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775236506; x=1775841306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIb1V/U3iyEpQy5G2ZO1niSW/i2jfqib/HV9z8tr9R4=;
 b=L6VzN/d3GB1DZT9kndUWhvpIySOPuHXOm5ewKRRn6zmp7W2ySooLWaPTYWKS3A+em6
 f+D6gHshRGJ9OU3QKJzlRJA4sqsJX5ZgC3Hgr/Hw1mrJsjcTyqC93rTakHr4nVrH1rSh
 AVN8hzEZMcOVfdir6i1/CVp+6YB6YWXR6RvdP/y5vDrsEsAZG7+2BNhUPuetbjg+C/bK
 XxeoSp/a8Rg8AERLUWoTWdsZYtbO7X0t5e9jHaXDT/lNR82sqeSkcrHCAqxcqQ1BjQwI
 84179DIyhMO9Vrf8M89h5QxqMxmMKbcqvLcVxCMCwRGhzCY6vQDSqClPGsBRZ85egHJ5
 ehYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi6tFfAofVmqJ58aQcn2mQeXDHKP/+jW2a2cBEqmiFo+WrpBqvosg7J71Zwyk025T6bEA2LBwptdE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9+/yS/VA2oJghL4blvBEnpRu6M+rob3lZG19CnfExyOXUMYpx
 RHZ80T7jFK06ivELgOHKjkFqEGOXAwyxRfcgB6w8U/EL1FnvOP7DnP1pMgZlQ5kjbM0=
X-Gm-Gg: ATEYQzxbYkur5vaagHqt9ynY5yKZka8f17v00QDHsNn3Hm2fdJTMTb5reHdjHgv6JlN
 yuPz1vp2KXZRJSLSdx9HZkJE2+34+bupSppTlZPpfXR59gm5Ip/ccjywWsO86zK0OgAlIjhDQua
 dheggbZPFy7CGDrgcwy2Dqe0QiETnIsGdhcDaoPemMeKjJ95wAZOfcRYe5XuSkK8NmN794/FwhE
 J492zUUBjeyqrl+Tw4O5TmHENShZjAJHkWrzNsa2zuk1Td4V6zfzCaMDnINLwEqGDlD4R//nIQS
 UMjJ4YcskjKaEzheIRyTu0/1XgUwmMNAPhOXU5lX7pmGwbdMQO5cWBy/gDJ6eDmrczzxXKQm24z
 McudVc3uQTyyYnARtWcG3R9xEx9NKlANlc0rAynw9w089YIXMp+QPKVX7cOKdAayL/EvJ/4J7N9
 NUM71KqbQDfjor+6QDVy+sLw==
X-Received: by 2002:ac8:57d2:0:b0:50b:b32d:b55c with SMTP id
 d75a77b69052e-50d6209bd29mr57954271cf.0.1775236505840; 
 Fri, 03 Apr 2026 10:15:05 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b93dd10sm49032401cf.7.2026.04.03.10.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 10:15:04 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:15:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memcontrol: add page-level charge/uncharge
 functions
Message-ID: <ac_1l4Fyrq1AhY8D@cmpxchg.org>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
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

On Fri, Apr 03, 2026 at 10:08:35AM -0400, Eric Chanudet wrote:
> Expose functions to charge/uncharge memcg with a number of pages instead
> of a folio.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

No naked number accounting, please. The reason existing charge paths
require you to pass an object is because there are other memory
attributes we need to track (such as NUMA node location).
