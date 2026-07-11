Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06367C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 12:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394F3899E9;
	Sat, 11 Jul 2026 12:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDSdFhsh";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8069899E9
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 12:55:32 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38115bbb83dso154670a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783774532; cv=none;
 d=google.com; s=arc-20260327;
 b=gkOmownv8+WFllTNvPUi/JAHXDCL41+PDxilCGOgHTdlpmrpsl8sZP2w8cN2wVAiTU
 RYnlw2QG00wRazxnOsWCNeHftV2qu13h6/4ZHi92pZOqyWXQxHYdg3P/FN2280uX7X5g
 fwWo5RiXkiXgswt6yuC1mDIyyOKWm3kBipHjSn3I4RAoJ+1ZNqO6Ar6wM2lAdqGYs6bz
 7WEzMv+yYxZBCOXSu1V1La20Eh6m+95cPNaWdUTS/X10vrMfCUUNdbxE1Vq1TAKZS635
 +83BENxe0MMwcqvO2PXqaaW4tE35kPDIwQDtp/mC4ADyCKnePraA1auCaTkfY9Ed0JvJ
 hurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1zUvgb/Vijkk139Zbj5Mh0/O0qV2LR06s+/nZ2EMR/8=;
 fh=FHqSj7DBZ4inZlCKuXK/Ay3di02aCU7d6hR25YoLvf0=;
 b=OFTADXG2SDweGfWPV+yRT1T/lHtMxpiBL8mLfo+G81ToEJPWnxRmhj/isugCcVj15B
 6Kc79lcKNqlYu0PffSChc2Cmfrp0sM/P17HGJ/K2aNp8u8iGD3KzuCqGQI/14rvLDFH9
 WY264rT850V+HBMFSEuEBDfe9Tyz3sGxWF0VVjR1G30VPKDjING+Oa2jYYSwRXZKPlLu
 S3gld8ztoXserRPXXCDK3wpI9iGXmMHwcg4JRF1AZJCZyML7GoW2Q8IyXKL1Nx2W38we
 +wccidQmp778ByIOBt/6XwVs008XxtWZdwKxDkYuzfSx2q7CrtuVUD4W/yT++xbnRL8z
 8b7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783774532; x=1784379332; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1zUvgb/Vijkk139Zbj5Mh0/O0qV2LR06s+/nZ2EMR/8=;
 b=eDSdFhshnqCOTQG0TK9bkrBix8hqEC8VNuymla7JRLtr0UKB+pAUVwogp+I5Vt/Ih2
 idk2yNhv/uQW0srm8xjbkToLgU8VLMEQrLBtS17p/ukAK06CxjeKLCPvhSjAxRx8nOKy
 3PTXSXLfejGwxzDjUJe5jfWI2OSRs3vl1b5geKvIPKaZ4AmUKDZGo7zW7wGTReRSbfng
 SXCtAiMlJjo9VYCvLU0l8oLyUQd3dOHJmi48X5NrbhosOizbpPp52aWbSAGqSSvGDg5O
 noLdwIMGVuy/R6JrpyK5CP06Yk4hN2J2JfCA5iq+fjbpXOiHzaC7pUzVh12VDAVNlYs0
 tMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783774532; x=1784379332;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1zUvgb/Vijkk139Zbj5Mh0/O0qV2LR06s+/nZ2EMR/8=;
 b=YfTBa6NNR29fV8ej1CQaFoFu7lfwuQBSmBshn1P/RxbYce/wwq8QlDiB+W0Favqag+
 fh7dLkPe//5tkpDdpmmVCd5QMtllv86+du6qBprN3SYyNLdf0y4dwg79U5kI5qy57dfq
 WnNieH7q3i9E6XTxvh97Ts8+Wbc9Bk6/OZZhBFBnU8Ea1sy11SdCAE4ZFTsb0IrJ4j66
 FuW7LZ0RjSLd469Zxb3f1RMxymyD4rd21kSBlrec+WNOntNbjQypas2/OYNw/H6mBPfX
 xiBrIK97w+fhtbm1J5XSCKqbEuccsLiXnNd9Lt+XXKT5jCNfoLGfFebMFMun1eget4gt
 spTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Row1veL0a5J+dRoJqhim4F2CM0OYazbN26s3QBPW2+pponw9Wncl871Zr336av6CVSytfcG8rLhjE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx690nP4JOgZD8Tqfy1duIF0e4bv/EJ9nuGQCGqv2YsAtgCEFqi
 2nyi30YnUqwWFWNu+SHMFaGsRZebulWj646SMSsMIhJ21kOy5jwPPJQyBR9/IgM6QIwfeINkcxZ
 B7rHO95b+LxFxKpaij8aPjC1mlvrXpLk=
