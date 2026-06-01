Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0586CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF51113032;
	Mon,  1 Jun 2026 09:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YSin1PcW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125CC113031
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nKVncQzPkAOF0y24Cqo28vrs6F2PM/5uxmV6mpFbwE0=; b=YSin1PcWmB2gguFz5cs5B5D8Bf
 yZaTQ2260qnYFE2k1IL5buM1lFGyrLPQ7laqe09ikRusI/b/mrjtZ/Lbv2z9joCXIKn3iJ7cCRpHm
 FfmmBDDlNe7YVR29pIwfheWLPjkMaECcIcW61gGKEe6Yhz9KEoZpZfz6Ci93Wd3y5nI9+b8rJPh5A
 SvmHAFnlAuHQoOIekNQJ4VwrfJLxcr1Ur1YaiyYmWPNnLLfN/BeHmuhGhpcET2KvUlvmN2axNZioK
 VKxZM5BCXct1vYJKvDJ7tViw/J+kC2avXMQhtpgyy/eRyi4MARf0ZiBDZbGeU63hiPN7JvIAHyxca
 6gzAyHEg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wTyao-00Au8p-SL; Mon, 01 Jun 2026 11:05:54 +0200
Message-ID: <41f3bb31-f340-4aae-b244-ec9d06ede55c@igalia.com>
Date: Mon, 1 Jun 2026 10:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] drm/panthor: Use separate workqueue for DRM scheduler
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Liviu Dudau <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
References: <20260522113817.11745-1-tvrtko.ursulin@igalia.com>
 <20260522113817.11745-3-tvrtko.ursulin@igalia.com>
 <20260522174831.34983d27@fedora>
 <7839ed28-77a8-42ff-8c9b-ac160e0f3a8f@igalia.com>
 <20260523080629.1ce22098@fedora>
 <ee686e99-6e80-4f0b-97db-8a3419e1314d@igalia.com>
Content-Language: en-GB
In-Reply-To: <ee686e99-6e80-4f0b-97db-8a3419e1314d@igalia.com>
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


On 23/05/2026 14:12, Tvrtko Ursulin wrote:

8><

>>> I will respin next week or so. Or if you tell me the global lock can be
>>> easily dropped from .run_job I can drop and forget about it. Wider
>>> context is that I am experimenting with kthread_worker conversion and
>>> trying to polish a
>>> somewhat-broken-but-showing-great-latency-improvements branch.
>>
>> Yep, I know, your experimental branch is actually on my list of things
>> to look at/test ;-).
> 
> Hold off a few days at least, there is a UAF in the branch Chia-I tested 
> and I am in the process of reworking some details to eliminate that.

FYI the new branch is at:

https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=drm-sched-kworker-single-submit

And benchmark numbers from Chia-I are at:

https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49#note_3484837

Those were collected from the old branch, but I am quite confident the 
fixed version will behave the same.

In summary it is quite compelling, and details aside, I guess the 
question at some point will be where do we go from here. Do we proceed 
in building something on top of kthread_worker, if the problem of 
spawning too many threads cannot be otherwise avoided, do we go back to 
the workqueue maintainers asking to re-consider adding priority 
inheritance or something, or some third option.

Regards,

Tvrtko

