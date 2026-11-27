Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACB606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XNr/JylU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE4C112C57;
	Fri, 27 Nov 2026 17:15:42 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E63A112C57
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 17:15:35 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so68170885e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795799733; x=1796404533;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/UfmuLP06BAHAycCguSoDWMAlj8HmLnc5qWwAUzsshs=;
 b=XNr/JylUap7XfLOAUHAGGLSn6HUZ2hSLNU7/YRzjCyw6bUePaLOvt5sFQAUOUlg/uu
 mCTq/7SDAl9mkCX7UXvQnZkex6jQoB6f/E2NwhNRol1lhabpe8LhhYriCEOztaMPcpNz
 glxizYInOZnxRqlVdfuaZ9eYqbpUs9xsSy93RIsjAdkSgZc/InP/XIuzG/RbqprhEi3m
 mtn4ZhzZl1kpYna70FpiGBQk+moCxtR2HIvvgZlbGKYXkm8RabWsCEQqnfPGC34vbr4D
 7G4QOQ4CkD+SqLlT2fiddxeWSmdL/2ViSBFNIHnDBXrDn1brjVvMSwNcD/lzW+7V5oeD
 wQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799733; x=1796404533;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UfmuLP06BAHAycCguSoDWMAlj8HmLnc5qWwAUzsshs=;
 b=DGHXFbM1FOAagxSGOwnNYNM9BruTSYpfpEgnXE2k9ZRVoFBm5Ik3KvpuPgZfgIq/qT
 bkk2UZGSrCdR7oDpx6rkHXZyPEh30J+K5xhAVq45iK4+VQCe/VAquqpAnMKZqWujZLcp
 i1NyGPivLHde9qFFIPucPqW0TS8h2C5/XtdW/8ms0ZpKI+Z2yqHLwNjv0P9KucAmF/Om
 Jg7bLNvm8UiZD/EMchBWT3/d+rYYAKpLayz4VHULkkvTgjXKq9znjLNk3cSaA3h7YCLD
 Y3bKfPmGUtHr8tYCjLGBM4xx8yBn/1jtf/cXXLZKaMJ4UiNBWWi8t7Y0b5Q28Entky/3
 +kYw==
X-Forwarded-Encrypted: i=1;
 AL+hErHtDLZdCSzzjl1e0hHojFxndhw7Ng0wLv+YOOIdFhYPu4GqdOvyXk3eBN00WpENYrYuywrkux/Q6ok=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/q3VHbhZJRjoEU5RR3Ayg3+NEl2jSQZ9tODlan/QjqpjqnJVBg
 VBOoHEgmabJX0RLDF+OWXM8iielMekMVlwts5nICiyF1P1iT4BIFndCZjxRX+NO8ntL2HNGC9Qt
 CL6DEcGST+RSAgDjA/Q==
X-Received: from wmaw11.prod.google.com ([2002:a05:600c:6d4b:b0:4ae:7292:22a7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:18:b0:4bb:abe2:bbce with SMTP id
 5b1f17b1804b1-4bbabe2bcc5mr96165705e9.29.1795799733462; 
 Fri, 27 Nov 2026 09:15:33 -0800 (PST)
Date: Fri, 27 Nov 2026 17:15:32 +0000
In-Reply-To: <20261127124107.1782-1-AeeSec@126.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261127124107.1782-1-AeeSec@126.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127171532.2097157-1-aliceryhl@google.com>
Subject: Re: [PATCH] drm/tyr: fw: fix integer overflow and inverted range
 check in Cursor
From: Alice Ryhl <aliceryhl@google.com>
To: Bilal Hashim <AeeSec@126.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 08:41:07PM +0800, Bilal Hashim wrote:
> In drivers/gpu/drm/tyr/fw/parser.rs, the firmware binary parser `Cursor`
> has two bounds-checking bugs that can panic the kernel on malformed
> firmware images:

Note that neither of these can actually trigger a panic on malformed firmware
images today. `Cursor` is private to `parser.rs`, and its callers already
guarantee these conditions:

- `view()` is only called in `parse_entry()`, which already checks
  `entry_size >= size_of::<EntryHeader>()` and computes
  `entry_end = entry_start.checked_add(entry_size)?`, so
  `self.cursor.pos() <= entry_end` always holds.
- `read()` is only called with `nbytes` in `{1, 2, 4}`, and `advance()` is
  only called with `section_hdr_size <= 248` (since `EntryHeader::size()` is
  an 8-bit field). Because `self.pos <= self.data.len() <= isize::MAX as
  usize`, `self.pos + nbytes` cannot overflow `usize` even on 32-bit systems.

Hardening `Cursor` so its bounds checks are self-contained is still nice to
have, so please reword the commit message to describe this as defensive
hardening rather than fixing a reachable kernel panic (and no `Fixes:` tag
is needed).

> @@ -144,7 +144,7 @@ impl<'a> Cursor<'a> {
>      ///
>      /// Returns an error if the advance would exceed the data bounds.
>      fn advance(&mut self, nbytes: usize) -> Result {
> -        if self.pos + nbytes > self.data.len() {
> +        let Some(end) = self.pos.checked_add(nbytes).filter(|&e| e <= self.data.len()) else {

This line fails `rustfmt --check` (please run `make LLVM=1 rustfmt`).

Alice
