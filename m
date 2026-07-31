Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D13C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89DF10F0F7;
	Fri, 31 Jul 2026 00:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WAPtDoMM";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7FF10E139
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:17:59 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cad8076b01so4005765ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785457079; x=1786061879; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBitaL1RUUQqXSfqSECtyVEDWdgVsoCHsw/mJvM7Qu8=;
 b=WAPtDoMMs1Ra+HCYAvNBZ13TzEUGDujXJxFEseiSbk/4lHb2nxzUz0Ltz4eXy+nFjZ
 v3N7FwlLetlI0RT/y5tY8uYmFaSdDUhDpPtkFHREYwlqNzGa8LmDFWLpV8Q3sRAriG44
 jauBBcH0QyD6wrr+ZldMx1rvtQmYbeN06XhJOfWw5X5zmo4GJL+oeI0q0etHQ5d8SoTD
 SEyNUItXy23hV+DMcWhlJQsz0Pg2eqsQRtzxgit4KB1epmNlkTdCU2xh4NhkGqNNjDt1
 jfWhJ3S8AxRieHJv3p32JUY9z/6k046xshg0BVwJRsud92kncXgdgqJrVAU0YrkneDjV
 WUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785457079; x=1786061879;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBitaL1RUUQqXSfqSECtyVEDWdgVsoCHsw/mJvM7Qu8=;
 b=jBAcuJoiNR+CXoOKfCOqADWKxMiTLUOzK3aRyuxsGmADh5lf5UZZRq5FLBZ0Utad6+
 2liZ3lWFjI2GCAKyFjs/0JPa8EN1b1LlYaHCVp+5luxkCb8iAIQ50Z9Q9uunSC/6GMdp
 XKp3/vRHYcyFyLCPPaZYoKGqER4RSMekwZgsNqqRL0+ovKBRTC9DYncpj+vUb5YfOZWt
 fDR2f6gUPMfSsm+3F8/zxPqYrx2/BpBD0Vbow8FC8+dMq8lC85nF5lazhq91nihzUm5x
 CrzoPGc/DRRmpbc/O3Zo89ndl0O5Z+LM6861jjanK0SCB22CtSxSPpiv46spD0lzx9jN
 zAjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqlkf8pLfwsLtWmJKclIz7RYt1wCe5vX5SKA1/OC8pozFWoKH1+NQXQ/3d0vx1Q8o2XRkhUHoQAna8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBmNpgkOnqcJrUORGCXZ59M86GnUL+kz6vUmaYYezihM3W3fJg
 hrR+Ei8YPQqTtKE/Ct1VWiAPD5kL1Te7TD1S7Wm4WAWAE1f+121yzOYQ
X-Gm-Gg: AR+sD12sOpevyN2yS4Rnii9uj5I7xE9bNmENTIM2E3FfYKoeecm0lvkIz4xYiDVY/y0
 +WGCiMLkfVYC9l6w/eCN54sA0XjkgHo2wrfzm93uy0xZfur8654wLWZINNGFytVABb+ad9rS436
 /qJ8/CNBgeaHdVlTUKhRFnsfUCfmoG/PxRXIWGsJ+iLdvqgZK9Gu2AlXFcMW8ve+9aMVBaIiqSk
 GASkN7/4hp7wT4ls+a2Agw7OqULxk/1YgM9Oe0SBkvligtUsqU+qgPMuaCId656I/J2TaESinHy
 ajlaIDiLgruOZKPli6mZyl/ediLGpU8CSPwoEOshRLWVo9VF5blD5PybjhWKeUzoDWOuPPU5RXD
 loh0Vh3KOKOU3i2hLRPhyFOO5RYeP2bHPi3mNLfNd0vVDXi+QDd4dUX0/tqs/fZh+WIoFvZqvl9
 7gfuDrvWL49XjhQkw4KqM7OYSl5am1ItjN7oWsoa0LlQKcU2/1TMd/zeFjfy3y2zMhcq0hxWt7c
 kI0oRK/27U=
X-Received: by 2002:a17:903:4585:b0:2cf:bfbb:61e2 with SMTP id
 d9443c01a7336-2d046eadd5emr478805ad.39.1785457079096; 
 Thu, 30 Jul 2026 17:17:59 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022c8b9aasm32885005ad.50.2026.07.30.17.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:17:57 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:17:55 -0700
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
Message-ID: <amvps7AAHxjvxbhQ@devvm29614.prn0.facebook.com>
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

Ha yeah, I kind of did the same at first too, had to grep for
CONFIG.*DEVMEM in net/ to convince myself.

> 
> Could you send a patch to add the missing config options to 
> tools/testing/selftests/drivers/net/hw/config ?
> 
> Can be separate or part of this series, doesn't matter.

SGTM.

> 
> > Sorry, took me a while... was certain it was a bug in my code.
> > 
> > Not the failure here, but wondering if this was on ARM led to seeing
> > that 16K hardcoded rx_page_size in run_rx_large_niov() may fail on ARM
> > with 64K pages because it will fail the IS_ALIGN(16K, 64K) check...
> 
> Ah, good thought. We've been meaning to get an ARM64 server for NIPA
> (our current server supplier is out). If it's not too hard could be nice
> to guard against that. But also not a huge deal for HW tests if they
> fail instead of skipping.

Sounds good, I'll throw in a skip into require_devmem() if rx_page_size
is passed in and doesn't pass the alignment check.

Best,
Bobby
