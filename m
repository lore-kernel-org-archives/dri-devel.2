Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8801C79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 23:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1F210E1A7;
	Fri,  4 Sep 2026 23:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="aQtFCJWv";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6202910E1A7
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 23:06:55 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=ZUM2AKTRyDOrNDBMw/PpojLw84g0UsyJaEenIna+gsA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788563213; v=1; x=1789168013;
 b=aQtFCJWvXr+WjgsZqHRE9+lFClfwQDNjBmh8txhqKugdL7x3P7/+DWpnER31CD5nmGIps5aA
 9CYS1sicQQoX4XxMSAQMSw81lmfkfjwcplJYh8qgt8FSTeuh8YnXK24aQ0EkGLofCD6ndVeqIaH
 yHIpsggT7GJVHFG4DGEBun5s=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 553d8ee376d76e0c;
 Fri, 04 Sep 2026 23:06:53 +0000
X-Mizu-Trace-ID: 553d8ee376d76e0c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 16:06:47 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
 muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 dev@lankhorst.se, mripard@kernel.org, nat@pixelcluster.dev, tj@kernel.org, 
 mkoutny@suse.com, osalvador@suse.de, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-team@meta.com
Subject: Re: [PATCH v5 1/7] mm/memcontrol: flatten try_charge_memcg control
 flow
Message-ID: <aptO87TL7KDvcX3D@linux.dev>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
 <20260831163752.2193337-2-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163752.2193337-2-joshua.hahnjy@gmail.com>
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

On Mon, Aug 31, 2026 at 09:37:45AM -0700, Joshua Hahn wrote:
> Refactor try_charge_memcg by flattening the nested memsw/memory
> page_counter operations to separate the logic between the two.
> 
> When page_counter_try_charge is made stock-aware, this flattening makes
> the control flow easier to follow since each page counter now has its
> own success/failure paths.
> 
> No functional changes intended.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
