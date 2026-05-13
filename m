Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADD0CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5368610EFAF;
	Wed, 13 May 2026 17:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mU1hYuZk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8rsLQIM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A3010EFAF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:57:41 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DEm9ba3474831
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mMie+CI7fOWywl6kF6h6N96e
 rnFrXS2fN9VjDSUGY4s=; b=mU1hYuZkcOu4TnVf24ssSjxq0iGXPCqiK9fhfpFw
 /nR4/pQhm1S820fJd12uRFzF+R/hseA/A3r+HqM9SRa+JCktFAVaL7VgRipAsukj
 9Rj59tw4tjuUJM8TFMajl75npH5E4wpsAwRfpNszIf3gGUE6Kc5Gn+PDqNAd2V5G
 cQs16fJO2t7sUoFvyC/huzNgYTrNsIg4GIJj+rb97+RDmJciN3MLe9Q1ZqE+oeEL
 ZoPpUSZ/mDJLGLwgon1oWrI7JlT5Vs+GUjTMMt6gHzryF4S+8s3mRMASej0KjhDr
 Ih9i5msLFZodVD8ag4L99QlXLYloS+ZzDfnQDffBs/+j+w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41a5ja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:57:40 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-63308aa427fso2102382137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778695060; x=1779299860;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mMie+CI7fOWywl6kF6h6N96ernFrXS2fN9VjDSUGY4s=;
 b=E8rsLQIMSmszRVqT2p6cJpYBAVv9AE2mu4xBNvYurF1uqCSobdZpgKMpMXzqvWShYU
 a+31doCh5HBI0XpcQblrQndFLxe+/cLgSvDT3iuEhkUwUynB/3lYLD5tQDAotrh6Y4Yb
 BaROdJo02Yy0BFL9cq0QSQZW5ETNg9xE6m1kdtFLBO/iyDpzv2YIuYWZmfSVXlaPRL65
 rCCbPqBgig1J2gkXl0i+2nRpSon7TUAsCSyhkn8I16Y3/RxAGMn/xmKPGO0PR+t4077k
 seuHBThBfDETjddG5XWtp5mz2nKM61TSZS2o4VS2DN97TjQZR2pxrcV5gVlAtI9BChJ/
 wmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695060; x=1779299860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMie+CI7fOWywl6kF6h6N96ernFrXS2fN9VjDSUGY4s=;
 b=WFYuo0iG2ZkVVt6gTTJCh50ndRXojMghz0Z2uJ21exakUXh8JFFgeNTrXjLdgatUdL
 S4T4nPmWld0ONhr0cuaJHigvrZ751Ms2JZSKUzn6H+Mul9MMMXUhmFHVZHkNGSGegEP0
 ls9WkIIH/bYDV6G/fesHFPosGxZF8GWKQDme2FNM0Wqlh69hRrOGpuSsuwKE/qXD2IU9
 BRAz3Pt5m0qHAcIJ+Sd5PV4EvPudPa+NS9YHyk5st/eLlMeWU73pqotCZp/DoCXj9xOc
 cnT4rfn8JOGgdhd0fDJAhaTNgPf12yKdImmJ6je19ws/uP48pH5tHbpjOuZftt8luSxc
 5koQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e9Uw4JrAAt6CcCfprBJO25boXuY3tNtL+Owzb/IjZeZhx3p/wjS19ugvAWhv992uTZoqDxKth6Ng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNPztGa3cRLy4ZUaHKKuwBP57F5vkBj3AmU030S0qH1Gv4RIjI
 MtS+poyEa6TvKP1gTIVZ6ri/Qmueg1bXa/xGFUPWoRXDlwizINPWm3sUxg5I0E+/whIxsXgYxgb
 4WUx07E2XGuyrCUwH8Od+lud19114l9fy25A3fdOAAHB7LYXtBmmBRjTfhWQI21uxIjL2PpU=
