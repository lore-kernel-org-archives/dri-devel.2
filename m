Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBC2103A9A8
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9135310E561;
	Wed, 25 Mar 2026 11:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfeRYa7V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lt01Nj9K";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F336B10E561
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:05:58 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P7NFAc3420387
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vhOAHvMJKevwOrbfD1PhZ51iUKVeUH+vagSnFd3VQJ4=; b=gfeRYa7VdP7/P4xK
 MxN25zDUAj4A9JV15YUBqwtuWj80DCx34jhc0CaOcA9Z/8uJ4xi15fvA+40u777+
 NvlcHKbCahG3G5uNYcwdnOlcNKc2BoWrF8xpNBbo/uluDcWvYn2NxeaE7cxepiOM
 zirtgnSFVAxLmrXeYOyQ/LgKtAlrJHX69gtt8+NNqz4CFBeAjPwMQEstgnYHImWq
 kn3V9nmWg3xeLCqx0stCeOtAUexgjb33ij4OMvLb12bWM2wx46ghA3S0UgP8JQBe
 9cOGxuqxX2WQRIulVDFL+xv6NM5C0aWHzINlP6plvbEgOx/uY1i5b1gjA3C2QEjR
 PZntmw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40f4jvwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:05:58 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-56cdc5244ddso623742e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774436757; x=1775041557;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhOAHvMJKevwOrbfD1PhZ51iUKVeUH+vagSnFd3VQJ4=;
 b=Lt01Nj9K84YogWlYNzTh1XdzfLF1+ucQxp77Cq4XM+s+S2saZeVBcsq5GeixxWTCzt
 QGYKl2dFQRWgBHNj56YnxON8A4h4Qa+u7sqFkiCuuJZSk//U08J7k8rntfRATYkLQEvC
 wF6xE0H74n7RCUdoLsZ7j50938ekCqugmQHl5VlinbWwwcfqqgGZ0AoYos/Az0rMDvc+
 YEpvv24yRDpZ9eEMrQMcv05+GmpApFt1wdE4bgAlh/+nHFRN8TMvDwLQEsrxdTDBJ8au
 RgZneB9jsdh8GySfbbEfIpiaD9Ws/wWWVEFi+UZCkwzLq0rj1xEGOGtyP3tkE2kpTzcj
 V+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774436757; x=1775041557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vhOAHvMJKevwOrbfD1PhZ51iUKVeUH+vagSnFd3VQJ4=;
 b=Xj7Jn3cVgT21mjOj7HoxymeCY0vb4vXhpvWZgsxbrjvWSNKjBQj9Wub/rIKlqYWpAX
 ZKJVs5/SuftIisbpFSmz4hA4fmmyq3enDV/MQVumnINI39mvLxfxjf3o7riEpd3loeej
 QwQM1Q1ad/eRy834FujW5H5hvuuibaZzT+cyd9S75woPvK1trDXd5rrgbCh/aJ+smTm6
 KbFMj9zxmIMUG1hUiJyn2N2tmSXAmwS5mnpF9NoUDOHAG22ypwikvfpmvKSVPvxBrEwq
 +ifh/eiylaleZeOblo5WXL14syNY3mNkqTMDy3yzqbH3EsGYl/OQzMifxHuUsisi+J74
 E6+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeiTEF6cwQdUDAkadQ7o9XM9r/7a7C+yIKkKWNNpp3nnzaOa9yi+nEHSqk4RxKY6m0mQXtqHdJDzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya2vZtXScyv7PqzN8Cs3/vS1HdY6ny2sTae0oRu1CCj/9OdeUm
 1sPJHOCKNeEgtRNjq1sFdyY7JWCqzC/qIknQvgB8gMxMZDjOzps4O6QErdIY5xheMZITYl9DKiy
 HkJJaR50Sshiiko4l58/XkwhzELJMI1v+r5vjitGrupUTh3Cj1/72g5uv1cdh36Jb5abC408=
X-Gm-Gg: ATEYQzyOX6QAT20qD1BGFOYW7CLy9po1+UQSiYaWKCepYi8lC5wIcvL1K85NagzkAA8
 R7Nm4LyJvzlbAOo41BZUt4mkt9dWPsDr7ihzX6xWbole5vSzVs3xXc5i7gGLL/54eUn0zliSZY7
 bvC8LlASMYfjCWQpRgbAezyZNDPYgS+rOgqSnRn7ZxTicNX0BLtpvgIM/F3yssHXyLQFRjXMTtN
 Tvc9ygi6Ty8CcBBb9nFVy3ckO0xGfMOPqjNuVAe7ks6y1iXLBTPEFiX5v+UFDLCX+H5QKN7JIwP
 wYhV9vGC7ekgPBq17AgFupfdVsX1Gl3P1Mh6FPcMiKk4YfMnkcoulpaArFmmH/4nwAH844pKWoI
 H/Ti5DND1HyJ04WV/2Gfdtk/aK4Bb0uPh5qBOcptjS7Hs/NKcKFNiKRkMx/lkD+mdBttimxOeF0
 YVSH4=
X-Received: by 2002:a05:6102:c88:b0:5df:af0f:309b with SMTP id
 ada2fe7eead31-6038743ab3cmr714895137.5.1774436757351; 
 Wed, 25 Mar 2026 04:05:57 -0700 (PDT)
X-Received: by 2002:a05:6102:c88:b0:5df:af0f:309b with SMTP id
 ada2fe7eead31-6038743ab3cmr714888137.5.1774436756910; 
 Wed, 25 Mar 2026 04:05:56 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335de0b2sm780796066b.34.2026.03.25.04.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 04:05:55 -0700 (PDT)
Message-ID: <1bcee25a-4dd9-480f-89da-adaba6752bf2@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 12:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] drm/msm/a6xx: Use packed structs for HFI
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
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-7-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-7-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3OSBTYWx0ZWRfX0cgr/uEgmiWR
 bdUlQHFgkbruGgJERTBdBSa+I2xKOrzR/xNg9T2g1PVp1UsTianxfURKHWsUVANXC9stnCbsKNz
 U4ihxf/mp4TlJszPd4ci3D9c0wec+QE9r6nX1Ayo7YqG3xZVbLYnFwLUG39WK2JCnjlsVNVLrJx
 sbxmcLUVeraUqUCBMrHrN57S3t7LaSsX+Lj/QiniD/AGtTtROuqARnHdCtvJKQ/OR6JQjN6za1b
 tn2mTr8h63USfeCRU4ZYcqZCkhK7tP/98I/zavZFVdASH+B19umBqc4GCqrpE+Sayg/On05s2Z2
 gIEdphsGiik1zcFY7wqBz6w4Gs/nQWm9i7VZw/ym32SJDp07TEha1q6Z6hpOAU/uwYx6ROW8NYH
 dKkbyr402h7/A32kfKxNaqYsPad3vl8skWGDCPGDqKiGOCdnjJReZjIiD5DS0oOyrGcGloxA7n/
 tWpIPJawu1lzLes3TIw==
X-Proofpoint-ORIG-GUID: GYFDbju7azWsZnHsG_qz0XsqZ2BgyWFX
X-Authority-Analysis: v=2.4 cv=Cd8FJbrl c=1 sm=1 tr=0 ts=69c3c196 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tlrG-h-73r_ERHy7KigA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: GYFDbju7azWsZnHsG_qz0XsqZ2BgyWFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250079
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> HFI related structs define the ABI between the KMD and the GMU firmware.
> So, use packed structures to avoid unintended compiler inserted padding.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
