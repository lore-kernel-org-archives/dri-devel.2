Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1A410A88E1
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A17C10E256;
	Thu, 26 Mar 2026 15:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qvSVhgA7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688AD10E256
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:50:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 236D0403D9;
 Thu, 26 Mar 2026 15:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E743DC116C6;
 Thu, 26 Mar 2026 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774540254;
 bh=pKIj3tcfeBPXe/46yo2sX5wA8dnGZvT4oK8Fk/3CliM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qvSVhgA7jcT6VZ+RmHI1kRRK8SGsHoaWqmYWfUtk4Sjf70FbahN3PxYGCx97xwcsK
 ApfJVYCeMAaSZubPTGkup/WMAajtik4a3BrnIptns/ZkuKk7ddFQKvfJo4O8DweEW3
 8E1zlZBjAIxQhOQk4AxquNVO+MEo+SRTCkYVQrZgvpwypRvLjl/7s1Up6ynqeoAr6H
 wNxJfmkqM6xjwmawlUMGur+HpNmDZ4Z9YcNJwSwI7N5KQviUTFAWm8CR2XQPCnteoH
 Vd6KtCOfeK8nUtHwHGHn+ZVQdBMCOdGY5bRtplU0vTYJRDHDzZqCJqb74WEL6os0pG
 7iJiclx0djgTw==
Message-ID: <fffb3c5b-e3ad-4784-8b74-da8e79218122@kernel.org>
Date: Thu, 26 Mar 2026 16:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [drm-rust-next PATCH 0/2] Fix sync::aref imports
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
 <CAH5fLggj1nFqQ6yxAgQxrTGJ11pzBdObbu7WNxv7YZDbhkCE2A@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLggj1nFqQ6yxAgQxrTGJ11pzBdObbu7WNxv7YZDbhkCE2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/26/26 4:49 PM, Alice Ryhl wrote:
> On Thu, Mar 26, 2026 at 4:25 PM Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> A few imports of types::ARef were merged into drm-rust-next, but this
>> old path is being removed in rust-next this cycle. Thus update them.
>>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>> Alice Ryhl (2):
>>       rust: workqueue: use new sync::aref path for imports
>>       rust: drm: use new sync::aref path for imports
>>
>>  rust/kernel/drm/gem/mod.rs | 2 +-
>>  rust/kernel/workqueue.rs   | 8 +++++---
>>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> I'm applying this now to avoid a linux-next break tonight. Thanks for
> the reviews Danilo and Gary.

Sounds good, thanks.
