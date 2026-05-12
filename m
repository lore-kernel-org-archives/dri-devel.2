Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5972ECD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4AE10E28A;
	Tue, 12 May 2026 09:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="he0vYbcj";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F1710E28A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:30:39 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so286543566b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778578238; x=1779183038; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
 b=he0vYbcj1hS+a97cnq6aG616guLOIP3ITzlbtCUeND6ZZH1BdMoDWOIO9c6tVDS45A
 n59EGEV32j1ezWGJ53oTULoTed4xL2HrwKGTKdr/ZLhgz0j1+U3upypNxDOY9SDnaN3I
 pa9Kr08pAR0K48W1wAOmuCnz3ub9MYxmZ2KY2OuEWDFEHnNpvKM/iZrrxviGNcL4nAkr
 VEjz18Icwr5t/ysKeUAYsEdVsaTZ/FIPnB3ezFGUUiZ4KAE0rWJEVjwmCgrjN6Et1ETT
 HAfEdYLQ6+dO47cmqnvf220606Uc1PHoRQSenIe9N+Lpy9P1bTEYA5AwDRpQfFSzG/Ym
 EfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578238; x=1779183038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
 b=YUuKuMvwlSTspLFQCYS5wHO3lKnjrkBlAGwtuALlaQ95XZER4D7MpJULxKxif33rET
 OG7WbvH6wMMlu6BaUeun0XIVefP256MunwtXMSSly/lJu2Pt8EX4fqHWkLnytP2xvisL
 WYgt9W6a65+B4n6j/pUlaj2PoIGByNrCOUjU+v3S1oemwFbuWp7+bJcArIxMSxhWj1go
 h7v+aoNW2Ad9ZfCiJJGwXCDzNdIeL00IAkK1hblRXSFThmeiyvTWfvuLkbJPVhzJc+IF
 xUaE/girlW74deL2wmOMc38XlNQb1Vd5vdqHpGMM7n2pkSskygzlD2pid1VUv4RjAnvG
 E4jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ovCU7HoJu64WroE29djiGzVLIT1YpdNZAb/eKBwWmYhC0ELdgOW3WATtEE6TIXRkyI1cOmP7GX3E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwZQlbIxyKT4DBYhTeta/dLlH1c5W4zpAbmRSq2njF2PYezxW7
 WfWXGACwSukLDgC92vZCR+F6ZX3su36t30HBs00rGUK4JP72DxmmeUtd
X-Gm-Gg: Acq92OHeFmqJFYDfcWYjPlH6KBQleNtU6JQ2DoLeQ6ZRyblEga/5i26/SALgCqtO3Sq
 Ul0uWgyTwwK9ckkclL5te3EPb+DyKWC8TCCC8w3evdGUKIQ6eAiiqS2fRzywr0BxrV0ZP6psf/T
 RSokgWrkZkxtkjy+krqa32t+qZrH2mv3CGp9jaSxOJen95fVUtR8TF1GVQTotRa373HdMJQhI+J
 TMiFAYPRAQx2qrl49aVqskB1YKNmWXrKm+ehyReGz1ynKTkg77aZmnYjFGKgo/JK1GfpkaETwuI
 4j+acHfwVqpnGhmuIXPaghDUrl6+aFXs4nspKqQTJvTU2YyZFNZAS/CDDSWKBW7FZ+YyFO76Hyf
 KHbCkIZ4p//OiRU7Md0JONW6cR4v8KHjRQUi74MyyXOwf8OTDz6bseCKQGFRPYt76b25unTpZdX
 lKHWsnrct8hoHTKUcatEqOlVdVdEq1xo5SW38Lp+0UiZq2FbnpRKYR6WCL+m559BIu9k5PBnfnQ
 x7nlEvvbunUM8lJc0VOJsevdnclEdi+62Ng53LoXHxcdO8Xpw==
X-Received: by 2002:a17:907:97d0:b0:bc2:1dab:3ea0 with SMTP id
 a640c23a62f3a-bd28de036d4mr114881866b.8.1778578237873; 
 Tue, 12 May 2026 02:30:37 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 02:30:37 -0700 (PDT)
Message-ID: <24cc68b2-c432-4623-92eb-b56b76850c35@gmail.com>
Date: Tue, 12 May 2026 10:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <afi7c-VUJWOLlC1m@fedora> <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
 <afxgc4hizusnAA26@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <afxgc4hizusnAA26@fedora>
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

On 5/7/26 10:50, Ming Lei wrote:
...
>>> BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
>>> which can maintain long-term vfio dma mapping over registered user-place aligned buffer.
>>
>> Interesting, just too a glance, and it looks like what David Wei
>> was thinking to add to fuse, but IIUC he gave up exactly because the
>> client will need to cooperate and that could be troublesome.
> 
> Here the cooperation is minimized, maybe one shmem/hugetlb path, or memfd,
> and it is one optimization and opt-in, and fallback to normal path
> if application doesn't cooperate.

My point is that with widely enough adopted interface the user will be
able to opportunistically use it without knowledge about the file, i.e.
not knowing whether it's ublk or something else. But as you mentioned
below, it'd be cooperative interface in either case.
>> Should we try to push everything under the same interface instead of
>> keeping a ublk specific one? Again to the point that it requires
> 
> If generic interface can be figured out, it shouldn't be a big deal for
> ublk to switch to it, and the usage is simple actually.

Sure, you'd just need to maintain both as there is a mismatch between
interfaces.

> So far, ublk supports both FS and nvme block device.
> 
> And cooperation can't be avoided for this usage no matter if generic or
> driver specific implementation is taken, for both fuse & ublk.
-- 
Pavel Begunkov

