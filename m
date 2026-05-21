Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F43CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0870810E458;
	Thu, 21 May 2026 08:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="eZKDvFim";
	dkim-atps=neutral
X-Greylist: delayed 402 seconds by postgrey-1.36 at gabe;
 Thu, 21 May 2026 08:07:02 UTC
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8E810E458
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:07:02 +0000 (UTC)
Message-ID: <f4e9063b-1def-4380-ad2a-01a0b12c1027@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779350417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnVqaFOkUKkSYbg64c5pRbVkOYoIDmxDfZVY5JS/cPw=;
 b=eZKDvFim8VqhBk/sVLqLNGbfeYV91CjMZI07U3viOpNuKFy7EGI4Z78yqXeg6CQ2nYU8fT
 Lcq1/k5qgbrv16RxaBmLpvxgYWGqvEVVZKY0ijjzaR0dWCA8qMGqNUrjjTQP5oqiwfHd3b
 74E7lE0Cd9lpzwYXvgATwU56ia6zZsk=
Date: Thu, 21 May 2026 15:59:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] rust: drm: add `ThisModule` associated type to
 `Driver` trait
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
 <20260519-fix-fops-owner-v1-3-2ded9830da14@linux.dev>
 <DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 5/19/26 19:58, Gary Guo wrote:
> On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
>> Add a `ThisModule` associated type bound by `ModuleMetadata` to the
>> `drm::Driver` trait, allowing DRM drivers to expose their module
>> pointer for use in file operations.
> FWIW, I was considering adding this automatically to the `#[vtable]` macro
> (associated types/consts won't have any costs if they're unused anyway).

That's a great suggestion. I've implemented it in v2 — please review.

Best regards,
Alvin

>
> But requiring an explicit specification isn't too bad either.
>
> Best,
> Gary
>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   rust/kernel/drm/driver.rs | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
>> index 5233bdebc9fcd..c798961650c1a 100644
>> --- a/rust/kernel/drm/driver.rs
>> +++ b/rust/kernel/drm/driver.rs
>> @@ -115,6 +115,9 @@ pub trait Driver {
>>   
>>       /// IOCTL list. See `kernel::drm::ioctl::declare_drm_ioctls!{}`.
>>       const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor];
>> +
>> +    /// The module implementing this driver.
>> +    type ThisModule: crate::ModuleMetadata;
>>   }
>>   
>>   /// The registration type of a `drm::Device`.
