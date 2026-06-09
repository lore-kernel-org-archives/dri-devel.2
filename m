Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2404BCD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8388410E011;
	Tue,  9 Jun 2026 00:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="HVEXkQt/";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1302210E011
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 00:18:01 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8ccf6a63a45so62325466d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780964281; x=1781569081; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MJrcrd97RrpK34MMckrW+u7pfPo1y7Snw62FaBcwTvE=;
 b=HVEXkQt/2ksHf29aHGb6qLO9vrVwbX8dzuEpiPSQAq8zNog24M5GJAxuvGYZUaY5OU
 Hh5ylVqybXqa1wR7XJJHKgvnLnwIFm1fge13piemrveuZtJsfByQpIElhQ0YcYHj2Zbs
 7Lb7rHuJNLT7zNGOBiqhfeWAgY1DQ7oKA91qPKGtULsX7pWk2HDNTBlP9rRoJFhLsnlq
 9HVTerwRr/gS6I8RN9ehuQ6mmIYJBe8EYtRvyCKJUu/GmLZmvV7QQbUBceBV94V/Suj6
 B2vLbRTYbG1zy/CdQq9lhIRCnaAXqyfS8U7bGpN1H5Unpjf/dZpcUQXOJbWUpEJxU7Ei
 tVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780964281; x=1781569081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJrcrd97RrpK34MMckrW+u7pfPo1y7Snw62FaBcwTvE=;
 b=Aa4TdAjFo0EMlvhu4A9g5UI4wJg4ARNjLlf0C8IGJx+/hY14h4j4GVigs8gs3kp49j
 SopUna1oKptFluGCUIwk5P/T861rLhn6UhYcEjH10jDTRRXR0KooV1nuec5JVLr1BAnZ
 wL3CrsSGtWIYc1htORkhuX8KoD+5SG+tKmgpcuYfqPAJEnuBoEZYFJ0SVOQJkv00nUbC
 vUEej5VK3iIBUKLRFHk/tpfLzsd+J89dM8ks9isPGSdJdnFCLX9tDZu+UyrLygx+008R
 cZ4dQ9NrFUbCoTnlxKjEJmJIeOcK8Le1esCKToKPqrOUXz5KcbkWP5LxFIbOZKSl/dkW
 mJTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9629ZzQN4wx4yUgB8DPX2akUGazJkbb0DRyGtcgnaoZaZv+HdX6QvPHXMeycq6GAKziMmjPaPBRi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZsAEQIzibWqVyNj6NWrHICKVvB662bN588g5HqdjwzxZTqQJ4
 SYitdLTGhkbSkOROLtOlivXf3DjxvKzcXdJvAeHpXvdDpaCxiACjt+YXvMsPIaQwZg0=
X-Gm-Gg: Acq92OH97fIpQpS/u/IdXh8hQIZ7Qnnn4F8tn52G8j8FWdjH0x9JiDR7yxl4Ke+NI3S
 MfNkvtAauFZlIkLyW+P89UbN2YapXOyAiN2QC9jCi+1FvNdjABtYgYfQ9gRVDghKZx07ysEIEfi
 8y8ZiSHamtOJgjdoOTjeCSx2/kYNgZt5w3SakW1Nc4XhZgnyA3uab+OxbMXd9dQBm+Dk2nuW+YS
 H6E2s3tDw9lGTEoMkrTEAAno4OEg0dOyQOrm1/5NSy8UHT780sUgB/46MZne/OfAS3ciKawEVbI
 aZ3OX1CzpreJVglqfoGtTbEqE8gbL3jAXve1Wb7lVVJ2SkUFUX2hb24asSvN82AJy0EJBoN2XaA
 vt5eCvXXITt6wRmTPfdIlbxO4yRKzanGI9NQJlFnp5c3Aoa6FVumwBKSHQmhttmmIhATd31BrH7
 eUv3FpT+L1qIWRIZqb2PIf/cQ9Ikl0JpjVtlTZNtFojrpgfJA0T54F/JA1Z5E1bQfgd2GLKus2K
 iDUxgVVjtICGncLniRk295n5rI=
X-Received: by 2002:a05:622a:1b15:b0:517:8f31:df0a with SMTP id
 d75a77b69052e-51795a08705mr257391641cf.8.1780964280672; 
 Mon, 08 Jun 2026 17:18:00 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c4d7absm165652141cf.11.2026.06.08.17.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 17:17:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wWkAI-00000000rFN-46mU;
 Mon, 08 Jun 2026 21:17:58 -0300
Date: Mon, 8 Jun 2026 21:17:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leon@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: take dma_resv lock before dma_buf_unpin() in
 release path
Message-ID: <20260609001758.GG2764304@ziepe.ca>
References: <20260526111034.4079-1-Ankit.Soni@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526111034.4079-1-Ankit.Soni@amd.com>
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

On Tue, May 26, 2026 at 11:10:34AM +0000, Ankit Soni wrote:

> Take the dma_resv lock around dma_buf_unpin() in iopt_release_pages(),
> matching the iopt_map_dmabuf() convention. dma_buf_detach() acquires the
> reservation lock internally, so it must remain outside the locked region.
> 
> Fixes: 8c5f9645c389 ("iommufd: Add dma_buf_pin()")
> Reported-by: Ankit Soni <Ankit.Soni@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/iommufd/pages.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

Thanks,
Jason
