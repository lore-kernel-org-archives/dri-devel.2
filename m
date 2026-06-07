Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4225BCD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 07:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C1C10E2D6;
	Sun,  7 Jun 2026 07:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z03Y2FEa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9984610E2D6
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 07:22:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 688A544277;
 Sun,  7 Jun 2026 07:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219DF1F00893;
 Sun,  7 Jun 2026 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780816932;
 bh=Nuzco7IGxuavqKddyKcXIMXeEDthh+2UWERv5CPzuzE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z03Y2FEaj1Mch29pSYOg5Li93jqLfUgDDV7tkuRMFPaasz+06uzr3fnLPsCvh4pW1
 HV4fV3GIn/yq3019PsgiB7ZYjdEWKi74fpxV6xor4I8PPGcEr3BVJFCGYcWDDus1WU
 r6b1UCk8DHolRXQNZ2tOKHDVVJ22Pv1TMmirnXvPQ4XFw0K6nz83xO0t7HmQBa1PDD
 L6/VejkjGoxldWsZtc6anVd4VZz70ujDPF/IlLNHk6j1Er9JiVZNN1OqAZvpSCvOkT
 gU29YJKxvgzNoLtX1YxHyy/eg/PuNH2Tk9MKjjcyr3CHEux2TvLDfdrntUGg+fPObe
 9HRz3t12jBu3g==
Date: Sat, 6 Jun 2026 21:22:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Natalie Vock <natalie.vock@gmx.de>, Eric Chanudet <echanude@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <aiUcI8Ecsc7I8N41@slm.duckdns.org>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
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

On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
> > As I see it, we could go down one of two paths:
> > 1. We go ahead with the patch as proposed, and I make sure that the users I know of adapt. Could be a bit icky wrt. "do not break userspace" rules, but since the already use non-merged UAPIs in one place, you can argue that these users kind of have to expect breakage.
> > 2. We use the old handling allowing multiple lines for dmem.min and dmem.low only. This preserves compatibility but uglifies the code by quite a bit.
> > 
> > All things considered, I think I personally would prefer going with 1. and taking the patch as proposed and just having one codepath handling every limit file. Just highlighting this so we don't do it on accident.
> > 
> > [1] https://patchwork.freedesktop.org/series/163183/
> > 
> 
> I prefer option 1 as well, but would like an ack from one of the core cgroup maintainers too,
> and what Maxime's opinion on this as well.

Yeah, if at all possible, please drop the multi region write support if at
all possible. This shouldn't have gotten in and yeah it's on the boundary
but the fact that users need external patches works in our favor - both
qualitatively and quantatively (the usage is likely tiny).

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
