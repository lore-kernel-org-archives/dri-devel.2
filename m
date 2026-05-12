Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E9CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A648710E1DD;
	Tue, 12 May 2026 09:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MB6+UjAI";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD0C10E1DD
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:30:32 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso48074666b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778578231; x=1779183031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
 b=MB6+UjAIKXPEat6QH1m0/soCmQNsl/bxBaY7LH41+nee3fC1cPoK9DJEouta08wKwk
 xicv5nwj0PYcaW4PjxqUiX6knRJAEsS3H+71VKlRI5goj9cww/fuLmy4LgXNwTabuIPF
 b6vZx3UDS6mZE0KOCJRIqhMp/8vzRNNRdEqbtQnpaqKD35h6nqe68OQX4cCa3gAsn/aL
 6302hj9oo/EAS8ZNcVP8ZC6itmVcixuDyrSJN0u55z03vFsI0nWb33k+v4otduRyFOuH
 S3Q4+UFDvQWsW9QN5P/EoUoTJIxiq3Z6O+ET0d/a9ayCa1Oaf8Ckx2w7WFQ1G/QEHrX+
 K7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578231; x=1779183031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
 b=VVmdSKk/sypaVg7mL3egpACdWijHSRGyAdpGgnGu7Llhq0mYq9pIiosQDdyyMnsa+N
 e1EP7epUYbMxNd/mL6inIuM5KdUqVQcQJxljgU7OPfOVqbg2N5ummU8e4QyNrVs8o70X
 SJnxL2H2ti1tDbLGKgdSfgmH7vl7Kek45HVOgijd+tIgiMY35ibwbDEsUqsRovcKjItH
 8+fzjDpkb1Fpf3KQNXrhmtrF+n8HnZROZ8Nc1DW9RPB0/LKdg9ptBMFJMcSKeWABMllo
 WNDyJKkajlXb24G6G3mb3ac1W/stGE3R9hCJJnv1wEVUICZY+FjMqVyoCaiEz943s40X
 Ymjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HpDEmeqDOdr9hMSTbOugcS/Xeumdem8jpoZ02gZPaXqYvh66Df/yDXGFq8XqE9uqA+rUm33ZnEU8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcxzdT/fxQsG5+aEMHv3knjomWhbFPVRMkzLMCrST/CjdgTpmu
 FqP2KoqV32EWu1ninOBmzrCWLm5Pkn2xpYNYvrhnBeAQ2k/KujT+cb5Q
X-Gm-Gg: Acq92OGigWctAsnuzOyNNSH2HPZcdC6i7HRxqhGa029lhY+G4uvEjvsKPn+SY6VpXRt
 WIWx0vQSLgJU7eV+J+KALqpthHTBZOrdTA5Yfj9Rtua1Jma7WZw9nxl7m3FxrwBuEsVc5ql7/Dr
 fAXi7eI5FB0++4aJ8Vu77M2ttrsVy/RtjVVBb+9s89NGr9rtham+4aDbrNEKTsTlyxKwwT6cDEc
 jf1D8eexRz10kKXc67kES0N9oVA998acGJ8UrsIf1bjqpjIawPaiM+m45g+jc/Ef4KCqPhKt3Wz
 C2S6CfuBDdvEqDo91VrEnBANURiJxYONosSDYEpn6rgxWHovXLW8hjrwr87XSnx1GhK1munNPQZ
 MEjSXguYNkcn5iq1GyAYl/2+RjlhQagFel9wnTKWtjixeFv2sjAI4W24JtnSvTauly/QVEcP/xd
 /BcUwvB1dSslE0rAOzF4GJoBWEIJPkyU26/Fgu4mZ4nXXKaf7e8dvyBJtDA932hDwYXZFzxDuRv
 46631MbNXEoJOG97bcy1Jrq10yc18tbLuxu+BqHykG+tiS17Q==
X-Received: by 2002:a17:906:99c3:b0:bc4:f3ef:e43c with SMTP id
 a640c23a62f3a-bcaad52246cmr973369766b.45.1778578230560; 
 Tue, 12 May 2026 02:30:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 02:30:30 -0700 (PDT)
Message-ID: <a4748a29-8aa1-44c1-a1e4-b82f4f191d4a@gmail.com>
Date: Tue, 12 May 2026 10:30:27 +0100
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
 <20260512070045.GA32030@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260512070045.GA32030@lst.de>
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

On 5/12/26 08:00, Christoph Hellwig wrote:
> What tree is this against?  I can't apply it against the usual
> candidates, even accounting for the time lag in getting to it.

It should've been a Jens' for-next

> Can you provide a git tree?

git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

It's a wip branch, for now it's just v3 + 2 fixes.

-- 
Pavel Begunkov

