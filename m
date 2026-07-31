Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D670C55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9465F10E247;
	Fri, 31 Jul 2026 22:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C223PJQp";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9F010E247
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 22:01:05 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so17485285ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785535265; x=1786140065; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bvrQ6elHBjzw1ZZIATnQHAMJ2uvLdDDK2nT5pKMJu90=;
 b=C223PJQpDXyT7KyZpjAWS6GBCLcs8Fqi0oCks4Qm4Voe0NICpcwbWQ8HPsSa+zoELN
 qs2d60qzxGtzHM/CDjP2jtxiB6H12uHcSxoEIrtssIPyhtA/PBlKkKxuqLaBN/bGy4iL
 fqDZ7W5rlOgEcmK79Dt/UZRo6RQWQTQBOhV4zH3nYMu2OjQsNvmV2Bom1wKlyGuxdwJx
 16HmcHmulrcbe9l+BhREL6vHMTJ4h8iTV0nWk/rJhxIhwVp10LdpRl6BR3gM1m4UM9+N
 CaVh+CdBxrKrOBcWN/jRl7R+AQm5WRfZycL/vkftqSpaOGP+aeix0oCgRzY2MkrcTFvk
 SH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785535265; x=1786140065;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bvrQ6elHBjzw1ZZIATnQHAMJ2uvLdDDK2nT5pKMJu90=;
 b=coqraL8gpkV8OSqCF1SemSJ8Yc1QKmttOHtwIRDTz3uHmxyNAVbx62Xj7Z2Gku2XE6
 Rs8eEto1yzHdtMeC+HB8fSJq1oRJFpbqbPwcvN3vQRbV3VoAklz30gZ/c/D9ymDdmkBg
 L4hfY5lknVx6CxMHv+ccb+UQRYGcelM1JUA+wr9LaMkye1Nh/ZNcb1ldTD09cykUCymB
 F7dRqOuQBFJ0IJTOqSek8gSNRXGst5p2vZOcCUvuRFiUQ9cg+ttq4uVE1i1DNuyHTBHI
 h4f1WQg9oN/Fgah2J1AoLXuYO9GTwmn7W85TeFmw2qalmCnjW2VPN+/0NGbaGRM58Xn0
 p4NA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4o6+4BbLNpWKm7Ivcrz99wby1loQDOT4O2B+mRJxzyi8w4Lmki428yerII0P7X+nn3NbA2S6PZoA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7bXmbqqVxis5RKALUhd27iUGnxhz7orWs/tWNRf/dIn1J8Yl9
 Ex87rnQfpd5OVQ5H3khMS/tV7giUZSPhSQnpxJIq153qvKjfjOWmjWkx
X-Gm-Gg: AR+sD10t+7fugZosUbOa8ZK7drGnqLURj8m8m0eW56t2xPGHoszo2UUhou7HoGxwlgs
 /xUQwoqIYIlLGLx247F5cazlX+Er2jWkcDSwszm+By06LvaS5bQ4ZEM/ZOoi4FjdHE9rqbSkwfW
 oLKuYeEfXd04kfXHsGhPSo6P5XX6zeX8eTDJPtQ2xGo8MDEyGMci4vvLdRDQ368CEV3GCrHey3Q
 XS14JJV60pSaaAGToIrES+FPHp2/Ny0VQAFJPc/UT5ATEMc2RAazbJ0amXEgn8pZHgmGK9+Nf9r
 dzNDF8DJ43e2V6IfRGQYVwf0sSDHLjaAnMFoXBfdYkZILLBY5JlpNWnpyFyltFfTXXe1pXfYnsM
 SNDWiWnuUu4NTCw4GLkvMM+qE1JGhnjW8C6yVhdYYKZSpSod/gk74SHfcNsuwb/p6Y5XIY/QZzK
 Oq5vpws1shnMmvPvT5JCInGxCvw40GrGyclz907vElNMAQe99eHYfCvI1JkPG6rxu/2oumBfnH/
 cQbXQrO
X-Received: by 2002:a17:903:1110:b0:2ca:c01e:8837 with SMTP id
 d9443c01a7336-2d052428e6dmr13323565ad.24.1785535265148; 
 Fri, 31 Jul 2026 15:01:05 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:7::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b121751sm10403345ad.65.2026.07.31.15.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 15:01:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:01:01 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
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
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <am0bHSeJqcgdm3vn@devvm29614.prn0.facebook.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
 <20260729191649.55ab7942@kernel.org>
 <amvEJVio9XtCn+YT@devvm29614.prn0.facebook.com>
 <20260730151433.6f71258e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730151433.6f71258e@kernel.org>
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

On Thu, Jul 30, 2026 at 03:14:33PM -0700, Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 14:39:37 -0700 Bobby Eshleman wrote:
> > Poking around, it looks like 231.1.167.0 and above should support
> > everything, so fw should be okay AFAICT.
> > 
> > Looks like the config is missing CONFIG_NET_DEVMEM and CONFIG_UDMABUF?
> 
> Ah, damn, you're right. I grepped for DEVMEM and didn't look closely on
> a hit. Turns out there's a non-NET DEVMEM, too.
> 
> Could you send a patch to add the missing config options to 
> tools/testing/selftests/drivers/net/hw/config ?
> 
> Can be separate or part of this series, doesn't matter.

So NET_DEVMEM and UDMABUF both depend on DMA_SHARED_BUFFER, which is not
user-settable (selected by DMABUF_HEAPS and SYNC_FILE, for example).

Pretty sure UDMABUF is supposed to select it, not depend on.
Documentation/driver-api/dma-buf.rst says any "exporter" should select
it, so I'm going to send that patch over there.

Meanwhile, do we want drivers/net/hw/config to workaround by carrying
something like SYNC_FILE or DMABUF_HEAPS, or wait and see about the
udmabuf kconfig change?

Best,
Bobby
