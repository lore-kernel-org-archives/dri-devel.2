Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3C3CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCBD10E173;
	Sat,  3 Oct 2026 22:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQ4mZEd3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EkBE/2jb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A507C10E173
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 22:20:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 693Kobr4312105
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 22:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZDUY4/VeGKFBMA4JwOSyOd7J
 xyUkDkfT0gF/JVIGPn4=; b=NQ4mZEd3FAsW2dkl8OqrjjtKWfP8wtAPIpaVmGly
 Yp5EhqD8FO2JGnZmIzuwX6gvBFFohxXfxZMBD6fD75OF2U1q+LD0GTz1G8Ber3ek
 NltrQakv+zZRMtlNxOUfSHu5GUYAeB6o+MMScpkwhVqvlqhfDGUtMCJy7qPnpnyl
 whqGJErcCbJjqDFCBPiTtJDt5LbkDI/CsOwHPXrldej7y/iPTIKSQgMnNAkPGFob
 QTwhoj/tfMueJh35z2l2zFe+XtMBoHOB1ztJxsIWL1MaTeoDuJTOxhi1CfS41bDo
 Xb4dDAoaISke0Rv+DatI6ZbRXrjls9Vy76dLYO8AYxetCA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2t36hwsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 22:20:37 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf45382794so598083137.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791066036; x=1791670836;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZDUY4/VeGKFBMA4JwOSyOd7JxyUkDkfT0gF/JVIGPn4=;
 b=EkBE/2jbb1fgeeCuEJRfdpJUx4w7HrupPBlj0S3wqaM6VZvXNy++2rk9gzpGmtloQL
 GMgUOBkrNrxNf2Z43d/ZpwVuaZriPHHY59QmKg9oTa7fK53SaIXmeEgDvu90vWaqbhtK
 fPrqJ6XU2zdkDQOe+p3s6Kx1vsDrDE8uUD7Qe7TNdTs2Pe4asQEjGL79eIHnbiIHVz4n
 J8iKE02t87JAPMWDzK2LM93OZ64WEZwOnO6FS7fJRyMlNGrsgBtDu3gQ1YRaKxgXB4+A
 ED/Gie1WhOX81/Tvb9Z3ZYC0Jk7bfsNy7uQgdSje/Su3d6IfRaBHJwTZKmcBvWxxxaLV
 r5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791066036; x=1791670836;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDUY4/VeGKFBMA4JwOSyOd7JxyUkDkfT0gF/JVIGPn4=;
 b=ibVLrNfoAFtdNWVJq6i+ExrfNjiUtuOV77hJ7Y8LxatQBiy6xC5msINyfmBYKXG3on
 AbI65OO4f0Ol4/pctgnVpsgdemYPy1ttDcW01dR5E42G6MMTnmIY7g54PUainge9Dp4q
 NWP9H2EqtmcI1rQ/jd2yVrasu072229fr3J8y130nmGfSXMyegT26d+5Zyu8UQsREWvt
 iLL+EsU6Ds2PxdjCbV6woqslI0m36QJcYiEKxyselfJI5jN3S/dH5QzLthCF5dmy4hSD
 aiSfH5e3WDnu6cLCPn5yzlYFbf0pJiDBdQ31Wk9YXrzl7NOQtVtDPqNRNuzU2eJ+RkUh
 gllA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/JW3uQ801Y45iRTR7jSeX9L+iB9/8gCneQ58M9No8Ql04WWYcICH+Ts125d6NiPp/pVkH4F2jCR8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+eeoCRvStdhuNxSeHRgqL+ibEJA6s34EKxVn14KbJf8z6NGqm
 rWH3+iKuLwnk5sAM6AnlHa0YE4dakMZsr5HjKTVUKvfbk8DdHzi5O2+2gJWntgPP5YOyd1pQTnf
 7+uqlt272dlZt7rcl6HWU3IOtiVZLdcTWP/9x2f1pK9w/n9AhhGabt7ve3Zq3YZHMo+6Bw/E=
