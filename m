Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7FFC531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24E010E495;
	Thu, 23 Jul 2026 10:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="myUXaOfV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYCTHXj1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D0A10E495
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:05:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qirA3390703
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y+itfSfH8dlCA2Ag96yjb0QZKGwEWMn7/dZJVuyJcP0=; b=myUXaOfVQ8rHd0NT
 DH6HtnMB1Ur3O0o6eIuqjj+gjMrnad7zaQm2+MSfkqs9HcqP/ggNoB9sPeV1LtMQ
 gVbuwEXS89meaPwHD+1397X6XjAl/6u7hab1mOHPrfk4lNx/Ac47HDfTPE6goJWd
 oIJRl4folaoCIBDzYvPFTb++ZOH3TnI/WDMKBPMtI0jp7hc+zC6OWvjRfULY4ffY
 UxYOrFKlQTtUdSZTRZCW4tm+A/mKE76nphRcI7AVQ0RMgY8lG+UDJ568JbRv8Ia6
 rFwfUE0s/2c156PcfPCVV3cPAwQBxCrBGNHMd51ytNsN6oNxEN5o0SjxEpM0IhMU
 Atoimw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0krrxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:05:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e6cb57d25so18550385a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784801104; x=1785405904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y+itfSfH8dlCA2Ag96yjb0QZKGwEWMn7/dZJVuyJcP0=;
 b=AYCTHXj1A7Ifuw582onD828Ty/+37rSXD300gK/I1ut4uQUKbu4s4LYsf2wqTkq9TQ
 Lomgp7TVm0KPzvVjwjcCMMFCSrozp4l9Xy24U3ETsBhJMl9pY90eIweSi6ZRMmygQk6j
 0lNNMac8z7MxWATjk1+Y4IKSQxdfo9ksweWKnj5ce57IdToVuuLL3UqjX/+WyCX+qXp7
 PnGmbqomThhUz6g55gTQT0E0fjHu7POZm/yo39FQphTFxYJcqIXiOy9wqpRXAND9njSz
 nOa5QpZ+bIyS/FN+d7QbzaLnvkXMYZSycZU2CK16oUwvHPaFneDTcosivM6XXMbJFvix
 P/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784801104; x=1785405904;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y+itfSfH8dlCA2Ag96yjb0QZKGwEWMn7/dZJVuyJcP0=;
 b=I38npz27TRfP2Lbk6PR/2E5SxQ9/QjwgSH6hO45Dd9rVaWVAH09+2mYh2zXdkmIuud
 VR64JYsafD6XzrlLGIfiWegl21QtWD0A8kQkuvgutCjnJ+TObaHBg1LOq+59ePe5cy4J
 pyLFO+qkTY9vZPOEqaWDWxavsGoa2ZNC/4zH8kCo7SsG/8XDhLgGrjlU+OOTKLSiez4b
 BBHPMW22JDsVHzUDV3/0GNuOt/Y6Cg/ZaD91lP3MfFZ5Vk7czo6s2+RFwru/s4/35MUp
 EfhhZ/LH8vcRnnuM7vqlAuBMclm0ZmRDZkDLQNGQDsgoUk1O217ZikENgo4li9JeXfb1
 xvkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyhwJZrV7oe+Ba278Yn9jH8WKTW3YXaMmKwL5sam2ploH+cXEWv4aL6/gZXetBkNTYqjS/p+wLcb0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNSK/7tq4qCKbQAd3z30C97H6NWupKujWoVlUfZ/giUu9qyN5Q
 QZfRgDofmBMMwwY7R7q9GHykeC9ps8kT4nVGJpTnbxnBwI04Lob5hf5sQ8VjHQY1JuZnxfd5ZVS
 dmU0l1j+XMCEsve5qK44zPiNfn1+P9HHbswwKE4XN+ydtiDxzK2qgYY2PZCJ7HPiwl11ap5s=
X-Gm-Gg: AR+sD10R/LVhDhUssCLLr9n3piw0RSaA4+zFV5qQQf1jY67g5Dli6MFDAscSkAjaQuj
 Bxd5qtcXxUbZNeyu6gUAdjI6JJnZAIXuHkKr9J009M5CQULaU7HoddEpcK7hFmx3H5VS2+0E2I/
 nyfwx92J/V0LKbQUayZDwZRV6k/ztLrxj00VsQxqEom6etgZVvRvf1maWOCbYr/IleJeR3aYgRq
 tyUH3TZGKJ882n0/04ZlxcSy0qETA2rWF777JZP4pudJlh5N4QiJGiJhOxQm3edWCUkblE4hcm8
 HLddgeti0IriMQYPD49KPMb1qLn27vhQnbeaQtmK4XFNzRqejwEaXWgGztd6TGIBsu2tVb7EEfF
 maNTsGVJ7EDv35I2rk6Ufh5nX
