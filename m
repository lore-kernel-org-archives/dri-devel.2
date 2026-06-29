Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD1C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D1C10E838;
	Mon, 29 Jun 2026 11:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jueRmeAk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C5C10E838
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:53:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 174DE43B4F;
 Mon, 29 Jun 2026 11:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094651F000E9;
 Mon, 29 Jun 2026 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782733990;
 bh=o6rZLVkG1sq/4BZGymOihUcF9tHkCw2+D/PK2hEwG9Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jueRmeAk+vbC5qNPeX7tO6jKvFV/8324+x1OLpRIWY5VzmyzuM8/i//ek8l97AVqo
 sZbnaels3qxfAhXkWu/pJ2KzTSYYwaqU3C+KEhugzxx689ISrGPOjOQewMTFf3R0LF
 Usz3lYMji97dSUZmXQIa7Lznx9pENW56MXhhg9H6oPuxkgvfMO707xAcSfDt6FY+ye
 RQ+LtyuWQkSvCP6NjEcNsFlKUTo7X/D1Q4UXm5DGQdQ9v0yeFHQfJy0mGuu+ynwBU3
 SBeo3z3iRLCkF/K3QESRbVtaDKyEoBRLbAnMnBS3nALw3jCIM6UGlk0LsF5F/I3m36
 MrMDYquGQvcJw==
Message-ID: <a9f1b6a5-ccf5-4bb1-96a8-54a3ed8f3f81@kernel.org>
Date: Mon, 29 Jun 2026 13:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu: nova-core: falcon: store bar and dev in falcon
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Tim Kovalenko <tim.kovalenko@proton.me>, Alice Ryhl
 <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
References: <20260625-drm-bar-refactor-v2-1-9db6b890d92e@proton.me>
 <DJLIEZJL9ZS6.J2642U4G4CT4@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DJLIEZJL9ZS6.J2642U4G4CT4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/29/26 1:51 PM, Alexandre Courbot wrote:
> Danilo, any objection?

Please do,

Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks!
