Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5D5C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F78210E451;
	Wed, 22 Jul 2026 09:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DM6M3o/B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JaArU2hq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9BD10E441
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:27:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x4qI1400157
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GmXXSLuM+65AEjIHsAa+PdHzF+2smBIWId/4yRgNPeU=; b=DM6M3o/BC5qsz4we
 cdNf03ltSDaY2K9VRJ79T9yQS9IAn9ldHSwK2pjIrg72Pb7vO06yENIzro0aCY0f
 8J2GJ9W8ULSD3hr0LQ3NypFN6jnhBqJJJAzXva78MAMVLgWr2Ac1zkNxLa/uCUF5
 bAhl/E+b4ihgf1AjHXI5olaeUO8ZbCeODvg7tolNYt1zyXS0hWD3aTgGnw/SqXD4
 kgQk8oVkBX7wiXn7NdfiatXcnalbIDiHStdHEvhRhEdyGBFYOPZGusmAaiOKCyoE
 R9RmRvILPbWzrmA1HI1ICMGaXtzpsbN1erj+G8UwJL1X/JFnF0Yr4zPYES0+bDTy
 Py36dg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr838ube-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:27:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c27616421so34093351cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784712423; x=1785317223;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GmXXSLuM+65AEjIHsAa+PdHzF+2smBIWId/4yRgNPeU=;
 b=JaArU2hqlsqsND9tnfnn9Ezg18yDVNEq0/yHv2oIqk9RYy+7/H1MvovrLOTtjZfAb2
 CrmGMrXvfmzdoO8uKQzjRRXv+tBj5FEfkjCjVpQHKvbMho1uBG47PaUdbRk4v2OZoGPI
 rB2qqX9J1x9vnip/dQIJeh4gwNP+AeHylpQ632FuqZ5M41uPyH0kGPUTKsKpJJynK77t
 wZxcahReMWUvBkeellWeSjWqxd5PoKGPIZSWdOrayHSZdOwnVrfqhRo6v/vm+fd1mAcm
 GnL5yTaCQa1jfepKE/ERCeIg1GoKN0hwYZIKLyyAoSZ3U6YMFOX/BjVe0LJE8HloCJoz
 3d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784712423; x=1785317223;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GmXXSLuM+65AEjIHsAa+PdHzF+2smBIWId/4yRgNPeU=;
 b=XFahjtQ5DuP7G8LpjjRNYNW2jI29H2MjOqwdt1wvCNYfGCJWIdy/HCLespVSU0LwVQ
 cfeT7wcZsENqWgQm3EReSHSprR6lD/6KM/TaiGqDjN6Zj8eZXHQmp/qCB55zU1q3lkju
 VCMc7xggWD+XO2yGEWZ3Hok6z9Bz57FexQSFF5SZ9cVwSLTbD/DwK5keVXerRZLz5nc8
 n19pZBOTiA0cxYsCL7CzgSHWkN9t4fgoSumrrKgvzT0DuTJwZ1osWx0r+Rh6rnUlE4R4
 2RL1dgiLryDJN4QVUrlKqG5Li8uJBhjQQz8mKJYGZu82o1PeD9qLOVu3T2oaDvyeefl3
 vYHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RraO6BuaVH6w/1D4SRojg5Es1XY0/3d/bJyCLSXmWTq2AEbAtkFCPFUxL4UMnhNH+6O/NM71iZhLHc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrU2x9B20cPhiSpLueTxjGZD22GB9sSHzeFI6pp3mv3fruyFqg
 NtdtQRzAVrsAcPpeQ0kCSBIz5sba7ttp581p4jPvrVy58mo9mAPjHHdFtVtRMzyWCfN10qiXGPp
 +mgiwvXJ3UpAc+h1oIFdyzQ25UCLYl3wfBPH/M4ObyQP9vapcea6AEKP2xqfrM/7Xsm+nq5w=
X-Gm-Gg: AR+sD10m3aiAVaknDTgMZOwPSY+uQRU+zw/Si0Cmyq2CNkFMHZpUIQC/Ty/PdaJbh5e
 bBujxTI0u4hhc9WmhBF9YhlaUsViQS/PNBTkiJBfWogDdeCGhr6USF4s6QytneaM6QZqjIlHqxe
 guuqY5vSswrT8/fz0EMoszJ+MdmgEK/CcEhcdP5mZZGjeB52PQrDFFX1W5dz8VqLzRYqymYaGhg
 yxzG0wEIYtRiwxZPF4iqdgF9VwniDhV7Mw4aQ5kVodFDoUJ8ePLIFTik17zwLw27X5qGDvEoFI4
 b+EqNWelCdqgZ63fPLhROCKg+n4WcysRvvZ5t+Wm15DUJv1Sb5n9KHW5Ug92RpAAguxeE2ASa0t
 UQbgQYeBuasw5RxFh7A5bKVV5
