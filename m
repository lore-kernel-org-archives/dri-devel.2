Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F2606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DzYdy9e+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2217D112AF5;
	Fri, 23 Oct 2026 11:53:40 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AAC112AF5
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 11:53:33 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a2000d5ebeso6103225e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792756411; x=1793361211;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uLj6FN5zzpYaXQgmzegMg+GrSB746kgYZ/YLy03P7lg=;
 b=DzYdy9e++RPryOhZpj4nm2tQz/jMc7pjd40Wr7qlFb3k5QparY6eX/bx8R3mIvi4I4
 YcqNlCsYISwStGwWwKA8aqwlWzczO5tce40WsvnxA2EplCdffVOf8WVWDvNGy4BiXjjW
 Jl/8RXb8dD4lzZhIz5JFI3oQKvGM7le+UGUQhEEBd51o8zS5qZZkUmEjKdlqC4Gfop7p
 B+GJDoliQ3g/BO00uyTUiAoqe3gG47ncWrcLuGAGdS8JK74QapjOx+5f4+QBxYb9+R09
 qCk2eBRg+pDOrELlvnKEn7Tbkf18tXJKsj9A4rzFhlcDjf8cofCwpfqwI3qSxJSg6zt7
 7FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792756411; x=1793361211;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uLj6FN5zzpYaXQgmzegMg+GrSB746kgYZ/YLy03P7lg=;
 b=lOUgLlZDjRdS6LBl4c6rR/bFmCCDW+9gdT6oar5gHrezB1+7rAusqSCWmQkQb2eUJs
 ykoPKOtjXc7Y7SkTr6420Wsw4smpRdDiEXeCYTkIDYpKCAleM7E4ICIC99J7JOdnziLZ
 NtJ4KIcKqvXY5qxKDUlWO/VBvaPb2uNhPqDP0PbpLrdv6miuVfYvfXlC1grzYSuvHGIy
 bBsN19cQYJF2tm66Z3T/61XSyuQUGVUUd8w3+jz/9L+ZrhlhwedIxwqecPS1XO7Q20rZ
 7Jcx9tenPwDNVQgXB/yCwN5GiFbvS/KBFErCJLhkCXIJcG29cfuXjbrCHYxdIUs+aGiK
 7q/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFJsDjeVbTYQOfj9/izJtINu1bIhhr8YA56hz3UviiyqZeA8YzAo4p5Wz0656HBVi8sqihpj7NWb0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ10ZOT+N7LH+O7RHiZbbGwxycXjo8JNOml+zmIazlJAI3yNlIy
 1NSwyihJdDhbmaJ63FEZkx4ArsxWgYqk8Ua/U5M2XTlZTApL2Di9zqZZV8pZbM1WyZmpoDSscSq
 l8752wOeqBhILwbBONg==
X-Received: from wmoh19.prod.google.com ([2002:a05:600c:3153:b0:4a1:8915:6ed2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8a:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a211ee9b8amr34064815e9.12.1792756410725; 
 Fri, 23 Oct 2026 04:53:30 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:53:26 +0000
In-Reply-To: <atqh41vrlC4xVtaj@um790>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
 <20261020-tyr-ioctls-v4-2-704de77da223@kylinos.cn> <atqh41vrlC4xVtaj@um790>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023115327.1776353-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 02/11] rust: mm: add `task_size` helper
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>, Ke Sun <sunke@kylinos.cn>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, 
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 04:53:07PM -0700, Deborah Brouwer wrote:
> On Tue, Oct 20, 2026 at 04:25:19PM +0800, Ke Sun wrote:
> > From: Alvin Sun <alvin.sun@linux.dev>
> 
> I was testing Tyr's auto allocation for the user va range,
> and was surprised to see that mm.task_size() is always returning 0.
> It seems like it should work since it uses the task_size from
> struct mm_struct, but it doesn't, at least for me. 
> 
> If you look at tyr-dev, I think it would be better to use Sami's approach:
>   428d71932b6f rust: task: add task_size()
> 
> Sami creates a task_size() method for CurrentTask which is our equivalent
> to the `current` global and then you can see that task_size becomes much
> more clearly the equivalent of "TASK_SIZE_OF" used by panthor.
> 
> This approach also correctly returns a user va range when Tyr has to
> assign it in my tests, so let's switch over.

+1 to switching to CurrentTask::task_size(&self) backed by a C helper
calling TASK_SIZE_OF(current). Please also include `<linux/mm.h>` in
`rust/helpers/task.c`, as on some architectures (e.g. riscv) `TASK_SIZE` is
defined in `<asm/pgtable.h>` rather than `<linux/sched/task.h>`.

Alice
