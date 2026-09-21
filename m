Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A81C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D888610E5B9;
	Mon, 21 Sep 2026 09:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="emtK+myv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoMiGDxw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CB310E120
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:27:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L79uOj467171
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6y9zQn6vdVFp1pIjeU34Sa+AThYw+cYdoj6+lWv6DoI=; b=emtK+myv3usdP24s
 OllM6ZLLActmbGIWq2Dsd3DlQZsIk+9Zg4RY+DSIH1KzrEkwP0XtH1p2heGqZwlv
 hpc0RnbFu7RCi2ETWJIXuctcgK2Y9r1NcaK6fb4kUTiH5fGyFpBZEQeJdzgz7Uou
 sCI2F8YJlEVkRJwCU3vUrIZx52YSEZhasX+1wJc0lrLUpku7pDP6CmtETVcFeWac
 CPPIuKYW2Q8NlxkjUPZ35ukMIJLzOZEfcwfyrWotYX/6/ve7VXvENjXPXqkbMYvX
 RvgdTpNzG8kv2GO8wTM/Fn+2qFVYzv6Pf0mD0kfr1EvKeaqb4RsRoiv0GKZ/8/w/
 7ocMAg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b9x2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:27:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934a8cd3a8bso77463285a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789982857; x=1790587657;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6y9zQn6vdVFp1pIjeU34Sa+AThYw+cYdoj6+lWv6DoI=;
 b=VoMiGDxwTssWx0y0WmMkSv31raFod/D+YTr3YupKK1tfDeUJG7WI+xyCJCcRlzUl2A
 R5fMOTfNQH4bLq7M9Qkp/D31nd6GcCjUvl1RFU1/If4if0/tuOkjydpglyFRBxA9URCs
 ZcIbyS++2DCYUpGwqOfjCQrTEyuBrGBZF4b1hN2qj95hBN6+1D9EnqkO838RxcP9uz1b
 voJQdBvJU4KzhyyELOZexuf0O/aIdY33zpUO74wUccHb+wWobkGqJlczVkG9yQyBbcsX
 FJ9EqGNRa+3ZC+8WTIigigT+d91SPJzuUMkc4NC4anz7ZQos+CTKwphy8gMWoFH2Rb22
 JaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789982857; x=1790587657;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6y9zQn6vdVFp1pIjeU34Sa+AThYw+cYdoj6+lWv6DoI=;
 b=GKLPMMGeBDmUHNFXOM/KIp5Li4FzyIQJc/X0OCcjvBoy8erv7vhZRb56zUZKsf967q
 kFyThMjgAd+iTY422CIePBzjIqDkWxUOHwnhM77b2pAvg3cv3+lqEoimxsCghanB5Tj4
 3ykQ32b5+qytZVCmCewSMEKgX1JJ1jS22XKS3JZ6EigPVqb4fkWHdEeNdIy6D1EZg2cE
 IPNgnwn0dvD3MlXcXGXZT8nJsRign+iXWoAQws5rcNhElHT8DaVHQyCVhM+lJq7++Zcf
 gEcXPfJEwpynfE5zPrSsB6WWxeYd9/AYOEhOLGsnhcY2JOwY72sGQs1u0BPMcD5LWwhH
 uc8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuG77HhsEJqh5xfRQiIobkRY1jVQPEEi27ay8Rmf+zlsLV48R8F0t44ZueKJuG5XtckI1GqyWDLL8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAvnRNNVys0yl1xnRSNDbIz6ZWVBdlGBERB2NbQ0VLkmCOkviE
 R58zUgl7plhgGNZyPM9ujTGKbHv06Nxfmvz3nmmmnYmsz7ANToNjLJmhNSARk0y0PUl/kyMpR5Q
 WtDI7bXO9kELsEasnG6KGOvUOj22BK7egNlXJoTTMsLjlr9Vi0GZYi8pImvGyNw2apizsK1w=