X-Gm-Gg: Acq92OEI4BjrS4rMUnguWm7Aebqiax6k1jRlqg3lOWLadMdlfCk+YZCYJcxWGj8CXl+
 OykgHm0inruUYrQm/oPBL/oep+vzgrH2JkM55zGFgBkrzMtEK+rS6JeanJSW5ceWhOK90vP4Ayf
 iUAwC09dro0/Jj1wqE9xuYs7WdiUE65diGp2jrkVNKLsY0ZisVIC2WXF9NKR5qmzZ1jHWAQFErX
 gxdwJbF3nAzoZw0/9sZzyLpcfy3+9Ie94bONYthDDT9ZTFwglo/KIEZO6QJBOl1ThD1lvcZCArG
 yp1n/Pm3GlfzugUrDPnsbxk/R+/p0hQIoZtnDzL3tNbmSCzvIEOnU5ODagNi4SdGEwVcRVUdvRF
 3A31yjkryGsbAki5HRME0j7dWXYuxv6sbfRlIEy/aa7I5n0pEg7CmE/T7XOLI8iBLl1+j0JNfeT
 6SsxoW4F1y0wIvX6ouTbUZYM0/rpPW/pk3zwzWqLOOjOVwNA==
X-Received: by 2002:a05:6102:b07:b0:631:e729:4575 with SMTP id
 ada2fe7eead31-6377156b7b8mr2460648137.5.1778695059893; 
 Wed, 13 May 2026 10:57:39 -0700 (PDT)
X-Received: by 2002:a05:6102:b07:b0:631:e729:4575 with SMTP id
 ada2fe7eead31-6377156b7b8mr2460622137.5.1778695059390; 
 Wed, 13 May 2026 10:57:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8974sm3167182e87.64.2026.05.13.10.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:57:38 -0700 (PDT)
Date: Wed, 13 May 2026 20:57:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 Yifei Zhan <yifei@zhan.science>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sdm670-google: add common
 device tree include
Message-ID: <fz4llnqzz4qx5xcp6j6xswtkfmalzyxm3jwycl5yfmn6qhc6n7@wa7mpngjeykr>
References: <20260513172549.1345-1-mailingradian@gmail.com>
 <20260513172549.1345-2-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513172549.1345-2-mailingradian@gmail.com>
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a04bb94 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=byJCrBVNwhKw5jrXw44A:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX+PZ0Z/E3ETri
 NNMgWnJE9QNbc7Uqtp50KkNEw7u9/1arDE3wbleEru/7cMgHaVzHgXj2jABsjmuzH7H11G0/zm7
 mw8pyXNCc9sE+QjObfBl/jWzwq6QJ22s+zZLSwr8z53DWHS/VG6Ph4yToiy7of9yq7MlMwVBO7N
 rVdRvCiAtc31Zfnr1bTEPShIXVgF861nrxTaM2J3vLRLorliWI4yVSqprGV+xnRx1g4Ntm7SAVL
 JO67iuCPAa3+ZhaDaFxwy/9Hg43FKVO3zITbomAyNSw/EHnhewtJj/0cyAyFVf06wbpx1wDAr1n
 WTSmxQudOGymB8zb0ipJ1PHuGisCpS/n7mHfexYExg7yKze7EowfRa2HQlVr+ju8MTedcekdYJN
 ybDcVW6w1g7+4OQUfHse/T7nDHplRIQ3P5wk4tlb4IGkgYmgwmJkhpSU9kqdhefglE5B0+3eoh2
 ywJF4IpD+pkiLCF3k3w==
X-Proofpoint-GUID: 4FW5b3O64opIJo8Pwdym_2n4FGTDzVxo
X-Proofpoint-ORIG-GUID: 4FW5b3O64opIJo8Pwdym_2n4FGTDzVxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179
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

On Wed, May 13, 2026 at 01:25:48PM -0400, Richard Acayan wrote:
> The Pixel 3a XL can be supported by reusing most of the device tree from
> the Pixel 3a. Move the common elements to a common device tree include
> like with other devices.
> 
> Since the original devicetree should only specify non-XL properties, it
> needs to be completely rewritten. Also change the SPDX license
> identifier from GPL-2.0 (which was deprecated as it can be
> misinterpreted as GPLv2 or later) into GPL-2.0-only.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Assisted-by: "Claude Code Review Bot":claude-opus-4-6
> ---
>  ...le-sargo.dts => sdm670-google-common.dtsi} |  22 +-
>  .../boot/dts/qcom/sdm670-google-sargo.dts     | 714 +-----------------
>  2 files changed, 20 insertions(+), 716 deletions(-)
>  copy arch/arm64/boot/dts/qcom/{sdm670-google-sargo.dts => sdm670-google-common.dtsi} (97%)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
