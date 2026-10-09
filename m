Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C5CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31D510E04B;
	Fri,  9 Oct 2026 06:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLekEbqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQpBylwe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F5110E04B
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:02:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993HKka4178443
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 06:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 60YgA86+GQN4v5pv9VjFhYCGaZUcpH9rkoEgoxf9GQ0=; b=DLekEbqkJHfJZ10D
 IaeOnTjDOI8/ia+dW1xRDP8KnNjo0oJeAKBnPMbfqY33/OUahRS8Ks8OnZMsSYyC
 Z1Be77kFvxKuenI+Ah2o6ST20sjPfS1e3qBrA5ejAcjG3zvrvyWCuV5E2DLFknX0
 IbEY4YqKf85vzB3UeESRfMO6fvhbjWBMMKEPWmRwoDSXcCmq7QgKxeFp7gqjB39t
 ZJr9hcdxBZ64P4XHEiaT4AEVlw1OofutSsmMvGEs7vGiGMTbKuSgaLGReCsR50Ok
 2G1TRoSSYKS0xyHqDLY9cisvi2Y2ao/J6e0gkIOEDNGJk/h7F2X4QpoREpGnQgef
 tf8X4A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrt65q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:02:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6f80c76e6so72816195ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791525774; x=1792130574;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=60YgA86+GQN4v5pv9VjFhYCGaZUcpH9rkoEgoxf9GQ0=;
 b=iQpBylweSTbrTI8X6PDDW8/GdNxqvQTZ7EllIfT0Qw1aN9HDhpFVa78fdIJx+QxNia
 ee47V1pBsZ1e7ZEK7vt5AuMaUhlYeeVazR7p+9KOArze/elSp/WEM86A+9etPDSMM8kK
 BTfD6p09E8HO+pTfVGzk2olHpiwdKI6GA5fPHPNQekHUzTXDaMm9OOp5LEYgvELdu5bz
 ju7/QCAK2pWID4uPy8B+d3oN7k/HE+Mlb9rLSAw8290klTdSePzKNh95GSfVNP0/jWrS
 q4iJ2CuvIicTDqXoclzE6u6jx/dpcZDjpCej5CnVyr7+ZpGDQdBpKlvDgAYGd5jHdbbs
 0kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791525774; x=1792130574;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=60YgA86+GQN4v5pv9VjFhYCGaZUcpH9rkoEgoxf9GQ0=;
 b=MlACjOv/SfoHfIxipWbFtFolozhIRRUevgxCcTDkzdQyntwIDU3D6FuWGnSwL+f2GO
 iRq+392JqxH31yB3zeDUIUkaCYTH+ZehqooyMDOFS7H5UmOyUkMCCmXpImi5FvW9vG0A
 agqwx2g5wwniLkBubNs+syMyj2D8S/+kza/QccLDNv1eC/qdoNBK3JtOG6Xmh6rHA6lu
 CHgSZ2xUUkpsEfQZfLWvJtJukq1NrfungubMUxJk56E2NAFw6GJLKmgVjMGeth+eorWr
 RQSQ136vhffdzH8b5ltG/uVO2ZVBmHMk5p5SRLkb1G1lMyB/7Msdg+KZXX6qvhxQL6sn
 CK3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByEH5jU5p6w0j510ZLpd2Rbid4z2YqG0P3i9pCUtSkgj+iKF9ugHQPrAUTROPf563Xfcs3I5Qkb62A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKZO+xtL9SpXDzDloAA+/wGtNhrTePz4MfAdDvhpbb/LILzlAcY
 gvWaPY5N7O5yor8p7fRHXkQ6uS4+DzmdaGxN41x/Mzey7jMRE/wGH/t2q/qq2MOVK99RcbGRPoc
 EFTOyVMiQ1zAqxOpxcW6B3kRTMqKr0Ls3Kb1fxKPypWwIZ//yccw3x1sAIoZ/Eh8hoOllqnQ=
