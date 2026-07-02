Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4802BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 05:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF9B10E43D;
	Thu,  2 Jul 2026 05:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ro7Z422w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fcxHcD0I";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D13F10E43D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 05:35:14 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6624lc3x3485718
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 05:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BXQOVmnUutoNTds54kZvzeA6Cp+B841HmrjaPmvpvAY=; b=Ro7Z422wvJg6R1s7
 Y0kcMu0dvzFNqsYCQi+5vP5rKolNBWse0+yiKy0SFP2ebg15PUlx+K/R49KfqgT/
 9aaAnJ3RE6Lks689pwq04JwO37K14wcAvoK2ES8ZalzlTzlYHkwDK0CyJq+TIhZn
 0gUg2ZLwJregtSEi1+xPif6BrWe+Jw6cUS7gZ2uGSEvtSfSKH+e1YSe7VKnPW2I6
 btlxDsKQSxpkWJSh5QetF/LooBkd1CNSfXzVrL06cG9ZkV9L+MsvV4hgUkULupXL
 onvBGvV8y+yIXsSm0X94pZfDPwp/RTuZMOfP3MoVvPUsHQ59fz2LLGDYxZzAixSM
 LuUuYQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98g43k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:35:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88da04b71dso1636734a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782970512; x=1783575312;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BXQOVmnUutoNTds54kZvzeA6Cp+B841HmrjaPmvpvAY=;
 b=fcxHcD0IqxMRDThTSPUe4UgI/8a2Lt0GZKegrVj63SR8aI5QB5ITeBf5amVbNtNit7
 mJl1yR4/MYCFwonoeH2uDH2Z35lSlHFMKsxcUVubdy76GjNZDVG4nBAcvfnF+IyZ5aei
 JcC7Mq/zCknyvOcZydDIWzzyjOa63/MoPy4RImgRzZblL/8FBpcCEJB6EYA7feI/fe0E
 Bzr6ZSUBr2OXOkdg6cCQvdpI3tb47ztu5614o+2MDJ8/8u9IQ6s6fWIOksYXyKtSvtoc
 OCtRevr4zfz8QeHXLlz+5D0R0alo1kdixSWaCtEj6EaeQRoHLREhWd+G60YydQsO12rX
 fKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782970512; x=1783575312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXQOVmnUutoNTds54kZvzeA6Cp+B841HmrjaPmvpvAY=;
 b=cztdWRr1wS2o6ld2KT6Qo6o2jRqscymmxs4Odi+HtFPWATqNRV7g7/fc0BT4Mu2spo
 dYP6WAhaFTHyMh77wuFBwEWHbPKoAb0yUaRNBVq5P+FHMrUDWX7H+jbMG8BSqnamlS05
 lxA4pr96kI4ofeg+zlB3wBDzHLmM6QX4h0dj1AkOQMCTJVLMIcfj/+rAlLLXou/OWQcd
 z/lWJE6PkfZYjZZ/PC5j+TuIf8dj6z66uji3Uw5JMazHaE/cHzupOII9FJ39Odc1Um+B
 SW34wUsaQPRB7eEZg4IwkzE5LZvEqsxao/A2FGUXn3MOnEIwM2oe8Zoj1MYFoPMtHLDC
 CHGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D4d+OtyNw2ngV+uEoaIZxue9KbJ1jWVX9WRFMUDUw7eGA8pl2wlgUp0Ck1deQb4yLA10AUX3y9Yc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO3wB+znIvXSak9JylU1cKcCb+GEjcTf+07YnuWNO5jZUKemWr
 lAvQBo9W+CYWpdDuzbWGJBjm5w/Q9FlQu7qPTe+yuO7XWBA5qOADQZAgixC44ec6QOOI9hmlXo8
 Odln2i6suKC4rWGEH7zxlkaihZ0rwYyiQi5xHcw8qLfiQA7Apfjd8PAy7vpaMeYqOPFgaZAU=
X-Gm-Gg: AfdE7clwJ+eNiTbZgbCMQDb/z+lIxEP0wXCwzXsIl4nosP78pbCXfwfugfSVY/j7vgx
 0bzx3WkWthMgSr+Nxomy+YmB/5/K7zSKsrRzg1ZdqfivFQv2TqzVmmgU3DSWsLEGw9tjW1xJtem
 gJauVn5Qpa4DFYUgGdDQ2aLaNC5/+15lMURC8K2bCma41hInj6/a5Wu2/VA288PxOl7Sgksldav
 hM1Yq160ZZnc1u5huSykk4EkqJqi+s2EGzjLJVskJfBRXdowC+lMfJAbfRzgMwBpjSrFRydcyKQ
 ujj5hUNDTfltcSeAcleSbzI/g8JyK4dy3BEb4yXnLPc7SruihGJWsu3oLIXXBVv2fcJKfCx9cyi
 vCk4Wb5sNev5s2fh2A2onED1NJch+hpM4arBQwa8V
