Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74137F94CD8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5FC10E222;
	Wed, 22 Apr 2026 07:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="CFIREPaI";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D849F10E222
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:51:12 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48371104ffdso6117695e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776844271; x=1777449071; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoRr8QDMIzfqgX7VNwrYeGw2tZtA7cdSKtjPSj3Z59k=;
 b=CFIREPaIV2/MHOT/d/OqkNKeII6gJxQ6aLyJlk/Zw9YpID2NYx+ZcbmblpvjoSElUV
 Hd5QO+Iw8QcSzU5kdm0j9rXxe7iiApcQ1Utr01jJZyqCT07raCG/K3RBrvNdi8JYGvky
 tCWs1+F5mRh2zUuyEVTShh3+Rg+JdWZESUEsFSGwG0kRTYz5hpbfYBIO9em9H3rVsPv+
 NTYrcjGH02Th4hKjGt09nPcLPWJt8EKS3F+uSAlUYSGDH3WcLVPAt1ZkmWN9bpCmI/JG
 0F+zos04L76vlfYE/huqvt7LHavaxvhDTi0SsLD8yRZTPJCfuf2kLukGVafmk74gNc3h
 ZhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776844271; x=1777449071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JoRr8QDMIzfqgX7VNwrYeGw2tZtA7cdSKtjPSj3Z59k=;
 b=fQTQmsiC7vVEzcwjk42hxMi53FmmGamdrVS4r//LFRhvmgnycMgUU1H44/ehUm+Y7M
 N9i3oEgHIwFIN5eFb1VIPZnRQCOMCqyk06Le43gxkJLTG5xedVnRO/+aiZDr4MIGYBJi
 kFKCc66X0NA9oOL4oTKTvtW/TOps0JjjkRE1eAI+/B2jj1svz+G0ZKZC+DWEGlFm5h6R
 +qwp9ehp5f7OAz3oEP+qF3MMezjKbQ0O0nmKPeHV4WW398/+PYZ5SMe66EnuYi10ol9b
 oVBdvZnMFX9YTWTd76BzL6zGEYGofn4SeNNKG4THdRkZK1nR7w72biheMvOVB8BhR+lT
 lFSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ90Ky1FZaUT/PA0+Gqgcoit+qSPObNFRM9/ypzYoNa08jG/FiNZlL2JaqbsokS+DEGRKfmI3A1WfD4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxb8Zuvs9Pdl+JJNfh32hVPenjnzjDRqWKaJCaveNGsDXBnNAot
 57rosLiEgCW5zR6nSrmEm1WuOEGXk9+WQaTfatuPJlEC5jEVAACZWUW+7fV7Et8zS2A=
X-Gm-Gg: AeBDiesS0T/Mlyyj40yQLGEyA3U8nDXk5g0eo081DtU1NBEUumGkzwCfOoq/Udd2lOG
 Lq7ierpyOW3UUwpKAUQkUNjk+46CpNFL3z5C39whF8KPO9bLgUvIrsIO+T7Ps6qtVFi4TE5Zdfw
 qH7IF9QJMotgU/laWYeIL2U6vYD/D48Q8z2v027PrJakHJiQWvOQsC9wLGIZbbfYPeBYH/F9sMi
 YDUk1oCR6YlbCzFlvOmzkaqbwGrRQalpREXYP+Cuc/xxsCMawrIazZpVAfa1YU5/RPQCQIkb3Ew
 P85jS6nwnisbfIPaUzAKh0+MjvTP1+UFULxKYtwDLJUt+/2J5dEXU7iyahOJKsjJ9D1OCoDo8ZH
 FNJh0gtNbTkHJYbcqQSxg8ALNx8baTHnFDXqgY5UjbYaMZRNjjsTR+jMWeieMZ1qazrHPsHjGOH
 pICCzzEnWg+ZVrP5FmXHn7kJqSKIvQPj+AAmu3XqP+z+YCbANOVLMLxLpgPBAgejYsyGaF9+ihZ
 UNJa8pnK3e4DFFF7e5Wt/Ppuik=
X-Received: by 2002:a05:600c:314c:b0:48a:5664:f44a with SMTP id
 5b1f17b1804b1-48a56650076mr45995745e9.2.1776844271346; 
 Wed, 22 Apr 2026 00:51:11 -0700 (PDT)
Received: from mordecai
 (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz.
 [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm39579398f8f.32.2026.04.22.00.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 00:51:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:51:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 catalin.marinas@arm.com, suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260422095104.1b3c4132@mordecai>
In-Reply-To: <20260421121004.GA3611611@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 21 Apr 2026 09:10:04 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
> > >> You reach there when is_swiotlb_force_bounce(dev) is true and
> > >> DMA_ATTR_CC_SHARED is set. What am I missing?
> > >>  
> > >
> > >So a swiotlb_force_bounce will not use swiotlb bouncing if
> > >DMA_ATTR_CC_SHARED is set ?   
> > 
> > Correct. Bouncing does not make sense in this case, as shared memory is
> > already being mapped.  
> 
> It is a little bit mangled, there are many reasons force_swiotlb can
> be set, but we loose them as it flows through - swiotlb_init()
> just has a simple SWIOTLB_FORCE
> 
> Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
> selected for CC reasons. For instance if you have the swiotlb force
> command line parameter I would still expect it bounce shared memory.
> 
> Arguably I think this arch flow is misdesigned, the
> is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
> the correct API to check if the device can DMA to the presented
> address, and it will trigger swiotlb_map() just the same without
> creating this gap.

Seconded.

Then again, the whole DMA mapping logic is extremely convoluted, with
dmaops, direct, CMA, and swiotlb, so I'm no longer sure there is one
undisputable way where CC shared mappings should be added to the mix.

Has anyone considered a cleaner design yet? If yes, I'm volunteering to
help implement it. If not, then please ignore me as a random rant.

Petr T
