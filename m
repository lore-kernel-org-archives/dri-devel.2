Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65C3C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203D410E878;
	Mon, 10 Aug 2026 13:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kDxj9bqv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7BC10E873;
 Mon, 10 Aug 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=in27MSSbAxZbIP265QZdTG9n006Q7o8kcgCwAqziv7o=; b=kDxj9bqv56sC44wxqDOhy5+4UJ
 u4f0gXC49VMaN0nAVlLWBXBQFX1n+43xx194cnQeQX2in6Kp6KPjQg4xqcbkNKkvrzs5eUu2tGACt
 GrfpKcRnSuDcOlqZZZKXhKozFXe+hVuEzH3q5CIbKYf3YSDDqKkrikPkMYOZNrHh54XwviUvfCXPx
 vpSk41O3zgj8NQ2z17aYaW3SMZxz36qOOfB+9ANBO9NC51bAzZEWN+Ml5ibEB5BCq1XlpYQ6SmlYt
 A/a/A1YVcWhOR7kgwvDh/2vug6uDcGV1x4e9Ocijzq0EIHbPgkZKz0ti0VMm4CLzBQBWjoujTqMnX
 rffT9q8g==;
Received: from [90.249.211.112] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wtQMQ-00Gc30-Hh; Mon, 10 Aug 2026 15:48:14 +0200
Message-ID: <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
Date: Mon, 10 Aug 2026 14:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@mailbox.org>
Cc: phasta@kernel.org, Luke.Wildhardt@proton.me,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
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


On 10/08/2026 13:45, Danilo Krummrich wrote:
> On Mon Aug 10, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
>>> Reverted Commits:
>>>
>>> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
>>> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
>>> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
>>> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single run queue
>>> 45c211ddf92a drm/sched: Switch default policy to fair
>>> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
> 
> [...]
> 
>> That might be the wisest thing to do; but let's hear if Tvrtko has an idea for
>> a hotfix first.
> 
> -rc7 was released yesterday; even with a working hotfix today it'd be tricky to
> ensure the hotfix does not regress other drivers or workloads with 7.2 being
> just a few days ahead.
> 
> I suggest to not wait and get the reverts ready.

Yes reverts would be safer. I have them in a branch at 
people.freedesktop.org/~tursulin/drm-intel drm-sched-fair-reverts, 
mostly straightforward apart from one easy conflict in 
amdgpu_xcp_release_sched. Smoke tested on Steam Deck looks fine.

Having said that, the fix for min_vruntime handling I provided earlier 
in the thread also looks fine in my testing and is simple. No 
regressions found with synthetic unit test workloads or messing around 
on the Steam Deck. But we need to wait to hear from Luke since I haven't 
been able to repro his report locally yet.

Regards,

Tvrtko

