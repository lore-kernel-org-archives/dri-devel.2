Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC9DC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7792A10F6B7;
	Fri, 14 Aug 2026 19:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dzd8g1Ze";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DM6+DU4Y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C82110E596
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:54:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EJgm0u2311882
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sBb2cKTCYnoOH/mWjGOkU1ht6j2WF9ppGTqUJGv9xjk=; b=Dzd8g1ZeWUYoMuE8
 SgbpxjJfR8vd6YeFIzC1HB5sTGKKn8DKxkk1bvOB8Rlw+LG8RGDAwDxgO5kvMA6P
 UPT2TiGqPqQwnpBdhyq7NTBZC5rde/0ki8ZcGcK0ISuP56lERJZq5ye0xWszduss
 pQHt8KHJ4LJvm8IFSAEJW8kKD5g5wiALb6CqaYzu0jxcs/kOkAg06SWCjmWfzR6r
 JdR4+CT7Wyi9VMETR+8RQIb2EuSpaFOK+VTN+n0fPFngKeAs/igQULTPizon4UgE
 6ag+ugOMPTSgeW4oiZLQOQG5M1JKsoeOVtEdjzDGiooidTP0bcUkKvlgEZLDeYe2
 TQCzzQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g25f1h3xn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:54:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso1506653a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786737266; x=1787342066;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sBb2cKTCYnoOH/mWjGOkU1ht6j2WF9ppGTqUJGv9xjk=;
 b=DM6+DU4YkYdbhJEnLpT+FABlbX/QHzpaohVBeJmkW/iuzAT760IcBlGeQEVSh9h0Lc
 0oOTz/2k2DDDZZ/nzM7ZaoztFCcb63/lQ8/Kug42birLNhj1JtdAysUFfz2MDigFk0KK
 EwjgxQPld0W+951rNAc+NDdXmVJAr9LYQ6+387G3j9y4rNWUOevHXbyE06FQlueoh3hZ
 l2vARAZu3VFypYNMWEvUimgFO/RebluakmxoOdLUsfP3gKfQl5k/uBsxVA7/Kj4oAi85
 BznQhEamnVbjSX5OeO8yLsMwPe/UzXEKeDtZR/olAl2W9iZsfRlrlP91Dtjbu44Btgkb
 33KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786737266; x=1787342066;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sBb2cKTCYnoOH/mWjGOkU1ht6j2WF9ppGTqUJGv9xjk=;
 b=hGKJ0EuOwsOY02i2Nzh98f64l49fvK6ivYutLkQ+3m1h7Ul/dQSlBOqVgJ5BLRx3us
 NJAdtQ/8xef2J7jsUnmPemsss70j/Qc9E2xcWw7X6xCt3dOZRFMfcwRjl2oKEtiLrmzq
 lCGwphSpSVVNgsWwEp5c8Ikw+XqUxSNI1scmf3JPFZODTDUOyUZ1RtDo/vf289Np4BRa
 wNjtx96BthbZLrsfF9rVVOB2RIwByQ7YZIOjfEZgrGR9jSxGxwdn4YZ8l7hhZXu1TbSK
 OmFhVUWt+9RDTsGd8rhwhiQph+O2MvpfNDMqoeb0C2SW8WUD8wzCPjvFDFLk8APG9CCp
 saOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+3V2x0TGSZKN32Fd2dlS7oSypdmq/pbVkgx+W895vuxbcQxrUflVNzNeUVG34nhF4McECwArjkS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyynrU2t+pDVYngFWc4wzUy5q4yiUIiPRRpJYMzBTKYq86Hsw71
 rK/eWuI0E8wRVdCgDb4nFalcPOV0sIbBBphjM6JGXbzboG3snjeP1e836DThZD0EZ1WVQKDQdcX
 1N1emeIz6blKT4cLxaM+9hvLJ8XlgVm4Bx7tgzgp5jH1XLxGUVSGaN7WKmBS/iUVS/XXY1tOcWi
 X+Hbg=
