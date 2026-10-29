Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F3606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ccPKuG96
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07093112303;
	Thu, 29 Oct 2026 14:06:19 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6FA112303
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:06:12 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-353804b591eso3341991eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282772; cv=none;
 d=google.com; s=arc-20260327;
 b=YO8iF6J8ZMj0ZFqyiGmaO0kWOv/CBu3YiHD0LtKuowJaQpS6CGAXMqg+JitKke0hrv
 4hlVHcJAjbfoKo19urDxdigG54Y2UO9mVNc7rTTmTxZoh8ww7I/fiRACsEBolf2Fp0q6
 qV8Jw8mzbvsDskTG6EPuZX2q5JmqkFhhqKDTMZPK7Mlr5fYzTK1Q5IyTamCfXf3mSIOm
 1FIgbMhKewQXYj6HHtx6WP/geJRhs5ke67Dn0f4v5JHH7zRBjcg6gsDwoRLnP2wJe8mI
 sXkQk5H24SpHrK64lNkAgLGVCs2u0z1CbshA6rz6LV8mT6pLuO+pm5oNppv/tySsTebz
 elGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5AFMA62x81Eod9qLhy82JE4hw8ngyRnLnh0416nT1Yg=;
 fh=tsx+9kNHUNf2kPX4aPTk447QhImsXpR/zGIb5L55U8o=;
 b=LDaGG1wYzdLvtjLnTHINx9rPHRlIiOe2xkZFmFeqHfwPt088TCIu7blE9PaLCQdOw7
 CzitZ9o7RgD3V9Drt6NnM39W2AYc46E4+7Cg3JpHG/66bvfOWAJyxzprTV3LGwrd5ldS
 Htn7RrGXsmHRS5kA7lQ/83whvmVVJOU8HLvK4sGZY2pNCycH/wuGWsRm2VmOAB7ZxdoL
 4CI8MNFao90TvTQ/v56VEBWI2dgjxrjRdN3A11ktL1NgU5i55UR3XtfeHC6K4NVTHtj/
 gmNFwLuywI6LP7S783rNRbL4XcF92YEKwYlGpbw0B44LkFgq3iLuwVtUAYGvPwK/HQcz
 0sNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793282772; x=1793887572;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5AFMA62x81Eod9qLhy82JE4hw8ngyRnLnh0416nT1Yg=;
 b=ccPKuG96GNL7dExyfVZJvCK8kbUw3a5no9uA7PnUZpXOdoMzFx0baG+I6wshwX5X6G
 JgXxsDc69GBbH2sAGygI06RHvcCP8y3Sj/OlXjdh8QLp4KGt/d6sTU2MMGhZ6VkC39NG
 PSAVFDS09wFu2ZkwWdpwshK2ya8ccLUGcV/7V40RhVhqDvKGMaKUCivhQisM8kAI5aBP
 s2DBOWnVQ5ZQLcdUzdJqEUp1lP8Of4VbmsgtHnDmA6dE0UrnUPoNQPsgvgQMZRnNUYBV
 vyXWSeT7VYIXHSGbPrjGUSMdXzmHuZstECy7MDSki9ztvfucKC4bIXajKD1SkBOpktVC
 Hl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282772; x=1793887572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5AFMA62x81Eod9qLhy82JE4hw8ngyRnLnh0416nT1Yg=;
 b=fD6REO2phyWnwKVIvqWFIyXzWRGv56cq0b/NF9NcuT2lroEp4gV/i6TJ7w3ZGsPWuv
 sw0gZHkSeRMnbPCj0AIdlWjXTuowBqlTFTjN9XdF0SoLW3uem6H81vqGOc9+QH93Twmu
 J6ynskeb5SzinpqRLZFNAFf0LUsmDbcc/fYklSwqeL/34UH1gtqkQSMpl8wP+XBXxNrB
 vvC0dbW4TYp3xFQsZb8zCFhfK2mHATVJYC8VfKdzSdaCiRREUJMywchGwrRe5GvwUzze
 fvDoZEJXsdstqNXmNTkyYtP8lUpISYyMYV3W+jWtCPTeUkcWdqUVpfKPAeRuro/gCsVm
 sq7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJBqSlapQSX59c87VGNgkQcHORxvdZ9QVXpR71SPa4QHZL1NDv5apW1UGh9AAvkNSFcWHPZAylrEw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIt7sH0CsDCTO6g2g7KgBd+AGGSy1G5Acwui4o/yjLJ+DvKryu+
 B336P0xES8kut0igkM5Gz57iZ5cvlQWkmQtPEZsZBGbxhPOekcO9LgnJWvYNSRmm9Y8IstZ1w5r
 sw58mIEqwpQEmGep9OBzkiHRI4E3iN9cf9YXstUtv
X-Gm-Gg: AYBFou3tdAx5kINa6RVGufqAkGBkghEYT0zaFC/u4v63IflgOMUBq8CbNfwAhBwKwZi
 eHe3tHfmdyQkQUgYg0291+N2lssiy1LlqqQvZgLuPFQ9dZKzEmUL4liTXhEkvNy5MGDW6r9ErEB
 BAWOjV2to0dC05oTAMvL+Q7URdaUwZKsezx2Hb0C/njSVVd4cz69rF+dKRzWlD2tb+x/SHwe7l6
 M5muzs+G0bQbbr24COVnngvAuON22EXT4ZnflvorLkDODkSqTYskQbKnGPZQfV+0SoCEBrLX4CB
 PhGjOUl/8ZDVqlIJ++/BLuYqjUJji/zoF0JJd/s0tFelK74rGWpq7TUMi5VGYx+Ju8bCVY7JA9C
 83EBuQyqnj4m24oTGutYY3rHA3MQvFTnv0x+/UuMGxN5RzLpARiuBdxFRenNCCXHERmFicYSnay
 6Dk43r9aMLWnUNqzoeSNhKREpyvPn/xQnwg5ZbPbOEaew2j3ewYl4e7WEzSo/gBwQw
X-Received: by 2002:a05:693c:87d0:20b0:369:daea:812a with SMTP id
 5a478bee46e88-36a203e04ebmr7980604eec.30.1793282771027; Thu, 29 Oct 2026
 07:06:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022162116.2282295-2-phasta@kernel.org>
In-Reply-To: <20261022162116.2282295-2-phasta@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 29 Oct 2026 15:05:53 +0100
X-Gm-Features: AclHuK_SoizvoU1-Dr6Iy33-0wETUO3c6OG-X77GiKNsKuJD9voK4ASEhNNET7I
Message-ID: <CAH5fLgiDRJuid2usngucBVNd4tP3R6Xavx-WWoKpN7xMQqv+zQ@mail.gmail.com>
Subject: Re: [PATCH] rust: DmaFence: Implement Deref for FenceContext
To: Philipp Stanner <phasta@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 6:21=E2=80=AFPM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> A FenceContext carries data, which the user should be able to access.
>
> Implement Deref for FenceContext.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
