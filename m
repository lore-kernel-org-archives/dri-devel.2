Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F83CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FF210ECF7;
	Thu, 25 Jun 2026 13:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sveoc4cA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15DF10EAA5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:02:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCA9D443C5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5421F000E9;
 Thu, 25 Jun 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782392560;
 bh=wWpfoYo0he+1/XkBK644Cd03AtNcgDe0rI1UeR8YX1Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Sveoc4cAKUNYDUtQpv4K47fJt/hl7zZK8tsbX7Ne7/wCLB9uAGPnltdA6YWtTRmJU
 /7xHIU7y01csInUJPCg/9YhVEti1MXSSaQW6E6aOPRwZjo//DcXdHRau31CXto4Hji
 eEgUU7pqSa6ZEQDgQQzdCMSue43OPdISm4w3RcDKye391ngRppV/oBzlwI2rSP4Rsx
 Ut773Qzi7tSBz58yGrEDUuGtDK55hnMqIKhvfqGjBSWWCgCw0h69p/1kmQW+L5oKoW
 FP4dONHVHNdJwMd12HA7Zi7KhLHbHYvnRVoiISe1fU8lM2RPiyeRbyyDeEaqzP5quo
 PIzLXh3E/J1Tw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 8/8] rust: page: add `from_raw()`
In-Reply-To: <20260625102549.B56171F00A3E@smtp.kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
 <24fS7Cgk-Y_pR5s6G0gXJ3zpbj_q2vdQ6BamOE62CiY_dtN1xrG5oDJqTy0LCceddw2AsvATlzKDX0MwJIg7Cw==@protonmail.internalid>
 <20260625102549.B56171F00A3E@smtp.kernel.org>
Date: Thu, 25 Jun 2026 15:02:28 +0200
Message-ID: <871pduixi3.fsf@t14s.mail-host-address-is-not-set>
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

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `# Safety` documentation for `Page::from_raw` is missing the precondition that `ptr` must point to a valid `struct page`.
> --
>
> commit f6aeebdd661d4004190de07e9d991442f793517a
> Author: Andreas Hindborg <a.hindborg@kernel.org>
>
> rust: page: add `from_raw()`
>
> This commit adds a from_raw() method to the Page abstraction. It allows
> the construction of a shared reference to a Page instance directly from a
> raw struct page pointer.
>
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 6dc1c2395acaf..c88fda09ead5a 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>
> [ ... ]
>
>> @@ -143,6 +143,20 @@ pub fn nid(&self) -> i32 {
>>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>>      }
>>
>> +    /// Create a `&Page` from a raw `struct page` pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
>> +    #[inline]
>> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
>
> [Severity: Medium]
> Is the safety documentation missing a requirement here?
>
> The # Safety section only requires that ptr is convertible to a shared
> reference. Under Rust's rules, an uninitialized or dummy pointer could
> technically be converted to a shared reference if properly aligned.

This is not correct. A pointer is only convertible to a shared reference
if it is pointing to properly initialized data [1].

>
>> +        // INVARIANT: By the function safety requirements, `ptr` refers to a valid `struct page`, so
>> +        // the returned reference upholds the type invariant of `Page`.
>
> The invariant justification inside the function explicitly relies on the
> caller guaranteeing that ptr refers to a valid struct page. Could the
> # Safety documentation be updated to explicitly require that ptr points
> to a valid, initialized struct page so that callers do not inadvertently
> violate the Page type invariant?

For `ptr` to be convertible to a shared reference, it must point to
valid and initialized data.

Best regards,
Andreas Hindborg


[1] https://doc.rust-lang.org/stable/core/ptr/index.html#pointer-to-reference-conversion

