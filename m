Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95672C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DB510E407;
	Thu, 17 Sep 2026 14:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="eZ9Q7/S/";
	dkim-atps=neutral
Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com
 [74.125.227.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE27110E407
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:02:56 +0000 (UTC)
Received: by mail-vs2-f40.google.com with SMTP id
 ada2fe7eead31-78a6c77d255so277743137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789653775; x=1790258575; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
 b=eZ9Q7/S/DEY4FhXMUDOplTqKHf/k6QeyadXgZP/COEPtoXs3xspTQYQZbXZlR6oi7k
 h3J6en5YpV795E/SZ/LT6t+kigguJuvBNPqNHlhDA2DUtcopBkYdWmsufYRlynS/NGIp
 hWc0b/J5DE84rp3a5V/y0cn8B6lDaM9FHUubjDgKSclHATMyyoA2mX8oj7wQlQZM13Qk
 bJtb/yQreUWGzcsBa/x+ieoQclubCR/K5wSHpgp3eaodhnyk5aeiVioMdf2Z2/Dk5kHL
 hFfe9l8T0Xa9PIEyXqGh+No9sKjfLo5AW6Ge5+wDaY5omboFZTFlUZqcdC0aIC/jmMDu
 yvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653775; x=1790258575;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
 b=vjM/wZ/XjF1t3phnt6Ce65F+0C7s+wJbcGd7H2Rra+rVQCw/CV8xo6DzQ/vR+h0ylY
 QMfao2ax4C1PGRKKCGFvvhmP3zB/7WJH12C/bF7qG09eMGHM9A5AkPOccuEVZKt4IpdN
 zQYe/SF2HlkNWuemvRqB5AdRBQ/9IsOdzfTtD1EF0Hv0xdl2QFH52jySmOA2v9w2Ddcn
 TsOqVUcXhe/Rkiuvv3sFKRIUHOE/t59lZU2FAJeMPOL8NXW3Hoo0dRRnVhYdf0Kncfvn
 VytbzTyxl4JasdkFR9p9UtU8evbP/tMQxw4dqlqNi8lVSEkwtWBq7z3kWo/PbqroEvmb
 fQVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDKQg6i4q1cqKSv3HgubtEmMutr93CGEKGCDzwJoy4OqtdsHbt601eabP/n4HPELhmwCXDui1Pe40=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m6hjIRlsb+equewl+GJ1fUMtmiIrjWyWudT6th4k7t80qqlYLU
 B1I6gA8WzEwgCTUUfb2/j/marMrah428qXLynugNedxdFXamcx07TUqSuQpcUvGGohs=
X-Gm-Gg: AYBFou24K42CrPoNyca6fioeDBRI/yZRwEeqxhnq1+fsLa5oA7jXho8p2er+t6IPLTF
 W5/mr3ZX0XUkvYVx9Ll7P2vZxqQcpvXIk8wt3veZQihURFw0ouza/HxXYQmzkO7sVOJbqAQbj5x
 OTki0FTc4rvY29DthjhNBN6qsSKQi6WqYyRWVH//ZBQV4LncBo1qDNgZDqEAy6CANpSB38ib4RB
 MiHS35F0gnbuEjf+qrakrMwfBYR1cTi9hIhSFLISDnex73cpIha2Jbqoj9vFvMTGhF8DD7Rl4ic
 8RxOMperXlqMTRB1KPe6B/fM6+HKgdQI7bcrc5qE6QXc4t6vguCsIlD/KknOpStYbJ445u8Rpow
 JxDpRKHHHPbOELMTlHhlJdOMLT3XNgZdnrMhWx/dpZWkTJdP9uGpbM0TIjnOL34WsBb5fOsAuUf
 RiHURnhD/76tYCf2TKiS2k6wQTrhw8RHhRpma2lkPubFvDTRSQKx9CF0JnCSCxVIdoCtqUM4WBN
 fDuYidWNSxakOVu5v84DZCqI5rz8s1XTovr1hZHMj+3l79HD7eXQfcR
X-Received: by 2002:a05:6102:a189:20b0:7a2:63d4:3d25 with SMTP id
 ada2fe7eead31-7a263d44d51mr364707137.32.1789653775451; 
 Thu, 17 Sep 2026 07:02:55 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bec59fasm50600486d6.39.2026.09.17.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:02:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x7ChR-0000000Co7R-3O0W;
 Thu, 17 Sep 2026 11:02:53 -0300
Date: Thu, 17 Sep 2026 11:02:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917140253.GG3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
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

On Thu, Sep 17, 2026 at 03:56:12PM +0200, Thomas Hellström wrote:

> That is, a flag to tell the topology check that some transactions
> *will* take the host-bridge path due to IOVA being used, and that the
> computations including pci_p2pdma_distance() need to check whether that
> is possible (checking whitelist etc.) and return the corresponding
> THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
> cut using the bus-address would then be hidden from the driver.

I imagined it would work by the driver passing in what modes it
supports and Intel GPU would simply pass in ATS only.

Even something like mlx has variation, only some operations can opt
into ATS, many others are never-ATS.

Driver should not make statements like " *will* take the host-bridge
path" since it has no idea.

Jason
