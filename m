Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFF910ED65D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CDE10ED31;
	Fri, 27 Mar 2026 11:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnZNiARR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CL9fqoOB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4788F10ECEE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:08:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6vnCv3713711
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hH6XCXfU1cU4MjgGg+hvW26AzW9Ed7EUeCJbH4+sBf8=; b=FnZNiARRNURmkMMS
 QXVXc1OEtgPfIFoGi+gzagm9/p1NE4ZvGWvHhv/b7Bt+xiYEx6PuFpIwpGSxr7oB
 FpYSpzOj6n2xI+UJO4QOZ/oEsUD1v6qlZtGer/SENLZndAeBRAKW4Let9K4gGHd+
 16C6/PUgEK846h8dH58s+vL+ctqXFV26vbCqLp5VGsR7ZUbBAa5zDb78+7jn6eHK
 t6RwFeSIpoybD1r+ZhWSLn6IqajzpZDJyr3UvFZhlj3oV0jnJCsqSvL4eo6ozJaA
 8X+UcY6RyzCLwK/o1ePDOdLuvCY/Ljoz9Kh77Lm/5/UiuptvbQFFB6gsW57Gswt8
 0qDNTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapstf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:07:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899fcb63705so5505686d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774609679; x=1775214479;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hH6XCXfU1cU4MjgGg+hvW26AzW9Ed7EUeCJbH4+sBf8=;
 b=CL9fqoOB6F/jvcrOTledmCtbHWGbdaT9+54ZZxEDLB4X1al74FU/tRXC3gR76OFksQ
 TfwC2f4E4XwNdH99+6iMSYG/ntgsFTLk9MAjEHeE9CA9kl6MbmiVVofeb6E3D+9xjZPR
 gn09POYh45scoj+C4goiJh3UGc4Vi811TcJLkYtHi5FDE6ygEGVIYdr68IP6Hv0OlAp6
 wAECWx1Dp0xUPGAZNiz7Co2cD2RzflHW3WtF5Ua6/Y9RSv4IF/NnfjEK5yXmKD3uyGTX
 NpZ0qtdLQ6KvGyBCoPf1lSeLoyiFZbGF69PCaC6+JsXVYhSMFrtdo89HGSfUUNXWOi+j
 QLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774609679; x=1775214479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hH6XCXfU1cU4MjgGg+hvW26AzW9Ed7EUeCJbH4+sBf8=;
 b=Pog+wVIdaj+bVdiSdg0Lkgc5bAnA99fm4LnpS6JKBqjQDPMJZybmi3Tv0INey4gxlG
 x7N5Z62QXFVKDyeA+cmOiET7JANPWbJdpcdt3l3eRzm+RlH/ZItgRKF7ec/RVN1JsL0t
 vJCmL/RydhDmWOfGcB5h+oFC5vdJbQX5zYTQO4abCp2PGOn47lGiBoXxEmF96/zhH4RT
 CaK5G5oYKgXiel11x1rhSY+RwHOJs9grOtj0UcPzH1u2hrXaCMX7gAvU+gyZ+EPODYyh
 BqSVZQ3ruetA641N6Si0nFbw6+83fh+rKvua8caxCEFJcYmlK7H8B37MJCNob9HlU3NP
 sCDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3AxkQy5Gm0USkVacq9YjfITjH+coc+kGhpC7gK4JkVg54y2iYpqeDCyO96ig7kGuf32/VYS/eKAs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yymd2TXd6KpeBS3jDz4IgnUqLpHpc9ClUEyu/1hBVJGE5UEkWK9
 BiLJNPLXRFE/YhTsTab011pTZUTZGl+Nfnz5n/znXfKLRt6vkfqUqrQ+bI1xI/HcrjheMsy/gB2
 qO4UupiN2SqdGkByaKD16LTc9yuCJcWa9jJ2TWrkwrRD0n1wOUaFwLzox+u3IVYShccF7wzU=
X-Gm-Gg: ATEYQzwWrnnoRMOMzAfD5u0gdDngEfmD+9XpCkYPTSoFjYSsLzk8K3uDBCz/hnzlxdg
 kEGpaKXYZfeUY8qV+pUpLtMR06+lR5ZlTImjBMPGn1OkVK5XFH8ryhHAvhE2IoNX2K7AgqmeEQI
 TiK85ce3eTMAbRTnRqxUku11TSurFpTmqAtwa24S1y4EwNlO2ATys8Nr79vPj0/tD1AcxwOjJhO
 L/p/BmgsjBzPDkPseWzwagaCxm3OtO7ddodddPqz6QRUKTJ4psDGk8ZsIS6dC2ZDOnotRFDAPua
 JBIg2IZl1rkuD9wDINWOv+Sn1jYyv8WlJFTcCc/JVuyaDJhYJV20+r8HHWNpVdygZwo2YshC1bw
 PiWYX4vUdpt6bocG6cgLinkdg4ITts3art8MQm9w6W4nj2wfrgiNXeRvhkkH7D3P7FdyYKCy8Sw
 2Ec4c=
