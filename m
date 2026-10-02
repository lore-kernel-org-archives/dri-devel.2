Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EA3CA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D1A10E60E;
	Fri,  2 Oct 2026 21:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZR/JA4QJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjiTgqCa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B84B10E6B2
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 21:51:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692K9w762900878
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 21:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sMU6MKK0FAn2tWerO0qAxkcyuX7YPsGW1OWnSkMW9Qw=; b=ZR/JA4QJys1qmmOd
 sfIWHMrxeW9MurI4dn9r7upLneBy3rfUJbJ9K1C6mky3KbciGHyKYo4mKNgxo4zE
 GqyVIQzl4rzn2N6qaE+PpttUxhALuM73OgyK2DoLB1zPpzwK2NzaVacab50uZci4
 7b+0MM/NiV+HRnkrszmt0OI9dwM1nibJKCbP+aRCw5Alp7DW/6uxAC21dlxRJxHn
 3iuKmXgHcSrDJHDhJ+DCuI64RIBPDEmzB5Gatvf7t4LIuEqdvVXXd7BqwD0NKcGp
 qFiVq+lZWxYqxUbB+WIcsKhWg0ZlswUNTEAiHLNQeMEYmAGXd+TaTF9Jkar9vLUg
 aiSASw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj02kqs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 21:51:14 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14373747468so51260c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790977874; x=1791582674;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sMU6MKK0FAn2tWerO0qAxkcyuX7YPsGW1OWnSkMW9Qw=;
 b=UjiTgqCaGZWOkqqY5Pkz2n/eha90C+U6HIEbnb+0/tbivbo/EzOzUGkU23UN7hVBW+
 t8V7CikJfqPPvWWvsfd+QLDt1ATeAEt1YOAnLKH1Sqp9YYb+kCBBqbmq5Yr5+AGm3ead
 Nqcx8190o4HP8/eikilct7ycrfUHbCr5E5mWMdURIs5JIQsPANIpqtDIAQqnsG0U8aL0
 /+59cG1Hwu+a+iQnZr+1knM6elUwGwnc1HIvrMe+Zy8UsUYrrpWvB8P4ed1k+vLHLCpW
 pXtkfP68YiQLCsz2C3pWBiSxs0Pz3ThBujracydxh0RdpGldRZB3xAdMQt/7b+9vCwei
 3nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790977874; x=1791582674;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sMU6MKK0FAn2tWerO0qAxkcyuX7YPsGW1OWnSkMW9Qw=;
 b=qGC93+3EJnA7irAbyGWNBDLg8Q5fcn49sbEaaurp0sFsr1QxUf3AEKgVrzcLv8Ufjr
 ZYMLY2r++ostxqDUTLTZUlbrNXEPwI+ktRv+RESfOf4xC99rx8D+ORJB+DyF3WS2ynTn
 EV9Fam6uVSyhUZI2t2fUvjonPpSQUnLU0sx/1D9zx3iYp6r1QUxmwO/iEXSKriCVMofV
 KpxF75H4FyLI2E/NfDC1lCUO0bMedkBoMobbIme1trEykxzF034RLDeAtB/zYzHaNKJR
 fVoedY6J+XW9wvhHBpF9LX1LoOfSjQau7psb1UjE9/YFG7kw3MvSpb5Bs8YJ0xnmh0Gb
 XB9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByYNlVjlcQYF5mvx38vJ7FhsRWdK3JQwxYslCLk5Zu0sM8+0n/WHSz4reG7UpOdUOnbQE82/FMzBSs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mzTHZV/63tYbith+0o7YDlmGkMGkG/8xt01wI0r+EtMhIwwrr6
 XxxX7THnFadNyNcMZPFU2dXeNlv9MDh64abK/kethHTi5MhXeD8WWMDvng7lJg0gBFdKj7Q1fJo
 VGEXZlrvA8LmVxOB6F6ynCzRkotA5rD208GP/cUwfJsl2a4+eAuHG6418WQvorhKAoMlD/94=
