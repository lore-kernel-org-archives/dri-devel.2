Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A11FCD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3BD10E436;
	Mon, 22 Jun 2026 02:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Tto3Rx1j";
	dkim-atps=neutral
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A826210E436
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:55:45 +0000 (UTC)
Message-ID: <02e9be5f-8dfa-4a4f-8a70-627ed1124b91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782096942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPT6DAdg86ekeubsFUyJE8zxGgUJMoz3jyqa9JhEVkU=;
 b=Tto3Rx1jAaHFtdkhawr4dGV2oKUQ+FH3oxDMEtfUe30AqTgIxxAqLJzSwSTl3FHaQCi9kl
 8DSHCQJxWmTNAgouSdXaK156DzQRkSoeITF8p9plSxjrB2oLwl/FA9EjLfTd3z4zp8l83i
 Ss3MyZcgf5r8XpkmwL+rT4BP/ncSct4=
Date: Mon, 22 Jun 2026 10:52:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
To: Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
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
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-3-fd99079c5a04@linux.dev>
 <87fr2kf3m2.fsf@t14s.mail-host-address-is-not-set>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <87fr2kf3m2.fsf@t14s.mail-host-address-is-not-set>
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


On 6/18/26 20:13, Andreas Hindborg wrote:
> Alvin Sun <alvin.sun@linux.dev> writes:
>
>> Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
>> in the doctest harness, so that `crate::LocalModule` (auto-inserted
>> by `#[vtable]`) resolves correctly when there is no `module!` macro.
>>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Does this need to be ordered before the vtable auto insert in the patch series?

Yes, you're right — this patch would be better placed before the vtable
auto-insert patch to avoid a temporary state where the doctest harness
doesn't provide the LocalModule fallback that #[vtable] expects.

Thanks for the suggestions from you and Gary. v3 has been sent to the
list:

https://lore.kernel.org/rust-for-linux/20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev

Best regards,
Alvin Sun

>
> Best regards,
> Andreas Hindborg
>
>
