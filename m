Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D44C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43FFC10F40D;
	Thu,  9 Jul 2026 07:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PhYc/OCM";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E5210E520
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 22:03:06 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-48f0e5e6698so42081b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783461785; x=1784066585; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r+Cz/DGzX9LixlJM1WDO9JL3XKhxalEZ7sqlBmeIS0k=;
 b=PhYc/OCMcelHHXGcO6wAkxktP5SsqVR0rc/8kqpgKoth0g7K2kAJ68mE9gSFyU9bNU
 m4hBeWMqs2muovGW+hHUhOxh337FnxRXoKwHeNDJO/KNlkScddJgLPF/h5FYP9BYyRs5
 udXTygPsAGTYb6CPzfwLeBIEO2UxKBbwDPDOGsZ+hOAdyZWD6UcNCY2vISxSLtgb1hJP
 s9yIcP6+dZoViW6l1/ggxUNlgN3IQ6E23T7pn1d42AeyXFUuoezzclJuGY28fvnjDgWu
 0s2QdnYA1idFzt2Pseruv0YMPRUM2sohvM0IcG8hHof61KRehBwpx2A+OUxJ+wKB5quh
 fjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783461785; x=1784066585;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r+Cz/DGzX9LixlJM1WDO9JL3XKhxalEZ7sqlBmeIS0k=;
 b=MCXmX2SqYVGvB/I9j0E7ILHWp+rXa5MaxrVmFQcYjTLYfXrCgUDiDWakJGsd/l5uE5
 bnyhtpSg5ASwaDnTgCq/12GpdbaC6kK6s01jKm49kPN8oTPjLeuN9x92p2hKMP5Hn1MD
 E0DwNwjOEETPZUhw0jPuI5lODS7pUaa4vHCl0AF0ARzfzHBiLXfT+meBDcMQKQv9HdQ1
 y+x30zR4pY7FGBoDQZCB9+ltTq7AM0EeSw+bcUBUI9eK8kp8JF2i79dPLGdklTQ0XIba
 2S7FB86SkVQ4H2+9ylO8VKjTtt/LdpsmxWbfnDVtIuWBh/o+NZe9gUGwIFxoVGQffleO
 1/pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ928/uVLmq2p12BetLpy9VlqdRG/EvrjQo6L4mQ1IqiOOUQCpKagcMCDKr78f6HyS1T7mR9jo9XCyo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFK31Hvs8dQSoj9NzwXIZx4hR9eAxDLuc5yvH9tlRrOjh/3Mai
 EK+GDKF/su3wy7TtXbAhOOkLnDg70AbB4XO1G11aK+Ok/1tKpTPnzIiA
X-Gm-Gg: AfdE7clnlAnyoLRyONkBdbiTFYIXu4B+eRfyL2V04OkkmUuFEUDSD2txKlZXlE68nFf
 6TSbcj1yuxe7I87p8Q2+iqIMHgWWCfNHC3/9U5ucADacx7G9/4ym9W48vGcz/M4NydAGVJm+YKy
 nUkosW066t9R8ngr20VADZlPdow35d7CmB6jV/HoqDCwqCZ5YYS0tHh5nU1IHUvbmU5RV6av/y7
 Mmx5Rpt2ijVFwEVo7LGqJ091zZLALy1/l9s7U/roGX4UyT/a0XCniIsbZykmDwlmOlNgQ5P9Wiy
 ozTi/yRH+JMO4qwNRbSqO5NqKFwbV2qMUzkxGjMCyqqg4QuKeQsN5UMV88ACKo/RJGhxZF9x0Fa
 4C49kpbMNvV8/lpxRBImnyhpU47nASdkrDmUOCiYL7h2CvWXu1xdj+HN9pCLJdzSLCTRR0u82nM
 sIHRrQfIu3P4x5zxcl3v1rrvVF4xFzksyv
