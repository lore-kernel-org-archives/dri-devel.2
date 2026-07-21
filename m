Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E720FC44520
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 00:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA6110E234;
	Tue, 21 Jul 2026 00:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfF7KM5x";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB2C10E234
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 00:28:55 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso10689360b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 17:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784593735; x=1785198535; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YnhrM7uIvjKhsDFp/QtkP00zu99wnVGEBhtiKwVmfTw=;
 b=mfF7KM5xH79rdCZvSHd9F2noVOIEU2A8pk/JtHs2RiKkynPEUr8EcaVDoc8RZlzFAg
 CuxQ19BfI3QNyyzUImkrSZw4HWGIgR8RN1sQIZKL/tvShedwnfMqSwFttym9k7UFu7/T
 7d1q1WLRBuJX2DuYnxL2IN7DK2kFlZzRTZnToQ3E7LoqcUI3GtzcOmLJtWRiAOGHXpLD
 i0t7FB8ZBTXn+ZIGrJV4JCDjGAukKRBJBbX+VcHKp0RGXLUWyIxn1DlQvIAxh00yRMbv
 FIMNguQmgOmT8pffMib2AO9bPm++qSI7nmYRTOSoYLiutZ9eMMM2DvFFm3M/5wPThVBA
 1ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784593735; x=1785198535;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YnhrM7uIvjKhsDFp/QtkP00zu99wnVGEBhtiKwVmfTw=;
 b=juuQ0VsUYjNzA6RV7TayMlvIACtw1o5iTJgYMY2GCxaaxCclpJpPM9z0JGs43l0fjH
 G46nAnEpzzd321y13rgQ0+YtrCCgtqcWN5KohRoMPOtlrgbRUBB+iKSOlFyX9GQOD8O2
 J+NHIVNuTSYgtnYbBdSaMWX5PsU4pD+7SCU2XfbEYDBZ4ZIDPVBKL9C9vguDpgVOGEsw
 TNyg6RquXhxniGWvarsOmNjypHV6tOH7clyFzU/b/MHMmZUsNq1ypGfFnr3S6oYfG7YX
 g8HEwi/WkUuMlqSb9E959sA9SEHnjA0Klldzp/+CmXNbf6PGtCpn5F8f0H7WMZhshQxE
 ShZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJd72tIs5RFWTDv9eS/s/qcAn8B1puQ8q1CU8uGIzV8Jz1M/WVPWefYh7MkaxgyMcCtZ77KIXQcAM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcICRFCPnxRA3TSgr6V0FXr8tx5LhYvmnc5W4Vn2VfDSSUWGXz
 G0P+lOKAM99tnTpFHLWv7VBrTjwOYdfGeK07ZcqqNFezDfoUmiCQUiwl
X-Gm-Gg: AR+sD117b8XTXZzJodhVGYZLwxHWsDKoXBFd3cmmr4h77z/VzlIN6AGrMBVR0QhIMQ+
 cp0dCNOPvzwSjWErfIFu6oh4OH+Bvyglts9S93pcLRlMUD1DW2NLHTXUuxKDzFifJrdILQ2KZlZ
 utqDXnN0peN8P3R4OZVpf3mnTqbzngx/ZIjm72wfIANx+CWCHGM52Ollk8ss+y2MGeCYi6CxfCi
 XoJrdy7yvzYc/v8MJ0qecMlK/tHXXppZuiRyRPjEbaJ57wkz1l4ZJU6mvVvTuY50QDaANx+Ro7n
 CJ6Pz/rZJNlJeDyydPRqN2SpTdLv67jJsXbiI8/gc2p7rNvioU1ARa7WG8S9th8/4wQOtipKiFS
 hfoIDyirQZlpV+37fmYw8tyKyqeZLYDHMRp02CnajqsaP01VXQdAybmtsLP2TW/9gmzuTcl6hH+
 D7jNeirTcaIItjpTAQWH0PGU/BWZvit4/ezQ==
X-Received: by 2002:a05:6a00:2f97:b0:847:8704:1c48 with SMTP id
 d2e1a72fcca58-84c292ac4d3mr10870603b3a.20.1784593734662; 
 Mon, 20 Jul 2026 17:28:54 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2af9f00bsm6429812b3a.56.2026.07.20.17.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 17:28:54 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:28:47 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, matttbe@kernel.org,
 skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
 Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 2/3] selftests/net: ncdevmem: add -b option
 to set rx-buf-size on bind
Message-ID: <al69Pw6/5M8jCM7y@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-2-34bf6fac941b@meta.com>
 <CAHS8izMz_S8K80EXn3oFXiDNkGuPUMzjecaJjAvaZVky-7O40Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMz_S8K80EXn3oFXiDNkGuPUMzjecaJjAvaZVky-7O40Q@mail.gmail.com>
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

On Mon, Jul 20, 2026 at 02:15:42PM -0700, Mina Almasry wrote:
> On Wed, Jul 8, 2026 at 3:55 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Add -b <bytes> to request a non-default niov size via
> > NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
> > udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
> > hugepage produces one naturally-aligned sg entry.
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
> 
> > ---
> >  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > index d96e8a3b5a65..a16e55af51ee 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -40,6 +40,7 @@
> >
> >  #include <linux/uio.h>
> >  #include <stdarg.h>
> > +#include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > @@ -61,6 +62,7 @@
> >  #include <sys/time.h>
> >
> >  #include <linux/memfd.h>
> > +#include <sys/param.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/udmabuf.h>
> > @@ -79,6 +81,7 @@
> >  #define PAGE_SHIFT 12
> >  #define TEST_PREFIX "ncdevmem"
> >  #define NUM_PAGES 16000
> > +#define MB(x) ((x) << 20)
> >
> >  #ifndef MSG_SOCK_DEVMEM
> >  #define MSG_SOCK_DEVMEM 0x2000000
> > @@ -100,6 +103,7 @@ static unsigned int dmabuf_id;
> >  static uint32_t tx_dmabuf_id;
> >  static int waittime_ms = 500;
> >  static bool fail_on_linear;
> > +static uint32_t rx_buf_size;
> >
> >  /* System state loaded by current_config_load() */
> >  #define MAX_FLOWS      8
> > @@ -142,6 +146,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
> >  {
> >         struct udmabuf_create create;
> >         struct memory_buffer *ctx;
> > +       unsigned int memfd_flags;
> >         int ret;
> >
> >         ctx = malloc(sizeof(*ctx));
> > @@ -156,9 +161,14 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
> >                 goto err_free_ctx;
> >         }
> >
> > -       ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> > +       memfd_flags = MFD_ALLOW_SEALING;
> > +       if (rx_buf_size > getpagesize())
> > +               memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
> > +
> 
> The fact that you are using HUGETLM and 2MB mappings here made me
> realize there is a pathological edge case in the code where the netmem
> size you're requesting is greater than the mapping size, so you
> actually get no netmems. So like if you ask for a 64KB netmem size but
> actually you did a normal udambuf mapping and all the maps (sg len
> entries) are 4K or something. IDK if the code already handles this
> well with an error or what not. Worth checking.

If I follow you correctly, in the case of sg len == 4K, and requested
size of 64K, it will fail the !IS_ALIGNED(len=4k, niov_size=64K) check
and return -EINVAL.

> 
> --
> Thanks,
> Mina

Thanks for the review Mina!

Best,
Bobby
