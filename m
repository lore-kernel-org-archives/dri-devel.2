Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2458CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6351110E32B;
	Mon,  6 Jul 2026 09:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="igSfXDSG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qi7XAqFP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B04710E84E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:39:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66693xLE103102
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 09:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SbjCETrpVj4j77Vo3a/oe72PsOFxot0+LxVY86kScYM=; b=igSfXDSGDXZyx/+x
 3CJahP7NvHEriESw1Af3soF728wAkm8m07BTNRQTpyQV0fid7mWNRl02gXhYnqfK
 bcBuMpD07adRfZTDp0SxSdh2UShWruleWpw/E6BQdNodE7o93BBEDR0TdVM2WKrf
 1sAnRmnjHO5SaJ6Q4pjJWO3/NatVmggzTxajWuTS3jmic4RD3cl5WNsW0MZXgEup
 FksPk3ls5DCyO1vE6BYGTqN0SoTKCEIAjVASH6ujrtF+CXDZZw3dcXIQpjCrIT1D
 2WjGHPvi6Frnz1luwacQfR7vZbQ+uCjC3pPXQowDURBYYqvPTNHnn+/JR80Jfrqy
 A0PsWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h50c21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 09:39:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e7579ded2so41436985a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783330760; x=1783935560;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SbjCETrpVj4j77Vo3a/oe72PsOFxot0+LxVY86kScYM=;
 b=Qi7XAqFPqn0HJuwGWfBBPX9HgjcO4g9bOPifL9Po9QNkYA8BAC3PawWUK/ziWOr3G2
 XiqVxTpFj2kcBgZsZJS2Q8KKkZLuhED+PwZJ6ApZpMfJJqQhYVHEHXTh8VwJjdyBsBnA
 1aGkSnVEsDaL1U1Xhxh5zn7zQWVMZyZgYCDtaGuhOqNFJNhfLHGhndKg5o28UUyMloQ0
 gvmaW28D135k90NZqC4lw7mfvhHA9a7E5ewV6AsoRmMajZwYRisPoZttvv1ZySWAy+V6
 JGtDlgw/6UQ3DXyWHj/d0aV+hmowsOapyERA7HtAex1TXYPS7jX9W0psqz1CLlNzjg3B
 4MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783330760; x=1783935560;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SbjCETrpVj4j77Vo3a/oe72PsOFxot0+LxVY86kScYM=;
 b=HTffhyzryOZ39z+l1nbWYuhlDLvln/fbvZlKajTXSZQm8wuEG3Blte1hmX7+TaxQ85
 zbJgX/rh8VY6Et5754M8hFLeHRBnWl7LUyxaivl7RYFE54bgjr3WlxszOn4zKQWy2W9l
 Za1RAhpiLN/Rco9jc1NY0hQCoUuPbJNkEUrlVlSvw74i+DwfMKHhzF9uhZlc24pMm3vf
 2yhOmKMUeNRxqJojwKlvqi2cYiOVf9HBdoNhqA7LvAXV5MUVCj8J8fKrL7uSQw0Dw2Ll
 9Lvq9FsLQ81IR4VPC11zxuaMu2OnRd6WzIxnXhmJh0zYlFHpuT81SUa5MU/9JuRhgtKq
 TMwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGmWQvMeYtT62CYzA9qnNrfXMenrtSEyGjT/VYz/P5nYqqHoKOjgdzhYdtVmh74FG21YKdoUuPfDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztB8tz+d996ufTjEbAstAxTOAyI8lv03/of0kAUTo4WEqjdCJn
 svxh9sTZdykZ0ETl72WQ3Kf9XR8TtFA/v0o0p3gLJyX9M9ieLwvf9HQAfOwL0My8WGSGSFQYUoT
 sjHVDMDnAnnECEeQbZsP7dO8o9vwRd5K0qggnsV7BW7cse31GNlCuX4pl5oUTvp0Gdy3mgPY=
X-Gm-Gg: AfdE7cl35H1n1wGDiVwN/efiim9/w7x8wIosOfg7WNMXyMV5jGRUqQqetUqURgJNQPO
 7DVC/XTJ/s+ukOHv6yxZyaNmdSjTl7l6Hc1SOTaNZND9WOR4lA0s6lY+NBCluxch6P1JEAhGrQo
 SXOp7NXiemGqraxRJ12d+2m66rvMwN0Zoeg+eZHpm8hf8ssDhYjtf11IuPqA+6shLs0tPdg5rtS
 6cojltGaBCWQFbigAf93vP85dgGtMxngOb57u1Pki23axeH67MCp5Yz2XpUdW3qhCBWY2wYMUk2
 8MBzHl5Jfxu2Grq6XJVjZGmAnk0dCYc4MrotJiMsXbqo+ZdvvyOoxnomX2uEp25wqLM7KQ3HOWc
 JCw3JkeUc1BbYeuRZx6XBcqsWSbmvID83eS4=
X-Received: by 2002:a05:622a:8b:b0:51c:1c73:51a6 with SMTP id
 d75a77b69052e-51c4bdfe4d1mr85762451cf.5.1783330759855; 
 Mon, 06 Jul 2026 02:39:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8b:b0:51c:1c73:51a6 with SMTP id
 d75a77b69052e-51c4bdfe4d1mr85762291cf.5.1783330759458; 
 Mon, 06 Jul 2026 02:39:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19daea67sm3674475a12.26.2026.07.06.02.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:39:18 -0700 (PDT)
Message-ID: <2304770d-a752-48c1-a11a-30978a834b0c@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-6-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-6-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rTpY3eW8hHoIZ6aGEG_fK_mvdl5cIZDf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX986Ca8CJZLOc
 5MBaaGJgI3czOFL7X5QkthDUITRdbtU/BtULslKAIKuwYcXQ2QpsobTKr34ty/24xXta8NjcI2P
 HdVAe9P/D9Wkr6DsJ4rrYGriiEVutQI=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4b77c8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=K30R3rYzCv3NiW1yJugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfXy+bmxwON8bb0
 vH6aEvUzO+rfQKPHVQNMPAWU3UY1UPoH/3EqfRvwv/PpnAjRzDVnvLQtuNZmo/sEQjXi3oCBlmS
 CI83Y/SQeIhm6Um3ZgUfLdiGnootOpkIRvPc1O/CYLCWSHlD+YhPfqok57a0i89/ZHiFKZlrby2
 loeyOe7Fic87XRT1pQoravC6SO4eBKMA6rBfZaDSPUDjfzbA5qgSLHcpHA9jHWfiLtScso4ilut
 SJmVA0JcUvzdcJGryUA5do3e7SyPwu1Fgz3wmy2WlSAO9bgJEzJKZigoG4/rb558m3zkLzEuqYU
 Qqe5ehr2j7dvhE2B92epljvFLBa1FP8SKduPD2Ur4tISXpkeRLlpkJYvjTTlNAEIn9fgtRlwXzr
 rhR7RTbwyPm/dEXN1I6mmCBmadixOFLwda3FTOuzSUDZfuefvi+YCfn81P0a1L8UHJAyhws9EfH
 SFHYmTZzoZZ1ZWvF0Zw==
X-Proofpoint-ORIG-GUID: rTpY3eW8hHoIZ6aGEG_fK_mvdl5cIZDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060097
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

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when
> it reaches high temperatures. Set up GPU cooling by throttling the GPU
> speed when reaching 105°C.
> 
> Introduce a passive polling delay to ensure more than one "passive"
> thermal point is considered when throttling the GPU thermal zones.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
