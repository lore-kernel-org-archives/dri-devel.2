Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4628CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069C510F8B9;
	Fri,  2 Oct 2026 15:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSaRz2gp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xsz3Hq9R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2865110E62A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:20:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGpBk1246238
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +cNF6DqGinBHxTriqAkA4kPs918oXXSZcLnUiTRImG0=; b=eSaRz2gp9rD7asIp
 yhfCF3T8CerMOjzVv9ccuc5l4JhiaiOL/6OHylhyB3Y1R9jPpRvoTLQ/GIj8u4oW
 IFL24hJjoBPl5Xw2sTwuKdWFkAfyGweTioWLo3fUlsayNyMzAGlBc+ZX3gFuaQqx
 AJzvHq8wzUhnsLBnxT8YpmpXmR5e6Hgh854OCTwypo0qrYGZYsW7Jt1p/i27GDOi
 X090K0FYlIGiDE8GxWTH6PxpsyamOAjija4Eq4vmL/CFa8+dLM3zuRi0pT9u4eXA
 bHBcynRhFwLr79Cp5dvkrv3mV7JippRpA8i8g37NZDh6rxA42B3GgCqrndVmKTvl
 Qlo/JA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d80n6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:20:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a6e2f00130so749376a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954420; x=1791559220;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+cNF6DqGinBHxTriqAkA4kPs918oXXSZcLnUiTRImG0=;
 b=Xsz3Hq9R+Bkwk9hbGDqR5dH0vaPsFbVmEwy+tBiPL1UTl6TmvPZA83OWmlC6DKT9BQ
 NuRdGo+juZA4165KnO54ehsjfJy5aGNPthVwMckz2K2NUCsfoVh/MqEV9EDXRV0ojIh1
 vkPPuOrNu9mPmn2npj4d+SLY6KUJZFX6SzPqKhlhtSNTwxK6GJShXnaS/YcWpLNS9Xrn
 DPFwbq9m9PDRhY/XptzK6JDsokRNNg16RDrhmg85cthoF6t4O9bftF+sUXIdXcEoVWFg
 tnTCDdVpFlRe9Uac7r98aclZq7K0x1fvxadKiGLBAyQuLD52Ak0I1ycbYpC6a3/Sn148
 +kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954420; x=1791559220;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cNF6DqGinBHxTriqAkA4kPs918oXXSZcLnUiTRImG0=;
 b=20Dkd6ZxAkqBZSiGg9kUKzN1ZNXWU4DaeN5SJTdUYG3/WEGnt7uDFlCD7dlj39uOA1
 32Vj8ZbXyUMfl8vOu5KiQmZtPsmbkq1O8LQZq9onN+3pwQSaw6drNnVOYOrSoAnGMnnI
 DQ2Bg1o0HyjN2V3eD8bhBLkVkaAp5A06mtMJN75cg3g1PH00A3AOGRzXW0CfusqIdVGt
 HcTJ0qVD9ukis+jz6ze6JpYREmiqV4VF4TPAUJM2hsmSXhcelAuxWjPGaNWGS/A8zl+S
 XDsqp4hym7jGPpk8fGcde/A+fRAeBPqpsi6shDIqzgKnmWS3XUjkZIa67KXISccIXj2V
 jU+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZEIA0F6NR9nV9FZquHBW0PJSYCD+r2gtR4z90fSFWXjEoddjpVFCYYHNFcHAposwDjrTRMXpt7eA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2ghBd8G0hulReWfl8yy6JHrk+iwO34RKl5rxcL3dZD15RavAW
 jO0BxNPENXBWKaRCqImxYVlf1KOPGJm6LNBZTZXcj0JzvFybxMgRLk2U6/adkaxs38zHSm+xmIp
 MqHYD7+25eH4VqZdi2ezjq0uLG8gCi+TQbUMGVVlmn+24rkdC1QODR0robrR45IByLAlTW5k=