X-Received: by 2002:a05:6214:4111:b0:89c:69f6:a1f4 with SMTP id
 6a1803df08f44-89ce8ef05a7mr16678806d6.8.1774609678789; 
 Fri, 27 Mar 2026 04:07:58 -0700 (PDT)
X-Received: by 2002:a05:6214:4111:b0:89c:69f6:a1f4 with SMTP id
 6a1803df08f44-89ce8ef05a7mr16678416d6.8.1774609678368; 
 Fri, 27 Mar 2026 04:07:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203c1104sm240530966b.33.2026.03.27.04.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:07:57 -0700 (PDT)
Message-ID: <b9f8d016-e22c-45ed-a50e-51e18f5d6e6d@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] drm/msm/a8xx: Implement IFPC support for A840
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-14-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-14-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c6650f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0lWO4tzWYGIBUrK3vqAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3OCBTYWx0ZWRfX05JoApzroadQ
 y/OhhV5uwHEij8z+SSOAYxfE9CdXngt4IzaIyTSbSv4u9cFPNK0Nf8Y67JjFh+RZj7uEjev1Ihq
 UOzJPd1iD/Uh1RLYdIAsJoYk90Nwnfsmi11rhdDbR+00fJrmI+bBI0KVkPZeDvWcyDLBCU+g/Sb
 v1M1XPGzuihGReodLrgX5Dg6M8OUWLr22/oSaA9mTY/d6vWy+zWB4dZWMyLl5USbsudXRRrOIit
 dE0xRIhAzRkjj3kOlSak4VI7vk+Hyj0qr46FctvO6RmwMHoLwoGLKsiqPW+irzvWULMYkJ8KArI
 NJlgwH0o4UsBR8M08nFmuoy9Wd2r9LbVf2NUhFdJ3tkQ70A6QhzaEOiDoIxPW6/lB5ET2g6T/by
 8hK+LVdXDBXFMfMDrsWcEXpWiiUlWevYvsrv8F8V0rBnTMhNumZ8SREE3xQxTo72TAUncJSc3VW
 N0uEy+sSWXeDVX0fhJw==
X-Proofpoint-GUID: CBJ_-WTDRFZQXeyAa86WKpLUBxOL6z1q
X-Proofpoint-ORIG-GUID: CBJ_-WTDRFZQXeyAa86WKpLUBxOL6z1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270078
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

On 3/27/26 1:14 AM, Akhil P Oommen wrote:
> Implement pwrup reglist support and add the necessary register
> configurations to enable IFPC support on A840
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	REG_A8XX_CP_PROTECT_GLOBAL(51),
> +	REG_A8XX_CP_PROTECT_GLOBAL(52),
> +	REG_A8XX_CP_PROTECT_GLOBAL(53),
> +	REG_A8XX_CP_PROTECT_GLOBAL(54),
> +	REG_A8XX_CP_PROTECT_GLOBAL(55),
> +	REG_A8XX_CP_PROTECT_GLOBAL(56),
> +	REG_A8XX_CP_PROTECT_GLOBAL(57),
> +	REG_A8XX_CP_PROTECT_GLOBAL(58),
> +	REG_A8XX_CP_PROTECT_GLOBAL(59),
> +	REG_A8XX_CP_PROTECT_GLOBAL(60),
> +	REG_A8XX_CP_PROTECT_GLOBAL(61),
> +	REG_A8XX_CP_PROTECT_GLOBAL(62),

53..62 aren't listed by kgsl, but I suppose this is more robust

Similarly for:

SP_CHICKEN_BITS_4
RBBM_PERFCTR_CNTL

The other reglists look OK

[...]

> +	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_DDE_BV; pipe_id++) {
> +		for (i = 0; i < dyn_pwrup_reglist->count; i++) {
> +			if (!(dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)))
> +				continue;
> +			*dest++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe_id);
> +			*dest++ = dyn_pwrup_reglist->regs[i].offset;
> +			*dest++ = a8xx_read_pipe_slice(gpu,
> +						       pipe_id,
> +						       a8xx_get_first_slice(a6xx_gpu),

IDK if the compiler is smart enough to pick it up itself, but
you could do const u32 first_slice = a8xx.. beforehand to save a
couple cycles

[...]

> +	if (!a6xx_gpu->pwrup_reglist_emitted) {
> +		a8xx_patch_pwrup_reglist(gpu);
> +		a6xx_gpu->pwrup_reglist_emitted = true;

Would this flag be better set in the function above?

Konrad
