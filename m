Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695EE9D831
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 04:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F2910E1D0;
	Mon,  6 Apr 2026 04:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDX/karK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIcP9eIq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB69510E1D0
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 04:39:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635LqTm22570664
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 04:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ErGZ9VGt485klsK/g/5Yj2oyGp2dAuXoJriTQiswEyQ=; b=aDX/karKvYmPtB5E
 ZFzkJ4/tawXZhF55uWZwsPOFHXAirMRJk4eEple/+0j2HijDm9BCh2aithOdvobR
 zBqot8XcvpYSnhWCiNfRyMLbZpOK8r5NAuS3rkZ+iUDsOnA6EpQuKbz+EoIXrNLR
 p45gI5vvbbdKDPNW81FIL5SfBswQV8ELidtvugTxbDlPG4RbCA8zLtXfi/lFk9tl
 d+JgZX5/h4krD1m7uakjeutr6xSEn8xqMRDpuztTyvkMGFQvMyRcyzhqHarmT/w7
 r66Nwi3RujeDn8f7iOFL5UISgbIb7190ZbCUiWeoI6XOhDucZA7lQoPSRoaN3+wr
 G39PHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4darbfm1x8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 04:39:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35845fcf0f5so3838400a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 21:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775450346; x=1776055146;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErGZ9VGt485klsK/g/5Yj2oyGp2dAuXoJriTQiswEyQ=;
 b=dIcP9eIqKy7ViUqwh9hflcxYlLDe5LzlZbqaGBnsGyLfYGKAvgbVZuJJ/B20h4gF8g
 ZfwJXPYc089kxrGVkKC8rP2LxzNRRzc6azT/0PhZZstvy0u0qQn2KmqKZx9JkHkBztxX
 jXbApkhPFiRAMq313gnSGPSXlgiXqdRDCBrbLQLMttGpKlEsfV3aNAHl+jnuS656Ahjs
 dA7f8EqDouiTjUr+eUR83gOj3eiGygImVXJn7cFUzmUwBkF3JUfm3k3pBarTVhUiZrtu
 fhiz+/0j0m2D6Zi9tgAfGPMTZrC8en2AicmAVjkNu3DfSRF8qReAppabx7tBcLom9Otu
 Wv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775450346; x=1776055146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErGZ9VGt485klsK/g/5Yj2oyGp2dAuXoJriTQiswEyQ=;
 b=W+X9v/lHdqtEo1c0IqwSVkkVRkOApsZgpm+9eIJhcQFQnv4T+gFnG7ZBw/cFRcDGlC
 p/QTcrwVNm45rLcVK0ae0bGeseOV5rgqK4y0BLxbaEXfZUIGKj9e+jKTPNrHuYTsBF+Y
 ZHLx3AyPCvU6U7OU/nRkz7FUYvK32hUrdWaewm/10DBTjCESorON+u/umvTrVwmV28G5
 tPiK7ZVSJsQqQxMLhzGIRibdVVZLDfXLsoCezY01ct8hg0CjpB7HyPFv70aAgm6blOjC
 mYQt8JpzX/xEciw3pXYzO2o2F6F2egzkIpDIWcTzYG8zuvrkkf6fX0fVtj7UcFoUWvdb
 1SSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNdfSVfurQrr9lKpDPLMuzyJQXDMJHN4oVZtRfz7sluKXpTw6U22AavRXyHVtn88Rk0kErbELhrsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzboA4iXW4i5PLpaOCyPV83vQzBs7xS9XryTGaE6Gt8QZvMkRoe
 T7sqVMLs18fyX2LlUxu3l1QW1bk6EgWPx3bJIlM1D4MsP78BEb93U+4UWgLV5hEy0aZodbFp+VW
 ogvyJLkRYah5iujMp03PDtuV9Q7frosMDjmuq06kcX7Jv4URYuLAPD4f9XFhLufG8HVBQUS0=
X-Gm-Gg: AeBDietZVYVlaeWe8A4kd/a850T3E073932BVAdQjAonH7vZ/vcdcB8oV5rVLIK99oB
 6oZ9Z+K4VmzpcwRXLWwqGOhvwgzobuorHsImHtAxMXJET+/RzPuQXKvEki00fZ0hWpTc9wyNqQj
 Hr+pqTtCfQ8fC7N0kBQbxgeKuNVEQ6MVqBhT+UwZKn5G4TkIXomj2uTPdZl2++Wfd6pUOiqy/yq
 eXZGS0JiL+74n2IqHc6cBYLNpi78MhgUKGL8BhwBWdP1INSP3wQEwmOX4d+xVRyGwo6ui9umtXN
 kt1+uZi5i8WSQZDjKTL2VtxqRhCJ7hmEDLKFct5KXVE8XAEGwyYOFIF0DthKD+XPpTZxHH2WACV
 AAB++ql8fxMuFdub5TyWedOuUVbqVvVrIfrBNiWFP4vxQIMAmgI47duyw
