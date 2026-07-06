Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA7BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014AA10E2A1;
	Mon,  6 Jul 2026 06:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+6sPStd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTuNPdGy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F5210E2A1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 06:16:37 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641TUE3615451
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 06:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gUTk8sYwNkAHjVq2F4TJJ5lnD4yG1DgRrEDupwQVYKY=; b=b+6sPStde73fF+50
 lwoolqxNaXGnX49NC6CkU4eyfl1Wp0O4lvYvxnXmWANPBY786/eCTGLVjQn4WIeP
 q1s53E2uLax/nbnUR6VeLviPkV8z03r3GSZBi48heGkvXqIzuvqGyfSD1yGOuIgp
 8ABxe3RazbQa6Fk58fSVn0PBAKMgn+g3YGFnHIoYpC5fnM88fFGk5SdM+F38P3T1
 OxmCUZFPA7A4DBr/aqwHs/qZyLK5HQRD7YcF3nX+Qs3uuI88qQex/I8I6vt51JaS
 0ei4ZafsejzWCdhO/ngbQiTr5ebDuN0DQLY0zPN0VjzOkkhK0VCYDgbAJOo8vaKP
 McZfHw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3cn99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 06:16:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37e24235ce1so3799534a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783318596; x=1783923396;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gUTk8sYwNkAHjVq2F4TJJ5lnD4yG1DgRrEDupwQVYKY=;
 b=QTuNPdGyNtXXYmLQ0Et5SLqrMS/44MWsYi9SZguRi25+rvjTSSA+VGBowiP05a5C5S
 KoD/FaScd1WIqf8CymhbdLsxi3e+98JD+rIZzCLQXI6LM/l1ivfGmQGMps91yH2bch26
 3M7vxAqgTA6lKCZ6cmipX2bkFFopjBabYmM5uzzemyZr4G//UqsRrDB0DSPnNVYtG0jC
 HW6x0zYBTEY2Ff2SRRaHhxqVgQKboApGukqA8B2H9zCQhOpTPMhs4nfb+ju++1gc5egJ
 8SWIvKhRatAoIwTNnq2mek5oegtj83yx/IbXzUCp6Z6XJDLZ1SXtkw0cd+Q5CHbXg4MX
 oBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783318596; x=1783923396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUTk8sYwNkAHjVq2F4TJJ5lnD4yG1DgRrEDupwQVYKY=;
 b=H03BgavZ2cPSQM3MS95mEhb4p6HjIeYOIPlivSV/4gSmGEF7UZnltABwoksW5+lNr+
 HztfTlksXitk9+IyjPaKaVhjI7GwvN2aj4bz11WN1tvJd9/cdLQAH+CpIbX4L9KQOXOz
 Y7Jf2+PL4oqr+tQjOyswxb+3fj5iBDAJITwluKTmT9OD+NJZ/XAh0pl2NOCZDgVfjWxy
 K8y3wwnP0h2C58th5Ai0G3hGtRe5xzLmOTEaaP7TsA+c+CvLuOaqq1efqd2gMNyH1SuY
 TxxJZEiya9YyqhGG35fRU/NLVfLqx0KmOk3t9JT5E7XONAkw903tw6/6wZImoJodIb3q
 s6CQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Royw+DGn0QgSz6Cx0YHztHha2KdgH+bujIuDNUryCyghlttdznBD68zxcW6c7zf0NrDD3D7By2vrAk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYujsChPX4X7qBw07RMvg941IEqaDJ5sa/gCLDcO6O+VYa2qA3
 ZF1wdQBKNcBCL7aLAXMNSoY3+adhQenQLEo23v5o0v187F8C2tFvJgdU6JWbieb28yDBtIdQTEV
 xDX6V0DGws8UsZe1urBjttWMV/e2BfE6gkxD/Gw8sFqwSPrXLaTbmdneznpUK1km6Idw6vX8=
