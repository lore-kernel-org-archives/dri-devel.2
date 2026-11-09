Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDD606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Y8jrWoOa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2091D10E43B;
	Mon,  9 Nov 2026 09:52:30 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00E810E43B
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=BzUPhjfbI7hgxlhrsDS2vrCET8eg/Sl/5dZnXUefZbk=; t=1794217944; x=2109577944; 
 b=Y8jrWoOaxTqvlFRpvDF1uwZpcrj1L4WjtLyiZHAh/ZAQdWnUJBP/iVzkjwbSfE6GuJ8J5ujDxbW
 kdTbVlva+pysNP8uQ0VtXHWXtl40Y/nHuS4ujr/6ptRRtrKkIRNRPjeGoHINaf7AuA68YV6r7ifRG
 6iA+zVfbo0nLnYIUEGYQ8XCS35TvaG2ONHdi2Pc6hR9KyhWfUX1uY2ygAoikWi3/9952FtiQg6lj8
 jnsJuxquWfdXBBflgjANhAViKv3vj0Y500TEzDpmozk0a4sWpSaFB7PqlRmO28/ubHdeefXJ/lJLo
 cK1arA7hsAVcongWQbDm6aXTEK4mt1HSyDwQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQM30-0078U4-J4; Mon, 09 Nov 2026 10:52:18 +0100
Message-ID: <6b489363-274f-426a-9143-6ed5593a0c19@igalia.com>
Date: Mon, 9 Nov 2026 09:52:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] workqueue: Imply strict CPU affinity for WQ_RT
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>, Steven Price <steven.price@arm.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
 <20261104095225.32654-6-tvrtko.ursulin@igalia.com>
 <fbf6ec45cf29c26e2a064bd79f006862@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <fbf6ec45cf29c26e2a064bd79f006862@kernel.org>
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


On 05/11/2026 19:00, Tejun Heo wrote:
> Hello, Tvrtko.
> 
> On Wed, Nov 04, 2026 at 09:52:24AM +0000, Tvrtko Ursulin wrote:
>> -	if (wq->flags & WQ_RT)
>> +	if (wq->flags & WQ_RT) {
>>   		attrs->prio = RT_PRIORITY;
>> +		/* Strict CPU affinity for low latency execution. */
>> +		attrs->affn_scope = WQ_AFFN_CPU;
>> +		attrs->affn_strict = true;
>> +	}
> 
> I don't think this needs to be hard-coded. If setting it through
> workqueue attrs is too inconvenient, how about adding WQ_ flags so that
> the affinity scope and strictness can be set easily when the workqueue
> is created? The flags can be expanded to u64 to make room and
> reorganized cleanly while at it.

apply_workqueue_attrs() would work in theory but is not exported for 
modules which is required for panthor.

Regarding the flag reorganization, what would require expanding to u64? 
Unless I am missing something I see currently only 20 bits are used.

Although on a higher level my feeling is that panthor could first try 
with WQ_RT as is, and we consider adding strict affinity, via either of 
the above options, if that will not be good enough.

Regards,

Tvrtko

