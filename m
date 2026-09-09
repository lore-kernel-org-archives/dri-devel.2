Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A9DC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD5610E038;
	Wed,  9 Sep 2026 08:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WkQJwhoC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A8F10E038
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:38:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A5D3601FD;
 Wed,  9 Sep 2026 08:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3C1F00A3A;
 Wed,  9 Sep 2026 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788943083;
 bh=OokCh88L7dOiSl9iYeV5AtfxGkpDH2A3rzbeKYbgX70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WkQJwhoCfV+M2M+D5Cnh6cCdZO5HKuhxSUEEz9gBmnc/UPR28nO1K8w9gKnts+1Y8
 oBmfE60CWrhNuan9eV5cFsFWcQA/CTh5cL4/mlLeB5yph9UbRRR9jAeq6SXwq7aMmc
 rDltQpiTTwU+8fl9xPsbn/aO2VlFh6bcpOYSIbfiiUaZsAh2r2jgjNN00cuJ3YbQNw
 gRHpss90TclYAK9ew4kMHJ9suU+09f5PfmmoPgxoDySJlNScj+gpxWooy/8ifMWjbU
 8fFflINvseKf8t/ah5CbSNZn2R0DezQ+pmrQOt2S8SJuUeg2LTuMZRUnhRpAKpv4ud
 O0iL+DUzeClcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm: page_counter: drop protection fields from
 struct page_counter
To: linuszeng <linuszeng@tencent.com>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-descriptive-name-v1-3-1828961cb01a@tencent.com>
References: <20260909-descriptive-name-v1-0-1828961cb01a@tencent.com>
 <20260909-descriptive-name-v1-3-1828961cb01a@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:38:03 +0000
Message-Id: <20260909083803.B6E3C1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Orphaned and factually incorrect comment and redundant padding in `=
struct page_counter`.
--

commit 2561d898691e5e4e0a87e8f8b40818bf2f82cbb1
Author: linuszeng <linuszeng@tencent.com>

mm: page_counter: drop protection fields from struct page_counter

This commit drops protection-related fields from struct page_counter and
moves them into a new struct page_counter_protection. This shrinks the
page_counter structure for non-memory counters like swap and kmem.

> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index b81f16702764e..a4dd461523af2 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
[ ... ]
> @@ -73,6 +57,9 @@ struct page_counter {
>  	 * support memory.min/memory.low (swap, memsw, kmem, tcpmem, ...).
>  	 */
>  	struct page_counter_protection *prot;
> +
> +	/* Keep all the read most fields in a separete cacheline. */
> +	CACHELINE_PADDING(_pad2_);
>  } ____cacheline_internodealigned_in_smp;

[Severity: Low]
Does this move of the padding to the end of the struct render both the
comment incorrect and the padding redundant?

Because the struct is already decorated with
____cacheline_internodealigned_in_smp, adding CACHELINE_PADDING(_pad2_) at =
the
very end appears unnecessary.

Additionally, since the padding was moved, the read-mostly fields (such as
track_failcnt, high, max) now share the second cacheline with the frequently
modified watermark fields. This behavior contradicts the comment that
states it keeps all the read most fields in a separate cacheline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-descriptiv=
e-name-v1-0-1828961cb01a@tencent.com?part=3D3
