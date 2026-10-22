Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B1606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYujOQpX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jMr5FoEE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1AC11249A;
	Thu, 22 Oct 2026 10:11:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0790112489
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:11:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xxf93426941
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=c9B2KZJqk7yWavVCYYzwu+zA
 2gBsyHi3wZ3RoLDA4uc=; b=EYujOQpXhcPwGx6szVYQ8PLBcWiS28DJul+ISrVy
 qRkwyx5acOfFAWNU6K1SExdLPLSHUn/iJyosKfM05T7TbgwW5ePvuB48nJ+CiWR0
 W7ASmhJhxWxOh/l8KlXO2Fdlp5A5+HEgMoXE4EoGt8or7fb3r4mWXtaJlYp6RjAH
 YKuNR8t1gg88vK9YjHmnFSJpX5FNm2UrhmMT4eA51I7zwuF9IH71SmnlNlKRJBva
 a3wZfxLcRNyp5/cBBERKjj05VcwSGy3ioBUqLPWMoNhgeBotgf/r6ylNvDS/1InA
 Xw6LQczcS9b69ypRVK9T4wkpbk1AQUhGr1jQwCPc67lmVw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93asu0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:11:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so363681985a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792663869; x=1793268669;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c9B2KZJqk7yWavVCYYzwu+zA2gBsyHi3wZ3RoLDA4uc=;
 b=jMr5FoEETG/SVTe7RanDMkm2Bu8uoBfq691GMjiY6MMZgRKNcZvZaZAjOGRHTKBz7m
 jRuPynb9CX7lThjPtlXgn0eVMNaVWZPUEQOI4aDyk/j7PEqVibQlgSeMajqngXKKPztb
 VbhevqMFuwmpxVdXzJcGGnF/Ii/1SuxL3Q6f7kT82JEFbR3fO3pkAIh8fQojQJ44Tmey
 AqEA6ye5TzHUz71R01+lXjDNwGS/tVNDLZauXqUFiLbYUu5Bhz/Loz3ywqmaiAhB4y7v
 v9YxTK6s99Q/iMcDR6YsM2w76Eoyhz4sN5ySFFCXRQ+AZ33nDtW1EPAKphTP4M+b1zxe
 M7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792663869; x=1793268669;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c9B2KZJqk7yWavVCYYzwu+zA2gBsyHi3wZ3RoLDA4uc=;
 b=JQlJKzMnxLahT1suGf3547apr94fU7k4C2+s1fNSQJbunYZeetnnEP7+ED7/L1IOFG
 lCoilHHd6cor3bF6rn8FEifap6/kb1wvUBhMBsQBFtQ7a4Yiyr1XRiQIkGGT1MyfAvWE
 zav6Yb845ZUTiBrC6DLH6yITKvYu8OUQfaylMrZ1SQZ4nCW1zDOOmiObZPkGQFlV+z5Q
 jFJSnla2dZqmp1KQamldKml50OJAURnELA0hqKhbgWkc3Tu0VHI1FlPjjKo/kQvWuBra
 5PXsXRUICwIJ3hninhe0w7AmUup3Mm8pQuriMRwuLaOmkDXiuUeaSFgIBOfcldaLihKS
 q5vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxO7ygpgOF0sHeorhQLbWXBXRg3WeCPZSEkqPYPmpSuTohJKUfoYPLEIXS1Z1XNoQiVpPDjMdNgKbk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcYI7seL1dWtPZOPtX6+oj2YiR3gQ4QV7yT6wRXzxuzFMucsLv
 COUhLQoXOB+SlDO3WchtaMQT9yUOdA1CDGk76BHNECVwfP9VR7bF501oOKVfYPF0wCEVnwUbSAL
 2w5dQgHNqQvHjwjryozQM4F4s5FiWKHVfsIZk+hrDN7mCSS2BG/FZx5wf1k5z6mK8pKH48yE=
