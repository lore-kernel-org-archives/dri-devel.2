Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1CBCD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1973B10E16E;
	Tue,  9 Jun 2026 08:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfjrIVWN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xp/3ceeN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D82210E169
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:05:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rJEx1585631
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 08:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KiAcg4GZAcbzhQVB9wJOqt7JXLgCAxLB5dfBhEJmHiY=; b=hfjrIVWNvvFu/dyF
 YgGS0wXIsycLqAA77Z9hRFVllzKDuZ0FPJkDhUWIgHuMOD1Yfk/fMzSaTz9Lt2Ao
 tuEw1OmRP/zHhNwWYga3pRxB66x/9PaTuL1by88qCscJBNUCgKpvTf1qcMAwiTDh
 kjw44qn5TzeTUmCvPNG7bokg6EnG0VNAcgQOHNJpv1jxn2m51RQWJp6VLgKmUsc4
 YM0QR+dsNSR5s8pXPN8rqul5fCYi02r5QwK9fFu2r7fSqwU1/WZ3nAfyrjTGwbHi
 sKEf4zssoC1GZ35UlCxeR6wa+Ngo3TfWKrv3HGU2Dnxw9GNTgTX7CD9cT8vPcuqg
 f2gZ/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgg36q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 08:05:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915827fb1a3so107851185a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780992332; x=1781597132;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiAcg4GZAcbzhQVB9wJOqt7JXLgCAxLB5dfBhEJmHiY=;
 b=Xp/3ceeNB0PgBgZSVmJBoWNrlTmPeQGWBwy5v1APwGyf4K1nF2S7zNv4WoRUDM1ksf
 gK+MeUB+VcEfbu+bnptzTVrKZ8n9idczD51MUoRPF/oPHdIZG8AmZ5GPEOq0J/fVK8U2
 zr4pQ3BQDs+IL+LLAAgxJyd6yRi4EXJj+2OejvG+aSZyAuFb8R/1iJTYSyOpGOldPqjv
 WKvQxpiHGXloRJ9gf/KUfDQ9Rp+wnLO+MpEzjK8suVs7ImHxgm4RxCIG4PDxbC95AwLw
 dVbTtdTkkzMsXGXGY3z1TZurNpnM1lauq/Z3fmzBUunBPAyohREr9WgCYcNVk0wztHSM
 0vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780992332; x=1781597132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiAcg4GZAcbzhQVB9wJOqt7JXLgCAxLB5dfBhEJmHiY=;
 b=rDl2ZTg27MJSUzgtuD610DfvteC8I25PX9SScHO1JDcgklKP04Keo7DdvjzFr8uXSh
 mwYGOYS+7njLkh/SSEYelEt3YjD8B0WjQol+gYExEaVsgtqELjGJhEWB+6/LY4mpNNrq
 bAwcEUptvdP8fKVtm1JGVAF5cVRtbdzukxryKApDK+e9Ng2Nx0Ip/VzIC0iBMVxLTgct
 JfIay52XZgax9wTU00T8gXYE6gmuhxViHookdFmq4Dfx/RR9+/mS6W/L/Zw5fYv4hQgN
 fsbFYhwVLQhxRRoLOibbvqOeysy5MtsnotqHuiWU00lF2HQ5xVFgdLKphUC4yxTW4uCx
 A85A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3AET0x89ZW/YWhaMEvct8M41476VQCag0EJ3H9qracXdThoqMfq9/Ehg04PHOcGrig55cSs66Blc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yykq8aZEs09AcYqAbzdQD4LjE4snuCrY1HTRSuOfGdPzl4/Jyus
 UgB3z2YHgYgkrukNpCGagKFy746riiq7Dwhe3VG+5vY8/uRPfwG2kwHhSeRWFJm8Ei5/+jGxD3r
 YC9reREw0fptCsouHdlTswfy0plx21dRMhxMG9iAE6eksCxjytgHbCJAaFymEHMhMey4LxsM=
X-Gm-Gg: Acq92OGFsK1p3qsz8sL6/rcxHUHX7vbEIKJU+PDQU11EOPA5Rlv8vomJ9/mRQlXzy9u
 TJYP6WFsRUPq62FJypCJp2nM2BciDKOkjbkiNV+OPLgf0ZCD3v3r8IFHc1T+SMT5nfEstqYU0QZ
 ZVh8GAAJVD8eqhF2ir/Eaji8JFarVttNpgjAVVHOARqIvwVfzPEtFVFIfa9Vej9eE0JM20wqqQU
 hnQvk6JBl/Ueo36xyiFKWtTFeUqnO4VO6cNeumzmp6bH0TdN+r0prd/ESfbI8mnzzWHH5ARTPMD
 PT8dyBKcgCUsmqBMr+mb0K4H/N/HAoSAqinkiGCIHphgBtSsJpR+pugo2miPW9Zq9cWlIFbSW2q
 rYEn1/92mOpkC6frVLSkicHYEPzCXTram6Hy/a61FBm4lVuf5GX3A3ugR
X-Received: by 2002:a05:620a:1a06:b0:915:79da:a898 with SMTP id
 af79cd13be357-915a9e33362mr1730746185a.8.1780992332030; 
 Tue, 09 Jun 2026 01:05:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1a06:b0:915:79da:a898 with SMTP id
 af79cd13be357-915a9e33362mr1730743785a.8.1780992331605; 
 Tue, 09 Jun 2026 01:05:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf3e39647c4sm606892766b.63.2026.06.09.01.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 01:05:29 -0700 (PDT)
Message-ID: <791b0c02-e1ec-45a6-8b24-07a628b2671f@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 10:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/adreno: Add support for A704 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aditya Sherawat <asherawa@qti.qualcomm.com>
References: <20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com>
 <20260609-shikra-gpu-v1-2-9d0e09cab115@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-shikra-gpu-v1-2-9d0e09cab115@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NSBTYWx0ZWRfX2dGOdbdvWtCu
 4CtGyQygV64CpYDvKD2KlHjNByXgO3X9hvAiDEVwD4OIgLY32/8zSi53G9Tm+OQgPOkSYfMWnkF
 6dCbW7x3qDTMqwy6cuVPTCtVgkUEuB14PKCiiF1hQIKZe/VCFBi/5J1ygMs78tPQibpEXY7Sms+
 aRp3H9cp/lOotpytVYt5DEVRKHAyWRJk8y27dzrtPkjY2ma8eswUWPCN2Mi197VRR++MlAwY0MB
 VLrBeM9LMdbAdQpGN5E7hzrHDLjSrFCztdSwJ01QRqDiGoOXFV8Nq8XiiLecb2Q/1unmid4VfM/
 UGw+Y2GDVVMa9DXYhwalj5iUMPRCjei+irU05jyKS212jKQdFOqd6WNHSLIjxmZsA1bEIDyMMs7
 fJTl1Bq1ekP41A5X5YERzkKBteUun3N5Wtzk29thuGYMpPcXXNKLP+X/oKGXx4U80lqbURgL9rR
 z5VcAMt4j/ytWgWN0FA==
X-Proofpoint-ORIG-GUID: P3eooS4aFeocrreRQ5VcY7GOPKlCdSFi
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27c94d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dsl4z-DLeecaUYzO57AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: P3eooS4aFeocrreRQ5VcY7GOPKlCdSFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090075
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

On 6/9/26 1:36 AM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
> minimal changes. The only KMD facing difference is the chipid and the
> zap firmware which is specified via devicetree.
> 
> Just add the new chipid to enable support for A704 GPU in Shikra.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
