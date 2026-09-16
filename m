Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952A8C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDCD10E021;
	Wed, 16 Sep 2026 11:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jPCfSzTH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5523E10E021
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789556803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wa6WV+kYrjlESTUxvQTqQFxS+ZtQm6NsZYg9SHCkmJo=;
 b=jPCfSzTH+6qFwOvcnBBrT6XkaxPkTPREnlURF/Z9Rx9CaAO5WXt86C63m3bS+lnYbS7OS4
 0y4t/+dNu/BEXIWOJ+oi+5zpuSWYGwLPpDtwOO4DoCIkhqWAQjQAt4C3sY6Kk52T89QwLh
 WItEeceWfSkLzWurWhgMEIlvzox33OM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-7HY1A4oKM0GZ9LaMmSghwg-1; Wed, 16 Sep 2026 07:06:42 -0400
X-MC-Unique: 7HY1A4oKM0GZ9LaMmSghwg-1
X-Mimecast-MFC-AGG-ID: 7HY1A4oKM0GZ9LaMmSghwg_1789556801
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4870142f030so1974912f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789556801; x=1790161601;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wa6WV+kYrjlESTUxvQTqQFxS+ZtQm6NsZYg9SHCkmJo=;
 b=v3ZefcxZ/QPm4tUjl7kTNAXDev0CQrxoWJGAj2UA7e5Qy6xFEuCZtvMOq6X1FscSmR
 ebqyiErB0524IdfctC8Xg4H3dydwLvG8zWYqnvpAXhvJOyLGMMi0/7KcCXyRkexy2eob
 X/1EbZif8M4JibGawF0Ej/zM7A18scNPTEo2HWf1H3TPeI9oXr/uOC6pCzPJFFsis8NN
 bwMjF5wO/EYJOaciRHqVpOWq6lZWT65/0pOdqrpHVBJHeTd15gRhherxQaYrI4N4OD+j
 /o70mGOkgYWkqM9hj4RPqvAdw5oYR9GFmZAFX/azKq6P0fLwjnv+8Mr6XMJqbe2Hk6UI
 yaLg==
X-Gm-Message-State: AFuF++kprhoCd83MHbxT4eAxwRpMvJ7O+W8acR47tNN4v/0epXaLQ2+N
 PB9lrIV+J41U/bt+hAi+bMLI814V8CgFCNGVLRoMPDDktYT4OzjUuNIeTP5boqY9GFdxw4h3tYO
 RKj/1Rt0Tfj5cUqf44J9TaK23pUwTWnFpblhCHTIteMN13PXWMXne1mRqz38J48i/ZK8qAw==
X-Gm-Gg: AYBFou25SgUxJjzppXXuG1ccbDckm8Bz1Y1LvfwNTFfOGTfqv3v1GXw9WtJj1jTf4DY
 DECFWVOSNzl184SwQJjDOCzDdjaSNJGJhhIQumbH0MDDhJovtcc5tI/gkNYwgxZK4oG7c53BWpZ
 UFx6b3RCgPgf+3hmuxA6z01gRiPahjP0WvsgzMOe11QU3FXWishI7ETcks2pq/8f/XUIvGV2rf+
 30u4VlKZJLSy9B6VmsXchIPmemzZTA4TBZ5of/l7enMD5hNaNuc0Vw7CV4hgoXRgTAa1hDlht14
 VqN+98Dlq1zelb4B+M0bOAMVX+BbO3hDASfEzQHXHGjPq2NoTRnljznrJNxQa1kSyuFvr5cX6gA
 X79v0Y78Q/ofNxli8I8/GNbMcG7j7
X-Received: by 2002:a05:6000:60e:b0:486:e901:e59 with SMTP id
 ffacd0b85a97d-4870d05a86emr2951065f8f.31.1789556800675; 
 Wed, 16 Sep 2026 04:06:40 -0700 (PDT)
X-Received: by 2002:a05:6000:60e:b0:486:e901:e59 with SMTP id
 ffacd0b85a97d-4870d05a86emr2951010f8f.31.1789556800204; 
 Wed, 16 Sep 2026 04:06:40 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7659sm6964448f8f.3.2026.09.16.04.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 04:06:39 -0700 (PDT)
Message-ID: <4fb988c5-3dc7-49b2-aca8-45f23e71bad3@redhat.com>
Date: Wed, 16 Sep 2026 13:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: host1x: Allow entries in BO caches to be freed
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Simona Vetter <simona@ffwll.ch>,
 Herbert Xu <herbert@gondor.apana.org.au>, Akhil R <akhilrajeev@nvidia.com>
References: <20260515-host1x-bocache-leak-v1-0-a0375f68aeab@nvidia.com>
 <20260515-host1x-bocache-leak-v1-1-a0375f68aeab@nvidia.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260515-host1x-bocache-leak-v1-1-a0375f68aeab@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ZA1aUYlb0QPjNHV7uRD4fn5sjS3tmsJp119TE-MQ5g_1789556801
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

On 15/05/2026 04.34, Mikko Perttunen wrote:
> When a buffer object is pinned via host1x_bo_pin() with a cache, the
> resulting mapping is kept in the cache so it can be reused on subsequent
> pins. Each mapping held a reference to the underlying host1x_bo (taken
> in tegra_bo_pin / gather_bo_pin), so as long as a mapping was cached,
> the bo itself could not be freed.
> 
> However, the only way to remove the cached mapping was through the free
> path of the buffer object. This meant that if a bo got cached, it could
> never get freed again.
> 
> Resolve the circularity by holding a weak reference to the bo from the
> cache side. This is done by having the .pin callbacks not bump the bo's
> refcount -- instead the common Host1x bo code does so, except for the
> cache reference.
> 
> Also move the remove-cache-mapping-on-free code into a common function
> inside Host1x code. This is only called from the TegraDRM GEM buffers
> since those are the only ones that can be cached at the moment.
> 
> Reported-by: Aaron Kling <webgeek1234@gmail.com>
> Fixes: 1f39b1dfa53c ("drm/tegra: Implement buffer object cache")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
...
> diff --git a/include/linux/host1x.h b/include/linux/host1x.h
> index 5e7a63143a4a..d8f052a85b75 100644
> --- a/include/linux/host1x.h
> +++ b/include/linux/host1x.h
> @@ -143,6 +143,12 @@ static inline struct host1x_bo_mapping *to_host1x_bo_mapping(struct kref *ref)
>   	return container_of(ref, struct host1x_bo_mapping, ref);
>   }
>   
> +/**
> + * struct host1x_bo_ops - operations implemented by a host1x_bo provider
> + *
> + * @pin: create a DMA mapping. Implementation must not touch the bo's refcount.
> + * @unpin: destroy a DMA mapping. Implementation must not touch the bo's refcount.
> + */
>   struct host1x_bo_ops {
>   	struct host1x_bo *(*get)(struct host1x_bo *bo);
>   	void (*put)(struct host1x_bo *bo);

  Hi Mikko!

FYI, this now causes some warnings during "make htmldocs":

WARNING: .../linux/include/linux/host1x.h:159 struct member 'get' not 
described in 'host1x_bo_ops'
WARNING: .../linux/include/linux/host1x.h:159 struct member 'put' not 
described in 'host1x_bo_ops'
WARNING: .../linux/include/linux/host1x.h:159 struct member 'mmap' not 
described in 'host1x_bo_ops'
WARNING: .../linux/include/linux/host1x.h:159 struct member 'munmap' not 
described in 'host1x_bo_ops'

If you've got some spare time, could you maybe send a patch to fix it?

  Thanks,
   Thomas

