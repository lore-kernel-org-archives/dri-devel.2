Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B04BFF60C6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A33C10E07A;
	Tue, 31 Mar 2026 06:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kokq1RFs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dd/VQeYR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065A410E07A
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:12:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V1v1As1402784
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p0aMlhT5CZN52Oj5+/T8fdKML+u4mpyZcz2vb8Q0plg=; b=kokq1RFsXN6BZ8/o
 NzMi3Gq8qs9EKhtw4ecMQwOPRHr60bkmDsPyJf5ff9vT6gjnfwELnOgvPtQbKzq+
 1yL+hD2Ja1/zZ8N6+XfGog03osTPT6RnZM8kY3gfnLgkynto/Hh9qE7w3AQuxfDf
 2tgzluGu4GQOYgaB9LlydO3O5QKNdsWnJ+ywW+Au2VCf4iPxDfADRnJCJ3nbzC1R
 eVi20vo4MM7wyGDXwPfAarH8iqArka1XWluWYmPXa+d/rNJtDre9HLW1R8FaDVwN
 fYzGlJwcJUTKk8k5RZLk/eQIZ6lH9XgLYyj1e3CFov+Q1mu3T3TToIbipdMno+UG
 FQDOkw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4hbwuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:12:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c1631e6189so26429389eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 23:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774937566; x=1775542366;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0aMlhT5CZN52Oj5+/T8fdKML+u4mpyZcz2vb8Q0plg=;
 b=dd/VQeYR7G4+tBtSLaOXuYKeW8jgnAiEIR/grN4mcEJ59bVnPH3WJiTNoGtQBzGKPV
 aYT3OQXvzss+LvcRd7s2P3QmVEPNzHwosdcHiwfuJ3UG5SsYefYlY48hHustVXDNe3aZ
 OodxiO1mME9a0Xo3t6voNmFrrnM6797BG1LwuLJsi14AOhlVxy7S8YTm/qjj++/Lthst
 gVa2APSCi97J0Vn1QSE8ebDWy4BGLL4IkDycrZ+qFHwvVixJjZag2CZCe0vYrJ1T/6kl
 2dqzIFDoAiNHqzCl25EtFfmp15s0EGS1ZhWmUzxFxEhPI61MrfSIjMFyfibFhV3Yva1R
 TdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774937566; x=1775542366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0aMlhT5CZN52Oj5+/T8fdKML+u4mpyZcz2vb8Q0plg=;
 b=aiBpvr/nUAwkA63R8/scXp0RfCzmzIBfpTjNnbx15CsqHLi/WPmZoXhZEhRAhlAwf+
 LsNoxNx8bdBgJv9ikmM+SmwDwOH8zuM3cWIZxWp84fj60OQGWw4uw06aLoDYFpG9+adw
 D8ZQ4+00kVnvC9XIaYDHA9yawx2bzR6fWKDKR5qdwWahUjc2RMB8yTgIIBPbH/8VeWLy
 Kxbu5s10IzzpmZeNZkTItJ3Gmiewx5m2/nxOvWZ4J7784TWRneWdDeGUWHIiQ6b7BdMu
 aYpf4hz7zEXJlCGRdEK0DqlsbElfdc8bytINehK8K1mZrhhTb91bsKFTJYwOsfi9/KCO
 ryXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwA+pEiT/eRxH2+k1MM5pJ4YXzf9v+hgkksYThN1sxr0X85IucgZbKESf36C9sxiY5woQ4XEe5JxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1SG1dKsyhn8QmxP/qhdf1qF4ngBqjFhPc4Mu4LTZMI4aSs0P9
 0uEUPGZVCcrgOfPKxP5KotYGgR9UVvScF0eZ/1ikTLo/EyOBet4pmcQFXyHCEDXPyfgi8BFOr2V
 jlMSvmbcnEYmiyIPUDY9PUd8KQGKLQnBm0qvDWDcwLBUdW4sprTwZ64/77MLd8mupjStdljg=
