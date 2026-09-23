Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23F5C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E541E10E9B0;
	Wed, 23 Sep 2026 21:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IFfLk5F+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172A910E9A6;
 Wed, 23 Sep 2026 21:08:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2D3D600AA;
 Wed, 23 Sep 2026 21:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16721F00893;
 Wed, 23 Sep 2026 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790197711;
 bh=oYRyYQ7jGFmso8AY6dUwDwpqY0QEPIOZBmqP3y/+Wjw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IFfLk5F+vPh8IZNhqF0jC6aiB53HDZvSF2VK2z8f7otoMhT2JY81X0DRgu4kSZy1c
 joRyiJr0iXdIujrsXvmcilGrrlkhEL9YLIUEvmzKixvjEeFJ8vxgxkwXlAMImcgbz5
 ObT2M39E9XWkmhhoICbrZZTEJIdLs70sQZ7CLs85nDdlrYvQI58UEG0MV2Zli3ORfN
 qEGaY7uobvyPgkqQYN9MxRINi7FLvSkgqHtmHbwFsTDaPMYxN2sV8xdrPRQjkvGaFE
 AUROK5OvdNxX5Jpjfb4/VhakF9Jk6w7yYiqjrfNKsr4mXgTRJosRSZ3QC2bAL67QYd
 6F00ow4Wk2EBQ==
Message-ID: <49153dff-b4e0-43ac-aa82-15175fea6445@kernel.org>
Date: Wed, 23 Sep 2026 22:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] firmware: qcom: scm: pass qcom_scm through the
 exported API
To: Albert Esteve <aesteve@redhat.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Russell King
 <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <jjohnson@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Brian Norris <briannorris@chromium.org>,
 Govind Singh <govinds@codeaurora.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, Maxime Ripard <mripard@kernel.org>
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <bRb6NzJiFvNGB0X3BeiVytgZNlRv88LFlcaBwwFIFa3GtVZhn5bh9EoRRDliRtgsnlQNMddvcIPK-5HK9x7z9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com>
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

On 14/09/2026 13:41, Albert Esteve wrote:
>   static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>   {
> +	struct qcom_scm *scm = qcom_scm_get();
>   	int cpu, ret;
> 
> -	if (!qcom_scm_is_available())
> +	if (!scm)
>   		return -EPROBE_DEFER;

Is this equivalent code ?

Its also a bit confusing to me that the next patch adds a .available 
field to the qcom_scm struct.

I see where you do get drvdata but I haven't managed to find in the 
series where the data gets set - haven't asked an LLM either - I think 
the logic to associate the scm pointer and get it should live together 
in one patch so that the logic is easier to find and reason about.

---
bod
