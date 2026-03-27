Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B188010F284A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165D510EF14;
	Fri, 27 Mar 2026 16:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhaMoWgP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hx7Fow/f";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6211310EF14
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:17:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RF2LFT3631417
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h0uSEuoFInxVgrwB79dUUBt3ZPYXBustTfB6r5GqV4g=; b=EhaMoWgPsnhiqVsV
 Nd8oSZSoky4XsXx2YeRGcDZypaTTiinDsVBfXcuUhTn+zWujbfYDyryYb59/V2d1
 msvX6uzquKSoiKUM6grtzA/ptTlc9QLxhXJUBgbQFXAZl+Hgq5FXas41nEa6lB+d
 lD+j6uv00oS23F8x8E0uMeOCmZvewQfWQU2jXuJVmJvyulrZizOiXQw0zNZfS8Qe
 yEN1tmzAX85sBFUvmZRnNbmaEMHX8sLZ+4tGUnrrfBblFaxF2/Tm+f2Okt4JmeT5
 0gZr9PcmbNctyCJw5myhyQTEG0GlDvQFS5M4UmsbLcQjUtUNcvREvA7QOfQbPSvU
 N/dLig==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5v6b093w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:17:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-126e8ee6227so2363951c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774628222; x=1775233022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h0uSEuoFInxVgrwB79dUUBt3ZPYXBustTfB6r5GqV4g=;
 b=hx7Fow/f9An0EGQcfAKi1cTSf7o7DdiiQJN2FdNo1R9a702RqgUob0PW1dkrKQEqnm
 c4gn35ZYEZWn64hIR4nzC+9aJ/yMmgBVHiLF7mt7whPK69ZuoFlCpVabGXaNDGOd0w+/
 3YFgVHNYLESsuyhte7EulYdGSp03WGOFxBV2SsGa7FiG84W7Q7inlg/QwFZS2zwEMB7g
 fG7D0zLEIowchVg/iK5/QqKtvZD2uhC5ENVyShfGRG2+eukTg+8CtbAPddlmbiz7cJNm
 +FzjH6N7kQEXIF2mWrnwysmEQSmzxZfzihQkMXAShsqpOH+W91uy8oQ2tppcybMK3wOc
 z+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774628222; x=1775233022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h0uSEuoFInxVgrwB79dUUBt3ZPYXBustTfB6r5GqV4g=;
 b=pgLJiLB/iGJhOv2i3vEMXVW7UJP42BQkkJijA/WWO87jlWmMFO8Mp1yADbo/sc3vts
 37JfJP9y018IJdqF0rzst5+rne4qfKmwn0mtzs2Lsv5uF0Dao7IBdoj8y8LOdNicm5vL
 WUkq0mCyvSJyAM9YiwNxWotxPavYXBO2l2aE6i8sPMFhWXZJzEEnrSnBro778j+ubSEP
 8qptd00g8gp/2m8jF+v+t4ctu7kwhMa7ifY3TFZ12h1ImtF7VPASWRvXGIBIJyshQ6PL
 RP+rKR7p+qxZhLe35i8/+mQ638i4kQ98Pyf658DYomCCI5JHON6GPKRL0v2ez/hVD32h
 WqJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi0pRRHsDoEywbk2KPGT3lISTdI2ndrxHRxTbh2DjqITx6R/udh6LcDV/4O5QSsObegPHyLhLLN98=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+bne10lYSwGr/1wEXeq23oMJ4vlfek3RUiDXnx0rBR0LOhN9H
 5lpgmDY+JI88Xe9EQLjLbapu70lMhBT5tUdvmxPGjXVbfc5e0aCN9hCdhIQ/AJM8CFiXkDSLAKZ
 ZoXPJCBPM6+jzv7RhLCbROBylSvy9x+1zhlzdt5MDP1JGNZyrqCIdzrrFbYj+22ov8ssd0Gs=
X-Gm-Gg: ATEYQzxctxIRalPdvGb8zAntVTcT/qGvF1/Jrx7k5UlVDSCBwL/snWKAfHwt1UlNitP
 avNo79gY5xfCMvJfTUKpZ7PaQbHvD3K8ov0G5XuVFAWAslSfhYc3IKb6gOcYjDL/Z3qV1OMxvIL
 FP1CXWHDO69YBYg1e7oeC5rHFWLOaKJmd8ceTMh9tBVrQbE+Na1hjUaODngoICZ9CYfpsmn44mA
 2DPUYcgHqSn6Kb4ZBaArU+crGXRs/WVeJn7UKKLqyz8CCzI0VGUKRh5+xpOmzZ0/rot4PUswlVt
 4Tl1aWxgJGDCpk1RJG1CvplZl2vdoYmD2HYDbHYew2KmEMp6BhzPBghRtz2DeYb54ojk+V8jZ4G
 oxDYamuqLUL5CI2xA1EcTTQQunOe7eRaSqsThCFJ2vB8cvi03oudCH9XwZF8VjSh2wT7jmjZNVd
 g=