X-Received: by 2002:a05:6808:5393:b0:489:f199:42bb with SMTP id
 5614622812f47-49fdc040ab9mr5109894b6e.8.1783461784688; 
 Tue, 07 Jul 2026 15:03:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:1::])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82f3csm430555b6e.3.2026.07.07.15.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:03:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 15:02:59 -0700
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
Subject: Re: [PATCH net-next v4 0/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per binding
Message-ID: <ak13k4XZsHnGKIOb@devvm29614.prn0.facebook.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <CAHS8izOmA_U=Q6WOO5mcoi2vBps_JFEtAQa3gXk=JcL3rqE1BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOmA_U=Q6WOO5mcoi2vBps_JFEtAQa3gXk=JcL3rqE1BA@mail.gmail.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

On Tue, Jul 07, 2026 at 12:24:21PM -0700, Mina Almasry wrote:
> (I'm kinda reviewing this very late here. Some suggestions/comments
> but feel free to ignore if not useful).
> 
> On Wed, Jul 1, 2026 at 12:22 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
> > On NICs that consume one descriptor per netmem, this caps a single RX
> > descriptor at PAGE_SIZE and burns CPU on buffer churn.
> >
> > In this series, we add a bind-time netlink attribute,
> > NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov size
> > (power of two >= PAGE_SIZE).
> 
> FWIW we may be able to support arbitrary sizes with devmem. Because
> the genpool supports byte-aligned allocations AFAIR. Also the
> dma-mapping happens with the dma-buf size, so the actual niov size
> doesn't matter. The only thing I can think off which may not be
> flexible to arbitrary sizes is the driver itself. IDK what happens if
> you ask the driver to dma into a buffer that is frag size 5023 or
> something like that.
> 
> But that is something that can be relaxed in the future.


I think at least for mlx5 there would be some issues, as it splits the
memory region into fixed-size strides (256B), so I'd expect it needs to
at least be divisible by the stride length. The mlx5 driver seems to
guard against this by checking for sz > PAGE_SIZE && is_power_of_2.

> 
> > Drivers must opt in via
> > queue_mgmt_ops.QCFG_RX_PAGE_SIZE.
> >
> 
> nit that probably doesn't matter: ...QCFG_RX_NETMEM_SIZE, or
> (...NIOV_SIZE). This doesn't actually work with pages, right?

I probably could have worded this in the message more clearly, but this
name is not introduced by this series, so we probably can't get away
with changing it.

> 
> If you decide to extend to arbrary sizes, I would add to the
> queue_mgmt ops supports_netmem_size(size_t size) function, and let the
> driver enforce "it has to be power of 2" if it needs to. AFAICT core
> doesn't need to.
> 
> > Selftests use udmabuf, but udmabuf sgtables were previously hardcoded to
> > PAGE_SIZE. This series modifies udmabuf to respect folio sizes in its exported
> > sgtable. The result is that when backing udmabuf with MFD_HUGETLB 2MB pages,
> > the sgtable is populated with 2MB entries, allowing devmem's gen_pool to carve
> > out large (eg. 64K) niovs.
> >
> > Measurements
> > ------------
> >
> > Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
> > num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov size,
> > mlx5.
> >
> >    niov       RX dev Gbps   RX flow avg Gbps         app sys %
> >   -----  ----------------  -----------------  ----------------
> >      4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
> >     16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
> >     32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
> >     64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11
> >
> > RX app sys % drops ~19% from 4K to 64K.
> >
> 
> Hard to read the columns for me but seems like good perf data. Did
> performance become worse from 32K to 64K? I wonder why.

The drop off struck my eye too, but didn't investigate further. Given
the wide stdev, it appears to me like the trend is positive but probably
not huge. The cpu util deltas, on the other hand, look stronger to me.

> 
> I have some devmem performance fixes that are very critical for our
> production that I haven't gotten around to upstreaming yet. I wonder
> if I can send them to you for upstream submission. Are you potentially
> interested?

Definitely interested!

> 
> -- 
> Thanks,
> Mina


Thanks Mina.

Best,
Bobby
