Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405D606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oidO9ov1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JFld1Tpx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897B510EFE4;
	Mon, 19 Oct 2026 20:32:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4649310E1CA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:32:28 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKJS32158052
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WP16KsMS9UndTPVKVIGZFfnh
 HsJS+B7A6404Qzj4ck0=; b=oidO9ov1cjN/3fBf9GYVjfKzjKLzVOUFeSsa2A4F
 wjEsy0IkLqjkAU/9E+IiZ6SgaLaxUtXe7R97+2Wv79gM7oJQlu3IEwEede4zf3AO
 ruRZf+QmDA+dhDJHnSnoP0oRVEEDzfeMjFQsb/dgQ5oYnydshZVGTkXtmGP6wOvq
 0+wT/E3k/dniG2YgidT30gkVDku2s6Snaimj96tcPVeJoZmJnbhAIrlj6truQo+M
 P0pbTwrfqSDDjrO24IV07pdSH1f7tIeKoQ291s5cnzWM88ouRhIXDM5WcX66JGrl
 H1A9dLQuCZyM6CbSBrKC7bnvKyE6b1VLwptXXGLY98co8w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65k5pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:32:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a556c43so58340966d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792441946; x=1793046746;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WP16KsMS9UndTPVKVIGZFfnhHsJS+B7A6404Qzj4ck0=;
 b=JFld1Tpx+9PW6WtJmP0pJDajM2GgqHHRaV0WBf19a1Rq+voLCq4AlnfvLLWDqSbzoI
 sNcQei9UB7bfIEt1cs4D46kpdp7qn5mfj7e4GFaeQjx6mTnqQ2+FXHwmlJ3lxcgqth7X
 9NVNnZvPYiGkffip+t0u+MwJiAp1Is570OTkWGvHgv6SIfbZUjlFnGTDIV6vWqUyTJpq
 CwkXJse6/rHpoXr8avrRtHx4oa63fW7r0+KcXHeKKdIn48yaQrwgMFqmLmLPWbKtFb1n
 +RsQD0Q1FfMSOaYscxInjrd69qT8a+h2ekFpEN8avPp6W9kdfIip+uwoHPixbu/aS5r2
 AyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441946; x=1793046746;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WP16KsMS9UndTPVKVIGZFfnhHsJS+B7A6404Qzj4ck0=;
 b=VpbEp/+JjWWB9bmNuFv6UIuAku6+eWKFGMpi19OyR1WMXh6u4UvKy8jnU05PDHsxV1
 y8Du1Cj4Hlw4ZwJadLPF+pUm6ZfpTV6R5M2AGLTwGHgVzUvCJHrVVqya/b5PpENVSHzv
 SzMGu/TQ7F/Uudy8DF0YT2evhHW6R/9SYLoLMx5uBb9ds4R9XSQnNDoex5IlwqEbZI+D
 ESPyNYaIXtkHf/qA3mKTcevGNksjU42Et/FEsa1+SfV6LB5UEdrM2mRv1kfi1KoxNmuu
 GMhdWW88lHdftj/Aypq18RLcHLNwfcAzpfMPc9KMcBgy4tjT/npwE8t819g6A6gMRMkl
 Br2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy50zXzzEG0jLQGu39ZLF01+Nep0OfG/6iXqAVyGdIO4z2XC1X49qIlYFMb9NBQbN2xWD9SZxXZmk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsRHG0CQvXOom45NNf6qNQrAwquXFk3UtOalv9cMbWUhJHyfKw
 uEI8k6CH6mmQOkdFbnJdC7GsObv8nNK8fX++UrhqZGF7/aMwHN9QbcH+DHtk6Eogmxckd8TasDb
 ZY6ytQGhP0XpTxAxP7keuEwEBuBxpfeOhvUvk7ydK+iMMmoM66Z4hZwQAb8Vy7/tCUExbU+Y=
