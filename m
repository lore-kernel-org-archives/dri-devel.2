Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C115FC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F45B10EC7C;
	Tue,  7 Jul 2026 12:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="go+XicZp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BnQY9TZj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A9810EC7C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 12:07:44 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E2wt3070557
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 12:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TSZCpVJgYGNPn1Ohux957EKWIlXyg6nTTccZRFciuH0=; b=go+XicZpWJFxQRlD
 q0EUzpDkuXG7BOzDsO3p6LrAZ8TKf4BxfuGYViRgyBuKbXB7E/XEb+yH0WLd3QBh
 9YtUZFlHi+9sxl9rVRRpjZeYEPSb9fuOlOE+7d2pBtrvGAZVqxopGXu7PzFWFKyF
 XEfkDfk7Xaz6V2dtpmj4qWI6JkeW/KU7JQOaAr4skymQA0gVc71JaaTujABrld3K
 z5HOWBuaqA7JEBugDGD0atRrgsTkdrNCwdnze1jKdYzSvmAZFsQgCMpvuxWMhLAE
 sXjDGV1VD1HkALkWTxiPC5pjx+m7s/Xt0yzsCGNv5xWx2DdjnTqX16bjqLN5QJx4
 e4RvZg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8hve1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:07:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso8330771b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783426063; x=1784030863;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TSZCpVJgYGNPn1Ohux957EKWIlXyg6nTTccZRFciuH0=;
 b=BnQY9TZjZhWelYOefaLPKCS0Nv5dC426gdIvuZ33vCOuOhDNVTGL6dNllu1ybLbnJQ
 xi/uJuCNs/jxjnEer4tAkmRIxgYzFTJfBeubJYNUdq9GVcp2Z5iIa+c0ph1L+SoPxa5M
 YqMROv8+GCBFmq8iymhUVVOWiLubs5NVfn14y5fQQ4rQfCtwNrhm6RxldollQXfDtpNf
 VR1zY4jGZMzspSOuZDcXsc4lQ0gV9mC8GIUgQSxuOFvkQUFB0jMTsVKWYYyFMeeQRCII
 KrjuQHvhXUXQ6lIzsnIP+GR83Nx9Se+6n4K13HUjuDcyDI501WBV0jfznL3pDaTgfybr
 3XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783426063; x=1784030863;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSZCpVJgYGNPn1Ohux957EKWIlXyg6nTTccZRFciuH0=;
 b=cJjMWcrWko+8a4ODqiKa3N/5pDdDznIx8Rk20XbzKg4+FBz98RE2+JT0USyBr5i8Qq
 +EAtsgNgNt4YQD1MGgEpILmHe1VlOB/OMJSvOJZNrCcQVcwxbgRl7GN1VhWeB8GYwjRP
 YUDbEN2KAF3bwAbGvW8/DVZaVwSQ/ZFfMTLlSz7ZnYQqcpLj1mchgsxwAxhoIgy5u/2j
 OXQNSRLL4abWBXDQIg9Q89Yq6FG+Kzp3VR6+MSuZOYBUwbnPZfnd0v5J2UgU6MMSW1Oi
 ieLaPQ4QRYZ33aS/jqWday4RbhP3d3IeHAGYr4X/5apXU6SZHE5qKjn/m9sBe/e4BrNg
 eB6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpr31kbxP85z8fhP8ondOhXqVEvIpu5I2zT3AsIZGfD64OF9IXIGJRt0nA3E2R5hZQlivToMvuJ4vc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbBxuRmnit/UESLb8Uze2AJnHNklcRpmtsJDuTDqxyPYCQ66So
 nIp+kObqdW9VmJg8u3Tnt63JmQ4QrEFEXZMmipJR9cXt0hqJp4/syCXeBowgKiXVmRy6tz6oEh8
 KVaACD58qbVW5b6+WLQUIhXMdY4+ij8ILJYzd0mbZlYPGNv2VpJldI2Lww3QnUP91gCj87Mk=
X-Gm-Gg: AfdE7cnPgIVNhBiq4JIqCNgJAdlAg8F2I5x3O1JO9scIU166UvQYhgWL6K0pfuDMlUe
 vhmJYZex3tLfqfVya3UUdyEWD/5Mzr3rwb/hUnI+DZzhwv/2XE5VKxO1jSW4f31r1xM7jYOAak2
 4poYx6xnDWsyQZDs/2L1QlIR4+b5msBAiIVW+UTX7w8gkDJY+T1rBNo4jwY0Stf6rmbS2eKNTiy
 nDUMpn3lcB+t9GPzvCFKIwwRv6QYJY9f7tr7xe/I1M1y9eXte6xhMiF9712Yb53sixvvMuDhWfn
 tUVeF3/rxAJfx17QgcHJQ4SPOKFwha8Zjk87Xvxyt+34Ios3J8t/j34TkzIbOnqgOlgZHT8tDjC
 q8jiEBE8XaFf5I+uG+/faKPvu406S6WZ23g7C+OvpalJ4
