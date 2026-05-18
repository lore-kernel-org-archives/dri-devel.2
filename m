Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622DECD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FD710E4AE;
	Mon, 18 May 2026 09:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U9QdLm8x";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CE210E4AE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:13:10 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488b0046078so17753285e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779095589; x=1779700389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=;
 b=U9QdLm8xTxWEn6b1avuO++JG7gtRfPyxiffCQsG9N2b5/rjboBzWXrCGi3NNRhCY41
 hHSH8qwZAiFWEQYMfAYvPIWvv0wIShJGQrBCvwF7NbHNYiqpDYfmv93aRIZnq81L62Cc
 jrR2oGUYtXJWedL1z/CQqbtpXXKbmruTa7wQBxHyh/P4ROW7NjspggoFBbOpWDyLGB+L
 pSrt6JGKDivd/Lefwy/BDIwPNHUcy6NgSMOhTf0VO7kFSZXLjuIkkgwxT/DvamE1hMlq
 cO4brAW+e7SxtjtJ8CVxYjCccRuhK4KU+BUATcIP3uXq72FuBjmXHbF2LjeWWYmSNZ87
 DDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779095589; x=1779700389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xG/69Jp5I3ufceWw4+S4Fo/It8aPbBbD9UGvG/3mKFY=;
 b=DTl0j5Qu3gEok9qNKifcBgTmFzMa96ixem+siVN/PwKHseBHvmEJgkicxxI9Fryaab
 oR4e1bnXt1hZgqFlGjZMKfofn8IDrKqBFHgDkamWz86HlMn1db8CcjUGzdlIK/qB8asD
 tHV25XojRSCzndWeeXOiXngui+oYb/l7txNaOS2eAl2VW11a6ZjZotUnz8YaAljJKfN7
 RFu0KDi3dIPgF9KpX2KxcGLaVeiLBsCcxwK787Zv7OeZlDN5DdqPGR+6YCly8ZLfJHv4
 gzhUKAxJOLV1diTk9huK+RuBKqiKIZQMkytOasfg2QJUWfilwb1eIx8FaR4zHfCq1lUg
 /87A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s8yuPdw4rahd7Hi/sTTHL3OKQSlUUq3QvMF09P2d+WkcWsdri93fizkzhYR8/5etRnJgm3DwU6N0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxctyeR7nLVyEOZxT/+/yzvkOp9dL8M4kuiajI0WjFaNdLlyN0/
 CWoXbrUP5CFTcDZK2rY0cguBhuFaDJR7ZnQa5aDUsH+HXE95vzTrXC/C
X-Gm-Gg: Acq92OE5080YoNWQ8VF9B/Zr+tOIMVOaeRgNxjlikRKgVzlxY749o9qaZwY18xwJ4LH
 uS7Qi+Kz3KhSh5zDrPSm3ApFfqUNkFXOmkpZIER+twFjLWlNekL2SIjMacPoAjxJ3SBhocCyF0Q
 S/qYGVVoyyHElhLkK7YHoUAgaYhgXG6TWaBGwVqaxmIc6QJp7zK/uLF8gCW0pYFEyBmOjzZ1mBZ
 eiJYji76duksSVeiDuuhD6S4cQOy8tF5kkA63Rw0c/sF0T6FMPVN97Tp8agKUcEDB4kEG9PiNc+
 zr7nOqF4CluCU1O2r3T/KxeftV2w3mAa8rkH1wuVON21ESG8wNmQO8YvQ9usvtLqTiih65lPg54
 byzPjtCrQKdWV/DhVBIR0AZBlxA9WosoIe0a0fGZesw5UxhuRGO9hpBYb7KadUO2vkxuPPgjQWV
 ww++axwWM6CdWj/ztNnaEyw0fKBzRUJs2PFyeYu453//mpjM9O8pv09C2cgvq2ibUTlqXunKZuQ
 IjduY0S214JUXBlMl1QgXfT9/++15iiegLCobmdNDVREpZOept9uFWTi6M=
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48fe5fcdf50mr205316035e9.1.1779095588623; 
 Mon, 18 May 2026 02:13:08 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:6e9b]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm36837416f8f.29.2026.05.18.02.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 02:13:07 -0700 (PDT)
Message-ID: <88576019-44fc-4614-9e89-a17478dbf340@gmail.com>
Date: Mon, 18 May 2026 10:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
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
 <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
 <20260513082553.GB6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513082553.GB6461@lst.de>
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

On 5/13/26 09:25, Christoph Hellwig wrote:
> On Wed, Apr 29, 2026 at 04:25:52PM +0100, Pavel Begunkov wrote:
>> Add a trivial implementation of the create_dmabuf_token call for
>> block devices that forwards the call to a new blk-mq callback if it's
>> available.
> 
> This should go into block_device_operations as there is nothing blk-mq
> specific about this.  I.e. even if this patchset doesn't handle stacking
> drivers yet, it should be easy enough to add them in the future.

Ok

-- 
Pavel Begunkov

