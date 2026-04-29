Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A237FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8B810F264;
	Thu, 30 Apr 2026 07:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dancol.org header.i=@dancol.org header.b="iJ9b9ndC";
	dkim-atps=neutral
Received: from dancol.org (dancol.org [96.126.100.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24CF10E129;
 Wed, 29 Apr 2026 22:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org; 
 s=x;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; 
 bh=uVZSEQP5zYzPKq/kXJFdSX20dlInqIpzN3iJojggZaU=; b=iJ9b9ndCysglOphySl2DVS8JO4
 w3OcJSDc7xhmQT5veiqetcttu9ThOkdqc8YNLLo0pJN6lTV4j9PEWhBysgAhHmv9vUGOV7u6n16Kb
 wuK/tpbveDTo+QgA8/CoapE5MsDsLXc0kISJ05RLes27rjbuZS70+OPHtyco1MU+wa4/WGw1Ms6oM
 wtohJY08BWEkB6cNATqquh+IPtzCfsoLX/eulDz7gn6r0KJsMLku2VYpLK1U8EYICu9nAo0krypg2
 uW+oNYNXh4o/CtnpXmmuBp4uzWTEbaJllEXYqyuxu5mD9p1q+oZFoVkXQGCyykrlvb3xHtewI3ebf
 4F5fuArw==;
Received: from 2603-900b-c400-2854-5e6b-eefe-e3ac-fcb7.inf6.spectrum.com
 ([2603:900b:c400:2854:5e6b:eefe:e3ac:fcb7]:58720 helo=localhost)
 by dancol.org with utf8esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <dancol@dancol.org>) id 1wIDm0-00000001oB3-2JdO;
 Wed, 29 Apr 2026 18:52:52 -0400
From: Daniel Colascione <dancol@dancol.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthew Brost <matthew.brost@intel.com>,  Christian =?utf-8?Q?K=C3=B6n?=
 =?utf-8?Q?ig?= <christian.koenig@amd.com>,  intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  Carlos Santa
 <carlos.santa@intel.com>,  Huang Rui <ray.huang@amd.com>,  Matthew Auld
 <matthew.auld@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
In-Reply-To: <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
 <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
User-Agent: mu4e 1.14.0-pre1; emacs 31.0.50
Date: Wed, 29 Apr 2026 18:52:50 -0400
Message-ID: <87se8didkt.fsf@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:37:56 +0000
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

Tvrtko Ursulin <tursulin@ursulin.net> writes:

> On 22/04/2026 21:41, Matthew Brost wrote:
>> On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian K=C3=B6nig wrote:
>>> On 4/22/26 09:32, Tvrtko Ursulin wrote:
>>>>
>>>> On 21/04/2026 02:26, Matthew Brost wrote:
>>>>> Triggering kswap at an order higher than beneficial_order makes little
>>>>> sense, as the driver has already indicated the optimal order at which
>>>>> reclaim is effective. Similarly, issuing direct reclaim or triggering
>>>>> kswap at a lower order than beneficial_order is ineffective, since the
>>>>> driver does not benefit from reclaiming lower-order pages.
>>>>>
>>>>> As a result, direct reclaim should only be issued with __GFP_NORETRY =
at
>>>>> exactly beneficial_order, or as a fallback, direct reclaim without
>>>>> __GFP_NORETRY at order 0 when failure is not an option.
>>>>>
>>>>> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>>>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>>> Cc: Maxime Ripard <mripard@kernel.org>
>>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>> CC: dri-devel@lists.freedesktop.org
>>>>> Cc: Daniel Colascione <dancol@dancol.org>
>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>> ---
>>>>>  =C2=A0 drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>>>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm=
_pool.c
>>>>> index 26a3689e5fd9..8425dbcc6c68 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>>>> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct tt=
m_pool *pool, gfp_t gfp_flags,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Do not add latency to the all=
ocation path for allocations orders
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device tolds us do not bring =
them additional performance gains.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0 if (beneficial_order && order > beneficial_order)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_flags &=3D ~__GFP_DIR=
ECT_RECLAIM;
>>>>> +=C2=A0=C2=A0=C2=A0 if (order && beneficial_order && order !=3D benef=
icial_order)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_flags &=3D ~__GFP_REC=
LAIM;
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ttm_pool_uses_dma_alloc(p=
ool)) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D alloc_p=
ages_node(pool->nid, gfp_flags, order);
>>>>
>>>> I missed this conversation so don't know if this was discussed -
>> I meant to CC you here, but missed including you.
>>=20
>>>> having less of 64k pages is not a concern? I mean slightly higher
>>>> TLB pressure etc on hardware which supports this PTE size.
>>>
>>> At least for AMD GPUs 64k doesn't matter at all.
>>>
>> Same on Intel GPUs for system memory mappings - it is either 4k or
>> 2M
>> GPU pages. VRAM can we 64k pages but that isn't involved here.
>>=20
>>> There was a large push from the Windows side to use that size, but
>>> we have more than enough evidence to prove that this size is
>>> actually completely nonsense for almost all use cases.
>>>
>>> I have no idea how we ended up with that in the first place.
>>>
>>> It could be that there is still HW out there which can only handle
>>> that size, but in that case such HW should just set
>>> beneficial_order to 64k.
>>>
>> Or we move to a table config if we find drivers have multiple
>> beneficial_orders.
>
> Or a bitmask of direct reclaim orders?
>
> I am not saying it is required to be "smarter" than this patch does
> it, for AMD and Intel apparently isn't, but for other drivers I don't
> know so it does need looking into.
>
> Regards,
>
> Tvrtko

Probably stupid question: for systems like my Lunar Lake Xe2, which has
unified memory and (IIUC) no special cache-type or write-mode
constraints for GPU mappings, would it be possible to use regular
system-provided pages (e.g. from shmem) instead of going through the TTM
pool and allow mTHP to provide the aligned and contiguous backing
storage that the GPU wants? Something like GEM has, but maybe inside the
TTM API?