X-Received: by 2002:a05:6a00:3018:b0:847:73f1:4ce8 with SMTP id
 d2e1a72fcca58-847c094766bmr4215992b3a.46.1782970512082; 
 Wed, 01 Jul 2026 22:35:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:3018:b0:847:73f1:4ce8 with SMTP id
 d2e1a72fcca58-847c094766bmr4215958b3a.46.1782970511558; 
 Wed, 01 Jul 2026 22:35:11 -0700 (PDT)
Received: from [10.204.78.220] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dcd7esm801508b3a.11.2026.07.01.22.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 22:35:10 -0700 (PDT)
Message-ID: <01d8d8cb-3de0-4267-9a73-c06287393483@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 11:05:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: create duplicate sessions after all CB
 probing
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>
References: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h2ihDNlfUnB3R36mVcD8o53LCYqDl6Ed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA1NCBTYWx0ZWRfX+pCAefVrE8o5
 Om4E84GWd9ClP2RLqVLOUhZyx6N4e4jgTm6e7NTmG8yPFmWYvb6Pw9zh3f63L6kdca3+hhepASj
 wO1gqTmZrf5Z8+In1MlJ4jHkk78xDooJVG9QgXv7RkvfRXZ+72KKbg8dzbhWLHRDevKJqbEb3Tk
 tQVOf5k5wcI+jdL3ZGvj4lVr/sX0+CUuv/yjvqzvEanTfKy9CY1ERmnnhxVHAvzm+oAQN3nRMBw
 m+WVLpmJ5ID0N0s8Buo49AwB41ESdVHSiFiPiN0osd7tMsnjKE2vEWtM4RZNjI7IpIqybYWftBE
 eCGoQiv/tWTMzjd+UKjagT1aZgdBpWmKuXiHpIVKk5PRO5Ttzr6BmT5TFQgpzCm6NbUDV1SJqYb
 349F+qHIbmpVTct1a92CU+e4pVCWbkmpzrtRnsSXU3Dzbf0m09tsnDuAPl4cpemwIGdmYUluZTw
 83sIDKPZUJf7hE+fDGw==
X-Proofpoint-GUID: h2ihDNlfUnB3R36mVcD8o53LCYqDl6Ed
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA1NCBTYWx0ZWRfX3Xa1wohtZ9l7
 XUl36y7Pn0+xR7nVR9ftgJP5Yz3VWpxJNz803S3V7OSdSsghw4l3Ub69FEEo7Ma93Z8ARrhOHDW
 GxQEYz/Gaj2UpOdHHUjoo+WHeS/pHvk=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a45f891 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=9RQ4r9LfJCXKqqXW7GcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020054
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

On 09-06-2026 16:03, Vinayak Katoch wrote:
> For ADSP, only a limited number of FastRPC context banks (CBs) are
> available. Each CB supports a single session, which means only a few
> processes can run on ADSP simultaneously. If all sessions are consumed
> by fastrpc daemons, no session remains available when a user application
> starts, causing the application to fail.
> 
> To address this limitation, a Device Tree change was used till now:
>   qcom,nsessions = <5>;
> 
> However, feedback from the upstream community indicated that this change
> should not be made in the Device Tree. Instead, it was recommended to
> handle this as a driver-level change.
> 
> Instead of duplicating sessions inline during fastrpc_cb_probe() using
> the qcom,nsessions DT property, defer duplication until after
> of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
> all compute-CB child nodes have been probed and the session array is
> fully populated.
> 
> For the ADSP domain, append FASTRPC_DUP_SESSIONS (4) copies of the
> last probed session once of_platform_populate() succeeds. This keeps
> the per-CB probe path simple and ensures duplicates are always derived
> from a stable, fully-initialised session state.
> 
> The qcom,nsessions DT property is no longer consumed by the driver; the
> binding and DT sources are left unchanged.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..46afbae9c234 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -30,6 +30,7 @@
>  #define CDSP_DOMAIN_ID (3)
>  #define GDSP_DOMAIN_ID (4)
>  #define FASTRPC_MAX_SESSIONS	14
> +#define FASTRPC_DUP_SESSIONS	4
>  #define FASTRPC_MAX_VMIDS	16
>  #define FASTRPC_ALIGN		128
>  #define FASTRPC_MAX_FDLIST	16
> @@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
>  	struct device *dev = &pdev->dev;
> -	int i, sessions = 0;
>  	unsigned long flags;
>  	int rc;
>  	u32 dma_bits;
> @@ -2204,8 +2204,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	if (!cctx)
>  		return -EINVAL;
>  
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> -
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>  		dev_err(&pdev->dev, "too many sessions\n");
> @@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>  
> -	if (sessions > 0) {
> -		struct fastrpc_session_ctx *dup_sess;
> -
> -		for (i = 1; i < sessions; i++) {
> -			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
> -				break;
> -			dup_sess = &cctx->session[cctx->sesscount++];
> -			memcpy(dup_sess, sess, sizeof(*dup_sess));
> -		}
> -	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>  	if (rc) {
> @@ -2445,6 +2433,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;
>  
> +	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +		int i;
int i was already declared outside, avoid shadowing> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess = &data->session[data->sesscount - 1];
> +		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess = &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;
>  
>  err_deregister_fdev:
> 
> ---
> base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
> change-id: 20260609-dup-sessions-ea2acaac1994
> 
> Best regards,