X-Gm-Gg: AYBFou07M1upC8xFWyD5fhmLMoZqmNlTuUhofx1YOVfX34R7rUNQsDxCVQqIlPvTLZN
 nrU4gxFYd5ayuCnnHKGVFj3+d7a5p5UeW9UD6Z4kndZ+E5W/YbBeFdNdn2DoRui6V+9nnN7S/QU
 pQKqKjLEKc4q4VLvnDwebOejmJ7Co7/Dd2L04LPJJEgGhFapaQZ/OlsFY71v922p5Zjda0Z8NrH
 tE1/6jTUIMUgzALzIBJxTr3nwbJcmv7yQCBC4/zao8WC5YEdXPs8Dx6Y9R5fJlu7cgR03URONOZ
 gHYe/W6MprlzBKSTKIJEJtmrIj5Hu7oPP+Fhn1viI5dqAwGlKHey7tCH6IWYHoLlRKjtEBvA/Be
 G8roxkIrwDfWD736HiOW737pvEueV
X-Received: by 2002:a17:90b:2ccb:b0:3ab:1af3:a0d with SMTP id
 98e67ed59e1d1-3ab3ac63ba3mr904211a91.33.1791525773470; 
 Thu, 08 Oct 2026 23:02:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccb:b0:3ab:1af3:a0d with SMTP id
 98e67ed59e1d1-3ab3ac63ba3mr904180a91.33.1791525772712; 
 Thu, 08 Oct 2026 23:02:52 -0700 (PDT)
Received: from [10.219.57.162] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38f2f866sm2466686a91.10.2026.10.08.23.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 23:02:52 -0700 (PDT)
Message-ID: <f9e811df-f0d3-4dcb-adde-7c4e42fb9ceb@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 11:32:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] misc: fastrpc: iterate CB nodes manually instead
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
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
 <20260923-dup-sessions-v5-1-e953133a1827@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260923-dup-sessions-v5-1-e953133a1827@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8838e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=SHHY10jX5hRKE-y4DCcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 4WjGX8TPdiyA8wH9VXhCCJoP4aZllbZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyMyBTYWx0ZWRfX9OdBQaQW954j
 QZzpCcOFZBHI4Zdgtm2SnLkaiv//KC/HoVrd9hdjOIlk/jKA7wBwSCt+8/SLTIRAzLujzIsgwjw
 ZB8wscI5m2oiKzf5srydfF/e/HttF62caNO8lLdqlIwMMYthAUy1qJ9q/q+aXjHW8j3Eqaxpmdy
 neUrmhXNPcxYYXULQLzmKjJ/4ShTi8W6R/2Tn0npJ956eplqLXuQtQm24bdoJ58vLg5Lbwb+Vuo
 lRaV0TKuWVacaSi5d7p+CW6Vz/3mluZY7SjuqOhOu5pYsCg3sSyEkYrn9igEifA7OQFf+UNFViD
 dLgLfuLZXu2YOSth5SKhn16LO+QqHLrpv95+qs872C+Z+zKmSpVImDuq02UosPFCJYRZyr9L6ek
 sfc463G1Gd3NegzR9lEEwKfc4uI0LotY3KWmFZx6RTNEvojLBU6/zdwM17UkI8un0uOjXl3P5pn
 KFHH3Hx3Spz5FUiEZwA==
X-Proofpoint-ORIG-GUID: 4WjGX8TPdiyA8wH9VXhCCJoP4aZllbZi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyMyBTYWx0ZWRfX81P5AWnGooO6
 icHJHc/ZZq4Hxzqcf8IyW2Iodhtgl4Bw/zoOzFMo7o8bOXz2IYzEqWTPdq2jxUjLeEkyvlRwZss
 WT81If4eFMIUBbvdB0b4T9DWmJbu1lc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090023
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

