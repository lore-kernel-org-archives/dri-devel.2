Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3B606A337
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oNv+liRd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KwOy+SrB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707711124D8;
	Thu, 26 Nov 2026 15:19:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BBA1124EC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:19:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEschC1071257
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ex2uGZMaTo28cXK9e97FP9eID3+hoE7u72R6RyiD5yo=; b=oNv+liRdPWRzk7rK
 SX+pO7pgIIJjFDFa+PF3myfN0YZ6rg2AR3lgRV+jHmjfm1zNKUPoKBHFAAHfd1Zd
 HSX/q6jqroDN6gPuDT/7qWt/XqcAWdq3xguWUQGP6dnEe9KHJb6VvPG/u9xyvTEs
 p++ao7NxFYT4t+bfB9eNvIoYBQcAkKPNJq3u/l2XS53gMz6CPmG0dyJvKx8ZrFpL
 97HB+BGSEcNmHGOaGDEt6NqPAB/OhIvYX0VKD6+8BCvQaRpeAGHyEBZ7DBkE4aJK
 nQL89ORA5Yz+lKuEHnxZOJBCahN8UGCZhFUuAahUiEv6mafcOSdIyMGV/4hxk9Wj
 PdRlvA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne1jwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:19:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5360b8cf8f5so14779631cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795706373; x=1796311173;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ex2uGZMaTo28cXK9e97FP9eID3+hoE7u72R6RyiD5yo=;
 b=KwOy+SrBMPvmmORwzLX27KRdkzn/pE/8bc3GAG/A+9BldFYHDJo0gvPdMx1dl00Vog
 Y5HyKKCn9FVy32ccX3Su5e9dkZGJdzKCmXCY4hi/OrFWIKfU7u/VOeJed2EITGvuoY9z
 eGc4HaDXV1VWJqlx/OxCLDR6rh7SCrZizepjzZynjIEYFob7uY0Abq/UZVDR/GsLKaQy
 vhnmTQJTuizZ7hczNEzSfBhcTmvq0cNMsu/tPyP0qn4zuK95mW2HQZeqH0Br7TtcuMUp
 JaEsouTKbQpl9cQeD2enSG9QhI7okdoJYyszmwYbQ0yMFlSn3fklv3oPNkm9Lg4YkX0t
 h6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795706373; x=1796311173;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ex2uGZMaTo28cXK9e97FP9eID3+hoE7u72R6RyiD5yo=;
 b=X3+QYvh0rCGfmV8EQ4nZatbOjkRO5R+8jXZpqupJnr6y7iQM5fhIAl86Wb2vP9uxRn
 umI1HbzdiVKoV3PfhNG0ZScWlVsAChbQJqFz/A5G1UUglL93YnNl92SZo0DUme3DEMrN
 Juod7YHUTV0qahRUBL+kE/u0rziM/ANvfq3r0lZH4fQSk0cf+BEvj4Q9BJxGkg5ppIwR
 I2yGPH/BKBORlbNk2myrCRK3aEtbkJnkjQt+QDxNnaRBTicoLxBgT0UkTiCjtQ2N39D9
 JXhQlj/lCdOhnisCQr3g9hu5scDf2y9lnn8XiX/w4SQB+yrwtNFDtF5PlLOu0D4qx0/g
 t2Ng==
X-Forwarded-Encrypted: i=1;
 AL+hErFx8M+DVfR630UImxsPI2IQK8aZw0t9c43oY+ICJSxgIPV3XyRGY0qYwENAWvD4MfON1WhUEdVEcBI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LYOULkxMNvz5J02HwJs48PP+kKcPWzcTR+/TIOhH05Mqj75Ea
 et6QCDFyjpgO6N7Bv+OHf5uqrMwnJHJSzTTBh5H/jWtM1GFKQinz8UKLJoPcdTc5whrSnDIL1sf
 B+wS4/15plw5Kh87049VL+qLAhsg/itptaObmi32Ii7OTz/bilDl2uEKZzNL3aUaemaqhSeM=
