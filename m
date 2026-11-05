Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB9606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOUiZPlN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B622211222B;
	Thu,  5 Nov 2026 08:41:31 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8A2112250
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:41:25 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-91c63449320so16764096d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793868084; cv=none;
 d=google.com; s=arc-20260327;
 b=hcaGYWrnJ3v/wPRo8r/Y1oDqXt1w8fsq9dOZ98zyp2k6hn318yCz0VCl6EHw4BMWad
 1ni9d0GkbzMbYHPeZRJnlZNmYzHQ4U2Q1+dXfUTfTei0OK5voF+9kGBmcM2CVQ+k/iuu
 gF4K+eaxc4GIoM5FARIexwNfzSAGc31alIgoi8NphfE8piZcSIBVUCR28v2V07l7Tv8R
 Lg8LnAZ4F89ZvI7TkqoXHC3nOmyaYTEgGyGMTpNNFV87dc7oUVaPbibZpVu0HiQh0QV1
 SjA2g3E3J0fTxCh8MQQj2TgBdsQUfs5XwqNoffvMaTVd8078dD+fSN0yziBbWh9PmUOR
 oWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=93jv87Iwyy3JRzOhRq5Cce/h8tGYeWiXhCqgOwKlqf8=;
 fh=EGTWSx7WcgN65g2LNKFGVagtSQDC4N8yADt7lfNBC0s=;
 b=JfnAxnNR8B7L1Cx+LeysQHVFohUQteVtH/ok3VIIWjdjTv5PtqWG3N91ci7ZKAj0sZ
 xF1TnaNP9XPXwkOqcXqDYttnL5oKYhTBmZIB3TKcBLLK4p+G+Ep42MYqfSqvWX2BkLOO
 dkVxk6TYR1uZum1U7UXJecWZxDzWC/7pGzP/qwmuYk8jvHxrPFVLpjEWmYZNJHHMEwqH
 +r00FpX5ufp9TJcrICp7X7VWmkmcADatcdRFfDTkkbNJYEf095LijNZNQbXTTElPzXjb
 hKVYJFIVAbX+JgiUecbrm+0YDKkZ4jD8dDUT2ak2Ed+MFZbojgWi4vQtCEEaschnenZ6
 ii+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793868084; x=1794472884; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=93jv87Iwyy3JRzOhRq5Cce/h8tGYeWiXhCqgOwKlqf8=;
 b=DOUiZPlNZdtFHkLpRnWWkx7JE3QNhFtDI5yVOV62hznR1RSI4ah5ZKbmu4y3bw7odZ
 +dCE1NkZDce2Ng7/l0K3zFG14OpBwODPzE9ASWr+8e55RLu62DYh9g5uXsUWey7nGQm/
 Zi/EndtfT3PAZYOaKjImOb5StF3Lh6WR/VynQbpuodo9y3fR1zLtMy+1+vZSgmmB6JXL
 9Wdt3nZDltxukwrSnNO2ywAaWy7ISRZLeIOFDi41AFt94Lknwh+Fb7hzbBnWevCfVON1
 w6KWciooLQ9H7Rj87EvqLmmkdxcATJ3K4WJCiYHXnjyT8RoPXPPcY22pJgsWyNKgbixR
 V8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868084; x=1794472884;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=93jv87Iwyy3JRzOhRq5Cce/h8tGYeWiXhCqgOwKlqf8=;
 b=PMrd2vTGY06+T2OuAQ+7ViPErI3tq/79WTlP9/ruqrwf/bsTdW89fiKDEpwONPvd9a
 qcHkwCU1ctZkHbPVrpfYGszldB/YKcUIKDWvzVKO1D5rbgDsQ/QG4XC3X8h6t6mzjwyI
 IK2Jju6euflOOzYObIis1idEoDC64sgQisJVRxwgjYsVJ4NwOF9aOjUNOuNZrA6h0gts
 cu5TXDadlqeZzNxDH/xj0DNcbS75wZ/IyETSGvwvGtxrRZp8GnlPMRaEgjPSl9ahtA1Y
 94vTnEwTSvbxRoTqAwAr62YC5Io3XPx39xvKY/TErgutYEYBCEsTDZYMgwDMGkzsJJpO
 c+pA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFrYTZ81VsquixAokjZyjauPqdzu67CWqTUZZz/5QWgLVyuc1lrh4iU3pDAadvbE1J30bs7dKZJ7A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ECCv5DiJ3SFc0nQMwSL52JKZyjRLS3VcWIZCubbIn0cp3DZvj
 ZnzXkT7AMcARx004MBX67jrjJkSfWNHcKlrQ3XylocIt0nTdpyUDY25kM0SKjhQcsV1gXFJBVNL
 IDUBYgd+vjBeSnWx0GjrmXQTEgtIwb40=
