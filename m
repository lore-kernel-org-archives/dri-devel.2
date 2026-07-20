Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E810C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B9F10E1DC;
	Mon, 20 Jul 2026 21:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="thghe5zf";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3070F10E1DC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:15:58 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso454085ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784582158; cv=none;
 d=google.com; s=arc-20260327;
 b=pjAXiQy44oE7rSoY1bZ+AbU7jlDf6ncGBcmYQ+c/k0QPadFVTNT15WSOeCuj0I8/Z0
 FgDjbYT4rgv8nRhlZg8tMeXIM852HGNzdkYoxX8JF/1AhZ3yKQ/fFZ5LHllDxuDJqYG/
 kInPWyprhmI1N2g5IHXYTnN9hSA7OpQR1IrLbGynzd+9lypWPYeWoCBZvX7MT1fIT2Kq
 ZZTgYUg/N2W13BjbaE8n+I4rcH+UR++L71ciKO9KqtbCK2LH3sSrpN8B78J2V2RvQ4wk
 MEhgVAZO9nCkL9+1eDCUFhTUtmTrntBltiDqtYRFqtFtPvIXdsNfhGmKwvKZZ8RE9kRU
 zwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AUz90BaUvuUhSt2RwJPSmjEfCptOlPXUUGIO067pPsI=;
 fh=UPTxBVEKBsuZ5DilPdxBy/Kh5RPz6Szf29hrrqkR9ng=;
 b=O1ysoizGgBFi3PJ7fruNlmEsb945ZgA8L4qJVSJ/LcdD8P/6mEbKgTIZqHwCRNZ1Ob
 /qOf8u8886ARFMmNkUuq7LnnlJcZnoh1KmXiEam/jYw2LAa7TOqhLmAJADuBOdoDJFFA
 SMGJyuJ9Spq4ga6wpPtLu8Vgh4nkhOLDQpH+s5p/R/hTkj8yBGZ8KOnUqJ2OAK2TLnyO
 Q18J2FmBpPHrGACeo/AFmKCPz52zdhuRxt1upUm1jLcTp8tkyne3Dr200AKxlbpFAUsD
 I73DnrMmNO0Ns55oxibrV4VJ6YUjJvvDcldBKTRKnytkFHua1m/LNT9Rf9skKCV1uBdy
 SDYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784582158; x=1785186958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AUz90BaUvuUhSt2RwJPSmjEfCptOlPXUUGIO067pPsI=;
 b=thghe5zf3+jwOsunDfHkKJiVOvCXrPflfT5xjbVKD5SKtSJF0WGyYAdE8hff1C4Bok
 PMX6V6GQd8yxNsN1wK0GJYPbHDtCqZQFRCQT1S7rpSumee4yhUsYK/35qYRtK4l/K7Wk
 aAbaFsRBuoE+MuV+gwyL18+A45z63qMBpzU6lfTQwDxGVqNhf7xKrM4RZrmmu4+RMXkF
 hJdNtOsoLhiWnbExWjV7duIkrLyoAuwox21nUHN+g0kn6uX+9JRhd7E6rC1b8D/5XmFn
 zBG7bOtTHzkjC9VNdXT1ZiDz73Ehrj92vnWr0BqTi9kfp3sIZUMeOSwGXp7u2bDoRK6+
 ahYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784582158; x=1785186958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AUz90BaUvuUhSt2RwJPSmjEfCptOlPXUUGIO067pPsI=;
 b=Weh1rKNv09SIHZAi6HgiI1n9BbVT29C9td5QIoNS2edzyWb2cgr9Uhog79etFnzq8F
 SoSzvOBitRSxhSlyIhoDtH0adAOcVuTMHI5k4wbMc9h9Te88Hl9WoJXYLxNyerhDeu6W
 /6ssLZpY8abiAKq7qn5OfIgDUgUl+oDNsYXklzkgF3ef4rN+1ebIxft8WTbfogm1tQS3
 o1s8p4eYCIQSElo8Qzv9T2+tHUk8EMuHbiTjZXwe4S0o73+LHlnKJS5kXt6UCMrElzh6
 EA1wf9B/ab3GXtwW6CJTQy69DmTgM6fag0Kxgpl5tsfY7WRu2GZVk5irgKgo8KrBJd2u
 fZPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoT9PfZ3UJxcGGjtUnHD8mkPHoD9XJJSFG79wckX/Q0iOgY9UF2E1uLVz/gl1NOLDEqnmqq0p35UDE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxq0hb0HrsnIJ16Bgqmsq45yV6wcJVNFAtRb7kD7CBrbhgaHDy2
 deydPcWh/kAzKxTB8Ns1UuVbEaQpHUgSGRf/E7esYrfzsCW7tcFjiq1oW5D86FK1YhIy5uKhxCb
 J60f/MbcQsdfztHGQpUHTHMP7xIs3olUMsMBOSTke