X-Gm-Gg: AYBFou0+iv26Pd0WQLYLtdrkn34eF1oabOJAkf+tb58B8T/n+SwgBzin3oPdjWCNJxg
 9mrH+TnNFYXpSuEL2AjP1y3s2aH3qYNJZIDEfj43kmYIsjx0SMpsuzJkbuNF77qgBOoD3DDPdkr
 Hp64pnDoGb5SdOnKlYQpoNKgVZkMJs1i1OBaAafpAh2LVPEsZjRVelWkHHPWvWuINCRGGhtDjgC
 PHibiB53Q2qRkPXPwPsxDMxWxagiB2Dr2BQcmiFmwYjQoZkiRuGdqm9TzRGPDm4BURdHrCyUeqE
 2JB7xh/dbe7+4RD2JNCIBnyTeVkmKdDbMFA0YD4LuaQRilfS6MBEptaThRCCh+5TATuJlJFAYQ0
 H0jtsAs7Yi1M8+OHnKt8w8g==
X-Received: by 2002:a05:701b:2513:b0:13d:31c5:815e with SMTP id
 a92af1059eb24-151c32d97cdmr825117c88.17.1790977873860; 
 Fri, 02 Oct 2026 14:51:13 -0700 (PDT)
X-Received: by 2002:a05:701b:2513:b0:13d:31c5:815e with SMTP id
 a92af1059eb24-151c32d97cdmr825075c88.17.1790977873258; 
 Fri, 02 Oct 2026 14:51:13 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.235.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f0672c2d1sm11715212eec.4.2026.10.02.14.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 14:51:12 -0700 (PDT)
Message-ID: <9355acaf-60a1-4fc0-a27e-8195eda3aac4@oss.qualcomm.com>
Date: Sat, 3 Oct 2026 03:21:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Bjorn Andersson <andersson@kernel.org>, Oleg Keri <okerixx@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
 <ar_AuRr1eaZzOfw9@baldur>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <ar_AuRr1eaZzOfw9@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4NyBTYWx0ZWRfX40/yDmo3WwQD
 kgt4iZAvxXYZ3En9qdWxCQll1iSPnXi9Ae4UoCUmhyinXrk8YLXVt1a+gRVLhpOyYJ637hepRcI
 9VEotIn8OJ+o/iLsFeN1aIpUCFSwZRs=
X-Proofpoint-GUID: s_m2eSvK9DUMO3ijehdOJcPCuApeTlOq
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac02753 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=AE3SQRS/NFwxibvl9JJKcg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=BHwv5AXLfuIp9uWDur0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4NyBTYWx0ZWRfX5KeoELlZzrql
 IGbwbBaJpb9EQ14lUHkys7ms7LqcpyrRxzG4SZrd83Zv8hb0cqX6fyasrQ9+lCIxfJYJYmOL0k0
 1PWaAEQMIUJd7d8EyIeCQbpC4uDZ+47OrNmjrIMbh9LR5ZZWy1OAGRvYhvXn2oEQdJY+eJeR0Ff
 Mjtg+5T1lGQOt0Bm/rQCVqob61CpfBDpyB/RaxDpuw2ck/5CNiuZQCoHV+4rS5KkxJJBNWu0Crp
 pgojhNpn4hpqbfs1QchwpCX/FlqVGnoQRytE2REgkf+KkMTE2Nd0+50KIjzkmr+d1LeyWg5Ly2R
 ngooxZ+mHIxd9eD7dKbjYu/tJThD6JWh49M8wmTL7UrgmEt19yZmKa0Hiw+rcbCOYChYqW7GvQa
 c3E6SYAVuQjkw9Hqba21g9uzCv99Vbu6Ul/aBlB9RamrwCZSOre91V11nbf/IXbefV2qiLFFp0A
 D35+GZa9uwJKeaZtiUw==
X-Proofpoint-ORIG-GUID: s_m2eSvK9DUMO3ijehdOJcPCuApeTlOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020087
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



On 10/2/2026 8:08 PM, Bjorn Andersson wrote:
> On Sat, May 16, 2026 at 01:37:51AM +0530, Akhil P Oommen wrote:
>> Add the CLX domain table and the IFF/PCLX limits tables to the catalog to
>> enable CLX feature support on Adreno X2-85 GPU present in the Glymur
>> chipset.
>>
> 
> This patch landed in next-20261001 and while it works on my Glymur CRD
> (COB), on the Asus Zenbook A14 I see the following failure during boot:
> 
> [    4.843643] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt [msm]] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
> [    4.853804] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
> [    4.853878] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -110
> [    4.863980] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
> [    4.864038] platform 3d6c000.gmu: [drm:a6xx_hfi_stop [msm]] *ERROR* HFI queue 2 is not empty
> [    5.128548] ------------[ cut here ]------------
> 
> And then as one can expect there's no more GPU.
> 
> Reverting this single patch makes next-20261001 work again.
> 
> #regzb introduced: 93b6c8d10fad ("drm/msm/a8xx: Enable CLX feature on Adreno X2-85")