X-Received: by 2002:a17:902:d2c6:b0:2b2:53f5:461f with SMTP id
 d9443c01a7336-2b277e566a8mr124146675ad.25.1775450346412; 
 Sun, 05 Apr 2026 21:39:06 -0700 (PDT)
X-Received: by 2002:a17:902:d2c6:b0:2b2:53f5:461f with SMTP id
 d9443c01a7336-2b277e566a8mr124146525ad.25.1775450345888; 
 Sun, 05 Apr 2026 21:39:05 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm162456115ad.28.2026.04.05.21.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 21:39:05 -0700 (PDT)
Message-ID: <818da0cf-06e8-4a26-955b-67a3d5392e91@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 10:08:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260403084135.1300931-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260403084135.1300931-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA0MSBTYWx0ZWRfXx/VhYd0neVMP
 T7nC1EiHo06D2IZrWVwia2VBoBcs6XJBvDDtvEVvuWQ8UXGEllyHm28W/ZD2Ix+pNHpBfnFK1Z5
 jAxKg1QqDLu01bILvBP2Z7DALYn5t2HB7FzQJNp5wHfzbV3x9YxiHG7Fv5TsuRmHN9xaIdyYdAQ
 Naaf5GzyJdAd/J8MN6IgJ0jU7C+lTj69S89LAshby5HGlqZDNxybmfDtlByQFHfNJroH8sazPnD
 gvNfZcvxYDqj9HzVhuL/EtZt3y5XCKrtZvqwkhdGq1NIniT8MY5rObJlS7jBjrv4HJH7dxipvca
 rltLmWMjob1qTGD0jw64YBqhFit8nOO6n604S9dkMK8PYk+WZufZf25rfAUPw0Jfdfdn+3PsTcx
 2Lzt6sy3hhk31ueBPgXavCRq6SyTT0mdkP849LvyfaEnj/c2PMse/dYXNpJk/PezgfjQHgRRzG3
 5nf8QKPKMhSkeschd6Q==
X-Proofpoint-ORIG-GUID: Im3oVyoeSk-9Bj-JlYQl8lfz3h4co9YJ
X-Proofpoint-GUID: Im3oVyoeSk-9Bj-JlYQl8lfz3h4co9YJ
X-Authority-Analysis: v=2.4 cv=I6Zohdgg c=1 sm=1 tr=0 ts=69d338eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=TIcjmxIkOcpZypuolxMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060041
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



On 4/3/2026 2:11 PM, Aniket Randive wrote:
> In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
> descriptor (TRE) on the TX channel when handling a single read message.
> This results in an unintended write phase being issued on the I2C bus,
> even though a read transaction does not require any TX data.
> 
> For a single-byte read, the correct hardware sequence consists of the
> CONFIG and GO commands followed by a single RX DMA TRE. Programming an
> additional TX DMA TRE is redundant, causes unnecessary DMA buffer
> mapping on the TX channel, and may lead to incorrect bus behavior.
> 
> Update the transfer logic to avoid programming a TX DMA TRE for single
> read messages in GPI mode.
> 
> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
> Changes in v3:
>    - Added comment in the driver for better readability and changed the
>      position of 'skip_dma' label to allow dma engine configuration.
> 
> Changes in v2:
>    - Updated the commit message.
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index a4acb78fafb6..78b92db7c7fd 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   {
>   	struct gpi_i2c_config *peripheral;
>   	unsigned int flags;
> -	void *dma_buf;
> -	dma_addr_t addr;
> +	void *dma_buf = NULL;
> +	dma_addr_t addr = 0;
>   	enum dma_data_direction map_dirn;
>   	enum dma_transfer_direction dma_dirn;
>   	struct dma_async_tx_descriptor *desc;
> @@ -639,6 +639,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
>   	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
>   
> +	/* Skip TX DMA map for I2C_WRITE operation to avoid unintended write cycle */
Seems you are missing writing important point - For read message ?
Important is to clarity what's the condition we are handling, Skipping 
something is anyway clear from goto skip_dma.
> +	if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
> +		peripheral->multi_msg = true;
> +		goto skip_dma;
> +	}
> +
>   	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
>   	if (!dma_buf) {
>   		ret = -ENOMEM;
> @@ -658,6 +664,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   		goto out;
>   	}
>   
> +skip_dma:
Better name - skip_tx_dma_map ?
>   	if (gi2c->is_tx_multi_desc_xfer) {
>   		flags = DMA_CTRL_ACK;
>   
> @@ -740,9 +747,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   	return 0;
>   
>   err_config:
> -	dma_unmap_single(gi2c->se.dev->parent, addr,
> -			 msgs[msg_idx].len, map_dirn);
> -	i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
> +	/* Avoid DMA unmap as the write operation skipped DMA mapping */
> +	if (dma_buf) {
> +		dma_unmap_single(gi2c->se.dev->parent, addr,
> +				 msgs[msg_idx].len, map_dirn);
> +		i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
> +	}
>   
>   out:
>   	gi2c->err = ret;