X-Gm-Gg: AYBFou0/v6e91rlykDiCwGYkfjqqJ5jcgg+npAX52cwFh0kLTUH5zODP+Y+0OuW1aK6
 mKaGBNdeJU/0WA/h9NwrrDNhK5mQIlo+83st4nD2mFpLIVinl9Gw2NeKphNkUkw7DbrSrY1G2CU
 PQGDE/B4kOnzlAoC7zNX4jRwLnlpJw8ogky3o5N8sV7zNtYiADMb/q9c5mtevyAN7CYx54GZv/q
 CRL1tqaIqy2so8Js+69NouFShwA59LOg+RcHClR5yEK1/tag2UWaFyba1dd4DgPsg5eJRZJbSZi
 lQvJfzdqRLwZPsV80vTvWV8DZxZcWTs/O2bFrgqy3w5e/Uymyi8QkWOlnVsyEvvCGxAjEtjQ+kA
 NlfdFAI7BGcEl/p2o
X-Received: by 2002:a05:620a:72d1:20b0:93f:34b0:4880 with SMTP id
 af79cd13be357-93f34b04abemr804966385a.22.1792441946326; 
 Mon, 19 Oct 2026 13:32:26 -0700 (PDT)
X-Received: by 2002:a05:620a:72d1:20b0:93f:34b0:4880 with SMTP id
 af79cd13be357-93f34b04abemr804961985a.22.1792441945686; 
 Mon, 19 Oct 2026 13:32:25 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d85a9bsm17135825e9.15.2026.10.19.13.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:32:24 -0700 (PDT)
Date: Mon, 19 Oct 2026 23:32:23 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
Message-ID: <evnzk3qzvvy2pmf6ndffqamxf7sv5hrmu4tia342tmix2xhoyb@czxgky7ywmx7>
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX94Zs4+i219Zh
 UATF2ytAczlx9/LwVf3fRUiV7fXcEnjRLtqNpVcrzKkudqFVlK+1mV7poMw8OERYjnEE5guGqjS
 SZ/n2mRN9G9vY3uE9cteRqJMu1HxyPc=
X-Proofpoint-ORIG-GUID: j2eK9tXlL67jsrDIp9l0quEIqspQDjiY
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad67e5b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=PlByJ0tI-E0pWcfLig0A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX6Um5Lp/1ow7c
 2MXys9qFI77N2+wYzVgSb4Z/djJHqF3Qvw6kNfCGDX4F7RjBrvnYrSyvCje/6Fm8Rk+ZKTprS0b
 86bz62P6AD/NAZgDzF+spL6503fmLuEY5k/Z8qgIX/oP6AcYUiorWGU0OlsJ1H1egz3ovyk+5q4
 Op4OyvoMuT/rhCJvHU3+9+H8A8+DaJKxqfBnh8tJHqWwUBNOtxblqKETGe45HC6bobPqMG5UY8k
 BevkBf8r5OqJGHF4iTsJaSrfkbL+hvCsyZ+0ZStinidmSeqqnIahmI3kwawAxWhlGaRC3jCQUoi
 RaT/05gWKIVBpCJ2gpulVaUt86MqEbHeCnMqxl9MaEieoslKE2643NLHIdZWRji5c/QhNzpuAou
 N/9xQkaYXwVwuUgVLAQTiM6aD0ruax+BsTNUmZBsKk3BlcYS/0JBzz8R6+q1cegqDubGBNEgJ+z
 MnIiUjwkZaVOe+5g8og==
X-Proofpoint-GUID: j2eK9tXlL67jsrDIp9l0quEIqspQDjiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190081
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-05-16 01:37:51, Akhil P Oommen wrote:
> Add the CLX domain table and the IFF/PCLX limits tables to the catalog to
> enable CLX feature support on Adreno X2-85 GPU present in the Glymur
> chipset.

Same on Glymur CRD with next-20261013, GMU fw v5.2.38:

[    6.619232] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt [msm]] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
[    6.629590] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
[    6.629750] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -110
[   14.795082] platform 3d6c000.gmu: [drm:a6xx_gmu_resume [msm]] *ERROR* GMU firmware initialization timed out

Dropping just the .clx_tbl/.limits_tbl from the 0x44070001 entry fixes it.

Tried on top of next-20261013, no change:
 - the QCOM_SCM_GPU_CLX_EN_REQ change
 - GENPD_FLAG_NO_STAY_ON on gpu_cc_cx_gdsc
 - modprobe.blacklist=msm and modprobe msm at ~90s, after all sync_state()
   calls are done

So on CRD it is not an ordering issue. The CLX/IFF_PCLX HFI messages are
all acked, then the first GX_BW_PERF_VOTE never gets a reply and the GMU
stays wedged after that.
