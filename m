Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B219606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Z4wFvFR/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74B110E5C5;
	Tue, 17 Nov 2026 21:47:30 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B1D10E5C5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:47:24 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so150036f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794952043; x=1795556843;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gIwiNUiHWgzvyXGdgc8knRbhVSBtepqYaXTWRnw+kyM=;
 b=Z4wFvFR/p8L/jaQxoL/QpBSKoGIYNEnwTFo5gW5NIXHLqULgu3f/kyUkFDNDJYHM7t
 e0LYEQ0fCu5m+s5KgHFbG6ag175pHk0TtLwFOTYGb3L7dBDOuE6xNrXiqNNKU1/XawGW
 uEojwBn91J32vybR9nTu9AHcVH3lyMJOlC6+QC3s2mGnIomoDzJRwoDYvAWD/vMupVm7
 HuEgFT9AF5aw5KFL/sIhyFt+Zj4SAI3g9mrjCUh+7xMQXDe3ronLC/ZzBIXFe/NpG1E3
 Mxj2P3hWI9LDR6X2ZQf53BoJbiRmMjvDc40v5I2gbtBveOv5dxiK8BBSXhbJB00Gm3CJ
 QLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952043; x=1795556843;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gIwiNUiHWgzvyXGdgc8knRbhVSBtepqYaXTWRnw+kyM=;
 b=y3/MDCH4QwL0oKG3X+TQQmE57lZhMUVKSgAtMBiSP2UAXKm49C8BE2aySHtD138UQk
 IRHGpRfuu7YLXDCLuli32juNbbQglVX3Aahi4GN5ufS2Mr7oLbkQ6BEYs62C7QhgTOU/
 hmPz8kbxDg5ieMr6QGKa2zsQ9bEnczP4i6I/HSQcVEDMgXKDe1VMu45c2VsfswZGRK1J
 1/OG2KaOvyX/3g7glMY/Xshm1Cy+yvyEb3WDI1yzbyn+M0YtrgZ9makkltIVTaafT1OO
 QAX0/Jv1SkW9e6c6HZKsjCbUbqSH0nBFBLHuRc8AcDSSXRW1RJAq7QlE78TZnrXixRz4
 FRjA==
X-Forwarded-Encrypted: i=1;
 AL+hErEeGpuXRe0ppdf4TktJsHiQOLRkBhrOefDbIe+6q2Z5UUghfmLqy7edohcMoO+UvVef2LK5Ofiamvo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+pnjBOk8StwcpPTSyLRrUPCpYQOice28BoWL749YtEkrq4tZSP
 XAOBMf6PN0d3icdASxxTjznrz5rD4Y4Ry6+ThyTqP/GxHX1+ent9QYQa7kjB02/yejQ=
X-Gm-Gg: AYBFou0R2jdSDhU7yEmr3Ic2E2UI4pM531pLTJc+xYKIKUD1ma1bWudg4h+DKWlivRZ
 UVw8bfFCWtveYPeC8al60GaFDHHXxwo5YRNbO+4CwgQ8f7PP0+idADq+aQzrMAQXv0p4ICZPD+2
 6tDzlzctuOa/MGRVpmWf+ZazYoe2rSertTZdVACYl4SN5rF+Hxq1tHhJErHzVafLg/bKtEhdkzf
 VGa5dNL0p//Bssg4rEzKEWjyoP7RagpWl5wyE/k6P8ycYM/uiSP1hSTYhdchYpD3P5bAAXoq2vg
 nI5u+w6YilK1rLf6ceHk4LuArbUs9SETZ8bES2F1OK4iVLtRbLkcw3q5fIjuBYqcRXvWNh1HNJY
 ukbaRb9oE7XrC2ja5k9iNWS7Fkwu0esgXet+gJGcitq0HmYDlFeyi1DoyoNVShSoLXp8zyhdryF
 uQ5XX2trm7T6qJHDMp1NqHDygF8/hUbDh1KBn5rkbXCLVWvGMnSfTZMnhL8yMYNyQrjPTxETMMM
 Kft9Fojx5cwPFUHhVKIuCyLMpASPz90yVf10ZdXaQ5McAQOs4G13+ucCq7rU7Uvzrwj7ODTLE4M
 b1vMsquv3N4+Wmvr1d7XGoUll58WArjMyt6uL34KdR7zNsSuPTAyLTxwGHB+/pp4kedrhtbxRSz
 sAg==
X-Received: by 2002:a05:600c:34d2:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4bb7d6d1f21mr10057405e9.1.1794952042780; 
 Tue, 17 Nov 2026 13:47:22 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d256f64sm14409575e9.1.2026.11.17.13.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 13:47:22 -0800 (PST)
Message-ID: <f68008ab-e743-4859-9b33-a88fc1e4b855@baylibre.com>
Date: Tue, 17 Nov 2026 21:47:21 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] accel/rocket: Fix the panic in
 rocket_iommu_domain_put when the domain is NULL
To: Chaoyi Chen <kernel@airkyi.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-3-kernel@airkyi.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <20260814022453.437-3-kernel@airkyi.com>
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
> In rocket_ioctl_submit_job(), since the domain is assigned last, an
> error before that triggers rocket_job_put() -> rocket_job_cleanup()
> -> rocket_iommu_domain_put() with the domain still NULL,
> causing a panic in that function.
> 
> Therefore, the input parameters should be validated.
> 
> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
This issue was already fixed in commit 
70e6a33d68a9b03335c5426332666e52d07f45d6.
This patch is not needed.

