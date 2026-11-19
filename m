Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF6606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BoTWH5Fi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5A31127C1;
	Thu, 19 Nov 2026 23:48:35 +0000 (UTC)
Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EBD1127C1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:48:29 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=6LWaP9a799dRmXjPzl0gkWLih06hsrqQYvPtGBFxEsY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795132107; v=1; x=1795736907;
 b=BoTWH5Fi1IZExkaX1UVG0UE/sKHeD7yr0JBoEA7pSxpIS9I/AG/d2puwMNbDLQzs2vT11U1s
 vASgSWckzezIb9s1Sd0vB6uxw4uXPLLwr5GKRk1rBj9hLubjulj4/oLYePkSmiMd7yc+crCqZM/
 4ZhHgjLXJXGKVDcDNMWg5GdI=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id a9882a66356e0e59;
 Thu, 19 Nov 2026 23:48:27 +0000
X-Mizu-Trace-ID: a9882a66356e0e59
X-Migadu-Flow: FLOW_OUT
Message-ID: <583bde38-c84d-41a3-a65c-d1365ea04f07@linux.dev>
Date: Fri, 20 Nov 2026 07:47:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, akpm@linux-foundation.org, dgilbert@interlog.com,
 mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 mhiramat@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk,
 linux-mm@kvack.org, James.Bottomley@hansenpartnership.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 joro@8bytes.org, will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com, mason@kernel.org,
 aesteve@redhat.com, tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
 cuitao@kylinos.cn
Subject: Re: [PATCH 4/7] tracing: account ring buffer pages and trace_array
 metadata to memcg
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-5-cui.tao@linux.dev> <avScKhR22kFOQ1z4@google.com>
 <20261111181447.3c483a50@fedora>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261111181447.3c483a50@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Steven, Vincent,

在 2026/11/12 07:14, Steven Rostedt 写道:
> On Wed, 11 Nov 2026 16:47:38 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> On Fri, Nov 06, 2026 at 09:18:26PM +0800, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> Creating an instance immediately allocates two full sets of per-cpu
>>> ring buffers, array buffer plus snapshot, about 1.375MB per cpu per set
>>> on the default config, plus the trace_array and its name.  None of it
>>> is charged: neither trace.c nor ring_buffer.c passes __GFP_ACCOUNT,
>>> while user_events in the same directory accounts everything it
>>> allocates.
> 
> As the name suggests, "user_events" are for users and are special.
> 
>>>
>>> Instance creation is currently gated by tracefs file permissions
>>> alone, so a
>>> rootful container with the host tracefs bound in can create instances
>>> until the host runs out of memory.
> 
> You mean, "works as expected"?
> 
>>  Charge the ring buffer pages and
>>> the trace_array metadata to the creating cgroup.
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>  kernel/trace/ring_buffer.c | 8 +++++++-
>>>  kernel/trace/trace.c       | 6 +++---
>>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>>> index 1fd28a72e6ee..676c059c112c 100644
>>> --- a/kernel/trace/ring_buffer.c
>>> +++ b/kernel/trace/ring_buffer.c
>>> @@ -441,7 +441,13 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
>>>  	 * gracefully without invoking oom-killer and the system is not
>>>  	 * destabilized.
>>>  	 */
>>> -	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
>>> +	/*
>>> +	 * The subbuffers are charged to the memcg of whoever caused the
>>> +	 * allocation: the creator of a trace instance, or root at boot for
>>> +	 * the global trace.
>>> +	 */
>>> +	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO |
>>> +		  __GFP_ACCOUNT;
>>>  
>>>  	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
>>>  	if (!page)  
>>
>> Hum, by default tracefs is root only. 
>>
>> And even if made accessible to other users: 
>>
>>   1. The life span of a trace instance is not tied to the caller.
>>   2. The ring buffer is shared by multiple users.
> 
> Right. Is there a use case out there that allows non-admin to create an
> instance? Tracing ring buffers can expose a lot and should not be given
> to unprivileged users.
> 
Not that I can point to.  Instances are admin-only by default, and the permission layer is the right place for that.

> What exactly is this trying to achieve?
>
The series closes uncharged kernel allocations that scale with user input.  For tracing I misread the tracefs permission check as a gap rather than the intended boundary.  Combined with Vincent's points on lifetime and sharing, I'll drop patch.
 
Thanks,
Tao
> -- Steve
> 
> 
>>
>> Overall I am not convinced charging the creator makes much sense.
>>
>> Eventually a few allocations for iterators could be GFP_ACCOUNT.
>>
> 

