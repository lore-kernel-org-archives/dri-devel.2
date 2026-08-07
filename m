Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F496C5ACAB
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09ACD10F460;
	Fri,  7 Aug 2026 21:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="KtSQ2Zmh";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43A910F460
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 21:49:32 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495509b08ebso5675e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 14:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786139371; cv=none;
 d=google.com; s=arc-20260327;
 b=I9ueZHoUH9Jc8pBiubhunnNzqqLAS3tr3Ff8vrMb5YlZDSJVIvQhObpwZQu8VhuJPI
 xUy26OhHWWdxf1rIF9gt2AyXiyt0UVeQymGALtFc/YCsibCPELOeML0ymPtTikLTp7ig
 Cwk3Yf9MTn8wyUusvDL+/OfBvfI1YPuy9/qTacoGQCdfgKtiwjEKHKPo7lYTyeGeVN3y
 OoRJkGxfY9VpvlreC6M304loSA2CMelQV3Pk4XG6M/LW35pTapL3deSVa1+iQxiDHje+
 +qFmCLQZaiV5Xh5k9ru31F3Tq0fb8DLidIIGJKePv6hhmhBAJvWGgch12RIjoycNl3h4
 XNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tojr7GnFU0It/HjO8jYmDDXbwX4n7nas02X2nGuMiz4=;
 fh=qhcBkaggc/OfNWzFcfa6Zvs78tCNGMqWBO6vS9G+Jdo=;
 b=nUe9bYtD3KUrpvE6wfheLC4nrqJIPamsTeL5bQjUyJAisIuJOb+S88Y6LQOO0y1Q9l
 FEE1qTIVagYBz2UJKRLCrjjdKitGLayvs5ePY5O3ioISdaXUtG72/q14T4BfJjemTMy2
 ZlRM9H/TDDd0SJFcVdJODdGWogL81UUJzA16JWU/FlVbehB55QR8xQ7gV2Tm/MtQkcoL
 waoHGz6EtRUaXGSofpxQS3SPeyKcxme+7aDCBHeEOjwaqV+w3r0bOwVghBuM1i2dCPS+
 nkEGXkLCJJuyPI3Amd7+QSSQ9YwO67gHojfwpPsInUvXGhXfYtO5DVieNgjSgmPrhdZt
 s/Lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786139371; x=1786744171;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tojr7GnFU0It/HjO8jYmDDXbwX4n7nas02X2nGuMiz4=;
 b=KtSQ2Zmh9Fk8Tqk7Oh4E0GIbq9B8b4LbeFoYb3vdARvEFGUMs5j2PZeE1oGYEgSykH
 I62ueCKHv+oWjM0z3sxHuSwcOrzufzJ16GbKoDTFwYse6239PbduTf5xQRuL3WrWMDHq
 q74PagnT0e9QvpaXn/HXvNzr0AH/64uEeGhbGJ5bdKBIOnlQyPJ/4fj86VQvh9lI3fCK
 ROVHUo/6FasUsq5IVHHLkmN7jkMd6j/nCFnzWdK4iMIAsf/icOkTx4Ec3IV9LgBbrGCd
 Q0HsMYfvOdwG3FEkvDP+uS5su9E+Aq4FBhUyNwvZB8Tj8c/0MiD4sQjaL/Jx3HFVqQEe
 /qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786139371; x=1786744171;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tojr7GnFU0It/HjO8jYmDDXbwX4n7nas02X2nGuMiz4=;
 b=PKQ6hzEa5tTNZYTeaqDZ52tca4I1scqo/4hustJQdV8OPuBLZHRhZdnCkTtiUoo8LE
 bYfqsKQRfDlX/c3RhO5FarNe+wOY9CFVOOo002UV7U8jCcH+7sR/l2VJ0dwjaIi0yMWG
 c8XorLluUdnyolW81lbyEdEuauStzRvc2zU8V5y/SUCjeZ7MPrhVW2/JQ7xaU6sykwnd
 VDbLVtLpLnhCnczRfJbN/a6DnmmxbhfQ3pDvSqk7taVl/AG7BsonVChBdqLfzrx/HhoH
 ufkvPiHDpS1mia0zZ6MPvyub/MRelcNAMxHjPbSWYXCYKsnSJkz2+iOZOoRoGfAM1ZuF
 57BQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSZvCJHECCwPfcEh9vtaIl4cmoTVQ9rgLMgZPWL88+HKVVeFas3PiuGbZfpYusqtO2bAzFz+YSXk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGmkuA6dwVOmiMRwqfJnAbMrxJ8up122SUZT3ueArAHLByl4+l
 4Zkkr/Btizc9ND4aHBPTPn69Az4D3RGN4nuwgCukYdMhRSsvkngfDZt30b8xdeeSFoEX26siU5N
 zz4aZn4Wfw6YMMvKoexlGNjY47JbWV2BjU3dD2hoC
X-Gm-Gg: AR+sD1354xqo/B/Ii8KiZ/ks1DeTR6UQ1ugOFQ5UbWqXZbp/desv2i6ZymSHCWEzPY7
 CH8QzOYwPbDFVEf2SpfXc1Vj8jQ77OOPqnt1rCSZcQcSyx+jAGiagnmBG5euQiJ+GUXfSNsNLIc
 B9I32kfWGv6xJ/arryX/pb2PIL3CndhoOkoUMLelccvDFwzcW7bnu+sYy6rZAYu+KELfiVe18+9
 wiVlhmQtWU4r6peVKEePkR6lk2iHr8FRIuGfgLASsTpDXFafXwykM5K9MyKRP7z9uGhz+uWdUM8
 6iL2gsESS21drti8zgo+TcEVo0tQDcV7ygoHjO/T6bBqyChvcOVZkKE4whABtclQIg+BcWMudWg
 =
X-Received: by 2002:a05:600c:1792:b0:48a:5618:b4d4 with SMTP id
 5b1f17b1804b1-499624fa627mr282955e9.1.1786139370663; Fri, 07 Aug 2026
 14:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
 <20260807101140.1357218-5-shoubaineng@gmail.com>
In-Reply-To: <20260807101140.1357218-5-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 7 Aug 2026 14:49:17 -0700
X-Gm-Features: AUfX_myL6rl83duYDy7P4wt3f7i8-Bq4xO_AORup9Lze93VGtdc5GMGWYyQ-sUA
Message-ID: <CABdmKX0i_DaS8Q2=Q8Xs5bTbSCj2FFSpib9ReCGYFXSeiBcntw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
 "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

On Fri, Aug 7, 2026 at 3:12=E2=80=AFAM Baineng Shou <shoubaineng@gmail.com>=
 wrote:
>
> Add a test case that verifies no file descriptor is leaked when
> DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
> to deliver the fd number back to userspace.
>
> The failure is triggered by placing the ioctl argument in a private
> anonymous page and flipping it to PROT_READ (via mprotect) between
> the kernel's copy_from_user() and copy_to_user() calls.  With the
> buggy kernel the ioctl returns -EFAULT but leaves an extra open fd
> in the process's fd table; with the fixed kernel the fd count is
> unchanged.
>
> This serves as a regression test for:
>   "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
>
> Suggested-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
