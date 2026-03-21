Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1855EC01A4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F85510E41B;
	Mon, 23 Mar 2026 08:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kucJdISX";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8435010E2FC
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 23:22:14 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c107ef474fso2727458eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774135334; x=1774740134; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmSlASJxZ4qJNq9Ag8r4ipXI8Q0Axl649+ut2f+sZl0=;
 b=kucJdISXJT9np2bghB/MyjCSdDG5CYB31V+2IfY5Fd2ijZEj2YeqB0LWtQtgWsEat1
 mwufcKpzD4LMNnU+M0upbMGGJAFZ9whKSpaMRAuvi7cV3FSQXZutxLywASlUnEcB02Nb
 TBYi5VPBIVbER65SGz05ZCK9n3VIMzn0SZvEwXWPlgbwXddSSjiLN7FeZMQGVVwieDDr
 THZsFoF7wKDrK50L/xjdQqu2YJuMM9GMnJLSGitIBxGT1dmdNppvrWmNGxoyDyyw22X+
 N5drme/oZOXiRakrjebiMIPgzdJtDEdom5P/Nkcj82cLTqdgaTaeii6UMaNWiqLq/hld
 uK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774135334; x=1774740134;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UmSlASJxZ4qJNq9Ag8r4ipXI8Q0Axl649+ut2f+sZl0=;
 b=TvSeIO1fJ8YjrbLYKElLdshQ0P5gAEskmpoStTLIWzzPYNSTJA+Cd0DmJKCtD4iqGz
 nDbSbdrkEjllzWq8SUqHau3EfcnhXU6xUrp7IRh0uYl6Zo/6FiBuU/qrg+Qc3PZOmiR6
 aSwUmj2SV98kyo6TuHkBN2xQ/+tAYhWj3TBBXY/WGiONYsx/kg6N0/i3NOqu52naHFPQ
 zbCRXa0yCzCk7XXzFZBsIwuHFO/lWMqYCsHRfGe6BTzX+eHjqDMsuzOEjCd7bPhimn4P
 7EK2aLoceuNokmPZwWo1lS+Oi79mkekMN8weNl9G8NZy5oyF7WQdCbQnTAk9n09J7FIn
 n9tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC73o8rGJsCEocomK0Vjj14D9B6H94FPVtvhLDiEvPqlWzMF5HSY42mF0tjx2rt5VVIdXmLJSdVQw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjRwFlMfj8BtOyfujEGkOnH/C877zjkMFV2f3Ctm8LUvLV76b1
 J6LBx1njxsvEuZfHg3q2ZRJTxF6T04GWLU7CthGIvr6mrcJHk3UK4sAi
X-Gm-Gg: ATEYQzxy/mzmlfUL0n4OkPB+YHYhw9ooutNqgPVODCnV8h8Hynltt8iMxITQi4zSuXB
 c+vGjmGFDpK5E2nqVAMA8A73EOoEzK4Rg0KiJQH6/9SeD8znbVbxliGjIF/g9EAbVp0hFLu0vhS
 mW8woSxpKdC3e5vBvjnK+Frqv9TgDroHtmOw2E2oNG1yCPGv2fUgdVlcZQR8bsMpn/g1uDHJc7d
 J8Pn//H1LPsPtzvAUdvaYclILXJOUFNpI+c4bajfipsly3htnoa3Awa/QIAbQ01cw7ZcrAqMj6+
 0LwGR+QoxXib0EPK/Gz63O/lfmvi5Zibcq2lwIAjRpPCq9vaBxfw3W33f4afd9ELFUqHFjoOWh0
 AMCsljRpSM+OiXHs+5dRS2wzZFJmfKYl+v6L5iMgFZpewPnJy5EVYpToPYVB5aWqFcBL/YTrIdF
 7gqF/Xo+V+FQT/xnudqn0laYxQieRBL7ykZVmC7vkExGvZ
X-Received: by 2002:a05:7300:3c05:b0:2be:140c:bc4a with SMTP id
 5a478bee46e88-2c1095d7855mr4154948eec.3.1774135333601; 
 Sat, 21 Mar 2026 16:22:13 -0700 (PDT)
Received: from localhost ([2603:8000:bb00:9b3f::18f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14bac4sm10927970eec.4.2026.03.21.16.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 16:22:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 16:22:09 -0700
Message-Id: <DH8UHISTLOA4.934370PUTLB4@gmail.com>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] rust: dma: add generalized container for types
 other than slices
From: "Aditya Rajan" <adi.dev.github@gmail.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-3-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-3-dakr@kernel.org>
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

On Fri Mar 20, 2026 at 12:45 PM PDT, Danilo Krummrich wrote:
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 2eea7e2f8f04..ff3e147f1a23 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> +impl<T> Coherent<[T]> {
>      /// Returns the number of elements `T` in this allocation.
>      ///
>      /// Note that this is not the size of the allocation in bytes, which=
 is provided by
>      /// [`Self::size`].
> -    pub fn count(&self) -> usize {
> -        self.count
There is still a mention of `self.count` in the safety comments; perhaps th=
at should be changed to `self.len()` ?
For example, see the safety comments in the following functions: `as_slice`=
, `as_slice_mut`, and `write` in same file.