X-Gm-Gg: AfdE7cnt6c0CM1qEnstMweKgQmgz/3HKxPY93oCF/xemcniCebkN5Rm9Dfiro+qIK3r
 L0v3AeYs46LAmDpH6qARdgZinYyg/W6jzazwUhz275uFjtIzUhZl8pNC/BWQF2zTryEm8eQ0Xc6
 4XU6GxxLQ9sWiXgKyqlbrGP2ym6fn7BqC2mbSiVkJ/8BD9r+ZnrzT2hFXiHyTYdweC1qncP6Ihk
 wc91zWfVzuR0PrcXiZs4tAA2cOX6BUJkbknJXsF/QFV+Fpmy3nZs+q5U0cHh/bzHNBDo5GFipqJ
 E9tCifPjtoqI3B3jYszmafupQdUUbinrTROBVrlDmzhaFvrsVqgVap8Bs2YVU4IBcqYy3Hc9sAf
 nbXuBAtRwOsrPp5unr/hVgEEjvx1XGWBrdzih4wBZIw==
X-Received: by 2002:a17:90b:2682:b0:381:21ea:9147 with SMTP id
 98e67ed59e1d1-38281184e03mr10572122a91.13.1783318594822; 
 Sun, 05 Jul 2026 23:16:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2682:b0:381:21ea:9147 with SMTP id
 98e67ed59e1d1-38281184e03mr10572092a91.13.1783318594328; 
 Sun, 05 Jul 2026 23:16:34 -0700 (PDT)
Received: from [10.204.78.23] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3812815d3e7sm4191321a91.14.2026.07.05.23.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 23:16:33 -0700 (PDT)
Message-ID: <82310a26-daca-40f8-8bb8-f3ec015f9f0b@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:46:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: create duplicate sessions after all CB
 probing
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>
References: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
 <01d8d8cb-3de0-4267-9a73-c06287393483@oss.qualcomm.com>
Content-Language: en-US
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
In-Reply-To: <01d8d8cb-3de0-4267-9a73-c06287393483@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2MCBTYWx0ZWRfX31rHoW+uT5u0
 GAyRLPKQxYhP7tnJpnsIQJM6tlee00tJg02MWzXjCsIr2tvfTaZfNz/QLNByabTSu73REDSmwCx
 8br7UfrhMVwPNF28jjV7OYXImUWHa1E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2MCBTYWx0ZWRfXxPBlEJmgKl13
 +9wa3an85HsJWbbjI89xegFEVuu8zIZA9KaqX9RBHIwHXjZELRvxf6VLb8TNhDNn5ubFc9dcQhw
 Q2Y7nz+927m0ApOuaEv6cPaFQ/7FJNOXDDauxcdc1g7FEdcEGh0eRiKLOGZX8skCdQkLHUy/13+
 /ogzGaFtCmdAM/Yc/fltEIx1heK4mvqtsbqOaguao4cqDN+Vi+g4Brsjg/KWEwim16DTbGe2l/0
 6HQZxrTsSibbn1PrUq6HfzbZ1RIC+PN/7dYpuFGLms3LUKJ+F529v72XICqJoyymkI1JbfbLr/7
 V0YwCQVhV/UfMn2tZ1xZ3CSX9bGTX1uJ0Hy1TWUS3TmoG+xHSyv65pHw/aalwEvI7k/K42DH3lL
 /sSn5yY9DZBLgrBqZdzvt/sP7PvB8MskpWgxHDWyJBHYM+EZ5BNSTDc6HefeU+ZoWksxIXyHvFB
 XQ8jWyxBJdUYzYTatfg==
X-Proofpoint-GUID: _6pMYxtFB4XTP2GONqb2SagGB70npw9U
X-Proofpoint-ORIG-GUID: _6pMYxtFB4XTP2GONqb2SagGB70npw9U
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4b4844 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rCFuom7URbRVPiQ4E2kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060060
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



