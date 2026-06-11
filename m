Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E62CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4094610EE29;
	Thu, 11 Jun 2026 10:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibH1AWNM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iSu+6QT8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FB510EE29
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:29:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA07FT319131
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AsbX8LJfzS1TZMIkwbo3ResQeTNTfuQ6Cs6WQoVUlHE=; b=ibH1AWNMnqYf4733
 LM3sye481UJUyBjAz4Y94Pl8IXMLtxnri52mTXTxtJZihbXU4FmaO1gxGWNKAD3r
 9xdVnyRYvtg3rCPxCd0NRuxZK0dTMOGFxtFITJ8Bdn/yeb+NSneRS91QI8Tx+m14
 FOHZg09oek6hql1MrQplonw93stutFwXWdoENOxRTRhgK+J7L1vEtPJe3HAgUXVS
 RTMMPQxF64ONp0qUmauT3WM2aFZQnqLNNXCRcnnJZwK2BRLSSwDEK7L6LuDA8cU2
 ZTMjGFDCNbthikmmh4gD3ZkcJnidVdH4DKYG9hnLCjqQ74PWKwWwBIu+jCfhPVWC
 ia3MoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sk0g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:29:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517647fbff1so25777581cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781173797; x=1781778597;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AsbX8LJfzS1TZMIkwbo3ResQeTNTfuQ6Cs6WQoVUlHE=;
 b=iSu+6QT8bsS+uhQKR1RCQh4fkkzjQRiDo/aO2m3AkaIqf702VYv0xbIb4SQR02Fw/e
 uneBuzeBF7aElkgMgoAD1F7XnIT4jPABno7VSVBe86msdIxRhabsH2cM3BBdIiA8eEXr
 WZ5dNbPL+ah6ie2v4gEaka1Npl73M+AmllGrxD69zxNRBAtZbcymNOpGbCesYptO+Qg7
 rcrIJ+LsBm6UJpHaEStDDuLDuTJPdk0loFIV2wZa5q5gTJeEuqtTR6sOzgJ6D6ir8u5B
 CC6ZiJGidR53wmCmrhQ/DTH8T/afPdMCyLZbKV2wv3htWta1HAyJQJdLGN+pvryJERks
 FM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173797; x=1781778597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AsbX8LJfzS1TZMIkwbo3ResQeTNTfuQ6Cs6WQoVUlHE=;
 b=IXuY4Pw49b8NZSgQugr4igLRpPoT2XyarP61vN3EiF14HftlQX1quEaeKbgtQPZRy2
 fQqOqkXz0pVS95CIrixK/K+vPTqHTwe873rPd0DZ7HYY4BsxRTkKTStE4BtexPOUMksh
 e+Y03NKbMj3jypj21EsoOsULeu0r4to2xD0zCqRJLei3Gvu87aGjHJCvdKGN6o35ljg9
 UuouggNs2f3MuAkVbpJwVe5F2NmbhLnoBwc7OkwmX3lOUDZhdigPGtqXuDErGFhUs0OL
 KxKWgcFpr0SNit0iZ+qzMBid80ETDisvuQ4diOk8c2pPglxvAzZa51QZTidzwObcmVOy
 aoGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SFV3jHaK+5DDiy2fiE5eb225+aU2zQNL5Wtvr/rG0ZVxutUlE57lUOtOWUR7T6CoMLsI+yW+w4kI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJyTvOCpFB4uNmEFjibVwaguCf9Xgq93ggg9MBkbohXz5tURza
 flxPxa7f/xc/PVslLjCPg87uHKBV8vpx+rIHRby4Jyxa6aEvlgZQ4nMHsWruDVPnJPcaeqOai8e
 zBHIZbC76tK/dtnnhJ/JvCtZBTDYBrysk2G40mn2SEJAeasBMZ5kazUPy+4YtLvwL32nldAg=
