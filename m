Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B0F459F9
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1039B10E99F;
	Fri, 10 Apr 2026 17:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMoDkyl7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aaVM6UTE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2A710E99F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:01:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AAhIo34148720
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bp/JyCTFtYQweJXfZZHfGdsxTk73Q69WkzJJd9yJDo8=; b=TMoDkyl7oeUMHSz1
 h4wbFV4nYnVGhfvzDmN4xUy6d0XMg8QC98zam32doQLoGBKcgqhlDgl2GGhxsAwD
 Xhtc0/Lxf0xf6G53bITxUHvJYoRwyAT/NjGQgPi1RxMVFBjKMVaNySXEOU4Ary16
 whCWw85DgOcGC39X74/lnJBWIlOuxiq7kLenyia2XyhsogfphGqWMJkkdL2HR9LM
 3s1mbFDwoIFjzh9Bv2CfVchktonmZinmvNQUZR+7aRBnXciYJvggaocDtWc0Wal1
 hNq2TtTgsEfTfLzAkagGORu7vD/v2zFFu3XEY6O2CxDzdXL0k7aaRg5EZknl4it0
 Ct6dIg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudgj6uk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:01:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so2532082eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775840513; x=1776445313;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bp/JyCTFtYQweJXfZZHfGdsxTk73Q69WkzJJd9yJDo8=;
 b=aaVM6UTEH3K7qC9XQUSqk5DDrpX8GHLWO7sVxv6ed8J5gvhpMD9u5LovprHr5H4fls
 klHUi8siXl8GsKNo/ICpeZ0kOQssGdd+Qn3MQUQBLMgkfCRAPqRzLUllLK+tKVjxzekU
 eKZu6cR4/21BfQ+6n2A1jL82BZyp8VBGMJ45fVl0dRXrxxaybGOBMnxNhiMixLwFnfyx
 Dywtu7kGOgyZ7W1ICDC9cR0DGfcY5Y8E41f3TRswWw2dOrIqUwJZyZ5hDls1EezXj7UF
 l30UXvpAf2N7pNTo1JHPgeiT48GwA4AfD9GeSUoOE3C9lUEWnc4jw3jOqg9xxw9bzrHq
 SfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775840513; x=1776445313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bp/JyCTFtYQweJXfZZHfGdsxTk73Q69WkzJJd9yJDo8=;
 b=fnbUWIwV7EHAeLAQJhdS42YCZfuY0mOfHIkl1rU6kl6eHtexSVTHW2oB7A2VLM0UMq
 BzrZFnsRzjuxqwmbNFnDa1hcC6Y3M6zisZ0Hl4Xpo4qipNvxE+lLzroVN+RvhUre9pdr
 kJOvgVn+wqjrsSlAv2gjMIm4mgkQgENwHdj2QKPvbNPX+NQbdv6F2+Jt0zgEPiumUXvS
 WX4bgTVDNRSSgT43Lc6nuVXje43irw8gh4WzCuPHnPqzc9iYRwiRJPSo7igtj2f+VTKu
 DBmxo/ztqyoQjdwJ16ImgXv3s9knzwgBpZV+EDAMqcfTIR3luNCOwjvo1Ky5Fde3TAJd
 2Tqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFl3MjNfr5Y0QJRRLqCF0spQf2kbaCCyX4Dv9QGsPeFE4pE5gCwyLngl7RhdkcqUPA4yiZj2OpOzM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycS+8TCeOZyjM0BohTffbZRRl8tqj3E2wCmMHfwEtXpErWYofR
 6qlPvs4AyWBPiYI20qaMPJ/7YmvVWL8gkNr36NMAn0BRtMORVVRziBcAPd9BQHv/oIq+/WR4Hnv
 bQVuTqBTfLZrJBwPcDURfrqqb2fsfIHPXcABjseTlMvsmdhO4Fm515r9ry/o38gMsNVaeNO0=
X-Gm-Gg: AeBDieuB7ByDvOs7UDD03QEuvyQDssonJRSxNoJpqVWPx1km8ggEyKf2oTBLhVE92L/
 +oP6QhQ6pUvuScp5KCgkdBOmKeQUbU7JwCJAXnI2jRf4TT8LqWj2Ag+HSgMi0wz30MqxNB2ztVR
 7J1eSZXADoNFI2gs2jIpEPc2i7GwG0ZUnQnSUNryRBF/g22XEoexnIM0yt9OonWH1W+Srtepiap
 ZYax9RpSOGJaQyU/FWcR6cMAidcsHkTeDyOEnw4oTpTPH6WsZWmqdNp7g2nM/cIHyjmo2S7VLxw
 kbD4uG/sRDo3DWgwJSvk354lu8JnXTbt99qWSNn2xnYoMOAu9zBFL9WANaxZJ2u/5DJLhrIBZRD
 DiHkrbB6La1y4eYreu9URzO85sbpepRKRIQaheoWEQEf9V2p+SZo454mf+k2hVHw3GMxErmD/9W
 E=