X-Gm-Gg: AZFdTZceFygv6oDuEeHQ0RiuQCqdfF03gKGgD0YLzb9pJIEU9oBeKmajwCtIzj26wXa
 Q7kU937aKhDyYoqmjil5l69WMxF2AWOp4eymOSDF02hdwEMoJ6eM9p7LbJ9M3aFDa9JhCp1A/ND
 p9b8lqD7qJnp9Y10BhtYgIpTKexKaoUFARlIr0UFA+fyamPz5bBUeFDmrt8mPwPXaK5FYfAvFdG
 0Jia4/tv7JwkxgL2oeQ0Zhgb4m64NX02poweMieSraxXFf3MKQmuLfFbmAVPU8ygXW8AtpYjjEs
 RYrzmAb/ka/WrzrxXCsx3RH+f5CAe3FxjK1ug/oZHW3tujI8OcqD8P4fjR7laI8wujn2sYKAp+k
 7rn3coGnhmokTTVCinHnqiVVGrjuQxFbVwpHGpUxyqIwyggbb+cqLXs5zoqH4GAC6KGUbqKE=
X-Received: by 2002:a05:620a:a084:b0:949:c973:1372 with SMTP id
 af79cd13be357-949c9732a6amr3391365585a.3.1795706373472; 
 Thu, 26 Nov 2026 07:19:33 -0800 (PST)
X-Received: by 2002:a05:620a:a084:b0:949:c973:1372 with SMTP id
 af79cd13be357-949c9732a6amr3391362385a.3.1795706373059; 
 Thu, 26 Nov 2026 07:19:33 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37108c8esm9867226a12.31.2026.11.26.07.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 07:19:32 -0800 (PST)
Message-ID: <330a5417-a973-4211-bd57-c5103cada03a@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:19:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/msm/a3xx: update the CP protected register ranges
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
 <20261111-a3xx-fix-me-v1-2-d81f50f1ba1e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111-a3xx-fix-me-v1-2-d81f50f1ba1e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b084e06 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=iDjXRScZuT7tmbgFxAoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfXwx1TIP3y/tEw
 bXdbHnRaBw5W4Z2wS37Qbb0h2W9U5V1zNHaGFylBwWInC+ECoHCW+2NINImFybNtlOIh63M6fks
 nnrpnO7Z64mZ89L1nQrR1MA41mspAKXxJjrvmdUWZjISt7w0Ca+kNntdNNpSB2zG4mDtY+V2KkO
 u7zC3D1kNrmk1fMz851Q2E1xj6knmPaOQH3IPuOBoEZmMXDMDiR7huTeGFIEA6GsS+FHwCrrrW2
 /PXhhUxjU53d3owhpmmfjN1rojhVjVh4gpNWkPR0tpOmEPtUVZFn7I9M0bMxymCjys/LY83pRyT
 sXd3Ch22X+eNlM30HttV9I+pvdKL9AxeN/exmtzQ2XHeUtvSbBG8cs73TaJ4iAj6OaFrpp+3ckI
 rol267GnbzkS7ail2+V9voOo/MOS8X6yKxbjUji4aKMDfVXPpQIKETULwOu/bJHpf1L9dTPOS3C
 6MSnIZ3abgnRv/byD2A==
X-Proofpoint-GUID: BC4B9CIpoA35V8nuuwvoAoma7h1QorkA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfXz8WHTVPKW4So
 3ad7NTEdCkUIETwSfzjeTtBA6qxbrLcky1WKAbyFZvuRxmrtzqCwRqOMei4a5mWas6bhCLF5ALI
 VOvUPobOtAlGRbEMCDsuijaJ3q//Pec=
X-Proofpoint-ORIG-GUID: BC4B9CIpoA35V8nuuwvoAoma7h1QorkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260059
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

On 11/11/26 2:05 PM, Dmitry Baryshkov wrote:
> The protected register table was taken from the msm-3.4 downstream
> driver. Update it to the ranges of the msm-3.10 kgsl driver, keeping the
> wider 0x100-0x13f RBBM range and also covering the VBIF QoS and AXI
> registers at 0x3040-0x305f that the driver programs.
> 
> Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