On 23-09-2026 14:09, Vinayak Katoch wrote:
> of_platform_populate() only guarantees that child devices are registered,
> not that their probes have completed before it returns. This creates a
> window where fastrpc_cb_init() may not have run for all context bank
> nodes, leaving the channel context partially initialised.
> 
> Introduce fastrpc_cb_devices_create() to iterate over child DT nodes
> directly and call fastrpc_cb_init() synchronously for each
> qcom,fastrpc-compute-cb node. This ensures all context banks are fully
> initialised before fastrpc_rpmsg_probe() returns.
> 
> Introduce fastrpc_cb_devices_destroy() as the symmetric counterpart.
> Before destroying the CB platform devices, invalidate all sessions under
> the channel lock so that any fastrpc_user still holding a reference to
> the channel context cannot acquire a new session backed by a destroyed
> device.
> 
> Since fastrpc_cb_driver is no longer needed as an independent platform
> driver, remove it along with its match table and remove callback. Use
> module_rpmsg_driver() now that only a single driver registration remains.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 104 ++++++++++++++++++++++++-------------------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992ee..f20d3e5ecc81 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2333,7 +2333,7 @@ static const struct file_operations fastrpc_fops = {
>  	.compat_ioctl = fastrpc_device_ioctl,
>  };
>  
> -static int fastrpc_cb_probe(struct platform_device *pdev)
> +static int fastrpc_cb_init(struct platform_device *pdev)
>  {
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
> @@ -2355,7 +2355,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>  		spin_unlock_irqrestore(&cctx->lock, flags);
> -		dev_err(&pdev->dev, "too many sessions\n");
> +		dev_err(dev, "too many sessions\n");
>  		return -ENOSPC;
>  	}
>  	dma_bits = cctx->soc_data->dma_addr_bits_default;
> @@ -2389,37 +2389,63 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> +static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
>  {
> -	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
> -	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
if this dev_get_drvdata() is not used, can you also remove
dev_set_drvdata()?> +	struct fastrpc_channel_ctx *cctx =
dev_get_drvdata(&rpdev->dev);
> +	struct device *rdev = &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
>  	unsigned long flags;
>  	int i;
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
> -	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> -		if (cctx->session[i].sid == sess->sid) {
> -			cctx->session[i].valid = false;
> -			cctx->sesscount--;
> +	for (i = 0; i < cctx->sesscount; i++)
> +		cctx->session[i].valid = false;
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
can there be any such case?> +			of_node_put(np);
> +			continue;
>  		}
> +
> +		pdev = of_find_device_by_node(np);
> +		of_node_put(np);
> +		if (pdev)
> +			of_platform_device_destroy(&pdev->dev, NULL);
>  	}
can you check if this works here instead of above blob:
device_for_each_child_reverse(rdev, NULL, of_platform_device_destroy);>
-	spin_unlock_irqrestore(&cctx->lock, flags);
>  }
>  
> -static const struct of_device_id fastrpc_match_table[] = {
> -	{ .compatible = "qcom,fastrpc-compute-cb" },
> -	{ }
> -};
> +static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev = &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int err;
>  
> -static struct platform_driver fastrpc_cb_driver = {
> -	.probe = fastrpc_cb_probe,
> -	.remove = fastrpc_cb_remove,
> -	.driver = {
> -		.name = "qcom,fastrpc-cb",
> -		.of_match_table = fastrpc_match_table,
> -		.suppress_bind_attrs = true,
> -	},
> -};
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
> +		}
> +
> +		pdev = of_platform_device_create(np, NULL, rdev);
> +		if (!pdev) {
> +			of_node_put(np);
> +			fastrpc_cb_devices_destroy(rpdev);
> +			return -EINVAL;
-ENODEV?> +		}
> +
> +		err = fastrpc_cb_init(pdev);
> +		if (err) {
> +			of_node_put(np);
> +			fastrpc_cb_devices_destroy(rpdev);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
>  
>  static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
>  				   bool is_secured, const char *domain)
> @@ -2639,7 +2665,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	data->rpdev = rpdev;
>  	dev_set_drvdata(&rpdev->dev, data);
>  
> -	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err = fastrpc_cb_devices_create(rpdev);
>  	if (err)
>  		goto err_deregister_fdev;
>  
> @@ -2711,7 +2737,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
>  	}
>  
> -	of_platform_depopulate(&rpdev->dev);
> +	fastrpc_cb_devices_destroy(rpdev);
>  
>  	fastrpc_channel_ctx_put(cctx);
>  }
> @@ -2798,33 +2824,7 @@ static struct rpmsg_driver fastrpc_driver = {
>  	},
>  };
>  
> -static int fastrpc_init(void)
> -{
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
> -}
> -module_init(fastrpc_init);
> -
> -static void fastrpc_exit(void)
> -{
> -	platform_driver_unregister(&fastrpc_cb_driver);
> -	unregister_rpmsg_driver(&fastrpc_driver);
> -}
> -module_exit(fastrpc_exit);
> +module_rpmsg_driver(fastrpc_driver);
>  
>  MODULE_DESCRIPTION("Qualcomm FastRPC");
>  MODULE_LICENSE("GPL v2");
> 

