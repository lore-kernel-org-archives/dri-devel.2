Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAE7CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 07:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD1D10E051;
	Mon, 25 May 2026 07:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apEBNKnG";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F64E10E051
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:29:13 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso18242355e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779694152; x=1780298952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
 b=apEBNKnGd0zBMjIDbWL6M8JOK10F0gxHNshDRlmsUkSs3B4zsMqER1fVAAnY5tZ/d3
 XgffBDPReF3PCIgkgKzxPSgTeGAty92z9gPanbOSVw94L1QHUE7Fxg/10a9gProye3vo
 ZblRym7iiWq9qU09DO869Xy0IsGCdEjMthuBfTYyiGQo4K5+QWTeGsYG69ip+gEJbtHQ
 Kb5fy693/tdicYd35hrrUlE9W8dnlCPFSpfSUW14aAG1AChKtfBOqyk/m4ZlU1f4SvyY
 qCo5L+NKXCJ5VQops1oj/MwaHEFgR1r9zglCuf8IFaLLg0cfeFLu2JLJfuCf64XLTsBo
 uXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779694152; x=1780298952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
 b=A60u0NH9WzMZRQIgnN8ArD33lua1GbhlbAugO3mIc0mubboXYtYCpY0ccYdgDrsX05
 HB6c7e5WJAG83O3fgJC4lAgx7pD+AsBxfn6gMdR89npVlzRqlMBDs8eyxLcI2k6yIHlt
 YTNICIWa82XJD4VwAWjs3AfL1ahSkO3y58WmadyzP1PFa96qbB6rZuddC6diBs3HsbAT
 z3VP0cqKqtg+xvMabV9vW05yJso1C5WSFR6lx/QNjkNMXAMInSJ+OU9Fdqdmoh4gG4L0
 b9kP6MqPSW6IKEu5/QDu3clS0mLI12nstmCnsoBr7PnFSl95Z+YkP21/7iE/BMPuSZHH
 aoYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bGPz2RCH/4Amnkb03zl0R5CN5u/DW6F1StnPtE4KJLGfAFSniotAgS3adRQtiYXXUR2a2uFjz8pQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqsf3FnNGpW4IUH4X9FIjua6GOyb7syfTUn6dunlrRgewPNzu/
 FP/0eNb/6052CgjUBJx52Z5KghH8O8JmEbFEkjsLxYnqbQmVnzcT+Ru0
X-Gm-Gg: Acq92OGUvdwfMQuTY461UjDmBqqiMRZGndTgO8CTfdaag1Cjm8NAeBNNEPBta/4W7mm
 m6Eeh6uKXU2t4TljA9j+7G4sm3SuGt9gi/2aJ8SQDu/+J20MdCmEK97UfMtNc3Qb4mSrQuZLRDz
 qQsSGuiFNXKa9R0rIFyk9NMBIOAFaJ66kSz8gQSAXiBXm9iMTbDvqpdF2YVf4WQRDYXy0WQGg5z
 D6qBHMaq3TO3hRisz+zuEB9f45rPbbzk75SqTmLIyAMp6+1qLycp0JsyCcL5lHTr6YmceTKa6X2
 zC/oF7DUuT7JqFTAQiuC08r1t4Wj/ahGu5lOK/6/mOO1IC3vt+3hGN/jMDRpr02IWVrM2C1V0oO
 l8+/jWpglCOqBT+3bS6fj4wM5s7JlAaKvQAi43cUcJMvq8rTFVfJTgJOEAZMpSAWlBmyNwMGde9
 +NoXAywy7SowLWFzgmXtYjH7zIdRDgORqhhESfA7q6+cgC0IC+MvGgyDxDySYIuov8F7n+QU9OX
 jrQs8zHhcZnE+C7BOapKJZLqm7bFk/5H/bcWqtSaf6aO5AwD7f3dVFmXQyHZZ7KEwmKWAVTUQOT
 uQF5NkAo8JAo6T0Bj4PUOKo=
X-Received: by 2002:a05:600c:c4a1:b0:490:1640:8269 with SMTP id
 5b1f17b1804b1-490426d1a16mr227253215e9.18.1779694151663; 
 Mon, 25 May 2026 00:29:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d4cefsm81771025e9.14.2026.05.25.00.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 00:29:10 -0700 (PDT)
Message-ID: <57ae2e2f-8523-4cba-ad77-920535edd236@gmail.com>
Date: Mon, 25 May 2026 08:29:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <20260520083043.GA18893@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260520083043.GA18893@lst.de>
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

On 5/20/26 09:30, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:29:54AM +0100, Pavel Begunkov wrote:
>>>>    	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>>>    	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>>>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
>>>
>>> Shouldn't this be a REQ_ flag as we should never mix and match bios with
>>> and without this flag in a single request?
>>
>> Do you mean adding both and propagating it from bio to req? submit_bio()
>> takes a bio, so we still need to set it there before it reaches blk-mq.
>> And there might be bio-based drivers using it in the future.
> 
> I think I forgot to reply to this, so let's do this now.
> 
> REQ_ is actually used by both bios and requests, so if you set it in
> bio->bi_opf it will automatically get propagated to the request, but
> it can also always be tested on the bio, including by bio-based
> drivers.

Ah yes, good point, thanks

-- 
Pavel Begunkov

