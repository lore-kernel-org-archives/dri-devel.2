Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7272A10A88F7
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69C910E956;
	Thu, 26 Mar 2026 17:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTF+97R8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rv7iZUML";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94ED410E956
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:54:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9jmc3898356
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lJ8HtteMMvMlhJffKR11CdAgvrwhXQNnd8G5HXi3zio=; b=VTF+97R8d1vrUy0h
 ZSD/rx+xUZ0ViyIY0boV39RaKQJHTV/7ljiDG6Vw1XRrvI3rhN8mWLk3bb6bsUd1
 hXAmsT6nmH7maEeQNUT0rGr+suqTnzb0abZ/Hgmt8L92FvAGoOL9T1OKGWB6R6aa
 PWc+zxHugQq/OcaUDIQME1oz+oL085urVjmz0j+0mo+c5wSrkMTWkb7bVIkrtQds
 v54VXayD+LF/j4hHElv3RVGMW3Un5OH+hnsd7/OaoTMBb2SH7zgLe5yvGut4OmjN
 exQ5p51mynpO4yIzml7n0MQRWWimzBMdz/V5xQ7c4yYsBe/3q/BdKx5Y3CRGVAIb
 /3MZWw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kga6wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:54:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35641c14663so1726454a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774547689; x=1775152489;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJ8HtteMMvMlhJffKR11CdAgvrwhXQNnd8G5HXi3zio=;
 b=Rv7iZUMLxpSuAldBUV0uSV00d0KmUaxp7oBEiYZ9HkF02y5MFjod2RAY1O4FtKLBqr
 3u7WD5w/RkM5aaXvhz1MZgaF05MbApr42T+j1hlRmrrblkH/YPvf1vQAsd1+xMXWuOBo
 O7AvIfDn1MFQ47Kw5h7zutqRupAqkI/dBH6KSPpKZzEl6S/wn7NDRGLm7MwyIucuNjnz
 t0wncuCcMR0aOPVcuAoeXkGbChRRyhCFzfmV7Gp1l3Q3pGUb9Y+X0GGViyj8HgbdLGco
 p2vaiVTgmjP4KIQ65+pFUicRAncqz0v57Qbg7uPk+O47hRNNVeI+piGo4dc2nlTQUMeC
 0z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774547689; x=1775152489;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJ8HtteMMvMlhJffKR11CdAgvrwhXQNnd8G5HXi3zio=;
 b=JzTNfu2OW9lcGEJGT093ZE5etIw+qNC0NoznsoTUZVJ71XS4pdRtI8cs8t++WKFtat
 NR+lDZyFGR0g9VnCwV+7BXh+Om/kqAYevABSX1+d0BKfMfxwjhVSAvUzk5Ij8ehBhd6h
 RZW+lCshrlqDUZLShkon7ZCszFOy4dNGbhsUXjGJc0jUAglG1PCN58TvN3weG8KtITyQ
 ddPcKB05o3HESk2FW+NPQCxsT1InVnIDEdgXZ9wWdOx1XQqGQ7t2Ui7YdQyVWTqS7Ext
 sC5rmuw4SYTJgbpYBg1BclbX40cjpqHqzcl6KVxhQeZk0ncwJ3dgoNUiMG+L5zSit1Mn
 7Wqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmJa1kmU4quaPzOKlPyfAxEskj1sYiDFpeXI7IHx+dt4hiarBW51l3oKr+QWQm71/AL7gkpv1W+os=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5NvT7eW9ft86Ofr4JuMqVKL85Y2ra5RmJILW9GLXSsKNq3tNB
 jz+sZyJUwL08VOee7hOfpx582UND+fCGmkGY7N9sgt2wYdGb/iHcxuWNW7bW6eLOEdNeWVivDRd
 nsJf1A6+i5NgtRJKKavA+jXW7IYgwr0nnsDF3J84bgZheflFRJyRyqEEvd85Y8qc+N4TliyA=
