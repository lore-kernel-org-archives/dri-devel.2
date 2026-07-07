Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0FDC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 19:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5046610E185;
	Tue,  7 Jul 2026 19:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JEGhK/GO";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A867610E185
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:24:34 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso22215ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783452274; cv=none;
 d=google.com; s=arc-20260327;
 b=OmUnJPMUFecI9ycPLS2Gtx/iAg261NGQxbqxUGw7tpSALa1VwWePcTZOqv96ZCNaS/
 zdle3rcLodChdjb7SaysDZ9ZfZVJGD+ZlYCBAi7IDl/kQm0NC8B3kCUAFTtBNDtXlcbY
 ipRAzGaOAwmSzTyyOfyffJJcR/Fu+38Ws/Q6T4Ye8CpefeiG0W4f9OPsHi4bw6dL4QYs
 Iulq0SockpZiHYzL4/CGf9R+awAtk/CegzW55PaRZHNUbauuOWjsS5D/yIKAozSZ9cTJ
 KGuJLiXAsyobQRF6DHw8w0AEmB/H5ZmPWbQoOxWzFzef4jlMgvMGq4EDMSL+X/S/4U3N
 UVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Fm7QjNSE0IJ2/34q+H/eGUWaQNYPo+v65MhhotHihY=;
 fh=7jCHR+0ylYw7yqHWtmjeH3JQHScgxeLpM/njsuNm0Uc=;
 b=RsHvk3T1DHm1aWVamO4qKuH1r1jX22Y9YxbRIMMrN26nIFHv89jbeu0OJFzlx2rxOP
 3DMU7Bt2C8X4fokzrpaljZ6r0sHIXFEkvM9d7caGzDiilExgYP6AtafrLIRYCmDKkzCG
 u1Cbif048MuNzT2oYJaVSQa4ezllxCdOMJLO9vHAbwp8Q/Jpnq6E731EX/jHenah028C
 ZcpflycIpj/8T8KezlPDZMrnw2SOYsMm2w/WXLEy27T49K0Syt81MDsV3zH/4OZK3Yl+
 ESPubIQDo0pEplR7ADR+L7FZ4XeKv7cg8zXc66b3A7AWogwM978U/s0E9y72n1UZQnri
 Ah3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783452274; x=1784057074;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Fm7QjNSE0IJ2/34q+H/eGUWaQNYPo+v65MhhotHihY=;
 b=JEGhK/GOoUPLf7G8oaiBkHzoZamRXN2tgseq66yTIe9cwwpQh5eKaMzBX04thWfspM
 +eaWItRQfgwBxZ7uHr95fzaGfDt+P1LtbtG+MmguljpAqTVOx12DgZ9NMIQxgPmwpPGi
 4PEi68f/YzfCDEwU/PASRSGibMGhlFmpt0I/2ZI+K1QSL+5Yc/XXFbFKXAfHzH2f17A7
 mWRMW0CqHbaKBJBkZx1dIwqfdNCy9f0wsWKgdSMDxZ/ZpzVkqX8xBAFyYXR+8G/IpngU
 rcDKlJ/U1UFkfwzYK73Sv3ZEu/NOPGg83lvKXrazpeFRE9dlC+Ma2NCB/Xiz6Hz/jcQ7
 EvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783452274; x=1784057074;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Fm7QjNSE0IJ2/34q+H/eGUWaQNYPo+v65MhhotHihY=;
 b=eFvjAdaTkxouQTVBUgaR25NjCnPsZk5FQmV7nj4rVoZOQsjlXg+OorlK//WvD238L6
 ZDw8tJsFLKB31m+ZmHv89kIU6zvPGJDeCiA02RA8DJRutZ1AifrUJNXoyV85qgB712B9
 /fZu1neYX0xEb1tT9j3rSX6hTNUo2jRZ9db2bTPJCI92n1fOgq9ZeE+rVbheTtz/uykJ
 XGktle4GO4ehl99C9JV9/L8kaxkfHfRz6nsywppENdzM8J+7ZvkVZtFXrA0+4CNXv6zx
 q2Aa0B4rs+3K73Bke3uVP1+4nOj0V2NRVZRpiyVu59Ftiha5tEtqAMDug5sacRf5fJ2O
 bCFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXnCIuNQqnmthcAjtXpHTCzFJg2rlLRPwzGfiLV1pEf6e1KRn2N19EcKKVPyhLhGme4y1Wwn9WFI0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrG26/lEQP5jMh/JlgKMWu1NT2IJoVOfI7ozgtDy7QVh+bfoDc
 yI9vDEwh3+0os8ruYUtLIMFKA2LIPME/f1JsRYYMNS5wPA93O4b+iPZf4jo9FhG21IlVAhs3kVP
 RUgK8bYNI+eJ7fvYAoawGfEOAeCONliMLQpY/LGax
