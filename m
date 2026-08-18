Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B94CC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8C910EB47;
	Tue, 18 Aug 2026 13:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="fzDaNaON";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461BF10EB66
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:07:27 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-92e99ef0902so227959485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1787058446; x=1787663246; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k6wSKG5ykq4Q6C1KtG/SKHUImq95NPkNyQJpM3ppYMA=;
 b=fzDaNaONErbLIen2BggVcyfHlL+ngQCJfHTu5xxb62Akqm3ihCYj4ozrwCgTAd2Bdn
 R+NYbfNS4S+1wPxzqC3Kp7DnRH/lXRFkMNLK/poV3e2Ujued6aKdZbX/D2yju1JxE+vs
 sg+3JdeNQ/jA8Myi/BTyJU1+PM8kg8mSTFBe5KC0f005BnNyERudMcDO02Bgomj34kfw
 wAIJNxUOnpCEUC9rHYeO05e/DDq9WuL3xhthE+6NnP6SikRDvUbF3OWrrDcQVJ7usGWV
 O6I/ODXaRVs3Lbjkmn9T6iaW1k+wGG+/qJwu169EJZkuzyQDijvw31Fcw8IOBF/yGQoH
 sl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787058446; x=1787663246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k6wSKG5ykq4Q6C1KtG/SKHUImq95NPkNyQJpM3ppYMA=;
 b=Pw6DZwriEq1Q+13IH2J6e0QlZBMlDrxwq0gq4VCG6aDQsAiVpWxccUvHNKvYljnszH
 etHbN0af6f1+nFBo4Zt8LdhjmVdFusy+plPNu+c9w40XpO308OC38bArokOGvTDr3Pth
 knNZg2eqCzaP+5qBIYrOWURn88CqEDMQCHFEeZyVFtx1XtDdyiMngZRuAPSQNCAYg4Fc
 S6V5P8WcuEdTtHjCljQR4qhcQe78hrLBzPW+nokSY8y46D0BEapesgdppHOMAmhDgv9D
 noAbrvBPuCLV2F2vV2JkFsu++ysEtDaJwadtJGTnfLSC+WmeUcCEp+4SiQgsrjfSgRcc
 Hz/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0wV7LTDLQugigOIDm1GlEVEcH8AJBZYdy4s6Y7jgLyzL+4azQQbBQpUOPBtcK2JIZ6yPPFP6wQ9o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBjvLNBB1u1vK9/DGQbZfnqojOaHt8mjnIy5Sodz/ugczOQ9Ih
 6SvnVeY3Cg480OO7hAlv8ai+FnVInM3WguCSOlMh+KKHBha0NyuZs8yChCr155WMVFg=
X-Gm-Gg: AR+sD131wf369CIU9wE4NdamW3iCQg6Q19m0r3kDZeqAFdSb4YFrH4bZPSSSOp6W8wy
 Umk0BJ0+XrWrAlJDRXP7JwBp0I3lr8ggWA305l8Cqr3Jtn+knfXn7juZKYRGmD6MyOTOmwvsF0Y
 Db/kNISSjJwJ9Bq5JllH0v4ieWY/ajcyocp6RKSG9zqOU1tBtrmV0NKy7i4FZEb+/srrNMkki2S
 jU2ZqrgQprnv22cTNfz3xpZ1kS25n9aPZAkPibRUJb/DcjaRNIaYt2M1TFtwAgQF0F5DNqlf+j6
 X+9C3tbOxhgtT3QbibTWCHZq+lVF+tprMTT30zqNwDTIhrdcLb/akl/jDu6c5a9Bi8aXb3y8q9Q
 4UBSbCKez5rJFOMQqbHCjfM8GCFtEA9QA/P9Bxyy34YY78Tka5tqIZIJnwtO1W22qiuba30Dref
 nYLGwusPnWZrJxxtqH55xhZmkyM+lajbdK7WXHCHjFEA+z1095F2sXuokWaIAIB06h772sDUmou
 wXqiMtUABDoUvsq0aVij+qMe95KkPgXcFpFLFz/3E2D1Q==
X-Received: by 2002:a05:620a:4624:b0:934:aa56:45df with SMTP id
 af79cd13be357-93704af041cmr767327285a.11.1787058445831; 
 Tue, 18 Aug 2026 06:07:25 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9370342b3b4sm281378685a.44.2026.08.18.06.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:07:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wwJXI-000000001zD-16ZT;
 Tue, 18 Aug 2026 10:07:24 -0300
Date: Tue, 18 Aug 2026 10:07:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
Message-ID: <20260818130724.GA5482@ziepe.ca>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
 <20260817134416.GA1415075@ziepe.ca>
 <89ec74da-15ed-4278-b651-5c753fa4f146@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89ec74da-15ed-4278-b651-5c753fa4f146@oss.qualcomm.com>
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

On Tue, Aug 18, 2026 at 10:40:25AM +0530, Ekansh Gupta wrote:

> The CB child nodes are not separate addressable hardware — they are SMMU
> stream-ID assignments described as sub-resources of the parent DSP
> interface. 

So this is exactly the same thing.

Read my remarks here:
https://lore.kernel.org/linux-iommu/20260618151745.GD231643@ziepe.ca/

The DT modeling for devices that have multiple stream-IDs is to list
them all in iommus list.

If you don't like that DT modeling then you need to start out by
explaining why not very clearly.

There is undeniably a Linux gap where it forces all streams in the
iommus property to share a translation. This is a *linux* problem in
the iommu subsystem and DMA API. In an ideal world it should not be
fixed by hacking up new busses or mangling the DT.

But of the easy options I think hacking in new busses is the worst
option and has already been basically NAK'd for the hamoa project so
please don't use it here for a diferent qualcomm IP.

Given several qualcomm chips now have this same issue I strongly
suggest qualcomm consider trying to fix the root cause and provide
some way for a Linux driver to progmatically "unbundle" the multiple
streams.

It would be much easier if the HW properly supported actual sub
streams as we do already have a programming model for PASID. Maybe
some kind of driver thing to reconstruct the iommus so that each entry
is exposed as a PASID in the API instead of an alias or something like
that would be an easy direction.

Jason
