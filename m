Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24BEC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F408210EEF1;
	Tue,  7 Jul 2026 20:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="X9vSYDDQ";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6AE10E2FD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 20:36:32 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso3925ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 13:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783456592; cv=none;
 d=google.com; s=arc-20260327;
 b=sNpPytU71/uXe+FRERVQc8QjsffcE2JkctC0ButG7IlX+CXcwn7Yyc1XkV585pEwRn
 isYAToFMdbCpsL1OwwR7nrZP7tkFLkrBf1/3Fy6LLgUwDyhDNxckk0Z8YP5rZ1DSuh72
 qqULvn7spi+vHNJ9vEC5OUZpduaO+6h3TmYWPECefXZUXMPZDodYO/E14eXbANdjtUd7
 ESf5hAcD32E3dPsJm6MEOTdR55enE3eRxE6+7NBpWvOzj/HOxy7Bg5OlKqOf3Ux+6R08
 yCRrdLRbrJOvbNFGMTIXYKRzbtamQu5r2Z5os7ji5RUNxBawMguJkmk0UXoi3/NPU5+U
 sA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jS1etq2XBh0Y21n7kpErG7DuCVj3yAQ6JGZ2x5w3TvE=;
 fh=ETLYN+c1krLdNkmVSvnfdhFduJyyZOrMgpEIylautKw=;
 b=NiTfyd4UV/+MZ5RZ1dYGn9BQIlpfQ8dhZdcJOLjSLovN1DNxfW9wBy7f8ifqq1oSqZ
 H/Mvr6c4W0wHeb90Qlk/cBr9SD9b/Wpv6HLtgyw0E2X/Q0mmTZj37IR/e7gNnxteKSD6
 4Vgcnpr71XBvwC02aWvzaFC6bTp+uDcIpln15e3lj5g66hsJPJlb2dwdHHwwrTzvOm+2
 1HVdY8ND2E0rNCsIy22TJAxIqq+L91IYUnggJNxQcMC3LFDpFwK/PecPSnteluS1qFuz
 yygioW5PPVMtwXjGhQHD+sC1sKGZvcQni2NGRa++LrYf1zQEpPd+eo+mWBtEfPEhEIfX
 R86A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783456592; x=1784061392;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jS1etq2XBh0Y21n7kpErG7DuCVj3yAQ6JGZ2x5w3TvE=;
 b=X9vSYDDQlICS1wQ9IfvAOOLaSh2e4QBpA0ln5n4IErW2+6ieDNMe3Y6KyYpBY8OjPV
 fEZ4mkCXL4lthwSOxlcmbtRqbmS0C1Sp3RP4Sio3JhIbCEyXnisGgu9hXMrR/F9/MNXt
 gNs6y60wWT5XGCBO6g2aZMnla/Yl9YBcALNnWdOMnlJ4+yYouWyJgTYcMRq5kPrp+9SK
 jeEpkAJZ+QIUMbH7xsSzuWgSFv7NnJoAfagyPGualGKCrGcq3uaIepBTizG9MEem1ATr
 SJN0d+uQtKE3Pi1MvbhXv1C3vBigHiP2hBgKEJyDPwXM2lqwO5j9TjAhgx/HZtOigbrh
 FalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783456592; x=1784061392;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jS1etq2XBh0Y21n7kpErG7DuCVj3yAQ6JGZ2x5w3TvE=;
 b=ejvtFcCscOlz+RBvshJ5cZaSnDCYk0wVUAfWrA0uo6rI/UDuDehV9J5E/12AxTGEtZ
 pkzL9e6GRaScrUJtmxpdhUIPAThQZ4gNYmdEG+3iJyzA/nEO+8t0u7bZZZ7wqvX8+Dmk
 fxAIwW5q8jVgN5JmxYrnOfXI+Sz4rGVV+BtbHdZdjqK6unCgVRmMXVWYjyKMSFatNmx4
 US+UkOf5NVttguhcqT4CVOhG/Hx4WQ9eGsO9g5xptmkrL4kpJW22yrdrcFczzpgg0wtF
 hr10cb0/FUj32vtFI3Zkwz7a5rr6FVMDA0by63XCnulNIzI/m9CQWv4Qt0Px+hi6EcFj
 +rag==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3XA+WWFqjre/jk6k5aVqERI4QGUyXgZDgG1NXP7A5ux78a4s5FkV1OsXwVsjgiDhgzOLp/2qZsHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2nBA6MWpAjg4i13zAgBl15xWL0kuBmjzEgLgfveEYOrX27dfh
 bJWK+ySlpk3yR9EnfhPCShy0EyL/qqPa9eN8OyEI2+sqrSb5wmEjrrcjLpvizOKCWenPX/ZffDg
 vws5s3DyPiCRjTF96zWMz2cnUr788qmOaMVkVl1Br
X-Gm-Gg: AfdE7cmQux31ulzHx2ovbbXeAu8PeDSTc/SfZoTCNSL/mimK1LoyIE+xbwczS/fyos9
 yM8Nqd3CXW0CJtCPHh/VM5pzdGFXftf4FoVymC5IHFU3XfCMA9XmqnQWjV1CkT+Fkm+uQKz9UTa
 zyQTs5XanPKNZ4LoAzm9HwPFS3CfcCLAln2SWRRi/Zxj21nF+nV/bmCq+NrRuEF0C7+dDQT1+VS
 fbHRMDpA16J7MD05nSrR7wC+qnrbY0PItUDco0/zPta+JDQlAsS5rn5i1AHstnd1LgZTWru7C4r
 fZuy9eQklAa+Kv53xo/ayF7bdmrjObtUqa1FNQ==
