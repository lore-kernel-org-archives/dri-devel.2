Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5E2F459FC
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CBE10E9A1;
	Fri, 10 Apr 2026 17:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMMvkIPb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hadJNWlG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0393210E9C9
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:08:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AH89o01498616
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HZOxmQZBEOeXvhjn2YgqcFwzqbzGVvP4E9vnaq98S+Q=; b=gMMvkIPbjfraVc7k
 lzHsqHWRGylCZTg+gypgOLgoLjcoluVaAZvoRUmJf2qaOczDDJdQBDH4m69wcwBG
 ge8eKFh0i/Tse8glkYs4sCmIcgvqcrsY/Uc7aErrOitbqRPSMwbKpfVyl+4TCSh+
 2Q7HRZ+/VO22l+WXLgZ41sF1wJWPysKK5m4k9WbKnAF6ZWW6WL1FAPajOics46Y4
 0qJuwtFCaE+QmnKvkEIA/oxEG5xiNf5VPOYx8FsYuJFVu22fJca1LcWXQNHCMcVk
 uL7Q7mGYb0+ms8ZXrKzp2lSAxnKtd22h9iVMSrlN1C+W1chf8naN+cHdmFaKKyPf
 t+mnQg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b18qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:08:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso2821022eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775840925; x=1776445725;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HZOxmQZBEOeXvhjn2YgqcFwzqbzGVvP4E9vnaq98S+Q=;
 b=hadJNWlG6J2gsiNDR70LHh4YreXTGGlzxGKXJZXl1Vgrj9pYPfTqppxrS7XPCqKYN1
 fxJUQTaCAIX90AAT2nkY1fOfp84+DGt7lZFtAmx46TKXUn6NSrZ97WSSnFG0xdYE//3T
 tE18HoPdt3521/M1hOdGC5suovPfqeF4IKXk8pq+UDwGkpUgYXpj1gIjZH0mxBNeDpmG
 /kRP242sJegys+xOMoLzoqQyTqXAvDP/BfcEeF06/91C4E+y+TTdUr9GjROWBdE63JHy
 0oR/8NxnbMOPaG8BiJjClxR9BFX0svziYorKfgsHQZDgFfoTafPyZaBr588wD0ULXuVv
 BYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775840925; x=1776445725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HZOxmQZBEOeXvhjn2YgqcFwzqbzGVvP4E9vnaq98S+Q=;
 b=FWowxeMykJGrWkk5euXgvb0MPTFLV5d8jMIwLTZpMqv9o9XPcr+tzufCsNk+oRZkaZ
 uWwRZrPQCMfw6GvVeJ/24RfPoBvEqmL5ox47rt+bNIIoHSD5INQ3U4+gSd1Ek1ueqYYM
 O9qG+ivo5KUcAHhrhSm44rdvQFGu8vxCubhNLcScFd3f5cKJgvnBwn0o3Pz9fH9V47wh
 6X4wHfqMrif62Z7S8k8URLYZTV8VY4oqE7vp7x1A68htn9wGmgcTPZSvcsXKrPIkwXYo
 P22I/y9J3Gi62h0p+chNwXk4SxOd7uJDmAHx3LqOQQVKiT0FZKXeRsqlgoXydOSSZgOr
 cIhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIXGWwpuKAUFR+lXeoxvIUZn+a+wH2HIMv8mpvnBlrzHDB2HsOv5TcuVhrx0z+n+NiKtKAujoOtfA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8SZdPXNqg1eQ+G+XQEE2DkE80qfww9FagcDDD+foFJzKYC4Ts
 ejD0cr811tc8RLmoMZKg9ZBILLkYS8aoariW223VaBLxI0k9wMfa7M9AaYxBccWFySeGk0qvupW
 /pAeojOhc3//zEpkcv8q8lWumElfs85tGmZMS/b+5nqblSNxjZFN+8ljMU7SUEG/QHoHe94k=
X-Gm-Gg: AeBDieunxtwrdbyB3V9RhAmlp4ddbSWYl+c8X6eYeWCNRk7oZqCZNyLRfuOJJawCkwI
 8Midwqk+Yy1zk2BTK5tbWYg0salqAoyW6gArh3oqiZ3nZHNDg/JA0YRXKfjRTT3IFrMdn2Xp3cD
 V44gbBbXy1h0eRD4t/vOLK59QP8h63OK+B/WW/mKqiUxPPIYWplUzJRpf4lrQXqbqJttudkPqme
 8nkEjd0uvqL+u+jklEV0rX+oGfVymYCGNnzoiIU1sd8YdDvRkyulfNGUyAz0b4Q2/bcpki4Dpc0
 /7jYwNZLHPd1uOQ/8USIBouHeYsjgk8yHmtkY365VzfGMWH6q8OZqMeCOzgBv+GfU+V+Cecnjp9
 0e1tGHPw9Ff+IQ+QYDOQdA0QP1grV57iLdSFUUpJHeltpansnQWJ4xRnD0lU262NPsR+K6s+Qat
 U=
X-Received: by 2002:a05:693c:3116:b0:2d5:432f:1569 with SMTP id
 5a478bee46e88-2d5891752bbmr2332808eec.15.1775840924844; 
 Fri, 10 Apr 2026 10:08:44 -0700 (PDT)
X-Received: by 2002:a05:693c:3116:b0:2d5:432f:1569 with SMTP id
 5a478bee46e88-2d5891752bbmr2332781eec.15.1775840924302; 
 Fri, 10 Apr 2026 10:08:44 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde68bsm5089493eec.17.2026.04.10.10.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 10:08:43 -0700 (PDT)
Message-ID: <aa92c999-2d0a-420c-92af-92540a27027d@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 11:08:42 -0600
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
X-Proofpoint-ORIG-GUID: rmP4ODyItL3u0L9zdI-eOounSr1ztQmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2MCBTYWx0ZWRfX0sG8/kyoqRWh
 vTUYorSA8ZYxu8O51N5gW1vYB83xvAPBqkrKoMhPjROVPebjmdpWxnOrLTWgyup+bVumwCDdmJS
 5NYinJRJ1JIbz4lU1XYpczMnCfIR2iY0yLm5HPqBATjr4cYxB7vlteiNtVudwrI6Yeu30aH2Eil
 BufMTDOi9PFE4UAQhx2WqnvqDuaOJkcYRlJCJt3G/e6iZbiIlZTTApF/TXJ366tCahb9MBV2aEM
 lKL2ind8lPvF5MHf9jEu9T3pF3JFkR31DacvbB6I4ew9tG5xrMZ1tcFkbNJ7Q5Suil375sr1cdf
 2QhqkARH4fsdWDVgU92lSpeuLvjYLkDF3e5THGHV5r5OYzVo+UJa51w5RT0caZvOpj7tOe8dnok
 HPLIY7v30ewL1PTMD3QaZVe55txXU2MpuObcRbxccecKY9u6bZGBnb4kCPrgKvStHgqSFY4Q52U
 5JhtuNWhGMDXJiDQvnw==
X-Proofpoint-GUID: rmP4ODyItL3u0L9zdI-eOounSr1ztQmP
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d92e9d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=kkqwuB-7APtATm1xqVgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100160
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

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
