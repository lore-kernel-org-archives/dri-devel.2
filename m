Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C7C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F31F10E3D9;
	Thu, 17 Sep 2026 14:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="G1zOhHvt";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA7310E3D9
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:28:11 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-91235f46716so6935656d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789655290; x=1790260090; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jw1k2NAja1Um952Tl85LJupIp0nZbLj8NYpKbR9I6hU=;
 b=G1zOhHvt4zjdtHXF9JOwUiCQTsnHk4L5pCEteuDhqV36h5mAgntZUPRN/yljUH3mvE
 E49f9dXp7IXmK4c8O4+jPsPSXD4IGk2Dmu5CUzyq2hSpq3Zj0nhmyshdokIRCvGyY27g
 pAFIT6NoRqE0reaFcYQjw4p4M7c9scKrpDZOiL6qPMIHcF18vE3QLu4anOOkxg8ppVTW
 fEjSfsjBjr80F3jsWzNNDsPpvDhjU8GdI0wXMpao513DWtEN7sxkHHHDNG88BqbUBQbN
 edIFAzPlYGvTbrMCrg3u3LigKIkOTCtaHywMy+QRFY8yyvJwr8IYF7OTSgjPMPm3YWgD
 Ornw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655290; x=1790260090;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jw1k2NAja1Um952Tl85LJupIp0nZbLj8NYpKbR9I6hU=;
 b=mffsIv20Op+m5Mx7p7U/LVHBdSj9u7OIle1zO+8CD2q88yykPYg3YwaCyv3tXHGAsr
 5UhRRcv/MqK9hl/NTO3P1gVEP67ShJq24GWFU3SUShy/EfpRzMFEwyPzXRuvZkaAZrEy
 FfwObL/OkjzgFHT0Kvk4k9YU20gkBVuCEAHhv3i5W1Do3b74nAe4j6WO3vSMZmIdooWL
 qxw4ywNt05h3lrPuB/NI+GuKY7lasrjpEYySqkfwSX3SfN6dSoNI3IoO+BvK5tKMEDNM
 0x8lFdboVTKTNeGuo6j1Vbdce/z3mrBFNNh6FQ+l1Z6EUVKHx9+N9HsW4GBkKqjAmWhr
 SXdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUcvkktlvA78I8y+kW4q+dNQ15P65JdRqaqO7HoG+iVRbfbM3yLT5V6CxHEXYc5lloWUy1toSJzdQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kd3FkGy++EusaimvU7I59ZN0NHetj2zi/l+vlJumECaL6gJ3mC
 SK6sIUKFfMyqc7gLIM2j/QCzAFFj5uyRyPmomRP+w2AoBDnDaT1EPbRzkLLUa/Wpk7o=
X-Gm-Gg: AYBFou1DOQkpmoVTINkKcGvuzn1Y0BZRHC304r9/f0Y/DMhzYsUuREEKWLJP1D3eJr1
 rapsUQIH/xUk+u/aIBOFqgqyDZSpMF67IS2OiFFkHZqORO5/lFeerq0KjVSf5czefR2MC021Plf
 5/failFHHmyX8ECaXQf/prwjJbD317esGcDPyELJbF31tkEvN369AbzYQDWdVj41aDkfuPR5AmQ
 PW6Ts0gFPKx32CZhYZUgjQ+1rA24O5SX7RBhAm8SuqHJPnhWzvnf9VAWxUFAHr+JaiaMFaS4V88
 47tIL3/P8Asxszzi8rH9ZdBHLlJyM6gWJSF7L9KfcAavSH3jjKa0L7Lo8noqln5d2HCtopdq4vr
 ZazMOV/ndC58HT9iHK6QKCZ/xhQV1q+y5TmS4Xfghpky7SJf5YLa5PaXEQaFjVI/iVaK9wneoHs
 NXn/efm/66MzSMMFwpHKbRbqnBLg1eQFnAh7A9tRbmhUZCint+t9K2h/ucB2X3AWNOZBjmDlh0H
 3VuUAMYJg+8qnURP5mRizSk9Vs3cEmCPjkmCxGrJFC5+P5Q1Lfyt18O
X-Received: by 2002:a05:6214:1316:b0:912:517b:911 with SMTP id
 6a1803df08f44-912517b0beamr9926716d6.48.1789655289706; 
 Thu, 17 Sep 2026 07:28:09 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123be9ca82sm51192626d6.32.2026.09.17.07.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:28:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x7D5s-0000000CrE5-25RS;
 Thu, 17 Sep 2026 11:28:08 -0300
Date: Thu, 17 Sep 2026 11:28:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917142808.GH3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <f3708893-4760-4157-83a3-313867a94e78@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3708893-4760-4157-83a3-313867a94e78@amd.com>
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

On Thu, Sep 17, 2026 at 04:00:33PM +0200, Christian König wrote:
> > However, at least for the Intel GPUs, ATS enablement is based on the
> > PCIe-side enable bit.
> 
> Yeah, I can confirm as well that this is something really exotic.

In most datacenter systems it is only the NIC that initiates the P2P
transfers, so it should not be surprising that NIC HW has more
optimizations for this. In real systems ATS carries such a perf cost
that you do need to be selective about it. I would expect every
serious NIC to have this capability or it will not be perf
competitive.

NIC and GPU are using ATS for completely different reasons.

> Additional to that the setup that ACS seems to be disabled for some
> bridges bit not all also sounds extremely uncommon.

I'm not sure where you saw ACS disabled, you can look rdma-core now
has a tool to help people get their RDMA NICs working in GPU systems:

https://github.com/linux-rdma/rdma-core/blob/master/kernel-boot/rdma_topo

I would view most of that stuff as completely normal at this point,
people have been doing versions of this by hand for almost 10 years
now. Especially the asymmetric translated/untranslated routing.

Jason
