Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E8FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7F810E8F4;
	Thu, 30 Apr 2026 17:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E/aLqins";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFCE10E8F2;
 Thu, 30 Apr 2026 17:06:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1828441579;
 Thu, 30 Apr 2026 17:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8DAC2BCB3;
 Thu, 30 Apr 2026 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777568813;
 bh=dPdHfPCW7ng2kSeVyDlMheharmDFRf8Ia5tgN1rIr7g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=E/aLqinsRaz6E+em9mmxb/ZmPZKQBFN0qzUWyMQ1WmwBpvNArlPyD2O/izyCgrhZt
 eIXJpUB4ekDjPDZGqtXXWplC89vsNKrkO432KF7hiOdDOWgT0wQBFrIjP5dx7wxAhL
 q+74f9XyxQvN8KdY0JZ3Fac04I5MqQ/RxFaIL/wPBDm8G/Ge3ilJTrCeacwiyGTX0t
 KTrSXj2Mjq/KHwqqNkcbGDJTcEPN5qX1tqx64v2waZGOELXhsWRVRRMg0luurIZx/L
 4CbIQD8kOgp35xgTgEmFcZyE5Bn2vIr6wPy+iQuaoCrMpta0JHLuKgmLuFkaOPOoYQ
 dGcLQS5WymL1w==
Message-ID: <59b3dab5-3341-46dc-851a-419790eaf403@kernel.org>
Date: Thu, 30 Apr 2026 19:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <76191a17-18bf-4e9b-9ab5-dc9a48abfabb@kernel.org>
 <be42059924cde9bb16a087ee2a5abb0b9d850d68.camel@linux.intel.com>
 <aepuNL2fwp47P1Wi@gsse-cloud1.jf.intel.com>
 <aeqbe/9YRKNyYuWY@gsse-cloud1.jf.intel.com>
 <291406b26b8badf2e565996515931d9ebe50208f.camel@linux.intel.com>
 <a1252167-63a1-481b-9f1d-2a7bae7a3b6c@kernel.org>
 <afLCwHaPZMu/dxqY@gsse-cloud1.jf.intel.com>
 <f4324084f3808b9a42b87ec27bef7fe920dde9ea.camel@linux.intel.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <f4324084f3808b9a42b87ec27bef7fe920dde9ea.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/30/26 09:47, Thomas Hellström wrote:
> On Wed, 2026-04-29 at 19:47 -0700, Matthew Brost wrote:
>> 
>> So again, I think starting with wiring order into shrink_control and
>> this helper is a good place to start, as it fixes an immediate issue.
>> 
>> Let me know if that seems like a reasonable direction.
> 
> +1 for wiring order into shrink_control, and possibly also the priority
> as mentioned in an earlier email.
> 
> However for cgroups-aware shrinkers, The number of free memory in a
> zone might not be an indication of fragmentation-triggered reclaim at
> all, it could be the result of the cgroup hitting its memory limits.

I'm not sure I understand your concern wrt cgroups, but some hopefully
relevant (and hopefully not wrong) points:

- fragmentation is a zone-related property, not cgroup
- hitting a cgroup limit doesn't wake up kswapd nor go through the usual
reclaim/compaction paths, it's a form of direct-reclaim-only

So I believe it should be easy to recognize when your shrinker is called for
memcg shrinking and not kswapd and thus it can't be happening due to zone
fragmentation but must be due to memcg limits, and then you probably don't
need to check zone_appears_fragmented() at all.

> So I think if we can solve this with a combination of GFP flags,
> plumbed-through order and plumbed-through priority, that would be
> ideal.
> 
> Thanks,
> Thomas
> 
>> 
>> Matt
>> 
>> > 
>> > 
>> > -- 
>> > Cheers,
>> > 
>> > David

