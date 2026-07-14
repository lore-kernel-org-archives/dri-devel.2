Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC90BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D9C10E69A;
	Tue, 14 Jul 2026 09:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p6sCIi9A";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2098610E69A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 09:22:08 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so2210028f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784020926; x=1784625726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
 b=p6sCIi9Ah7AHZVy2j9e4zK9bq3f2hIRNt4jkAcnBSBBCvUmT+bST6K8IFfnEaXyHxE
 TB2Ttalcu+Hxr344IVwsGiLQlJsgY7vEJIURrxMfloJe1byw3WwzfqlmPL85Z7MeZR0M
 somFIKPYvLPUp/lUTuFSPm2YWe2wvkN76lmybn9KabULhVPXcwwuuEIFt+DbjwfHyR6x
 pFP15K3eAJCGXwqJuSJCiEa0YLjrxRSa104xLgmUYutJuEu+pVwuMTuGgxMZCWPNcTHH
 3LyQ1Fj1JRaCUBCFCasQt07HXiqyeCeAcq0oB+coNgVHD6drLGnbofbx4FoXBs2lNPZT
 WI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784020926; x=1784625726;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
 b=SxG5G54eF2LJQyBXIbPEeafQTW01/aJazr6u3pLihE0ZnG2/wmYAy9DSWVg1p2VHwc
 BqZO4w/fA+E2225CKk4Asmtdyj1oQH+l51bV4+dgqrRss/XCaSYEDHv6Hrma/FApwV4s
 mI2ZVz6tn9Q1WWcskP5aUjT1PRqwZRUaHSfNo9FVvORxBIzzkSiOC1PNtAGl05k3hdxz
 zxl6c+iBwgq529a/cjhkTtZ6JSrTsRI42XtrCXIlNgQg3HU8zuC83EgD66NLRRVs1RGc
 mJYCVCYi4tbE38B/Fuq3Il6QDHQ0yBcf2QxiaU62HYLm3+5obwpCarr+z9BVg+lNIfwe
 w0HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrfm9n39LEiG1JHYo0/aqSOlVBDr7hq92opJOyEQFDFWsnQjy9BWLFU/ydQqKyTRombgvIXvm3yg4A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaSc5ouvhVBln+R5ZGgEx3y+m8hHUi/1K8xnZD3K2SpSUV+bxM
 MOOuXzEnFgtG37wWJJ0841ppkwpY4W+acaOeshDwbwP0AEe5eZeSHVOe
X-Gm-Gg: AfdE7cm2+pP0Jubud9NRfNdSGtJ4ZYE4Kj+0tLZQGmw1GNiO8FnGsSyiNpcKwAEMoxR
 ZR954UYfznskm2eU+x9MyZw22ImPugtiSikoqmNKtKELl5VlDCXhPa+jNDQ32jM3Cpw+O9DTfAD
 46l8dSfSN2Bsxw2wAAXZdTixOrL/uMFySvXJB7ieUfyzgzCVY6l3taZKe3qTMktJsZ71ZsOcr7d
 vfkpBbPkO06CpoX3t65NqEGTW3qLlbGvzZH1GG6sRhYOwFB1q6Ur5l2YOC9dFpCqTXkLjWzsDHD
 KWQ0+FKXj66QVNcpl7PECqA4LEcftRLdXGbmqIht+XF/EzHQzQc79o2YNeFg0FLaAvpkwMi1ax9
 f7MumMrjSPx1VG1yX7gZtjvNgp02QWVI4CYYz+TF/qW2x/9iujVp7+9vBXstJNgDLARA8jMX4+J
 hJgmR+Ph+0kf6Aw0QVCzVPX+89zPt0S9dVImelKi2one85fsGlIGRTm0cReWwjm4koAo7h50l8X
 zmOqnE5k6u64MQ5Rar1xG/S8/UMEkXOmsx6Oo1nSqK2zg==
X-Received: by 2002:adf:e186:0:b0:475:6c34:2120 with SMTP id
 ffacd0b85a97d-47f4887dd78mr2004457f8f.18.1784020926324; 
 Tue, 14 Jul 2026 02:22:06 -0700 (PDT)
Received: from [192.168.0.207] (nat-wifi0.uniroma3.it. [193.204.167.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f476e9d02sm6291743f8f.19.2026.07.14.02.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:22:03 -0700 (PDT)
Message-ID: <619bb771-1038-4ec1-8d4c-17dc69df33d6@gmail.com>
Date: Tue, 14 Jul 2026 10:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
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
 <20260713071828.GB30168@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260713071828.GB30168@lst.de>
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

Hi Christoph,

On 7/13/26 08:18, Christoph Hellwig wrote:
> Hi Pavel,
> 
> do you plan to resend this series?  A lot of people are eagerly waiting
> for it to land.

Absolutely, I'm going to finish v4 next or hopefully this week.

-- 
Pavel Begunkov