X-Gm-Gg: AYBFou10eXKTx79AZGs2jnhN9lWLUBu07k14XQVdcAlYQt/6ExIRU4FpnxvWN6h0GQr
 XPDxY23dswuulO0cG2qqrreBPzV7WldNLiPkF3xNZNRHoTudko7bNOGKH7aWkB9lXyU6sc8c/a5
 Osj3PqHO2G6SMLTNOsTDw9A59nLuMRVbT6IR6ZJp68Pk4uxvB/PEthfciS1ZNycwGSvwfxbmQWo
 rOW4JBJJPyvMk4qyJckokUNHg/oUdLAASvzP9dphY4DeAXVh+SY+TEeCUHk7Vj4oAaey2VPcV5i
 R0Ab7JmAA93jesm3PVhxbSBSw4Gl0OTScWyX1WU+Jki/Osf94rl5zMJ6h6742FrHX25X1iTYBTT
 Wi+2Uqx7e6A4w7ENOOU1ixw==
X-Received: by 2002:a05:620a:470e:b0:939:c6ab:e3f3 with SMTP id
 af79cd13be357-93bf574e359mr981020185a.3.1789982857290; 
 Mon, 21 Sep 2026 02:27:37 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:939:c6ab:e3f3 with SMTP id
 af79cd13be357-93bf574e359mr981018285a.3.1789982856852; 
 Mon, 21 Sep 2026 02:27:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a3573ce12sm276656166b.35.2026.09.21.02.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:27:36 -0700 (PDT)
Message-ID: <989c8883-c481-4132-b6ca-3a333aa0788a@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] backlight: qcom-wled: Fix NULL pointer dereference
 in PM callbacks
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
 stable@vger.kernel.org
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNSBTYWx0ZWRfX0CxjvjqhBc+S
 WZBQGIfEGjB6bIDlBR9UZIpu1uRYigPmo1JMqWKcQ8S8Ba39OunnWO6kStp1miN5fAB9BDcpLex
 /trduVK5HSr3HSKCk9GqSBNBgIu9+BGvmwxc9R5yhnooRXMN/LefsMODb8Zbt+6AIY/cILUZ7kF
 L94tPt+439kGOThD88xCPFs9gmgNcARoSWpZ1Ek+cZWm3/2OdLbUMHUwcjmGWKqW0V+ndEeXmqj
 YTGt3wbxlHjFimpu5AWnmcP5ezAOMMAY/ZgVz464BGHjYQIBZXv7YvfW940oT2e44UPfRUwRigm
 xTz2wp+EsW1feCGZytIzZdRJ1XvumlZVw30lvE3N0wETor8tlrOK8JdmRyN9enSW6o0Ly1oU1+Z
 Xekwem/fRduHCA1NKMMhVgFggM3Xf9UrRYhJXYFqy/rlRfXywtRh5aMaA2VjQ9CWackesM4kVgi
 L1opZzPLbSWW9S9Q5Sg==
X-Proofpoint-GUID: thSSdOAwGmVgcLN0-watbiALAOZl68ar
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0f889 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=WGO8Zn8UdcYOddqErpsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: thSSdOAwGmVgcLN0-watbiALAOZl68ar
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNSBTYWx0ZWRfX0hYXpTOjN6lV
 fwwQ87nllpFJMCORtD6Hc/dnvQt2HMaBvcijj4sXY9PuX8+kR0IXPA/kIPgpKNAwm1pXor+DN6X
 cr4mMkhJgm2lBR0srxxuCpDuLw8IAkg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210135
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

On 9/14/26 8:14 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> wled_probe() doesn't set the driver data for the platform device.
> As a result, dev_get_drvdata() in wled_remove() will return NULL,
> leading to a NULL pointer dereference afterward.
> 
> Set the platform device driver data in wled_probe().
> 
> Cc: stable@vger.kernel.org
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 650dd95f06ef5..a76158a298335 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1747,16 +1747,17 @@ static int wled_probe(struct platform_device *pdev)
>  
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type = BACKLIGHT_RAW;
>  	props.brightness = val;
>  	props.max_brightness = wled->max_brightness;
>  	bl = devm_backlight_device_register(&pdev->dev, wled->name,
>  					    &pdev->dev, wled,
>  					    &wled_ops, &props);
> +	platform_set_drvdata(pdev, bl);

This does make the pointer non-null, but it stores the wrong object

Konrad

>  	return PTR_ERR_OR_ZERO(bl);
>  };
>  
>  static void wled_remove(struct platform_device *pdev)
>  {
>  	struct wled *wled = platform_get_drvdata(pdev);
>  
>  	mutex_destroy(&wled->lock);
> 