X-Gm-Gg: AfdE7cll8i26Dii7TQtTzc0IGtyXjB6G0GFc71YPJ3gu32uFzdkWLJpTThPm1ByApK5
 zrOo0UrveToUYM+bEt8tFaZHILfIC8wBKv+Bg/xPLlfveVbWPbQYWLWrbFo/uCW11llMedg2+tR
 AgvJvuv2F6BreG2ifL/VxoCxfqGxTKD5XWnqzFVl8Z4hP0Ru2dlgydBJGj1YwYqVsRcfBM9yMOT
 retqPAjMMyKo9qFOx/gWqNam2lGdzN42E0BE8ea1ZgwOG59OwB106eW/CbOMLv6b2DZnlgLxUlF
 A+Tpm9e1ctq/fUOlmi6DXRJZJmTCbb1QMbsF2pspap9ch49cSm4L+gqX4VPkKCnx/4FsiN5rSKp
 1ULLw5IUTjZK3
X-Received: by 2002:a17:90b:3e48:b0:380:7688:fc06 with SMTP id
 98e67ed59e1d1-38dc7849860mr2139954a91.8.1783774532077; Sat, 11 Jul 2026
 05:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-dma-shared-buffer-config-v1-1-8c1571000855@kernel.org>
In-Reply-To: <20260708-dma-shared-buffer-config-v1-1-8c1571000855@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:55:19 +0200
X-Gm-Features: AUfX_mxzrtwl0-qM1WcyDgdPW3fSN_iew-N8VZzUs1Dmg7dy-KYQxeN-HmNLFeM
Message-ID: <CANiq72m9t0y3pfZUw_KbJSjujjQcM=FHxTCLenPoC_-v2udibw@mail.gmail.com>
Subject: Re: [PATCH] rust: helpers: guard dma_resv helpers with
 CONFIG_DMA_SHARED_BUFFER
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, David Airlie <airlied@gmail.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Wed, Jul 8, 2026 at 1:53=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> Commit 9b836641d3bf ("rust: helpers: Add bindings/wrappers for
> dma_resv_lock") added rust_helper_dma_resv_lock() and
> rust_helper_dma_resv_unlock() unconditionally. However, the dma-resv
> functionality is only available when CONFIG_DMA_SHARED_BUFFER is
> enabled, resulting in the following link error when it is not:
>
>       LD      .tmp_vmlinux1
>     ld.lld: error: undefined symbol: dma_resv_reset_max_fences
>     >>> referenced by dma-resv.h:463
>     >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock=
) in archive vmlinux.a
>
> The dma_resv_unlock() inline in <linux/dma-resv.h> calls
> dma_resv_reset_max_fences(), which is only compiled into
> drivers/dma-buf/dma-resv.c when CONFIG_DMA_SHARED_BUFFER is set. With
> the option disabled the symbol is never defined, so the helper fails
> to link.
>
> Fix this by guarding the helper definitions with `#ifdef
> CONFIG_DMA_SHARED_BUFFER`.
>
> The only user of this helper is the DRM shmem abstractions, which already
> depend on `CONFIG_DMA_SHARED_BUFFER`.
>
> Cc: stable@vger.kernel.org
> Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_l=
ock")
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see:

  https://lore.kernel.org/rust-for-linux/20260708082454.1254320-3-mkchauras=
@gmail.com/

Cheers,
Miguel
