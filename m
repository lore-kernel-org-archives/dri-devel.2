Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20823CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891BC10E371;
	Mon, 18 May 2026 09:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZOC6Opvb";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2769910E371
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:11:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so23978015e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779095482; x=1779700282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
 b=ZOC6Opvb5j948x3M/H4Y3DcmV916S31rt92JzA3Sh7g+azrwOnbRyBFdbt2sbKSSAb
 s900uYICdhMhnO/8vWRGDBPMZ7PQ/XVgArKV9bPZRJ0L9X+lt1H4waKN5YSDTf/kKg1g
 9n/T5Xey2JZFcaH9WL7txhRVXdvuJ45uzpnn7lPB6VI+hg5b9Jz5xiEA+JcnOUvjkDcc
 sbdrXiE7fuKsAPzW2iKbBfD1IPLA7+6/ay0cRYtc8ZGf2bfPAXMLBL7BNnspNof5/l2x
 dznxkv2+tS+x/d+EFpyhP8zZO5jx4qOg26iQ63LTpmszhnZPTBiDthqKSyKFKHLSc5dF
 RS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779095482; x=1779700282;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
 b=JDRDZvWrXXfViKjQUrbTSSDEXR2PkJ2xegJTaVzrSJ2r5Hk/OcQeH7OGNpa34fQCUU
 2uj73kcLGUFF8icNm8yCYTw8z3tWyUIRUpupRfVCw8rCOk8hcsAzoaaQG7PEPo64glcp
 y5OyDHokpf7IzicIk/GH+M9tBQGMhHvYUaJeHDeWLunAmlxqhsdTchTXj39s823jGxQM
 zxCzR456wVpMQev4LWXID96pg80DqVpQacGwKZQF8G7ZIqA9HJa8T4BxY9XfhaDEiMW0
 RKHTpnRmEbP6tUtZs29KwIi2fyq7Zy8af+ladlJb3qcRcucRY99s04Ng+LfZP3Nf5VJ3
 2lQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ83VQKMuP1C0cH0MST8P5ZXspRTmdg2zMSSPjGV5WDP2B3WiEVueFx0vSWLD7/T2ZkNDh5FoxPoUAo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLEIT3xW8jloYxrOqAqQ6KYMPbvwG+mjwJkfkaH2Qwj7NVENjE
 oeZOGm+5bbJQTyBjKfpHBoL/FptleOYzFQWgZNroKqFVAjIEbYVC6Mqu
X-Gm-Gg: Acq92OGYAwAA9IOSxUndPuuCi0DsoC4QQYTkhqyEePSYzQuaDSebrdfvFNuhmvMXoBq
 gvX9TFe+MCbNQRqDIYwg2S5UpY0jtgFh3W9txJ+rqCaYG87neqG/Zy8qavys0rU8d+JD2WjeYCQ
 3XLfgsV361MDDOm7w17dxF1e9m/Qgrz+sRAGwq1a/8B2MfHlpoD646sieJ2ZV/YzGmk3SY3rIgp
 6cvYZrBno4Em7uq9zdMN5KtXjJMf2sFpjqVK5k0KEKd5lrjew+W++w2f9+9QpSpNXCC8PlTzpy8
 kJ/ocQC2d0wOjuk+9uBxKXeBaon9HmHhkeNPD6nKgTYzzrYlfSuIvy4jnt8XRLsrBfEP6U0CGJN
 hyC9bLcq35QY0PyZN0nADHvRDHlEGCUMDF+w4MPSStsh9y+I5A/r+/XeHxScXWKkvEGveUuAoIw
 EShhpEkKYYZ4/h3Fs3mTOfPXKfAbGpYxvJeqgjWeh4V63iY2T0AA4L6Y7begYR5u1JAlAmCqyIT
 Ai2JN/E/tUVyqyO1+cxmokluofdmw3QoKuqzl7P7ZneFTtCLIR9IstgEJQ=
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48fe60e7d79mr178172895e9.8.1779095482306; 
 Mon, 18 May 2026 02:11:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:6e9b]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe79ce3sm80272945e9.31.2026.05.18.02.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 02:11:21 -0700 (PDT)
Message-ID: <d262dbc0-48c1-4994-917a-1f975c60b2af@gmail.com>
Date: Mon, 18 May 2026 10:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
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
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513083937.GD6461@lst.de>
Content-Language: en-US
In-Reply-To: <20260513083937.GD6461@lst.de>
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

On 5/13/26 09:39, Christoph Hellwig wrote:
>> +	union {
>> +		struct bio_vec		*bi_io_vec;
>> +		/* Driver specific dma map, present only with BIO_DMABUF_MAP */
>> +		struct io_dmabuf_map	*dmabuf_map;
>> +	};
> 
> ... and please add the bi_ prefix we're using for all (well except for
> one oddity) fields in struct bio.

Ok, going to add

-- 
Pavel Begunkov

