Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A9606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=MLyh5SzI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D48B10E6D5;
	Mon,  2 Nov 2026 18:01:26 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F169210E6D5
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=rsoXzBeHz6VZLGtk/wZzqQf/KgxPznedob+STUPBrcA=; t=1793642479; x=2109002479; 
 b=MLyh5SzISmuvGbTobX0FR1jDmnNgwVpY5pPpr4+jpkwMsyWSz8U8QO/mO6KsWhRwsmQuV7xjmMN
 4uwbxbzJbdLNjNM5dO2Hi1h0MorwLgbS1qEXBum3WpKZtpbrUxLZL5pK0/JjA9qaDchtEcPiM2UtR
 U7NywhPHsvAsg6IVWe1ynV4BabjjsWk4gZqbwzia5dGnn6AaA8jYXiaZmCIHtYPmBrSDxe2HVIQmg
 QG1k8WbL70VtvW6zGFfWUeTYgls9YOalesswLzLKvCf6eCDqMfLO1GFESBb16iJnXlEQQLnPqhtLU
 O+S7d4x6BNt+CSckM1RfSkYYK75SYDru3R2Q==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xNwLH-000NsV-GX; Mon, 02 Nov 2026 19:01:11 +0100
Message-ID: <ab160c52-1645-4ec9-9ea2-5b8bc36d9284@igalia.com>
Date: Mon, 2 Nov 2026 18:01:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] workqueue: Separate sysfs mutable vs immutable wq
 attribute sanitizing
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-3-tvrtko.ursulin@igalia.com>
 <91711e517792f2e607258d75b633898e@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <91711e517792f2e607258d75b633898e@kernel.org>
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


On 23/10/2026 22:28, Tejun Heo wrote:
> Hello, Tvrtko.
> 
> On Thu, Oct 22, 2026 at 10:38:46AM +0100, Tvrtko Ursulin wrote:
>> +/* Sanitize attributes not modifiable via sysfs. */
>> +static void
>> +sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
>> +				   struct workqueue_attrs *attrs)
>> ...
>> +/* Sanitize attributes modifiable via sysfs. */
>> +static void
>> +sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
>> +				 struct workqueue_attrs *attrs)
>> ...
>> +static void
>> +sanitize_workqueue_attrs(struct workqueue_struct *wq,
>> +				 struct workqueue_attrs *attrs)
>> +{
>> +	sanitize_immutable_workqueue_attrs(wq, attrs);
>> +	sanitize_mutable_workqueue_attrs(wq, attrs);
>> +}
> 
> The three helpers seem a bit excessive for what they do, and the
> immutable call in sanitize_workqueue_attrs() is redundant, as
> apply_wqattrs_prepare() runs sanitize_immutable_workqueue_attrs() on
> both of its copies anyway.

Okay I dropped sanitize_workqueue_attrs() locally. I was trying to 
express the logic behind mutable and immutable, which also leads me to...

> Could the comment on sanitize_immutable_workqueue_attrs() state the
> contract? These attrs follow from the workqueue flags and are enforced
> on every apply, apply_workqueue_attrs() callers included, not only
> sysfs.

...the topic of what would be the best commentary for both.

Would these comments work:

/*
  * Sanitize attributes derived from the workqueue flags and which need 
to be
  * enforced on every attribute application.
  */
static void
sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
				   struct workqueue_attrs *attrs)
{
	if (wq->flags & __WQ_ORDERED)
		attrs->ordered = true;
}

/*
  * Sanitize attributes derived from the workqueue flags and which need 
to be
  * enforced only on workqueue creation.
  */
static void
sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
				 struct workqueue_attrs *attrs)
{
	if (wq->flags & WQ_HIGHPRI)
		attrs->nice = HIGHPRI_NICE_LEVEL;
}

Regards,

Tvrtko

