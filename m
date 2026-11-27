Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA68606A326
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromdisposition.org header.i=@fromdisposition.org header.a=rsa-sha256 header.s=mail header.b=GJ6xOBiY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1F310E208;
	Fri, 27 Nov 2026 00:23:50 +0000 (UTC)
Received: from 4do.net (4do.net [51.68.154.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E59B10E075;
 Fri, 27 Nov 2026 00:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fromdisposition.org;
 s=mail; t=1795739021;
 bh=y/6ETTKQWSdIBrWUEiwvoMMufChdxlb4i9BGax6LuFU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GJ6xOBiYoBrEWnjMrWSkiXDKvAaWHx2DvTRrl5E/mL0yfgq9Jv2ArGR4bMk+cP0jB
 2Va1SfUz69eKBK7UkB9IXw8zLipNSNxWeik4ouLvIO3O0hwYXOWLLzX01k43yh8qJP
 QPXrAVsWv5KRbgPMKxo+cYrtikxoqQ2gdk8EXt0NM1z0ONU5vI8zeuDg0i+NorpzKj
 tvftMw/iu/nzGwK+y46W4J7KYWaTJMG5M3iptLCFS8Bcto8xi26E692vZcBhTm1apt
 BcVzAkcFHRCUsVOqQle9DYDEkLgKfQcJI6eZ6cnoBStqJzWiV+vg6iPtAf0SxXaAjN
 /gotfd+jzbFsw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Nov 2026 00:23:41 +0000
From: Demeter Barna <me@fromdisposition.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Akhil P Oommen
 <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav
 Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 4/5] drm/msm/adreno: Add speedbins for A660 GPU
In-Reply-To: <56ac1346-3164-4418-a00a-168323787535@oss.qualcomm.com>
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
 <20261105-b4-sm8350-gpu-v1-4-a7175cdd6512@fromdisposition.org>
 <56ac1346-3164-4418-a00a-168323787535@oss.qualcomm.com>
Message-ID: <9bb065d6e969a550eec543cc888d1bfb@fromdisposition.org>
X-Sender: me@fromdisposition.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-26 14:29, Konrad Dybcio wrote:
> I only see at most 2 bins, what's your source?

The downstream devicetree. The one on my device (from
lahaina-v2-gpu.dtsi) has two as well, 900 and 840 MHz, and my unit
reads fuse 1.

The 738 MHz one I took from a newer copy of the same file, where there
is a third table for speed-bin 4, for example in what OnePlus publishes
for the OnePlus 9 on Android 14:

https://github.com/OnePlusOSS/android_kernel_modules_and_devicetree_oneplus_sm8350/blob/oneplus/sm8350_u_14.0.0_oneplus9/vendor/qcom/proprietary/devicetree/qcom/lahaina-v2-gpu.dtsi#L903
