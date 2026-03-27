Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946E410F284F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096BD10EDDD;
	Fri, 27 Mar 2026 16:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EbUg4P1o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LC9lHaj6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9F210EDDD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:50:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhHDL2769230
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WhZqUgLrglsJ9egt0HZnkgp125uN+lGRSaHje0okr1Q=; b=EbUg4P1oYi7DXLRB
 2j3XKWprS29EgjELSgLJM5Mh8umzYzmSocMiZbcpF33ehKNJWiX7LtyifXaK12Oi
 dS5aG9i3ojdCLEmb2EXHr6EZHh/+40fkI4I9tvkHAfFU2afPyQToUO5VpgtWvskS
 daETKtAzkJHH4l5XvzlRD48ScQnmd8ZeIZiNul3kbFagpnsb3Vuqru/EnKy1f4MU
 +7P8SFVn6YNzr+ktRWRQc2zmmuKTc9Sy8iRl+k+a9vyxX0VH3tpQnFLtJaHjvg5R
 nIUH7UG3Myes1PUerQNQiszQkBT3z8pR2cduCtpq5GKzR2h8eE7/2nEq4X73Mm6A
 8cuE3Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv3x0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:50:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c1030ca85eso2619506eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774630229; x=1775235029;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WhZqUgLrglsJ9egt0HZnkgp125uN+lGRSaHje0okr1Q=;
 b=LC9lHaj60isK8dH28RYLIDmA+EdTETXCDzOum9eE5SzaZNAAqc0YPsleL+uGGLX1dF
 m9frVySg998ne7tWmvmsSsrKYdpzr1ICQXwz+WWbSwCJUXj08nsxeeIPPskkyo7xKaO+
 FuJBtNB/tRVtT0OHHjbqciFIKd/hoRvxqO2APloTDPKY9JOfa+zqD5WFwgF+nMLbV3O2
 tTU9cPmIVeXfW9EMeGK+LVwl1eQL5eVV7STe/zEJ+6luRC57c/oYdL9wDt1MZHpi/4t4
 q2cZSnUrebPNgSIjYSS4pHAZxYE1fUU+ZoI3LlxS3trQKfuK9KC9AoRs+++hZ2olaF+O
 4O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630229; x=1775235029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhZqUgLrglsJ9egt0HZnkgp125uN+lGRSaHje0okr1Q=;
 b=S4dCL3vvSDkhRNHL9JCEV09HoyqsAw7S1mDdIiK3GG3cZVmj0he9mN+oG2/ztjA+QJ
 9ZMlgMFQo+6Zh84Qs+65lAzQXMMx0wM85hcUGntt+hzDCH/lewHMjixejW4q8OgMR915
 7hJMhUDxg62MBKNIsicQQgRGWG1H5B6n+2Hd1ueM7aaJ6tgfawBTMJKICsCTHtGWSe4f
 PonCaeOY8HP8oKEzvNGLNbVb8lGHAOONSqImwtC95kS/jpf4+CA+csRWbg98nvAlz4Sc
 lVal9qSA/pDThnBElmZQGkenBrimZZdkdsfOqkALNyxBizPvUqekJZvVwPzh7hxs7wwF
 jIjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGBN+qiAXlSosxNXJ2SgVjbjnnyiRo5kjk+4Fql9kMcubTBg8xTJffrZjdCdgzsSVKex7be4n2Ifw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM2pio2nXNe4RbfoGZjkXL+AZNVb51YDJ6y8hBH3AmRTcpGVKO
 f2mAGihIWdO8cbDj4xXhdIkrvJXCjD8otdcb01XebVZEts/gt1B2ENodK2FssPM7sQALcfQOx+7
 F9qGijn5DtApu8K42v/wzXVNP3houC6xcr7L+r8A2x8tzSfFg23jjGEuxyrOZYIqfynYRn33jFX
 7z7Iw=
