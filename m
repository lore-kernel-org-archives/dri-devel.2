Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABC3CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B4E10E319;
	Fri,  8 May 2026 10:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2x69sam";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZPitwT0M";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7499D10E319
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:01:19 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6486jG6C257851
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 10:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mYVViA5lER/JWv5LGE7unDaZDBq0499CdgqNysorOsY=; b=O2x69samdgWyIMd6
 7cqPL7vAlIDvOUoeFYbDyUGzGj4mcYthiSaXdA8AdmVjCNs1tQ+cazifAcfsuONV
 D/xO9oLZqKulN+fgmNTqXz9k2hLo0Y1wcAZMqsH9l/SLH/1ugLSGhL4Do7b8TZDN
 cx+STkZxEtiJez2Dr74zvaEKgnZWoPL68wfDZmSATuNOwnr0JjXX5Xnea2mPJifa
 kYPxpzgw5kdHcupJ+VRqKmJzLS+FcglOTuhYmI1/tI1s7iBTDPpkgl0cIc8IExN9
 MAKPVMqcuGjeyzQe+tt9W1cv6/o6tzCzYuGqF+BbZTR2u8Mcabe9DPCXJKhS/Xic
 QAFE7w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1auegqr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 10:01:18 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5751831fe6dso207986e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778234478; x=1778839278;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYVViA5lER/JWv5LGE7unDaZDBq0499CdgqNysorOsY=;
 b=ZPitwT0MjNiDG07GJKVlEDnE5PdCr3qfwygbL3jl0IJBDrccVfZkw8ZIYFxzXjy/Hh
 KGcq/bYigph1nU7hknP5ofJFe2ebbYfHQ3xnkDZGlyJlDNpmHtwOntbWQ85fDeySve5o
 HECuUUvgxMXxDp20HZawR/qB6txhzumiu3Dh6CzzjUNodnrofLSYxyqi48xKDAQGKZZZ
 vegPLkWTCpod0CdmnPTpPgfyx+aO+zl7RKU0lt7RP//sWD7mW/ZX+SKrak/RIeBPmQ80
 8iech04zJO6URb9Ojp6sH4VxN2t0mXaQGDD93qUDcuXohpRfPh8eaDlYW83QFn9MuQN3
 CZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234478; x=1778839278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYVViA5lER/JWv5LGE7unDaZDBq0499CdgqNysorOsY=;
 b=E082qzyEyArQTBifGGudIGlXSkA/IfY+Obr//HgF24GFISkpn5adIGQnWJI0wSi4uu
 H5q79Ia9ObV+GRMWTBNLlO09388MzeUcPkM9KFk8SRGz/BZ05or8HOfVggsNkQne/TEi
 EXcdgVoukocx+VmZB0L8zwAE3MLe1fiGYgFaTslP9MHmFkwqqbwfbj8/Aqz9uzDPXd6t
 lmw+hUFArF2DvgpcZvREPEbgtw7huT5jZY/8OJuG0P3xmFhwTqgzsFGa0v9ud268rESO
 embsrv2keu9TXTadm6dnuHWITkWJpfpeOx9VFb01++NBbkEMJpreJs53EigYxqWF4z35
 2M4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ96zL716MtVyqKHmoOx6d5NnDRtYX++9gNXhJeUHGvjLPhaK8sNttaUhkUqBqWZzU7NlaA+bZZWvdc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKEtaNZA0wSMv01aGKge2SagrunWoItxdc5eOFUNGlDs+DddLi
 lVoVSDAqPgIQhWCVPQgnXllu+JVNTq31UjzFleufWY5GVa+e22xKSbB87xDgXGslAbYOL51rSWL
 mBGW70IqQzZ3B0Ryva3siwIZ6ixxGMBnD5S3e/ogJjqrizpIiDu/SVxPojdfSxtA7RkvD+xw=
