Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B544C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F09510EBFD;
	Tue,  7 Jul 2026 08:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2h4gFwU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QCJAiSFr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAFF10EBFD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:41:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678EE2Z3203455
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 08:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T/aFwVhqAGc0ZbZI9x0aiPx8X3rURaDkbGwWbnLHtE8=; b=I2h4gFwU+DniJ4AS
 I91DXHqeGqDegN3b98/ME1S4lHUcHux6a+mV81sSLsHSjLylYglx2/w/5qDHd+ol
 HF0zsqAyi7+hb/q69X8Jpg00yWpQJmFWn2xYqWrnnb4jQ/caRQdTo2sBdnEvBOJx
 shzzooXfsKpgIZ3W7kYt7Qtg2YQ3tVOtVCSLNO7WTi0ogZqh1ZL0njIPq2Ekx28r
 tdo9WfgNDu94+IU3vy6pzlKrPRI+1NJd2NI7xOACyRDnXoZrO/Yn8LPq5xXfOkKq
 ISh1NjzAp8nhQsFyyHOMM+uajbYVla7wxSJNH+zLr8BfwxKHghtfp2CcT3wQ3Lrt
 CYw5eA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a8hhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:41:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so4234344a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413665; x=1784018465;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T/aFwVhqAGc0ZbZI9x0aiPx8X3rURaDkbGwWbnLHtE8=;
 b=QCJAiSFrPsnS0EMbR1eaTKMIZeJ8GBCiSt+2iwsP8ijkIr3xXUI5nUn4IhAwy/tHOG
 kbUaKliJfM6m7jWmTs7K4zv2bq6Vf5Jox96NZrSSEKHnMI7WyDMijDAjQ4q3JAlhvqJ2
 M99Ox5iXkH015SmV0bW+zKD0p1BNa3QznyZZ5saCS4FJGMO35lQH1T23io/7muJgLc6J
 eWrcyx0W9R60mJNcwO+UNkR8TGrU0lgYljwJAFzP1OMdGgmKAomFSFAFNlIC9TXTa+up
 4HryLgeh4SDspukvWR5TWm+b8IBWuE7Q5aLH704fiYABwv9LdIvaqOERik5sbtpPNfPg
 lcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413665; x=1784018465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T/aFwVhqAGc0ZbZI9x0aiPx8X3rURaDkbGwWbnLHtE8=;
 b=D3MAbjz81wMO5TLCJMJtUs0a313EnBE2eMyJBgYYte7RyzlVSnxeNk5DOYWy8pgC56
 drYqTQHAlt2gQnYBoRprhxx6pif+LK/eQ86CPDBhtlPJywBcBeO3QnU8dgMZ0w2LA8yU
 Lh5wjbXpfozkBCIvpS+P5LW95M8I6FvKCRdDmZzoSDCwSh0/dhmiYwK0kMTPSkkTo0KW
 BvnOdyXyDQ/qxfw3HJVHsKjeUxjtOo9IWEyui/D4xEC0IUdLHzUG4EOT8eBbIBd4QSoo
 jHC4dldiILwCxIzt35LVxUiRc1vrjuVQ2WcJHGNukrGkHuuM65Trx6aUSoUfdkDzlcF1
 QjQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTvXSFHHtxNrh4+LBKmzdU/Zh/uCUqzOx+h9xezC1MEjE5Vr6dOAfaCk2g+WbjOtr/mOmo3Ddzo5Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxsi3Nsbi/hRIonALUPs4SGAfDhs/zOc9LZUT1+Yv90dNvadw5h
 X4EU1kQwlUkD3MQxlebTqgZR9oCBQgMAhnGhCje6yFQAa1a+swwbRsWyES/oZVw32s8KG2XfmtN
 swpdds0Bb/gixJnZIXqVZqh14WT5NMGo385KwlXjnZRxljYQ+ReMIBJzagKVxCTVq6Svnz+I=
