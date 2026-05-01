Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6A7CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 21:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7833F10E1F7;
	Fri,  1 May 2026 21:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ekLosy8E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bazcXBZ2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3417410E1F7
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 21:17:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641IGUvW101939
 for <dri-devel@lists.freedesktop.org>; Fri, 1 May 2026 21:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0hISFTIH9qemc8WfsjCvYlvWtmbajff+MCxuRvrDDwQ=; b=ekLosy8EQdjCqU/6
 QUD1khqPnU2ZaUG0//YemMqM7854zqbZfpSEvac8mdgSVJldkvo4Cp8pvS3Sk0S9
 ZNgtSJHXYvPHArbevxPqwmzh9eb/GtdWT5aoaUasEVILmVgKPY/LSqlkXXKBG/Zn
 xhw5DGyylQKiHQCgXu734ZHJiVfDh+GlkGYnZ2TxrD3qQZobTUtuPb1kF/ETymAy
 pRA5YxVSuyeV0a3mLrYgcPRc/DZ3QdM4SXZKIXBTd9Yc82vJizpQTGXfNCKnxk9W
 BbauTyuxQaCq4desOUxG7IFcMvTg/YsFpT+pSKdcBJuJIyrWY8rq0xEpMuVJVCrU
 mvdy0A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw1a8reym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 21:17:20 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12dfb99429bso837293c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777670239; x=1778275039;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hISFTIH9qemc8WfsjCvYlvWtmbajff+MCxuRvrDDwQ=;
 b=bazcXBZ2Nu3RMwCN0fw7UXWEGNegC+7icuu2t9SxcUFC1Lu677ycPPNhE9CQxQUwms
 +1DhRjs9mTgv0OvE0ctk8MEMpqf9wvueQBuBNE6EBMjEvtmvQMEzsNjBF9vLbSQ1UUeD
 fqlHevuFSjjpOAWpGSTASaNQo9NEPX54F0zyPKkyo6HR3OLQSsuOAV4aThsvAq7GOujj
 sL+cEoRrt4qA6GPQbGrFZU2ddJuFLbS3FPPpr0kG0BAJNaGK+VHgvGVYjlGwYF8Q7d4O
 VFKysleqHCsOKiPt9KQAqcA1xk+t0LrlYxVIlguQRk3tRiFSAhSp5WpNxz76/FEYQQQr
 I62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777670239; x=1778275039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0hISFTIH9qemc8WfsjCvYlvWtmbajff+MCxuRvrDDwQ=;
 b=Xdikc7di5FnCR3HmQ22w7yZH74bsA/JSpwVvfNqH53FWzhqb3OEitMehCnuZl9BphC
 wZgS4tEq0E7AQkZEPy02PbGvBohBeg0Bf82BOeD7IFTOhyH0zLe7OALwOUBFeSjYy+9C
 HlVHBI84UtomS1LXscsitsYa7bCgwshk8DEMDaVNecFkQZ95nYWgMHpf38sMYRR70fWz
 FwqEm9KISLcgGM9FY+9s4hmVf/7btdaNQWFfGGlryePcbRH9AMcnetWmteGunsUv7guc
 ObkTHDEzb6mQ8pQ4FLIn9aY4r0B5TmC38C+2Qs+WJrWd2TfHdQudxFv/wQSuiMyey2oG
 kM7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Y277Z5Xux2qeWGlmezSDxi0xGt4HYpBKFdLx31APcOIHsBEUJzCMat4AyzZLx7TgA7ZDh83S9dtk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+anO6gjReB7+7+6HUS0ZR2ipbjSkxbG5nB3SNEcivkMBCedE2
 G4vB/QLY8ZkdDRGvwIW5PItm5ZZceoqxjB/ongHhZ5sfYS/icu410+5+ITwYOBO8iMHFlu8yvhj
 gy5mDArjXkNbpPjrLfuyzOTLHTcxV2JKXzrTd1g0yKHTCd+MPnb3fvZELSQoMmkQ8d2iB3Go=