X-Gm-Gg: AYBFou0aGHz0ORnbzhz+0uUhsv1aySrqXW6xRUSeqno9gqKWpNvkys5NRYrc5iC8JRL
 kugkBuRZloujOj+WbmYErMkOC8Ppk8cfGrbG5ICAwd8ZuGAHDfsdGGE04ZQlEVWn3mcpeQEP6Fy
 IeUfDjJ5ImemsdK/wJwx7rEIa5IEmvkGfgpU2LRC6qUooPUMdkp9n6ck+rU0Emc75ht62OsKJcX
 B5ZzzBCih+U9e50jlDkcf4/TWRZx3w0YKqNXzes1pd91N4wdqKEB2nWtHaM8knK89W02QVxtLhp
 n5OkldtzuNgvjbOBuy1FaSWnVmYiTZ2zsN/Zfz5W/RBmzd1FgKQaU+2rVIeNKAJ9j6piLw9Z8F+
 4W5UhkdJulKalbN4nh0m3oBS7GWGwdTxB692JJj1TdFIJTDWeexl6lwtFTGn5PsvjUtrCC2dezV
 U1lGbWs58WuExN
X-Received: by 2002:a05:6102:3c89:b0:7c3:a114:99a7 with SMTP id
 ada2fe7eead31-7c3a1149fd1mr157082137.14.1791066036412; 
 Sat, 03 Oct 2026 15:20:36 -0700 (PDT)
X-Received: by 2002:a05:6102:3c89:b0:7c3:a114:99a7 with SMTP id
 ada2fe7eead31-7c3a1149fd1mr157066137.14.1791066035847; 
 Sat, 03 Oct 2026 15:20:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e333cf3sm24109191fa.39.2026.10.03.15.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 15:20:34 -0700 (PDT)
Date: Sun, 4 Oct 2026 01:20:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nickolay Goppen <setotau@mainlining.org>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, akhilpo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch
Subject: Re: [PATCH v2 3/3] drm/msm/a5xx: Add hangcheck progress detection
Message-ID: <ffjwlr4kc4rxb5rktabvuplrz4kh4zrpki7ctz6mrkdtyjvk5f@r4easyboav2s>
References: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
 <41bbbfda-de3c-4ecd-87f5-cc784fd6483a@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41bbbfda-de3c-4ecd-87f5-cc784fd6483a@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA4OSBTYWx0ZWRfXz1UNlqCzAi0M
 Gb4S6RXW6ibtTsMom0yxPd6/K16ZLk5EjNn528olhAnQLPpvPqmAiKX933yddgJWISFahBc1EIH
 J9Ovl8QJW3dmx7a+ppqNcVSWPGkuGEM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA4OSBTYWx0ZWRfX8p2RZ+7BUFud
 tdVeSe8i/34IWPBVhGO3Vrg4m/92BEeXydNJnPdM2NOVkF1bbaCJcpYKopm7i1RHvz/rEKxjpz6
 G0n0hPaM/ZH78TSGpPjg3tKz45NknE6N6T0Jl2Gr2vYCZHVumQL9eFCWrgbreV8LGuNFacxgiZ6
 uKd/Yjl1nd0Sn2j5E2/Dh6CQ8yQIX4AGT7NVbGQKL+vdXnsiVAbHR9jRy1GK7/KijDllCIvQimX
 p67nds+8ODS8hlGkfR4bCZQn4xMyMmDXFjMEkmfEw2xih1rW8OgFQ/b9jH9WzDjPLXpapzUV86L
 55gSFWhY8FyouFiDdgoxzL1If9rr9iO5Vlibx+OM9Mo12Cfki+/O167kXC9A5HKzXQcuKGzMuyy
 1UhXntWsHxPjSh67Z52F+v8jQwTkzjR5klkbWRzVw66bJoAPoVC7hfoM4e96K6ndghnp1kwqBx7
 qwTM1ZFuuusE1gZ6oYw==
X-Proofpoint-ORIG-GUID: i8fdJVp5iq8AQJuhFeu6YzKJNXjO9XDP
X-Authority-Analysis: v=2.4 cv=UpH2pOwB c=1 sm=1 tr=0 ts=6ac17fb5 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=TF15XWlp9_Q2BVNvarMA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: i8fdJVp5iq8AQJuhFeu6YzKJNXjO9XDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030089
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

On Sun, Oct 04, 2026 at 12:15:42AM +0300, Nickolay Goppen wrote:
> Didn't solved hangs on sdm660, but I think that it isn't related to this.
> However I've managed to get a command stream from hang_rd. How can I share
> it?

Open an issue at https://gitlab.freedesktop.org/mesa/mesa, tag robclark
and lumag. Please note that for sdm660 you really need the patch at [1].

There are also several known issues which affect SDM660, but they are
mostly on the userspace side. I hope to submit and fix them one by one
(e.g. on that chip there is an issue with the blitter programming).


[1] https://patchwork.freedesktop.org/series/174541/

-- 
With best wishes
Dmitry
