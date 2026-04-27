Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D552FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DF710E2B2;
	Mon, 27 Apr 2026 13:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/1r81SI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UvRFtafx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A20D10E744
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:13:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TBLP665664
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s3iVNUw12SY/X8URiLbb1cnOLSTbe21tBccpKnto7BQ=; b=Q/1r81SIHBKGczY8
 zdRb4t6sOXXPx3fNhFO2/xgtH1U9uCWmcvLC3IcJ0JRWHo+jsF5pLJANwhJ/6Pp0
 hUZIvOcQCkWXj+ILELYT51emAlIZXTr/aBByLFxr92ay/pQHAXAGzhdnepSSkx8G
 fpUO/RAT6+V94Odn0prXVJtlp8mdyMZKk0UUkA/QU6mwK/Hzn/noCAklCvLzNAUe
 S23Zz4sc+KeQhREQ863iVVSl1dh0lk2G/s1JfCqF6f9aOb+gN8NxVtZ0mcymyWnF
 BkYIJOMTqVBFGHAISfEiYNCY79CLFN4oFL7HAFzlPyTU3boygqN7wtGmCrUXlI2T
 zRgUIA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n1gya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:13:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56ee3caacf5so719826e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777295618; x=1777900418;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s3iVNUw12SY/X8URiLbb1cnOLSTbe21tBccpKnto7BQ=;
 b=UvRFtafxv/4u4HRJhsdq/56Da/QLEPvnhwYX98tVgOo4yrqUBvwyj2cQhkFM6+g/ur
 2VvNk/nTtFsMnRg20njMdz3AD4kIeYsCDiAQSCKvHlqt3pH8nndyl+PkvW4YFvg6FdDC
 0HLs/er8Mcc/hnll8RrDlR0oQagCy27HjR67vTMlwu6ErmXsoafT87KajXqajhJ0YDmg
 iGrLI/+kXQ0KxvpAKgRb+RV48RQC944LT0LterAx16UMiWdwg9rEjj4wOlQf2dsVOa6Q
 oUuchVK7FcTlHggOBBLtCzApe4gLm8VguVaz4qlBs28qlViZ+Uu1GP+3AYVmxyEoeHEy
 Gb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295618; x=1777900418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3iVNUw12SY/X8URiLbb1cnOLSTbe21tBccpKnto7BQ=;
 b=cxAAX5uKdcRjvuRMoMJ5No//EBJOdy3tJwicseP9sKlG3oHa+cv7j7ss3nos9GBg7V
 1Z0zKHT+zCP2AbwHhLsUw0/5lY/2lC7Nq7jIpz02Kj+AeBC0yl4jBZWUeiLc2UveKrm7
 39/NmXG4ITUH0pa3wd111BOPLvQMFtoiqRG+N9G0/tKIAg+E30IrjCUSoLifRj1LyEye
 ExRD17pYMzQwZ2FLb6QJafOdltwT4j7vyxFDedPH8uaSTkuAXxqoOueFw/oG92Qoe4XP
 UHUpbgSBsUhcTvU3qyvxrXIBFjIVmyc+jrsW/MJsmN/TUt+H3/iYfBiunB+ivqh4AHqt
 cQJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9D+bPPJPIXMGjYCromwkYDov1fgzko43YPWbS+R1SMf1M0Kdx9HdTYqxGZG5nmtv/w7F+qrlIW/wQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmAGwVwuhRi4SmkwFA3/uEwtWDQ/YfkgVgGS4A11IfbtiQufNN
 +Tdsb3lOPXya4rnsgLFTwsdsM5pbX3cYPhgDXnfoK0V/i/OmWFXsQYPBsAApx0IwpjJ6whp4mSr
 WcLAaI5OlfcdYJi8njrXgWe0R6UGTjViNCCEH6TtyAt13xIzGpZQx6Vin5zHM/g5tNP9pzsw=
