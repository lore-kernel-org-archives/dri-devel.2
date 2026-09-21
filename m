Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F41AC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7626810E39C;
	Mon, 21 Sep 2026 09:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gEW8KNSF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a8eQkuAI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E64310E39C
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:17:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L79xYW607136
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n+zrOo21ugBRzxhcPfBDsYADhDuFT+BowRPcmTeqWkI=; b=gEW8KNSFNdph8A2U
 QfOZVNgsMzjgLn8evgXNCg4P6gfdTb5QdHay6ueY26RTV1Zu2Z+BxMM2A81srUGZ
 hJzS62UXXeC44IRGa/fKo3qOV1POjsm0jb0BFe34ljUw6ybu8TimcduBGmEfA3Ku
 +7w/hGPsEhhCjwXHjgMcbaVraoAlyT+11nnbSPaicfl9BdQl56xoHPYEjemyZLVJ
 1UDR8iMOFveSSJgyGJQd8uIvza3TsKNrqWkKJec+bHnqlz/OMPBXxxzduMiLZbnx
 dSKMOvKgjmCN4DJvxsjqFdpz6zE47vG36auq4RBbuNQYxAt2wM3PMzfL62kiA76F
 H7gomA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehhnr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:17:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so7122784a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789982225; x=1790587025;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n+zrOo21ugBRzxhcPfBDsYADhDuFT+BowRPcmTeqWkI=;
 b=a8eQkuAIxdPUyF55F3PAUTr+b4O74vOPsf+xknuy7cN5k0u3Zd+VM9sis0WRFyVPtN
 lhhDtT5dCTorkm5AXJdBihRPN3y8LD7Rx1cUUSYm6/Ids+uOIzRsHMxD1lEKrtOuqpE9
 EAqj113EgDuPCH8NXIzA11EnloBu//0cMn+4u7esGU0qVJF45xYmEaW/xmzQQv2bONpe
 FAo8Ho3ZCCKxiwhY1wb88P3BDl+HJDwXRrBex/1jdBSpd0kfL7/LCWn4qTKA93Gosf5W
 +T9Od0dZ2bT1GOLoxgJcverVGb92gZiPJGoAY9WpLaLIYqoZRfePAXEYPptIY+uWCEKo
 sn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789982225; x=1790587025;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n+zrOo21ugBRzxhcPfBDsYADhDuFT+BowRPcmTeqWkI=;
 b=uiaKDtxyz6FL477pXX/seeNwr9uIqgpBz1y5wTerGROhyDH0jw8H7HKr+DdAM2hKCc
 YgzJgjyigWlpt0vEe8/6q7wIuzZrIyPbtoaQwxuFJp4rEqc+fpYGIS3qhIb9+2u5aRhv
 bLKryk0EMRjYQzK8xsdg0hbuPvifM4ikvWrB7UcOd68vPlw94Zr9/Q/qZMyHQwOBDhPg
 ZP5EwHAqN7voJx19PRYIKS0yjObGvM+krVEdorVEgESzBmUb78rBfvgyDfOfG356PrKD
 7dwfWPnXJKI4iDps1tWxiSJgNI3u3UQEpOrlyGexoFgw+wThwltMmzBz1n6xgFlZKXAC
 8aJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPF6MCFecJqv2p2IF5A4+Pef6pzBicsbWrQAzxpSnvF+HyDORaE3xW2RUOK06Yw+7Omvqu894putU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mfPvwjDq5nZPJdi6TiDO52I0D+9ugZPWWtCTSXYcXAPZ5Tn1hr
 wl3NllQfRuBL65o6BFPmcgVLjQR+GXDQog2vuUWPlE6bDFRGzwW3rCbeKkuevB1CE0yh09X4THj
 vd824JY+SZRoYrSoNbE67ctXmrbucebpVudfvraU2buQlyHYgfIK9/vbecLipUyNpb+LUzYY=
