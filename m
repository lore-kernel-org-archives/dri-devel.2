Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E91FC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394E810E154;
	Mon, 21 Sep 2026 13:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DSrn0v4h";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039E510E154
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:44:07 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9a59so4267927a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789998245; x=1790603045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=;
 b=DSrn0v4htpB+/lts1ufbX52UBddTf+3Y/R4pByKuz3AE1PgI3lUenvvQAi/CltO3l8
 PvVF8srLrTcoj0JCmBc4HXRHJuaF5vetVyWR05Pq5H2zljdGNGe1Kmwp56e2q3L/6kWw
 kzmJMcTsyIPpU0ks59mbrQhFfhi4W0Nyr1SYcpeqCYBfwm2KInEs+599ffFMb5vVYohx
 v6DKRPCrGLWo72fT2q0ZT6xxOG2RewsaLJVkfubO82uaK6S5bBuOgQd98q9zRzIqRucz
 5xEpHCDJRk5tCjdGz9E4IsZEBr0Klp0M8NNDZB5yng80jxrafIKPTufONVR/OYzYH34L
 5OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998245; x=1790603045;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=;
 b=uuFs+BIOYRfEWEbiHqVTVw3LTIcLG68jT78fXKnGDVzfcK2C+j0F+PRFWLaL7gMzXl
 XOu/ZO8flQNaBL/5ioF8Sm8aTf5b3VakSKW3WzINoDPICiJeZpFrpF31sOoAWNQZM8RW
 0YAxYpbBwbbuSo7kq+0IZA8rHrToU5orI2OjoGnTSrEP+Hr0fhCKa6Gwh2YegfwxaCIs
 fx3QQVP5sMooteUBXDyv6winuAkdFv9cqVoO4r/nqymFs5rn/c7KqYHHCnGOksQL7Hlz
 tq/sFi+YVb89lRpr45hOBXO1FwRUtf42lymsjfeDJ7+OqBGp4vL1HKpuyi8QJld2cRHp
 pOtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL7jxmKZvCYyDKjRKj2ZTdcYPgFDiJhv5CM1chQwXClpA0UmsQn0+iieBixtvNgMFPCVamhnSeq6g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLXPPNGp/YfMiagcS3YY2BJLiM5sPim3k/669chquyx9tTG5xn
 1f2x7itZNWXbgMXJjWcYCIXiakFyI2zrEEwAUkDec6UynPYNwBSjCh/J
X-Gm-Gg: AYBFou03I5noMuBrPEmSSwCSZP5EQr9bK0ItoBqw+Lh7yoiIOIO2hMTLoS0xGGw4PGm
 qRg8rgaBjkAuMXXEUKnN65QnSa8PxkzluYzCR/P5Ik1HmSgadUpQU/WeCKfxYgzQ7D3E7a3qzqL
 ZnOiobQSXnDPEFlrqEo0OU+1kJuyVrIQKL1vSk9RqxQbY4zReZ849qXyu6iN4XX9s12ATJhPJWr
 m7M7u+QpEmp2uXaQ2lnz8Np0a+h5gNS6MZxBGcTFiTxuTAxUfpy3eqwCi4auK5Q36kWHZWR/J4S
 NKuwjSXMSM/zdKXYe7K4lgkufjAhQOQdye2WXAerhqCbOma0uRTuDW5MBu8VNvmuHUtv7YNYyc6
 dSrcSunquILf6M2a8hXhg0ehIpPZcJ3VtxMwhgOLrFt3rrypTlym+3e3Z2bRCchOSq3QnCSlKr4
 AhjI2mJu4gSiHOzJ9ozbOJj3JiGLWl4ebbuRT5yZHtLCpRLrwOLOjMLTquy3McdjLPXxziEhq0H
 Wa4En0eni0cG4iLsPybGkwOOOUrtr31PnwIbcSztLffS8qcJdvzX0zdfCYFxKmHl41u/6dw4sJZ
 CGf/NuhvU92jdxCjTIID6v7vu1wPYfKszMm8Uw==
X-Received: by 2002:a05:6402:2355:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6aa53104448mr8100478a12.5.1789998245342; 
 Mon, 21 Sep 2026 06:44:05 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67e0d3c5sm4417232a12.22.2026.09.21.06.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:44:04 -0700 (PDT)
Message-ID: <b3e1db34-45c8-4723-8d09-eabc28bb0988@gmail.com>
Date: Mon, 21 Sep 2026 14:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O
 infrastructure
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, akpm@linux-foundation.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, nj.shetty@samsung.com,
 joshi.k@samsung.com, anuj20.g@samsung.com, tushar.gohad@intel.com,
 william.power@intel.com, phil.cayton@intel.com, jgg@nvidia.com
References: <cover.1785596451.git.asml.silence@gmail.com>
 <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
 <20260808074245.85757-1-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260808074245.85757-1-sidong.yang@furiosa.ai>
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

On 8/8/26 08:42, Sidong Yang wrote:
> On 8/1/26 16:46, Pavel Begunkov wrote:
>> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>> +				  true, 0) < 0) {
>> +		dma_resv_unlock(dmabuf->resv);
>> +		goto retry;
>> +	}
> 
> Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
> returns 0 for a still pending fence; only -ERESTARTSYS is negative.

You're right, and this chunk is gone in v6

-- 
Pavel Begunkov

