Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D6DCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B00610E1DD;
	Thu, 15 Oct 2026 12:42:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B54C10E1DD
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:42:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jipS2417235
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KgCkbIqj+Xltp5HS/aMjiyIa
 do5whRz2Y+pFV9bEePY=; b=R25y7EuuLXCZtzDPvFdgieK2SbIvfbN1jRnQW+Qg
 Fl/7uNZi5zwoZ+YKQLCsVdTrDJsRk17T3DAN2EwcwCUKO/LlT8TQqVhK9UDPK0U2
 TJ3d3+MRlCI/G8R7oYHaGKlRVl0MOyBheA1VVxEi/SP6hqGYhweHPCrFvwREJwTp
 2dmXH0GtBhjZoAbTmWS6AXpvfkcckuC/C0JSfK+kM2OsVtXaoTG5oAOfbKngdpF5
 glNu6K8EZSka/gEgk8RWDFzCZXU3bLT3j+Y0bhiJlKXH/u2WG9s5Iajflm0fiAQZ
 joM1dWehim2el4uVZ9WnKB1NayqHPCRZkzRaKslfkNM3RQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhj3sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:42:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9106fce784dso130864486d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792068163; x=1792672963;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KgCkbIqj+Xltp5HS/aMjiyIado5whRz2Y+pFV9bEePY=;
 b=kSTnVgFcBbvEhofnGs3Z0lyjqfmdBPmacJdQLcqr7EyTO89VwPLKEzVDipMVWabZnM
 epsdIeyNfhtBepkRqsY0Bsw//8bNFLeTUJCHh6BtnW6FyORdXCnyZ4DW7HvBg9xOrdLP
 rOV7TSYHWNnZdFc8DJuz2M8W+GgXsRxgorSQDihnLBS/WPTvUyZrZgZY1b2F02D+tHrK
 d+4h/qm4AdhZKHMUYGba8GQFMHcMvKyt6432VmuVvGLHqQiHH/u2dOJSav9lkAEAA9OR
 9Kvb94owULXRNOwOPxc79fIcOf5aioHxi/3/ksJE/FcAU3iyMi/xu5mJFjDSiXC90lLh
 vIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792068163; x=1792672963;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KgCkbIqj+Xltp5HS/aMjiyIado5whRz2Y+pFV9bEePY=;
 b=PW3wN/IzFnJPxQPBOVxEXSrw8nfHXaZdTxYKKDGKV4Vsi/A03W7i2qUiI3X9SFTzt5
 dePOr+KfjWcVnbguu6U66qq4UfpI6hAWCLFBHmRbP2U8RySxt2/H+CHSfdziwt3fSUM2
 cQPygDqfFnMPiYNxL6FhrbUkZP+jGG96vyrCKodt1E697w0jTRqICkVE8nZfcJtjLT9E
 erhQkBTf2NpUbuHnTtiB9gxFxaM8S60p2e9B0k9uN8cYkBuUGH6iHch6yftNRTMqxr5o
 bv83NbgizkI5ojvQEsG3bQts4Aj8tyNiESpYwWOSMN6HgzoXZVnzv+N0M/c+iF5DheKB
 HsxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxefG00lWfFM6GtAlEytRXoCmj3bnRjUMLjooRlEchqA2hYYzZwoaj3/iA32ks/gwO4u6WQpYDx7Jo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLkE5ABayV7qg3pYSVnbCQ2CuKxqWe9zHwPlWI8pO5D9O4ZpC3x
 7uPYzFrBzCW/FsDULPDjBqmEMPvPGDUO/aVKZBLrCah2XLotDGr1RxeV1u+QExmcLui+c+pZXO5
 Ms1rsUYcgzVyV1p8vb8scyYU6rom6lQnThK3YI2QNzg7eLIBcDdZx1zFoCuI+ZwWcNRt/1S8=
