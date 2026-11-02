Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E26606A330
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3Y8ZWrt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KRecaUys
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6125110E607;
	Mon,  2 Nov 2026 11:32:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DE010E5FE
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:32:42 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AQBN3440377
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WfN2zl6N/U5Eh5uhKHe71C3cBewA9U9lpLVxicyxkzE=; b=O3Y8ZWrtZtSS2V5W
 LYyq3iyKF3Jleek/N8UVXIrjoUBfCLs0yUSiB1ehJratC3aKbH6N3I17XXhirxvU
 lFC0rK3OdQh26C+ixDNkIJnl7/LfAd06olQdlZSbeOh+rwnQjgY91hZmyPh1Zn+j
 OpoJBwkelvrKZnIoXsGCEwGwQiJgCKD62pM0liyYipZqWO22PZHVmqJ9vvzrebg/
 DhkYUsohJ06d+tPAxKqG2lPKLDzLTXYXn4Zb0ni6s5Fvt/tC4WDon+pjj7ionC39
 V/GYFVxRkspomB85S9gCsj0MaJAn1DT1GrPpKoAcyWeZEZT+QyBYSs21j9Yw+Xkj
 y5aW0g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg202444-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:32:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso48737785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793619160; x=1794223960;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WfN2zl6N/U5Eh5uhKHe71C3cBewA9U9lpLVxicyxkzE=;
 b=KRecaUys8wCuz79OIQ4oMFguQxuzfSaDAtPQdxRIxtiqZWnQGQjrdQFpl1UZobPy9r
 NH+/nMG/77LzqiMj77wJX0+kFuzIEVvxAkq2cp0ntOHVzyOWyVO2/We7VVwOkwgbC7RB
 gtjNFgqn4DSV+cNLV9V8u7QYo2gFBSVZ7p5+5pAe+smLu582Jh/Uu9hap7Z6oTPSx6Z2
 LWnL1bHfe9eTLjnwdGCuUZncwQVcWZhS/QvXEaOSK4XCl+mvyc1Hgd0BM/uaCqL9w8dg
 ENCj8m1S6OYP3raWV2qpBKmZ5XatP3bedFcM7PhABNQuN7Fi6ya6wzHbQ1FZVaHatI1E
 Ltqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619160; x=1794223960;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfN2zl6N/U5Eh5uhKHe71C3cBewA9U9lpLVxicyxkzE=;
 b=kZjyVpDKxteEyFAKnyTwfGmc2fHWawltrOZHjwRXCnrnqajh0Jhl73ibfwg+gfAjwm
 grp3IzTSsyDQC3duhsfyaZO6ZIDIWtGo0srRuW0l1/jb/3dnYhIdL0F+xzxDuWizzpv7
 BDeQ2M6kHYWtzyAYZzOuC3er720TbT0r0UuX0SuidBzXwLIbLrRCJfPilXUmjzg9020d
 jBVSMFegqtDCiVRf0KlGs8ckDE0kVLEGEJzkfDneAybaXdUD0Y/IBvHlf6TSYHdDMlUc
 1oYnWzy0k3cY4GhEidibFQs5+pDjMzzBS/vpsmHDF+dOlbGwg5Wx3z9joWsO1Npb0AaQ
 1w3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT/Yb5DFXODqfyXhtJ+ehjxJSBINn8AbtmwjA/7Zobpn/zHllXVzwIoxyO5yBbcoHP89KN9aFOLO4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYILcQJmwdcHqqxOxC8PJd+nuWaRzbUedOU0WepAYSjtgtdyYJh2
 /HurNjRpPYw5NO0GacrN+85D/yZQzv0WX/9zJLhZZ48uk9N7ckVMISuMSzeVcSjeN6SvQAYp3iR
 j5NDROKkycKHJf3lAC65Xx+F8baM+wPa2GefpnJkjnq4mTriLI80TBfEbaq5iifWZ6U2uuzQ=