X-Received: by 2002:a05:7022:618a:b0:12a:6b99:1ad4 with SMTP id
 a92af1059eb24-12ab286cf5amr1634009c88.11.1774628222063; 
 Fri, 27 Mar 2026 09:17:02 -0700 (PDT)
X-Received: by 2002:a05:7022:618a:b0:12a:6b99:1ad4 with SMTP id
 a92af1059eb24-12ab286cf5amr1633983c88.11.1774628221305; 
 Fri, 27 Mar 2026 09:17:01 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm8135794c88.11.2026.03.27.09.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 09:17:00 -0700 (PDT)
Message-ID: <5abe5ee7-f054-4e32-ad9a-c9b8f10bc423@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:16:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER" <linux-arm-msm@vger.kernel.org>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260317003034.71618-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260317003034.71618-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f1QMcXTOvE5MB1LevcYgEfE9NQjAyjL2
X-Proofpoint-ORIG-GUID: f1QMcXTOvE5MB1LevcYgEfE9NQjAyjL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNiBTYWx0ZWRfXzN2mpxxnLU9g
 +A2Ne+BEujDxdXXerzKDdOkx65NyhQp+U3+wYrGx6Zjf5QyDX8Q8e0oLl90/gZSq2+40lf8xbSM
 5ki5vq6GERJmVywjKWOLTFSX2tsnS0iIJDe0lc/eE0VNqqoPPhsGLx9cSMRtWHX5z9Ga/SKzWF1
 oyeYEYB8yUom12GxYfmEQl3qQ3MvFl1K/KOLZ4/fz4VoyukpSAoW7ICgdyTQpH7QIatCYg/FwoS
 ONKxBJ9ZeKdKR/ytQzyEndHVgWLynR/rPKuNskmu9oukqZd6K9ms7xFziej6f/C3ozi8U688uPF
 BH2CIo8vHPQVJ+6NJQGMmOcwzjca6vNkv2E6Hx40e+YdRkrCaETV63w4/4y1AULgg8m6RUU8sZs
 MN/nMQ0xcs9IJZoVg55OYHedK+GLEWkOIPZBv3N452FCPn93SHTNrA7SNyiRglC3OLtDMrprshj
 nxYtQIuH/C6zEgEuktw==
X-Authority-Analysis: v=2.4 cv=JLs2csKb c=1 sm=1 tr=0 ts=69c6ad7e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=H-3xqeJHN62Qb4ZhkN4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270106
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

On 3/16/2026 6:30 PM, Rosen Penev wrote:
> Combine allocations by using a flexible array member.
> 
> Use __counted_by for extra runtime analysis. Move counting variable
> assignment as required by __counted_by.

This fails to answer "why".  This change is not justified in the commit 
text here.  Please see "Describe your changes" in submitting-patches.

Also would be helpful for you to mention how this was tested (although 
those details don't need to be in the commit text itself).  You are 
touching arguably the core structure of the driver and any mistakes will 
be devastating.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/accel/qaic/qaic.h     | 4 ++--
>   drivers/accel/qaic/qaic_drv.c | 7 ++-----
>   2 files changed, 4 insertions(+), 7 deletions(-)
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
> index 63fb8c7b4abc..ab428ecd26f5 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -405,15 +405,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>   	struct drm_device *drm;
>   	int i, ret;
>   
> -	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
> +	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, 16), GFP_KERNEL);

I dislike the structure of this change.  16 is now in multiple places, 
and when it will change in the near future, its going to be harder to 
get the update right.  The existing code specifically assigns the value 
and uses the value from that assignment for that reason.

>   	if (!qdev)
>   		return NULL;
>   
> -	qdev->dev_state = QAIC_OFFLINE;
>   	qdev->num_dbc = 16;
> -	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
> -	if (!qdev->dbc)
> -		return NULL;
> +	qdev->dev_state = QAIC_OFFLINE;
>   
>   	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
>   	if (IS_ERR(qddev))

