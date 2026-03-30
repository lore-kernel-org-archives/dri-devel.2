Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F3FFB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5F810E4D3;
	Mon, 30 Mar 2026 09:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V2AF7rRw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YELIGw1l";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1252C10E4D3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:46:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U6ZaiY1969532
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yDrYF8AidRgM/KSPWZFhvJmgdmBlKR/d3nX2Pp8zXbg=; b=V2AF7rRwPDOcqgET
 M7MuA0dy5S8N5GasrsDZqvagyHXI/mPCrjjWps4xfuEdUaSnkgL23PvECeyyY7cK
 LAQESa1GZec2ew4rBzNw9CLvUgblD+DYecr63U0LEMudoJ3n5drl66Y4a9rCF4bu
 SKe8aewV6wI+WxX/dNl5a162y/oN5rjIxQsJyh0muTmNOGr67e2IryY/wP/ZdL2q
 IBEkSkgeQhiQMWRHdf+pKQktFX3DnKwfrmX2setHEKdG4usARHVgbWZ6t+St7zX3
 FYqMHJPdSeBtoAyYyb5VE7arsU1ux1awDCoVfCGNpMuW0KypavV1PD9KT645eGmj
 cJ7rWg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67c7dhmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:46:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35d93a8149bso2413683a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774863977; x=1775468777;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDrYF8AidRgM/KSPWZFhvJmgdmBlKR/d3nX2Pp8zXbg=;
 b=YELIGw1l+rcbkVn27X1mkqCQLJbcC94xvNDyPZ1U3TMHS+qLenqknujp2UyrdGIWU7
 Nki2AYBgq0JEOFSUwdVgZ0lCwg/3jwvDb5FmDPgOBXAzFZdd0jTpirJ7OKAlRAn1q+S/
 kbCoXqmIB0OAOw23v5Ggs9KtCfAU2GjUIXEoID3AQvMMkHQ/fCZLOiOKmkVWo6zMe07+
 +6aBLe/ALt9RjHItVZMESZcrLvqFkZhJ19l4eNC6DutSIjzakXkRY4ajYT/Xp0eS7gUh
 +1+TaEjUoobzwVUa58IPU1/onlCmx/QjkVyOQgVX2nARHqdin/evdxID96xF08390h7s
 ACcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774863977; x=1775468777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDrYF8AidRgM/KSPWZFhvJmgdmBlKR/d3nX2Pp8zXbg=;
 b=RpKICMFTSfPbGStodIVMUT4enB5jlqpsm0pihI7C0GF5GOLCpoT12sztEdA6rnGOzy
 KVjSmnRbam7254PmRP6mFB6Tl9eFZYV5YwPzZpEC4HInK9SdQ+Yqcs2yISvBrfEEybQr
 467J+CtxOkbs8EYQBlilWL+p0MI8Ko0BEttZWMs+AWzU8OCY1l+sVZ3pKJXfEo/roq64
 B/1af/F2tJQUJPc8AzYDKrvvcjHF9tK+fKmFVVC74SPNHPKYGyjIf5x4GU5PNtlqytWV
 dSbMxXdeZcP+sRAs2itiVs0DZ2IN9HCpH6s0wxpAHHh7rPail9cvXHImcB/pvH60x49h
 y0Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt568qCnn4rULjyo6OUOyRKr/nKdnOLsQmcLdFZRDNoUqRwc535AWD5buT/eFbsBl0MIKol6wlFV8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzp3pejsT4qPh78QDMeiX8MbI0pjE197uqR8uH2KNw8QJczPnXw
 w+Il15EnQ7q0LtkUgtpLzPc6dEP3RZ09puscg18sKW4RFYfowUtpJek3uQtROjLGcyLeWQCCMS9
 TEhoNjp2dx7oM/tFm+nCRhtuUmzM6LBHmZsqzVWmFMCM4wb8dDvrA1bx5y3zDLVxfnnA0AoU=