X-Received: by 2002:a05:620a:2548:b0:930:a08c:cf9c with SMTP id
 af79cd13be357-930e6f6532cmr568151485a.2.1784712422592; 
 Wed, 22 Jul 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2548:b0:930:a08c:cf9c with SMTP id
 af79cd13be357-930e6f6532cmr568148085a.2.1784712422027; 
 Wed, 22 Jul 2026 02:27:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c903c2sm76219766b.32.2026.07.22.02.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 02:27:00 -0700 (PDT)
Message-ID: <b8f316f7-0036-4d10-987f-c43d60dae854@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 11:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev
Cc: Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
 <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
 <20260721124005.E00041F00A3A@smtp.kernel.org>
 <6rmntcmouwenb3t5xk5rh2rijd3sc3re5m4aeuqive3wifn6ux@hauua7ltycvj>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6rmntcmouwenb3t5xk5rh2rijd3sc3re5m4aeuqive3wifn6ux@hauua7ltycvj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wgQiy-3epOrPLm69JnmySPySVQ9cok9F
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a608ce7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Ey9pX4ziOnSd-lTtWQwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: wgQiy-3epOrPLm69JnmySPySVQ9cok9F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4OCBTYWx0ZWRfX0r/pkK5TkLpU
 6VQToegsh+yA5p4lK4wrxbcnoBMyNqWJYkFrD86D+GM6RRrSHZFGdKINT4lFvLN0JrwLCRJ9tdN
 pwJ+iKDRMDKdp/xIkFhA2zm+kTvs4TvRnJZ8LjVpKGbfKq6uMM+CU08OYhq7YL2d6vQSnwhlc/y
 LTJKB6d/EX8F/MM1+HdNSrS7VAe2F9zxQ/joCEmKzuSJ3Lh5yxI7jOKtSNYLLGx/4lzw67ldtjC
 H9qoqU/yGQVXhCu38vUfXG6yPNywjPXBpwHEEs7+JUzbdma+lx2wsb67LAmsCWLjVy2IORO1R2v
 EEGpoVLkdsD0K3oKjU2hEEDcWLVlLxSCKKberWZ8ure2RVh9O08U78lHiW8Vi142WIJKTcZpROd
 tMe93WdcZtfeYOmajGTbmJ7OLx8ntbDnD82HzJrFbRYtxtukqrMazIyPDAXUVybAC5RMxr23Gqi
 NXLCRwtCmpQ6OQ3tDlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4OCBTYWx0ZWRfX6+F41nxhkMdZ
 d8JqapuVRbmiaBRyqKbs1Tr2KPz9bCAEiIbGTaVVgIHhYSzQfvbwScEwGfnm2QdqrkJKPCfYYlj
 d6JtA9jklDvDoO3eFB5MJ+YwqC5emTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220088
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

On 7/21/26 3:40 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 21, 2026 at 12:40:05PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] A race condition between SMEM probing and `qcom_ubwc_config_get_data()` can cause the driver to bypass probe deferral, incorrectly fall back to default UBWC data, and return mismatched configurations to concurrent callers.
>> - [Low] Missing Kconfig dependency on QCOM_SMEM causes linker errors when QCOM_UBWC_CONFIG is selected but QCOM_SMEM is disabled or built as a module.
>> --
>>
>>> @@ -178,9 +195,30 @@ const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
>>>  		return ERR_PTR(-EINVAL);
>>>  	}
>>>  
>>> -	return data;
>>> +	hbb = qcom_smem_dram_get_hbb();
>>
>> [Severity: High]
>> Can a race condition occur between SMEM probing and this function, causing
>> it to bypass probe deferral and use incorrect default data?
>>
>> In drivers/soc/qcom/smem.c:qcom_smem_probe(), the global __smem pointer is
>> published before the DRAM data is populated:
>>
>> drivers/soc/qcom/smem.c:qcom_smem_probe() {
>>     ...
>>     __smem = smem;
>>     ...
>>     smem->debugfs_dir = smem_dram_parse(smem->dev);
>>     ...
>> }
>>
>> If a driver calls qcom_ubwc_config_get_data() concurrently during this
>> window, qcom_smem_is_available() would return true, but
>> qcom_smem_dram_get_hbb() would return -ENODATA because __dram is not
>> populated yet.
> 
> I think this must be addressed, the DRAM data should be parsed before
> setting __semem pointer.

The DRAM parser uses qcom_smem_get(), which relies upon that global being
set. I suppose one way to fix it would be to initialize __dram to
PTR_ERR(-EPROBE_DEFER) and returning that if we need to, but then we
go further down the hole of needing to assure all these getters are only
called from defer-safe functions

Konrad
