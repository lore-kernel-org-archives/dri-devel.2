Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33307CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E138896C7;
	Wed, 17 Jun 2026 09:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ACskKXOl";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96B2896C7
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:54:51 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-460166910e6so2987441f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690090; cv=none;
 d=google.com; s=arc-20240605;
 b=cbU0MchW7JK1DACtI4wvQUFW3Fqc8nR2TL50Gr061yZeihjEc+CQJlx4iV30QQy0Jn
 a4HQPLyDi3hbKDEX0/V2h6rtcueqZ+BxAjTkdqs9mLEfLAIN5+EV4w882KuFrOq1qXFh
 qpdsVx2CCE+Jx8LbIUf1TsCsxdEzO/fGrhBV0dG8BO1eVJWiG6qgIrUn+QjnxuH3vCms
 gbnNYPy2Yzzgx2au7qeiEXelTh8Eadqrb7aYqFvfCfl3x5szd4hClXHzZXaGcOm9Bw32
 XwpUrTUa3Hbf0bTYNlXAXGSRGwXE19yXWTwUc+7TSqfPTyNyCNHAhWiaxpwtA1eNxyUM
 WwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
 fh=39yYwXGbsPdk1g4kqDA8C2BqSC70xJGtTt1IfgXLl78=;
 b=MSvVMMh2uWH3Qiy8B53dRU/G087ikzWs2Sj9wqTxr2Lpu6ChHUMTr/U3lHRk9k6QqR
 1wMS8B6KxUq5OsIn6NAx2EKLf9+nA15pLypTXwPVonjsHzAk++EARGcLTp/VRhpcEpk9
 NK55WTMv/4Bai4iOPbBMkQtAI8ka3C/VmBLh8kJy17V62Aj8oG3a3rXT8HfGRkcWsXNi
 ggtV9vi0nEEQ2TKP/BB7GZRWyCff0O5IeXBemmWAJbyVuhWSjMUe6N0eC5rPbclCUbCf
 e9Si7qh4evNXrzbw+ECqZi4QiNMPRS2iLYTk2tMsjjX4dh98Yba47do4/GGFeprW1m9y
 ZGLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781690090; x=1782294890;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
 b=ACskKXOlDEOJWp/UkHqQX5y4PnP8t0kuDaoq9NTE+wHvK7O0jPYUElPwtJN9hIkib7
 UG8e+sXzMnBYuo3qJb4Q3So/rejobg29n0FABG68YkY51DrBuG1IDG30pD6PK8J2jbJn
 E+wJ/oZYTXHUcG9/dxTbj9Qz3BpCONKpiqj34c1YQ20YM8NsFOMNm47SksyeisQ+qYJb
 yjxWt4jM6d4ZTkDCWXEQObAzofolsXn80naCU0ZgGKRh6hP0/1WkzN5E9zS3husClZuH
 qssrL9k597tjeUuVLjLaxYHHdCN6vj5kRqXU8BrUQQJgMt1iDeuv3z4tgPhiX89hQKWc
 BM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690090; x=1782294890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
 b=JLmTCa2+t0reLAM9zBQSZyS6f3VSLiz9LF3O9SfIRzy6DBQ1hg7SfyZ0ymIWJrJm4P
 dKt5dLxwAjDI8WQ52qQHZjoYvroKYGObIG1gxou1LPdJWjoisTg6mSg9vqbZ49yb3MqH
 fr584QhPHBlNCx4gTrN76owPWl/QFBnTe+VoSoPhOh0lTkmwcfXzw4yu8azeg6gYlqNz
 kb+PqUPmC4oIsFFGpziK+wGAI/fv0yodHZ/OQpb/zgAIdyx32ZPGRYWmyZwB5pZo/r2K
 tuFZfPWFzmzwxGLxO7WlyeiwqzTkaltr4DEXJXxBU+aFrZsZpbUAuFsMJ6zHKvq+qXse
 U4sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/65KbA1fMnXxuj9SeWjMPkvXItEr7SPd8O2MrVy4TJiiT5SqqyOnRGy0z10Tol2SPDdBN6mJrbcjk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2+U2ExK23+Q/A2pYDduDOP9yN4MAD1dQ6gCt4nlm/DXSX0Omo
 b2mMGcgrqIqB/8fWslMyfoxEGW/gATLq/LgaVn11HBL2s+VsfB5XIxE3WXKswfLLB0Dg1d5hHoQ
 wQjSQBtU+VuKtJQfI6E+gFYzFkh6u3zL2ehmuVzS7
X-Gm-Gg: AfdE7clASDeQGQ/MnsUA9XKnWz9Z9qqTCqkuaN/rUuacmFD98lJPrJnwDdXhP18TPpK
 G5qkwlgljzDlZdMy++FrbuIuEmLbBDzVxzWRFpcnP7CYDo6xWGud2T2X2ZV51vAoqlvDYCWXRI8
 BKCHTQ6Jgyh7AEbTjN9WOphcikWABxzmLV6gRHSE+k3V2TOzG5ejCdOq/iXKrjmrSN/hm1pPUFL
 B9Wk6k3vn2+7DrfKV7YYzDFrSL7djgFakAf9aYm+HPWCps8QIr69kgZtTM5KVVWtsjEqlRFxFWU
 oL56NfHNJas/udoVdS3hkd6Sy1/2OCpoOpt00C/xRWDxv6Xc9BQkBhTzMqM=
X-Received: by 2002:a5d:4a91:0:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-462376a4df0mr4361735f8f.19.1781690089839; Wed, 17 Jun 2026
 02:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Jun 2026 11:54:37 +0200
X-Gm-Features: AVVi8CfPlpZsDlv9ciJ6wpjG8CPXMs720UTUcxwfh8qgpqFIXUpU1m_9T99wYrA
Message-ID: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
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

On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This will not compile unless Rust Binder is also updated.

Alice
