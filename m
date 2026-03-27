Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE9B10ED655
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C8010ECB7;
	Fri, 27 Mar 2026 10:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bG/Kehax";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h94Z1tOr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD1510E37A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:34:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6vf471749076
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k7ZBDbuE2fq6hvOfuwI1jZUEIplOhdF5KT/8Xms48L4=; b=bG/KehaxCjJdS0ZG
 STZ4lfo4a6bgLI5liA2buFRHNc8PXPWWaW9L8XTUt7rhd7cbQkXCiN6MtqqUe09U
 mg7s8kL6G7VChghzwVxPFt/dpdlgiNcgQlnNsQBc2ps3js2cyWIlJ06crErsCYGg
 5PYGXmMIPzLbLIaBWVxn1MX2D8uakQWgGI4aD0+tAFbz8pUTED23o+sElZP9/VQV
 plZESEOJ4qBqBRjvvR0IuV4UeJmwYE+ccyz6RGLRBIIPOkeVL6HCD4k22yYjlDD5
 FshwrVKeLv7O1FUt6HjaPbgxdrqRqUY7q8PWsmWXWYSBYt32w6URDzrkEFDHkCFj
 56+sIg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn10xk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:34:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b33a19837so7374181cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774607686; x=1775212486;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k7ZBDbuE2fq6hvOfuwI1jZUEIplOhdF5KT/8Xms48L4=;
 b=h94Z1tOr95+G4n8RuG6t0vjCDl+i/FD6YB6dm1IQ5/Pn1S0rf+V5/9N3AvqwbRjKkv
 zLCYBzYe/ismQYwT9x+gDQ2OmmMHTpp+DT+/iX1cYt+5vanpAG4SfLoydQLT+p7efSQ/
 QpEcCPzvPQe01AM/Kz/a7cEtmJIiY90EE9hbBlZ2eSXYKgDBbk7eRHGS1qCETi/zCOm7
 Yix7DuL/T3FqRWWslUbLdYf6nqBklu9TmnGZgoEuoycyGsGs+OLZFCpz/w8Mfexn1Z2s
 exK5vtKUA4CufKn0PNkqreJhdZWgdVZS407q48sVlJyS3/Ew6cG5RfgzD7bo3uJUmZP+
 K2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774607686; x=1775212486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k7ZBDbuE2fq6hvOfuwI1jZUEIplOhdF5KT/8Xms48L4=;
 b=jD4KsT22Eb38VS9zgFegeP60k2CSWyofEsX5v4XCFsxwzFgbjpvfglj/e8x8AUWezy
 iBiiri+dU99HaCk7zp04iQxH3fqDLAcWcpEISTEBBsKOR7irXarxEz4GcgtqAtlhWW3O
 BvQBYdrV0VE026stkcb1nHg8l5BjwoeTClmKcaWoLrIgJfhsiGDqXPiO5vedQWUuyn1d
 0Zu980X6QZ3V5l2fD5510/nwx2yy50cIDPXxPaZSQCKnN2xNUclcIp1lOq9eehhFKHK8
 anam2fNwoNiBUzPxzFsBd9IxA9R7x7GYcEMY5U8uSLIINgDUq0256u5eWa9CtSy0FfTc
 +RZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8VhfGMhl5CbrIPjcBbpDQUDel7drET4kAfnJG+P1NFSSzfsZENN0aEiTrF4rqMlcCZJGePkTGX0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTSn+gYmDwykXGDiIjzhOJg4xjSNyWo0SVw5jRn/y5RECKKtUk
 KmAVIgpNx65uJiwfqsm4//vjfZnaXrWZ10U9OwyxuHzJKQUZdIVP+oc0MRFy6Dca+Zom6nZD6fx
 6jVQ+wcQfgw3mxUW54EUGrHQXyQOfISAjURdoYvEb7lFsJ+UmSosBm+HXkSATb4cWh9J3wS4=
X-Gm-Gg: ATEYQzyNmldv9SKHpm34bqVfmg8PvXw+AmIMWRSbMAY20w0HDOQHrpLgwgI8buoUNLq
 GsQiwCzrIg0DeZVxDOfptJlQ0+a3NdijnlBfBzkJ9EXF3IpkqE+/4vdsdBkrVBX5P6Pf5arCSrO
 Klhc+gw+pNj/8FIT3oj9KzSMoF1FB9kldOug/0Ur3y/2Vm4i4b/ia4KhM9pti7FVkJ2+JtmoR05
 1xIULef27hgLSu0FfJvwcguEU1ywihgL5qIvF1WhCeiV+UcvhZqqaQLckbGyTzvVwUonhlKOB++
 ZnKmq1ha9rWoGvhvgIhLNS1fhfXDHVOI/0gFbmBlulGRTDUWEKHaIdWz/79H8TIVDJrqvj254+t
 VGNpkun/WkxlnQ5CU1DOU9krjsk+80AuTeL0QeoI/q4PTXHJudvLtwOCLq8TBRsIqqLx5iZCwmr
 KLL3E=
X-Received: by 2002:a05:622a:1386:b0:50b:92cc:f879 with SMTP id
 d75a77b69052e-50ba39655dcmr17410831cf.7.1774607686171; 
 Fri, 27 Mar 2026 03:34:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1386:b0:50b:92cc:f879 with SMTP id
 d75a77b69052e-50ba39655dcmr17410601cf.7.1774607685717; 
 Fri, 27 Mar 2026 03:34:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b2021854fsm236805266b.4.2026.03.27.03.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 03:34:44 -0700 (PDT)
Message-ID: <ac26b598-78ab-4cff-8fb2-a1d657b1c478@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] drm/msm/a6xx: Add support for Debug HFI Q
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
 <20260327-a8xx-gpu-batch2-v2-7-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-7-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3NiBTYWx0ZWRfXwpcfjdSFsLxt
 Nu2MoaFDwtLjMuxWNBYatq6v98FIfumXJQ6XJ8pH6NrANpdNehyYJcXFd874DnvLSVb5bpvCp2w
 Bo8lnIRZABCXOY7oIUdGbhMUAuUAMovH7aYSOkfFS1xc9j7by3QbpUN+4G0rlKkSr40ZhfxCh1Z
 owBztKat5/PzCLgtBpq3fcwB4QBfehd8XGlLGmROEuN8sruxnW6djnbBG84xxJ/BxX7Lb3J/E7M
 MqN9lFZ2PoVpT8vd9UKZgck53R2/irs9stPkewqNwjX4ykXS28jSQtSmNBW3RkWSlRdicm0FWkY
 P7eMSm+HuWK147oPWMM57TLslxmsVO0XV6OBeZXkJhiBYGh8F2jq6C1wv/edDU4Bls9ru8IQdGw
 QvC5ynTyaA+j5j0N3nMXnpZrj5pI0h/olLSuAfLfaxVmS5V0Ow/aAB9NXHgpgUjbOWrA66vT3Md
 Q6tIz0hho0jQTBCeMIw==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c65d46 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=NOWTvYqtYlfs-YhqgjEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: EXezy_sujguaai2G-Uq5ZU2Wtt7kAmOK
X-Proofpoint-GUID: EXezy_sujguaai2G-Uq5ZU2Wtt7kAmOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270076
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

On 3/27/26 1:13 AM, Akhil P Oommen wrote:
> Add the Debug HFI Queue which contains the F2H messages posted from the
> GMU firmware. Having this data in coredump is useful to debug firmware
> issues.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
