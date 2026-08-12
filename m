Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB0DC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779B810F053;
	Wed, 12 Aug 2026 15:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H1HYtnay";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D273C10F053
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:02:16 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so149433966b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546935; cv=none;
 d=google.com; s=arc-20260327;
 b=Viwf8b6KXeX88hyJ6yAWqV2IAw4uog/3CvGbNs5PWhVhShW4s1+591daXlvNqbCtJe
 aAdaQqotHMYR9mcyEIWJ4ixfi5fTgA7B+1UNGY8E/xftAyPwIryrtP4h6b+T2UEPxSyO
 aQ9wuNKRY20kYxsjB7Hk8r9S+ul9OFanLyszEn8Vlx0/E+k6JvYaNQGORk7Ci8GkpfE9
 N66R7bZ4/hjUb0ugdw2xMNULQywuyCBFSsKQdGkhTdXPoTd4pyW8OijYVijKsJLStboy
 fHJ9D+HLVEBj40g4ejFhcKoSNukSbMV28yNIHpm/nJuFIrNhjCAMds3EbfPgwVheEBqv
 hOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q5uEzbGEkmct8ZKXCwDqoN9egKEIy/PFu90SVjOVj20=;
 fh=1enVimnujg5LgP3eJy2ITekazDW16fGIUM/387o/fnQ=;
 b=l4I1+dW/MhWWBeBFPeTelmunCQnkvy60bfG2Bi5LKEM/XwLZAPxgcsOJHl5/8ZERgH
 xm87wbtE2xFzpNImPyBZ7YtVQscR4yudbMcvdJuzeRe+b6wRJBQAtU4QlFgM54ibjwOu
 Q8NZFw2DCjU+G7wl+RVHPREncRz47YEQQKtgCEBXmY6Jdv8c3qztWYIo2bwrZWf5Atwj
 BGZU/ncGqyalK+4HcbYovLV67nIvRGtCFfXLcWrCBwuGSZxs3N4vY5lJSbT5hF0i270X
 gYQXkUkdzYGax4/Bge7PwQxq2QLw2txjLfYckH61dcrvrJqU8rjomQE/X+G0lDUh5aNc
 g6dQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786546935; x=1787151735; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q5uEzbGEkmct8ZKXCwDqoN9egKEIy/PFu90SVjOVj20=;
 b=H1HYtnay3Lp9EdhVFcYi6cRXnoH5HMIqfCmWG/FwucSpr8fGaDW2GvrinJ1t3WKURP
 dUYtemJuTJuwIjkniTLSgpmhJyUK7wLzBrvNlckedUkjvIsbjdkkebzjplRaVllaBXVE
 rMXATnl21A2SzHuLVQ4vvrU2MpjbHk55h3xB6pco/DD+HdbURh7GQ4rAPz1mBp3mqK04
 Y5q+4+qnEu/ujThVQmKQbruZvR+ICOAdc5mCa5SJ17nUC5jg5PBs/5RS+jBhZncrdz7/
 DikgKbZtrOkdp47bJwGd38EiuslUYsF0aRhpf44/Ha219lPo5MhDgUYY4vOaf2hBx3+s
 Gy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546935; x=1787151735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q5uEzbGEkmct8ZKXCwDqoN9egKEIy/PFu90SVjOVj20=;
 b=CHY3Wps3kMybM0VZlstbyQjp0DbiUDn2ViX5WugLUpTNbUkprk5KTNS0k29WzQEz5n
 mVPoUmDpf+3mknkzk6OJ0tHIL02qSaCjQXXL1pv/Og71b8/BIf0ogE6rb7a5a9LqbjmC
 3Csy9S7P7gpv/SnPsM2qzgjG8d9iAguapK9C4PzhxX0Y3hjvB+SPlrF6ZwQcXbNhWuQT
 t0GVk7h1X7kgiVPNTQ0PsEGczfXXXW8I30ja1iQn+Br6GxHwzOhObXUw/LVetoPZkf7s
 xJIwppQLKQuaN0PtK66x4wRLxK0t3kkuQsgBffiLB2JNtfhUwLLp+vqaPdLkXEknzjm+
 J9eQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBkDdb1Co+1IiBfNQJlszqjcZVwGl2BnpwkncD2PRqC4ECF+w16Oou8HzmjkK7U221UHl01uoRQI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWHvEEtsttx3qxUzIvV7D5kojCSm81tCxGa23jI8lFTm/GpXeU
 wNiCsI6MZy1ykD7vfX63JuNNxcw72Y22OIFfm3iY8n3fVDQDv5UNb35z0nfmHytrRjvcGHoaTRn
 NNeUe9VVLoZmlrqxGAklAkRfpDwRsnGG6Q2OWEZSe6w==
