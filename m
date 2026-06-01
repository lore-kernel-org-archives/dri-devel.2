Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B76DCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C498113100;
	Mon,  1 Jun 2026 09:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Wr4noz90";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09D9113100
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:46:03 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f654so2846606a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780307162; x=1780911962;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=F2mLiP05KImuXhLYRlm3itUuIPBG7j9sX+uByjRaID4=;
 b=Wr4noz90uNFCw3xQQUuiyLZa/rBoEhvdCvNTgc1VHN+jImGSnWfvTS3M9hqhxHgBYk
 ekKOlgKtLTG+kbnY+tgUicmN7p25a9z8h413hi1umAXeImngFW+AJARb+WNj7J0Gmvrr
 n/6vNLSye3oWs0xxVqE+9cVON2xwlymt5y21taDhiBEKdUIzaNZVT2JFYIufB+fV0uo/
 FzBsn4j0DglVECtGmFcHVt7AonEQqmZYrktkSx22ksQsPB5wemZqg6Tgn07Vxm4V+Ocv
 gdFGe7Ee3wRJFg6WpCdbF4KTCTa/Dhxi/CnUw9k2aAflu6yDeqRmRJwSAfHFqkr6Bu7X
 Q+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780307162; x=1780911962;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F2mLiP05KImuXhLYRlm3itUuIPBG7j9sX+uByjRaID4=;
 b=VVgmTiKDqOqY4tpErjucueKtJUD4mtUU2aCvZ4LRbrY1S8Tov54PE2NDvNIkDkEEvY
 ljZSXON5/7dwtC6zSB5MZphV25pHTJgu9cZNogCS8uFuu9b4VyzDZEU7fiaXl98kcpqw
 I8ux3YRwpR61B4eXlvWSZOBm0JEJEYRH250FjDgVUNJNPcSY7DpQImo7nknixrqWd+lo
 temYVedTGSAajFbi50/wu6WiAxpph9baOIY1xfoe3jf6984m16QOUxSi4ycqGEBem9F4
 VCvWwHojXf+FXaZxj9FnnuNGP18dKEg0/3X6O2aIDWFBEG2mfUKXiuXXLj0kMj/thN/h
 Lq4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ89actD336Ixe3DwZNjLJepotouoFRihJN522IakG/r4eP4SWd7Z/SdUoUnYS8uT17Z3r2reEawERA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT8DtCbPo+ldGceHm9uZb7YM8hnaxRCOcD9y9XUuLhzvPtDFtN
 VqcDu/apjFO+8T9ZP/U5XgyVlffD+n99CntK+X2e6TACkbYisUpBrXc0x1YoW1EC0RmIbGPa5Nq
 pP+J1IHJbpEwK52/+nA==
X-Received: from ejcmy11.prod.google.com ([2002:a17:906:5a4b:b0:beb:3773:86c7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e158:b0:beb:7979:47dd with SMTP id
 a640c23a62f3a-beb797959f7mr242224566b.27.1780307161830; 
 Mon, 01 Jun 2026 02:46:01 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:46:00 +0000
In-Reply-To: <20260530143541.229628-3-phasta@kernel.org>
Mime-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-3-phasta@kernel.org>
Message-ID: <ah1U2P8ppTjprYwR@google.com>
Subject: Re: [PATCH 1/4] rust: types: implement ForeignOwnable for ARef<T>
From: Alice Ryhl <aliceryhl@google.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is, 
 Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rcu@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Sat, May 30, 2026 at 04:35:09PM +0200, Philipp Stanner wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> Implement ForeignOwnable for ARef<T>, making it possible for C code to
> own an ARef<T>.
> 
> Since ARef represents shared ownership, BorrowedMut is &T rather than
> &mut T, matching the semantics of the underlying reference-counted type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