X-Received: by 2002:a17:903:1746:b0:2ca:e513:17a6 with SMTP id
 d9443c01a7336-2cce6070055mr514845ad.15.1783456591431; Tue, 07 Jul 2026
 13:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
In-Reply-To: <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jul 2026 13:36:18 -0700
X-Gm-Features: AVVi8Cft8xhwKuUJQBVnGzgYj4CRKQzZAZeZD_sYSlOKVL1n3UGciPvnN9lcbO0
Message-ID: <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
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

On Wed, Jul 1, 2026 at 12:22=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
> churn for large flows.
>
> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
> lets userspace request a larger niov size. The value must be a power of
> two >=3D PAGE_SIZE.
>
> Measurements
> ------------
> Setup: kperf in devmem RX/TX cuda mode, 4 flows, 64 MB messages, 60s,
> dctcp, num-rx-queues=3D4, dmabuf-rx/tx-size-mb=3D2048, 10 runs per niov
> size, mlx5.
>
> CPU Util:
>
>    niov        net sirq %        net idle %         app sys %        app =
idle %
>   -----  ----------------  ----------------  ----------------  ----------=
------
>      4K   62.38 +/-  8.27   33.40 +/-  7.51   54.15 +/- 10.23   43.67 +/-=
 10.53
>     16K   58.91 +/-  5.35   35.23 +/-  5.88   41.05 +/-  8.87   56.42 +/-=
  9.24
>     32K   64.12 +/-  0.68   31.09 +/-  1.48   44.54 +/-  3.51   52.63 +/-=
  3.65
>     64K   54.69 +/-  5.54   39.67 +/-  5.81   35.47 +/-  3.11   61.97 +/-=
  3.27
>
> RX app sys % drops ~19% from 4K to 64K.
>
> Throughput:
>
>    niov       RX dev Gbps   RX flow avg Gbps
>   -----  ----------------  -----------------
>      4K  300.63 +/- 53.21    75.16 +/- 13.30
>     16K  321.35 +/- 28.20    80.34 +/-  7.05
>     32K  347.63 +/-  2.20    86.91 +/-  0.55
>     64K  332.11 +/- 14.26    83.03 +/-  3.56
>
> Throughput seems to increase, but the stdev is pretty wide so could just
> be noise.
>
> kperf support (not yet merged):
> https://github.com/facebookexperimental/kperf/commit/8837577f920876bce698=
6ec18869ac04439ebcd2
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I'm pretty happy to see most of this patch being a spot-for-spot
replacement of PAGE_SIZE with a variable. FWIW:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  Documentation/netlink/specs/netdev.yaml |  8 +++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/devmem.c                       | 55 +++++++++++++++++++--------=
------
>  net/core/devmem.h                       | 13 +++++---
>  net/core/netdev-genl-gen.c              |  5 +--
>  net/core/netdev-genl.c                  | 19 ++++++++++--
>  tools/include/uapi/linux/netdev.h       |  1 +
>  7 files changed, 71 insertions(+), 31 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 5f143da7458c..70b902008bd3 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -598,6 +598,13 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: rx-buf-size
> +        doc: |
> +          Size in bytes of each RX buffer the NIC writes into from the b=
ound
> +          dmabuf. Must be a power of two and >=3D PAGE_SIZE; defaults to
> +          PAGE_SIZE.
> +        type: u32
>
>  operations:
>    list:
> @@ -812,6 +819,7 @@ operations:
>              - ifindex
>              - fd
>              - queues
> +            - rx-buf-size
>          reply:
>            attributes:
>              - id
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 2f3ab75e8cc0..85e1d20c6268 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -219,6 +219,7 @@ enum {
>         NETDEV_A_DMABUF_QUEUES,
>         NETDEV_A_DMABUF_FD,
>         NETDEV_A_DMABUF_ID,
> +       NETDEV_A_DMABUF_RX_BUF_SIZE,
>
>         __NETDEV_A_DMABUF_MAX,
>         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..3d6cf35e50f3 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -46,7 +46,7 @@ static dma_addr_t net_devmem_get_dma_addr(const struct =
net_iov *niov)
>
>         owner =3D net_devmem_iov_to_chunk_owner(niov);
>         return owner->base_dma_addr +
> -              ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
> +              ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shi=
ft);
>  }
>
>  static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
> @@ -90,16 +90,17 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_bind=
ing *binding)
>         struct dmabuf_genpool_chunk_owner *owner;
>         unsigned long dma_addr;
>         struct net_iov *niov;
> -       ssize_t offset;
> -       ssize_t index;
> +       size_t offset;
> +       size_t index;
>

nit: I would keep this signed. Some of the most frustrating issues I
ran into is some of the underflowing and then passing a > check or
something. Although if the LLM is not complaining about this
particular case, there is probably no issue with it. I also notice a
lot of existing code that deals with indexes and offsets goes for
signed.

--=20
Thanks,
Mina