X-Gm-Gg: AYBFou3XdpWy2zTaHJnnLLj7vVPfFVkv95Y62vOSvxECxfyixyNhLWlRf8g4gORkWyL
 MijARPSqZIf9Yhwh9zAI4VXixWLGVZ3Mo/NQlX2uYwQaMj6GGIvTTOa7GCNGomrRQ3IOwiD33b9
 jeVY9W/2d1BRyixwOSyQPHSMjCkYQTwyDZgcb9+DjVdNF4zi0g6/sCNBDy2B51uy2OD0zrmWYEq
 S/xoeq1pwIVlQISPePSWx2hEr+RgKbaOTvoRpz/gAQjyrh0a0vnlk3gHp9Ip61XKODsqjhHNJvU
 z8BYD53LABn3r8msNg6MgVRrCPwjlWr/mURwJlPtysrAIureHSUrtKNFbhJNCV9DLqmRyTKvneH
 uwNH1phHQZbbks51zgYDyqLRmU/1Mdgg8PhexN+uhA2so3SDrbRCKDk+xGtpOBc5gXymq9vO8Ei
 +pEgwHmiHSplU1
X-Received: by 2002:a05:620a:8909:b0:93f:1936:b20a with SMTP id
 af79cd13be357-93f57f777e6mr833148785a.76.1792663869295; 
 Thu, 22 Oct 2026 03:11:09 -0700 (PDT)
X-Received: by 2002:a05:620a:8909:b0:93f:1936:b20a with SMTP id
 af79cd13be357-93f57f777e6mr833144685a.76.1792663868810; 
 Thu, 22 Oct 2026 03:11:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac4f5541e4sm6578571fa.10.2026.10.22.03.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:11:07 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:11:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] drm/msm/dp: Add DisplayPort controller for
 Kaanapali
Message-ID: <7p6lfgpiav4hqsxafx552i5ck2evnczrpkpb3ggjszvwzsajvy@75h6d473f752>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
 <20261022-kaanapali_dp-v3-2-b5ae8e6083c3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-kaanapali_dp-v3-2-b5ae8e6083c3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfXytR0jxqEkPDb
 Mvi5aLlB/sX8TEgyJ8ahEtnoSX1u9z0b4AgMudluJjY6RuwBsSDgFWjlADbCTvBES8JyUUxCGBo
 BT3GdOjPdd7r0PUna6sIIWqJGc9QaQ2ghJgnTN7jeZQSGSDsUvJ7apS38lANAOuJeY7iSeXqbvM
 qYao5N0jAku+tHsGhSbrsTSbBxLtRBy8Bj0aPqwksRQChihqZkCtfVTLQqAF6CA+OEWTb+JkTxw
 rWIYOXw99CyTTQOu9zwJPTYHkdSe81H1bQQafYEUmvGUEy5cs2joODeBgy7wjUgxoVaZ8d0B2hF
 gitYSUt3veRNYtz8hiAEXsZ51qcVTUzA2E47FLmndiQs14lNX49kAuL2f+Gm5PBdFoQEkKlmMSO
 ILdvNiqP2kqTM4EWR2pGijfeTPIDxEz0unRbaEu0E3hxGMfNnx02Hz4EuPCYihrUFgsPPckXB8O
 zgax5erQfxXW3soyOZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfXygaO6IqWpzH9
 1BwRJA3XpQM90PCJaizl+ooCm8mtTT+KFzW9zoeI/hRBLKVgEqvsu1HfCaJqFXSxMU3TGK6LnEc
 2mwOiHFewouY6Swrp4ovfBBY9YP0LGk=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9e13d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=OHVtJ8ySOF6wsxM0GN0A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: WLVUsk2Or04S1-OUT6Wy14E-g-VcUIWj
X-Proofpoint-ORIG-GUID: WLVUsk2Or04S1-OUT6Wy14E-g-VcUIWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220040
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:19:43PM +0530, Balaji Kalkonda wrote:
> The Qualcomm Kaanapali platform comes with a DisplayPort controller
> with a different base offset than the previous SM8650 SoC, add support
> for this in the DisplayPort driver.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
