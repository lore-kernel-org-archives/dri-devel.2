Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FF5CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF7310E439;
	Fri,  5 Jun 2026 11:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="N74i+GGN";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CF810E439
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1780658828;
 bh=grJWHPyWHk8AoQrPfPCjbyowZDDAMw3aAx81Y2+OkBE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N74i+GGNoRR0g17Ffnu3NiFljaOwuwpxqDTJa+TTkHeJKzoXGffMgGBLgkNZy6V9P
 FW0Imepg0M0DhWM8mTNCenAbBV4/lME5xB9WI8+e/iouz18LG0s9xNjLqerAsABoEW
 LlEeOcceVMFODm5FuCtxrHcqbrh/PRJCZ8cEZVOpemUnWLXhoas7Bkfmkvai0zSHKV
 0xCxUlhn1ewaBnBdUNOe1z1vXFWJaJyL1CE5/0svZmq4cTKPhwiTaqDiUfkrw6AuPA
 Mqs2bk0KvRWGChOHirz1VP6jjLrxCeFCQ834fPxVyLumz1+ltC+Ptp+UXJh3KShG5r
 8gU5ZyT/srkBg==
Message-ID: <158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se>
Date: Fri, 5 Jun 2026 13:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
To: Eric Chanudet <echanude@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain> <ahXKFYBdCMDBvc_N@x1nano>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <ahXKFYBdCMDBvc_N@x1nano>
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

Hey,

On 5/26/26 18:59, Eric Chanudet wrote:
> On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
>> Hello Eric.
>>
>> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
>>> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
>>> configure whether allocations in a dmem region should also be charged to
>>> the memory controller.
>>
>> This kinda makes sense as it is not unlike io.cost.* device
>> configurators.
>>
>> Just for my better understanding -- will there be a space for userspace
>> to switch this? (No charged dmem allocations happen before responsible
>> userspace runs, so that the attribute remains unlocked.)
>>
>> (I'm rather indifferent about the actual double charging/non-charging
>> matter.)
> 
> Yes, this is intended to be configured before the user space stack that
> would start allocating things is started. Once it has started (and tried
> to charge something), the configuration is locked
> 
>>
>>>
>>> To handle inheritance, dmem adds a depends_on the memory controller,
>>> unless MEMCG isn't configured in.
>>>
>>> Double-charging is disabled by default. Once a charge is attempted, the
>>> setting is locked to prevent inconsistent accounting by a small 4-state
>>> machine (off, on, locked off, locked on).
>>>
>>> The memcg to charge is derived from the pool's cgroup, since the pool
>>> holds a reference to the dmem cgroup state that keeps the cgroup alive
>>> until it gets uncharged.
>>>
>>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>>> ---
>>>  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
>>>  kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
>>>  2 files changed, 178 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>> index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>> @@ -2828,6 +2828,29 @@ DMEM Interface Files
>>>  	  drm/0000:03:00.0/vram0 12550144
>>>  	  drm/0000:03:00.0/stolen 8650752
>>>  
>>> +  dmem.memcg
>>> +	A readwrite nested-keyed file that exists only on the root
>>> +	cgroup.
>>
>> Strictly speaking this is not nested-keyed but flat keyed [1],
> 
> Indeed,
> 
>> which leads me to realization that this is the first instance of a boolean.
>> All in call, such a composition comes to my mind (latter is RO):
>>
>> 	drm/0000:03:00.0/vram0 enable=0|1 locked=0|1
>>
> 
> So per[1] 1 key, 2 sub-keys (enable RW, locked RO), that looks better
> and match the documentation, thanks!
> 
>>
>>
>>> +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
>>> +				       size_t nbytes, loff_t off)
>>> +{
>>> +	while (buf) {
>>> +		struct dmem_cgroup_region *region;
>>> +		char *options, *name;
>>> +		bool flag;
>>> +
>>> +		options = buf;
>>> +		buf = strchr(buf, '\n');
>>> +		if (buf)
>>> +			*buf++ = '\0';
>>
>> I recall there was a discussion about accepting only a single device per
>> write(2) (at the same time I see this idiom is still present in other
>> dmem.* files, so this is nothing to change in _this_ patch).
> 
> I would second that. When setting say dmem.max for 2 regions, with a
> typo on the second, the first one is set, but write still get EINVAL.
> 
> Also, I just notice dmemcg_limit_write() returns EINVAL if the region is
> not found (this patch returns ENODEV).
> 
>>
>> Thanks,
>> Michal
>>
>> [1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format
> 
> 
> 

Perhaps a bit late, but before we start adding this UAPI we should enforce a
single region per write?

Kind regards,
~Maarten Lankhorst
