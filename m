Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FCDCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D6010F51F;
	Fri, 22 May 2026 09:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTn83EGM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIT99LJU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4031610F51F
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:41:20 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8bli71657832
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fq4BHObcrvqyKiIQ1B6Cme/MxCDXFz9gmMnUXPDD2Wk=; b=bTn83EGMLABe8cQN
 /TKfn+D9uSd6l2jak2XJgHD6cxbRE6E9KW/VNiCUi7Q6yh8ybCIv85doRvFZEGih
 nZ4ZpNcAFqMZtDTbT/Jg0B6lPiIP2NDa3HddEstiNRzbdazASNnpdLOSoacviJjF
 iZGjwHKRRs7l+jOHboE/98iAGDIrB1/7sZNPqHlh1IgJID/IOCdXm9r65Nw5oxzL
 k+Nui/Fytauq6dtQYO8rlzeornbvLBBL9wdQKiaR0Mb0YlcedetQm5N9/OevRPAQ
 vQcnk8i6DOWb2QMGoS8/5FTC/87Eq86fi4Xza6xhCtbFPLpv8hLKsS7fn4APB05v
 bIXGBg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkn5mt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:41:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d9f1bccd7so17552641cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779442879; x=1780047679;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fq4BHObcrvqyKiIQ1B6Cme/MxCDXFz9gmMnUXPDD2Wk=;
 b=kIT99LJU5jishg/xeUeoqWXs1IvPE3dz8UyYZRQtSpnhr5MahlmJuTciQusk5azzHt
 ndJQRGvhXbhJw6egkGfBXRUTOaYOxMv+HqfWmHdZfWkqZzxU/RyLT/ibLDna0CgRST5x
 hM98m+S1/YwKd0HoZBQekKbqV42G0Kf6YFsbVJgoz0kp/FeqC1tkcUEX0bunHALkmZXT
 d8DuGxKON/dEQLGu6gigGHWqucfJ4gbpnLjcMZzgDdZ+WoQxJ/N5M+mGmHTzxEt9rX0r
 wDQiZ9yFk69HuFHflfw4wBM1B9kW8VMwlMElTen+H8nUFRBnx6hAKTk0e6jvYEwLPSTv
 OgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779442879; x=1780047679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fq4BHObcrvqyKiIQ1B6Cme/MxCDXFz9gmMnUXPDD2Wk=;
 b=FP/O95rUvgBa0G7yFpT11h45WsatRHfIgpER2qQeOte0cw2waxID+bM5ZmmVxr1vKr
 V0r8HtaXy0+fgP8VZvWg9LyBU3U7KfNyW3IMKLW5jFBy9HKuiuI+PhtnKJGttV8a4Jls
 RK67pPCdrCghL/xXQy+eLH6aVhIN0L3U6PYutjttolgmjoyhNrHQg52ir5YvZiZf8+Jp
 f6/HRYLPb5xBIszjTQ0VxFqfMQyuqOOfcwwKSLDM4m1qMNU3PT9edOpE3Fin+RBSZ+3V
 5ktsQA1iksntbq9M7igO60wSQSc6Yp8oePXyWPjAbRb+XxEpndGo5KyFIgAnEIuhuB22
 VjpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JKHU93ydHwlOmXSls1F6tTFvNymU2M0UTkesDh3fuzTbLcXAozZkck7vXJWGptJYx6cea8z0NlJU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOeEkmqNtKqlQDfg4r9k9vCxZWncM/EPdhvbsQrGF5CYmfzjCD
 hpmIMwQszxMXq4ZIOe/oV221pZoUwg9qe5rsSeI8WyMI4/6vWmPxFJ4z+F8A/yp/4Ak94taI/at
 0QcX0+Ipr0QV79bmqxejXbMq22ALqhwPUUdbmHYhiFpnd0yWbEM7LX9EAwe+seId//H5IxLs=
X-Gm-Gg: Acq92OGrcSLzsqH/cpbPNqNM3Ul7iZNL77UkhNva7pTP4pEkockb2JZcd/EyilJbdgf
 qFfcTVIr1mOSlOPySeBJV0OqLZ+oEuECK+B8HfKcv84E3jTiuWpahWJOZ/Lg7RmNFOcBqh9YQzV
 USx3F7mPvpJqHwuiFIUl9ECfn3ItTf3PnA0vB4WehKcDg+wY7/Cq3OxMBTM9bJ/uKS8ECI44xtN
 v7CkIlkbbQ5nHldYy3LsMD4IXHAKb54iaDkTM28g5w+ZrPcVZiR5E028Ss8dTaUDXapxDP4ctxw
 1enrD4DZ7wvt0L1fZpxzdFvqVKMTjhc+EvXhNqjeit0kfQaYObM0tZ1lP4ihE5cosKK9Ch1FqO3
 oYdv5mIi/SKgLnkP1iyIGVft8SnaLdNaIIgPExIchiaaLYQ==
X-Received: by 2002:a05:622a:17c7:b0:50e:5cc1:1de9 with SMTP id
 d75a77b69052e-516d43c245emr31559591cf.7.1779442878785; 
 Fri, 22 May 2026 02:41:18 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:50e:5cc1:1de9 with SMTP id
 d75a77b69052e-516d43c245emr31559471cf.7.1779442878402; 
 Fri, 22 May 2026 02:41:18 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc5ecee74sm34905566b.29.2026.05.22.02.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:41:17 -0700 (PDT)
Message-ID: <6f302a66-ca33-414b-bb80-dac5d9ec225b@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 6/7] drm/msm/adreno: add Adreno 810 GPU support
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
 <20260515-adreno-810-v6-6-fbe04c7203e1@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515-adreno-810-v6-6-fbe04c7203e1@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NCBTYWx0ZWRfX2v3MzBH8yOrj
 EspK3bQ0GodsmTTU6gydnX6NxO6rLTc1RH/3FODMPUnJGLi4pMtsZbrfqYDw5Fsje3XiPsmYcwr
 NGsyZFFF7M6Srt9kzyzExxTYmqgqtWo4ThnEyJJux/xisZKkrZJ7i3tQJ7L51r7tPHtCDDbM+MV
 CDyro+skZ3KZd5PEEy0PwuX59sCe6kxVgh1w6DlJg6iaAu3m5gXKeMtOMS9nEHNoWJ8tmCvljBh
 F1HsAImSoo5E9bAITqtmOjPAIalIW9bB157Vs40GpOvXb5n2b14Nxze+fdHnzVMMekPqydWmu2g
 dVd214+/DVxL4j4m3MRNCxuBpBy+Ppu04lR00uely1AYZm3yOuJj9Kyo2clCrytEAARksYMT+xQ
 RtyjEBGh/0xy37QIH1hXKZ67tACvJCAJuyNwmEQVFNsuNOZxRIrs3RSQiSIGYsP2AgIafkO2N/r
 h/wa9TWxWs/zXV8oyjg==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a1024bf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ct3XC8PptM1zmpRJzi8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: YS1U5Q27j-CkY_Q616zfmUlrjz9RsHgX
X-Proofpoint-ORIG-GUID: YS1U5Q27j-CkY_Q616zfmUlrjz9RsHgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220094
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

On 5/15/26 7:09 AM, Alexander Koskovich wrote:
> Add catalog entry and register configuration for the Adreno 810
> found in Qualcomm SM7635 (Milos) based devices.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

modulo the speedbin question:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
