Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEAC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C304710E06D;
	Mon, 21 Sep 2026 18:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O3r8zX3r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D683A10E06D
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:16:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90A0F43F8B;
 Mon, 21 Sep 2026 18:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5761F000FF;
 Mon, 21 Sep 2026 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014588;
 bh=l4EJvxSj/BJsRSgpyFNvCVzIpp4EruN23HflkMWdmXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O3r8zX3rRAdTh0tZ7rs6DQexuLgO9QK0vtOA6kKeN8MadLlRZl/xbGDhgQW1w9lLr
 RIMwyajFNVsPe+RnDMMptexa7Z+k3f+aK8i6Wlj37NMZ8VtcfTGeDp8IJNnoMqI8nf
 23lATnS4SrmJdOkZpjKxmuDOeI3HwfpP3FYOgOLS4l1JlEoQ74ksPe2EPombWAmaub
 i0BPGA2SU2TmTWn+l8hwAesNTCiAzu0AJTgWPzfgXmjRD4GY6zCyoW8sQAgFR2JOfZ
 cSYaC5nq11ykUAUAqGSBD9FbdPahivlPZaQYvxyGMz4EVzYyXb85FpKYMU9aRTh/h8
 ObdTOs2AVvpyA==
Message-ID: <7e555045eff532576b56daa4e023be1b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 natalie.vock@gmx.de, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
Date: Mon, 21 Sep 2026 08:13:47 -1000
In-Reply-To: <20260921-feature-dmem-high-v8-1-6371fa83d6c3@gmail.com>
References: <20260921-feature-dmem-high-v8-1-6371fa83d6c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Hello,

On Mon, Sep 21, 2026 at 03:02:48PM +0800, Qiliang Yuan wrote:
> The dmem cgroup v2 controller only provides a hard "max" limit, which
> fails allocations outright once a cgroup's device memory usage hits
> its quota.  GPU-bound AI workloads need smoother over-subscription: a
> soft limit that applies backpressure through reclaim before the hard
> limit is hit.

That's not how max behaves. A max hit makes TTM evict and retry before the
allocation fails, and since 747c4bb450ad ("cgroup/dmem: Add reclaim
callback for lowering max below current usage") lowering max reclaims as
well. So the premise doesn't hold, and the patch doesn't show a concrete
case where max reclaim falls short and high would help. Without that,
there isn't enough justification for adding a new interface file.

Thanks.

--
tejun
