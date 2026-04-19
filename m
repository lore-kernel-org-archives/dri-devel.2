Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E2EEA7194
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 10:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CD110E072;
	Sun, 19 Apr 2026 10:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="puSwcU6p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvX7U5fX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9FF10E072
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 10:06:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ILjNoY2379609
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 10:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XI5BNpMIZ8Y0V/s2/V6NIC81LF/72Sofa7E3Xufqt5U=; b=puSwcU6p8iHAqE6n
 8aa7KUtBbfYH30jSmF1QmXGZkuZ1WYrwNBPOa6Q5ERDF07aPMgfDXN9sH1TRKD5R
 WbkhF/MmAAXWfKqRK2D2FtwC9rZB1YdBbN+YBswcrCd9jngSQRiJVaUGIj8E8ENo
 GVjritebgRtkjUrd4vNNCrM8VkfOsfgDPG0czGpyQQG1Le3765Z76e3JSdJVZJTM
 FfHitXht1Bh2cb/sth8EqcNfmEDpyy5DL/mPtwqUY2mezDkeiITG3sxH2NP+kyKu
 v5eT+ExIqAwaKP3k61uowgp63xgcamOpOrEMKAtUFGxtmdAKjqyrLMk9vq3PAhRA
 Loamrw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr2fnn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 10:06:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9467e85aso2066553a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776593210; x=1777198010;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XI5BNpMIZ8Y0V/s2/V6NIC81LF/72Sofa7E3Xufqt5U=;
 b=SvX7U5fXPXFtUygXArO5LIbMR0wQ0IltNwNrZjEaYetVxF9d45AlOE9tKMejCL6i3x
 vcm16NJhlMMJkeP0FotujHeiDRQCJmoeJe9tdrEdihcQVJCG/9bcqLFAq0j7sCJtFY90
 FVJngbJMdIGhswSt9VNSpZ8e4ORh96g6OnP0LIg2T7uRS0dH41US16qufgvpre7gZ1vJ
 DhQLhRfjqbuTuMtS5uuHh2DAVbjjzumbhOxpcDb4eJXBEaZDPxzyI5wCpL9wdu684/lI
 5kjxrej9O0gVh34tfhgCTFdeVpnFxnwcS7GNaGTxpzhRXO/eTy05fAGaDltkDCFdzInk
 Pd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776593210; x=1777198010;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XI5BNpMIZ8Y0V/s2/V6NIC81LF/72Sofa7E3Xufqt5U=;
 b=be1M7nvitKZApVS2dyDyazSX3zhsQMXtLf+z/lShDq6FBPe1S1Xz2qMETMo6U+gz4L
 OsZ9+oG0Ry0Y+dc0XGjTHCdBzo9jksOabCXSWTVHU8alVme/egLRIPhjgl3QjoIgm0wC
 +IrsXUDg/lAGnOFGxqoL1aVPFIjtIq3cuogeFgSuVjbafmGqBxaZIioRm6+CcWP1oh22
 Zi7PNlMgqWBX/wUtCH4Oc9sVrszyCE3pdWDl/0YpE5SlmZUwfzR4N3fB/PJXEP5kjfTf
 VbOSoaBNyvLHKvTjCla+lxi4gv6b4fOEEPSZLcftk3K/JLpK+88LHMEsKE89r3sBrrkc
 WcBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UHGcT+tYlXTbnPQ+e/Z7chUQ6rNZsUFKTh9jGSIwkQlzI88vELxDfNvrCfNeE1CbAPUq3KDSGI/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaAsCmuWi1iB3KXHyO6qF/OU/G2uPGwSKDzokdEa1NtxU6c+Jc
 lP7DqdcD53WXBhOZN3TZBzbogluntNRjITKxhq8vaEGHBmNd/6BQ+U9fTZYm/QgFQxXymiodUSD
 xdr71hRqw7GABT8xN7gO0mKWrb0FCuoRvWD3dBlCnKbWKv66mbkZLFkpMACdKFSuM45s8vhvqjp
 ToEUv3tw==
