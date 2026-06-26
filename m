Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6100CDE00B
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 02:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FDD10E2CD;
	Fri, 26 Jun 2026 02:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="HBuW3/F0";
	dkim-atps=neutral
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1249510E2CD
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:36:21 +0000 (UTC)
Message-ID: <34a009d9-a1f3-4347-9e92-866ec05ddb60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782441379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CegCkrNaBHbS0Oj9Ldk9o9PP5HExitwf901kAMkwPm8=;
 b=HBuW3/F090mBYZL37N1SgKew3WdUYWwEq1G3Gdz0VQvXxEOspJwKy5dzjesLiz4H9/7nEI
 Ld3FlxQNHmujt6uefJXigfVXjSPvhIU36Ndkyfamoz1N4Ux0yrRNByHqzMl9c55vVs8eVK
 xqqSNZuaW5n7thiQ8n0QYdK/uoHGbEk=
Date: Fri, 26 Jun 2026 10:35:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
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
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-7-5295e333cb3e@linux.dev>
 <DJI7IOXAD84M.2F6VSBY64BO62@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJI7IOXAD84M.2F6VSBY64BO62@garyguo.net>
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


On 6/25/26 22:40, Gary Guo wrote:
> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
>> macro with `this_module::<LocalModule>()`, and update
>> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
>> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>>
>> Assisted-by: opencode:glm-5.2
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   drivers/block/rnull/configfs.rs | 6 ++----
>>   rust/kernel/configfs.rs         | 8 +++++---
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>> index c10a55fc58948..b2547ad1e5ddd 100644
>> --- a/drivers/block/rnull/configfs.rs
>> +++ b/drivers/block/rnull/configfs.rs
>> @@ -1,9 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   
>> -use super::{
>> -    NullBlkDevice,
>> -    THIS_MODULE, //
>> -};
>> +use super::NullBlkDevice;
>> +use crate::LocalModule;
>>   use kernel::{
>>       block::mq::gen_disk::{
>>           GenDisk,
>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>> index 2339c6467325d..c31d7882e216d 100644
>> --- a/rust/kernel/configfs.rs
>> +++ b/rust/kernel/configfs.rs
>> @@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
>>   ///                 configfs::Subsystem<Configuration>,
>>   ///                 Configuration
>>   ///                 >::new_with_child_ctor::<N,Child>(
>> -///             &THIS_MODULE,
>> +///             ::kernel::module::this_module::<crate::LocalModule>(),
>>   ///             &CONFIGURATION_ATTRS
>>   ///         );
>>   ///
>> @@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
>>   
>>                       static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
>>                           $crate::configfs::ItemType::<$container, $data>::new::<N>(
>> -                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
>> +                            $crate::module::this_module::<LocalModule>(),
> ^ You only changed one single place. This is still plain `LocalModule`.

Initially I wrote it as `crate::LocalModule`, but clippy warned about it. So
instead of putting the crate path in the macro body, I added `use
crate::LocalModule` in the calling file.

```
warning: `crate` references the macro call's crate
     --> rust/kernel/configfs.rs:1024:59
      |
1024 | ...  $crate::module::this_module::<crate::LocalModule>(),
      |                                                     ^^^^^ help: 
to reference the macro definition's crate, use: `$crate`
      |
      = help: for further information visit 
https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#crate_in_macro_def
      = note: `-W clippy::crate-in-macro-def` implied by `-W clippy::all`
      = help: to override `-W clippy::all` add 
`#[allow(clippy::crate_in_macro_def)]`

warning: 1 warning emitted
```

Alternatively, `#[allow(clippy::crate_in_macro_def)]` could be added on 
the macro
definition. Would you suggest that approach?

Best regards,
Alvin

>
> Best,
> Gary
>
>> +                            &[<$ data:upper _ATTRS >]
>>                           );
>>                   )?
>>   
>> @@ -1030,7 +1031,8 @@ macro_rules! configfs_attrs {
>>                           $crate::configfs::ItemType<$container, $data>  =
>>                               $crate::configfs::ItemType::<$container, $data>::
>>                               new_with_child_ctor::<N, $child>(
>> -                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
>> +                                $crate::module::this_module::<LocalModule>(),
>> +                                &[<$ data:upper _ATTRS >]
>>                               );
>>                   )?
>>   
>