X-Gm-Gg: AR+sD11//5azYXoL7SdJhPIfmXacTTWqqqhKDQ0aXRLwyCpoHQgftBV451bL4wLw/rI
 5mhE+FjdRlW0FnZtc3KYtc4F5oVLl0+Qzx+SpL0yeLBOjTkEdFaFvIYd3v6IkZavZuB+62V6Gm/
 qdwS3ZuaHRO9OAFuYpyGzwzIGC7q0Ox5NEm7e1SPx09BaW17inUZx/nsN8jIPXzgKvrZcl07tbU
 ByRuhPsv+qJ6Q5IOJtbmlW1asjn+e0EfJOBMpFSGp/KMeoA17iE3tJHzarK1x+ILhMtXmhwCqh3
 htMqlNt6MhQg8f2skbJjGnraXTc=
X-Received: by 2002:a17:902:f54c:b0:2ce:7ae6:2a23 with SMTP id
 d9443c01a7336-2cf7b702c3dmr2558895ad.27.1784582156890; Mon, 20 Jul 2026
 14:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-2-34bf6fac941b@meta.com>
In-Reply-To: <20260708-tcpdm-large-niovs-v5-2-34bf6fac941b@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 20 Jul 2026 14:15:42 -0700
X-Gm-Features: AUfX_mxUXqtSIB0dpGSWPZIOzVEGjkP0LeV9jHf6fDBCDwwRrEGRR9CjBBihAPw
Message-ID: <CAHS8izMz_S8K80EXn3oFXiDNkGuPUMzjecaJjAvaZVky-7O40Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] selftests/net: ncdevmem: add -b option to
 set rx-buf-size on bind
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk, 
 Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
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

On Wed, Jul 8, 2026 at 3:55=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Add -b <bytes> to request a non-default niov size via
> NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
> udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
> hugepage produces one naturally-aligned sg entry.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>


> ---
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++=
++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/te=
sting/selftests/drivers/net/hw/ncdevmem.c
> index d96e8a3b5a65..a16e55af51ee 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -40,6 +40,7 @@
>
>  #include <linux/uio.h>
>  #include <stdarg.h>
> +#include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -61,6 +62,7 @@
>  #include <sys/time.h>
>
>  #include <linux/memfd.h>
> +#include <sys/param.h>
>  #include <linux/dma-buf.h>
>  #include <linux/errqueue.h>
>  #include <linux/udmabuf.h>
> @@ -79,6 +81,7 @@
>  #define PAGE_SHIFT 12
>  #define TEST_PREFIX "ncdevmem"
>  #define NUM_PAGES 16000
> +#define MB(x) ((x) << 20)
>
>  #ifndef MSG_SOCK_DEVMEM
>  #define MSG_SOCK_DEVMEM 0x2000000
> @@ -100,6 +103,7 @@ static unsigned int dmabuf_id;
>  static uint32_t tx_dmabuf_id;
>  static int waittime_ms =3D 500;
>  static bool fail_on_linear;
> +static uint32_t rx_buf_size;
>
>  /* System state loaded by current_config_load() */
>  #define MAX_FLOWS      8
> @@ -142,6 +146,7 @@ static struct memory_buffer *udmabuf_alloc(size_t siz=
e)
>  {
>         struct udmabuf_create create;
>         struct memory_buffer *ctx;
> +       unsigned int memfd_flags;
>         int ret;
>
>         ctx =3D malloc(sizeof(*ctx));
> @@ -156,9 +161,14 @@ static struct memory_buffer *udmabuf_alloc(size_t si=
ze)
>                 goto err_free_ctx;
>         }
>
> -       ctx->memfd =3D memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> +       memfd_flags =3D MFD_ALLOW_SEALING;
> +       if (rx_buf_size > getpagesize())
> +               memfd_flags |=3D MFD_HUGETLB | MFD_HUGE_2MB;
> +

The fact that you are using HUGETLM and 2MB mappings here made me
realize there is a pathological edge case in the code where the netmem
size you're requesting is greater than the mapping size, so you
actually get no netmems. So like if you ask for a 64KB netmem size but
actually you did a normal udambuf mapping and all the maps (sg len
entries) are 4K or something. IDK if the code already handles this
well with an error or what not. Worth checking.

--
Thanks,
Mina
