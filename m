Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A145E10BA426
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC0B10E1A2;
	Fri, 27 Mar 2026 06:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="A9gDF14E";
	dkim-atps=neutral
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7B610E1A2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 06:14:11 +0000 (UTC)
Message-ID: <d8b015a9-72d7-4e94-afd6-2ff96ea09c69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1774592049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCauHrrpuOtEUwL7UUDJRVF5muBm8RrWT/mgiwv+xSs=;
 b=A9gDF14ENKJbOpOxKu6kZy9qJi4ayqoNaNGI8Aee3uuYHEoSPY2DTA8xcMb+AlH1XSW07x
 FLvbdu8ugk3Bo0yzMWN4z9hSk46T76DdRv2t+KrWg6FQEdaAIYnonY6C3MMkrrYa77N9WE
 PKUfoQchdhK1mrxUokwpkv1zcpZb8q0=
Date: Fri, 27 Mar 2026 14:13:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] rust: sync: set_once: Rename InitError variants to
 fix clippy warning
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-3-074badd18716@linux.dev>
 <CANiq72mg9nAMrFNc4Tbn7rXeSoZGETTZnUtKBieVT3XLBmmhYA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <CANiq72mg9nAMrFNc4Tbn7rXeSoZGETTZnUtKBieVT3XLBmmhYA@mail.gmail.com>
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


On 3/27/26 00:35, Miguel Ojeda wrote:
> On Thu, Mar 26, 2026 at 7:55 AM Alvin Sun <alvin.sun@linux.dev> wrote:
>> Fixes clippy warning:
>> warning: all variants have the same postfix: `Init`
>>    --> rust/kernel/sync/set_once.rs:68:1
> Is this fixing an issue earlier in the series?
>
> If so, then I would suggest just fixing the patch that introduced the
> issue directly (since you are not the author, you can use square
> brackets between the Signed-off-bys to indicate what you changed. I
> agree with Gary that is may be simpler to just allow the warning.

Agreed. This clippy warning already exists in Gary's original patch. 
I'll fix it
there by allowing the warning directly, and add a square-bracket note 
between
the Signed-off-bys describing the change.

Thanks,
Alvin

>
> If not, then please add a Fixes: tag pointing to the commit being fixed.
>
> (By the way, if you do keep this patch, then please copy-paste more of
> the warning, i.e. it doesn't say what lint is being triggered. In
> addition, the imperative mood is what is expected in commit messages
> for the kernel.)
>
> Thanks!
>
> Cheers,
> Miguel