X-Gm-Gg: Acq92OHJssxMzcFXIdLrFAp4jyPBjzlctifYo/3ciMDCmoRw/kNYyWP5PDmcRo6GgHx
 kFPu0rinonmwwwaTYzbzidtXgErgGAYHg85a9vQ0I0P7O4s4fXsFAIuWsArksgmrTjyFGetFlUS
 36hQL9BJ5fHCEE94+fZvlDDSoHvnuNXIanc2RQNcsHzwhNpGra4FCM56oT/JRxXw1pjByO2DdEj
 grVgSAL7TFmUd2t+mgsjZD7W+IjMOBC+wK4RM+Xg9wco8l+ZwgeRqDdtG9SmMI6XbDq3i/oaDHu
 7iN9NDIbNSO01AJ7tskIaSNefQIGEC85gBPipEqFc0qqeS4u3i7D8EWHzEGICvwY0aBuK703/2O
 K0xOeFliZCCAlivuhr8A5WLuxiQHXQ+tRsumusj3w7kjvkBSV/Am1kgFQ
X-Received: by 2002:a05:622a:1dc4:b0:517:5af6:77f9 with SMTP id
 d75a77b69052e-517ee1d207fmr22539701cf.3.1781173797058; 
 Thu, 11 Jun 2026 03:29:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1dc4:b0:517:5af6:77f9 with SMTP id
 d75a77b69052e-517ee1d207fmr22539341cf.3.1781173796593; 
 Thu, 11 Jun 2026 03:29:56 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e6585154dsm10778203a12.15.2026.06.11.03.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 03:29:55 -0700 (PDT)
Message-ID: <90de58eb-b440-44ee-882c-cb52d0f816cf@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 12:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drm/msm/adreno: fix use after free on error path in
 a6xx_gpu_init()
To: Dan Carpenter <error27@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <aiqNktNfXiaPhje3@stanley.mountain>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aiqNktNfXiaPhje3@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ikw3IJmcEHjn7K0b6O_dhYYsfHP1XgsB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNSBTYWx0ZWRfX9Sp6Wdn3j+pV
 QqbFg1RunKB22EKlLHRup973TduL6TsHxJl4Kh05bVkbq1E6h/4xmuxpuD3hy5JuyDoZbHEodLi
 vkEAgDqXnG2UkF0t3ziVguHwb/5WSNk=
X-Proofpoint-ORIG-GUID: Ikw3IJmcEHjn7K0b6O_dhYYsfHP1XgsB
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2a8e25 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CLLU5E3UPER3H5ubdxMA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNSBTYWx0ZWRfX5xRjxOBlBdK8
 Y05Q9U/g0AsODVA3qmLI/iflDT7ggqH30Zkp/oJDTgdbxJFQFbLGB5UpYGNHTHqCG8W9Sz75QdX
 fiFxeTvtRvLvGbzlpdNtEIl21hlJ5KxnRhELPXvPsdYNOsU1i+l/sMgHteHPjZ67h705viEBPy0
 RrcOtnhFEduZhy0dPkyKvEvZ2rZSKf0yj6VJx3UgWWUnekT4HrUOQQGoyNgGkik0Ta3F6Sxp0Ft
 OYNGGCzZeJa/EuEGmuPbicIa0jqlb6DPGbO0LCEkS8Uzttf81LQz2MeTdfq/aKBEpEQlmC8H/k9
 6QUoZ4kHKJHAtlEB++RzvR4vIIjKJjJHhSuPreDGJS6YZ2pcCuH6XzvSnh9fj46UQw36H51pxFZ
 CjTp+9uSPkhVg4BNlZidQ6FvEuWHMIc0WPzbzGObgki1mKCWFFV4iLZAD+aAUvuz3pGUMScTJOV
 iR7EwXxjMhH33fyI9HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110105
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

On 6/11/26 12:27 PM, Dan Carpenter wrote:
> The a6xx_destroy() function frees "a6xx_gpu" and so "adreno_gpu" points
> to freed memory.  Preserve the error code before freeing the memory to
> avoid a use after free.
> 
> Fixes: d158886cba08 ("drm/msm/adreno: Trust the SSoT UBWC config")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
