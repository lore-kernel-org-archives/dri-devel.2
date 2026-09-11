Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE04C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5792310F5D1;
	Fri, 11 Sep 2026 13:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fS7c78qD";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52C410E35B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso11540425e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
 d=google.com; s=arc-20260327;
 b=UD7E89KF7512iMltTKMsq5O5HEWbLKspvb/McOBA5gh5Quy4ZZeMPvzkKC7/fM2kvD
 6mHjTJpfjZxkm95dCIAdR2FsrSOSM9a8SH91qhWRbV9Xi2lNpPe9ugBMwwjGQh4qybM3
 Pq1DWkoLBaNpILvM6amYjNQZ40KmSkDM/YKXlKs43tbQXuCklavfN6YgQE8sdZowe6tN
 jOdVQZZ3rYxLllkKWO9v3BPuegtgjKBHT1ZLa8C/DWVtR3XjrW6wOXvUvAZeGcfkPET0
 5KLg4q5fLSYAiiNmcf0XVVL/XmwVqUEnJbzTmeWHVwVwku2+dKItCzuiTTn3hHmix4tb
 ho8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
 fh=AUySHYSl/cdDY2y6eBHYQ/5ZxiiG9Q0ziSQnJNxDsOk=;
 b=kP7E1JtDnuXx2LRdZ6dEOgxahmdDjs85zLK0RRH45Mw6hraOMZtKtkqhjVpKZV6olH
 kUVZksDWHym7xVetLGEVcbHY/hoC+AQBWVtQU1cfk6DGd90T8Qc1xtpZulQ7MXanRGz0
 t8MRF0khmrXNM9M8F/RbXhdjXGG9d60ZfYh2rv0NbTCui8xW56PMg2rCKIqpOSFsqdCk
 dIX9iIwMIAMWSaCxA84B7E741K1lhLh3hb4+JOVSjEw3s9BfnBJPZmhUvSFdZR/TNEXK
 3ejVRv8VzK+VRClBOycnZ/uQuWmhDX3FL8VI+Pc1OWZmmNO7IBZVSBkxQBGlAvXE07Zx
 Gy0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789134210; x=1789739010;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
 b=fS7c78qD/1tkUjBcs89FZyNA8HIyn9tBhmy6n0EHy8i9FlR84OkFjOcpT1n9RRHjXo
 JmA+FQtuo66Mcb8+MWscnh6BpNHLja5mKcbre+l5RJyUE72XYBTeM9rGG3j8szRUd3Ih
 dWZQmgkgnf8Y1dm58zHYRW1qhkzZYSaYrKZXvvuXyjdunTQJwHiLmM47FmdWeLAljyuo
 AxJ1DDD4Yd5vc34hJs9t27Lx7nDakjTJmeZY5+9xABjt8q8Fi+VoqzmXR41w17Mi6Lui
 /M6EG4LxNQ595yU0Q2dArWs2fjYlGxYJ5v2udBM/Z1ATIs3BkLXNVhMsyHgGeXEBdKVT
 nV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789134210; x=1789739010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
 b=Zl6B+l58aY8I0HSZ/1Bu0Q2t3WhAGEJ4Rp2FO8Ukddps1S9WZxkf+70vkJzJ7R4l1M
 Md2VU99davQ7s1HDBwXl9G1nZEyQAZe7VMC5Vzec3zLkyCmzyZtg01pnVLZvmj65v5hY
 WpTqnWMWq54FVXoarTp4ajiMld0aJ25zM5v6Du/NbjLL6z7gW/KA++aFDzFBDj4sjTEm
 jID26tT/POmwLP6stya7tv+b/CJ7sHteGExcEhF07OUq9FR0cB3l5fAnyWwNI9MjTGJp
 7tEJISSGWH+mkZugLwtiQZFUE/4xuUejpi08Pki/c6RVkQJfS/7m1Tb3CP3PATmCQCe+
 7oDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4aP3mHDpYkCMhVesaqp2EMB1MKKF55dboIe5Kxkhu6LTq85FcL24VVENw1kcc/ACNnGelO4Ld5fE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7RP5Gsq51dTVcVtR4SQxFKpl4/Sob5g48xmHZEx3O1FcMgIEV
 jTFn04Hm29dZb9yBfBSlXH3/SiT9I+DjYyHTumYqzF5eITYxK9aMCSZqn3xNnZv4EY1+S4byCNL
 3cM05hLReekyBNzvDDSyS2iTKPcmT7wLdRjvj96wB
X-Gm-Gg: AYBFou1wFRv0FN1MITMCsluRaNqi4LFma3BvBlDyQzz7Q7w6Ra0TfItLkwVhaMxssI1
 hhhm1BHPmEtZDx+w5yngMHqWkvPjJ+j4aMQKYVqeyI60Se501XTE2RmXoL98mgfmYX1wT3T1Wgu
 NyhNN9uKRW0q4oEfMk7PkpOFc8rbviwTGG4TUAyRKFoJc02PmKjWnPsAo9S1GfX60AOaVL6yshZ
 ebZHRiHXR18nZBOiGlJXCCk2dD7TbTg6SoHeiyM7c4UUxeEka2FpUzT7J+vky2DeBrcQ4Ho5wGt
 0NZgb4wQvZW2IZOTevhVfqwP0YriU7YlneqqE7qmglXwFDQSNwzFm/Fqk8cwUKg+mV8PuuCVH3F
 Ri+cVhTaDWVBHDAFaoEStD6hwHWiBCGivD/rSdY98bTZAD2DJncPM
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
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

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