X-Gm-Gg: AYBFou1hV/z4RnekLDnrfuUbuy0ciwcB30nZQdMZx0kxOxtlz0kaWKIH9BNeQuLR1X5
 BmYefDnldgHAIXRzSQ4u7+Pl+Z1GOU+4dWlaM9QC1cz3iznrtKOgIzneWlHFhleo450ph0eE2qX
 qiu3klDIMv9VMU1KiAITzxYxJSEkxrWCMt4UNVUCy5PlbQqHcpt05VP483fr7H+UvTp/O8dis+c
 5TC4NJjswV2/Eo5buA8mEC3V9hPwBV/L/YzOTgOzoKYL7iR0jgE+9SN8yBPpN5PCCmbInQEibjv
 jY5tijpdX7a0Ut5gqFue1gRgoI27ytU2Y7XZ7PqvWx3rNdZKDRtanCOhT2rPyLcUWz8ue9Q6eSq
 01pazG5iSSduM/7jBRB/IOlrbDmP6UDYFyZuE6mJycuUpghl9OdBkJau9tyvq4jX07+WhjsZt23
 QzS6FQHpBa8Xgy
X-Received: by 2002:a05:620a:4407:b0:93e:942f:b8b1 with SMTP id
 af79cd13be357-93ebd292a3fmr3061151385a.64.1792068163100; 
 Thu, 15 Oct 2026 05:42:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4407:b0:93e:942f:b8b1 with SMTP id
 af79cd13be357-93ebd292a3fmr3061145985a.64.1792068162454; 
 Thu, 15 Oct 2026 05:42:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdf4e5ebsm6660281fa.40.2026.10.15.05.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 05:42:41 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:42:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 04/13] drm/msm/dcp: Add IPCC power notification
Message-ID: <u7pcn75yh435vuuwqezml37bqfzdztvrywggbmkydkilwe5yzp@myijo4wd2bob>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-4-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-4-48aad0fe4f72@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfX+iSZXBzQ+Ruz
 S/xSTNdp/YusljEo3LeC+gtGK9C+KQNmygWkJE/k0WGmY+y9t9i7P26InZp19RfBCN3bXgNoKKn
 r5LHUlICnkcjfAQQS7CthBQyPT6e+uOoaAyYUz6oMA/Niyyn1tyZSL0zJcyftPhwudvF8ftHndA
 +3btiY7hh8RqR+ZsjV2PwVPXTjmi/35W0JHXMDYJdoPu5PibOj9cXks8r5AbDNtns/RXpZI4kxv
 qsvSUnas1JEnXnu0d6aGybfPcJCEeU2OfLnrRSwcZso5htcgx6R0iqTndYXKxZVDsNzTRTaRk0G
 ZPFAnynKdog81UGF53RBq3qFai1Zkh0JWilU9ijzSOhVc2C0I60WSTfSAYWFrn/S5e91xGfJmjx
 j0gfCrhQtOp5R6AD86rhaoi+Xyz/WZ3y91tPVJ4yC8LlHlYwsloT68bvb/ijRX6kJi91gLu79Rk
 +Hh/GZEH2xG+gyM85sQ==
X-Proofpoint-GUID: vGodZRb2OhETFBbv3jHlhVlvoqRrL0jy
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0ca44 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=CLenjPMy3891WX9YFLIA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfX63IEA0hRN0jY
 N4R6zYL6RtNxr6aSAxt3wflW7LMX/sKrPIneoaAuXkmVJKhVYJJVIwuA+qd4gWMlEg8OXwO/Uq2
 hVv8S8Scp7K1afHVR+n/BlCzgZ5wXp0=
X-Proofpoint-ORIG-GUID: vGodZRb2OhETFBbv3jHlhVlvoqRrL0jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150050
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

On Thu, Oct 15, 2026 at 01:08:24PM +0530, Jayant Shekhar wrote:
> DCP may be power-collapsed while the VirtIO transport remains available.
> The host therefore needs the platform IPCC channel to wake the firmware and
> to receive notification that it can service HFI queues.

Is it allowed per the VirtIO spec?

> 
> Add the IPCC mailbox client and power-notify interrupt handling. Wake DCP
> before VirtIO queue activity, wait for the firmware acknowledgment, and
> notify the response queue when the IPCC receive path completes.

Don't describe patch contents. Describe your design decisions. The
reasons for the flags, init/deinit functions, etc.

> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile       |   1 +
>  drivers/gpu/drm/msm/dcp/dcp_drv.h  |   1 +
>  drivers/gpu/drm/msm/dcp/dcp_ipcc.c | 212 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_ipcc.h |  56 ++++++++++
>  4 files changed, 270 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index bdc34babfc21..4195bc0e1fc9 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -71,6 +71,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
>  
>  msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_core.o \
> +	dcp/dcp_ipcc.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> index bf6c34af43a0..af2db3cf9066 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> @@ -13,6 +13,7 @@
>  #include <linux/virtio.h>
>  
>  #include "dcp_hfi.h"
> +#include "dcp_ipcc.h"
>  
>  struct dcp_dpu_kms;
>  
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.c b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
> new file mode 100644
> index 000000000000..e60a3ecbe3d8
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP IPCC power-notify mailbox client.
> + *
> + * The APSS-to-DCP channel must be signaled before a VirtIO queue kick.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/jiffies.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/of_irq.h>
> +#include <linux/string.h>
> +#include <linux/virtio.h>
> +
> +#include "dcp_ipcc.h"
> +
> +#define DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS	10000
> +
> +static void dcp_ipcc_handle_rx(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (ipcc->shutting_down) {
> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +		return;
> +	}
> +
> +	if (atomic_xchg(&ipcc->power_notify_pending, 0))
> +		complete(&ipcc->power_notify_done);

Can there be more than one power notification pending? Can't we just
call complete() here?

> +
> +	if (ipcc->resp_vq && virtqueue_kick_prepare(ipcc->resp_vq))
> +		virtqueue_notify(ipcc->resp_vq);
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}
> +
> +static irqreturn_t dcp_ipcc_power_notify_irq(int irq, void *data)
> +{
> +	struct dcp_ipcc *ipcc = data;
> +
> +	dcp_ipcc_handle_rx(ipcc);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void dcp_ipcc_rx_callback(struct mbox_client *cl, void *data)
> +{
> +	struct dcp_ipcc *ipcc = container_of(cl, struct dcp_ipcc, client);
> +
> +	dcp_ipcc_handle_rx(ipcc);
> +}
> +
> +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev)
> +{
> +	int irq, ret;
> +
> +	if (!ipcc || !dev)
> +		return -EINVAL;
> +
> +	memset(ipcc, 0, sizeof(*ipcc));
> +	init_completion(&ipcc->power_notify_done);
> +	mutex_init(&ipcc->power_notify_lock);
> +	spin_lock_init(&ipcc->state_lock);
> +	atomic_set(&ipcc->power_notify_pending, 0);
> +
> +	ipcc->client.dev          = dev;
> +	ipcc->client.tx_block     = false;
> +	ipcc->client.tx_tout      = 0;
> +	ipcc->client.knows_txdone = true;
> +	ipcc->client.rx_callback  = dcp_ipcc_rx_callback;
> +
> +	ipcc->power_chan = mbox_request_channel_byname(&ipcc->client,
> +						       "dcp-power-tx");
> +	if (IS_ERR(ipcc->power_chan)) {
> +		ret = PTR_ERR(ipcc->power_chan);
> +		ipcc->power_chan = NULL;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "IPCC: failed to get 'dcp-power-tx': %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq = of_irq_get_byname(dev->of_node, "dcp_power_notify_irq");
> +	if (irq <= 0) {
> +		ret = irq ? irq : -EINVAL;
> +		ret = dev_err_probe(dev, ret,
> +				    "failed to get required power notify IRQ\n");
> +		goto err_free_channel;
> +	}
> +
> +	ret = request_irq(irq, dcp_ipcc_power_notify_irq,
> +			  0, "dcp-power-notify", ipcc);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret,
> +				    "failed to request power notify IRQ %d\n", irq);
> +		goto err_free_channel;
> +	}
> +	ipcc->power_notify_irq = irq;
> +
> +	ret = enable_irq_wake(irq);

This is typically called from the suspend callback. Why are you calling
it in init path?

> +	if (ret) {
> +		dev_err(dev, "failed to enable power notify IRQ wake: %d\n", ret);
> +		goto err_free_irq;
> +	}
> +	ipcc->power_notify_irq_wake = true;
> +
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(irq, ipcc);
> +	ipcc->power_notify_irq = 0;
> +err_free_channel:
> +	mbox_free_channel(ipcc->power_chan);
> +	ipcc->power_chan = NULL;
> +	return ret;
> +}
> +
> +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq)
> +{
> +	unsigned long flags;
> +
> +	if (!ipcc)
> +		return;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (!ipcc->shutting_down)
> +		ipcc->resp_vq = resp_vq;
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}
> +
> +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc)
> +{
> +	struct mbox_chan *power_chan;
> +	int irq;
> +	bool irq_wake;
> +	unsigned long flags;
> +
> +	if (!ipcc)
> +		return;

Oh, you again ignored the feedback. Can ipcc be NULL here? What would
that mean?

> +
> +	mutex_lock(&ipcc->power_notify_lock);
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	ipcc->shutting_down = true;
> +	ipcc->resp_vq = NULL;
> +	irq = ipcc->power_notify_irq;
> +	ipcc->power_notify_irq = 0;
> +	irq_wake = ipcc->power_notify_irq_wake;
> +	ipcc->power_notify_irq_wake = false;
> +	power_chan = ipcc->power_chan;
> +	ipcc->power_chan = NULL;
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);

