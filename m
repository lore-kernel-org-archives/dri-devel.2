Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52881CC6B20
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9054510FAA6;
	Wed, 14 Oct 2026 04:11:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F42810FAA6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:11:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DK6rgl806685
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2tQ/c0uS9hC5Os56HC6aI7TxaXNDLsi+KoptbI4i6IM=; b=R0NuLLlkhxeN/yPD
 2psNOAKDD8g2at7B3HZwUIGuZnsOQNPddoXeG0VZqy1h2tO7WVSe982vJS0Mg4+q
 68eYvgxZddQOdD8AlpUqGHAjkpKnm38kJXgnfygwxHdMuPzO0qWENIS9r7hyI7nW
 yJ06jyakCUj0aSJOOhpKf4pFY5c8QZ/1HQMzBnR35vrg7rhYAY6IWgmluvtmc2nn
 Eo42Hq2LVj44+JCD4jFtt6Y/WPy/WbOKe8k1IN4FfM6c2m3xEjfLpN2Q/bh6VuCr
 dIRk4aYYTc7jDyCM6xVc1YVCp6T0Z8k2kuLlmTS065bFtVU8p7l1OyCosFqwT9wY
 DCE8vQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud69gvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:11:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so2459613eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951060; x=1792555860;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2tQ/c0uS9hC5Os56HC6aI7TxaXNDLsi+KoptbI4i6IM=;
 b=MWoO9uRYx4L3c0sQ2kc9WpYM3JRzNiFrfWci1/7z/QJUgl1wIlQWsWpMNPUGbP0eRA
 SzwwiK1+sVby5kwvsdCeAYbRtjk73ZGDK1mX7149qmUypNl4lq1ktdoY94o5sj2dUOxo
 kX6t4UfDydFh6TXZxqS6OT0I4k7/S2dYpa4X3FO9bwb5DF528miyzzvSJnMRilak2tT2
 9CAdDRXrWGJQksNbE/j7yYNB/ZXvWUeookf2GQIy1/HsB15hWnD6Mc05+jxThY4iP1PZ
 bd961oehNf18ifRNyCd6Ulmev/cPZqNnpjy/rwsbZzdw7ltAF7Hzf2623a8yHM/bYvAt
 JO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951060; x=1792555860;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2tQ/c0uS9hC5Os56HC6aI7TxaXNDLsi+KoptbI4i6IM=;
 b=ZudQr4UCU/6kyjE9VhRnWnENijkZ1q1CvrclNHbtaW5mdCsjiibf13ncygAxRGX9lZ
 ScQawGxBGMnJcf9x52pwi1hqI/6sjkMIN13o6KOEhKmjWJSZB59cms22284b6kyJj88C
 3Tp5AtWz3gt60AgCwlQRe4bsXq9gwJphAWBpsD2xfBOuwFqszmM+5s3CMzU4ROzTGeTh
 YQrNPdKiSj5xreO6sL6+ohTRe956y0lidfkhvlzsHMpJB4Q412Mfcky6T7bSJvvuLvkJ
 OMO1EypWHAeN1FEigciKGTE7izleQZn0Ydib2B4+ZqyC3aB5/a3RcVOMeTKOsRVnlVaR
 yBiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz4nCY66SluLVWIHMYKygE7ujmYX3/yNcgJozrIBAEIDd0wVpGQFUQSWD1UIS3Aw22mnOttjBrJfo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL4zz80JjKT8urcVpW3FuWbks/3LP+A9Y9No6StTM1pxyk7xr9Q
 +tP+2M7iIvwBbTiKtEHukhdQGKBXIJ5IrQdQqIU8FIAqJFgdfX0i0Qb7xSMv3UQpSOT2DYBrCeB
 y/rAHPkAytMEJpXi6j9rzm3jtca9JC5GhwKKv/RE1jS/LVU0CI8eHsQN+LtnRcOyaaxY/n29M0p
 ZJZDohug==
