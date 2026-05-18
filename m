Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B94CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A47D10E788;
	Mon, 18 May 2026 10:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hn9EdEGl";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95DC10E788
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:30:58 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-bcd3c190f71so378758366b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779100257; x=1779705057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=;
 b=hn9EdEGl+QO4bf199ZTx4eF9eL+E6KEoiUCBfsIil6aZZFHMvmEN3fWwZvRkNtvke/
 noPjQNQOXDWrlWkOWQHCeCAllqTfnfR+7gHKE2jb+CG/vgJIrAYhpDk984/upczz2J1w
 m/sCPSUTKZQnSKYwKqFDW6BWJH1iTMu85FqRAZtxlkrLX4s5RdiTIcomWYQmLUITil0B
 UBrGsy0GKItC6yS4buZcnHypqrwPjD+QEXNTph8lbsXcHwlS8UA5cdmFJ2uiHaTjUyKM
 DGfvWWx1mQR4/rZ/uhqz7/+HG2LEWI3VByucexBoPL9jzScUImAR8Fk1+daOSmdcg1EK
 9efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779100257; x=1779705057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hx27Zr2PfQkgYP6DocpvbcVC/5/Kjswu2b3jiJPzVQY=;
 b=sn19a7N0FUQo0s8Dy8uMn9Ew/8A+2vbGw//Vd2pS0JAwpnTUryjJ4eEprSKBz1srJH
 eN10q614JWqBV0J41BXmCRT++EufDA0ojEAomGx0ztg2/memFLGpvra7/Cq6Opqcm0E0
 4gzyn3KnJUOAj+kKjBf5dl0jPixDmQG/lVGj4AW+TheLgXqjS+djrZj3v8ts5dYWzoS/
 mjJvBMd81VlW8rrfWhkZUyE0HfEKflccZ+H49uZz9LJXPpjJtt5RpvuImGPy4j6c3n1m
 1nf30hvl9tcpJrjDaeBhSiVSybSJ8ky5RAvmWrw7mA/yHvrXa70ukCHWgDecoHvMCKSg
 gqig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/hU0jMf5GkiLqnkgmGrSqeVWQaRvn1eE7JysMBbov5puNVImeBbjDwtjZfsxvkTZ0Yp6ma77NCz0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywg0wSZWN2jQ1UYFgwzmiF7RQWO7yHidVUq4WwRyzeJoTVmzdrd
 DWC+iLgQhOzIjXyr6kJzJN6NFUYb6X5XeI2urAKrIaaOO30N17qJUao4
X-Gm-Gg: Acq92OEIvZrE/O7tlzk+JuzDGY7GgcWDtldEnHnmrhdc07i6laKR1a3JUtHqcCWZtFg
 ppF4/D3mix6tg5ARhI0SwXA3mePw90oZ0O6XRMMlBZvUPf/f7U+I8vMezFJZhCeUtT6TZhuQFeG
 OZvWNMiP+aVbr6TsZ8fLknYZWTKX2CXCsPij3dN/l4QfKIzy35Fk2Fu5e4FhiKnPBOYDorHlbWI
 J1MVcsnQFXaTHfsyZKdvlAQUvzUTW8ryoZ5iompF6gfjtuKa1zA99qz8Hs6iLt+zaD9x5FVpoyc
 1QMA6typAOzNtl85fLQiki3VCcL9gVrvHcEcm9jNZxSK2XFkkDitXIHSDqZsTloBZxd2/EfBGQk
 jknvA/gKdXxiYHhY89Fu7GRGoFQICZthj0Gy1s+sS9Hml2GFM5jJ2wnIFvQOUalU51lpZiWtMZ4
 H4VvHtpnK1Jyz+M1DPqr0lKJMCpwaskXrObkCuQUpNWXUCvkeI8bdGwwOmfcrJpjp1jeYNWn97O
 jhZ3XMRj4ZRwMzG4i2AkLl808R4r0bIV8RFfmcq4vUiqnn7lP/0kszkm10=
X-Received: by 2002:a17:907:1c0d:b0:bd2:bd3:1ef8 with SMTP id
 a640c23a62f3a-bd517a99797mr714341866b.35.1779100257041; 
 Mon, 18 May 2026 03:30:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:ec20]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4e4d54dsm542055466b.47.2026.05.18.03.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 03:30:56 -0700 (PDT)
Message-ID: <574f42cf-0d72-437a-8eba-fd970011e206@gmail.com>
Date: Mon, 18 May 2026 11:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <20260513083817.GC6461@lst.de>
 <CGME20260518092930epcas5p30d3b49f26efa5969ddcdb15351a886f3@epcas5p3.samsung.com>
 <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
 <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f9e04625-50c6-4fa9-8b12-76496e29f10c@samsung.com>
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

On 5/18/26 11:18, Anuj Gupta/Anuj Gupta wrote:
> On 5/18/2026 2:59 PM, Pavel Begunkov wrote:
>>> FYI, I really want SGL support before this get merged, but ignoring that
>>> for now:
>>
>> I was hoping to let Samsung guys to send a follow up they already have,
>> but I'll ask them to have about taking it into this patch set.
> 
> I had done patches on top of v3 adding SGL support and PRP list reuse
> optimization for the dmabuf path.
> Branch: https://github.com/SamsungDS/linux/commits/rw-dmabuf-v3-nvme-opt/
> 
> Also pasting the SGL patch here for quick reference:

Thanks Anuj!

-- 
Pavel Begunkov