X-Gm-Gg: AfdE7cm3WzeuxRComnRFJ+T1DbnAl6u3+1hU3aH99cu4hZS1Omk/EZBgIsZG/EE9n42
 h0aJtUuVf3wot8eLYB1fPIP9TPpzEI0sho2yqiPVVAxToDIrurTNG9H3XdwVLhWKCS/FA4lSReE
 oaqDcf3VUfYHnwruIE1g//yEYOM+PzG5jnVh1ddvI0jA8bchj0PsSfY/4MQckr0z4blbA6dEqvv
 Vw6BwXRGlm2Yc08O6SWeHF/e+LVh0wIXdVgvTeM+E5aAG9f9JMLFtATWMlWsOTdq+CksDWckOG/
 i1E06D1hgbalTVHscujTwoQQVmTw1ORxPuSBMsN5oob/FTZZqRWgTwMB2ZoRXI09KLObyIPqJ1r
 wLUqbUmBXv/wuvtoe3QZMr4eMCyVwVV0NMaQ4u/WMRw==
X-Received: by 2002:a17:90b:2e48:b0:384:8a11:33eb with SMTP id
 98e67ed59e1d1-387575abe72mr4559435a91.24.1783413665184; 
 Tue, 07 Jul 2026 01:41:05 -0700 (PDT)
X-Received: by 2002:a17:90b:2e48:b0:384:8a11:33eb with SMTP id
 98e67ed59e1d1-387575abe72mr4559398a91.24.1783413664710; 
 Tue, 07 Jul 2026 01:41:04 -0700 (PDT)
Received: from [10.218.50.222] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d1ad7974sm708702a91.12.2026.07.07.01.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 01:41:04 -0700 (PDT)
Message-ID: <447245d3-4e79-4645-a814-9dfc52fc5bf1@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:10:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] arm64: dts: qcom: shikra: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
 <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
 <cikq6wyljzdlyuopvxno7fipifzc7f2zc6hs2ligiu5esnljui@5mxhammibgpc>
Content-Language: en-US
From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
In-Reply-To: <cikq6wyljzdlyuopvxno7fipifzc7f2zc6hs2ligiu5esnljui@5mxhammibgpc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Q6t0UoJNwcRs_qrxWBo5_X4f4NB-2v4T
X-Proofpoint-ORIG-GUID: Q6t0UoJNwcRs_qrxWBo5_X4f4NB-2v4T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX4V9SqvFEuhLy
 a8gRJ2qI/PDb/tGObYn9eyUsOLCIxJzIMy25M+bF+lbvjGYwOZmHBxXnYiT3DxAcs8nlvt6uHNX
 LVzV+kB88JFEdIzjNW4WoE0cfwJvGzg=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4cbba2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=agT521uulj5WE4s-WisA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX4AeDl3xyox58
 zDulNYV6J2d2d+mHfkqmyd3Vsyp1WY+e9uO8r7P9taozq0PAsoEjQEuHpm9sj7QLb4NPyHfM17x
 RvEGXhotjMgwhHRXTyzrRLIeuj722t96ou9WjpOtZZlWF9pvCjTY5dUaRrdXbFh/rTDdlR5PUx/
 mncOczIqO4HZMw/rE0Qt4KNn3VEUOQd5wAF2lqgeeolfx8EoeLMhVe20oeQ0rmWf5BbEaurBvsa
 hPy3slQwhbJ+GVc4xus32QZ3Yxd8TJIgGfHVDqpLinNUM31wXFktyHs74Dl5uPxV2QnwcxGvqYo
 AuK5jQhiNmaXajQbQnUuFv4xHeSugD+imagQJ4zwhjHwt5FETXNbgC86m7B5wS3ttxOnlFI2580
 xrpMCgRAUmomdZ8dF+FrTF/0Ue3s7vEsdereJ9KF0xuBdF//KYOmr1DQIPfKw7EB1zrXqWg6mu+
 SYAu/lyeK4arGvqnY+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070083
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



On 7/7/2026 2:58 AM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 02:34:38AM +0530, Akhil P Oommen wrote:
>> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>> reaches high temperatures.
>>
>> Set up GPU cooling by throttling the GPU speed when reaching 115°C. And
>> use a passive polling delay to ensure more than one "passive" thermal
>> point is considered when throttling the GPU thermal zones.
> 
> I'm not sure I can parse this sentence. How does polling delay affect
> number of thermal points to be considered?

Thanks for the review. The commit message was unclear, apologies.
Without passive_delay, the governor fires only on trip crossing interrupts.

Can we use something like below in commit message:
"Without passive_delay, the governor fires only on trip crossing
interrupts. Temperature stabilizing between two trips generates
no interrupt, so not all cooling levels are applied. Set
passive_delay to enable periodic polling to ensure all cooling
is applied."

> 
>>
>> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
> 

-- 
Thanks & Regards,
Aastha Pandey

