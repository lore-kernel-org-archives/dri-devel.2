Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797A606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=do7okyF5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF06A10E6AC;
	Tue, 17 Nov 2026 21:46:07 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE7810E6AC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:46:01 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so1654655e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794951960; x=1795556760;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e/0455aVSKf4ZqTvdu8SIA7Syq8Dck34mc+Lxs2NK9Q=;
 b=do7okyF56PZkkzEy9J4cUwgo4Rq3O50Ydb68pTm5qSMWPY74+aUC9J3fCKNPnGdDoC
 63U6rgtkqiJYIKw7psRcMnSVo4hphfYogvptrSiiunE+L2ncC7AfsYCpU6UtlNEyGHya
 9q1fPemsQiQlHnTDH+CZOEi36/gnmAWoCOyfvtYSyhn50FdTsGSxhO9kf7bk4/JW1tJs
 sEp7iIS/bKnVgewVzDfrp36AASiR2tr5RAxcWHe4yhYozfWWuctg71JurPwNS2ZFRU7p
 7r36XzWSewzgPsxsTsPQCSv+ZBvBDgBK58NbScJwUp9bLOCfsFrYM1m8beVhKU8O/q1Z
 bCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794951960; x=1795556760;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e/0455aVSKf4ZqTvdu8SIA7Syq8Dck34mc+Lxs2NK9Q=;
 b=bKljLzdfWVO/W9+I9G1ZHgOHdBLqCBZZ7qmRA9MdmfNjXvJdLCqvhGNCyHDFOERZrp
 c8XiL7pZIiGOdpNV6muWlWBINdqpwXPXBJiufxnWmh4qHvabeILxamwsTLemmEVDIO0E
 YRnXDZi98hNlJeMTNlxjqQ8XTPrQaxSTwDI7rXdHA5Ez1gVMhPXGNfRCgHi5EnwFVycg
 sLLN0OT+w6qBsufig0qaFWJVkEI8VdyU+kn87d4KBxZ0KEttaxMVsEOLh3i5ootafSRx
 r58Ygcl4YZh4xjFbebhlgi0x6nxXtvn4lkjaG6sF+okRcO1mNfSWAGMu0cgMob5Ka7IH
 6RcA==
X-Forwarded-Encrypted: i=1;
 AL+hErF9ZNCa9iS8CGjH73fmFU+D0E+SfpNRBNnbHTnnM/jbu5aJsFmuiMqkHGsGwhmDYZoF4X3MgOUJ12k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z842TVpfWEcKjOjE0XlZk6Q2GolPEUyPXpMm0Dv1sghuP1iQlnM
 UXywTip4WXhe701tOq3GcFA1yEUPFrJ2uh4yzyAHAbeWZZRVxzeYdw247Whc4xFA6bc=
X-Gm-Gg: AYBFou3kZNFhXd15NwQzPDgSg7G9GbBDw5MoW3ynzjvYrkXlEBoVMjjBHSUYEEhZWDq
 B5DC/IIhsxitZq/UtCAbMPOpxisX0i9+C10zW1fsE5W07bg3dst6Ozy90BUAa37jcsr5t0VJXXh
 5mjSFpjaoi0nISryWdQL35RnBdOZFYBnWGnfHCH4Od3WBl4HBujJYRqpKq6OcBrsYfHnyFrVsx5
 aG/Mf/JdLfqmxnQMEvFVlX6yCPFQwfV7hOdntDD7XcPPoLRwNX665R+VKAYGPeNzaYqql425WvX
 BDQ9f3R8z42XVgHjWvYZ1kxNH/o0Pg4pgndlMgen7+sI4SY8JRHBDsJpijdMr/jXciKgXGvLDkt
 OMpFatgdP1xacsKjkNOoYnwxJpnmcNjRunvZ0H5kQke5Yv+M4P/wB5uKjHFTKu/SCN1RHNaBdgn
 e7Ac4Oc2q5lpqPvzfDaVai/YIRowqBsKLPZdGO2csTEv3QXJ8kw2G8VVrNXzG5n7hR4hrqHLTsE
 pcfXcx/AqL4iddTmLVDlFgOn8nePPyaYveIDzRHGgTb4FVJ7Scgkyxtme2FYUwAXgnHNdQQM2ZH
 p/yOXoeRrsg8/QrMwBh1wsnGwxXrDRDW9+VFj+sMZLcGal2xfOeql2liidJ1165Si5G/Uqu05Kb
 yeGM=
X-Received: by 2002:a05:600c:a54:b0:4bb:5fd1:92aa with SMTP id
 5b1f17b1804b1-4bb7da30033mr10977415e9.15.1794951959287; 
 Tue, 17 Nov 2026 13:45:59 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d28ec3asm15648465e9.0.2026.11.17.13.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 13:45:58 -0800 (PST)
Message-ID: <39614a57-c375-4bee-bcea-f0ebd2d0b572@baylibre.com>
Date: Tue, 17 Nov 2026 21:45:57 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] accel/rocket: Fix the IOMMU domain leak in
 rocket_ioctl_create_bo
To: Chaoyi Chen <kernel@airkyi.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-2-kernel@airkyi.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <20260814022453.437-2-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 14/08/2026 03:24, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> When rocket_ioctl_create_bo fails, rocket_iommu_domain_put should be
> called to avoid an IOMMU domain leak.
> 
> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Daniel Drake <ddrake@baylibre.com>

