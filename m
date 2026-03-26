Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2105210A88E0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFDC10EADF;
	Thu, 26 Mar 2026 15:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJ8RvohX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CF310EADF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:34:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6617D600AD;
 Thu, 26 Mar 2026 15:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE2BC116C6;
 Thu, 26 Mar 2026 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774539253;
 bh=xgV59XuiEnYysDHO3gya4Wt5dD2yT9/G88EecQrlncM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GJ8RvohXLbA7wvYa2sRPK1Lo0ng59PZVb3jGPflz3k0yZxLS628DwS7OFBV9vp4ZU
 R17xpwJSGAXLb62bPitYWXSnq/2qSqaQfn8GQjg3+qRz1ipIdE7owZTf+lajjZ7ywg
 D4+8MvSeOKnLmXwS49cUWCp3IiBhODCDAi1VbajMoCHIYCc8a8VVpfDOJvAGShv1x6
 wdxUnaGLt8eeDQINOQtrGar/8hDpLUYgHqBGv7mLY7ecZTxbNOPtv6RDRHlQ5tIIYn
 7Oc6OZSSO5swX7BfBvj+dVHrkJiRj499agrf0eNuorSfxEJTqbl3nHJQA5mG51bdUB
 hno688MzrrPHA==
Message-ID: <a6fca446-ea09-42bd-a4a4-436e0dcedd03@kernel.org>
Date: Thu, 26 Mar 2026 16:34:09 +0100
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
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
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

On 3/26/26 4:25 PM, Alice Ryhl wrote:
> Alice Ryhl (2):
>       rust: workqueue: use new sync::aref path for imports
>       rust: drm: use new sync::aref path for imports

Acked-by: Danilo Krummrich <dakr@kernel.org>

You may want to use kernel formatting style though. :P