X-Gm-Gg: AYBFou1fgQaYU3aItn24qhvdZxKV/TyZBQyT0ga3+N/6nABm8LBTAB6Cht+MrSiShrI
 zAiw3sSq+5nPE4YgP7OBtQDx86MM4Sh0qDQ5FaI7ERf7sK+zamoEtX/76V04KZCa11qpdKCjwlF
 x4UqW+Pg3RhmUkP0sQHRRgnLNBjIVS5ylWuByoTHI5CLIbal18clRgNZCaj3/go4nZf1ZgmUywx
 5OmRyDsYc0QL/c4LJUPC2oUzOltszs8I14Y+gj+VRyjvOz7VPLFVTHqYp94mLhR+nZ+NIokSuAu
 QLmaLEJjpL/c+ICXSHkUTXP3quISdaN0jYpIMGfRc+924wvZ5bGwcmkTkxFN8WjXkGomjBqsOgh
 pjYqv+u2B3Gd3SgF/0X416Jntli1jotlwT6++rSz70KYlYGlcPop5yhoHIJmeVQngPHw8Xzg=
X-Received: by 2002:a05:620a:a40c:20b0:93f:25c7:a4e7 with SMTP id
 af79cd13be357-9442180ad33mr1570944485a.4.1793619160422; 
 Mon, 02 Nov 2026 03:32:40 -0800 (PST)
X-Received: by 2002:a05:620a:a40c:20b0:93f:25c7:a4e7 with SMTP id
 af79cd13be357-9442180ad33mr1570940285a.4.1793619159969; 
 Mon, 02 Nov 2026 03:32:39 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabf0d1aasm364431766b.79.2026.11.02.03.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:32:39 -0800 (PST)
Message-ID: <4f5b64de-8037-4a64-9729-3f0a3881cc40@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:32:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] drm/msm/adreno: Fix invalid drvdata typecast in
 adreno_remove()
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
 <20261030-gmu-sync-state-fix-v2-1-89d3082d97af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-1-89d3082d97af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FNSQOXTMktxI02ONTHhEjSdRlTWBd_or
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae874d9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=67Tr9d3efp1zOqggaLoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: FNSQOXTMktxI02ONTHhEjSdRlTWBd_or
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfX8CBZmVL/WSg+
 vxUQL1u1KwF24vxRjG4e0oTiDKWrJQihMgSOC0zUGTzlHe6qFgXK/cIzgi/T6c/0PXhnMvzpSNa
 SmWpXZI8ZblH6N+AV7u7/MbSi6vzGnSUybVF9YNEPZh6I+b23u5qyXkaV1pmYNugtkSGTtcnlZY
 jBi7KpdoHvoJ3NG/QNiV75fCFfHdVD6oJb/Xau9Qnu//M9c9fwU6FvSPbADfGu/lp12JYedbrUR
 VM2c6oDug8XFhHTwrSTzsiuTwONDLqHAn2REUGRKMkyKuRnfxE5iYoqgjk+8SKa/6NByp6albuL
 Rt+/W+Pf/4xeb/gm61BGkWe1UzM2+LdTLxNW7KZNlocAQhUIr4lbxTj7uIWrxOKbmbbvI9o3sx1
 C0hQ8L/z7vEXmwf6RPa++FdSmIp7NrqZx/oNGGNqiC/qUy0Igqla8U+lq5G0CrVnpIWnQIPiUaX
 7ljQfuy/Sz8l1A66QBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfXxzaDHwEjb9zi
 B5doBCBIm+CcDbGxOv/Ot5fqzo9qGA9pZ0Ync9anX7JCVfPacjPSepriLsG7eFm9F086xiraglq
 IFoUfQPtWyAYaLlVInJtVUlkVrXcXvM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020045
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 6:09 PM, Akhil P Oommen wrote:
> adreno_remove() decides between component_del() and msm_gpu_remove()
> based on platform_get_drvdata(pdev), interpreted as a struct
> msm_drm_private *. That dereference is wrong because msm_gpu_init()
> overwrites the GPU pdev's drvdata with adreno_smmu_priv pointer.
> Use an alternate check similar to adreno_probe() that avoids this.
> 
> Fixes: 643515a9cd09 ("drm/msm: rework binding of Imageon GPUs")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
