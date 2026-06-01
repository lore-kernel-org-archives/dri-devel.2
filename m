Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979EACD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0687F113405;
	Mon,  1 Jun 2026 14:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="QdX5TE/r";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4988113405
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:32:53 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-9156b74006aso44570185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780324373; x=1780929173; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mi2AxBnDBuiwVVwwXIXlKf9rcXdvhFLnG5wAFAlVNdc=;
 b=QdX5TE/r2MoZ6r/xCrEGik08wHCB7czZ8JpO+P5r8DRvktYW+3pohQShTNjxlgxoY3
 T2JtjuTZoq31L2REX+LZT0bYjmxO9nql9qz47bY3vJ3bPiDe8z+NmhJdTRl8hD5+aAp8
 L2PmNE2r/FGWxucoT7zrCIjyapUuzCWrXH0SarjkRQKeAesrI5Xrn4tZECLZaGWM8Okh
 WZrknNX7sBXD3vTrACHvrtXbjWuRrIBRYLDv4um7ilSXsbmOJHKhZ8vbkZUqprhpxTrW
 nGPf969IIMek9a2yu56kLPABpdIdIkfvBM5T8Y9q4PSyNYpu7hIk9/Vxsv4JXC25DWlY
 67gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324373; x=1780929173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mi2AxBnDBuiwVVwwXIXlKf9rcXdvhFLnG5wAFAlVNdc=;
 b=V5J8O/NRikfu/5WFWiqK9PJHJVX4QMpVMQ91rWdSUsaCtUiZhAvQ/UKhFHk0jJWQhR
 JG9H9w2no4F/OSJ8cY/WdxcG0uBQqoOk5GKI3+qvznVyNyioZ6yka4q4ri/3KNqyGyCK
 3FSo7eVnHWj7ngV+9yoq0iMXysO2AXDn9QTfNCpny+Ij2KFDmOJ45i1t/qHQuFAK7oiJ
 ZJJI7Hxuli4atJYIcbsboTjSvB7ZP7VW90t3eBmVQO8NAq8Itwe5zhLxyu/F5vQDG533
 3crfZHA+z4qrbKylI2J96RVzxtrNotPaAYCEeiwd8ol8XHUaTW0I9yIfyi/8CTVfGqkV
 fp6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8L3T3wZeFvqNqDJsEOkTgSmqQ9cx29t7znLf5VF9l6Hw2KIdQj48GciN58aZ2kblO1B1TTwr7ceqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBtJLVdDDouQdYmyEQkkp6razXCQOiJzdJjnlLxno6DQcSQDUA
 mpyP1PekzW+yAJP2RhBMxvmPYtLt8OOiIti6SYpjrpuJ8x+7xanOIQ2oAeD2iObyHrA=
X-Gm-Gg: Acq92OEhS0GO7F4HQxBjBxRC8bKXKYkt3FyTPP66JeNgYfn0UVgcnQvM9AGvT4IabTn
 Z0zMU4e8siEwv/xTnuruP7r61Sf1jKqW5B7l6hkk6cntT3Eq3EqP0Jipq8bnOWMzmZKnbdSSt+H
 p14EZajxXSJj/yPK2rowMbx1dUm7SinQP0s51v9n8yc+ej82ayAXGa59EpTHPnwykUdtIwN7SiS
 cY8fafurr5wWWveBjG08AlAcIrjIBAaCT2cvLv/WCmq6MS/GQ0tZOhq0l06crfuRA4svYwxlZFf
 vx5qX09mptTu+FnuWU0Er6F5hgCw5E75yiC9VtGAV2aqZeSq7SkQQNVmQElDTT5zHNVXSdE6xEr
 Lk4VhlB9j9qcW7Ia22K+ssh0zyvBbTNQPS+U9VQsvOfWggNgaTiD3SPI1klJLCouYkY/yYDBw05
 1B8jKx76/Yu8e8AILox8+edODPRK9e0jlkfzuVIWiad/NaE75V2SbcwL3qNJ99MhIMM+vdBO8Zz
 yVTAbk6S5AOf3mq
X-Received: by 2002:a05:620a:701b:b0:915:4213:eb98 with SMTP id
 af79cd13be357-91542140a21mr1632452385a.56.1780324372641; 
 Mon, 01 Jun 2026 07:32:52 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91570271853sm113463685a.24.2026.06.01.07.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:32:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU3hC-00000001n2t-2ubv;
 Mon, 01 Jun 2026 11:32:50 -0300
Date: Mon, 1 Jun 2026 11:32:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com,
 alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260601143250.GA2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
 <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>
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

On Mon, Jun 01, 2026 at 10:24:14PM +0800, guanghuifeng@linux.alibaba.com wrote:
 
>    Therefore, currently only the PTE mapping size of the iova is returned.
>    The current commit has a large number of changes; this issue will be
>    fixed  in a subsequent series patch.

No, do not introduce the wrong API to start. The iommupt version
should be easy enough to do this.

Jason