X-Gm-Gg: ATEYQzwy8iWlgo6QR4zLMDX1cZ1g8SxtchfswBuxIZjrxAF3QbLqqGYFKomrMmVxv3r
 I7tldWGJlXupTM/PKBJ4v/AcY6H75xAyLdxZW/hNLAQ+Iyh5OHWLYkgmjNOf01mPc+1MxLN1BW4
 +AfvBAEyuChfLfdnBkIo5dvrIfopL7HZd0LSXvJX2GvBNy8A+OAbttePh5Ai/OXlEIGZyfS/jvz
 VHzJ6EBOdh3nm0xFhV2+JY193DNxuAJj4sYDMFjiZMejMmGjF61mRdHsxgmmK/cUVMgAt/LG3+D
 K8RnAlacx5E9DPayu8mPgqu1j/tRGr9YdPvXLD5FDu+Y7Vs6vN2OqA8Aqe6FzItd6TfKQrlRytP
 bYEpAgC5d3p1lb7E2TxOsvsVktP1RrOATv7k0FoHyNjJQ2W+MVEYlTIgGnb4Ezrb2pdbWOem4EM
 8=
X-Received: by 2002:a05:7301:129b:b0:2c1:5b23:1752 with SMTP id
 5a478bee46e88-2c185f5a3c7mr8288630eec.23.1774937565756; 
 Mon, 30 Mar 2026 23:12:45 -0700 (PDT)
X-Received: by 2002:a05:7301:129b:b0:2c1:5b23:1752 with SMTP id
 5a478bee46e88-2c185f5a3c7mr8288620eec.23.1774937565179; 
 Mon, 30 Mar 2026 23:12:45 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bda306sm9310625eec.3.2026.03.30.23.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:12:44 -0700 (PDT)
Message-ID: <dcf02dcc-e49f-4d7a-8cec-95d177b32336@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 00:12:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add support for limiting NPU frequency
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 maciej.falkowski@linux.intel.com
References: <20260330083815.1806045-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260330083815.1806045-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA1NyBTYWx0ZWRfX0INIen63ooII
 m5phFVwpIn7G0wIYYoCeCeZplshfWFLj+JrFkqyiCHv27gayMiv9680UMXDTBsydxAyZW4coGkr
 buEKAoFYI+aPDPT5bGdvzJ0sRKGSJfMK28dZhoOwpq/NvBXmwyWCcvCTXOy3X6CUcFTBlCSnh2S
 39HBR24m7xwgfJZJN0RzdYlUVBnE/EdNy+PetZlOmMsDiJQH3t7mgdkqSM2gdU/ry++zVmkttPu
 YfmZrX2JNPkFQK9S8bmUQNuMb9Wu3WPt2/fdTWqHDQWR7oEMcTf6PwV0D5Ppgf4LkFWNBem6tOB
 LX6Y47Ftg6zaEIZF3z99MzNzU6CseZYfpImReCBfsRBh9D64VJM4nU2frbdKF0CtMTIYUEuvyli
 t5bZSvm9SRxcyX7JB/sPLNH9Wn2F5L+WRvnuwlos6rgSyGuB96SUMXKHWAeObIeWxoI/I0UwpCX
 oSzTROoAOymyn+zNkQA==
X-Proofpoint-ORIG-GUID: kdbfC4db9ePwGFTxN8FpEYlLgyxy-y3g
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69cb65de cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NADDITVvBtDDP5XKSyoA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: kdbfC4db9ePwGFTxN8FpEYlLgyxy-y3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310057
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

On 3/30/2026 2:38 AM, Andrzej Kacprowski wrote:
> Add configurable frequency limits to allow users to constrain the NPU
> operating frequency range for power and thermal management. This support
> requires firmware API version 3.34.0 or newer.
> 
> New sysfs interface:
> 
> The freq/ subdirectory contains the following attributes:
> 
> - hw_min_freq: Minimum frequency supported by hardware (read-only)
> - hw_max_freq: Maximum frequency supported by hardware (read-only)
> - hw_efficient_freq: Hardware's optimal operating frequency (read-only)
> - current_freq: Current NPU frequency in MHz (read-only)
> - set_min_freq: Configure minimum operating frequency (50XX+ devices)
> - set_max_freq: Configure maximum operating frequency (50XX+ devices)
I don't see Documentation/ABI changes in this patch, which are required 
for sysfs.

However, I wonder if this is the best way to move forward. At best, you 
appear to be implementing a completely custom version of hwmon. However, 
I wonder if hwmon/sysfs will be limiting as you support 3 generations of 
devices if I recall correctly, and that number is probably going to go 
up. With the different generations supporting different capabilities, I 
suspect the sysfs approach will eventually put you into a corner.

Your collegues over in the XE area have proposed a netlink mechanism, 
which is in -next currently (expected to go in the 7.1 merge window). We 
collaborated on that mechanism, and have plans to extend it for these 
kinds of "telemetry" items. I'm expecting we'll have some patches posted 
on list in a week, maybe 2 (finishing up some of the final details). 
Perhaps you would find that useful?

-Jeff