X-Received: by 2002:a05:620a:2618:b0:931:4c8:d8ca with SMTP id
 af79cd13be357-9312157de7emr2304885a.1.1784801103333; 
 Thu, 23 Jul 2026 03:05:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2618:b0:931:4c8:d8ca with SMTP id
 af79cd13be357-9312157de7emr2301985a.1.1784801102894; 
 Thu, 23 Jul 2026 03:05:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f35026b10sm1961116a12.25.2026.07.23.03.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 03:05:01 -0700 (PDT)
Message-ID: <1246f02c-7e2b-43be-886b-13f39aa7d4e0@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: don't tear down KMS twice when KMS init fails
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260723-msm-fix-crash-v1-1-78fb4721c2d9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260723-msm-fix-crash-v1-1-78fb4721c2d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nd6--L8iyDGnBi9AeY5C-EQIBvdAX_hW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5OCBTYWx0ZWRfXyKxlHWYWza/g
 Nu+w4dxGd1W/lnpe7Jixrz1JAxmxRoVwK7FtccH/ElQ9Z5lsKUX4FTwTPMtc0j8sJ8BqJgQkfD/
 4L+IrOuh/zPP1X2WnW12aq6z/LhEkuU=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a61e750 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=H0Ibv_8qnN6G3ftQSwgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: nd6--L8iyDGnBi9AeY5C-EQIBvdAX_hW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5OCBTYWx0ZWRfX7UZfxNo3H6me
 4JQO6B1rOWowVNZffLO9t/XVCGxZ8uM/nY654FioJBYAJKGuFSWwe/HuqsQax6kySNdSppBj0iZ
 ITgln3ZepCvyamx5aTV9qaWBWi+a2QmzxNOaH0vjq5bbTPc/MiB6Wc+uPjfyd5YaKQyORd23nMb
 cK/14wge63hWQRmdrjRIXvjwdvBV13t3exozEVgZUVwbnAMcPp5Pux2IU0CKey4Njv5I7Bnu/DK
 NkytnJNFpkLqsdFL8VqaeyQB5T3xOrnP0Km3Nwmg0RAaa5vB/ASnSw25NjoQ3eFV/HX7Q64unX2
 JhWPtgetf62g3A9cTam3sXZj7WRHNTicESTdli4aMjRyZYmAeH6oYdG4e7sKsPUpUuprFJZod9G
 PWuwBWir/BPHdiOFBfyoQ59zaBz2y70odEV3SA/FBm5YAXO+3gihDHojzX45MYIL1Dedgh6TbKq
 yjAd6mWtcX0hITrYs8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230098
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

On 7/23/26 11:52 AM, Dmitry Baryshkov wrote:
> When priv->kms_init() (mdp4_kms_init() / mdp5_kms_init()) fails partway
> through, both display drivers already tear their KMS state down via
> mdp4_destroy() / mdp5_kms_destroy() before returning the error. The
> common error path in msm_drm_init() then runs msm_drm_uninit() ->
> msm_drm_kms_uninit(), which tries to destroy the very same KMS a second
> time, which causes a use-after-free crash.
> 
> Bring MDP4/MDP5 in line with the DPU driver whose dpu_kms_init() doesn't
> perform error cleanup on the failure. Let the common path own the
> cleanup, instead of freeing the KMS from their error paths.
> 
> The crash trace for the reference:
> 
>   __lock_acquire from lock_acquire (kernel/locking/lockdep.c:5906 kernel/locking/lockdep.c:5863)
>   lock_acquire from touch_wq_lockdep_map (kernel/workqueue.c:4094 (discriminator 1))
>   touch_wq_lockdep_map from __flush_workqueue (kernel/workqueue.c:4136)
>   __flush_workqueue from msm_drm_kms_uninit (drivers/gpu/drm/msm/msm_kms.c:243 (discriminator 33))
>   msm_drm_kms_uninit from msm_drm_uninit (drivers/gpu/drm/msm/msm_drv.c:93)
>   msm_drm_uninit from msm_drm_init (drivers/gpu/drm/msm/msm_drv.c:184)
>   msm_drm_init from try_to_bring_up_aggregate_device (drivers/base/component.c:249 drivers/base/component.c:227)
>   try_to_bring_up_aggregate_device from __component_add (drivers/base/component.c:269 drivers/base/component.c:748)
>   __component_add from dsi_host_attach (drivers/gpu/drm/msm/dsi/dsi_host.c:1739)
>   dsi_host_attach from mipi_dsi_attach (drivers/gpu/drm/drm_mipi_dsi.c:383)
>   mipi_dsi_attach from sharp_nt_panel_probe (drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c:247)
> 
> Fixes: 506efcba3129 ("drm/msm: carve out KMS code from msm_drv.c")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
