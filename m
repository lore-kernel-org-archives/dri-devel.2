Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCE9C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A955610ED2A;
	Tue,  2 Jun 2026 08:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eh9NF2Wk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5HVLmwZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F298F10ED28
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:03:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65218kQI3430258
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 08:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z2SH3tRYNqCdFVw1uC5sP1qyrvHciyAIFwzdinJEUYA=; b=Eh9NF2WknlSyINld
 eVIF021KSp0UjyVLCnlEdPWv6fGALXxwaR3hjkgdkRbeJvD3MPtPqP+Y3fE3mwIs
 MBHu/4ZHill9BS9qkj1QqcwB2xLSlRQRssp4tmZWfvoB14C+YCdBMpPyvE0RihrS
 cWC40osBtX3MstedUg8HWCDlm8UsPb76xp8oefRkVwqZYHcewbrUim7toUWR964c
 jaIc5xjh/6qsnD7KTTNAyanb9tR5sdjReNKQBbfIJvzc4LOeCMNkveIn+gfHKs1u
 dewKoojD3cLYODlZobHzNYebn2J7DjS3OMECavv/b/oNAN+fwL9LG5IbIzTlk4Lm
 vWI9LQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mhd94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 08:03:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d98b76d12so1645583a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780387406; x=1780992206;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2SH3tRYNqCdFVw1uC5sP1qyrvHciyAIFwzdinJEUYA=;
 b=I5HVLmwZR+BOnTu6fq0imx2LHKDazg6+jMoA0quoqmD0G37qgchNLt4kudxqnch5q4
 9fnO3SNRXPc4EVb9bpOdpZEPlV+T763WRndpacWD2BJjKRHxYQixRZxSLxq+jGF64JeL
 z5SaYWUmYxY/zQEDILp/kSmpgKwFxkUdAxW2MiUhZQkk6iZlUxXLV0QqZ9v2j1QBDKcG
 k9w8g27V6ZY45kf4ZlLiHWD+EkFbTrZaifZ73pT1OsLd1UuJeQByrbYoRYjoHCpv6vsW
 QMGXZOrZOXPZ70N3or/lYCnlit7EODmQa98WaMJOiFe7GXdI+AvosBGpafVC2/UgJX9t
 92jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780387406; x=1780992206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2SH3tRYNqCdFVw1uC5sP1qyrvHciyAIFwzdinJEUYA=;
 b=cCIjzXAPjou2dlvq3GbkIbfvXOVJgCi9sX0eo9UojRWXU5KDQQVlSkSakIepwdnrv1
 WmzUWeqXK0uob+fhGQjEM6ke/aSV0en08yhXZOduvn94fIQh/jJgss0GctQCYcPdJs4p
 6n5ju0x/u/8l1DlLAvAndrqYQEBkZ3t4Uf+aAcrG6Jdpjxu1tcPOwSMqVQBf9QAeDaCp
 IbRQP2x9iPtVPkUTtaZhou150iBjrHYYY/EIcSH8r3ED86IP60vDry/gmmOjHttOAfp6
 +xF5X3tiYHOJ+UrXY5RtQvaqo+nspGXw2wUaal8xJoSgfxwja4qK9zA9auTgO+FCx5q3
 0qMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9fhIpBLwdfahveKitdfZgHIcgZMHG4b8kCNDk9lrc6bU4jcnN7XtWvw+BKRI5U8ZLTmygK1qUI4w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4zqR5nljzL19s2sg7guLiXatpuRNZ5IBI8/MFg3ZWNrW99VHm
 3Q5LX5d2HuJmHncM1EWv6KLnHRdG0kcc0PuDkcSV9GDLZcJwBKxfZl6/5yRgq/OYXSwa3ijrfo7
 IzN05xAnqQBi8k38UjnWXPSTkz8QffkfFT5P+CF805+s5xPGpIjyAz/le1DOFJLT5FAbNoIQ=
