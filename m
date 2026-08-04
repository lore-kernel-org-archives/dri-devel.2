Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA50BC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C53810E8FC;
	Tue,  4 Aug 2026 08:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lcBDT7ph";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C900010E8FC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:42:06 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so753604b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785832926; x=1786437726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
 b=lcBDT7phQnfJBP0xVp6MlsFj1TR8wVUrC0QjhFXmspqfobRxr1bYSuaBEzE+4Ii+ne
 jLmjNF6fHt80I0zjhVsALNLieg5lh0tNqMOnMPOFj4DQzGB5Q68+cuLaOGpBi9K0oG5R
 RyVKRban4myMMGqoV46MC5A9oFg0atQ+tbq4Wl3EvkVtiUT+BXpd2r8bMLIdNgYu6iZE
 B5cpawGQ+h9lXyHi7ZqcA58DQr6CJSOY24bQpWuueQ50svXn8sdTSxQ2lkwOvsyksHtQ
 y7silX4/N2SIBp+EPvZAtR7ORj3KOelenYEIxC6KET0R9ueEP3ERQcY776tFcAFR4lse
 wMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785832926; x=1786437726;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
 b=iu50plt3eoHyALBSXqQY4WZhtz25yVRan5fZgFHxKars/h14yFDwMY6WkGKwqK2ErQ
 ess/pwuVBgn6mfzVv5AlaPSjJP4sfwSrpKzDcnvzz9GFMgNcNtaXUfro9rOgbMl1jMGL
 PCRRrXtPCoPO4S3I2YxGt0+cG+TT3I9y5hXtYtSn7z8gVCq3D2QsYJEtkce2I9PbYSnF
 f6zEYk5YO88fHRJmU8WJ8V+/vyTS9COZdbBrCDsAs/rNfylUO0dsT+nvBU9H27FfghF7
 n6Pxl8VrUzpKKFKXQthinLg7ZEtkW+XlvPq74kf+tXjRDVNDexe30cXphS6BYq5rCgZD
 9oQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrj4S2cwhsHKUo98H2yrcm0L921curdvPmUL5EcQwpuXRPDenw418X3pEn6RCAX0ubc9xXfNy9M3bM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yysqgc2BHegvHRuiODQnYq63JUrvHdCTWEGQDA1+V+WYFFEvNUU
 0xCtKs6JCAwVcCByFUjCygo7qzInmMWsSbF1Neb+YcQqjfJbxcUzXvAS
X-Gm-Gg: AR+sD10byNgE18pv90iZoy67bVGnGDAPQd8dEdCxg78JeB3SXvcEKEgyCMUgKV8nrN1
 koWevjNw0slnUsf3ThEeaI/hSqvhVLLjYy+5gGf9LEZBjB4JunxIpyu84xMwnkmPGfpIj3k1YK6
 hoVZF7xfvQF7r0Ysq/C4CSu4wIaC3GKOYIPcgMMq+Yv6ty+SyoH1UrbrF+XZ2LYs6TrwzwsNmMQ
 GYAH9/SIvhxkAkOwnuKussjd2BEVIxCllBrlEpqj979g5eJGoqDab830nafGyw7ezWZqk0MVJNo
 bFl26Sd07dtlQONFWPrmLvamyawuhPf4lOVFpvQY/MSy5RR/NnH5BlQ3G3WRSJQgNbsUqJF73iX
 xsxtyEqHjbxfvINS2T75Z8IH6GYp4KIRXl0lD6Ux+vA0NLNp1zSeO8RqUQafxOkK3az4lZ0crjJ
 3hP7W1bsAGW09hF87TVga4ju698YorNbHJnaIovm+qTLuy8twTJYYDTwLDSc0Q4R0sieAIRT6+r
 dOzHSRZ/EH4hIcqQBgjz0tKTPpTI1W43aqiA1x/ChcP7ahHLMeaR+KQEtrExcqAtP5slvgtAV+J
 vrqzj9dFn/lmThV1SgW5
X-Received: by 2002:a05:6a20:9188:b0:3bf:6c27:38b with SMTP id
 adf61e73a8af0-3cb6c937c3amr2601207637.29.1785832926102; 
 Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:541b]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe39ea0a73sm4753273a12.23.2026.08.04.01.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 01:42:05 -0700 (PDT)
Message-ID: <53c9cf90-4284-4b6a-ab2f-1686c7461bf8@gmail.com>
Date: Tue, 4 Aug 2026 09:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] nvme-pci: implement dma-buf backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <CGME20260801155005epcas5p4ecdcdf532aa2c2ff4e94638eedaa435b@epcas5p4.samsung.com>
 <9e3dd1b2d71dc0f9bd556b6a6d6e48fb6a8d727b.1785596451.git.asml.silence@gmail.com>
 <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
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

On 8/4/26 08:29, Anuj Gupta/Anuj Gupta wrote:
> On 8/1/2026 9:16 PM, Pavel Begunkov wrote:
...>> +	if (WARN_ON_ONCE(seg_shift < NVME_CTRL_PAGE_SHIFT))
>> +		return ERR_PTR(-EFAULT);
> 
> This should be 'goto err;' instead of a direct return. If this ever
> triggers, it leaks the map and already established sgt mapping.

I can change it as I'm going to respin the series anyway,
but it doesn't really matter here as it's a warning and
shouldn't happen.

-- 
Pavel Begunkov