X-Gm-Gg: ATEYQzwo2bpfcQ4Oi0hfSHiZAPxHstrim+zsvYLgrhk8k7IP5DdNclrJCTI45/mw5di
 rpP1ml67ay3qGeuBJmGHz3XOuV4x1Gl0DX8oDi4h7LGUGAfrB64RgkW7d16YxEXrtPHBwxaVwQt
 RWiKP9Ut0B1mvvVh/2aNBx2zueBziLr0jXYXnyzKqb5kAa4plPI7mnYZL8mcaLK1atrEPtmskin
 C6qVuJLJzh7Uj3EtfviSYcK+YvnPtcXJSCtZTA5qwOg68jNlLZ6c712WqO5lurcdU7GXatPOgwH
 OFVCAcSUvAVbO9aixKo/747pMl4X+unwIWtuW1fKr3Z6OfspmG4OQlu/BSztMA4N7CLADX5fRsD
 5+2aTYIuVdjCDsW3Ms3A0mlA1J0IIgG3rmnaYV7r8ZimLdpeaLVCkdXzPowwY0W+rpcZHOok86u
 0=
X-Received: by 2002:a05:7300:4348:b0:2c1:6cfd:73f3 with SMTP id
 5a478bee46e88-2c185e4e940mr1661645eec.27.1774630229296; 
 Fri, 27 Mar 2026 09:50:29 -0700 (PDT)
X-Received: by 2002:a05:7300:4348:b0:2c1:6cfd:73f3 with SMTP id
 5a478bee46e88-2c185e4e940mr1661616eec.27.1774630228717; 
 Fri, 27 Mar 2026 09:50:28 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16edc0436sm5516661eec.22.2026.03.27.09.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 09:50:28 -0700 (PDT)
Message-ID: <68679ac8-d914-46bb-8eb8-133f381934b4@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:50:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/qaic: Handle DBC deactivation if the owner went
 away
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260205123415.3870898-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260205123415.3870898-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c6b556 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=TB8fjEhHHLHokerti4YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: dkIz8Fzuc0xU98iNmGKLj8lR3cVDsFtH
X-Proofpoint-GUID: dkIz8Fzuc0xU98iNmGKLj8lR3cVDsFtH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExNyBTYWx0ZWRfX08aEi4zwo5eB
 4HJHXvn8qd5MqsvwSSHSBGWceS/dForKoLIL1rvmHkXcsv2+5epCuYmZA/rwW9Ao//NP1TqmxaX
 LBM0fkNaNHIRRT8qhUbLRgeiACmGoD2GSHz0Alw5HYEs2oz/Oq/8gWEiVN76CrALdo32taGZsQQ
 kgzkiaWN8d5xNFv7imQqeoaYffp/h64hTec17nkN9qD+zd1CDLdKQgxfyiQryXYIsPR3oh4f0dw
 5vqw5uNPXCjxEkQH2pY8GOGaHTuE7K7zYmphrJIiMjSYDoPNdCQCxDjBV+gYWtRz514JmVb3qpm
 trL3iS90NX9XW6c6zTGTDmdDv9rS48b97IyiGK7YnpT5Teaiugu0AEY68SKnrHM8x3bp/prSGzG
 OlIy1BM7/MpgG6pvYMwQVqzxIhRg9Y6286UYCM2Eb3qJjDBWnksA15/KKMZ1EaGeb6KlUADblyX
 PA8lTIT3MseZhbxeO1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270117
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

On 2/5/2026 5:34 AM, Youssef Samir wrote:
> When a DBC is released, the device sends a QAIC_TRANS_DEACTIVATE_FROM_DEV
> transaction to the host over the QAIC_CONTROL MHI channel. QAIC handles
> this by calling decode_deactivate() to release the resources allocated for
> that DBC. Since that handling is done in the qaic_manage_ioctl() context,
> if the user goes away before receiving and handling the deactivation, the
> host will be out-of-sync with the DBCs available for use, and the DBC
> resources will not be freed unless the device is removed. If another user
> loads and requests to activate a network, then the device assigns the same
> DBC to that network, QAIC will "indefinitely" wait for dbc->in_use = false,
> leading the user process to hang.
> 
> As a solution to this, handle QAIC_TRANS_DEACTIVATE_FROM_DEV transactions
> that are received after the user has gone away.
> 
> Fixes: 129776ac2e38 ("accel/qaic: Add control path")
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Applied to drm-misc-fixes.

-Jeff
