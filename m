Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EC606A338
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=TGHllOXg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8474510E0C3;
	Wed, 18 Nov 2026 09:17:04 +0000 (UTC)
Received: from mail-m128130.netease.com (mail-m128130.netease.com
 [103.209.128.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837E710E0C3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:16:58 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 551f9ad52;
 Wed, 18 Nov 2026 17:16:55 +0800 (GMT+08:00)
Message-ID: <daea6316-bf37-4b9d-92a7-945f34cd719d@rock-chips.com>
Date: Wed, 18 Nov 2026 17:16:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] accel/rocket: Fix the extra iommu_group_get call in
 rocket_job_handle_irq
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Daniel Drake <ddrake@baylibre.com>, Chaoyi Chen <kernel@airkyi.com>,
 Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 LAKML <linux-arm-kernel@lists.infradead.org>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-4-kernel@airkyi.com>
 <0e722f43-f08c-4636-bf3e-0dbe991bf6a0@baylibre.com>
 <72957827-fde8-4f4b-80a9-050d2f112316@rock-chips.com>
 <CAPsqS2QhAortoDOt9MBizTr4RCDhChr1xLF13NNTUYjyFMakhg@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CAPsqS2QhAortoDOt9MBizTr4RCDhChr1xLF13NNTUYjyFMakhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1edf1e46a03a7kunm2355c227669381
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0pOVkIaSUwaHU9IGB8eQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=TGHllOXgyJL+s/aCvjVJ5CotwyJ8QVPI/4twhwqsW0yPCG59Dyci1TvNZNY8uF8lkHn6iTHPcu3BYeeZYEJT9vDcaSjDLjsPIqJAta/qrMpcE3P2omQfiW8faKgRjBQWz6EtL+tRQMpKvJkTaMMD1RO2aMNdNB/oU9TNuILOP3c=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=I3smdXzbgBpgrivukeP0fqIaIFjz2n/NTWdA0NUSV/Y=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tomeu,

On 11/18/2026 4:58 PM, Tomeu Vizoso wrote:
> Hi Chaoyi and Daniel,
> 
> On Wed, Nov 18, 2026 at 3:29 AM Chaoyi Chen <chaoyi.chen@rock-chips.com> wrote:
>>
>> Hi Daniel,
>>
>> On 11/18/2026 5:53 AM, Daniel Drake wrote:
>>> On 14/08/2026 03:24, Chaoyi Chen wrote:
>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> The rocket attaches the IOMMU group in rocket_job_run() and detaches it
>>>> in rocket_job_handle_irq(). Calling  iommu_group_get() in
>>>> rocket_job_handle_irq() causes the reference count to increase
>>>> unexpectedly. And this causes rocket_core_fini() to fail to release the
>>>> IOMMU group, leading to a resource leak.
>>>
>>>
>>> While there is a leak here, I think sashiko correct in saying this change would introduce a crash because core->iommu_group can be set to NULL before this codepath is reached.  That might be a simple fix.
>>>
>>>> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
>>>
>>>
>>> Wrong commit mentioned here.
> 
> I fixed this one when applying.
> 
>> Thanks for you review. This is indeed a problem.
> 
> I'm sorry but I had already applied this patch to drm-misc-fixes and
> pushed when I read this. I have looked at fixing just this crash, but
> have decided against it because we anyway crash in drm_sched on core
> unbind whenever a client is active (no need to have a job in flight),
> due to the sched entities keeping a reference to the stale scheduler.
>

Oh, that's true, but it seems no merge notification email was sent out? 

https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/5c4aeafcac8c46be7b08b86795baa64453eb68aa
 
>> And it has been a long time since I sent this series. :)
>>
>> During this time, I have seen a lot of similar work. For example, work
>> similar to patch1 is here[0]. And some of the issues mentioned by
>> Sashikoare also being fixed by in-flight patches like[1].
> 
> Core removal needs to be fixed as a whole: detach the open files'
> entities from the scheduler that goes away, complete or cancel the job
> in flight, and quiesce the job interrupt before the resources it uses
> are released.
> 
>> I'm not sure whether I should slow down the submission, since it seems
>> Tomeu is quite busy and hasn't gotten to some of the backlogged patches.
> 
> I'm sorry about the big backlog of patches. With Heiko and Daniel's
> help I expect to get it cleared soon and be more responsive.
> 

Thanks for your excellent work! I think patch4 could also be merged? 
That way, people on the rockchip mailing list can also conveniently help
us review these patches. :-)

-- 
Best, 
Chaoyi
