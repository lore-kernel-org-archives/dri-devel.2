Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1A1FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9C410E9D2;
	Tue, 28 Apr 2026 13:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="dNuxLkdu";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CC510EB71
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1777382059;
 bh=nTVAk8FVU9/9Iqogqi1Nlg2TfMCF2sxeKJyQ/8j1X+A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dNuxLkduwB6bE+D5PePF93PM94aLLhS1Ywf7tnyWekON9xD2WQub3FOhLzs5iPwWo
 FSBWG0HYkaaK7+AiRd7RTCuQUgf4nQy7+GxTrsJXc/shlL4RcABxhbnBBLM3uyT/SE
 5Jifqsk6NODk5CJt6usjVA8KyL6w9t6MWF80wIMKTZWOqbQYwGZEkjYyJHSht1SE88
 M4ICL940urGpJ4dIpVE4N9/c0lIDuSu7SXLOSMlytVGLM0OZ8yXQsTCDFMAGdWKTgc
 M4l4Iy3TpDEsuY2XJ4O1VTGdyhgKbgswuscHCJ+XWKej5+2so1BfNNlmUP4VUoX1DT
 iGBJCKWphFCJg==
Message-ID: <e1b698c8-5b9f-4726-9f83-06ed62822bdf@lankhorst.se>
Date: Tue, 28 Apr 2026 15:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
To: Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
 <cykgy6mf4nu5kkwl3uc6modkj3ppela2xgjy2ijidpyzdsnyn4@cbwivcrqa5kh>
 <911b9bfb-c352-4f6d-93a1-540246ccd5b2@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <911b9bfb-c352-4f6d-93a1-540246ccd5b2@gmx.de>
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

Den 2026-03-16 kl. 09:46, skrev Natalie Vock:
> On 3/13/26 15:16, Michal Koutný wrote:
>> On Fri, Mar 13, 2026 at 12:40:01PM +0100, Natalie Vock <natalie.vock@gmx.de> wrote:
>>> This helps to find a common subtree of two resources, which is important
>>> when determining whether it's helpful to evict one resource in favor of
>>> another.
>>>
>>> To facilitate this, add a common helper to find the ancestor of two
>>> cgroups using each cgroup's ancestor array.
>>>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>>   include/linux/cgroup.h      | 21 +++++++++++++++++++++
>>>   include/linux/cgroup_dmem.h |  9 +++++++++
>>>   kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
>>>   3 files changed, 58 insertions(+)
>>
>> When the helper is added, the idiom in
>> kernel/cgroup/cgroup.c:cgroup_procs_write_permission() could perhaps be
>> switched to it too (structured in commits) to "optimize" migrations from
>> large depths.
> 
> Right. Perhaps better suited as follow-up work though, isn't it?
> 
> Thanks,
> Natalie

Does this patch need an ack to merge through the drm-misc tree?

Kind regards,
~Maarten Lankhorst
