Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606DFCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C473310E1C0;
	Mon, 18 May 2026 07:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="VyOxI4sd";
	dkim-atps=neutral
X-Greylist: delayed 335 seconds by postgrey-1.36 at gabe;
 Mon, 18 May 2026 07:45:47 UTC
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9917910E1C0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:45:47 +0000 (UTC)
Message-ID: <9839e1fc-faa2-4e98-9f46-b6449bf0f35a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779090010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdTZ6I3r6p2N/vnsVvGebag/NENLhnQV+Vz8Nhz5itg=;
 b=VyOxI4sdXqvm+ZcsCpKi6HOLHcz7L74lLGM81q/UbSZ6NICDfn64E0Q2XA3Q6S55HTzTdx
 X0vbmzjL+AlcLXHAbBxfoKfOB+q/zj0k6Kuq58ERzuLeduSZZNGmcIPQsE4YvijYiUz6E3
 suaYsH1kiu+xOt5ccKYwzQF3JU2Eoac=
Date: Mon, 18 May 2026 15:39:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 08/13] rust: drm/gem: add GEM object query helpers for
 debugfs
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-8-074badd18716@linux.dev>
 <DIHXMUSMRHYB.39N8PCC9D86KM@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DIHXMUSMRHYB.39N8PCC9D86KM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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


On 5/14/26 07:20, Danilo Krummrich wrote:
> On Thu Mar 26, 2026 at 7:53 AM CET, Alvin Sun wrote:
>> Add name(), refcount(), is_imported(), is_exported(), and mmap_offset()
>> to BaseObject so drivers can expose GEM state in debugfs.
>>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   rust/kernel/drm/gem/mod.rs | 49 +++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
>> index 276ba3c53475d..b6188c8873ece 100644
>> --- a/rust/kernel/drm/gem/mod.rs
>> +++ b/rust/kernel/drm/gem/mod.rs
>> @@ -21,9 +21,13 @@
>>       },
>>       error::to_result,
>>       prelude::*,
>> -    sync::aref::{
>> -        ARef,
>> -        AlwaysRefCounted, //
>> +    sync::{
>> +        aref::{
>> +            ARef,
>> +            AlwaysRefCounted, //
>> +        },
>> +        atomic::Relaxed,
>> +        Refcount, //
>>       },
>>       types::Opaque,
>>   };
>> @@ -177,6 +181,45 @@ fn size(&self) -> usize {
>>           unsafe { (*self.as_raw()).size }
>>       }
>>   
>> +    /// Returns the name of the object.
>> +    #[inline]
>> +    fn name(&self) -> i32 {
>> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
>> +        unsafe { (*self.as_raw()).name }
>> +    }
>> +
>> +    /// Returns the reference count of the object.
>> +    #[inline]
>> +    fn refcount(&self) -> u32 {
>> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
>> +        let raw_refcount = unsafe { &raw mut (*self.as_raw()).refcount }.cast::<Refcount>();
>> +        // SAFETY: `raw_refcount` has the same layout as `Refcount`.
>> +        let refcount = unsafe { &*raw_refcount };
>> +
>> +        refcount.as_atomic().load(Relaxed) as u32
>> +    }
> How is this reference count useful in debugfs? In any case, please don't expose

I'm just following the pattern of Panthor's debugfs output.

> object reference counts, it motivates abuse.
>
> Can't we just prove a common Debug impl for GEM objects instead of providing all
> those accessors?

A generic Debug impl for GemObject? Other drivers like Nova might need 
different
output in a different style.

How about a dedicated debugfs data structure for GEM Object instead? Say, a
get_debugfs_info() method that handles synchronization internally and avoids
exposing unnecessary interfaces?

>
>> +
>> +    /// Returns true if the object is imported.
>> +    #[inline]
>> +    fn is_imported(&self) -> bool {
>> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
>> +        !unsafe { (*self.as_raw()).import_attach }.is_null()
>> +    }
>> +
>> +    /// Returns true if the object is exported.
>> +    #[inline]
>> +    fn is_exported(&self) -> bool {
>> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
>> +        !unsafe { (*self.as_raw()).dma_buf }.is_null()
>> +    }
>> +
>> +    /// Returns the offset for mmap, or 0 if no offset has been allocated.
>> +    #[inline]
>> +    fn mmap_offset(&self) -> u64 {
>> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
>> +        unsafe { (*self.as_raw()).vma_node.vm_node.start }
>> +    }
>> +
>>       /// Creates a new handle for the object associated with a given `File`
>>       /// (or returns an existing one).
>>       fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
>>
>> -- 
>> 2.43.0
