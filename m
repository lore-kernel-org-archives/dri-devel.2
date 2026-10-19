Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C102CCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491F310E812;
	Mon, 19 Oct 2026 08:02:09 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2401B10E85C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:02:03 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1895ffc83so13304665e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792396921; x=1793001721;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G0t3iuUoGIZRca4fYcmBoqCEhSRJmAHTnYpYvfOnYow=;
 b=F3sAAKRtQT6IjyhKUmbN9XCYBElDlroUbAOmZQieH2uWEkDRT4s5SyKPhzYPOplM3J
 PfRGbO5LQBfvH2xsPZZhS3TeE32KT1uDY4qGLMZQXiMoUZGD9tflflUaY1qYDIcqDmoO
 ZljlKq9TncTe6z11VaS2JJ1P7fOvrOXqBiXhl9ir8PkPyiImKNLPt+is2SFPzNZumo+F
 dAlq/6rf4DnBwgHGK8MuxiRJRotnHm8pE5DM+9hlOzD5g5XDDceFO37qsqH/lmQIRy13
 yexKD4Xiv5kOM/JIEdrHvfVr8ZBjWVGEvMCoB2vmP0bXBeB7hFs2exUed7V59mX+uPIr
 CDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792396921; x=1793001721;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G0t3iuUoGIZRca4fYcmBoqCEhSRJmAHTnYpYvfOnYow=;
 b=2eVyeFI/q114WovDo0V3XWfiZ+ry4BUJRPzWZ7IDXLI+pMHn7b7/AsbTcitv3CAxqt
 EG2CIbp6H2H4M3lMppHLfD1MKZ69QNxtq9zwIBzQKYPoGoYgmKSYCh5CP/doFF5NQP1r
 tSv3tpmOIM2JnZAphhCyz/Hq5N44761j45KgUzPJdhUS/FQ6t33lKsHjM5OsHw1Ye2rI
 pIC1dsFB2MzltF1jlKWff+eWEnu90PEOuIh5TX26KVJoconQlGwCQUxh7TeKlCgwaXzw
 DOkRmkpVyChg57vKw4im6ahXQpqERgpFVz6SN2HftY2SPlUIKjQ1B07TYXI8aQSoBO1A
 9ISA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXpUOqPz52Wiyl4kbqCAoJnQL6oqCdS7JCj5uZgXXKm/Yo09XoOWfm2SqC81va5awxWVSb5H07+NM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKGOc0Fy7I47Z0WrfeHGss8AM3zIzb+wkfCEd0Mcm+A5hBi430U
 57CXCvprBgJLO/rjus91bCr4nZV62uOWDI75fqYV/oMcFptPJf4FXOVuna6lYSZK0kOFlhN0y5M
 6GaP8rLnKmO7BXI9cRA==
X-Received: from wmjk23.prod.google.com ([2002:a7b:c317:0:b0:4a1:c221:789b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a1d7615cb9mr143326165e9.17.1792396921174; 
 Mon, 19 Oct 2026 01:02:01 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:01:59 +0000
In-Reply-To: <20261016-b4-dev_query_fixes-v3-2-f8071cda3515@collabora.com>
Mime-Version: 1.0
References: <20261016-b4-dev_query_fixes-v3-0-f8071cda3515@collabora.com>
 <20261016-b4-dev_query_fixes-v3-2-f8071cda3515@collabora.com>
Message-ID: <atXOd-EeFkdA-trn@google.com>
Subject: Re: [PATCH v3 2/2] drm/tyr: allow userspace buffers to be mismatched
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

On Fri, Oct 16, 2026 at 01:44:21PM -0700, Deborah Brouwer wrote:
> Allow userspace to provide a buffer that is smaller or larger than the
> object that the kernel expects to write into it.
> 
> Set a minimum buffer size to match those in PANTHOR_UOBJ_MIN_SIZE. If
> userspace provides at least the minimum buffer size, then simply write
> until the buffer is full.
> 
> If userspace provides a larger buffer than necessary, then zero out the
> remaining buffer.
> 
> This ensures UAPI compatibility with Panthor.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  drivers/gpu/drm/tyr/file.rs | 47 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 9f60a90d4948..a153aa453ed1 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -1,11 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  
> +use core::mem::{
> +    offset_of,
> +    size_of_val, //
> +};

size_of_val is present in kernel::prelude::* and does not need explicit
import.

> +    transmute::AsBytes,

Use the trait from zerocopy instead.

> +    let mut writer = UserSlice::new(UserPtr::from_addr(usr_dst as usize), size).writer();

On 32-bit this will truncate upper bits. I guess that probably matches
what Panthor does. Is it what we want?

Alice
