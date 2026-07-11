Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950F0C44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 13:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA37C10E36E;
	Sat, 11 Jul 2026 13:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UuM7M/Kq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0617810E350;
 Sat, 11 Jul 2026 13:11:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 375F5601D9;
 Sat, 11 Jul 2026 13:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A9B1F000E9;
 Sat, 11 Jul 2026 13:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783775462;
 bh=iCb53dcsCcB5dATh8qDXwvKoRgx+avhB4VmAxBBy4JQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=UuM7M/KqVFuJ3M8oaDUH18u3GqTYP/pBo3nYH64+xJZu9uUZaP20F8jXVLR5UMXzp
 xJ4pHfSt9MMyJd+qDujO8QR7ktR999yhRpS4hZPR3nEuSloObatSs1QtAQA3I5tBqo
 oy/InfwNoQQu3rnchmqeUkvpXJadp0plU9epZS7ioE2dpli3QdV/QjsD+OYyCImAr2
 kHS5PBJUyti1wgRxn9VJZda9/NgS6mAjh8IkikuaoP9t06ZogqbWIJSbZU3F1NGgWR
 MZr5Jb9Od6V3O5dXsSg/tQRxqJXZ7iZNR7AMNMqtyH+1E8w6ErVQ3FOneHz3knGPkL
 p+jY90FUDad/A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 15:10:58 +0200
Message-Id: <DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org>
Subject: Re: [PATCH 01/12] dma-buf: Add reference counting to dma_resv
Cc: <christian.koenig@amd.com>, <thomas.hellstrom@linux.intel.com>,
 <ecourtney@nvidia.com>, <simona@ffwll.ch>, <nat@pixelcluster.dev>,
 <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260710190752.2355-1-christian.koenig@amd.com>
 <20260710190752.2355-2-christian.koenig@amd.com>
 <alGcHjo9fzhHshx8@gsse-cloud1.jf.intel.com>
In-Reply-To: <alGcHjo9fzhHshx8@gsse-cloud1.jf.intel.com>
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

On Sat Jul 11, 2026 at 3:27 AM CEST, Matthew Brost wrote:
> On Fri, Jul 10, 2026 at 08:52:41PM +0200, Christian K=C3=B6nig wrote:
>> This provides clearer ownership semantics and makes the code more
>> maintainable by removing the embedded allocation hack.
>>=20
>
> This looks a lot better to me. In particular, I agree with the last
> sentence in the commit message.

I have to disagree with this, it is the opposite. As long as the struct
dma_resv::allocated fields and the corresponding semantics exists, this doe=
s
result into less clear ownership semantics.

When the dma_resv is embedded in another object the reference count becomes
meaningless. If the object embedding the dma_resv is freed it doesn't matte=
r
whether I have a reference count, it would a UAF regardless.

It is misleading (and hence error prone) to have an API where one can obtai=
n a
reference count of an object where the underlying memory can be freed regar=
dless
of the obtained reference count.

A refernece count represents a shared ownership model, which is undermined =
if
the underlying memory is not owned by the reference count.

That said, I don't mind the reference count, but we can't mix up exclusive
ownership (embedding a structure) and shared ownership (reference count).

>> +static void dma_resv_release(struct kref *kref)
>>  {
>> -	/*
>> -	 * This object should be dead and all references must have
>> -	 * been released to it, so no need to be protected with rcu.
>> -	 */
>> +	struct dma_resv *obj =3D container_of(kref, struct dma_resv, refcount)=
;
>> +
>>  	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
>>  	ww_mutex_destroy(&obj->lock);
>> +	if (obj->allocated)
>> +		kfree(obj);
>> +}