X-Gm-Gg: AYBFou2kUWPt4z8o5lPWWqXTMriZymicg46us3J0FgZkOp4ntkGYGZDSIHockQRlpDu
 R9eALV/Ndp0rziBf3uuMnQ6pzloRRXpU3WQ6bXfKz+CQ7e5gw5jtv1TO/HFIo1Iha3TP1O8kvC4
 lbVhbxx1XpajCkwrWZQVyW5wDjmIYWmWfCXmAYGCtUCuGovlDWQNgTxBmliS5Sf5vRroJujbGrn
 nAzsETI5TcU0ae0r4jzQ1avmdfVpzSooyKH4zK60pKFlT/SAZzBMYqa9eXgoyHk12ks/FiIipSy
 gKrk31Lx9vZtyI9EeHER5ZAsXywyhQu0NbsBiUhqiHwOHAwOB4SuxJJEoXFqdItUD/2h2/VfUgz
 FAMDjn0FaDyFiHrYpJKKJ9VszgAombA==
X-Received: by 2002:a05:7300:e9c5:10b0:359:f28:412d with SMTP id
 5a478bee46e88-3590f28533cmr16950840eec.36.1791951059323; 
 Tue, 13 Oct 2026 21:10:59 -0700 (PDT)
X-Received: by 2002:a05:7300:e9c5:10b0:359:f28:412d with SMTP id
 5a478bee46e88-3590f28533cmr16950811eec.36.1791951058726; 
 Tue, 13 Oct 2026 21:10:58 -0700 (PDT)
Received: from [10.219.56.188] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d20dsm52191349eec.12.2026.10.13.21.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:10:58 -0700 (PDT)
Message-ID: <73949657-9beb-426e-a966-6f990eafa247@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 09:40:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: fastrpc: fix init ordering race in rpmsg probe
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
 <20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: X_R3iv2z6GVHbbRlcVWb-zRNqD5AFszO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX+umD3AtpA+S5
 Bv3Bi/1o/iA1wKYfGWG3Xyf7XaEkKOdNtXZVzNSKyCflUa79Q9+KpuS0YMLYhDAprwP8SMkuG5U
 tfmUVaGtLAHfih4fL1aSAk2e+bQiz8U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfXwYk6FYVop7f4
 eArtYphqXMqCetvqxK0jnzM9hn1MY1JUibiU4a44xRhzlwZEHlKOBgYITNhDiMhWB1okOpAEpok
 ZYDa9Sy7OSEk0wF7HIreLJgc5tnpFVk3qWQ69fZV25PfV7Q+x6ysH/C534eZASlWpVRXRNZj6RT
 lly7Rwd5F5WVlDu2i7lVnGYa4UEsPFI92gRugv2OcuBxF8PayRcgpl4bIHp+OscUIv4/l/s0lBe
 ex4Da71ELjiqUfYfPMYZn6s3IzOJDloUdqfKES9duCUVE80ZdfajdkOgmK4YQsJM/4qrvNPXwNT
 NmIdE+Ct1TxDiogDRSHSYzm70dEir8nzP39PysY5OmmpaKSnvC8QkGjbDeabRtdU7/8i0hgmBlz
 oXjTdxm3V4bIKP65zQ3491c+AbKBZJEz8LzsOxB0/hWTIvoVacbd9Pwolt45u7LcPTA4bMPwHyA
 xt+/HAZNhtlXpWz1dWQ==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6acf00d4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jkHBZFC6afHL268QTXoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: X_R3iv2z6GVHbbRlcVWb-zRNqD5AFszO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140016
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

