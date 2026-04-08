Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6ABFD5F98
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563B510E5D3;
	Wed,  8 Apr 2026 08:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1x6Kwzv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KKNeQfqJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A3510E5CD
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:58:19 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6388Ynag1796071
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 08:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qL7PDtfGlQZiLJDrztVf44XQnSa5r5vuSGqc/zpJnTQ=; b=O1x6Kwzvdbg2uw+E
 eILejdyVH8cqvM1QAiK+GMVTPTMJgESQ7kRxVRHDpvuB5G6XP0vXeNEVDxsokE8K
 RomxlH+xxn2A4Aic0mZqvOQNwquLOH3htT95lgMbWlhFM18LZ1EmEedK0F+Qx4Tr
 yHxkLlZ2q4YsaPbYXlSUJYbhgO8LE1WPOykoKwISdvh384oAOkyz4nJhT3efaQYH
 xD1xsEBHAoqyAdG1hNtRqely/oXDlWyRzJn9+fFZAjc/DI5qyVAmRAWC52bJNp8J
 fCniJp5gmIwO+ycHF/qILuPcdHgFbS/0SlHpuf06vO/IrxQRNh7d/Sf+3aZHUnV4
 IJ2Vng==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51db95c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 08:58:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb485c686cso203866385a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775638697; x=1776243497;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qL7PDtfGlQZiLJDrztVf44XQnSa5r5vuSGqc/zpJnTQ=;
 b=KKNeQfqJ6BeZh8KMLpM3sBfEmX+cQxWzuD+nKo05nhCTJnAUxiO/plb3Pnx1swzsyD
 ndcRkWm3D3+uwfdqZeF7iEuEHGNVgVLx5f54yQ3VgPhWiSR8VaUI5HtjJFZR30l/oozB
 g7QE7zSztE+i65/H1EtzQopYLWwSQoT/tuNlYIaNLOjVBNDsPm7hlMdM1bvX3ESTwayZ
 wPTACcnW1TtaKsmJ+sFUMOUBU1g1Xn839/gHh3ldfsYmn7G3jHWAmCXJlWC0Tdt76/rz
 HdTPq4Y4nCP9ipYbSkabEj+3ZVA5NWmKbRGUot61wKMSuAh2+DXzJA75G2KEuU9WVj1r
 8HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775638697; x=1776243497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qL7PDtfGlQZiLJDrztVf44XQnSa5r5vuSGqc/zpJnTQ=;
 b=BFpgv8liPE+yNBdHjDo7l37ITy6sZ4qxP+7+JT6F+B62TV+NE6na8Vr4YO27ZNTz3Y
 1oA2ezQRF+mL/7MU66KBnaGLx0Rn26SFVnEcU21HfWRBQm/aB+blF88n2VUawpsW9Y+7
 X/p+7Fl4ZqVT/S+upgo8CKkxpQ2fyPk5nDwerP7FJfFV9LZUqlijOgTDbuo09D01MKMo
 Aahg9jtz2dfPsmDewR+i5StYPF+PhHWotO6n7znJTOwHcZzbtzKuyDAeaZBClMF1KW62
 7IYSQbat6xEpaeb07EncsVopkR5iKY9JiWjads7RvG09GpHYkayzfBwgrM3p3YOWdYIf
 /Pvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjqL8H8HDHS6PDxzdl9bYuzJhAB1FeWoec/AgynOuBOEYGyD/nV+CDD4p7oF1ypwfv79ge4xvusH4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyh58C0ehiJeRLzQiy4PBSVRXoPKSYm8fTeCYE1REFGthljmkW8
 Hp5bUVZNoZnhL0R8r8rXjvCQ8/PRf6OAthXKfqGAW3bQM+KYxys31srbUMO2dL5IaJVBQo6wOGJ
 CHrh2ycB/KH0uLYULszGxlDojfzcsoYrZdCyK8XXdt0fhgJuaT4r9BW+nTGW1ahOs/zePMdQ=