X-Gm-Gg: AfdE7cl/E+p6ZSQDOBULnsBAbD6nJDnr/2qrxmSQSUlLI3XXTtRt47iW/1mWfhqoGH/
 b4y5VMXDK7dmt3gsdgrtNi3yZZK1Eh/hsHYyXJBa6s78lF9WdnOERu1kIWYKanCRwv3liIcMWWm
 k2UlXUzRsI85DPbkDRuTHv4Exl19pcQECKVwiMWsV5JiCpG4p6ynD+mlrBYFn2sbc3zsLAwfd4U
 IXDdjrXiua4/6guC0uz4WPFHz97FH9f1LQQ/d8AqB7HbF31HB8M1gxmHvRB+pcGZFat8acuybm/
 rThFz+o4OF/+J5hSAH5E1PpOMPY=
X-Received: by 2002:a17:903:13c6:b0:2cc:a859:d404 with SMTP id
 d9443c01a7336-2cce6093926mr513125ad.23.1783452273682; Tue, 07 Jul 2026
 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
In-Reply-To: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jul 2026 12:24:21 -0700
X-Gm-Features: AVVi8Cf2zkjvZFmISVUtPxc7XWtQGIP2yN30jA4uYxFxIOpN1CJ2PCF-gRvgh1w
Message-ID: <CAHS8izOmA_U=Q6WOO5mcoi2vBps_JFEtAQa3gXk=JcL3rqE1BA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per binding
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

(I'm kinda reviewing this very late here. Some suggestions/comments
but feel free to ignore if not useful).

On Wed, Jul 1, 2026 at 12:22=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
> On NICs that consume one descriptor per netmem, this caps a single RX
> descriptor at PAGE_SIZE and burns CPU on buffer churn.
>
> In this series, we add a bind-time netlink attribute,
> NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov si=
ze
> (power of two >=3D PAGE_SIZE).

FWIW we may be able to support arbitrary sizes with devmem. Because
the genpool supports byte-aligned allocations AFAIR. Also the
dma-mapping happens with the dma-buf size, so the actual niov size
doesn't matter. The only thing I can think off which may not be
flexible to arbitrary sizes is the driver itself. IDK what happens if
you ask the driver to dma into a buffer that is frag size 5023 or
something like that.

But that is something that can be relaxed in the future.

> Drivers must opt in via
> queue_mgmt_ops.QCFG_RX_PAGE_SIZE.
>

nit that probably doesn't matter: ...QCFG_RX_NETMEM_SIZE, or
(...NIOV_SIZE). This doesn't actually work with pages, right?

If you decide to extend to arbrary sizes, I would add to the
queue_mgmt ops supports_netmem_size(size_t size) function, and let the
driver enforce "it has to be power of 2" if it needs to. AFAICT core
doesn't need to.

> Selftests use udmabuf, but udmabuf sgtables were previously hardcoded to
> PAGE_SIZE. This series modifies udmabuf to respect folio sizes in its exp=
orted
> sgtable. The result is that when backing udmabuf with MFD_HUGETLB 2MB pag=
es,
> the sgtable is populated with 2MB entries, allowing devmem's gen_pool to =
carve
> out large (eg. 64K) niovs.
>
> Measurements
> ------------
>
> Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
> num-rx-queues=3D4, dmabuf-rx/tx-size-mb=3D2048, 10 runs per niov size,
> mlx5.
>
>    niov       RX dev Gbps   RX flow avg Gbps         app sys %
>   -----  ----------------  -----------------  ----------------
>      4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
>     16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
>     32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
>     64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11
>
> RX app sys % drops ~19% from 4K to 64K.
>

Hard to read the columns for me but seems like good perf data. Did
performance become worse from 32K to 64K? I wonder why.

I have some devmem performance fixes that are very critical for our
production that I haven't gotten around to upstreaming yet. I wonder
if I can send them to you for upstream submission. Are you potentially
interested?

--=20
Thanks,
Mina