X-Received: by 2002:aa7:9a88:0:b0:82f:9407:d167 with SMTP id
 d2e1a72fcca58-84826db0b6emr4883534b3a.38.1783426062779; 
 Tue, 07 Jul 2026 05:07:42 -0700 (PDT)
X-Received: by 2002:aa7:9a88:0:b0:82f:9407:d167 with SMTP id
 d2e1a72fcca58-84826db0b6emr4883488b3a.38.1783426062170; 
 Tue, 07 Jul 2026 05:07:42 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6dbfd41sm5359873b3a.57.2026.07.07.05.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:07:40 -0700 (PDT)
Message-ID: <81e84294-b438-415d-82ef-a523c4381eb4@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 17:37:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDExNyBTYWx0ZWRfX4A2JIvzNU0hW
 UNUix8YiHhc8qcO+6JKKUbtq2Say/j9t4nZSPd1NguL9erE593w/QUK/kcLlFoO0RmNanFgJmST
 PnB55ZzQQONlN1gn6/bZdKgvQng5IbNLZco1LqycUzR5AKmMALJT13RAm7YHuZAsrYHT1inuqYc
 MGvGs+AquBb2XTs0u7l3YX9yiCHzIDJIwPsP8fTN7WdbDKlgo2wSKFvfM0SlMyFkmeIdbiOSdMT
 PbJOcde9AQRfuoMsoJJxgFSYEKiEGdPU/Z8HxcBPUV5fhNx3pPbP/cf/AJYlsvzx56kJAArHzvC
 cmrcW41uKtOwLj98PyDPt1ep4YjkDPps9e1TMsjCXnoSejLl1ACTlo8x6UcpgVnp3uWLebLkGI1
 a2ATfCadb5qKAxAuvoTu0pRaruHGYZfv9yUFjazyWdtZb/Dl0NprZbtdHI/h38BnJKhYoqj773p
 AGumViIwov0FuHHsVJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDExNyBTYWx0ZWRfX5SsqyHtYsFVo
 aKPB0uqFVzBn1PuZCXhIo909tRDe/YACo+zMMayUc6rz/TC0lmeLt0L1tJGhUeAj8REzHFyuDdh
 N5r5zuKkrQ3RRywYQcJeWC07nVbcHW4=
X-Proofpoint-GUID: 0QQuOfDhxATP9i5VyPDoQcrVSi7ysVxK
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cec0f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5YGwSrtyFkuD1B6sRKIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 0QQuOfDhxATP9i5VyPDoQcrVSi7ysVxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070117
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



On 7/5/2026 7:27 PM, Aniket Randive wrote:
[...]

>   static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>   {
>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
> @@ -471,7 +484,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   	}
>   
>   	cur = gi2c->cur;
> -	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(gi2c, len));
Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an arg ?
>   	if (!time_left)
>   		geni_i2c_abort_xfer(gi2c);
>   
> @@ -513,7 +526,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
>   
>   	cur = gi2c->cur;
> -	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(gi2c, len));
>   	if (!time_left)
>   		geni_i2c_abort_xfer(gi2c);
>   
> @@ -591,7 +604,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
>    * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
>    * @dev: Pointer to the corresponding dev node
>    * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
> - * @transfer_timeout_msecs: Timeout value in milliseconds
> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies
>    * @transfer_comp: Completion object of the transfer
>    *
>    * This function waits for the completion of each processed transfer messages
> @@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
>    */
>   static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>   						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>   						   struct completion *transfer_comp)
>   {
>   	int i;
> @@ -612,7 +625,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>   
>   		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
>   			time_left = wait_for_completion_timeout(transfer_comp,
> -								transfer_timeout_msecs);
> +								timeout_jiffies);
>   			if (!time_left) {
>   				dev_err(dev, "%s: Transfer timeout\n", __func__);
>   				return -ETIMEDOUT;
> @@ -736,8 +749,15 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   		dma_async_issue_pending(gi2c->tx_c);
>   
>   		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
> +			size_t max_len = 0;
> +			int j;
> +
> +			for (j = 0; j < gi2c->num_msgs; j++)
> +				max_len = max_t(size_t, max_len, msgs[j].len);
> +
>   			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      geni_i2c_xfer_timeout(
> +								      gi2c, max_len), &gi2c->done);
Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an arg ?
>   			if (ret) {
>   				dev_err(gi2c->se.dev,
>   					"I2C multi write msg transfer timeout: %d\n",
> @@ -852,7 +872,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>   
>   		if (!gi2c->is_tx_multi_desc_xfer) {
>   			dma_async_issue_pending(gi2c->tx_c);
> -			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +			time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(
> +								gi2c, msgs[i].len));
>   			if (!time_left) {
>   				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
>   				gi2c->err = -ETIMEDOUT;

