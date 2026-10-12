Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2658CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037E910EF02;
	Mon, 12 Oct 2026 07:45:53 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E7F10EF02
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=TmnLgP+y1H71vWYuXUmZTmFTkqquXDqtP7vLnEohO00=; b=jTP7xg4xqLq4sdswNhW7Oa1tec
 D0MuJ17lq+LwL3+AGb36fmIauiQ45RoQXnQmP7ZHpgkBAhZYhxWvwRawJjQCxipEjEaAO+FE01wck
 WY8iKt8sqCYIgwaJxrIpKYSsoBGIGNptYb086FJ1kfDLqtvX8s9G9WwRQBPol/SubBH/BlfcMO+9a
 RmcIUB8AvVinjFn+4Iw0QO0hit9apMZepk0zslCFAOd/cV7xjztdueWwplnUtHP8BZ0KnO8MuNbV5
 oCV1izqNolV/COOPRhwhgBlod6YJIw7lfIFiF53LuZVPScxVdb8GwaPOVtHLoQjnkBBDvQzQQOiJy
 tu3pnIyg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xGAj9-00GE47-9r; Mon, 12 Oct 2026 09:45:43 +0200
Message-ID: <770ded5a-e406-43d4-9909-1531de89fce1@igalia.com>
Date: Mon, 12 Oct 2026 08:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: c
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
 <154fd1c6273812a804799cb82d11655c1726a83e.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <154fd1c6273812a804799cb82d11655c1726a83e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 08/10/2026 11:18, Philipp Stanner wrote:
> On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
>> When the out of range priority at entity init time is clamped to the
>> number of run queues in the supplied scheduler the internal run-queue
>> priority needs to be adjusted as well.
>>
>> There is no impact since none of the drivers hit the clamping path, but
>> we still need to address it by moving the entity->rq_priority assignment
>> to after the clamping is done.
>>
>> Note that a lot of this will hopefully get removed once again when the
>> single run-queue simplification lands.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> 
> Help me out here; we recently landed this fix [1] that Luke reported.
> Is there a relation? I guess not, since you say there is "no impact".
> 
> This did not exist before CFS in drm_sched, did it? Did you discover it
> by review?

Bug did not exist neither before CFS, nor with full CFS. It surfaced 
after the reverts of FIFO and RR removals and the single run-queue 
simplification. So the bug was in the middle of the original CFS series.

And there is indeed no impact, it's only theoretical. There would only 
be impact if any of the in-tree drivers would passing an entity to 
drm_sched_entity_init, with a scheduler which has fewer priority levels 
(run-queues) than the entity. And I am pretty sure no driver does that 
otherwise this would be firing:

   dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u 
num_user_rqs:%u\n",...)

Which was there for ages, added in
2bbe6ab2be53 ("drm/sched: Fix bounds limiting when given a malformed 
entity")
which says it should not happen. So it would have been noticed.

And yes, I spotted this while working on patches leading to the spsc 
removal.

Once we re-land the single run-queue simplification the check and error 
log get removed once again. But until then I think it makes sense to 
have the code fully theoretically correct.

Tvrtko

