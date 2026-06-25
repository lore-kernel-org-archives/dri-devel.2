Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3548CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC57E10E86D;
	Thu, 25 Jun 2026 13:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oDAOCnJJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65EA10E86D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:02:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24243600FC
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3071F00A3A;
 Thu, 25 Jun 2026 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782392558;
 bh=1H9YqsGITkikakZjicoBwyNffoOYnokalhrvBQ6sPwE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=oDAOCnJJ4Ljul/BncpuQq6v2RXxJQ+n9BE1KQXfeXxeSuDpmNz9fs0sX8hEP5AsN9
 aPME/YN2wktTp58v4JhIsrpH9Wvmb0bwj4+3QNMSzIoumlSPxBrQAJQSRBlaw5ULid
 drbXu9ENVTGJJHh1jc0uBJNAbWetLRslW9YcpkgKiTEYTbDA8XH+F/CdZ/jYt1XBAT
 B5i5hA3dox/ppuYHPHUjfoNOeR+jlxzKkpjXLwLIx+8K44ikmvZ5CUNGMr8eTXTOHK
 Pqf4jeyQHwBZtWZnrvgDxOWOaCg47aA1mmeChPuNXiX0yf3+W8n18v8vbjm2aHdYcQ
 yddnpTJxTGFGw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 5/8] rust: rename `AlwaysRefCounted` to `RefCounted`.
In-Reply-To: <20260625102800.B4C3B1F00A3A@smtp.kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-5-4e06b5896d47@kernel.org>
 <sC1PIDifb5R9SC4mqWkofW48Un8TOJzms8T2r2zfKwINaCyFbCgdIkAg7RhnBEXT9S32H3USLcHywBynA6ETxg==@protonmail.internalid>
 <20260625102800.B4C3B1F00A3A@smtp.kernel.org>
Date: Thu, 25 Jun 2026 14:26:53 +0200
Message-ID: <877bnmiz5e.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

<sashiko-bot@kernel.org> writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Incomplete Refactoring / Trait Bound Violation for workqueue items
> - [Medium] Stale and misleading documentation for `ARef` usage
> --
>
> commit 46d36a47415ab0722d334e8010242374e8bba94c
> Author: Oliver Mangold <oliver.mangold@pm.me>
>
>     rust: rename AlwaysRefCounted to RefCounted.
>
> This commit splits the AlwaysRefCounted trait into RefCounted (for actual
> reference counting logic) and a new AlwaysRefCounted marker trait. This change
> allows types that can be both reference-counted and owned to safely use
> ARef<T> conversions without violating ownership constraints.
>
>> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
>> index 3bd5eb8a1a526..fb7466a362741 100644
>> --- a/rust/kernel/sync/aref.rs
>> +++ b/rust/kernel/sync/aref.rs
>
> [Severity: Medium]
> In the module documentation which isn't included in this diff, it states:
>
> //! To make use of [`ARef<MyType>`], `MyType` needs to implement
> //! [`AlwaysRefCounted`].
>
> Should this documentation be updated to reference RefCounted instead?
>
> Leaving this as AlwaysRefCounted might mislead developers into implementing the
> marker trait for new types, which could violate the safety contract if their
> type is also Ownable.

I will fix this.

>
>> @@ -24,11 +24,9 @@
>>      ptr::NonNull, //
>>  };
>>
>> -/// Types that are _always_ reference counted.
>> +/// Types that are internally reference counted.
>>  ///
>>  /// It allows such types to define their own custom ref increment and decrement functions.
>> -/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
>> -/// [`ARef<T>`].
>
> [ ... ]
>
>> @@ -45,9 +43,8 @@
>>  /// at least until matching decrements are performed.
>>  ///
>>  /// Implementers must also ensure that all instances are reference-counted. (Otherwise they
>> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
>> -/// alive.)
>> -pub unsafe trait AlwaysRefCounted {
>> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`] keep the object alive.)
>> +pub unsafe trait RefCounted {
>>      /// Increments the reference count on the object.
>>      fn inc_ref(&self);
>
> [Severity: Medium]
> Since this patch renames AlwaysRefCounted to RefCounted and re-adds
> AlwaysRefCounted as a marker trait, does rust/kernel/workqueue.rs need to be
> updated to use the new bound?
>
> Currently, rust/kernel/workqueue.rs enforces T: AlwaysRefCounted for work
> items using ARef<T>:
>
> rust/kernel/workqueue.rs:
>     unsafe impl<T, const ID: u64> WorkItemPointer<ID> for ARef<T>
>     where
>         T: AlwaysRefCounted,
>
> The same bound is used for RawWorkItem and RawDelayedWorkItem.

Yes, they should be changed to `RefCounted`. I will fix this.


Best regards,
Andreas Hindborg


