Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92A60A2601
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=k6WnmBlR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F98310FBC1;
	Wed, 18 Nov 2026 12:28:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535B310FBA2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:28:23 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so9362155e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795004902; x=1795609702;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qZqAnvrKTsVRZ3k+qpJ8SHuObdEj1UWG4cr1fECpUNs=;
 b=k6WnmBlRquDkP3BnXTmISDjrD5Skr44orwVrN69yJVk+C+HFPLJHYAzZtPzHPK1/4z
 rE5m5XOJ0mj0fO8raRUSFytlb2byWfHsLMC9rt3TF+n0VSv9QamBP1WuSny1BK7ouXw+
 gjLsdDXQWTUNIA/ayxnEuj+kYguPquyxLetTc1key7WWEUjRyEaSNc7xemMiR6+xscLC
 nVF00/GWFl4cfKAKHLV+azE9XrC+eQcbcFczu95UVc8ZwlaFNp+tLWUA0W9R8W/6WRpo
 6Zhw/FkrZGRvVsTAQG7l1PVOS7J0fQlpIjicTHAH4ghXG3TO+il58x5YQ5qgXZC4amNU
 feAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004902; x=1795609702;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qZqAnvrKTsVRZ3k+qpJ8SHuObdEj1UWG4cr1fECpUNs=;
 b=odUP2jmXCpky+uGmWoTokuLM3mdSJZbMfqtL/O/osb4DNWaGI6gXPmtpHDAA0W3/zj
 o8ka6Qpl2I8YQAlgf+ZebUGBiW7rAqaJTaYmv2DkJIQpEr5aK1fZGEdaShf009Fwebjy
 lWx+aCPJ4uWgU0Z8wdZEL/vLPMek0gwz3vIElx82qW8SaijkbKF4YUaYXPzB/202Wt2x
 JwNxDY6Q0nQ1TNyw27Lcxw74JbldOEn7mNv1uHU4mpDvz99e3U1PvrcMCCiATtMYRer6
 FRKWsbt+60cntnKXi0hQK4fdR2j/zPnghXg3ZArpun24Rdx5aqri5ssWdiNKSTb9OISk
 TRfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFUsaQrdpyxSfux0/3+KKTZQ4JXkdkhH4DEjtY7FXIk/pEcwMycJUch9EMMgimr2LDXfhEPMVdCMGY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+y99N5QRXqGGu3CSe8qIqRto95o3d2n4ng9RwwsZ92Qwzdz2ZF
 RpQfK/HpJf68MlY9dmy+HdAi6Lncqlyvf9Y5Ns9FCGswpxgg+IXs/eftJ8aqqa8+38k=
X-Gm-Gg: AYBFou1tgXqF+urOPvA6ZbCXgr3sqMkyT84R7EKn68ZwGfZMI8W/arASj0bIgRA3p1r
 AaVLauFf/j2fkdFSbE/6m7Bw211A0vcabD/XjZMxEiZweaBsjgAtvIm2xout6T/WwatUMoXoAgb
 TvfoR9L7ymxHO3lCV3wSI0wgEHXw1NJJ75wKZ8Cy8790gv/e4CY+b+nhBZORByfOUfYsB6UbI+V
 rjNzeQA8zhYMz2DDNyUpyUXhoecbzp+TpNzJl+OTqly3U3cV4PabtsR7f3TyEBMpNXzzeC59xli
 BRwCUriBeORTHSRkvQIsDEgxwAh82iorUkHyRi0H7G12Gm9xA7zSUvKanRBlKqXkl1odIJ1dH1V
 6vJylYNNX1OjFzcy5ltMfRbFCJwEZq/NBv09VipOtAEivIPrLZnKUMZwjJteMUK0HtNCkYY3SHA
 vxuEucHjyQJYRy9UnkcIEvWgrs+WGzdQ34jZcfioqfqr7XN+jiQABpgfkKcQPXOwCuvdqflFedq
 eEoQJWtH9vj7g+e9Nae+jJDSQHZ+nqo/h9cPlT7cMXIS79x2hygjrA/ylzl37NFXq/4P6ZFpMbZ
 7LJNng6Vjzax0BYda9vaayVuJ2CVHkbckgWg2PNp06YSt9Cuz0fDrcYvKz5YilzXogpEJx8ryTm
 K4g==
X-Received: by 2002:a05:600c:34d2:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4bb7d6d1f21mr46698525e9.1.1795004901817; 
 Wed, 18 Nov 2026 04:28:21 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2abfc4sm64858355e9.7.2026.11.18.04.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:28:21 -0800 (PST)
Message-ID: <49a9337f-6808-4f30-b826-9a280849a51c@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 11/12] arm64: dts: rockchip: add NPU (RKNN) nodes to
 rk3576
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <f9f4f43cd1c4c8c6cee0371b4b92badf37e68832.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <f9f4f43cd1c4c8c6cee0371b4b92badf37e68832.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> Each core is on its own power domain only: core 0 on PD_NPU0, core 1 on
> PD_NPU1. Measured with both cores running, the results are correct, and
> the nputop and npu domains above them are powered through the domain
> hierarchy.

No need to include lab notes; we assume you tested this work and found
it to be working before submission.

> Label PD_NPU so a board can connect the NPU supply. The IOMMUs use four
> clocks.
> 
> Also set CLK_RKNN_DSU0 to 594 MHz. Mainline sets neither its rate nor the
> NPU voltage. On the ROCK 4D the DSU runs at 786 MHz by default and the
> rail boots at 750 mV; with both cores running, each pass of the 5400-row
> test has 11 to 25 wrong words. At 594 MHz the test is all correct. In the
> vendor OPP table, the 500 MHz and 600 MHz steps both need 725 mV.

I found this wording a bit confusing. I think you're saying, the system
boots into Linux with 786MHz & 750mV, and that configuration gives bad
results.

I'm not clear why you picked 594 Hz then. What does the vendor kernel
do, are you matching that behaviour?

