Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914C606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ef/WcXmR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2BF10E6F8;
	Wed, 18 Nov 2026 02:29:38 +0000 (UTC)
Received: from mail-m16023653233.xmail.ntesmail.com
 (mail-m16023653233.xmail.ntesmail.com [160.236.53.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7511910E6F8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:29:32 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 551083689;
 Wed, 18 Nov 2026 10:29:28 +0800 (GMT+08:00)
Message-ID: <72957827-fde8-4f4b-80a9-050d2f112316@rock-chips.com>
Date: Wed, 18 Nov 2026 10:29:26 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] accel/rocket: Fix the extra iommu_group_get call in
 rocket_job_handle_irq
To: Daniel Drake <ddrake@baylibre.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-4-kernel@airkyi.com>
 <0e722f43-f08c-4636-bf3e-0dbe991bf6a0@baylibre.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <0e722f43-f08c-4636-bf3e-0dbe991bf6a0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1ec7cde4b03a7kunm8a7c13a3602732
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0lCVh4YGUseSkwZSEoeTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=ef/WcXmRp3/JbdOl57cgcDsCjcrruOWIRVodPFUgqkBMQqGs1kxCk0jmzFrzuctBz/6RlanWo3XJ1Cv0IwLohI21kkIj7ZIDhYhpR0KgqQxS4A6eoDGr/XCwY6y1812V19zHiluIVZLBRYmffrSRlcepE1R4QcMPncOQLR5Fd4o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=YqKHThxqhV+Nx5LE0AW1AJg3y+A6AtDJSvDAZKmD6X0=;
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

Hi Daniel,

On 11/18/2026 5:53 AM, Daniel Drake wrote:
> On 14/08/2026 03:24, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The rocket attaches the IOMMU group in rocket_job_run() and detaches it
>> in rocket_job_handle_irq(). Calling  iommu_group_get() in
>> rocket_job_handle_irq() causes the reference count to increase
>> unexpectedly. And this causes rocket_core_fini() to fail to release the
>> IOMMU group, leading to a resource leak.
> 
> 
> While there is a leak here, I think sashiko correct in saying this change would introduce a crash because core->iommu_group can be set to NULL before this codepath is reached.  That might be a simple fix.
> 
>> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> 
> 
> Wrong commit mentioned here.

Thanks for you review. This is indeed a problem.

And it has been a long time since I sent this series. :)

During this time, I have seen a lot of similar work. For example, work
similar to patch1 is here[0]. And some of the issues mentioned by 
Sashikoare also being fixed by in-flight patches like[1].

I'm not sure whether I should slow down the submission, since it seems
Tomeu is quite busy and hasn't gotten to some of the backlogged patches.

[0]: https://lore.kernel.org/all/20260915041152.1725014-1-vulab@iscas.ac.cn/
[1]: https://lore.kernel.org/all/18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com/

-- 
Best, 
Chaoyi