X-Gm-Gg: ATEYQzx74FpIQYFGMF88czwOwiPqrak3biDtcYXL2Y5SgJ9Ai97fxIj+YPL6OKc4Scx
 G4pPCDZ4Tl3aduMEPTyFvVyyaq55DFBldSIZ2mhkGdV5Xxbn4DlNXTAFkuVKW6vuBoFE8K3MwHG
 3lmNawq6ttC4Lok6ZSd+yMIy8Xzy9sYSe1BoW4/5dx+du+kt5v0Px/D6Ct3vP3kGRReMakyPSR0
 Uv+1OIpDi1JWtY2Meyt3N1L2V11vczlhjH/7SJfy3D1PjlZ3SjkaiZhD/Y6Tg/DI8v630zuQhbe
 7CaryhMkKiNLoyXC+L5OIxd3fVNoeJIqkOhINLfdOjs30OTD3bD+u5NWUlxF7XDWqI53o/aR6tl
 PGL9q5bGbAZ+0Irj+MCXNUhdmK1kdhA6OGk9MNkJgxCuq
X-Received: by 2002:a17:90b:4fc4:b0:355:35b0:8b78 with SMTP id
 98e67ed59e1d1-35c0ddd9d68mr7285489a91.27.1774547689484; 
 Thu, 26 Mar 2026 10:54:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc4:b0:355:35b0:8b78 with SMTP id
 98e67ed59e1d1-35c0ddd9d68mr7285462a91.27.1774547689017; 
 Thu, 26 Mar 2026 10:54:49 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22a82231sm3600247a91.6.2026.03.26.10.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 10:54:48 -0700 (PDT)
Message-ID: <316826b2-2a72-44e6-afd3-dda3ffcfbc97@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 23:24:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] drm/msm/adreno: Implement gx_is_on() for A8x
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-9-fc95b8d9c017@oss.qualcomm.com>
 <b64447db-bbb0-4457-b803-ebb3eca26107@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b64447db-bbb0-4457-b803-ebb3eca26107@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c572ea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ItQdk60jCWHXMXBi9I0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNyBTYWx0ZWRfX0AqOGFK+FBNQ
 Z+/nyFWgviaZ/E6b/YyK6kOY5cAo9F73wM85hqM4Kldd/ooHIQAHscEzExwtfzuNtMWcxrmTZGR
 F2yjzXtV7Ojc5OG4LRrwXlRD2s0D7koJyFZd6EY2wLo8lI6C9/+Rf0SNc9s/BN0okv3ZireUDRt
 T544kNRngtOzkcvxmEJapo4+vADavCHACFkdwyx/i7TeJ3pk3nAL4pHpNl5r+HNwBCwqBVeOZkN
 h8RldSIPUcubh/VX026tJDdwVKr9XEVRDpxfalHM7nTk8oNqhcrDlxyLjXxhty1rqJdf0dVkyxs
 n1/ep/ZYwR6b/zgYOiw/TzcxttC3v1w2xEnG6VSVDDlRqcPXDLe+Yikp/mDaXxI/5oAP2pHeh7i
 020X0IjFwxhYht2g3L8o8UVJ5NrJot2tHKOnAD9fFsK9Z2ireFdtXCxxvBA7HLj07nMtqiTT0UJ
 fnPg/G45IgHNwqjwNaA==
X-Proofpoint-GUID: jaPlyVSiZWusISHrMx0vS91QR-8Ugh9n
X-Proofpoint-ORIG-GUID: jaPlyVSiZWusISHrMx0vS91QR-8Ugh9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260127
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

On 3/24/2026 3:33 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> A8x has a diverged enough for a separate implementation of gx_is_on()
>> check. Add that and move them to the adreno func table.
>>
>> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Fair, but then it'd also make sense to do so for a7 which also
> ignores SPTPRAC and has a different bitfields vs a6
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Ack. Thanks.

-Akhil
> 
> Konrad

