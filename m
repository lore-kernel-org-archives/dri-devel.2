Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E2FCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24DC10E451;
	Mon, 12 Oct 2026 09:09:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A751B10E451
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:08:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8KfHu1192593
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DyRfzjcKdOQMTJdwcyuqyC6/erkqy6LTPieCsoY9kfs=; b=MoewVVoliv/zj72w
 AyfDstsmLGGvb0tsugZPgioNxgvALQ1Mj78xTITiy2Ormw13C+5bJ8rSeEDZ06To
 zUq1EWb8ZQuu4Ou/eTX+CrOPwkMAj7Xbvz66sgQ82DU2baXkg71ldb7LwGEg303S
 AHWzU/tsW4ovOCp7U3hQEF0hfvNjcvgeHI99kVheS7tcdDicFFKWw9sYaNQqICsD
 JGKoWzvagJ3AVjXjlpRcCzgaG84S+4ZCRprqKjmW+UMG5WzfhCmEUP+s5wF8lKJf
 jphYMjb/fkBSgcAcIIzefSnl5Gw3zkArw7SxPxjvdzaIWm4L3eGA8zIQa2nXsRjl
 gMoQlw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4ednk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:08:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86fa6b15ed3so2588153b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791796137; x=1792400937;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DyRfzjcKdOQMTJdwcyuqyC6/erkqy6LTPieCsoY9kfs=;
 b=CxFKpfW7TgN7BmY5j5ADPQQ4UQepkubpL+u32P6bX8aQMPk+5Cqk6iv6qS0eJdwT/a
 lG6ia8zwvk2rPHbL0ROBXgl0SXuQVyHqPYHJLyeRguN/oRqy3tcU98IxBcBoCqEpV5kz
 +lD8fqainEN0zUvhmy1xdT3e0ykZcB+1LC9h5EZZmnXYoN0Yf1ZraUIzeuypz/ITQsmv
 bdOmYewHLweyJ12stJfTp6A6fJ2c/30rjqUr1ATFonczn84C6N3lZE9ut7sZ4JY8KbnI
 eeoTY9GUtZVCrySSsT1Xn8Rm5YyAxmcFy+6iNGXxDTgHiZdsgznZqHpZKR/g95J056D0
 d9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791796137; x=1792400937;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DyRfzjcKdOQMTJdwcyuqyC6/erkqy6LTPieCsoY9kfs=;
 b=2XLjVpAJWgm/btXocvxijQy8kxrLVxaUtcqQ7ipVIN8sXXNknZdLCFt9dLRc1ktPGf
 2qNhHEgCmErK5qTxCdR8Q5rXafKEg2+Qw/KmcbB7K0iaTSmxEOx1ZXdSfpBeQ0ClNWwj
 /Am184ciCV5It+lFsNVt7hc0UPAc4JQumuZzAF/dG7IPdkDB3rS++CZKOTMSOm+YDm+H
 5x+VC9qaVoPmq4lGdTxL/JvUar7NEaNIrxfuppx1gEvoUOteVdNxs83NmfdjTcxjCbt3
 JKhpw4NtlgBfFiQnCUR5XNDX2KvL5b1tqbX9uy9gzVy0HxSTOaPjyEuJm/HZ1vT6pLzX
 xhnQ==
X-Gm-Message-State: AFq9FYL48UPTGQnZSBjAlIB+HyMoZWXGKU9Bj29blytybradCrQzm5pC
 ZWb/vsVlf6PVWWGfol0Yl6Q8Ej3x8BSGh2VRUQtfby9EEJAcm4bjjUf23+zDZNiAKvHwrGdb+nd
 F/lwtvpqAghMhb8lULTQz19Nyh68jK9dtMXu1/qFgoZlkUo4r2Xsq639AzW85THzd12h2QOk=
X-Gm-Gg: AYBFou14FWCa0t9xhTDry9O6qUUx7yD+rSPkavVrcGcFGsb+/l6lErXilGhYNlCNTd5
 g1sKSWviLhCJ0dpOKKDpkU9PVmV3JBGTJ4PTrnKkPY9WatYTz7guHX233NwL4uh+cj9v2u8TMeX
 fhzttx4n6WV4Q5M9KzHHeOQfx1NP6Ix7H4wiyu460X7D0eprKI0CyyNbVXkeJUEdFH+H66iI+wI
 LNYTrComop9iDFDQVslHnB7gCi4rbO9IMX8wukIA1wG2zmE0FrphlWy0eNKdpO1GNNF82T6+244
 EuQHbz4fC4o9A+w+IBoc9sbaLkQ+9CljRjcnO7CDpldCbWrtj/Mcefjolv+LDXM/Hb+D9+oN3+j
 nemMjNLpKSUGh7v370vCCtIEvmIF1ZhqXmHRXK8iEVuDxmGNXI+TS23K3lyb6nI7OFSdFahg=
X-Received: by 2002:a05:6a00:2383:b0:88b:cddc:4f71 with SMTP id
 d2e1a72fcca58-897c7ec8c3emr7464284b3a.37.1791796137233; 
 Mon, 12 Oct 2026 02:08:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:2383:b0:88b:cddc:4f71 with SMTP id
 d2e1a72fcca58-897c7ec8c3emr7464266b3a.37.1791796136626; 
 Mon, 12 Oct 2026 02:08:56 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3bcb9cbsm3681883b3a.28.2026.10.12.02.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:08:56 -0700 (PDT)