X-Gm-Gg: ATEYQzzbQbkCtaclpL7tVdEhXC36CUHWEzcPf2FdgAX8QWEQ1KAdyNo38BwGo6VtftF
 i4PbbFXEeQb4ET/6DP7CBBjp9BLqFwOBUaYx5kfZ7lNH6u6AeOVShuVA/L4G3Blp3uXXw2/qVEJ
 9M0pXqk6lAjEyDgP6vMkT552EKniFLzGQRGcLQ4cN55RkGowr7T/M78PV7m/WQas+tdUjxEdwwh
 ZOMBG+jYO94ikMrW35qNY6X4T4wYKGDQqmLYIvIRXfA9SrAyFFxRUkqYBO4aFL+Ip7WVSRossUa
 kRdZA1oqZU78FggH/mcg59PEza/H2h3cZ63ROmRNKULBA1VbEbDEDpXuPR8ORwxWiO9fzVwbo1m
 zK3OcKzvApKClQBSnkrSpiDKXTVRmw3MMMQ8HVw0aDCjLyd0k
X-Received: by 2002:a05:6a21:3086:b0:398:66c1:aca7 with SMTP id
 adf61e73a8af0-39c7385982amr13909260637.38.1774863977312; 
 Mon, 30 Mar 2026 02:46:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:3086:b0:398:66c1:aca7 with SMTP id
 adf61e73a8af0-39c7385982amr13909222637.38.1774863976529; 
 Mon, 30 Mar 2026 02:46:16 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916ceaf1sm5852762a12.11.2026.03.30.02.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 02:46:16 -0700 (PDT)
Message-ID: <52455b77-fc3e-40bb-9462-8a78238bde0b@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 17:46:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/38] drm/msm/dp: separate dp_display_prepare() into
 its own API
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-11-01faacfcdedd@oss.qualcomm.com>
 <rsywfefrwv67umbi6xeybelsu5u6xqyklvtarnoluu5mzz5u5k@bkexqpdd47ew>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <rsywfefrwv67umbi6xeybelsu5u6xqyklvtarnoluu5mzz5u5k@bkexqpdd47ew>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPdPlevH c=1 sm=1 tr=0 ts=69ca466a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KxCuJjgNVnz-IXmmszEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NtOt1Ejov8w2ndOn0UbpqozsZv_tLHnn
X-Proofpoint-ORIG-GUID: NtOt1Ejov8w2ndOn0UbpqozsZv_tLHnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3NiBTYWx0ZWRfXyWiUUj/B4Hdi
 wO8+sh3m9SVtH3z5RDLsHVpX7bdePiJtPhq7PZ6zqKpRZYztkYLkFtZoR921zE0IygB6XS7k8bE
 ZeqkMvOFtUCFw4EpQtpS6rg737XOdqJZ82r9VrXmO6UNZC39rZMSzOeH83NeTmIsaCoWNMqvCe3
 3th3naleJeiypvRS/bSAaPcoLmWFjwMJaH+mxuXTxHTbNkJGM6+nMAvAcd7I6a5OsKBtwRZ2SAq
 kLcWeHFvaniHHXBogGwJ1O9VTgqOsdQsEJ24yAx1h7/CQoF7Iy0CxmIcVCd2wLH91Opt+qztlhw
 kCvMBXoQPKeJtsFn7+a8P0jarAQB9YiW1HOePRBqKYMbG3pr2AIQq70JEJxXTPe0jgVeLWyBMpK
 8zGI44bflGEBImN3tp37SbL15b6fPtgY/TYQWSNH9V2pThzbehDAZkUeLRqIi2CivJnHhvD7mfL
 i968mwTyOeEnEr97L4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300076
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



On 8/26/2025 1:39 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:57PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> dp_display_prepare() only prepares the link in case its not
>> already ready before dp_display_enable(). Hence separate it into
>> its own API.
> 
> Why?
> 
In the MST use case, this is expected to work as follows: when multiple 
sinks (two or more) need to be enabled, dp_display_prepare() handles 
link-related setup and should only be executed once, while 
dp_display_enable() is responsible for stream-related handling and may 
be executed multiple times.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 16 ++++++++++++----
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
>>   3 files changed, 15 insertions(+), 4 deletions(-)
>>
> 

