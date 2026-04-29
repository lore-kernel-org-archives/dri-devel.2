Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA7FF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650B110E3E1;
	Wed, 29 Apr 2026 15:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="odSsRJ6T";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B5F10E239
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:30:09 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4480f9b5efbso713303f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476608; x=1778081408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
 b=odSsRJ6TKjCT9wZ9Iqf9B2sY9rIX0/vdntOtd2tNmkrIfXDQTY55K5o3oB0/r0Zw57
 VgoqxNK1x5bfZmj1JNWnOv8oiwjJ9q6z+WSzvtf3cjSdFTqgyX+FaXGRPmKPzDkIKYEU
 1k4sU1KXnjyagxzH1MmNMhlnq+AN3tYeWN9m6nuymj44Q/fw2Xqt/4IwJEvo//kP6+aD
 HuZFO9A1nyJaE1sK09VPvP9vtaLuZiOnGPHT8HdB1Ril72w7Euh7ea+LZJpyIuk0UU3Y
 KcHLs5hhBZHKCWRWvvDOkT9FqwQzav2SBFx1wvSciOXtTSlYMxw90tF+rNbJs4iknFm+
 ULgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476608; x=1778081408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
 b=o4gowBeS7EDqteg/0uWoEHOQ6msZKk+8LOxmwEwmr+GdZdkgtoLD4p12khAy4gji7z
 ZtmLjBkWkfA/jBeQaiXJG8DJRUfJ5hSZwD8KbR225OAT/NjvCkbnfz0d1mu2/ZWWY3NH
 XatzXcLK1jsrTX103tFa9W2xPLcrSdpZDCAWuktuS/I+sHHFP/3HtMoa/fk7h6Ryv6WW
 xRKpB6Uw8/2AUtCiIdFySIYPF8AJT90Jz60Ot1SGC/aKVNrWikqIp+IfIKwkBM7ipfxq
 5N3XJk4UWjrNn7IpD81Zar1ZRroh1O9SZhbaSRqW9dKOLjilbKSk/8V3ofTQUQh1LXpp
 VcDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86TsY79Ib4qBIzm8TyZgG3P3mMdT7kZ+zs4nKw7sx/AMteyxbF4w5BZnetTAOV97wq5Z3KWqS6aCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0v3TA9Qhobn8NPaCvivZ/eXxS/lispejKTpIJMz6QEG1tXf4t
 NEkz2cGGkPf9DYuPP0GajsXuqRtYfpsOydM80vXzCVk0WtiMYjVwTzuC
X-Gm-Gg: AeBDievwDUMzM4Wna7xCMAA9wMMyXdMMShCfYc2gLxMkbRVXoFr/yYq55UdRBsXoA3h
 531O8glu8btcWoLXCdOitZ7PfDoghxMUFyUpwduKG8Hi1ugtiO3QWzOqtl49KDsg5xndLK0yIBi
 TIL79akUINyzZuWwJyVe66fJEmlrUOg3Af48NZVrYaJV6CfUQGRSamk+XjJKHwa9A6/R0B7WjlE
 xFKZsFplUKdrmboa+7JX6rocgmo0bEqrDxS3/fikwkXeB+ddTRGXDL6QqO4vG4TPWTa+RzW3/Uk
 tao56Ob96pmfyB2ikgFlATAZCcWGOBW2NRn48W13wodm7SYo0U40RM51sN0jQsT5pc0RUS3H2aY
 iB+C59vIR35T8Rdve1KTj3KKwgMljz2yySP0DZuGBvudwRRnRbFUPvoiIVUpDmMs+7wX+8uxh9E
 vDMt6WrqgClXrG2D3l4GhbVCoTHT5G2rSTeVAJis29nH2kjeFU5meKRw1+XpvehVwozyf+nmsN+
 S18OJs9vfSVWB7q3ddyLyMdhGteJNbV2kGq6846fw==
X-Received: by 2002:a05:6000:4313:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-4478eb81cf7mr7566713f8f.16.1777476607642; 
 Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Received: from [10.228.209.141] ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d481fdsm6740381f8f.8.2026.04.29.08.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Message-ID: <46bf2c04-72ab-48a2-a8e1-9f4423eb17a6@gmail.com>
Date: Wed, 29 Apr 2026 16:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/29/26 16:25, Pavel Begunkov wrote:
> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
> dmabuf when it's mapped, which is then used to initialise requests.

I left nvme request / map setup as it was in Keith's work for the most
part (apart from rebases, adapting it, etc.). It appears I have some
use for prp lists, and I know Kanchan, Nitesh and Anuj already have some
patches adding sgl support and some other optimisations. Hopefully, I
addressed most all feedback from v2.

-- 
Pavel Begunkov