X-Gm-Gg: AYBFou06uCK1aS+YNk6OFSsEVI/S8muojvCCA5F4+90cgGcX1rgLySQHrwLTDsHBjf/
 fMGy2iO7R+36p3LHq7VzLpEkWyuXP2jjt7rDgiAJ1nEbXMq0KJxHgabaKC8teUGSsWpXg5/TM3u
 xOKedPs8lFYb/ImjfbtneMGXjtmHGxu6/dbBkroR01sE8auCYF4/kqKOflJbbhHE1HKF7CmSvGr
 /DImlAw7TYeUxWGxZ4Uo/AuhkD0oX4qpDSmerkCxgwZMt0B8OJSZfkW/bTp/q1U9mJe1ix5Ew1D
 nxjs3zBDa5tGM6oteivDlJ8lf6r1q3Nee3oMxSNAm+cvh6m/Mb5eDPS6aN7oxZ9ri+MIVFLQWlM
 9JPjkXpKoOW7GsqRKv7zOBa1OJI0=
X-Received: by 2002:a17:90b:4c52:b0:39e:6a80:b799 with SMTP id
 98e67ed59e1d1-39e6a80b896mr10632572a91.41.1789982224932; 
 Mon, 21 Sep 2026 02:17:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4c52:b0:39e:6a80:b799 with SMTP id
 98e67ed59e1d1-39e6a80b896mr10632549a91.41.1789982224459; 
 Mon, 21 Sep 2026 02:17:04 -0700 (PDT)
Received: from [10.219.57.63] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331aeeddsm17414763eec.24.2026.09.21.02.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:17:03 -0700 (PDT)
Message-ID: <22594579-a48f-4343-84e1-5bdd99478b9c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:46:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] misc: fastrpc: iterate CB nodes manually instead
 of of_platform_populate
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org
References: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
 <20260826-dup-sessions-v4-1-35555d2bfed4@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260826-dup-sessions-v4-1-35555d2bfed4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX+dBF8lNAa9c+
 MvAh9Y9TmqsSbmTdEChAAZxKNo1H+hK7/RVB4paNj2XuUhkpSBPhweRmhUzE7lJBsdrnZrNQxRq
 jIrWkL9muZ4pUO5oJe1AD5sGLmCuIV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX3+1XgSEaNPd7
 TXcB0eZ9u5g890/BDkrOUntpOLv1pld1yRVAaaxAxwTDvw04TmVSunNi3mZHL68UTEjcLYELcGL
 9zmH2JQh35FSJLe+R+brwfHubrEesadtPsDnW4aazcSOVTbvm407X0UQ0e8XL3HNpUD0qhZ5e/V
 p/L65fQeFuBrVp6UqOLkpfrGuxmdsll5lC5m4+pBynj/0EZiXpOZet+kcB5EFRwQ5ZChUk2To87
 LCQwoge3zG0cI+oSJCF0nOuXB+2sz2rf7OiBwVWcuUq4RfrYEyaO3uARiKA+hftSFQub9y/1JT7
 qePfvj2szurd6rIQSNIK818rl4+/DKLie2Yk3FGqCZTxSdWK4b0e4eEQ35gtOkZokKENi4BArjw
 1YVWjWciBuLrKXyw++XDNtqgQLybWCsir7nGN0B7QtC/IzKtZLlDLAvVhgMjofqx+c63qOyVR+F
 1BZqVewK4kwSna4T2oA==
X-Proofpoint-ORIG-GUID: ZioWkzYchxCid9HObvISKZCOlrb4j1Rp
X-Proofpoint-GUID: ZioWkzYchxCid9HObvISKZCOlrb4j1Rp
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0f611 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0HjoTqE-giHM8b9XGacA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210131
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