X-Gm-Gg: AeBDieubGOO0PjbD8iru9Zva5xoUrSYNELGdkFRVjpqPvSWiOJrE5YXQhwNI+W1Igg3
 4SSQNYajAx+hhQfKeqs2XIdHrAJqMhHP3+WWmnH4QXYYfyjcKHN3PW/NLw2v/D2lJm9WW/VBy2H
 1o25qQ3Lx6ix45VBU9X+E9btpUbJGWLbOtIINIcKNiB6cs29+U3s68ePOPYV+ABmgrTb3oPiUlX
 11Xsfdi9lLnDVUktsynJxCzOkI6r9T+VY1GmpZfApPTbYu2nl9GIjKV7e3ljOjORSWN962VdjE0
 iHw7lL+yLn7gcxVziaem6mRxEc58SsUm7ZYM4lgtgje3L1GNCjxbOpygtaw46zFcUDa4Hr0ZNMh
 OT8nP9CXBXUGdMZm/B9sxGqqf/wYpXyLFQEOckDwhwgoKdGaofPdm+UNVP7ZB/BpXFJ8mq0PcBi
 /7xhQKodobKApIuFgkfXx2YqlyQg==
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id
 98e67ed59e1d1-3614049ed12mr9946211a91.24.1776593209571; 
 Sun, 19 Apr 2026 03:06:49 -0700 (PDT)
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id
 98e67ed59e1d1-3614049ed12mr9946186a91.24.1776593209087; 
 Sun, 19 Apr 2026 03:06:49 -0700 (PDT)
Received: from [10.133.33.90] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7cb5sm7357149a91.9.2026.04.19.03.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 03:06:48 -0700 (PDT)
Message-ID: <cf0b6133-e15b-49fa-b9ba-e67ac8bcf7d3@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 18:06:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
 <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
 <7rfiwbbunlbzmhdjvsfqccltdx7cveahbgg2rk6kkom2jesta4@nnbas4vn63we>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com
In-Reply-To: <7rfiwbbunlbzmhdjvsfqccltdx7cveahbgg2rk6kkom2jesta4@nnbas4vn63we>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwNSBTYWx0ZWRfX9cy899PDOR3Z
 GH1txZ4vl4+oORW8XeLy1Bff/XLXD89zA2ISF+SJuFsp8kKidhF+A855o6TSAuBmagf+sY8BoYJ
 cFReE1yIvla+mCEWSKE3NywpdAdL/0H85hSPW68O7iXsVhjs7XHtirXW19fECdr32NLo38NTCup
 ihXD8kbRNnpbckXrFIgumMP259ol3v5dY5RYN+KjQUa6wk4c3DgaCF5X0yeIXI+5NZNBNMPZ2nH
 eSCq5skJ5Z+d09tWDK/pmieWnVVaI+Nb5i3fSQCvStIUcPRD9Xxq8KkzLi0hY+U6SOtUU8jSOoN
 hDrkakeKq37t17hCTH4jaqI2XJMMza5eMvC0UnZGOaZRLdFWr/8iAnow5o7cfogeMlMYqWqV2Y6
 yOC8+uOu37wnhJQcqsWb/4qJiXOm10EjztL2clayKTOdvluvTpCcF/pdrmkD3cbNbEHG9h4EbOI
 SHWVb2n/ILSaJSEdP1w==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e4a93a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LlW_7vAnNt5ooDS3Xh8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: JcaZh23sC0BqWyflLw5MbRKxREBvczTF
X-Proofpoint-GUID: JcaZh23sC0BqWyflLw5MbRKxREBvczTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190105
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


On 4/18/2026 2:31 AM, Dmitry Baryshkov wrote:
> On Thu, Apr 09, 2026 at 02:26:16PM +0800, Jianping Li wrote:
>> Allocating and freeing Audio PD memory from userspace is unsafe because
>> the kernel cannot reliably determine when the DSP has finished using the
>> memory. Userspace may free buffers while they are still in use by the DSP,
>> and remote free requests cannot be safely trusted.
>>
>> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
>> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
>> controlled alloc/free and ensures memory is reclaimed only when the DSP
>> shuts down.
>>
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 104 +++++++++++++++++++++--------------------
>>   1 file changed, 53 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 148085c3b61a..a67ae991c0b0 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>>   	struct kref refcount;
>>   	/* Flag if dsp attributes are cached */
>>   	bool valid_attributes;
>> +	/* Flag if audio PD init mem was allocated */
>> +	bool audio_init_mem;
>>   	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>   	struct fastrpc_device *secure_fdevice;
>>   	struct fastrpc_device *fdevice;
>> @@ -1295,15 +1297,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	struct fastrpc_init_create_static init;
>>   	struct fastrpc_invoke_args *args;
>>   	struct fastrpc_phy_page pages[1];
>> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
> What was the base for this series? It doesn't apply to linux-next. The
> code here is different.

This series is based on the patch submitted last month. I will redo the next version of
the patch based on the latest linux-next submission.

Thanks,
Jianping.

>
>>   	char *name;
>>   	int err;
>> -	bool scm_done = false;
>>   	struct {
>>   		int client_id;
>>   		u32 namelen;
>>   		u32 pageslen;
> This struct is way bigger.

In the fastrpc_init_create_static_process function, the
inbuf structure has only three members; it only becomes bigger in the
fastrpc_init_create_process function.

>
>>   	} inbuf;
>>   	u32 sc;
>> +	unsigned long flags;
>>   
>>   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>   	if (!args)