X-Gm-Gg: AeBDieuxVoiH3kgoFW+SxCJMtUbvc8ZVNI11059HGf6Ve/p1ywwzRYVrBmuLETqQc33
 7G4vRzTkA118JzWczfEzbS26ZXOq87aHGP7A+3zMWYMDv/JVKx/YIPs2FKLJkTjE+Hf86s4jf9R
 CYLcfTr0LzdLLA6ts/K0i0F49NZgFRubDxVmgbiNcyoISPFAHsBxzXszn8iv9N+g5EM4sk35nFu
 hVH1e2hWh78DwSu8MCHz0tXxy8dgTkFPS1pLkVH0ei+Ej0WXqW38Fneh829JMy5fFAoM3jKm5aa
 iln/jUEPgg0A4WCzfvNqdrWjQi/FDZGTwCirX8fcbNiL+YLynY5y/77YyrKVN35FQ/aLe065DHZ
 7UBfp00suMRuYVKp25VIvfFaTzkgrH9aUamXQp6ffi26VJ3Zlsoh00JdAKLVt1qhZC9u7gYJax8
 CyA+zuYCU6bA==
X-Received: by 2002:a05:7022:395:b0:12c:8f92:c6ba with SMTP id
 a92af1059eb24-12dfd83ecbfmr389829c88.34.1777670239232; 
 Fri, 01 May 2026 14:17:19 -0700 (PDT)
X-Received: by 2002:a05:7022:395:b0:12c:8f92:c6ba with SMTP id
 a92af1059eb24-12dfd83ecbfmr389804c88.34.1777670238597; 
 Fri, 01 May 2026 14:17:18 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df82a141asm5540058c88.8.2026.05.01.14.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 14:17:18 -0700 (PDT)
Message-ID: <c093a2b7-1a2f-44ef-adc3-0612375e3433@oss.qualcomm.com>
Date: Fri, 1 May 2026 15:17:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: fix incorrect counter check in RAS message
 decode
To: Alok Tiwari <alok.a.tiwari@oracle.com>, maciej.falkowski@linux.intel.com, 
 jacek.lawrynowicz@linux.intel.com, quic_thanson@quicinc.com,
 carl.vanderlip@oss.qualcomm.com, ogabbay@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260410112015.592546-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260410112015.592546-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B9WJFutM c=1 sm=1 tr=0 ts=69f51860 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=yPCof4ZbAAAA:8 a=kkqwuB-7APtATm1xqVgA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDIxMCBTYWx0ZWRfX9LIcWiBuxS2s
 jV3yN7hxqDm3Qx9PPvTKhR7haxjB2rztaPYss4Kx4ObP0Ob8RGhCUZ8612sBTWJETkqDVM0ah1N
 TbZFGbIcEuEHZCbXHtOcG/y+M8YM3DCKen+GDAQ3umQeiS/eMiqmAomhdrhliCRJDM0adZYvTfA
 wFgoNAOSiHTGAmDOxOtTmmt34306kkmHs44Adj1x9SA41EdmwzX3bile/mGIpcUxow/rd9LOBFZ
 jSwrWf8mS4osAmvtLYQLYpXZNUCrPsuqDBwYerY4lJ1UwZdGSn/9Pf8G6gLh/bGQrCxPikiCpCC
 LyoitIZfNGcYm/h0pPmMDOxNeJHiUZPnqSHwPwAYzpdUF1zcKFJhJWT5pI0gxkDbOkbB6RTuzQg
 3tnWqVxHDcBk1Dwhr5w5Ucei4Ixq0StiwiX28cYQV+CcBlR3WUdPSvXn3zsOuDAeI0oi010qIqD
 8SmrW5Z6DA37gnZLFRA==
X-Proofpoint-GUID: 21pN9NlOwW1l-iq9H7Ho-wwF-dO238v6
X-Proofpoint-ORIG-GUID: 21pN9NlOwW1l-iq9H7Ho-wwF-dO238v6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010210
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

On 4/10/2026 5:20 AM, Alok Tiwari wrote:
> The UE and UE_NF cases check ce_count against UINT_MAX before incrementing
> their respective counters. This is logically incorrect and prevents
> ue_count and ue_nf_count from incrementing when ce_count reaches UINT_MAX.
> 
> Fixes: c11a50b170e7 ("accel/qaic: Add Reliability, Accessibility, Serviceability (RAS)")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Applied to drm-misc-fixes.

-Jeff
