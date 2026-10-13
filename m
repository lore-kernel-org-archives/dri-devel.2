Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5C8CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DF410E984;
	Tue, 13 Oct 2026 20:09:29 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4023710E984
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:09:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-487049569b6so2371693f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922161; x=1792526961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=;
 b=LZ5qdAtQmqTNUMgz7yBZex+rbpefiR7W4UjhtTLy4F2Z+7cOTZBZrPZrtGYcGLpyGP
 tFbgfRDT28blOlNsGJPIYxxgr6WDqk8/dMJzUFbvP7qqX91tpzCtYDksumti0DE63my1
 TSsvt+iE0EYr0RvcXGwtjBSWTWX5SDXePbCelkYTDCesoOmUl0BnvDxAIlKeyHUiZqD5
 H2MxWJmxSsIF9PuMQROB35hYJTgZP2PvAO5wd1o2HPFwgajzM3mt4kw3ncywoUPZovLi
 S4RWgRV0YVUvpYGiq/16xVT0+BXIDhZT6/UJRxtlQ0jsFbBiDy2/pGCxaSL0QgK/m8cl
 R20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922161; x=1792526961;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=;
 b=ZcEVC1b89T4G1gNZWa8f6qZv2pURDiELjq1xfixfvM6/Hds2FPVeJw3XlDhYih8D4I
 Gg4osqpWhRYR9W4U8YGzcHNEvItQfSrPGa7qKz3pCv5JMt2erWXOfeVFh+qePpZNG1Nn
 P3s/bVql6KRM5R04C/BG6w8GrOCJOLvVw/bCF121/D1nTA8wwHLohj3MccqhmhFIq+UH
 PVG/fVU/OALad53HKAZQwV63z4bKl/QEGpDbxB2i4en9YR2ip9YGOLuHOb1vtGRQ+0n8
 8d6PLynDeycHLhRljEvVW9W8xLV62bVlhy+Azxka0JTVi2xehdTtz/1V72kN551gP9HW
 V2VQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxplaxiLfVYtWFAtuEbpwiJbHv0iYK6lRImxWoDMu6TiZnETDUrkZ5tFg+tC9QNpKlFFWaXl/KN9AY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIirM3lL5av8Ecx9VbMGLtXdubumtq0SexuRI0h3SKRHu/TVDLW
 SItTEP9FpNujdU1Xcw6iDByWhz3zhs4AbKw92M4dkwqBMrp0Qa9ok/K+
X-Gm-Gg: AYBFou3jKwrIktSzL5RO9D/UaGiAlsvJfPDVKa1Q83NOen6YAPZiK+AdwtpEiW5WUpo
 mGn4/ZDz1IQMVnFv363Wj/McneAMQqdlbKYLl3dLSO433XuMzpZiX33xQK7y70V1Oh1lUr4HYxm
 vNFt+HNuN49LTplivJ+bCoUMdZdia/Xiume9PA3k8X5su/3g2dn4yJXT73X+X1+qS8WrX1Uvk5b
 hvLOWK4I4rzKA7/aTd/TPyJ2mPjawH/x6pv8D7xlmFCUEVmA18xX/OyjlH+2LmEszhfl8QGbdHD
 ErAmkGIfiQ10qtL84RZvl/7svjW9pmZ26NTvd/mG+nmZpVXoz+1FdBLgFIE67fO0n+4zacImfGo
 DiHqzk3YTbRt4da2q+5jnuWqLn2tD6MKJE5sCF+LBe9UP2C9EQkRCTYqb0nYvmvm1Mua22oXngK
 MNblYP5RcCFiqFwf/lMdX+//7eotI33T/q4Vt80k8JqZlO/Sh9SnyGW0Y5HK8cLwZJBwK+8Tsqn
 CciaRZrOAjUJZV5zs1hIkuQph6wQXk5TTQefw+wS/QZS+bgqHMq1CRK7l5BWgpnEFw1Z+M/HbOL
 2cImaJyr3Ki3VFEpy+Wnqr5FPRUTf9cp/an7+Jfom6/wWwyv
X-Received: by 2002:a05:6000:310c:b0:487:8b9:526a with SMTP id
 ffacd0b85a97d-48dbacdaa60mr25864079f8f.36.1791922161609; 
 Tue, 13 Oct 2026 13:09:21 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab5af7sm7243430f8f.31.2026.10.13.13.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:09:20 -0700 (PDT)
Message-ID: <293d49fb-6488-46da-bd3c-6f8600dd123d@gmail.com>
Date: Tue, 13 Oct 2026 21:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Matthew Brost <matthew.brost@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de> <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
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

On 10/13/26 20:06, Matthew Brost wrote:
> On Tue, Oct 13, 2026 at 04:10:47PM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>>> I've queued this series up for some testing, in a separate branch. JFYI.
>>
>> More testing it obviously good.  I've been waiting for addressing
>> of the Sashiko comments on the nvme patches before doing more ACKs,
>> and while I can't really judge the code those in the dma-buf code
>> also look somewhat serious.  So it would be useful to get them addressed
>> and the series reposted.  Same for folding in the PI vs dmabuf fix
>> from Anuj, although making the combination work would of course be
>> even better.
>>
> 
> Oops, I forgot to look at Sashiko's feedback when I acked the dma-buf
> patch. I think the two cleanup issues are valid,

I stopped answering to sashiko as it repeats the same from version
to version when false positive. Those two are warning paths, which
should never happen, I'd rather leak than crash on double free or
so.

  but the reclaim-related
> ones are not. 

Thanks for confirming, you already elaborated on one of them in
previous revision, the new one looked to me as the same class of
issue as well.

I'm not sure why Sashiko is confused here.
> 
> I wonder if there are some shrinkers in the tree that incorrectly take
> dma-resv locks in a blocking manner. They should only use trylocks in
> shrinkers and direct reclaim paths.
-- 
Pavel Begunkov

