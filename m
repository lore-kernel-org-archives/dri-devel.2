Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2DECC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FFD11260A;
	Fri, 16 Oct 2026 08:03:01 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFB211260A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:02:54 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so19253375e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792137773; cv=none;
 d=google.com; s=arc-20260327;
 b=mF2TnwdewQI0pmsDS0Efw5TwuJwD+h9pN7hSXD2J/Rd/hVC2mosLO+WMuUA5OgngN2
 rQu3YYqQfMLtiKFRnUa/grFQ2WAJHbFoOGJY6FqRTvrFKl5RlM7S1rcyDrJ0/A+xg3B1
 O6EmjkYMsuSYzJ/dZZJZV4C+790tX6UgiTugo7WJLHL4IRX3gC4cxmmjZ44x54u5K4fX
 lotEIxOLqefWez/VYaWLX5IYk6g6kLi3ecGHN65kSWQ3xTHWEBSSjf45vTZ8j68+JoXi
 a/eOaOoQsRrTWJeLNmFB/PPcqgaTy88GotqkxIVmp1cMpcvsKgfeVBWyOrTKbnpfctWK
 bbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fMgWkltWjD8XgS2rZlbHinux0fIVC/yssxPGnE703tk=;
 fh=KihA3BGmCV2XsTh83Cr2+zL1hn4PE/cGXroxMYSNsS8=;
 b=OsV7zJYTqP8tq0nVXt/3ZOEQiqGvKhhwrs4zespXx4HjV4RLnH3Rc510LuOX4PUYnl
 KYRtEDExTx9sx34UIaxxwFR+SJi9qadEP1luK8DEHEnX7drpOiYxn5ek5Amcu75BU5a4
 KWliuMPfaj7xjxGwc6GiZ0mZbgabyamKO8RcCNgwny5ZgTb45SUvOMlBuKRSIocC0429
 /DkzkUC5BgUv4ARVit3BAW5UQOFNU3COfFKVGfczXXnEQyvAHiqtsLMfAan71uVw/Rl8
 PoCyuB5zzaoeYEM1LBm9yj3ksq5P+Oq1dVSgWWtVNcW3febfFspeh5PXOyIvOfryjftK
 498w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792137773; x=1792742573;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fMgWkltWjD8XgS2rZlbHinux0fIVC/yssxPGnE703tk=;
 b=EZu9fnUVZHs4WYIvUIMoMnBzj1fMe/UVrVNWCwZKb8OowkLVEHGIdycdlyrtxQgO6D
 9XQGytpZghrXbAk/OSQA1H+79FuLcV4DvPBvOOTjoWQ8Q6YQ2t5ehTA7nSQ/CJmyg26/
 U/fmcjT+cca9YXY86Cu1XqnjEqA9oFcsgRe23RczY/3lBiKmoRjcxDw86Q5erOlxFuZI
 dNU9fjP/vFEy7X0+uMjSKJBfalaJz9hGKp/WSvT7n1Mw57qnaum7H6M0K2NDjlm2pTJt
 ybCQKWY5Qim8mrXkjFRavxqwmhb/CYlEsEaiMjuqssQUwd+Rzl5xSwy3BhGWMj/jVd1J
 X1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792137773; x=1792742573;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMgWkltWjD8XgS2rZlbHinux0fIVC/yssxPGnE703tk=;
 b=101djWBv6ATgBPYtRomNB2EZlq3Rq7q7h63sxynbm5DycRo89I1XD10yVs/XXIaYP8
 oBSsdy+LTM2kk78YeLhFuo/60JWGVd5slYFV4qMh7il30EUVLOnferqKhYy/SyE1P6L4
 2lkXE32eXZRxoUJZliNzzFa/763iQz5NvvxduQsp3AK1inu2oYkv06Y8V5hN2DWM9AUH
 t99gmJnwV99ealr9BjVKW1Cn+wNWDeKRzBoRlfERp47RZ5P2SRwDF9CSXKkPEA6xB9kZ
 j0xWOsn0PZ3CEV1pRGhatTjnTLyYK97VRQG4HLCFtnuhOax6qlreL0p1aDKs1KD9D6hc
 LtBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNXqD1wS1dELF5n+rJYgoCdQ5dyXBoiq0HSzJ7DaaFxGQ+8x+yZbP/185AXA3aKRsgb1vX0xKs+RY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhKrbaw8qAdYjvwzw68+269osELxTucFiOXZ5CjIbpIcbPuJT/
 8L8YsCxaDN60AHOu/zrLrmTovaabYx3xb3fR9lKGTPua6tGdB9B9aGMTzcQ/V5UcVHkwC68hnJt
 PK0pcLwQPWmzRYE59bbu6BYhlFShbP7nEUy4vWmZI
X-Gm-Gg: AYBFou3UrrTw4Gt3uh7eTHWKKnRaj2hwUM/ZBN3bPLBaKmYk82u9X0Bc8SIIFzN/l0R
 +F1vf/b6aaN5j4fqOu21y8oL8K4E/dl9wqRFQdQb0cVzy0FExrBScLCRq1Nqk6RdTFGwul00R6X
 pC/lWTGx8o7Ve+709ixU1b0GjjZUJyRXw+NojBcP3RclpLAccc50ZVWYvvpKD0b2MoCrHQvBsZD
 1hZxjRRVXqznP1TwBu9Fbk0he+HI6XoIh3n04Sk0SjrRSz9mHW5ywtbU8dB73RoTQUAD0Kk0m7R
 TGPO3jFE8hDdTa85GotYAucH3qOd5ROAi5gj9bZI/v10bdI0e1E7UGxFkGvf46oy2ToXRlLbfvG
 jyZ+kJoWhgY5mmmtg6k+Y7teb03AMf9ys6myRb4j6Gus9bxOhgnDK
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id
 5b1f17b1804b1-4a18e47aa9amr450721915e9.6.1792137771107; Fri, 16 Oct 2026
 01:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
 <20261015-b4-dev_query_fixes-v2-1-e3e6d25050cb@collabora.com>
In-Reply-To: <20261015-b4-dev_query_fixes-v2-1-e3e6d25050cb@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 16 Oct 2026 10:02:38 +0200
X-Gm-Features: AclHuK9VwH3E-o_Gsv9vnah3Q_w3nfSpzW3kvlPExDLV-AMTDeW1DeiF3LCmVWo
Message-ID: <CAH5fLggsJeaHfwirfaMvTUHr9rArbm8qPXiEfYiprjc9M+To+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: uaccess: add UserSliceWriter::clear()
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 15, 2026 at 8:35=E2=80=AFPM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Add a method to zero the remaining bytes in a UserSliceWriter.
>
> If userspace provides a buffer that is larger than necessary, provide
> a method to zero out the remaining UserSliceWriter buffer. This avoids
> userspace consuming potentially uninitialized memory and/or mistaking it
> for data intentionally provided by the kernel.
>
> Use the #[inline] annotation to make this clear() method available for
> inlining outside of the kernel crate.
>
> Since clear_user() is architecturally defined and may be a macro or inlin=
e
> function, add a rust helper to make clear_user() callable from rust.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
