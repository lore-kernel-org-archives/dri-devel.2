Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF25C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBFA10E30A;
	Thu, 16 Jul 2026 09:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="UcrWEp+b";
	dkim-atps=neutral
Received: from smtpout3.mo534.mail-out.ovh.net
 (smtpout3.mo534.mail-out.ovh.net [51.210.94.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517AA10E30A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:20:45 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4h16k24ld5z6MQd;
 Thu, 16 Jul 2026 09:11:54 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <mripard@kernel.org>; Thu, 16 Jul 2026 09:11:54 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.223])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h16k2256Xz60Mk;
 Thu, 16 Jul 2026 09:11:54 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.10])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id AC6E99A1971;
 Thu, 16 Jul 2026 09:11:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S00613639789-d330-4999-8471-5f091945c17d,
 FC3020C1E9D06427965D18C7378DB59FA321AF64) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <12fc7d69-f415-4988-9ae8-2764e83e0125@pixelcluster.dev>
Date: Thu, 16 Jul 2026 11:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Natalie Vock's email
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
References: <20260705175305.5589-1-nat@pixelcluster.dev>
 <de118156-3125-404e-8ddf-2326747df303@linux.intel.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <de118156-3125-404e-8ddf-2326747df303@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11554547797630083336
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTESDCHV13IZsUhXxpFn0Qi15koqHPEs5CALjFS6wz1hg6L4iBAPCtxEYD3Oe7a+lnbG9d+hPrVImm2a8hJGrHWT66xEh+mDfNc4nOwDVzmoTrfVy9fCzPP/EIJzClp/c7e1pM8W18qd3EbLCyH37LhHZZKqTtYZQKgLTO99HCvc+2lqkGkT6SKv46IDsqp0KDKQljY3kkbiri7ACVCXVPaNNT1YGY09JWVbvOVXcfDhKJeg03nwZse7EcVo9qupmcqcSFhfvxJL+k32r/Kvjc+hgiNlJR1c/c6yRWzGhxrlextGvzzmq+RzsV0ewgEKyQ16nsUKuZudBscq+mc8rPbNohrj/PlFrVViRUm855BiODYHrdR8nXL3bvnzdIUMnHhHJysu5b86cOYqfltuSTtkAXgXitSNbn44VypDgChjVOQt0m2ChyUAFE1i391HiRHxP5e0KiVOj4aY56JmMNyjLUsZ9EXie3NwOf4PjODig8Y6YmFAzZ7MYdWWuVqyt2mvjW/vm4HoiLJmMwKfkRAVffM+qz+bY8STW91WiT76UTj0VbpAFZ7rdZfVi38CyMSa6ROmcAuSxrGfcawFJVC+jWvLXsyTsFw63k1JJu1XBS7jwr32ix57WAp8gmm6ZIiM8zzY1+HtSjP52MRm3h+IucArHiAJ/8OiuFQHDWGMOQ
DKIM-Signature: a=rsa-sha256; bh=YEDCo224DpxEsSjCe2n500S4K5UGTcUVeBpLqihXGxQ=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1784193115; v=1;
 b=UcrWEp+bH0QC7cBN/bVYpeSm/zrdP2F4kbKkDUQqw4rHWBdPUjBaHDw8EJTE3f2u66/jPxt1
 TP7gI93E3zdTvbN0Wotnh6WybCBWXZrG4wI/Qk3R6bF2FHCUsP8HIedAScgG2B/D0yX4RlPK6WE
 5jcLJ/EZQ9M93xP6TyxNoMSBsDc5eLvae4u8rXwj2KU40s6bJLhxAVgXUypKL7iE7MvXpraZcxR
 Y880zKh040bRb/O3hfIQ/Y7hpvwAAwdKrPN2w6IUy+JviQDI610W/wCxlWe7W4iOjju/HP3Abp7
 UIT3JJzIR+K+UpskNwxM6+10S/lph9hRxcMcNiz1yyETQ==
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

Hi,

thanks for the ack! Any chance you could also pick the patch into 
drm-misc-next? I don't think I have commit rights on drm-misc-next as of 
now.

Thanks,
Natalie

On 7/6/26 14:55, Maarten Lankhorst wrote:
> Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> 
> On 7/5/26 19:53, Natalie Vock wrote:
>>  From now on I'll use my own domain for development work, reflect that in
>> MAINTAINERS and mailmap.
>>
>> Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
>> ---
>>   .mailmap    | 3 ++-
>>   MAINTAINERS | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index d0d1367a261b8..3050ab1b97ea2 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -627,7 +627,8 @@ Nadav Amit <nadav.amit@gmail.com> <namit@cs.technion.ac.il>
>>   Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
>>   Naoya Horiguchi <nao.horiguchi@gmail.com> <n-horiguchi@ah.jp.nec.com>
>>   Naoya Horiguchi <nao.horiguchi@gmail.com> <naoya.horiguchi@nec.com>
>> -Natalie Vock <natalie.vock@gmx.de> <friedrich.vock@gmx.de>
>> +Natalie Vock <nat@pixelcluster.dev> <friedrich.vock@gmx.de>
>> +Natalie Vock <nat@pixelcluster.dev> <natalie.vock@gmx.de>
>>   Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
>>   Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.ibm.com>
>>   Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 377d224c5f76d..0caa9ea58db04 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6636,7 +6636,7 @@ F:	tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
>>   CONTROL GROUP - DEVICE MEMORY CONTROLLER (DMEM)
>>   M:	Maarten Lankhorst <dev@lankhorst.se>
>>   M:	Maxime Ripard <mripard@kernel.org>
>> -M:	Natalie Vock <natalie.vock@gmx.de>
>> +M:	Natalie Vock <nat@pixelcluster.dev>
>>   L:	cgroups@vger.kernel.org
>>   L:	dri-devel@lists.freedesktop.org
>>   S:	Maintained
> 

