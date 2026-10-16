Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF70CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 04:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1906010E08B;
	Fri, 16 Oct 2026 04:55:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5595C10E08B
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 04:55:13 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso3797423f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792126512; x=1792731312; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xQWFKxuzzMgUKGL1MQJ4DQ3TQ8VWfkposnOCjkIVtBA=;
 b=oUcvWrBrglU33kJ52xZjq19/0Q28FwR+AXwV6LqM2YM70emBchquPbelwHFgphAFCx
 FiDMp9e7kA2BRgf+Eto8Z4JsCqs1W7vj84gQVIHtgtE1uTtGox68WkOVmV/ST18WhH+Y
 zX0vIojg8PXrGF9P5nke2FUg3KvaG2lrMApebph8Gf7EiLAikeKh+J9B+4SgAp2RYugI
 Sjqoo4q4KnU+Yj9tIEv5LoptbE24+e12PGJMJ+q4xZq1xcXjY3Ha7dOXYfYbVlaBPsbG
 0uWeenv3fUn1eqLrjnslrpV8ZQxt3sVrwRd+TPbWFQVHMpbVYO3/qnuhPOrw5AMcIp1V
 XQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792126512; x=1792731312;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xQWFKxuzzMgUKGL1MQJ4DQ3TQ8VWfkposnOCjkIVtBA=;
 b=yo4T5ibr/Iu25+cwMJW1DOx0wwbTtkdtkR0LuvhtyEMLD3jybJYNMzeGjaN35JbRrm
 9UovMJtUMDWHC/OcFWLJaqRGbFzFFkZ7LfpmhiYw7TitT9IbsPTyxKaamolgu24CNLdZ
 yrhXO9Ew6sZbcqvHMP0TkxdeN3CW1bc2D8fV1euHLX6WCXI4x0OwqH0SE4EqWj5aYq8f
 lN7IUhysMCCqMBKJfZmEu30zGRw8/6uJv1P82MZg3DK2+unLo5Lys5I1Ok01ZPUgI60Y
 eVfuUyUoFKKtsECyVU1jwqopYK4NU02r1YcowGDYpuL4sZsQgoBX2cPxnlQe3HZPyPsB
 utqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPmliBEeYHj5CwuQSsLZiBvgQ9IUaqFaQw2OU4eW2+EyrRMoRsf3KO3s+6+ciFHSL5uo1ZUIPVx9A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK1x6fDDNqOgWubzaLF/a2PPJfKPsa+arjz6Lpcfn+dhutLAmQj
 FhedZvOdQL5unSNiwZ/ruven4wfiyXduZDt77gFToCRDnyBrnkR3b9DF
X-Gm-Gg: AYBFou2fwszcw+CXMOgAqFCwqcj2+dee4mQeAqpr6XXngSNND3HgHU6WodiOvv5c1Kl
 Y6tavdKBBpFw9MMcO598CQxv7y1guZgPDYaL5o5fU4DdnllGRQjVeM3Cpah7dGPuqyF7oW5JuFw
 RuNqHTo6erbCiSGx6uMf+W6Uqig4ZRUdjCfR0PSAIMiI8SbFD2ijIMuS02qgpJ0GDfd6E9ChM85
 F++7IX3PWyWWoEugx5eRHuxRPKZtc0kiIP1oAbNY4UjNblEuvTwB9Mrla6VpubVCXZUe6DvInO6
 7HMflzCcF5xbVjTHEV8yOFdfzT3Cp9zY9SsyQCsHklq9t99/OIGnqK8kjwH1YELFnkeonz6+QYS
 hwLPuAolBp8DikUAnDbTa9RTqogiTa+H90g6mh9Z334JiOnlYEDHLKNKO6VM45wdvKx1xQzn2/A
 A8Sv3uUkDPt/RK0kcEqiz4HPj2I0fqVu/eZpAOKU64MYDan3mnRlzszLRB8HLGvMmgzpVNby9JD
 Gqtypiw4/uLnLXl5aGWPyk0uBQ09zJlbP8dg6WiifofucZBq6uoEv40FFoEjvNUPEdRTS6Lpijm
 mHdXeJ/tBSfrBpxKSo/qyRnltrFHPzDLnqVjyUwxlp9O6fLtqRxsGNVn7MdRP6XSLGvqvyOQzpg
 tMvTPdL+AEw==
X-Received: by 2002:a05:6000:4a07:b0:48d:f25f:5a14 with SMTP id
 ffacd0b85a97d-48df25f5ad3mr9567344f8f.49.1792126511382; 
 Thu, 15 Oct 2026 21:55:11 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de.
 [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50d080sm2455314f8f.53.2026.10.15.21.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 21:55:10 -0700 (PDT)
Date: Fri, 16 Oct 2026 06:55:09 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udmabuf: respect the device's maximum segment size
Message-ID: <atGtwBE_zrIvU0ZF@gmail.com>
References: <20260929054835.94118-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929054835.94118-1-kmehltretter@gmail.com>
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

On Tue, Sep 29, 2026 at 07:48:35AM +0100, Karl Mehltretter wrote:
> get_sg_table() merges physically contiguous pages without accounting
> for the mapping device's maximum segment size. This affects both
> importer mappings and the udmabuf misc device mapping used for CPU
> access.
> 
> With DMA_API_DEBUG enabled, DMA_BUF_IOCTL_SYNC on a 64 MiB udmabuf
> reports:
> 
>   DMA-API: misc udmabuf: mapping sg segment longer than device claims to
>   support [len=65884160] [max=65536]
> 
> Use sg_alloc_table_from_pages_segment() with the mapping device's
> maximum segment size. Return -EINVAL if the limit is smaller than
> PAGE_SIZE because the page-based allocator cannot honor it.
> 
> Before commit 5bf888673e0d ("udmabuf: Do not create malformed
> scatterlists"), each entry covered one page.
> 
> Fixes: 5bf888673e0d ("udmabuf: Do not create malformed scatterlists")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Friendly ping on v2. It has Reviewed-by tags from Jason and Christian.

Thanks,
Karl