X-Gm-Gg: AR+sD10Ufpw/ZSNiI92GeCyHHXTVoCgb8EqVwdEbxHVOzQPqbcTY0oJZlh38FAvQjEn
 NlXU5stYFbHZWLpu+EQrxOhUtJDqXT9+Anxfypy5LQtghjKSGc3c2SYUeXS2NpcBRMK1LXQ5bmG
 BQBWhf7r6PIEvKC1sHrshkL8ewfM94E9m24c0zL0BV0O3MqO/N9kZD5rkzKbZmNywHw5wTumkOV
 HfczpM8yLiXu02ONEqQrAgSffkRgU6lcDHk+B/r3pV7WbLJhIcOdQaKsz+M7klsRPPypjsEZllX
 agDO7Ka9cbf6BSwSZNCdtvjc80zFtsH/r96FS1bZELhlt0jlHPHbHjsHqjbbo2zsAuYjy76Ko+J
 hrV3cKg0SXJ0LH0ZeT73N5ZImb/V8tx8RrEQ8MKNgi4kDWwHtPesNgw==
X-Received: by 2002:a05:6a20:a106:b0:3a0:bc61:62e6 with SMTP id
 adf61e73a8af0-3cc71a24cf9mr9734309637.8.1786737266079; 
 Fri, 14 Aug 2026 12:54:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:a106:b0:3a0:bc61:62e6 with SMTP id
 adf61e73a8af0-3cc71a24cf9mr9734265637.8.1786737265610; 
 Fri, 14 Aug 2026 12:54:25 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387ed5b1sm19164963c88.8.2026.08.14.12.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 12:54:25 -0700 (PDT)
Message-ID: <27160077-35ab-4146-8b9d-cb8f64683c99@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:54:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: reject BO sizes that overflow page count
To: Hao-Qun Huang <alvinhuang0603@gmail.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260708031959.966009-1-alvinhuang0603@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260708031959.966009-1-alvinhuang0603@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DSJfMQ6mYtiAN_DcNnFvdJu6UZkQ6gpm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE1MSBTYWx0ZWRfX7cx8yjoXG/2Y
 b+vW6CL8eTM9eJbpBudx/FvAoi+GsN16Ylb1qXOb6FtFgkfZZ2PooFcMlZxk3juYyJ4XcuDsqyX
 4RFyfA/DeC9+9bEQW9OxYG4MB/ptx0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE1MSBTYWx0ZWRfX5Mf8p9oV9T4v
 xGsKLUa21tGKv9dvS1/Lyb5Zwwg9jHETdunuzc+r91FzNAaQiQvF3krpF/qLEVX+Y7/axnD4agC
 d9AVDGGdFCSIB0nOYcZKRM/xxKnbnSV1MsX6Q9qOOCdW3/VGaUZggi8rXDgX70tPJRix3oQoNlH
 0Xi8vinfaVZ9/Q+z4kMQ/HLZSnZB7dUlOJsvN+Qo6WgblF2BdXanUbOlFk/IgJ5ZkneXDxON8df
 reqw74Co02KCb1Epxb0I42+C78V0uxTcvzKlL6Q4x4uYXhalf4VhIK/Pdo2VL4U8QBheQT8tVzu
 bwCDfxJYvMQfZB0M7M8NEoSrofMZqaz71PaiuqURBnA9cnvKr+hQavhdHAPIszgSor1SmIwMKFb
 Agr08J4xNTXDPYGoLD0nfDm9BX0a0TtwdNVT93Cp4q4hLZ7LIaJK+1LUh/q2Fg/BebNoeZTt9Gz
 QtQBboJqoginlazs8Qg==
X-Authority-Analysis: v=2.4 cv=Z7Xc2nRA c=1 sm=1 tr=0 ts=6a7f7272 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=XvhK1WYLh5LTG0QYcLAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: DSJfMQ6mYtiAN_DcNnFvdJu6UZkQ6gpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140151
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

On 7/7/2026 9:19 PM, Hao-Qun Huang wrote:
> create_sgt() receives the BO size as a u64 but stores the number of
> pages in an int. qaic_create_bo_ioctl() page-aligns the user-supplied
> size without an upper bound, so DIV_ROUND_UP(size, PAGE_SIZE) can exceed
> INT_MAX and truncate when assigned to nr_pages.
> 
> When the page count wraps to a small positive value (for example a BO
> larger than 16 TiB on a 4 KiB page kernel), create_sgt() succeeds after
> allocating only a handful of pages while the GEM object still records
> the full size, so the request never fails with -ENOMEM. The temporary
> pages array and the allocation loop both use the truncated count, so the
> backing SG table ends up smaller than obj->size. Later slice operations
> validate against obj->size and then clone ranges from this short sgt.
> 
> Compute the page count as a u64 and reject sizes that do not fit in
> nr_pages before the narrowing conversion.
> 
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>

Applied to drm-misc-next

-Jeff
