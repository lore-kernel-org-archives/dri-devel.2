Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE1606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OgsfUskH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFD410EBD1;
	Tue, 17 Nov 2026 21:53:56 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A899410E3E8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:53:50 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so4786605e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794952429; x=1795557229;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LTgzw7Qx4yJlL2BwvJu8LETB7gbbjhmnMAMVPEMPtDQ=;
 b=OgsfUskHY7geQjuie1di2lOvCXgaOUJQQHCMZpbtHMSwqFuWEeOjpUg+jvHVpQWDqN
 yrEiALC+8svFc0DZTPC88sr5QF/1NWczrQzaDLzMxxwJEkN/xp8zWtoDSRcId4mOKTim
 y+6cJn5p3VTN2ienI7VVMRzDrn/Xn8ZzpMRFBz7p4kRTPYgE1HRUEOlcN8GHs1WJOwrm
 7Cufjh/mftwRuFOOdFp3drBTN4p8TwucQzqiafXtd4rU7zzAAjev94/eHCb4xRxbXNth
 Of/3vpnJ79A3+eKQGX05d+tm9J+4OBHZxtRMpSHD669kwWEkjlta7CAyLn8Qt88Z7qX3
 O3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952429; x=1795557229;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LTgzw7Qx4yJlL2BwvJu8LETB7gbbjhmnMAMVPEMPtDQ=;
 b=Cc31z413nGVckpuERIkERAwJJMX0Obx/bj5L5vDhdlT8DDlCLKzG66Y0HO7BhzkH4W
 sS01kOZuLuSBXq5kH1aDJAC0sCfeCLMqJeyy6oO6/37TeJ9uCb6hrs0FvTtH5T+5f6kE
 1kz6Kty83KoInUCb1t+Q+hWs17Sr+OCXsY45UcyJ/Zpl0DSO9gjp8lejJemb0M6KVf9P
 bjZzzmxsxHxWszG6stXWP201BaGNvFOfCf45+vWpjaChtt3g9s03XzmsM1j1UkcOCgd4
 RGr981knda+cT/tjpRbuBnABVe/8qgc/8LG67CU9BzmTocF7AWjGiYWe9yA8Kqkizt3u
 FWow==
X-Forwarded-Encrypted: i=1;
 AL+hErFYgWBfxIjh/YzzKnd1oxsAIR+QznpvhvlsxIYLO+/JKBZ4TeRixxxn5wfFSST2HRMff4p2rfEfLYA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cyGwmg7QtLwOZD84qtoTWbnf7Aye9tWLmSGOms7oCf/IZ6DBs
 KkgkIFSnvo3N+C88d/e9krmJ737rbfKd1nq41qzLvs3OfhLEGaY6sot6ZbRQaXvDDSM=
X-Gm-Gg: AYBFou0S/WgBtksw0HsZ2pBEKcO8Mkn2dEVavhgZn/wSabFWJ0+4Em6NxMKVye7G/GA
 K11WxaIyzVyYWHSZwiCMv+cDq1sZPlrBVF/hdqmpiwXep/mEewWsqOaSQqMKC3+TAwL3zU+38s0
 PydMhA8kLCUFlf+kth5HVql0oPSvHsuZDm3bthlyhg4RYhq45tsIrXu7nBABxMFW9UKWTHHqlPA
 Sg8PTz4L6eQx40CU9vL6G16KnftjNis0otm2gjqNYHIwE9gz98uSfur+XMEuFU08LBQPlkNEptB
 9FJLKs1Uw4l4Y5RnS4KJvO8heinNJpICddA8hjqCzn0qtyI7SqkdegjFCJO5n9h6dD/Lv11oGtL
 CW9hFCWgbJpWgeGdqvJvAOTGS9HBqC1B04krvqcy/V23SJgelWjVl36/6W2clP9V7RawzYdOeTc
 j30D8ayVUltYELBhC2boBj452jmeL1dif0llEnifyoyBry626G/GtIGuK/TBShRxk13tYnSc+eE
 lJx2ZURPW2UIsIaCCpes+R2UVQICLjAH+z56H1Z6jZbezBwPyIn1pYSsM2PERCCAgQ8CaaX98QU
 QCsgDjE9Y+xy9c/LbBLaamIDjN3xu3KMf1r5Qy2/mnvdetuf2Xv2KULJd9+LTXGShZYnSl8nJsr
 nZw==
X-Received: by 2002:a05:600c:6995:b0:4ba:4395:5755 with SMTP id
 5b1f17b1804b1-4bb7da03a42mr9384865e9.5.1794952429178; 
 Tue, 17 Nov 2026 13:53:49 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5f350d51sm136099085e9.4.2026.11.17.13.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 13:53:48 -0800 (PST)
Message-ID: <0e722f43-f08c-4636-bf3e-0dbe991bf6a0@baylibre.com>
Date: Tue, 17 Nov 2026 21:53:47 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] accel/rocket: Fix the extra iommu_group_get call in
 rocket_job_handle_irq
To: Chaoyi Chen <kernel@airkyi.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-4-kernel@airkyi.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <20260814022453.437-4-kernel@airkyi.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 14/08/2026 03:24, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The rocket attaches the IOMMU group in rocket_job_run() and detaches it
> in rocket_job_handle_irq(). Calling  iommu_group_get() in
> rocket_job_handle_irq() causes the reference count to increase
> unexpectedly. And this causes rocket_core_fini() to fail to release the
> IOMMU group, leading to a resource leak.


While there is a leak here, I think sashiko correct in saying this 
change would introduce a crash because core->iommu_group can be set to 
NULL before this codepath is reached.  That might be a simple fix.

> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")


Wrong commit mentioned here.