X-Gm-Gg: AeBDiet1F4AEIg+YwUovGNOApnIb6P/4Vb+A2mSx5ywpQGZa8isNuAZLaFGzbGlqf+r
 sI8JeITa9mfghtLf5/7W6WF7+xJZZqFAe9q+WtqrVjtHSkVLR6f1BCvNPIaNnOF0j1v8OnCQZbN
 hYtN+PiX1FT95RBw0NWS1CQUgfj0BQUWdWrP5It4Q7amCrt+WNfRRRkE7H0jzcvLPQ7jDrXPYwe
 TkfckwV8IBkIfzwNxpTh+SsWWE4JcrLvAQEjyMuiOObskAWqt4vR3ofsbc1mPNVyAQ52HZrzMm6
 SwxbqLOD4CdNU+G+x+yUYxl6MPb6tusgUFNt2ebMHTSJcc7vruSiLPh2CKy6XTzPIcIv+FE/gUx
 s0p1JsmsijXp1Bdfml9kVCmJSKua24j8yAsbAYYyZITpBgOVrTJ/qd4MozZBYxV2whapCnCE+He
 7JG1M=
X-Received: by 2002:a05:622a:7292:b0:50d:8667:6829 with SMTP id
 d75a77b69052e-50d866769d0mr92898351cf.2.1775638697507; 
 Wed, 08 Apr 2026 01:58:17 -0700 (PDT)
X-Received: by 2002:a05:622a:7292:b0:50d:8667:6829 with SMTP id
 d75a77b69052e-50d866769d0mr92898201cf.2.1775638697114; 
 Wed, 08 Apr 2026 01:58:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c9721b6sm612375166b.10.2026.04.08.01.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:58:16 -0700 (PDT)
Message-ID: <cb21fcd3-b924-4cb4-971a-9e56319fc18c@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 10:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/7] drm/msm/adreno: rename llc_mmio to cx_misc_mmio
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260407-adreno-810-v3-0-30cb7f196ed4@pm.me>
 <20260407-adreno-810-v3-3-30cb7f196ed4@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-adreno-810-v3-3-30cb7f196ed4@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zDnFMlnmmamiVJdlrNumN2ixogK67Zwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MCBTYWx0ZWRfX0Dclt8QZZugy
 Nveydlt7zts82h8CcxfvDUmLKLV/o3U00MXs/lCo4+MYzJygej5IjJQEQqEacHeERvjRbRaXYvE
 UohUCL+EzxAx0S9rsGzW6eqmRHIkytl9BVXh/RXvmNE72mzuqxKR/tslVnxE3Y16zF5hEPW/bAK
 t7xwnCqcBNY+ovPvWhsNdUWG63oKKPKNwJRenG0lqaswnskFLuq3EmdB2mKexvUSUuLvIjy/Q80
 GFRdlsNma7Q9NEKPrRe0NOkOkkhe1+hnBOIm9rQKijZx0TwqnN/nk6mP+Ur7XEC7IO11IZ4pz2K
 edY30h36RVWIqDj31aOlEwq2Vrjt3IJbEDyzppB3p04jZK65SNgyToI2T6By4unlSOKPayeygtO
 SVIN6vI5s2o7hDJWPdJDC8/2RUYoHqUdryqerEMbIEWKCClmpWUZEdxW8FzxTFO3s5B31UaqOHF
 zQXz2vxtZoKOqd8bGVg==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d618aa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EWmrOR-qnjryNtOcuEoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: zDnFMlnmmamiVJdlrNumN2ixogK67Zwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080080
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

On 4/8/26 3:45 AM, Alexander Koskovich wrote:
> This region is used for more than just LLCC, it also provides access to
> software fuse values (raytracing, etc).
> 
> Rename relevant symbols from _llc to _cx_misc for use in a follow up
> change that decouples this from LLCC.
> 
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Seems you lost my tag

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