X-Gm-Gg: Acq92OGKPzKZ1kD5xvVh0XJagbZsdT+DTFSMLXsiKJlH/v0XCnZe+GCMLIT41SlJ1U4
 pudTEha2/SY85yj1Cv8GppR8XlCqBkBhi9vHf0vw3KX1Tyg/4mIS9Gc3GjTRqhhNrJkfw60Q1M0
 N5mR1IH5JRKNZK/25dciDEUU/9LFA5xKMDh7aykUmZ4by+UhMx3VscnLhk3nJ5G1jDCNWIbwnhM
 GNAjhrDHRq6xZhOICCBHInAj6Kn+zMCAMmdVjcgcg2yGYXcPdPagDfOdnfclNzLDlWauun+3Ld2
 tXd9IXR71IXeA0VXwIoXHp+WRz+vneGXMdIBDOAKU/DZQ9K1e99xNF4vARVZkLdqTjQm/pvtWI6
 qUUKahcmV3Uw+bxLdqp6MkRxUU2TL0RKYomqSXVnAir42V7jdsM7gRFje+e9nQI4JLaJVWWQ29Z
 +WrhzSoLqJpSIWoONaVeQkse/y17I=
X-Received: by 2002:a17:90b:2f90:b0:368:cefe:ddd0 with SMTP id
 98e67ed59e1d1-36c501dff2amr14144984a91.15.1780387405779; 
 Tue, 02 Jun 2026 01:03:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2f90:b0:368:cefe:ddd0 with SMTP id
 98e67ed59e1d1-36c501dff2amr14144931a91.15.1780387405184; 
 Tue, 02 Jun 2026 01:03:25 -0700 (PDT)
Received: from [10.133.33.92] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd9183368sm1918918a91.3.2026.06.02.01.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 01:03:24 -0700 (PDT)
Message-ID: <88eb2a17-99f2-4553-b3f6-e4b5b1c19d18@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 16:03:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-4-a9221c1f1f3b@oss.qualcomm.com>
 <nop7uyplq643ps4naczmrqhukeiuvfxllutmaz2sbohrnxk6ko@pr7emfe5panj>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <nop7uyplq643ps4naczmrqhukeiuvfxllutmaz2sbohrnxk6ko@pr7emfe5panj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA3NCBTYWx0ZWRfXxCAQWvHL0AWx
 fHKtg2DlUitc5chyVYWsnnamOWdd6vG4jl3LToBIR26l4qHelbPJu8jN3CJ5gzHuGfbG8vIa2Ev
 AS4vAx/d9JQNhR3hHT3BWcy163QBy4C7oqEvjQktzhTqb0x3ED/6exHqENF7SGns9TgIzmZSn1z
 8b9QH2178rVC16pXYVB6QYda4gv58U1DykHz3wTk2sq+p3N4pZ5JhUgMqRVDuXAyHIpuUWCoMd7
 8idPuoUP1S3Rb+Bmr1HWl7Mepr21nH9b/TpCAw3b+j/0CO6pYbLmvSxzF3Aexvz3BTjq42veuQG
 t9slg9QSNfKpRYh5FB3PafD4vZ3Yc+uneKAYYCtCLkiZE1FTn+LpZpxBcfmjvBKyphCbnwS0Ro3
 1+nPyCxzwU+3U4rINe4i5Wqd2nGgcUHAKgMlIBJr6BK8eYAQWOaPfmQTZibvNI4r9e1dLI4B5Rv
 ZHX+m1CfVF7mprfWOTw==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1e8e4e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=C3L6VYGqFeyMi-qQiaUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 30wcGFEp1qK_PKelptHBbmd37tXcaTyJ
X-Proofpoint-GUID: 30wcGFEp1qK_PKelptHBbmd37tXcaTyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020074
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



On 5/28/2026 11:22 PM, Dmitry Baryshkov wrote:
> On Thu, May 28, 2026 at 06:40:25PM +0800, Yongxing Mou wrote:
>> The DP_CONFIGURATION_CTRL register contains both link-level and
>> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
>> all of them together. Separate the configuration into link parts and
>> stream parts to support MST.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 47 +++++++++++++++++++++++++++-------------
>>   1 file changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 86ef8c89ad44..cc00e8d2d6c7 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -388,26 +388,45 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>>   	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>>   }
>>   
>> -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>> +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>> +					    struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	u32 config = 0, tbd;
>> +
>> +	/*
>> +	 * RMW: in SST, config_ctrl_link and config_ctrl_streams are called
>> +	 * sequentially on the same thread. In MST, caller holds mst_lock.
> 
> There is neither MST nor mst_lock. Also being called on the same thread
> means nothing, there can be another thread, executing the same code
> concurretly. Please point out that they are called only from the
> atomic_enable() callback, which is guarantted to be executed once at a
> time.
> 
Got it.. Will fix it next patch.
>> +	 */
>> +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> 

