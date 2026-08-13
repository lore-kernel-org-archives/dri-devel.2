Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192F4C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C9A10E42F;
	Thu, 13 Aug 2026 08:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="UHai7FBN";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BDF10F1E5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:15:12 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=HJkkjybnc95eKMUgffBgUHHJLr8cPHCSSaxuPE45BEc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786608910; v=1; x=1787213710;
 b=UHai7FBNVrl0ZSe+2mNdxKwYssAUVvc8lLsNDvxwVJM9F25wBLYV5Nekeg3/FEgeXSbEloJt
 ZUh6B0rVaU2nqJACkfxm66O77x++fBtgRcll4Gv0xFHv1ZqOU6grQX9i/Mwzt/PjWYN5IIfrGkF
 LJ4WiabhJaVR4BgMgGXFog+A=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from [10.0.11.3] (2a11:3:200::10a9)
 by smtp.migadu.com with ESMTPS id 549bb4bc2be94b73;
 Thu, 13 Aug 2026 08:15:10 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
Date: Thu, 13 Aug 2026 16:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
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
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 8/13/26 00:33, Miguel Ojeda wrote:
> By the way, I removed the Acked-by in that last patch since I think it
> came from an older version as a series-tag that didn't have the patch.
> Please let me know if I should re-add it.

Hi Miguel,

Thanks for applying the series and catching the stray Acked-by.
It was a v5 series-tag, from before the MAINTAINERS patch existed,
so no need to re-add it. I'll be more careful with tags in future
submissions.

Best regards,
Alvin
