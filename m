Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E281CD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A3910E46F;
	Thu, 21 May 2026 07:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Iv/kUm6n";
	dkim-atps=neutral
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B8D10E46F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:58:12 +0000 (UTC)
Message-ID: <81013175-0164-4ad4-a4a7-0cab332b695b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779350290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvW89Y5yfvW9tGdg4/aM0qB0CsEzidAsVDHwaWcD2rs=;
 b=Iv/kUm6ntc1nclOZY3Cbub6Jza3tf2c1fxkkBVni4Osz/a52CsxDJaJwW3ZWCAXFi0XiRh
 0uRE7AOVta6oDrhghHpMBu0X351qPMkPHyEeAmHnU5+L1mG27GB0tm/2457Gm6qhe8lkBC
 lA+diiK0q90tc/UJ9UIRzA1ECGTa0g8=
Date: Thu, 21 May 2026 15:57:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] rust: driver: make `DriverModule` struct pub(crate)
 in `module_driver!`
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
 <20260519-fix-fops-owner-v1-2-2ded9830da14@linux.dev>
 <DIMMSJ6GO6XE.2D3RYBTZ45EW1@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DIMMSJ6GO6XE.2D3RYBTZ45EW1@garyguo.net>
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


On 5/19/26 19:53, Gary Guo wrote:
> On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
>> Expose the generated `DriverModule` struct as `pub(crate)` so that
>> driver implementations can reference it via `super::DriverModule`
>> for the `ThisModule` associated type.
> Why is this needed? Child modules can see items super modules.

I misread it — I've already used LocalModule directly in v2.

Best regards,
Alvin

>
> Best,
> Gary
>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   rust/kernel/driver.rs | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
>> index 36de8098754d0..9c7c69c4d2af0 100644
>> --- a/rust/kernel/driver.rs
>> +++ b/rust/kernel/driver.rs
>> @@ -253,7 +253,7 @@ macro_rules! module_driver {
>>           type Ops<$gen_type> = $driver_ops;
>>   
>>           #[$crate::prelude::pin_data]
>> -        struct DriverModule {
>> +        pub(crate) struct DriverModule {
>>               #[pin]
>>               _driver: $crate::driver::Registration<Ops<$type>>,
>>           }