X-Gm-Gg: AeBDietRows6KjXA61yJtY52b7wDr/ZdsQfkAseOWCeW+r3oM6kZSOmvi3VSAjUwPdZ
 5X0xcFh+GjjT+PrKJFjbQqehcDHT+LYucjEO5u1OPjMvgNTLSLneIavbxauH6v7jfTd7YibWlsp
 JWUeU6y84x41mG2NNRpcyDEAg1/ECLl+Mi4pmVtuR6iDuelvsHIycbGPyPmo3l5VWzF1DIl/ZBb
 LBrmPDxZ37zFeUWIn7xvGYUam/XHf9zCjhu71zR6ua4w1CU/DVtEzK3UgvV4qr22K7jvujPRC2A
 j8fobpP5vnA3FroOGxK1H6AX/UHIR6h6xmpLGZWXGwmlnnr8JtECIILJ7CnUDp+CjUHMoOzzcnj
 tppyY+fHe6L/Y0sOjmoKEV0HAjhl8zh9mldksamYSD4yeknnjsmoqVkwkMEwJRfvaWc5AgPUClz
 ylCGiLBqP7HyUXAA==
X-Received: by 2002:a05:6102:292a:b0:602:7589:6536 with SMTP id
 ada2fe7eead31-616f4c5b722mr8143759137.2.1777295618074; 
 Mon, 27 Apr 2026 06:13:38 -0700 (PDT)
X-Received: by 2002:a05:6102:292a:b0:602:7589:6536 with SMTP id
 ada2fe7eead31-616f4c5b722mr8143744137.2.1777295617483; 
 Mon, 27 Apr 2026 06:13:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba4517ec776sm1140081466b.16.2026.04.27.06.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 06:13:36 -0700 (PDT)
Message-ID: <b8cdcf95-7fb0-4d53-82fa-c7d1e986af92@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 15:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] clk: qcom: gdsc: Add custom disable callback for
 GX GDSC
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
 <20260427-gfx-clk-fixes-v2-1-797e54b3d464@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-1-797e54b3d464@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MCBTYWx0ZWRfXy5P+cFs5bKjD
 Jqs4l9OzP13xgNAWfw8X9WGNHjKu9J6KD0QrxuO/g4oXWKfGiEAFsplQIGGPzfNfO5nGVjHRD7V
 yj61sw8WLSK+8qJIQW45OHG1v6hMNeH5r5ihTIuFl1wewjXAKA3PWqxMpOueTLc+86cTXdA4DSJ
 q33Kb3hixzbctTSOyedCEc3/gz/+tgwKVVUXVTLeuf2DzhGL7pdgtN3e40R+8qTdCojXocNf3jG
 +DX4/es58pDn46FxQaHI6Fme5SF71LfBMqKJxvMZ0vGaB7MTFD0uBm8d5VVf2K1VhpJw0NJiF6s
 dMn0WwR4b8mrNlKtqdeVgcrXLrYUBJ9uxdFFTuqAPagwRRGiedZxf/ctUugdvHM1SvDpDszu9Td
 v/l3IpHMf2JZvwrxUzTjuleiylVbNi8MgCbj7UwwCwpZkX+80LgTlJalFBRw9skso8uquV9/Zaw
 xQeKGXia+RSOtfXoFCw==
X-Proofpoint-GUID: Xc2J6Ed1awHpq3AV3IK7GRHd5vdvJNaM
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef6103 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=aB4qEwVHbqlS5mOuu88A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: Xc2J6Ed1awHpq3AV3IK7GRHd5vdvJNaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270140
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

On 4/27/26 8:38 AM, Taniya Das wrote:
> From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
> 
> The GX GDSC is a special power domain that should only be disabled
> by OS during GMU recovery. In all other scenarios, the GMU firmware
> is responsible for handling its disable sequence, and OS must not
> interfere.
> 
> During the resume_noirq() phase of system resume, the GenPD framework
> enables all power domains and later disables them in the complete()
> phase if there are no active votes from OS. This behavior can
> incorrectly disable the GX GDSC while the GMU firmware is still using
> it.
> 
> To prevent this, implement a custom disable callback for GX GDSC that
> relies on GenPD’s synced_poweroff flag. The GMU driver sets this flag
> only during recovery, allowing OS to explicitly disable GX GDSC in
> hardware in that case. In all other situations, the disable callback
> will avoid touching GX GDSC hardware.
> 
> Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
