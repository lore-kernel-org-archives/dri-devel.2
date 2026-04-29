Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670B6FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C24710EE73;
	Wed, 29 Apr 2026 06:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Z+ji2JxO";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D659210EE72
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:08:59 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so7024518f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 23:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777442938; cv=none;
 d=google.com; s=arc-20240605;
 b=C8QMipC+Nunca0zKCZRGEdKO7g0KGwXuaCtSaZcESESUNKNHQ3iNmGCcGZyovvJYKW
 WjDKE616LzVwtqL4F6/9MEcbtlAavO1iYKPQfXiW3jz6euHCqnOkWkhOzzhePmK0wpOo
 qW5W8mCNIlGhiTeoqgaJKK5jtgQwETB7B4HiHjSkPAwxR8X1pPMimN7GtsYB78THzHHo
 ohxAK7rvMCrHBHBWdnTF3UDwNPBOcsPsVYZ8vGzfXuAnRydqS59cniHnDywDNSFonHy1
 VjVTKZ+5ivBEmCDhGqQn8DYAujEHSeVw4SuEc3Nzj+RxOnL16BmFD7f9ggoetQJtrm/q
 iZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FYU7pE3gVxxvkAEdh+WGXrAzl34zV58wn+9SKSc2ScE=;
 fh=jMlrBYE474hbJkHb9+tReG6xT1GLbaWyNHLNL385Y7A=;
 b=ZTxdPbdb+0USSCKomH6Fnm3lp/k5WEU6IP97MflWv1LRriGXxPT+sukuNBb+Pd/zbI
 SH+dCQNC5uHpUH7j+3rPP9EpuC6BL8AT1tabEyhRXmGzPgFcwtjlWFCJnVAqwgJh1Ds0
 Jzzwn/1fDuXjZY9HsKqcUVBCN0+8jbO9ubSiWM53FxzJMiq13OgBb4U4fMX0FduTuuwL
 1QmYkGaej21Ep41DpUBDg2BXZmWxFavF458RT56WOEtIL9d1wF5Gh86avLmTHfLrGY+Z
 8KC2OjjE7dwnI7BkjFU2przB3FLip4LSeVgrP3cHezjSB1Oy7LuFIlEueuNzmYo4ynB3
 lmiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777442938; x=1778047738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYU7pE3gVxxvkAEdh+WGXrAzl34zV58wn+9SKSc2ScE=;
 b=Z+ji2JxOODtSqYHZBxzdRbDP9fYPL+8m2Tb25Qii51L5cHQvpxI2N+653V6z7Fd+fh
 Z3oeQmhZsykY2VGqWBuT+5vJw3B2l6PDbLEBE+rC4gabWKRFriMZJCZP+HllyLDwqLcw
 VfwPNVyfeON8qXN47H89nL1f1unYrFzTbn1f3LUS7ZldSlmY8zBMu+XZs6nYLNPWNgPW
 Q1wjIASzWK3+wH2c8XcD47xsNo3FccAATywPqpF39g7qcjuJeZXkumKWdFmcLN5cibGU
 Cbccm+ufwni4uNCm5lelWJX7tF1wAyx0z6a8ejqt6636Y08yArEZOOuwKa38aZ/rtiC+
 E/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777442938; x=1778047738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FYU7pE3gVxxvkAEdh+WGXrAzl34zV58wn+9SKSc2ScE=;
 b=hQdggNR/mCh+yhg9Of0LtpsOuL7xtaTE6KORFTr34A2pYS69N6oaUd+YBVSzbN+JMB
 JuRW+ctgCQJMY6RT7TAywps7b7HAp9NBWJTGTqGr6mOS4m7TCrbLn23Jml0Gc5wOFG0S
 7UYVtHzkaQdEBUTDjFSnLlpLj+TAq0Ej5hgXyiBEitAHDTbzhbEZon4tHtPWM+GmAo/i
 IZ5Pbnc8WC/khWsU5JMQYHyMrmS9RvtFrWWR3J8utJcym19rWMuJbPL7C73AWpwR1x7v
 3zUujOXRYbH9ax3Ta3IB2RDt/uymjWojjNjt6aIbKhD3FDzdVgoxGIZKyHQxeYcIrRhb
 xbzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/44zvKR40FmAvoIKsk/n95D+EHxKSKii5i0QSChucNyy8FqBhXV4OP0r9TsSlDVuTDWiG6HM6uQFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywmCa51s8Qb4yijMYsze15SnKFcSCf5Lrgwa7Fgbnim2Yy2621
 4mfGe+RdWBDqc34lZRWXMNq26TQK4Gd6R3OquGWTJ4wfy4ZnmLfNIaLxx5H8cGd/P31/2xPC8yW
 8NNIMY00evlkke//SN09gYcFk31oqGXl0+51XyUnx
X-Gm-Gg: AeBDieuZzZskqCjHkelSHS2JNWR6eC+krE3mAC/3i0YezmOBkJbpGjdj5KQ0YStqVr3
 DhHy5MHGIchhQ4NmWNXxX9ATwKnHKHrQimVgw9xOoZcEYoHkL+78zVN4S58dUi3U2OWYSxY/QPE
 OH4jnzysFKwjNn9vDfYQHzIYBM1POgl2jSx6PfvyaSrneDUF5ucknaPuASVR/7xUiNUZ2Bpy8Oz
 RCkMMv0Wd/nMhY8vCr4jWUWHdEKCmjGLfvBiEZ0m8q9pygjMk9fuuuTfCOXDhdGqWX3uOja4dXm
 kFnqZdS0Cp0iSMjfazi81CjLgIfwDG8+sXHKvhDfGDR63L+Y/d5uGo0zh4s=
X-Received: by 2002:a05:6000:430a:b0:43e:aa88:f1a1 with SMTP id
 ffacd0b85a97d-4464a446fe6mr11181446f8f.30.1777442937776; Tue, 28 Apr 2026
 23:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
In-Reply-To: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 29 Apr 2026 08:08:45 +0200
X-Gm-Features: AVHnY4KpyMxlVfytNzH1PtMjfsVrbyhjVM6FaSYXLynKs8xxxgKqJH2pyxGWTTQ
Message-ID: <CAH5fLgjU+uUXzjAsa=ZaQhgNJi_Qa2Nc7mEC3HJCpr2vxOFEEw@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/tyr: prereqs for firmware loading and MCU boot
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, work@onurozkan.dev, alvin.sun@linux.dev
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

On Tue, Apr 28, 2026 at 9:20=E2=80=AFPM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> This series extracts patches from the Tyr firmware boot series that have
> no additional prerequisites and can be applied directly to drm-rust-next.
>
> Most of the patches are unchanged from the fw-boot series, except
> "drm/tyr: use shmem GEM object type in TyrDrmDriver"
> which now also selects RUST_DRM_GEM_SHMEM_HELPER in Kconfig.
>
> Link to [PATCH v4 00/20] drm/tyr: firmware loading and MCU boot support
> - https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-0-a5d9=
1050789d@collabora.com/
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Alvin Sun (1):
>       drm/tyr: use shmem GEM object type in TyrDrmDriver
>
> Beata Michalska (1):
>       drm/tyr: set DMA mask using GPU physical address
>
> Boris Brezillon (1):
>       drm/tyr: rename TyrObject to BoData
>
> Deborah Brouwer (2):
>       drm/tyr: move clock cleanup into Clocks Drop impl
>       drm/tyr: add shmem backing for GEM objects

These commits look good to me. I will pick them up in a few days
unless anybody else complains.

Alice
