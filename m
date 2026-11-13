Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B01606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdHvpMVO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED2B10E28D;
	Fri, 13 Nov 2026 03:21:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF00D10E28D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:21:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A16A241B05;
 Fri, 13 Nov 2026 03:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FB1F000C4;
 Fri, 13 Nov 2026 03:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794540067;
 bh=nBJkOQ2q2zXYUFL1OoXZyx/MF8UrYnWwNyMJqNuazjo=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=CdHvpMVOGwgKWscIuQ8A3utOk5wIvk9pNV3isIPQKIVvP7qZLeQ09PPM1jl4OCfW2
 GnUpjRI1szJQFZaPeZ4oPKHZjBrS9FnBX2IOPHP4Ds5ua/kdAc3nbEJBMTCESILE/6
 EKNPtRM+cn2/pwdfWkcTyAUB2a4PHTgFazJuX+2f+YdI+jSzMkluOoza4b7UIf2Em+
 6f4fUNzWKC4IjewaQSSmLyvjaZUE8eCur7GUBd/ScTZPZo40bSv/0KAbSPBoPbC/fx
 kVa86sjSwKHykASdtIzY1XVv4hjnOLJOg2EhiGyJfrtzJsmYEKscZY/ABX3CXLdAVt
 XLyxF1OnKFCYQ==
Content-Type: multipart/mixed; boundary="===============5694792853191233504=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <964189cada1029ecd88ceace91964d377836638fc7796c40636426b1d2ccbe00@mail.kernel.org>
In-Reply-To: <20261113024447.922683-2-k.chen@smail.nju.edu.cn>
References: <20261113024447.922683-2-k.chen@smail.nju.edu.cn>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test that a drained dmabuf
 iterator keeps returning NULL
From: bot+bpf-ci@kernel.org
To: k.chen@smail.nju.edu.cn, yonghong.song@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, tjmercier@google.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 03:21:05 +0000 (UTC)
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5694792853191233504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL

TL;DR: Commit message only: the test is credited to T.J. Mercier, but no
From:, Co-developed-by: or Signed-off-by: names him; the review asks whether
those tags should be added.

>     selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL
>
>     The BPF iterator docs in bpf_iterators.rst specify that the next
>     function of an open-coded iterator should keep returning NULL after it
>     has been returned once.
>     Add a subtest that checks this for the dmabuf iterator.  It drains an
>     iterator, calls bpf_iter_dmabuf_next() once more and checks that the
>     result is NULL.  The dma-bufs the test creates keep the list from being
>     empty, so an iterator that starts over would return one of them.
>     The existing open_coded subtest uses bpf_for_each(), which stops at the
>     first NULL and never calls next() on a drained iterator.
>     The selftest was originally posted by T.J. Mercier in the v1 thread:
>     Link: https://lore.kernel.org/bpf/CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08KhWE+qJ0J=XGMA@mail.gmail.com/
>     Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

The changelog says the selftest was originally posted by T.J. Mercier, but
the only trailer is the submitter's Signed-off-by.  Nothing names the
original author: there is no From:, no Co-developed-by: with a matching
Signed-off-by:, and no Suggested-by:.

Documentation/process/submitting-patches.rst says Co-developed-by: is used
to give attribution to co-authors, and that every Co-developed-by: must be
immediately followed by a Signed-off-by: of the associated co-author.

Should this carry Co-developed-by: and Signed-off-by: tags from T.J.
Mercier (or have him as the From: author), depending on what he agreed to
in the v1 thread?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43356758506
--===============5694792853191233504==--