X-Received: by 2002:a05:7301:4089:b0:2cc:afce:bc01 with SMTP id
 5a478bee46e88-2d589daf1b2mr2340779eec.29.1775840511793; 
 Fri, 10 Apr 2026 10:01:51 -0700 (PDT)
X-Received: by 2002:a05:7301:4089:b0:2cc:afce:bc01 with SMTP id
 5a478bee46e88-2d589daf1b2mr2340682eec.29.1775840509759; 
 Fri, 10 Apr 2026 10:01:49 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm5778968eec.3.2026.04.10.10.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 10:01:49 -0700 (PDT)
Message-ID: <b772c81c-3628-45c5-ab11-a0737a94b812@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 11:01:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260401220643.12802-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fkoKbq9lhrSBvDrnvU0gRWncwtu5aPxU
X-Proofpoint-GUID: fkoKbq9lhrSBvDrnvU0gRWncwtu5aPxU
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d92d02 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=xkNXEimOluXcSHuVYG0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE1OCBTYWx0ZWRfX3zKQ1qHZJydr
 +QkRHS9ttgYEwOYZ6RlYObKHqsVRDCb89OnABFCbZfC+gPrgrHK6gqUGArvN1+QyoRv1V8HweIt
 j2sJWDGBWWh3VZsfR8pczLA/sIfRVGDADbJzbHuz642BqQ4F7WBh514bCN9Ar7cTov9oeO+14JK
 E1SLIgX451ski0y/LHqNyYmPxG3yZ/phb/J8j/xcNebXU3yMP86r97/Rahls5OEAUs8QG4XZk+p
 UuzUcjm66Kp5p+u1NOXDxB88SYTm1Vb1g+8D+YqpKtCQuz8cxWgNnr3VLsUIBn0bA/ftVVeInW3
 T30jFdUqn1gWuMTkZ8QUwwva1T+eU5M486nlNqOiYvpzaD/RP4GL0DsIO03Q3efnBHCaF8B8IZB
 SUbkQK7FZzvhWsskZ7UBlz6FvofQ5PGQ/n/P4OKVgSGXkebIFUq5Js0G58nzlISoQfGnT/FncQ9
 87alSK82GHTqpNQyKAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100158
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

For future reference, $SUBJECT should have a space between "PATCH" and 
the version. git format-patch will do it correctly for you if you use 
the -v option.

On 4/1/2026 4:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.

This reword addresses my "why" comment on v1.  However I don't see that 
you responded to my question about how this was validated. I don't 
require a v3 of this patch, nor do I really want one. I want you to 
reply to this message and detail what validation you performed on this 
patch.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v2: use macro for number of elements. reword commit message.

Also for future reference, a blank line to separate the change log from 
the patch diff here makes the change log easier to find and read.

>   drivers/accel/qaic/qaic.h     | 4 ++--
>   drivers/accel/qaic/qaic_drv.c | 8 +++-----
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
> index fa7a8155658c..e237020f6aa9 100644
> --- a/drivers/accel/qaic/qaic.h
> +++ b/drivers/accel/qaic/qaic.h
> @@ -152,8 +152,6 @@ struct qaic_device {
>   	struct list_head	cntl_xfer_list;
>   	/* Synchronizes MHI control device transactions and its xfer list */
>   	struct mutex		cntl_mutex;
> -	/* Array of DBC struct of this device */
> -	struct dma_bridge_chan	*dbc;
>   	/* Work queue for tasks related to MHI control device */
>   	struct workqueue_struct	*cntl_wq;
>   	/* Synchronizes all the users of device during cleanup */
> @@ -206,6 +204,8 @@ struct qaic_device {
>   	void			*ssr_mhi_buf;
>   	/* DBC which is under SSR. Sentinel U32_MAX would mean that no SSR in progress */
>   	u32			ssr_dbc;
> +	/* Array of DBC struct of this device */
> +	struct dma_bridge_chan	dbc[] __counted_by(num_dbc);
>   };
> 
>   struct qaic_drm_device {
> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 63fb8c7b4abc..1dda8dfea5a4 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -43,6 +43,7 @@ MODULE_IMPORT_NS("DMA_BUF");
>   #define QAIC_DESC			"Qualcomm Cloud AI Accelerators"
>   #define CNTL_MAJOR			5
>   #define CNTL_MINOR			0
> +#define DBC_NUM				16
> 
>   struct qaic_device_config {
>   	/* Indicates the AIC family the device belongs to */
> @@ -405,15 +406,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>   	struct drm_device *drm;
>   	int i, ret;
> 
> -	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
> +	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, DBC_NUM), GFP_KERNEL);
>   	if (!qdev)
>   		return NULL;
> 
> +	qdev->num_dbc = DBC_NUM;
>   	qdev->dev_state = QAIC_OFFLINE;
> -	qdev->num_dbc = 16;
> -	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
> -	if (!qdev->dbc)
> -		return NULL;
> 
>   	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
>   	if (IS_ERR(qddev))
> --
> 2.53.0
> 

