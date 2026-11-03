Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BA606EEA1
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AHkNgI8B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E322010E1CD;
	Tue,  3 Nov 2026 11:37:04 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFF310E1CD
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=tP0eDm+K+Ts1AokzxU+OQjzFfPfzGLzzVFeOKFJstP0=; t=1793705818; x=2109065818; 
 b=AHkNgI8Bs4r9yQBq5xb+mOuEEneleNZIuN/skVWLpv7opSGQt7BlcR7RcQmb886DO2ppibXRmJA
 P7K94N/URejMjOQcCYjM53vJ8PnjxIqJNJFw/zp9wmkAGDvkN8JX6CQ48Oidnn1Cglf7alonbfJWm
 eQO8i0x7EyvyKtpOoHSiB5/cug7/hJNb3RqvTEGAuA0QQUQ9cVo468783OLQXgVVkrSXJ4IVpKERN
 kI/g7Tn3ea6LGcHpYQ4ibya4CeJ3AWyBRpqbZDkgyL5SHuPbtQf/Xs+BUuwYMoFXn3tdPfqDiaQaq
 y28Oo34HAQWYPY8FHXZ7UWfDeBONWpxDb35Q==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOCos-001AIl-PT; Tue, 03 Nov 2026 12:36:50 +0100
Message-ID: <9c0fcefa-a40f-4e01-8fab-c079d4697397@igalia.com>
Date: Tue, 3 Nov 2026 11:36:49 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] workqueue: Add support for real-time workers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-4-tvrtko.ursulin@igalia.com>
 <a3ae9a0f13e3972d0645f555bcc26f4f@kernel.org>
 <9d6add80-2ec9-4f29-a815-ad0e955f7b5a@igalia.com>
 <7fec5fa8362328bf3356a077a8bd9687@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <7fec5fa8362328bf3356a077a8bd9687@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26/10/2026 18:37, Tejun Heo wrote:
> Hello, Tvrtko.
> 
> On Sat, Oct 24, 2026 at 09:33:42AM +0100, Tvrtko Ursulin wrote:
>> Can do. I'll get to it the week after next. (Tweaks to other patches in
>> the series as well.) Should I switch to a different base branch by then?
> 
> I just branched wq/for-7.5. That should work as the base.
> 
>> But if you are curious how much better strict
>> affinity makes them I can measure, it is not a huge effort.
> 
> Yes, numbers with and without strict affinity would be great.

Re-measured submit latencies on three relevant setups:

     us	   7.3.0   WQ_RT   +strict_affinity

    median    30      21          11
     min       2       3           2
     max     1038    941         108
    95pct    2384     49          28
    98pct    2922     63          51

I suppose we can interpret this in two ways. Plain WQ_RT is already a 
huge improvement, and although strict affinity is even better, the twice 
as good median probably isn't a huge selling point. So question is do 
tail latencies above the 98th percentile matter, or are they visible in 
the user experience. That I have no experience to answer.

FWIW I have locally split out the patch which adds strict affinity on 
top of WQ_RT so we can trivially go either way.

>> Hmm.. I could do that, but since the tool ships within the kernel does
>> it _need_ to have backward compatibility regarding kernel _internal_
>> implementation details?
> 
> It's just a nice-to-have, but other parts of the script already support
> older kernels, so falling back would be good if it doesn't add too much
> complexity.

Okay done.

Regards,

Tvrtko