On 26-08-2026 18:55, Vinayak Katoch wrote:
> of_platform_populate() only guarantees that child devices are registered,
> not that their probes have completed before it returns. This creates a
> window where fastrpc_cb_init() may not have run for all context bank
> nodes, leaving the channel context partially initialised.
> 
> Iterate over the child device tree nodes directly, initialising each
> qcom,fastrpc-compute-cb device synchronously. This ensures all context
> banks are fully initialised before fastrpc_rpmsg_probe() returns. Since
> fastrpc_cb_driver is no longer needed as an independent platform driver,
> remove it along with its match table and remove callback. Set
> OF_POPULATED_BUS on the rpmsg node so that of_platform_depopulate()
> correctly removes the manually created CB devices on teardown.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 83 ++++++++++++++++++--------------------------------
>  1 file changed, 29 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca86..a153107d0085 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2363,7 +2363,7 @@ static const struct file_operations fastrpc_fops = {
>  	.compat_ioctl = fastrpc_device_ioctl,
>  };
>  
> -static int fastrpc_cb_probe(struct platform_device *pdev)
> +static int fastrpc_cb_init(struct platform_device *pdev)
>  {
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
> @@ -2385,7 +2385,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>  		spin_unlock_irqrestore(&cctx->lock, flags);
> -		dev_err(&pdev->dev, "too many sessions\n");
> +		dev_err(dev, "too many sessions\n");
>  		return -ENOSPC;
>  	}
>  	dma_bits = cctx->soc_data->dma_addr_bits_default;
> @@ -2419,38 +2419,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> -{
> -	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
> -	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
> -	unsigned long flags;
> -	int i;
> -
> -	spin_lock_irqsave(&cctx->lock, flags);
> -	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> -		if (cctx->session[i].sid == sess->sid) {
> -			cctx->session[i].valid = false;
> -			cctx->sesscount--;
> -		}
> -	}
> -	spin_unlock_irqrestore(&cctx->lock, flags);
> -}
> -
> -static const struct of_device_id fastrpc_match_table[] = {
> -	{ .compatible = "qcom,fastrpc-compute-cb" },
> -	{ }
> -};
> -
> -static struct platform_driver fastrpc_cb_driver = {
> -	.probe = fastrpc_cb_probe,
> -	.remove = fastrpc_cb_remove,
> -	.driver = {
> -		.name = "qcom,fastrpc-cb",
> -		.of_match_table = fastrpc_match_table,
> -		.suppress_bind_attrs = true,
> -	},
> -};
> -
>  static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
>  				   bool is_secured, const char *domain)
>  {
> @@ -2642,12 +2610,29 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	data->rpdev = rpdev;
>  	dev_set_drvdata(&rpdev->dev, data);
>  
> -	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> -	if (err)
> -		goto err_deregister_fdev;
> +	of_node_set_flag(rdev->of_node, OF_POPULATED_BUS);
> +
> +	for_each_available_child_of_node_scoped(rdev->of_node, np) {
> +		struct platform_device *pdev;
> +
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb"))
> +			continue;
> +
> +		pdev = of_platform_device_create(np, NULL, rdev);
> +		if (!pdev) {
> +			err = -EINVAL;
> +			goto err_depopulate;
> +		}
> +
> +		err = fastrpc_cb_init(pdev);
> +		if (err)
> +			goto err_depopulate;
> +	}
>  
>  	return 0;
>  
> +err_depopulate:
> +	of_platform_depopulate(rdev);
>  err_deregister_fdev:
>  	if (data->fdevice)
>  		misc_deregister(&data->fdevice->miscdev);
> @@ -2677,6 +2662,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	struct fastrpc_buf *buf, *b;
>  	struct fastrpc_user *user;
>  	unsigned long flags;
> +	int i;
>  
>  	/* No invocations past this point */
>  	spin_lock_irqsave(&cctx->lock, flags);
> @@ -2697,6 +2683,11 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	if (cctx->remote_heap)
>  		fastrpc_buf_free(cctx->remote_heap);
>  
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++)
> +		cctx->session[i].valid = false;
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> +
>  	of_platform_depopulate(&rpdev->dev);
should this also be removed?>
>  	fastrpc_channel_ctx_put(cctx);
> @@ -2786,28 +2777,12 @@ static struct rpmsg_driver fastrpc_driver = {
>  
>  static int fastrpc_init(void)
>  {
> -	int ret;
> -
> -	ret = platform_driver_register(&fastrpc_cb_driver);
> -	if (ret < 0) {
> -		pr_err("fastrpc: failed to register cb driver\n");
> -		return ret;
> -	}
> -
> -	ret = register_rpmsg_driver(&fastrpc_driver);
> -	if (ret < 0) {
> -		pr_err("fastrpc: failed to register rpmsg driver\n");
> -		platform_driver_unregister(&fastrpc_cb_driver);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return register_rpmsg_driver(&fastrpc_driver);
>  }
>  module_init(fastrpc_init);
can you use module_rpmsg_driver() instead?>
>  static void fastrpc_exit(void)
>  {
> -	platform_driver_unregister(&fastrpc_cb_driver);
>  	unregister_rpmsg_driver(&fastrpc_driver);
>  }
>  module_exit(fastrpc_exit);
> 