Could you please try this fix?

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..52cd60272870 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1241,8 +1241,12 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
                        goto done;
                }

-               ret = qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
-                                            QCOM_SCM_GPU_TSENSE_EN_REQ);
+               u32 gpu_req = QCOM_SCM_GPU_ALWAYS_EN_REQ | QCOM_SCM_GPU_TSENSE_EN_REQ;
+
+               if (adreno_gpu->info->a6xx->clx_tbl)
+                       gpu_req |= QCOM_SCM_GPU_CLX_EN_REQ;
+
+               ret = qcom_scm_gpu_init_regs(gpu_req);
                if (ret) {
                        dev_warn_once(gpu->dev->dev,
                                "SCM call failed\n");
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 86 +++++++++++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index c503912a61c7..9ad13eb173de 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1799,6 +1799,90 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
>>  };
>>  DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
>>  
>> +static const struct a6xx_hfi_clx_table_v2_cmd x285_clx_tbl = {
>> +	.version = (2 << 16) | 1,
>> +	.domain = {
>> +		/* GX DOMAIN */
>> +		{
>> +			.data = CLX_DATA(60, 11, 0, 1),
>> +			.clxt = 0,
>> +			.clxh = 0,
>> +			.urg_mode = 1,
>> +			.lkg_en = 0,
>> +			.curr_budget = 100,
>> +		},
>> +		/* MXG DOMAIN */
>> +		{
>> +			.data = CLX_DATA(60, 3, 1, 1),
>> +			.clxt = 0,
>> +			.clxh = 0,
>> +			.urg_mode = 1,
>> +			.lkg_en = 0,
>> +			.curr_budget = 100,
>> +		},
>> +	},
>> +};
>> +
>> +struct a6xx_hfi_limits_tbl x285_limits_tbl[] = {
>> +	{
>> +		.feature_id = GMU_MIT_IFF,
>> +		.domain = GMU_GX_DOMAIN,
>> +		.feature_rev = 0,
>> +		.cfg = {
>> +			.enable = 1,
>> +			.msg_path = 0,
>> +			.lkg_en = 0,
>> +			.mode = 0,
>> +			.sid = 12,
>> +			.mit_time = 5,
>> +			.curr_limit = 18000,
>> +		},
>> +	},
>> +	{
>> +		.feature_id = GMU_MIT_IFF,
>> +		.domain = GMU_MX_DOMAIN,
>> +		.feature_rev = 0,
>> +		.cfg = {
>> +			.enable = 1,
>> +			.msg_path = 0,
>> +			.lkg_en = 0,
>> +			.mode = 0,
>> +			.sid = 18,
>> +			.mit_time = 2000,
>> +			.curr_limit = 6000,
>> +		},
>> +	},
>> +	{
>> +		.feature_id = GMU_MIT_PCLX,
>> +		.domain = GMU_GX_DOMAIN,
>> +		.feature_rev = 0,
>> +		.cfg = {
>> +			.enable = 1,
>> +			.msg_path = 0,
>> +			.lkg_en = 0,
>> +			.mode = 0,
>> +			.sid = 6,
>> +			.mit_time = 3,
>> +			.curr_limit = 66000,
>> +		},
>> +	},
>> +	{
>> +		.feature_id = GMU_MIT_PCLX,
>> +		.domain = GMU_MX_DOMAIN,
>> +		.feature_rev = 0,
>> +		.cfg = {
>> +			.enable = 0,
>> +			.msg_path = 0,
>> +			.lkg_en = 0,
>> +			.mode = 0,
>> +			.sid = 6,
>> +			.mit_time = 3,
>> +			.curr_limit = 18000,
>> +		},
>> +	},
>> +};
>> +DECLARE_ADRENO_LIMITS_TABLE(x285_limits);
>> +
>>  static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
>>  	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
>>  	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
>> @@ -2227,6 +2311,8 @@ static const struct adreno_info a8xx_gpus[] = {
>>  				},
>>  				{ /* sentinel */ },
>>  			},
>> +			.clx_tbl = &x285_clx_tbl,
>> +			.limits_tbl = &x285_limits,
>>  		},
>>  		.speedbins = ADRENO_SPEEDBINS(
>>  			{ 0,   0 },
>>
>> -- 
>> 2.51.0
>>
>>

-Akhil

