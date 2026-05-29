Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2C4CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E8810FA18;
	Fri, 29 May 2026 07:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="njLFIoh5";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8F210FA18
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1780040071;
 bh=jQMKoFxjhXOg58Gu2goSrIvcgitzJfXOyS065eiSQOQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=njLFIoh5+QF8qO2yk3lhUuM/T3YGzqoJcLI545XszXAraCyn/vqzqXbQpztEhe2qp
 TvvjZJh8sITmgxaNvTUvCrCWKTxfWZ5H1t6ucIVSwHpWHzYJrJ8zxulTWmtYdQuf1D
 S1iDf5BZX/zV0p/epJhWh88rH8FjbA70aH6aSBWLtYah/vlXYhULlnKNsLubUkU37E
 7eC5Et/rBQnmvo5b5xtczea6RnEY437dQfirB8BhtMrcEPhpaL015Dxlh69eFMoueV
 Uz25Xm/jB+pKTjyCi8f7ocYa5b9mJEfuoTwizogiCCJAbev4ZmKHjn5+RxJNWFSD8p
 6wFW6wpwDZIiQ==
Message-ID: <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
Date: Fri, 29 May 2026 09:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
 <ahCISfTlN10gD8e6@localhost.localdomain>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <ahCISfTlN10gD8e6@localhost.localdomain>
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



Den 2026-05-22 kl. 18:48, skrev Michal Koutný:
> On Thu, May 14, 2026 at 02:36:08PM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
>> Just like we have memory.peak, introduce a dmem.peak, which uses the
>> page_counter support for that.
>>
>> For now, make it read-only.
>>
>> This allows for memory usage monitoring without polling dmem.current when
>> the information needed is the maximum device memory used. That can be used
>> for capacity planning, such that dmem.max can be properly setup for a given
>> workload. It can also be used for debugging to determine whether a given
>> workload would have caused eviction or system memory use.
>>
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> ---
>> Changes in v3:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
>> - Link to v2: https://patch.msgid.link/20260513-dmem_peak-v2-1-dac06999db9e@igalia.com
>>
>> Changes in v2:
>> - Make it read-only for now and adjust documentation accordingly.
>> - Link to v1: https://patch.msgid.link/20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>>  kernel/cgroup/dmem.c                    | 15 +++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 6efd0095ed99..d103623b2be4 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2808,6 +2808,12 @@ DMEM Interface Files
>>  	The semantics are the same as for the memory cgroup controller, and are
>>  	calculated in the same way.
>>  
>> +  dmem.peak
>> +	A read-only nested-keyed file that exists on non-root cgroups.
> 
> s/nested-keyed/flat-keyed/
> 
> 
> With that
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>

With your r-b it's ok to push it to the dmemcg tree?

Kind regards,
~Maarten Lankhorst