Message-ID: <f7e864e9-8500-430c-8f02-915a162bd2a2@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 17:08:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/35] drm/msm/dp: add support for sending VCPF packets
 in DP controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-12-4b81473185e7@oss.qualcomm.com>
 <20260929045000.55AE01F000FF@smtp.kernel.org>
 <t3klzrnzq3oicg6djkv6ixwy6oteo6c6zvnpddbqk5pjhsodoh@qz7pcou23no7>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <t3klzrnzq3oicg6djkv6ixwy6oteo6c6zvnpddbqk5pjhsodoh@qz7pcou23no7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNiBTYWx0ZWRfX9LYAQTiIMywF
 sWduW+wjHOrHlqFi5ahK68I9B2SI73ZDb9vIYJSpy2e/18+o97NVNirkclXWUYgMVdSFL41wBSg
 Qa3oGwFbePECwTudEoowhDklW/v2a4inzBnXPPmo4uhViRWFoi0j83cQGZM60zFyqqNHRFRFEjF
 dkx/P3wGgBi750FSgtGz6XFcWL5kJ1+NnxBTnxx4ZEVzsj+AX9dH0xf5NsBDRSdINpG4ocPy768
 1HzK4OLqGc2BpQa4MdTICEzcq0cpJv+aQe2ccrPy54hkiyV19rmb4mQH5wZLik55kh84FIs+pmo
 WpiBY2sBORCBbgJbBIry7sQEqEX53mBsuEEOsqkwPOGN6ebh5+nfDvL9qPzVUHqsryB2sGRgqEu
 XfHjEUkSlZbHKr0kJY3W1dAtq+lQ1J3ELVw8pU5Tq2nu81bETBxwZUWOJQwSjVtrGm5jgHAhZ2N
 pXJF0hdj7l1LiZzGy2w==
X-Proofpoint-ORIG-GUID: sL9HwKeXr_PvY9_3Iwny8nVK-vw654Fm
X-Proofpoint-GUID: sL9HwKeXr_PvY9_3Iwny8nVK-vw654Fm
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acca3a9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=61UhLNPrlPfkgRlA9uoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNiBTYWx0ZWRfXz3EIB4r+MhER
 CvNRl3qqKRGm8whUs+QQZwV+P6PgkEiOvI+x9bS9rlYDo4bzeU+MDNiVtD5g01x4p9Pt9vT1u2b
 RMP9lWBw/m8QcXVflaoVSAbr2/GC+rY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120036
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



On 10/1/2026 6:34 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 29, 2026 at 04:49:59AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] drm/msm/dp: bitwise OR of STATUS5 and STATUS7 without masking in ISR
>> --
>>
>> commit 987123505b6cfcc4664c72feae6b070ad91b79a8
>> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> drm/msm/dp: add support for sending VCPF packets in DP controller
>>
>> This commit adds support for sending VC Payload Fill (VCPF) sequences in the
>> MSM DP controller when stream symbols are absent. It introduces interrupt
>> handling for streams 0-3 using the STATUS5 and STATUS7 registers to signal
>> VCPF completion.
>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> index 9a0c9737e6d00..929e0f94f8ddb 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>
>> [ ... ]
>>
>>> @@ -2801,6 +2877,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
>>>   		ret = IRQ_HANDLED;
>>>   	}
>>>   
>>> +	isr = msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
>>> +	if (ctrl->num_pixel_clks > DP_STREAM_2)
>>> +		isr |= msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
>>> +
>>> +	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
>>> +		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {
>>
>> [Severity: Medium]
>> Does this bitwise OR of two different status registers cause false positives?
>>
>> The msm_dp_ctrl_get_mst_vcpf_interrupt_*() functions return the unmasked
>> register values. Since the values from REG_DP_INTR_STATUS5 and
>> REG_DP_INTR_STATUS7 are ORed together here, bits from one register could
>> overlap with the VCPF bits checked for the other.
>>
>> For example, if an unrelated interrupt sets bit 18 in REG_DP_INTR_STATUS5,
>> and it gets ORed into `isr`, the condition will see bit 18 set and assume
>> it's DP_INTR_MST_DP2_VCPF_SENT (which is bit 18 of REG_DP_INTR_STATUS7).
>>
>> This could cause a spurious completion of ctrl->idle_comp during a VCPF push,
>> allowing the driver to proceed while the hardware is still executing the
>> pattern.
>>
>> Should the return values of msm_dp_ctrl_get_mst_vcpf_interrupt_*() be masked
>> against their respective VCPF bits before returning, or should they be checked
>> independently instead of ORing them together?
> 
> Please respond to this comment.
> 
  Thanks for pointing this out. The issue is valid, and we will fix it 
in the next revision. >>
>>> +		complete(&ctrl->idle_comp);
>>> +		ret = IRQ_HANDLED;
>>> +	}
>>> +
>>>   	/* DP aux isr */
>>>   	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com?part=12
> 

