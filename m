Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB25DE9A74D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC2C10E5D2;
	Tue, 24 Mar 2026 10:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHKo1RTl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LVdEkxUd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF1C10E124
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:00:27 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O9wVFA3039725
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WT0sxJjxN+LdXES7eWwHlBN7cn82bPNexx29FFsAMOU=; b=CHKo1RTllj9tQhcM
 wFF/NhldkqPtJ2AOWhf7AmsLXH8XXiEQqaz/zAjBPCfZDYm6Q8RIaQWRjt9kYyEZ
 UVaGhgkKFzuqOsgVIraZQjF5azCi4r/Pg+WRDDRb3eJllUYu/D7NGR+pOUszQwwp
 TNIbyfW0obMVUQwgCyvDFJwYUssTJx4pulfcOBUwgWddYWJ/gYS8UP5TTsPb1QeJ
 ghgKLUlbhxxxcblZmQr/s9D6wgqLTTt5uPn3EVYrtYv2CGUBEwMnIGfntcI7CsFR
 HCjXdbOIQsZNldfKhivZunvt11BcTXH13hMNlqpmo/3KuYFQiu2vSb5oQfYk7jyA
 +NDiVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3rf0g09e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:00:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb456d53a5so360292785a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774346426; x=1774951226;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WT0sxJjxN+LdXES7eWwHlBN7cn82bPNexx29FFsAMOU=;
 b=LVdEkxUdtall6uTWZzcvFoQuHtLNmzLcD4c1Lv8IPm3uAiTXYkkfvKV4zLkWTktQMb
 Tacwl18F3ATwPF7cV9d/WUEx/fcpZy+D0LD5j11wV0+5ZKVwl+Lrj2q7j5GdRojQYwbm
 5btTT4gaVYyhdcot+AHCvjVc82k2FBMcm2eeass+fkwrG2QppPwzfyTNZT6yFOgFU6Pt
 rje9IYZ71AeC1sSHM6UXFG5Ub/sBaP68GQ2voeDRgfsveGninmeR2oenwTGrvFTzA5Am
 kCazQeJwVfalOKf9FCWvTZACgvt9VhGTWtDLtEKqu4qwhgl4BSYZpVl1KF2uozqbMxyf
 rdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346426; x=1774951226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WT0sxJjxN+LdXES7eWwHlBN7cn82bPNexx29FFsAMOU=;
 b=Sa4H0gZkRUfUGHQnjgrf1EZVoU0eVt4rtMpRrHl5j9puX5I94k7IagaN/ZVpQVxrFz
 7woReIM9h2BGZ1KtMTDucrbGyZwXOchewdFZ5n51/oxkhCMk+rQotxlGk0Xv2tKv67/Z
 uJyay0gqptGvfS2dBspNcIDsZbvOiYslGn8Z3zjaDSFy+5+Ra/sTVMJXImLveLjiONnK
 wxhI9FmVeqVwOq0phaH4pSv2W4xuTPDKNSRRQTWTYQPN97k/NtDwJwlWprnkGJwXMRqy
 adk8ZedAa9+qAxsgONAao8O6eRsRZ2RElH3T0gGbzEhfYVLulB2e5zqAJPtBPk7DPB87
 G0Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzz/tx7kbOpkA+GLka+fUjJKLHgk+rMtCcyIds9oiQP1Ryw2zPwW57wMWfgpYXxhsqI0KkZWsGNds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdEYW8nWkotdNHoQBJB44NynNI74IFQTKRFKXhQ610asW8AXn9
 oPxEOevV29C/N2nfoFYxPDrytEAAEsimPDYDIOCMmI8dW8sR/2jWk8zEBegn/5XVoChctfs6Cky
 ED7PBhiBaIYJ8kluNtWMrzFcBheIz2+zAzCmMt9IS/coOVg8Uu2QhoqFvhfj6/cEGDTabglw=
