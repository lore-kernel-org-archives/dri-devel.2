Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85667C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB79A10E5A4;
	Sat, 12 Sep 2026 12:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qU6MH+tC";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD1710E5A4
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:45:17 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7355e411so1344235e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789217116; x=1789821916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DnLavuIU3PeT29b0R+tsLZa/nqbV4NGKsHKuPzpckLg=;
 b=qU6MH+tCyGneX1pLbw3Tj/4YmCzI0XYTuE/4iwsf4xYi6UlIIlzzTNL1B+AFMkV72v
 apVdcboyT9h3TQaKhHvclPCivUDwfUaUbNLxE1OUztgZGQypCu5upkUIMIIUneYtuaBc
 RSTJbeJTspnox5xbbVUeQgurhpEfOzW+S3T/VkdG8Eh+nAdWKXKWxiZF4P2ekzwBt3ur
 SDZldzac5MSDx9CXXZjwvGEAaYvUg/ONPVjfueyPLdS8fsbNRav/rw8W7VyKHPEmGlfK
 XRvsqnk0uXfZ6aPOLYwp1Lmrua173KbcjBO11A68ukB8App61lTq6ZCoWuHsbqTqygWR
 a5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217116; x=1789821916;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DnLavuIU3PeT29b0R+tsLZa/nqbV4NGKsHKuPzpckLg=;
 b=WR3oYp1PmFpAWIK8bjPOUpbt3hFeKo98ajRJFT6E5h+Q6PQViYZGQ2+Nrye+jNdMfw
 BzMQcylvcQKFCssC+i7L80xDxJyydgdiQj9M/1r26xJ+ohLL5NV3jiWZqnaI0Qkf1bhn
 0kSa1T3Lue29jymiHm+fwOBb8ov96kcQi7IA1cNycc9cMDWan3pBiwudf5pmyFylyxBm
 txQ2+TGZbdLzCwkIHx2YfqP9lNOUNhf+wqT6G2MtXw2PuzruXbMjkv1F5JadESqTYqc7
 2cXwHiX80BQqGJLBVXFfSrI+02apkD5yaAXWnVnNUMC8RwnWrcHG5x1RDKP6V/CYtBdb
 nFMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUGPuci4R8ux5pF/oCuK+phXjgH/aBZu4WsX2G3Zkbv7RRmOVY2RjKe2INDY++uM/bS9vudmTcfts=@lists.freedesktop.org
X-Gm-Message-State: AFuF++knPzdbCID2qmmAq1nkkqqZVqBL13gWMWQ+b7qF1xIyPBYeKWZd
 iJkAyMAS6OomEveDilvQehmfV1Og757zMOlIlp52y44Zsf6XBvxX2Rn4
X-Gm-Gg: AYBFou2zChsF6CEHcxkZMiJGggdGizXyhkuUc3n36l86xPekxiHrJUDNAcvn50I9mil
 EwZkMHKNaq35Y5zFblDtVq9EqNV19g7xMre5nJkmvX2K9KhAY0d+ViWb8ZwtfVgzeSHCZ2kku6y
 Bfjrfso5yspagGLcoiLFgwqOMdVyerMRKIn+TQcj2DxhBWA+LfuTjIaE2rmSOqkuy1CbOEJF/aJ
 mPrnKp6PW+uQF1PVFNuDp35+HQeEavpRgfUJnwYmfEGh+PDbfm0kmLKl09NnvUw6+fMh56jOR4k
 uZBhm8qnJ3YNgh20h7RDtobto1SEKWACOqaZ+aK1W06CbJkNo3e9WGhEnq5F6tzkiXXecTdCBHJ
 r7eUZl5iizHuOTlKMN/ahTqQJsexL8v0RrjOzUwESa38xlth7mkXEMwZRTxzvKX7FjcRk8jlyqR
 at8YE2ehkeQJ1izZWEQiELqH/1EW5WITp7tEBxS3I/D2CrvggDrrdOabmN+8L5RC8AJ2f59bHGm
 onguE4ZQCxo954PXKr0Rgcf6o/NODTS1dNSJh425XNBgI1M8lX5XY8ViRjnwkO+A7Lv7FZcSg5f
 gkXG7QQdoBMx0Aq8EK1T3dQ6AE1x
X-Received: by 2002:a05:600c:4693:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49e619bec89mr188946025e9.6.1789217115992; 
 Sat, 12 Sep 2026 05:45:15 -0700 (PDT)
Received: from [10.192.161.217] (82-132-213-27.dab.02.net. [82.132.213.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaee4sm226373935e9.14.2026.09.12.05.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 05:45:15 -0700 (PDT)
Message-ID: <7b126162-f412-41d8-8002-6b31d2795f51@gmail.com>
Date: Sat, 12 Sep 2026 13:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
To: Li Wang <liwang@kylinos.cn>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <2026090913-landline-encroach-c544@gregkh>
 <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
 <2026090924-corsage-shout-833d@gregkh>
 <33c9db65-fa30-4d34-9026-98144ce1ed95@amd.com>
 <9447bb67-96e9-43b3-87c8-db231051fa2d@kylinos.cn>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <9447bb67-96e9-43b3-87c8-db231051fa2d@kylinos.cn>
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

On 9/10/26 04:57, Li Wang wrote:
> Hi Christian,
> 
>>>>> Nor why "fgds" is the name, that's going to be hard to remember, does it
>>>>> stand for something?
>>>>>
>>>> "FGDS" stands for Fast GPUDirect Storage. GPUDirect Storage (GDS) is NVIDIA's
>>>> technology enabling direct I/O between GPU memory and files on NVMe,
>>>> widely used in LLM workloads to bypass CPU overhead.
>>>
>>> That's nvidia's specific solution, but this works on other devices,
>>> right?  Or just for that one platform?
>>
>> That was nvidia's specific and very hacky out of tree solution
> Exactly, I completely agree with your viewpoint. In fact, we previously conducted
> a deep analysis of NVIDIA's GDS implementation code, which was also one of the
> motivations for us to develop fgds.
> 
> Please allow me to introduce NVIDIA's GDS implementation briefly:
> NVIDIA introduced two kernel modules: one module called nvidia-fs, and the other module
> is a customized NVMe driver replacing the Linux kernel's default NVMe driver.
> nvidia-fs creates a device file for every NVIDIA GPU on the machine: /dev/nvidia-fs<gpu-id>.

I'm not an nvidia expert, but IIRC they switched to P2PDMA, which
is supported by the upstream nvme driver.

-- 
Pavel Begunkov

