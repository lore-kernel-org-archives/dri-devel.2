Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56BEC9831E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 23:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0E010E236;
	Thu, 24 Sep 2026 23:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="HKEVhpdf";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DF410E236
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 23:31:01 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-328664c1479so171815eec.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790292660; x=1790897460; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dew4FFqJYn+znPMh3WMUshAIF8jLNx5KHzgyCUnY03w=;
 b=HKEVhpdfkTt6bR2yhQOVzuaerh18ZpwDXa9iA/+jBOcSmYeK5NUtwmc97FT1toFLTT
 cvB0KmPOp+gih3gGABtmsnfkm8bSHL8dq7aM9KhZIPOuczMuuiHvpHOIxhzTFw2ZlWvq
 2aPp2BYH4HiRaljg1ZRjf0BaWsLyG2Gk3qwllmX6SaXdpGhZVHKPhz7ESCmyZBb+IaU6
 +jK6czDY3AihcEvptF+yxdxRpQ/+Sb6RTcREDg8lqroBjW61WTYTCNzub8txD90Njx1i
 9x+YaHJZOpN2H28eEeTq3JwTAAWPjILnOFMp+W7fzNqIHOiRVx5FDpCvQxgIA9sk5E1L
 VpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790292660; x=1790897460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dew4FFqJYn+znPMh3WMUshAIF8jLNx5KHzgyCUnY03w=;
 b=2rFvupdrChuqTpDUIbhLheAS4e0G5VuY8Tev9EMlw1pl/3l+bvQO5ouYt60CEf4c1Z
 HW+xSj7fLNqlreuNDtNoQJmg+dsVHqGHztQWTc0Q2KQBS2yGyYbrDCkGoOTjskprw4cU
 loll/LDiFws82nWpZcXFjcnVEJrYkcmBGcf5MNmCIFYfK+92JQCeHg3JxreZKwj8+eW3
 GMBwRwvR8DSdagPkPcaM+V+KNizFuflnHNF6gWpZ44py6yark3yWrfkDBR2PEfOBl2nL
 xxarIKSQzpBOvqpkt02cQ0ixgcwroLX6gJIAhkfcyt8j+zpEPtV14SQlaOeKliVVlibc
 ziaA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYUF4STp0DDC0bhhoMgUEwgl62xQ6YERmLAMW79b5enja9j9Vmb1JaCq6gea7fPtLk0oJ65tnTsQI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lF4skHM/9nSFQGpI4RvcDejM8yYDzQieX/anYquKmwctqpaLfS
 +WvUnrpsVFLS3xydjSDe6G8Rv0KAoxRDMc9f5/llZQY5mzmqJHMzmMhh4Z0gmXVVuBA=
X-Gm-Gg: AYBFou3g7WEUViHuaDga4h0zxiLTXe+fuMV8sJtSlx7FyBDCCoVC6mzal0lKAlOViPy
 JbYkXDu9+McXQhkfy+PhjfCC/Hava1J2NXS99NorchXfB1XlyuSloyeFGUO5vPm/eQ/ik7yPrFF
 QiqQLJ87VZ5jkDzCaUFQPwFCVtaF2sgRWTySpl+xlZkqoiCXuChK4H/aId8GGoE1nUQnWphTaei
 P5zS5Xlej+DmLlNtBDmB8UvlfO2gPvOd/BMvfdwLoi1J1dGATxCZ5sF/qJ7o7zGgKvGDGnQb7BQ
 fl6sJT/hz4u9itugjOEK2KMd1vN9Qhk7YID9fL16Jtp9OSTzQp7er/wnzNfAClSOmX/kA/l0vuP
 0jqHvlQf3H+8gBkpIDhNmvPITrVH4ymEXg0/DVaLAZd/k/2TgaCngIRB1foPsgrhm6VnWtd2u26
 m0eEPUC3PL2f15CuHcaheTd/8PSyG1viOdyUFZEhnXZFZS
X-Received: by 2002:a05:7301:2811:b0:33e:53e7:1103 with SMTP id
 5a478bee46e88-3400439a971mr3000301eec.13.1790292660260; 
 Thu, 24 Sep 2026 16:31:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757f31sm2224790eec.14.2026.09.24.16.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:30:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9su2-00000000gds-1vZq;
 Thu, 24 Sep 2026 20:30:58 -0300
Date: Thu, 24 Sep 2026 20:30:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Message-ID: <20260924233058.GA163130@ziepe.ca>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
 <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
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

On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> I don't think this belongs in the importer. Every in-tree dma-buf
> caller of pci_p2pdma_distance() is the exporter, in its .attach,
> clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> habanalabs memory.c. There is no importer-side caller.

Right, and they shouldn't be doing that, but it still has to be
checked that the st is going directly to the peer device not the host
bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
indication.

I fear you will need some of Leon's series to make that happen.

So probably the proposed change to dmabuf ops is far too simple.

Jason