X-Gm-Gg: ATEYQzwmFEI1We5pFTmZaaRZDFNa9J8SBEZz6jciPGcqKNwoqPfE4wULQMhSLLx943W
 6ne5n4+GzxKOF1YRNtgzZexbsfHkzSx3Mc+SJh8ve+RWjgy5B4ItsyV+RWZZ4bO0wr26e7SHcZo
 etkBe/o1v8NEPGTMBgrI2KsSG4b1a2/2aiua3UKPM70im5UAMMJfK0HT1onRGEy6YPq3hwsczOG
 cX74Bxy36DI8ZtENJxoNEhKL8JnzdTZEb1P5yFJHRDnDwy+uTWKTJM1fRj0VEL2t4UM2WqxmZaJ
 PGA5sw5RmY3wiz4e3x0CDfA6V+m3AOE26dkk3dMmtyiv5yORxfYcbaud7d38NXaMMHYCzsrS3D+
 BXOOJHXAKR2QYayQEDwKRpi7hNYePTz+5b7qeHWBSpnnT0EZKfPPmN+MxnaJi1+6W
X-Received: by 2002:a05:620a:294f:b0:8cf:df37:4f6c with SMTP id
 af79cd13be357-8cfdf375316mr1003162985a.5.1774346425671; 
 Tue, 24 Mar 2026 03:00:25 -0700 (PDT)
X-Received: by 2002:a05:620a:294f:b0:8cf:df37:4f6c with SMTP id
 af79cd13be357-8cfdf375316mr1003153185a.5.1774346424857; 
 Tue, 24 Mar 2026 03:00:24 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66a5f017c83sm119090a12.3.2026.03.24.03.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:00:23 -0700 (PDT)
Message-ID: <30a4cdad-47c0-43f0-9327-04c28eac52ae@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:00:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] drm/msm/a6xx: Update HFI definitions
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
 <20260324-a8xx-gpu-batch2-v1-8-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-8-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3OSBTYWx0ZWRfXzm5k0hyac0s/
 EkL0cWzvbMZPYci3qHYK9JFm8VIs+a5yfF0p9WEjufFyWH/nfnzt38VqNss3JdKwSlAiSmX1bk1
 bVITosAvA8qQkoSyUugNJothYdti6uyC2HopDAIVEByIGS98v/0m/z2DA9newBhTYitX0l55Cib
 MOB5/t2jvtA5kQiK/jaYe4xmrwvqrkb713jckEWqZJ6e/OBzk/JsTAuLQYHjR+mJWDwoF2rZyoS
 iasR5xlCN8QAGJF2xIQ5szOoeYi0Dr83Cy4ndufy6aFxkEJgu/4s3P4JrYWpYrkNn8D1cD7QBk8
 t8l2rQKH+klWe2MSncvtvVtVmmo+GaMTzip22fjNrLYCW2OkTTRr8Ls6RYKiWAC7ySWWhrrq4Kl
 eRfaUSaqmkvdh1p9MPB6FVf/oPp5JGtuN+M8BHySWE+TgK2hsiOz4qdJunnjnH6RcUuONkabmT7
 7q1au29ymRSLGK5nKAA==
X-Authority-Analysis: v=2.4 cv=Ua9ciaSN c=1 sm=1 tr=0 ts=69c260ba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=yXWzbejlfdbuXM6ywS4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: eSI7QqlpBvp6sc2sz4MBk3jeA_jWaMII
X-Proofpoint-GUID: eSI7QqlpBvp6sc2sz4MBk3jeA_jWaMII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240079
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
> Update the HFI definitions to support additional GMU based power
> features.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +#define CLX_DATA(irated, num_phases, clx_path, extd_intf) \
> +	((extd_intf << 29) |				  \
> +	 (clx_path << 28) |				  \
> +	 (num_phases << 22) |				  \
> +	 (irated << 16))
> +
> +struct a6xx_hfi_clx_domain_v2 {
> +	/**
> +	 * @data: BITS[0:15]  Migration time
> +	 *        BITS[16:21] Current rating
> +	 *        BITS[22:27] Phases for domain
> +	 *        BITS[28:28] Path notification
> +	 *        BITS[29:31] Extra features
> +	 */

My first thought would be to define these as bitfields, i.e.
u16 mitigation_time
u8 current_rating : 6;
u8 num_phases : 6;
u8 path_notification : 1;
u8 extra_features : 3;

(hopefully I counted them right)

You would then not need custom macros to set/get the data

> +	u32 data;
> +	/** @clxt: CLX time in microseconds */

slash-star-star implies kerneldoc, which this isn't - but it would
be appreciated, see e.g. struct qcom_icc_provider in
drivers/interconnect/qcom/icc-rpmh.h

Konrad
