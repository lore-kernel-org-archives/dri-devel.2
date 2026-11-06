Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16470606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lgyt7bLo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB11112C2F;
	Fri,  6 Nov 2026 09:13:00 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DB9112929
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:12:54 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so2871755e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 01:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793956372;
 x=1794561172; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fmoyspqstw2/9PiOOpzl/yM+dFrdSjNpOnDbiAxrbfI=;
 b=lgyt7bLoXARwIajQ4QrzqtumamowCJwlnnmGh7x2v1Vp8YcjTiJQc+Lq478LYy8EIL
 IoKDCKzB/wGxJGowzbB8WQkcx2nQ2/ypoPUCn/dRUTCQMZs0Blz32qnPs91kW9aMffzA
 wQt0GShr+OD8NfxqsXlr26bsCTjmAaO00ML7E2/7h05LOb0uzOEUilgS+xuG5F352QMB
 AbbkGO05esDAxKEei/QgE4UA77ao/zyZkbyqfEAVf1Ict5ZIglXqPanXgl5SysuI3954
 0GpGMXApu6UOxcBY3EopdGYAN5hxXZFyg7JA6rUnjXmBaT1iG+5XA2qLC7oXAWHDqB3X
 rdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793956372; x=1794561172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fmoyspqstw2/9PiOOpzl/yM+dFrdSjNpOnDbiAxrbfI=;
 b=wqK3njoGxD5M7SYdLU4yaZmiXYUHumYdITEjuOqUNa4zh1csfbNbxJ+8rB1YQoPY4U
 fxN16prT1mGP9HAOhG4U6YybHXO0YWYEmkSMNy/mkKFfYw7IPZsF4YxXxb+K2ZB1/eyb
 laSmbTvQRNKMuovWwo5siVUgES05g7cvtAQpcx6odTHmvjfG/hviWGOOAFSFQngNH4gm
 EvcaBLfPGglqbGbQFaI0KEge0Lkv7jkewBPEpDUkZMO2KG3pZ6IjePzoLjsBFfO7Ekw8
 qA85ggq4tFs39RAG/EtuJHQE95kwKNBd0gM8QjFyFpHCwFApOXJ8/IgTui/zQb4nxSvG
 ffzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHuQ1Yo2ZmijuOFLlyVzJa2PxfGE5B/tJB9W3DbSA9WYWloTikUuB5OHLk+KZA+P5x6txtWLTNBz0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9/3VPs66HGRTnmrcU0j6Y9fZuVgqdEIE/2udNDkkjz2lXi5qy2
 h0VxdqcJIlyFsXBxTrb8VgpZPnW1Yw89MF6ENbibCTTjZWZT3tjTG2DOn4wWPcfLWzw=
X-Gm-Gg: AYBFou3EIyL/f4kpESyapMhcRLcwzmrNX17Ctzq3LcHKuNqjql4KpNMzOO3s72/mb69
 Liqiw+r228TmbBYVYlkB2EMGTUWV9bsZYqZbzF8jDQnswTGKUTSnRHp3gMQpFyHZLJNsmBIVe51
 nvBGb06Nr4NCEkRMA57URL7yGrMFpTuMR5s6fCKYfqEc0zGaXeYjgZvHNzeIO4199Ht9an8w/fq
 yqPT1MKhKy/nZrjRiSp7A7qVTaUWkVWmVXkPBGnkUWIMQyepbKJCV+JqEwjzRHBqDRxecaeJr/3
 maqLaF960ZpEXYmZ2nTzCQu1IyqVoPkcTQTLbKfnPTD+1zR5k/l3WI1s2N5fzZT96X7dpd5UEKe
 DeKh79SvjRj9b2QhmbZm82BB4gHhIMytuLkiHQ+Vzgvz3msADlUfgkQvFj2oGU8i98hZqDm7414
 WKWhvNRIzHxlqAK+choYVjXbnsGUYMUY2cmt/0jjkv5Uyo+BJFx+oDXNV4Bnu6mdTsUJGIg57wY
 nWnBI/Hg/HAQHh6Ws+Fsbd7RVCo5oSSl/+XZhewdFI4GR3mQkkTQOtv9L2i6YDMIB5buqILoYKF
 Rs4V7gf/yD61ILWIQla/B83djuZ9L/DTz92X1ZQl1SXXFLqSyYh0qwPNijw3lqI05bFsykZ1rUi
 N8f5b1JHOnBzAv9HMoxOTnplMq3xmw/VU67jFU3CIs7knZLnXHQ==
X-Received: by 2002:a05:600c:a4b:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4b6dff8449emr26012245e9.35.1793956372121; 
 Fri, 06 Nov 2026 01:12:52 -0800 (PST)
Received: from alcachofa.home (cst-prg-36-190.cust.vodafone.cz.
 [46.135.36.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcc6sm226920045e9.2.2026.11.06.01.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:12:51 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca, lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
Subject: Re: [PATCH v4 00/25] accel/qda: Qualcomm DSP Accelerator driver
Date: Fri,  6 Nov 2026 10:11:19 +0100
Message-ID: <20261106091121.3958523-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 03:51 AM, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com> wrote:
> User space
> ==========
>
> - FastRPC library: https://github.com/qualcomm/fastrpc
>   (accel support: https://github.com/qualcomm/fastrpc/tree/accel/staging)
> - QAIC compiler:   https://github.com/qualcomm/QAIC

Hi Ekansh,

I'm still confused on how userspace gets to execute its compute kernels
with this uAPI. Let's say I have a compiler and have compiled a function
that reads some values from a buffer and writes to another buffer. Could
you explain to me how should I use the uAPI so this kernel executes and
I get the expected results in the buffers?

Regards,

Tomeu