X-Gm-Gg: AYBFou0bl2pIpl/d/8+9gjupQU1Sk/N98frKB/1Hy3hRgR3o+4RgECMu53ZwJv4nXkx
 l3CHOURiLGTDB6z47Pzcux5PU3uZ/qBRBq9rGAr6zaoFBW3fhe7vl+esj/xYFcrK+ll+bGLy+v6
 fnDA4jCU7D5Acbxwf+HK6eq+RtMRYbYxQuvvTeiWvPSgEuff60KftBP31As/vanVICO8RsNY/f1
 qH3YsumHgmAI7QErJiObyGLslCBcC/v6QXBuFjIK7Pvb7hkhooagFFxA8SDW9cW0vl9MkDBsVIo
 wN7frRV2HXnj0dAJiQ3Bu65RtzKV0A/kUSWzQxUsiYvrE+wjpDq8YAcVJv1m4Hu8M3E3bFpIuuq
 XAmDeZBOscF2afNN9nAqSnup72OKQVQcWD6az5AJQgiU1PANOcg==
X-Received: by 2002:a17:90a:ec8c:b0:39d:b1bd:b384 with SMTP id
 98e67ed59e1d1-3a6ce82068dmr2855893a91.17.1790954419750; 
 Fri, 02 Oct 2026 08:20:19 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:39d:b1bd:b384 with SMTP id
 98e67ed59e1d1-3a6ce82068dmr2855862a91.17.1790954419169; 
 Fri, 02 Oct 2026 08:20:19 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a7064e9135sm568071a91.1.2026.10.02.08.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 08:20:18 -0700 (PDT)
Message-ID: <d268d08f-7a70-47b3-a3b0-a9c59aeb5db5@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 09:20:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] accel/ivpu: Convert hw_ip_gen/btrs_gen to enum types
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 andrzej.kacprowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
 <20261001110401.2866557-3-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261001110401.2866557-3-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2MflEumo6kgvdG0MLzqwdNErwWti7Bfh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX4/u2gUAzEeHj
 sTidPVJYLJMTpyGE7KxXIMDU7JzwBLJmLWoaZ6hWQqv5pFttJZUN3hW7O3D8vj4x5xsjx+k3V7+
 +FqVl3HTYAiv9LWorj1rXmS03JkdXHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX1Bzg1Efi6nGT
 UsDXEzsxKNjiOG5CQK2w38aIorAcp9IQfASK7vWO7ePUiZOq1sBoPGUIySLFkKuSaCELS1pbGYm
 +1kI4piqk14oC3HUUKzNTOO0Je17IF8UhGxCRMLWLfuQVRdNEWejnct3W6+m4bQ5ZzXp4hrScGt
 OmvzBQVPv+CTDlAVNp8LNfoJu4MGaLT+x4e9m939RsWSPcQAcwBJXxUYTL0DU0OaloWayPh9QFz
 Mr7AKiFMA0mZqFvVUSbJ3ePB8ZdQjUr/v3P5JNZEiz+Lps9W0wgZ8FXHdzasb9fwm84+PdqJyRe
 wRM5Nmn2FrcNDN7yys+l5AK1z0JCLtT2BERL/fPAv2eDj1ECHbsWykjQ2woAOOZ2IkhY50ijyvE
 Uc+qTZejPP9OakyrzW5xomsHQ4ghoAofa5SUWIjcPMP3t1MNLmiSadZxQT1yAOWnsk+omaSPsRB
 +LHlWC/Rqrqo4wH2K8Q==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfcbb4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=GcwFH-Sl76LuZEjdcyQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 2MflEumo6kgvdG0MLzqwdNErwWti7Bfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

On 10/1/2026 5:04 AM, Dawid Osuchowski wrote:
> Change the hw_ip_gen and btrs_gen members of struct ivpu_device, and
> their accessors, from u32/int to enum vpu_hw_ip/enum vpu_hw_btrs, and
> drop the default: labels from the switch statements in ivpu_hw_ip.c
> that dispatch on them. Switching on the real enum types lets the
> compiler treat these switches as exhaustive at compile time, so a
> missing case for a new generation now warns instead of silently
> hitting default:.
> 
> This compile-time guarantee holds because ivpu_ip_gen_init() now fails
> probe on an unrecognized PCI device ID instead of leaving these fields
> at 0, so the switches never see an unhandled value.
> 
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