Ugh. No.

> +
> +	if (irq > 0) {

Can it be 0 here?

> +		disable_irq(irq);

What for?

> +		if (irq_wake)
> +			disable_irq_wake(irq);

It is enabled at this point. Drop the useless flags.

> +		free_irq(irq, ipcc);

We have devm_foo() functions to simplify the teardown. Can we use them
here?

> +	}
> +	if (power_chan)
> +		mbox_free_channel(power_chan);
> +	mutex_unlock(&ipcc->power_notify_lock);
> +}
> +
> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags, timeout;
> +	int ret;
> +
> +	if (!ipcc)
> +		return -ENODEV;
> +
> +	/* Wait for the doorbell acknowledgment before returning to VirtIO. */
> +	mutex_lock(&ipcc->power_notify_lock);
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (ipcc->shutting_down || !ipcc->power_chan) {
> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +
> +	reinit_completion(&ipcc->power_notify_done);
> +	atomic_set(&ipcc->power_notify_pending, 1);
> +
> +	ret = mbox_send_message(ipcc->power_chan, NULL);
> +	mbox_client_txdone(ipcc->power_chan, ret);
> +	if (ret < 0) {
> +		atomic_set(&ipcc->power_notify_pending, 0);
> +		dev_err(ipcc->client.dev,
> +			"IPCC TX: power notify failed: %d\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	timeout = wait_for_completion_timeout(&ipcc->power_notify_done,
> +					      msecs_to_jiffies(DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS));
> +	atomic_set(&ipcc->power_notify_pending, 0);
> +	if (!timeout) {
> +		dev_err(ipcc->client.dev,
> +			"IPCC power notify acknowledgment timed out\n");
> +		ret = -ETIMEDOUT;
> +	} else {
> +		ret = 0;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&ipcc->power_notify_lock);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.h b/drivers/gpu/drm/msm/dcp/dcp_ipcc.h
> new file mode 100644
> index 000000000000..a3430e5cbe72
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * IPCC power-notify mailbox interface for DCP firmware.
> + *
> + * Channel 5 carries APSS-to-DCP wake notifications; responses arrive through
> + * the mailbox client's RX callback.
> + */
> +
> +#ifndef __DCP_IPCC_H__
> +#define __DCP_IPCC_H__
> +
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +
> +struct device;
> +struct virtqueue;
> +
> +/**
> + * struct dcp_ipcc - DCP IPCC power-notification state
> + * @client: Mailbox client used for APSS-to-DCP notifications.
> + * @power_chan: Mailbox channel carrying power notifications.
> + * @resp_vq: VirtIO response queue notified by the IPCC receive path.
> + * @power_notify_done: Completion for the firmware acknowledgment.
> + * @power_notify_lock: Serializes power notifications and teardown.
> + * @power_notify_pending: Indicates an outstanding acknowledgment.
> + * @state_lock: Protects shutdown state and response queue access.
> + * @shutting_down: Prevents callbacks from accessing teardown state.

What is going to access it during teardown? Can we shutdown in a logical
way, so that there are no accessors after starting the teardown?

> + * @power_notify_irq_wake: Whether IRQ wake was enabled.
> + * @power_notify_irq: Power-notify acknowledgment IRQ number.
> + */
> +struct dcp_ipcc {
> +	struct mbox_client client;
> +	struct mbox_chan *power_chan;
> +	struct virtqueue *resp_vq;
> +	struct completion power_notify_done;
> +	/* Serializes power notifications and teardown. */
> +	struct mutex power_notify_lock;
> +	atomic_t power_notify_pending;
> +	/* Protects shutdown state and response queue access. */
> +	spinlock_t state_lock;
> +	bool shutting_down;
> +	bool power_notify_irq_wake;
> +	int power_notify_irq;
> +};
> +
> +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev);
> +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq);
> +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc);
> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc);
> +
> +#endif /* __DCP_IPCC_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