On 01-10-2026 16:31, Vinayak Katoch wrote:
> fastrpc_device_register() calls misc_register() which makes the device
> node visible to userspace. However, kref_init(), spin_lock_init(),
> INIT_LIST_HEAD(), dev_set_drvdata() and fastrpc_cb_devices_create()
> were all called after the switch/misc_register block, leaving a window
> where userspace can open the device and call fastrpc_device_open() on
> a partially initialised channel context.
> 
> On a concurrent open(), fastrpc_channel_ctx_get() calls kref_get() on
> a kzalloc-zeroed, never kref_init()'d refcount of 0, triggering:
> 
>   refcount_t: addition on 0; use-after-free.
>   Call trace:
>    refcount_warn_saturate+0x120/0x148 (P)
>    fastrpc_device_open+0x204/0x258 [fastrpc]
>    misc_open+0xd8/0x1a0
> 
> Additionally, fastrpc_cb_devices_create() not having run means
> sesscount is still 0, so fastrpc_session_alloc() returns NULL and
> fastrpc_device_open() hits the error path which calls
> fastrpc_channel_ctx_put() on the already-bogus refcount. This
> triggers the free callback, kfree()-ing the channel context. A
> subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
> freed spinlock:
> 
>   Unable to handle kernel paging request at virtual address ffffcd5841510ca0
>   Internal error: Oops: 0000000096000047 [#1] SMP
>   Call trace:
>    queued_spin_lock_slowpath+0x414/0x5e0 (P)
>    _raw_spin_lock_irqsave+0x74/0x90
>    fastrpc_rpmsg_callback+0x4c/0xf0 [fastrpc]
>    qcom_glink_native_rx+0x6c4/0xf10
>    qcom_glink_smem_intr+0x1c/0x38 [qcom_glink_smem]
>   Kernel panic - not syncing: Oops: Fatal exception in interrupt
> 
> Fix by moving all channel context initialisation (kref_init,
> spin_lock_init, INIT_LIST_HEAD, idr_init, dev_set_drvdata) and
> fastrpc_cb_devices_create() before fastrpc_device_register(), ensuring
> the struct is fully ready before the device node is visible to
> userspace.
> 
> Add err_depopulate label in the error path since
> fastrpc_cb_devices_create() now runs before misc_register(); a
> fastrpc_device_register() failure must call fastrpc_cb_devices_destroy()
> to clean up the compute-cb children before freeing data.
> 
> Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: stable for both the fix patches.> ---
>  drivers/misc/fastrpc.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7ab1cbbf19bb..93d07d28a0f1 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2614,6 +2614,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	data->poll_mode_supported = soc_data->poll_mode_supported ||
>  		of_machine_get_match(fastrpc_poll_supported_machines);
>  
> +	kref_init(&data->refcount);
> +	atomic_set(&data->ctx_seq, 0);
> +
> +	rdev->dma_mask = &data->dma_mask;
> +	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> +	INIT_LIST_HEAD(&data->users);
> +	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
> +	spin_lock_init(&data->lock);
> +	idr_init(&data->ctx_idr);
> +	data->domain_id = domain_id;
> +	data->rpdev = rpdev;
> +	dev_set_drvdata(&rpdev->dev, data);
> +
> +	err = fastrpc_cb_devices_create(rpdev);
> +	if (err)
> +		goto err_free_data;
> +
>  	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
> @@ -2622,7 +2639,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		data->unsigned_support = false;
>  		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_depopulate;
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case GDSP_DOMAIN_ID:
> @@ -2630,7 +2647,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>  		err = fastrpc_device_register(rdev, data, true, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_depopulate;
>  
>  		err = fastrpc_device_register(rdev, data, false, domain);
>  		if (err)
> @@ -2638,26 +2655,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		break;
>  	default:
>  		err = -EINVAL;
> -		goto err_free_data;
> +		goto err_depopulate;
>  	}
>  
> -	kref_init(&data->refcount);
> -	atomic_set(&data->ctx_seq, 0);
> -
> -	rdev->dma_mask = &data->dma_mask;
> -	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> -	INIT_LIST_HEAD(&data->users);
> -	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
> -	spin_lock_init(&data->lock);
> -	idr_init(&data->ctx_idr);
> -	data->domain_id = domain_id;
> -	data->rpdev = rpdev;
> -	dev_set_drvdata(&rpdev->dev, data);
> -
> -	err = fastrpc_cb_devices_create(rpdev);
> -	if (err)
> -		goto err_deregister_fdev;
> -
>  	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
>  		struct fastrpc_session_ctx *last_sess;
>  		struct fastrpc_session_ctx *dup_sess;
> @@ -2682,6 +2682,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (data->secure_fdevice)
>  		misc_deregister(&data->secure_fdevice->miscdev);
>  
> +err_depopulate:
> +	fastrpc_cb_devices_destroy(rpdev);
In case of CDSP/GDSP, if secure device register is successful and some
application opens device, that could result in cctx ref being taken and
direct kfree(data) might cause problems, can you check that path also?> +
>  err_free_data:
>  	kfree(data);
>  	return err;
> 