X-Gm-Gg: AR+sD106UEgSrZiVmWCaGb1NNaIQf8nbwMj0+iknt7wQpeRTjthGTSyGV1cO0lpry07
 tsthbmHbxEvOvmMcLxnb4TnP0y8KHxyAuCdZX9Hkz1HUCU8o1BT8pzYiwmvqzWy1edY1F834aIU
 /giq4MxmtQIBEG43auSW6jfk8lUGNboGJFpD0EsI+RafCCHZG5AMfKCZOab2oXgkGum0ichAlrC
 CrEq/uFStdMV5TLDy3EMH7DMszuC+oys8783pdsHIVmfvFcFtJxXswoEeQVmrlhyox2ErEKv0g5
 020U3GVmNDBK2EchF3jFQokORhxh9M1441yOBguHKy+Imth6C0rrkw8MrIC4sKBrhLYBCqgzuQ=
 =
X-Received: by 2002:a17:907:980b:b0:c12:9b98:209e with SMTP id
 a640c23a62f3a-c20f300e2c3mr249056166b.23.1786546934618; Wed, 12 Aug 2026
 08:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260811204123.3198370-1-tjmercier@google.com>
In-Reply-To: <20260811204123.3198370-1-tjmercier@google.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 12 Aug 2026 20:32:02 +0530
X-Gm-Features: AUfX_mxNO1BArOhzalHmBpnvLYxDFW9EBmuDhA91cv0HkIInUfoU4eE504H7mhY
Message-ID: <CAO_48GEUhpyeenX8Vu1NoDnvzib5FGv3rOBYNYwQEWu1-6cjaQ@mail.gmail.com>
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
To: "T.J. Mercier" <tjmercier@google.com>
Cc: benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, christian.koenig@amd.com, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hello T J,

On Wed, 12 Aug 2026 at 02:11, T.J. Mercier <tjmercier@google.com> wrote:
>
> Write permissions on the /dev/dma_heap/* device files are not required
> to issue ioctls and allocate dmabufs. Applications should be opening
> these file as O_RDONLY. The BPF dmabuf_iter selftest already does
> this. [1]
>
> Users are pointing to these selftests as examples of how use dmabuf,
> and encountering permission errors on systems where write permissions
> are not available on /dev/dma_heap/*. Apply the principle of least
> privilege to selftests which open dmabuf heaps by removing the write
> access mode and using O_RDONLY for the open() instead.

Thanks for the patch.
>
> The same is true for the vgem test using /dev/dri/card.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> ---
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89..45b420e37c97 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -48,7 +48,7 @@ static int open_vgem(void)
>
>                 snprintf(name, 80, "%s%u", drmstr, i);
>
> -               fd = open(name, O_RDWR);
> +               fd = open(name, O_RDONLY);
>                 if (fd < 0)
>                         continue;
>
> @@ -96,7 +96,7 @@ static int dmabuf_heap_open(char *name)
>         if (ret < 0)
>                 ksft_exit_fail_msg("snprintf failed! %d\n", ret);
>
> -       fd = open(buf, O_RDWR);
> +       fd = open(buf, O_RDONLY);
>         if (fd < 0)
>                 ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
>
>
> base-commit: 9a11db68872055e6ead919bad04d6330851c522d
> --
> 2.55.0.679.g6767b8d81c-goog
>
