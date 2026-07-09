Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483ADC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D6910E6B9;
	Thu,  9 Jul 2026 12:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bjmHsOkd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8461810E6B9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D/WQMdT1l9oDkA/jlfeGNCnjf+AkzyssWz3FiX/dxo4=; b=bjmHsOkd2dgS5HkkDyJCaP06KP
 VY7w22kTCfSKoft26zTnifcBqI4G369Nwdaz6aGi3UKd6m9KZWV3oTluRAljV9qQ+qt7K+NEj7A1B
 c5lpbYYlk5GQVlNV96UqDbDiPXisSDfxVANeHfcec+NtaQKUfVXbi5oat0NLOCKV7QqVDdrd12cOs
 BkC35iXu0aeWQFp5J8woqMdOpDiZaKoJruN2PsMDVvaFymnSL1j6CuSmDnlGfwI8wtYCevDpBYaRz
 Q7hgP2spD3Ibp+HNz4As50iocOJEzk7tNXDQvMnZMM/1jdV3PbiX8ZYzPbIjoMVmBW60QWav/sFXU
 XYGKu+YA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whnft-00CDhT-9K; Thu, 09 Jul 2026 14:16:17 +0200
Message-ID: <261b77b6-6447-412e-b23c-dbb9b6b507c5@igalia.com>
Date: Thu, 9 Jul 2026 13:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] drm/panthor: Remove redundant drm_sched_job_cleanup()
 from the .free_job callback
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-2-tvrtko.ursulin@igalia.com>
 <cd319413-edd9-4bd6-b393-91f48fa7b795@arm.com>
 <42890d89-367e-44f8-90e8-07f2580afca7@igalia.com>
 <20260709121507.2b2e817c@fedora-2.home>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260709121507.2b2e817c@fedora-2.home>
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


On 09/07/2026 11:15, Boris Brezillon wrote:
> On Thu, 9 Jul 2026 11:05:52 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> On 03/07/2026 16:00, Steven Price wrote:
>>> On 02/07/2026 15:37, Tvrtko Ursulin wrote:
>>>> After calling drm_sched_job_cleanup(), the free job callback releases it's
>>>
>>> NIT: s/it's/its/
>>>    
>>>> reference to the job, where the act of dropping the last reference will
>>>> also call the drm_sched_job_cleanup() helper.
>>>>
>>>> We can therefore remove the redundant call from the .free_job callback.
>>>>
>>>> But we have to leave the "if (job->base.s_fence)" guard in job_release(),
>>>> since that one not only handles the above described double cleanup, but
>>>> also deals with all job cleanup paths which happen before the point the
>>>> job was armed.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>>> Cc: Steven Price <steven.price@arm.com>
>>>
>>> I agree this looks redundant.
>>>
>>> Reviewed-by: Steven Price <steven.price@arm.com>
>>
>> Thank you!
>>
>> Can this patch be picked up and merged on it's own and who can do it?
>> Not sure if there is any CI for panthor it maybe needs to pass first.
> 
> Nope, we don't. Feel free to queue this to drm-misc-next (with the
> type fixe), otherwise Steve or I will queue it at some point.

Pushed to drm-misc-next, thank you!

Regards,

Tvrtko