On 7/2/2026 11:05 AM, Ekansh Gupta wrote:
> On 09-06-2026 16:03, Vinayak Katoch wrote:
>> For ADSP, only a limited number of FastRPC context banks (CBs) are
>> available. Each CB supports a single session, which means only a few
>> processes can run on ADSP simultaneously. If all sessions are consumed
>> by fastrpc daemons, no session remains available when a user application
>> starts, causing the application to fail.
>>
>> To address this limitation, a Device Tree change was used till now:
>>   qcom,nsessions = <5>;
>>
>> However, feedback from the upstream community indicated that this change
>> should not be made in the Device Tree. Instead, it was recommended to
>> handle this as a driver-level change.
>>
>> Instead of duplicating sessions inline during fastrpc_cb_probe() using
>> the qcom,nsessions DT property, defer duplication until after
>> of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
>> all compute-CB child nodes have been probed and the session array is
>> fully populated.
>>
>> For the ADSP domain, append FASTRPC_DUP_SESSIONS (4) copies of the
>> last probed session once of_platform_populate() succeeds. This keeps
>> the per-CB probe path simple and ensures duplicates are always derived
>> from a stable, fully-initialised session state.
>>
>> The qcom,nsessions DT property is no longer consumed by the driver; the
>> binding and DT sources are left unchanged.
>>
>> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 1080f9acf70a..46afbae9c234 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -30,6 +30,7 @@
>>  #define CDSP_DOMAIN_ID (3)
>>  #define GDSP_DOMAIN_ID (4)
>>  #define FASTRPC_MAX_SESSIONS	14
>> +#define FASTRPC_DUP_SESSIONS	4
>>  #define FASTRPC_MAX_VMIDS	16
>>  #define FASTRPC_ALIGN		128
>>  #define FASTRPC_MAX_FDLIST	16
>> @@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>  	struct fastrpc_channel_ctx *cctx;
>>  	struct fastrpc_session_ctx *sess;
>>  	struct device *dev = &pdev->dev;
>> -	int i, sessions = 0;
>>  	unsigned long flags;
>>  	int rc;
>>  	u32 dma_bits;
>> @@ -2204,8 +2204,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>  	if (!cctx)
>>  		return -EINVAL;
>>  
>> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
>> -
>>  	spin_lock_irqsave(&cctx->lock, flags);
>>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>>  		dev_err(&pdev->dev, "too many sessions\n");
>> @@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>>  
>> -	if (sessions > 0) {
>> -		struct fastrpc_session_ctx *dup_sess;
>> -
>> -		for (i = 1; i < sessions; i++) {
>> -			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
>> -				break;
>> -			dup_sess = &cctx->session[cctx->sesscount++];
>> -			memcpy(dup_sess, sess, sizeof(*dup_sess));
>> -		}
>> -	}
>>  	spin_unlock_irqrestore(&cctx->lock, flags);
>>  	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>>  	if (rc) {
>> @@ -2445,6 +2433,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  	if (err)
>>  		goto err_deregister_fdev;
>>  
>> +	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
>> +		struct fastrpc_session_ctx *last_sess;
>> +		struct fastrpc_session_ctx *dup_sess;
>> +		unsigned long flags;
>> +		int i;
> int i was already declared outside, avoid shadowing> +
Ack, will update in v2.>> +		spin_lock_irqsave(&data->lock, flags);
>> +		last_sess = &data->session[data->sesscount - 1];
>> +		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
>> +			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
>> +				break;
>> +			dup_sess = &data->session[data->sesscount++];
>> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
>> +		}
>> +		spin_unlock_irqrestore(&data->lock, flags);
>> +	}
>> +
>>  	return 0;
>>  
>>  err_deregister_fdev:
>>
>> ---
>> base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
>> change-id: 20260609-dup-sessions-ea2acaac1994
>>
>> Best regards,
> 