X-Gm-Gg: AYBFou0e6JnZSjJ8zDLc1n1POFKRMFqFWaV+C/lYfS2OZZKB8U9YLbNkic/L1/Ii3h5
 Qb+WOxGFrU9BocWKjPItfQdItn1L+PeB+g9kdBZkV3Yne+vac8lNI5VocV1A6oKfto/i6yq2ENt
 WxYwt2FAiDaGDV9L/93BjsEPSOAReKEgIj7/igSo798kyc1KezPZCTnH2wePZQOETEjBEA3XZ8K
 MrKKwwaYxy2gcAcOQCtfKIvvioozBiSNHECbx0i9oIRnFSMK0ZCj67rQ7UAoDmMNkZ/vUPI/QT7
 yAgJcvJgfrSqjwF9P6rgIIc+Bc+OR4IuWKPCo0tT1m5Q0kck83fy4j+bDNBd3SoUgExY4kT8b57
 jlOkVYFVAHWSpmLQXy9p4HINiMJ6NU6Ot6NpOIl+0jnn7S0OLJt9buKs974u3DMtkf/yRn/4A2z
 isNn1SfYMPSv38wBLSuWjRfGtHOW2OQxkrhe/7R1B60QQ=
X-Received: by 2002:a05:6214:2f93:b0:91e:97f7:c7a2 with SMTP id
 6a1803df08f44-91e97f7cacemr17909686d6.11.1793868084037; Thu, 05 Nov 2026
 00:41:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103221529.585436-1-rosenp@gmail.com>
In-Reply-To: <20261103221529.585436-1-rosenp@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 5 Nov 2026 18:41:11 +1000
X-Gm-Features: AclHuK_Xgyxbeq-Ri9AU0jIyOpkBmLy-X-m-DhPanCxRRFlqIAlhliusmaAXcBU
Message-ID: <CAPM=9tyLS7z5BF573bjRsFPjh3+nmE+nqF_6Rwr+qCF4JZgSwg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/fifo: map Kepler video engine contexts
 non-privileged
To: Rosen Penev <rosenp@gmail.com>
Cc: nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, 
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 08:15, Rosen Penev <rosenp@gmail.com> wrote:
>
> Since the engine context rework, gk104_ectx_ctor() maps every engine
> context into the channel's VMM as a privileged page.  The MSVLD,
> MSPDEC and MSPPP falcons on Kepler fetch their context with
> non-privileged requests, so the first method sent to any of them
> faults and the channel is killed:
>
>   fifo: fault 00 [READ] at 0000000001050000 engine 10 [MSVLD] client 0d [HUB/MSVLD] reason 05 [PRIV_VIOLATION] on channel 9
>   fifo: fault 00 [READ] at 0000000001051000 engine 14 [MSPDEC] client 0b [HUB/MSPDEC] reason 05 [PRIV_VIOLATION] on channel 10
>   fifo: fault 00 [READ] at 0000000001052000 engine 11 [MSPPP] client 0c [HUB/MSPPP] reason 05 [PRIV_VIOLATION] on channel 11
>
> Before the rework, gk104_fifo_gpfifo_engine_ctor() mapped engine
> contexts without the privileged bit.  Restore that for the three video
> engines, and keep the privileged mapping for everything else.
>
> Fixes: 8ab849d6dd4c ("drm/nouveau/fifo: add new engine context handling")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Appled to drm-misc-fixes

Thanks,
Dave.
