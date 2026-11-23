Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA5606A332
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RS9/ZhtE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC4710E7E2;
	Mon, 23 Nov 2026 14:17:18 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82E510EE21
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:55:54 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so2576975f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 05:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795442153; x=1796046953;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aDhEOsQ4kFs3m5ViT1erT7rUy2o/jOwOkZo0YQ+jEws=;
 b=RS9/ZhtEGPwHB6aarP1BX5vyjoB8JSe4TOOrZIvJmXoFNLCgQo0cgZsDVl/sxjuHt5
 +k3HTOWKMM3s1dIgckZb56TIlsDK7EpMzfbfOcYKJm8fEmw5j5zYRhFQw9Dgj94l6IYs
 NelWdMqHFXzeuZTrnMMM8zVvvRVTFZO0sHuIT9nd5Hgv6bfcc9e98FtQYYYQ6a3qc1Kv
 +llL/6bhvv+4n7LypyDcklImaQyqRHl2vJGJb1tUFFPylmyKIzibHl7aGmlJHGFA6ZmJ
 Z0u2CFliScmBSNjAXFYceBARKQ/MkPyGGmrGPjiYsoBX+vku2LxJcsFsr49Qgt0tKasA
 JH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442153; x=1796046953;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aDhEOsQ4kFs3m5ViT1erT7rUy2o/jOwOkZo0YQ+jEws=;
 b=wA63n8GvLhFv7Ly6ncA9VsgFW6rpJ4y+auHDMG47hUUdza2BRVcWN1VR1gtb5sGm46
 S+awm2htfjzaH9Y33KyzfNSKxy6cK43HeuVvUbCMv1vxlrEy8EAzgVTbJgE/xuIFjhmj
 M+NTAM2ATnZQJ+XZjhBP0/3SmzA6w2n0/40xd2JYoJCZgf2kXyUoCVwgKU3rTw497mMZ
 VRgt4lDmaONIEtNRywHdfZLS5rOo4xHLGBSS6p0nSynh6WMkqgz+9O5jBHvaheLVd9P4
 lZxBjahdilG9HKX/KbqAKHpR7jShWWIKfF1ruWBfypvusIYicXc3mlMVsaqtUuvdOVkw
 RsRg==
X-Forwarded-Encrypted: i=1;
 AL+hErEiGMx3trXTCNYL5JdfxVJddIeEGMrK+dqVLIglFiE8le3vAxdQX2ue3Mur8+1sVbIysQQeNIkuZrM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2y9OE377YspeBdVVzj30fCPEoSTcinqHmXzOQAJFsVaR//NMj
 GnRobwXOX1N+wmZ3bYVZT5MQulpr6BYrgEjaDqo3Y5RvIgn08FjdzIZKYMXA3kXWvQ8=
X-Gm-Gg: AZFdTZeGy/GAeDsaIJC5Ml0D76jM9I3Cm7awGqt/9/gASGlPvdzIjfLm9hQX7TiaVtE
 dgY13PVZGVGRWbAh0ADJlPKMHjtsat6bRMdfLTcMtcAYta4u4/XDZ95mshH6FZSRpUjDo52YOIl
 SSkZ97DZkl86QgBJ/nGF5hy6YC4dgdPHhZWUVa7U+3mz7wZY+iIY1Z8fBz7KL+HVmHSu9BbfhCC
 GJMQPpTfMMUIwAgHCHrMu0EVWXocT4prA3/+QGZNFhV2yI2VEo4NnNRJPR9xY6x1s0hPRHBAT8M
 GhLO4xDTAcL5Y9LKXxV1eTm4O4w/yy9f+OgU6VOT1NkpHwWvMMru0uhL/FWQUrJtKbfHpOl8DhA
 QfppiT2A+0l4mmkuj16RYmafGPaL6BGVbJKRr8LvNyPCb15IWG7FXbe4KLHn6NCugCoZoZZxd+R
 N2Tp+1TjAxs5a7qSFKUMigg6UMmv9BrK0bvYs0ztZvgvBT4njeBCplNyAQeMJc9Z22uIe5r5/Hf
 x6NaqOoICCoVyydoTN+X664Ytb7rNL/Xi0ji/eksTR4nyZvSquuxa4cWjFM9uWE29vkgHt8VjzU
 AhEn6jjwdVdvHTp7a/r+T2CQA0fnuVzd31AxfcjpzwW6C4GakLh7QyC7yYJSeTgxY6uHa9PCb+w
 lowNJeXo=
X-Received: by 2002:a05:600c:e553:b0:4bb:9457:3c93 with SMTP id
 5b1f17b1804b1-4bb94573c9amr82975115e9.2.1795442153256; 
 Mon, 23 Nov 2026 05:55:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm176803775e9.4.2026.11.23.05.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:55:52 -0800 (PST)
Message-ID: <5278036d-c939-4726-a591-91c7dbedd431@baylibre.com>
Date: Mon, 23 Nov 2026 14:55:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: drop redundant zeroing of new GEM objects
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20261111-pvr-gem-drop-zeroing-v1-1-2dc725857053@baylibre.com>
 <CAKbEznssOrO84z_msOZ0tYjVYkaQ8P+f8uma3PhOF6+zp32Hvw@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAKbEznssOrO84z_msOZ0tYjVYkaQ8P+f8uma3PhOF6+zp32Hvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gyeyoung,

thanks for the review.

Le 22/11/2026 à 08:55, Gyeyoung Baek a écrit :
> Hi Guillaume,
>
> On Wed, Nov 11, 2026 at 6:43 PM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>> pvr_gem_object_create() clears every new object through a CPU mapping
>> so that userspace never sees data left by a previous owner of the
>> pages [1]. shmem already guarantees that: it clears each page it
>> allocates, and the dma_sync_sgtable_for_device() call that follows
>> makes those zeroes visible to the GPU. The second pass, write-combined
>> on non-coherent devices, only adds latency.
> I'm not very familiar with shmem, so I'd like to ask: is this zeroing
> something shmem guarantees, or just a current implementation detail?
 From what I see in the code, it is guaranteed by shmem, not just an
implementation detail. The zeroing is done in shmem_get_folio_gfp():

           if (sgp != SGP_WRITE && !folio_test_uptodate(folio)) {
                   long i, n = folio_nr_pages(folio);

                   for (i = 0; i < n; i++)
                           clear_highpage(folio_page(folio, i));
                   flush_dcache_folio(folio);
                   folio_mark_uptodate(folio);
           }

pvr objects get their pages through drm_gem_shmem_get_pages_sgt() ->
drm_gem_get_pages() -> shmem_read_folio_gfp(), which uses SGP_CACHE.
Each object is a new shmem file, so all its folios are newly allocated
and not uptodate, and they are always cleared here.

panfrost and panthor already rely on this too, they never clear new
objects. There is even a comment about it in should_map_wc() in both
drivers:

     /* We can't do uncached mappings if the device is coherent,
     * because the zeroing done by the shmem layer at page allocation
     * time happens on a cached mapping which isn't CPU-flushed ...

For pvr there is no problem with that: coherent devices always get
PVR_BO_CPU_CACHED, and on non-coherent ones the zeroes are flushed by
dma_map_sgtable() and by the dma_sync_sgtable_for_device() already done
in pvr_gem_object_create().

> Since the driver would now rely on it, could you spell out in the
> commit message where the zeroing happens and why it can be relied on?
>
i will add these detail in commit message in v2 if it look ok for you.

Regards
Guillaume

