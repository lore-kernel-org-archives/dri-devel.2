Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F84CDE00B
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 03:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF20910E2A1;
	Fri, 26 Jun 2026 03:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Q3DWILNq";
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495ED10E2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 03:02:30 +0000 (UTC)
Message-ID: <6d2b7611-41ec-45f0-a155-3b5c90c5d883@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782442947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f271ICHhBS5Ku8NbvazkeutM3PKmnGfN//6w5jBctrk=;
 b=Q3DWILNq4rp7hL2oZ6zGRWnQi51EjKsSeNeF9gJ2kjLwYticVzg/5adTwdCkossO18oJMv
 IX52h1GK1926K2SnQvL/RfDBYyDo0cmHpp2mWBjWBwBXYlPzRxN9/ESbADYOUha3RRcoHu
 ysyaxxln8iygLQDFXJyQQTJeou2c7/8=
Date: Fri, 26 Jun 2026 11:01:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6 10/10] rust: module: update MAINTAINERS to cover
 module.rs
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
 <20260624-fix-fops-owner-v6-10-5295e333cb3e@linux.dev>
 <DJI7HR91X68U.3BVK3U4OJC18B@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJI7HR91X68U.3BVK3U4OJC18B@garyguo.net>
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


On 6/25/26 22:39, Gary Guo wrote:
> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>> Module types now live in `rust/kernel/module.rs` alongside
>> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
>> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
>> files are covered.
>>
>> Assisted-by: opencode:glm-5.2
> Did you actually use a LLM for this patch even? :)

Yes, I've created a skill that generates commit messages for the code I 
modify
manually.

>
>> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> This patch should probably be squashed into the actual move, i.e. patch 1.

Sure. Looking at the change history of the `MAINTAINERS` file, the 
modifications
are always in standalone commits, so I followed the same convention.

Best regards,
Alvin

>
> Best,
> Gary
>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e035a3be797c4..74733de3e41ee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>>   F:	kernel/module/
>>   F:	lib/test_kmod.c
>>   F:	lib/tests/module/
>> -F:	rust/kernel/module_param.rs
>> +F:	rust/kernel/module*.rs
>>   F:	rust/macros/module.rs
>>   F:	scripts/module*
>>   F:	tools/testing/selftests/kmod/
>