X-Gm-Gg: Acq92OEov3wNiNwjdAf8K17KZyiBSmcNj6BE7U+f9w+bB/RK1B5qjtshF1gpTIDbhy2
 JPoIvsIangq9VstSKpyegWL1p0SICft/jBg6R7WRZTW0OLhwz6WuOsswCn8jkGoo0JXSzmEVln/
 Yw+kHKlK2Rnj1VPtUK1mNp3PFHt1DjRLsx4vmPvPEkvt7kBSgnizDP96TTMpXIuReYwhtHUl0aQ
 QBoFily7oDkZBqEzHkhyEzz6gzy92COIjmcp2iFPCfSi9ma7drDIRPEdXnKCtMdQ3XBACYAmbpg
 QmxwRhtUT9IZCj3esy4Io3bu3TVNlIsADk+59bs8G4G2btQTBibOBItyjxUaNNCCtKyhqCSMxiF
 dXAk99XHjK2jS6iboxXObv3rAdt6PRDEudV9GZMFTBfXNhek0l/WZ53VCI2RMeKFnzfgEzUkm34
 gVy5s=
X-Received: by 2002:a05:6122:6214:b0:56d:baee:40 with SMTP id
 71dfb90a1353d-5755cc74085mr2303809e0c.1.1778234476543; 
 Fri, 08 May 2026 03:01:16 -0700 (PDT)
X-Received: by 2002:a05:6122:6214:b0:56d:baee:40 with SMTP id
 71dfb90a1353d-5755cc74085mr2303743e0c.1.1778234475956; 
 Fri, 08 May 2026 03:01:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcac3a7f89fsm60530266b.29.2026.05.08.03.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:01:15 -0700 (PDT)
Message-ID: <2c43e6e3-979a-4413-9026-e6ef28acd3a7@oss.qualcomm.com>
Date: Fri, 8 May 2026 12:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/29] soc: qcom: ubwc: drop macrotile_mode from the
 database
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-26-c19593d20c1d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-26-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwMyBTYWx0ZWRfX32Y8Qm+0wzNj
 4SH0Tqap6Mb/fKPFRfy3cNugD8AkkuMjcFIS/x0jiDSyUVdQ78fp0zI4P9PUFh9UPlA0TXOhRl6
 d0gIui3vDzEMukVvpxDnlnGgN7TdqsUUyECHKi9lLVO1QLvPg/KyT3qm98qfEwg5yDdJb3/7Hu/
 j8T4ofiQ3xNTAfbew3qfWjzf+POJdZBtOJZBB7FLVqyfvLD0Y/CU4AsZ0dNK8UFtPyDzXB6+mUh
 THnagafTsV/17wdhcVhrHwlwTeEcZONuFRWLH5pu0ttm4mS5Eh/ZQoTevDA1q6y+4tsLVesSS4l
 eI+h/j68/68XYQwaahpK1ngMILnedZDHs5FIcEHHC4zncu4JVdNyMBIYWaT6dtBDr/fyfW/3qFH
 djIHXrZxK1vFUHeYkSXKqwQiotMhw6lWMj0PhonGZ9eyx2CbhQzNFL5SJglldphVCTlPl5R8n9b
 SyZWyDg+gBakVV4rRHw==
X-Proofpoint-GUID: CIX1DZpbczObl0XvHdRirgGmcFyzi5QT
X-Proofpoint-ORIG-GUID: CIX1DZpbczObl0XvHdRirgGmcFyzi5QT
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fdb46e cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=I54dV6YZZfg9ki0ab94A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080103
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

On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> All the users have been migrated to using qcom_ubwc_macrotile_mode()
> instead of reading the raw value from the config structure. Drop the
> field from struct qcom_ubwc_cfg_data and replace it with the calculated
> value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
> UBWC_3_1 (with macrotile mode).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

>  static const struct qcom_ubwc_cfg_data sc8180x_data = {
> @@ -89,7 +84,6 @@ static const struct qcom_ubwc_cfg_data sc8180x_data = {
>  	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
>  			UBWC_SWIZZLE_ENABLE_LVL3,
>  	.highest_bank_bit = 16,
> -	.macrotile_mode = true,

8180 should also be 3.1

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
