Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EBACD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFAD10E57D;
	Fri, 22 May 2026 11:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmcIfdHb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ag1W0Zc7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CF610E155
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:30:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8hOmd399191
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QGydSFVKDgHM2w/x1IDM+7RcPx6urNySCa95PlM4hS0=; b=MmcIfdHblIB1bMEt
 CK7bJ3ETmoEeQWaJqYsbvVXRtSsAUMdIn0Iwr4HDVlBuI2nsj+VDsV4RRNPNCIbK
 oHYYf1cSuV065nhcTwWgDONbwsZmshS4ivrEsPYgjO51+0nP51MMMohW+IE52VCm
 Zar5ljcobC02dmsJUI9eUk8y5Y5sWgpwvdaQa01AAVgjhV86IDhdbdHEi6Qqttvh
 X9IDLRxGQYsxqFnguENufcrQGryPVx1zQy7MPhmYr6YcWzyIlWDeMaWqR0NncqIw
 peY7gkNtR6owJN9WPrXQzKs3nNhSzP/v7YdFeZm+8Cc9DP55Y5XUSIzxbtF0nbGL
 w8FIlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9v2n2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:30:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914b8fd12aeso13824385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449458; x=1780054258;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGydSFVKDgHM2w/x1IDM+7RcPx6urNySCa95PlM4hS0=;
 b=ag1W0Zc79bIgiDeh2YtXf/FvZp8wYVBN5mEelG1lcx3rWtKreCLpBTbgxrDjkMCc63
 3mtry0jZjM5T4EQ5dW2qmMjAyVABPJbivFgnD2EXYaMa+L/kHa/xM+SHnGWeFGfFN/Dg
 3oBnFFL505zU3wh8UpFyHDPG5m1RqEdfjJcr/hLgLcvZvBRIZzg8Hr/0V0tCHJq2/6v7
 E2SDq/CtDdMJtYLzkax3nUOiJKj/PqSAXRuL20qxTR1RZzmCBKVSytkgu9Za/t4Gtr4X
 LCjkZUfioyDu5LXyHsK0zWyVYybWoepb2SIst3LI1bgfxkeeh053rgfvr2sFsIhbJgH+
 FVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449458; x=1780054258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QGydSFVKDgHM2w/x1IDM+7RcPx6urNySCa95PlM4hS0=;
 b=AJxFf+hmkwgaIR8aTa+5vlk4mtAhA4J/b7Urgp2pCrrE7fa5uqef3CjILP3adRKia0
 BhxfuK/yRV8saANO0iP2SA3bNEmYW1Gw2MyA9D/GRqVkR9IXZys7U+od99UVg/oW+f5M
 sKPcaOOxqT+zMtIjpjFtN9vpET9kOkPL/7XhPCQaR99LDCbGD4bsi7gWb1n883qT7cTi
 ILzyOEHPhvOyZWxLw5SvuMCyhuHIeUEOpLPGLvrEcYmiXLvw8XZktzbtAk7W+KPSNhmZ
 VENNEo7kHrkGs0Idu2EEY6TgmmLeyvQGxVqp5qLAqMv0UuLYVtFID0RnAV9vMab22tfs
 oCJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wHaGoYeJ7flL4xcJzZZM97b6PKop1pj4yOaAnhr+7R9vaDQ9DcR3k8mV3MRPxas4xZVu1jzZXMW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySB73Zr3CVPsFfUapEAL3PR+8QwwmCyPmzzGPR2FdowObZDS4C
 vxrPC1FLP9k+QTgE1cwrAB1LY/ZHSPytJJl8m4zoPuP1+lW6IIQioKOonuTxQOmRxn2NqDlPXd5
 hfFfDfastRoE8HxZNk9GLp/yOJpzYiBpWU81Ulv9q7gqiOxpwZyn39CJSN5QMFsdx4uM/ASY=
X-Gm-Gg: Acq92OFeN7pvIrSBfeLuSzSXQwnXaoHj5XiQ6cRZIl2+XrpygKFOw9VfubPdK37scJV
 z+TYa34/QTfw2hVsOG+MGcXwDXmaAYN6UbelglLQP3rgoIbtCwwNmgUTFp10Vr4Pns5+19VuP21
 iqv94NXNPIv5Uv4+To9V6tYKdwyH/vsnEm2sz009KXI3QxH2hE4GM2xPd6GpPRQz/Pd4pMukHkw
 5dGFPtLXeM9xqwASAlX6RKm7ObDfE3FXsm5DbGVCLOwKPAL16pachKf6GymHx7kZrMPlfa6mbpJ
 u3YUXl1748DviXC93iMAfd8Ya4Xy4+NtxQlehg7UJeHNZra3dadBUvH3uO2Bt0rw+rvmWxqwqjU
 HH3H7J7sIQP2ZP5SnBftU2tupuc3Pe5gaKGvVW0+k2fmfCw==
X-Received: by 2002:a05:620a:4494:b0:912:38a1:1273 with SMTP id
 af79cd13be357-914b48c0d3cmr316908685a.1.1779449458108; 
 Fri, 22 May 2026 04:30:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:912:38a1:1273 with SMTP id
 af79cd13be357-914b48c0d3cmr316904685a.1.1779449457566; 
 Fri, 22 May 2026 04:30:57 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc68e0ad1sm43764466b.60.2026.05.22.04.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:30:56 -0700 (PDT)
Message-ID: <c67ee441-83d7-4b66-ab19-c2c282c1b354@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a103e73 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0nMKL6qGrdLAchHWSpcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ck0kC-R2of-ThmU86QZmniMEyozwGjcp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNCBTYWx0ZWRfXywkPMe1uXFPL
 csoZEEF6VnUfdUtupWCBinzOFcRc+ZMQoGXxeyZUcrhlPx9HBk/IpRfGSYLTJDA0A5sv0i+2wqf
 Vzd87xfBMqcoaEw09kS9zcDqMAQMjxqapC+sUG83GEq0UM30EcOe9EEafkJUsBv66afLom2Wm8y
 1PbgIVTT5BBsMIgTuRZk0WQ66VSKTe0KC/G/nqwHziX6sDPL52AZElqiOOmdge4fKFlIoGqK0OW
 OEvXX4brgN6Y0eOtFQRPU5DuKbFWJ3aVZoCvlnB2oe5KbpZmV6SHvGfRFhz08fimEfM5mhq2OLY
 BJertZORpI/0RXpdtPZrrSNFzssIhYoOCiBcSnFTWbQ/oyXmeJLqvHSrEKu6TsADoUsY4ghUIyl
 JTMvk3v0FtHvIvfDNVne09V3ziJ/TQPJeiRQza/EAzQOVe2QR+9wnHLFSJtuDlceKCQaP7Yc1uI
 wtyQc/I/Yn9p0q7VPfg==
X-Proofpoint-ORIG-GUID: ck0kC-R2of-ThmU86QZmniMEyozwGjcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220114
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Instead of relying on the link_ready flag to specify if DP is connected,
> read the DPCD bits and get the sink count to accurately detect if DP is
> connected.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

There's still some trailing style/documentation feedback here from v3

Konrad
