Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3CC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E72610F14E;
	Thu, 20 Aug 2026 17:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="J+L0q+nW";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BC010F14E
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:47:41 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93703cc9e2dso2997985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1787248061; x=1787852861; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nhC4gcMj6qZbqU/PjOfQzYKyx+7NDJFZ4HXjtdF8h8k=;
 b=J+L0q+nWuwpvD4sJj94Xei19j5+4Rqa1EQwCaQoIWapoIrrONJfMXYMAcseuM16bKJ
 fAs4VNQ7fcftYnLFPbulfaUvcz23iAzjOyIpJUkrs24FrBLNFET+7d2PF1M9+N9I9Xzj
 VCL2nuo+3odKxtCkWO+e6B/Pqfa8kIa3EnQ7EPHm0q+5jUtivW9rZVacv5Voaj7N4sQ5
 3/DrPeFt7eASseauPKSDIUYlxqn9KwBaiLnC00zc8Qs6lRNABg2RwCgu3/HPbQelGZfv
 4BUSH/DgxoGteNKC/IJaS13luTvQb8Qh5Jjv6GSzL5atZ3tJ35qh43YDyz1tGsxvRmHQ
 uChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787248061; x=1787852861;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nhC4gcMj6qZbqU/PjOfQzYKyx+7NDJFZ4HXjtdF8h8k=;
 b=fBaxcGUp9JdP4w54ciRatCRAylMQPWDtuYLD62mNIGUwzJStbhoUCHQgE5huLZF2QO
 QPXlkZzW1/FkbUvDXnS7D+Al5zgx7Y6MZwSn5PdTfCi3jDf0foYKrO/MUdplRuFG9eUy
 Sdy5h7zF79GcFNVyus06cd3kPh44jZWjJ9HoN8WOeSjQVt+O1LYbjqyyGsNT42e4WBQa
 FFNwJRDI4dNLwtXk0Nii3YUUxrTO8yxHut4FUUu0/MEwCTTtnAQgM+WcJ2qUsxw0H+MZ
 dppSNZICdQT/VF/4MqLNoEinZIJKmKmL+dXszG1kE4MKbdXrOrJEN/3RIJdlPi4ltQnP
 M9OQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbOq9VCNhsosA5nJiXuNW9KgshpKDjBEAqWIB23Hb8jdGUQUAskYEzkiAT/Cl2L4x33dGnMBH6b+0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqEG1gkKl/Yni/su8Jv+s+h3ps4dvLhJqa+5H7ShiV2KSXLLIO
 T06y2UCcqOYJQI1k3Wh8eYG5xVmDXpPskTcqKcN0MFJxTedt2Yk38aa5eVo2Oozhgz4=
X-Gm-Gg: AR+sD137BS4T5wos98DDHM+GwDBuo4hkU/m5jQ438ZBuolp5O3BsrVBjalnSrX/+uPY
 wmmj1ygClea65HVKTQaRx1zpdcBBGE2HTJ3IhgIWDMxmfhU/mZN7FaAVKp0TCRnzfyRjI3AfEbm
 QM+GsOPmCc7H0XcEE5I/BU95iYKYEfNp4KIQpVko5M+ZAO1y3zc7t3+jGNd7s0eiaQaQg7TOVCT
 x2Bqha6w60flEh+6azR/jfzx+8evwc9v6z+6jPnzlEC+bSK64shQICL0FSdn3u6mAWbxW0qiqux
 jp3fSkphzJXg6Dxi3gd79qrEks0ffkkbl8tlRPCwlZ0RvswPMzq3IVsQYLTCfQne21zgKpEY/NG
 UDE9/0tim9qt3WrK6wrR2iyK93Hb8HCXupQMtirTTAPgCKj2MxqasS0MuEo/ijXMb/WM5HOqetk
 u1zCNKK1tFZYHn2Z8Ctfn73XZgVGmuk9sQFrInKgetRaIpnREP5CzirlkXuIUCt7n0fHZKQWmIm
 i04zXGIg+E/iS1k2aBrXcN1U0+mZqCm/dA++ZsjpbXn4w==
X-Received: by 2002:a05:620a:3712:b0:936:9f47:e908 with SMTP id
 af79cd13be357-9371e259c99mr1294064585a.19.1787248060787; 
 Thu, 20 Aug 2026 10:47:40 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720493f40sm418053785a.1.2026.08.20.10.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 10:47:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wx6rb-00000004ADY-1Cil;
 Thu, 20 Aug 2026 14:47:39 -0300
Date: Thu, 20 Aug 2026 14:47:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Price <steven.price@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Marc Zyngier <maz@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 1/4] irqchip/gic-v3-its: Zero shared pages after
 conversion
Message-ID: <20260820174739.GA981928@ziepe.ca>
References: <20260820150034.88729-1-steven.price@arm.com>
 <20260820150034.88729-2-steven.price@arm.com>
 <aoc9CyxGPHPKFH1N@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoc9CyxGPHPKFH1N@arm.com>
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

On Thu, Aug 20, 2026 at 06:44:43PM +0100, Catalin Marinas wrote:
> On Thu, Aug 20, 2026 at 04:00:30PM +0100, Steven Price wrote:
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 6f5811aae59c..a055837832bc 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -213,16 +213,18 @@ static gfp_t gfp_flags_quirk;
> >  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
> >  					 unsigned int order)
> >  {
> > +	bool want_zero = gfp & __GFP_ZERO;
> >  	struct page *page;
> >  	int ret = 0;
> >  
> > -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> > +	page = alloc_pages_node(node, (gfp & ~__GFP_ZERO) | gfp_flags_quirk,
> > +				order);
> 
> I don't think pKVM does any scrubbing on set_memory_decrypted(), so it
> potentially exposes confidential guest data before it reaches
> clear_pages() below.

IMHO that has got to be handled in the arch code implementing set
memory decrypted.

Further pointing that maybe we should have an alloc decrypted so we
can at least try to minimize the number of times we write to this
memory. :(

Jason
