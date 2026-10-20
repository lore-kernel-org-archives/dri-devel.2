Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84840606B549
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHllukLX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB00210EB5F;
	Tue, 20 Oct 2026 03:09:46 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D333810EB5F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 03:09:38 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2291019f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792465777; x=1793070577; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eRFeOO3Kki8hDmAHeTRG/02QqZyLShI99Jw754kjQWE=;
 b=eHllukLX6RlIjlHpB4+CHlKZMwZJEFzPrRcEv11CEuN8MAcmJJUQvQSyS9uHYKtq3l
 iIYRorkJDFN0C/VtiL+fVxV+O7EUCS7O3FyIEaKJrXxxHKMEqduUTQCZ2p57A7JEYUlu
 xuJbXuA+W6YWZK0EqN6fwnm5JDTxIqcuiZmlERGYEhNAqU881l3bRUVNH7iJN+VQvAzy
 DCuDYMqooBEXks6GrWHh3F/slS6LMwaV5eIe1ybnWqZ/VMOTweLzbqWxGmOgIBnbgeib
 BASJ/Fzc0ZwSR40Us5EHr0vVXweDy90Rvz5vXiL2JMN5ouMR+aiKL62JzxM7e8a6ldqT
 Qg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792465777; x=1793070577;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eRFeOO3Kki8hDmAHeTRG/02QqZyLShI99Jw754kjQWE=;
 b=gk1PyXCmAoPLrEATQ7bxLOKeh/CskjdH9MRCdlqmY7frD0COepDN2L0AZyBKTiPonH
 AUV9aYzJVkvTyPanFI1ZqCbaDSXDucj7A3jm6+LkTVKtvKmZentB3YYOzhGcn3BoyvVn
 SO42ED5WMWbVu+eYI4kUgcEs5X+Folva9w0bB6WoysGngm10ai3ZcITgH1EgcwC50jlf
 7nYlCWXbpJoJuTN76kkYfezQ0+R3HHrSnQNtuG2Lm2UA6UDIV2KMbqRKqUgXBMvPZgVS
 x/NT95EN66MqmUW3a+yi8Lqpdzyuc57NHffWn98qUevuHFk1I6znxOuZG+mUfETx4ME6
 8Ugw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgjXkspKUZDDHVXu48lFqqOFOW9foPYixdONEoDuwewuiLpA/2UxhXnHbS6I3HF7BhbqWehQT7f7E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLZJfP+B02N0pnEuwVs1FUBaUl281W60CFCeZhzmaqzF3L00jfS
 /cbkDiRWM0s9uFv294zhjTeYzvbsb1mvbGp01VX7P+IQBBFIlChnIfOs
X-Gm-Gg: AYBFou10ILBhDJPp1cQRBkr0NxEnPj8ueOKCeFd9vcrgF4gU9jVgi1F7aT8Tmig0y0z
 tE+staVXJCtEN+523haQGZmNbZbDfBm062wOrBJJi5YFbzYSLW+18T9b/JMgyg8os/fy1T7kvIf
 BEu3zonsT+7TW+DGVBfK4Q8H7FFEjOX2gVPhzqBlRypBZGw0nhWOwhpxS1JDmm2rs4xVjESlk8S
 K2G9g0ZJbn7ZfB78+QlJFOvrUy4/BsHvoV9mc3n2fm2NkCBCj4BwWHlgXKg2XAYxdk+eq+yN28U
 uszGbspOiQwM+82eEMqCYxhYF2vtHhSb9pFABIINeeAKSOWmCcpY1RjqFxWubsFrIzSyEXxLBSl
 KPxo3aOJM04xfLjtMI2jbPcgz6i2sefoyurFGnJ/+wbpigkiBO/9tex+kHZapTC8cEh42/DPorM
 AccLvcpxg6p4SgTR00W+a0gikkI93KPCmPSGGHT90AiT9PrUyb6n80/9gzi/r3Munb1WPPkhjY8
 LE3VpPAW/Mc5omAtNdcNGyAJF1YBhAbRhF+PpCWnK0IzthObXHA9xjMXB12p9pLAukUXXgrhqKU
 EDdEG7PKPcD3fkLQUmayjMrgckpTt6wOb7kguGK92hN7oQqBn2iBlpWYXd3BvmVawtbcHCHIUIE
 =
X-Received: by 2002:a05:6000:22c4:b0:48d:ffce:6cef with SMTP id
 ffacd0b85a97d-48e079200b5mr21966256f8f.0.1792465777063; 
 Mon, 19 Oct 2026 20:09:37 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-9c92-6501-cda9-90cd-4e49-75d9.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:cda9:90cd:4e49:75d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d75sm3304578f8f.25.2026.10.19.20.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 20:09:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 05:09:29 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] media: synchronize CPU access to imported DMA-BUFs
Message-ID: <atba0NA5lyG-326_@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <20261019124433.GU595565@killaraus.ideasonboard.com>
 <b9f5ee4d-987f-44c2-a1fc-2570f4500803@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9f5ee4d-987f-44c2-a1fc-2570f4500803@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On Mon, Oct 19, 2026 at 04:48:13PM +0100, Christian König wrote:
> 
> What the drivers do more likely is that they use the vmap interface to access the DMA-buf with the CPU inside the kernel. Correct?
> 

Yes. UVC and the tested vivid vb2-vmalloc path write the imported
DMA-BUF through a kernel vmap. Userspace mmaps the DMA-BUF and brackets
each read with DMA_BUF_IOCTL_SYNC.

> In this case dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() should be called to properly frame that access.
> 
> That seems to be added in patch #2, but I absolutely can't judge if that is correct or not since at the same time you speak about userptr access and the code really looks a bit like spaghetti. 


USERPTR is not part of the CPU-access bracketing. The cover letter
mentions it only as a regression test.

An earlier version changed q->dma_dir to DMA_BIDIRECTIONAL and made
read-only output USERPTR fail PREPARE_BUF with EFAULT. Patch 2 leaves
q->dma_dir unchanged and passes DMA_BIDIRECTIONAL only to
attach_dmabuf() for imported DMA-BUFs.

Thanks,
Karl
