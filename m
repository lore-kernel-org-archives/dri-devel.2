Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF6BFA1FE5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC80B10E2D0;
	Wed, 22 Apr 2026 18:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJfFq0zd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAecHZgu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483D310E2D0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:52:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG3gQR1230202
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Wotz04H8l5tgEEsb1NU3qjTk
 74Z9j+pDdwYuMESGV4w=; b=jJfFq0zdZy9ICHfrkQe/sXmomxTWDzPHZ4u4KnUZ
 3oh4PgAAn3MQFDjtXs3g5lFj/raVAAfcKw9RZhObgTW539TD4NAAngbB3beQm3Q/
 zgJgVQo5cEwac491XG+iYAqlyJMzRWIeb05E5x5IbXu8iV0X9XjHcTp+3E7fQFm7
 ch2yT5FSKeRX2f7JqARtAWA4Y/wfHzdhWk/s4ZIZlj9Rq/QfskVgCjWR71qFRQc9
 kWeh8gNpPKmx06CEmNOLKye+MAD4037Swbj6XggBcfGhAkk2xJEKzfpKg22/PuLJ
 +smX/Ebe9BOuvNuXKAgvqOCzYFwCHMUiAwmbSqEbWWRY4Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h68kcq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:52:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb007bc36so72761811cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776883943; x=1777488743;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wotz04H8l5tgEEsb1NU3qjTk74Z9j+pDdwYuMESGV4w=;
 b=XAecHZgujGVCC2lsMxDtzHG499FhylORAxIs8JDwHZoQkOJ0FnkLFzYQRcfveVWAde
 zTePZdBtRy9iErGhqn1uQE1PRDDVCLZUQDc1acr6Rhu3yGyFUUK4SuYPxxW3vaHpH1D4
 1ZuzbJIJx9Xmcea9BIN8a+PBULP61gunYnXwe8KrxiDJ6+FySoz3YvUbHp+sqe5lSk0v
 nd1gXa8wm3nW003Z72J9A0EtTb7cPmO8p0KdyemB5HeHglFs5IjNDuB1AeoaaCh29XO7
 PQtdFo9dA8R7vhWaQtUZNUgc3pfYgf2Rgwee6hGmBfnysFln1+LQuAF3+6eRglaKSeyX
 xPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776883943; x=1777488743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wotz04H8l5tgEEsb1NU3qjTk74Z9j+pDdwYuMESGV4w=;
 b=YQIa9/1ccirnJ7BX7nUS3a1cnBvrYmS5vVeROAa07WTY5tcdwoQiRtAt6G7PmQYzSq
 0FDnWZ2QUjxa24LZOMMjj9LBO3FUMsYXqZPWiXCF2ik/srsEJ5IvwRIN2R6iADt3ySSi
 6I6uYf+esreHXtjhnaovgGF2mCmACesO8ZRmhsPw48xEWlTcEZmK2k+NG24F67CFF76y
 uTdT1ty7uFGa469xneCbxJAxMA799yDPpsEiwUi5K0Rs/gqedRvfwSP7Dsr1fs+d0Ihi
 FqYPi7TEbniBlkXY/9csZNG29hBTC6TOGj13imhM+HoOmH5ppjn3nRxjdMmhl1yc9uXk
 rrxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8I18K3oropKQ0yKrAn84c3YdwmJNi0B3j9M6zAXJLRC6HJ616iPNtWuQGre+/0TQL/vDs2Jrhz2o0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkxxX0BzeA5wuTa85StvwXr0uS+gMypkqPc1XDR11tuIpGewqS
 /fLNN7P8dKBfcQhr2FkQ5wqkurCredtDKCmVwEqDEREm1j6+BZoXrkkLHaxB94QzJWFcnfAZ1GZ
 3W4TitFkL/1BgP+EF6cLO4g9e30oJbTi6LWDrDO9LU5X+Utaf0eV7NStNd9YB4qMbSIvB8+g=
X-Gm-Gg: AeBDieucGvSsoN4GlnmLDTRli99QcNyJOPmqbSabWn9GoZfRylkZb+CjO3O9gAf/aEZ
 n4xkyNVJk1BYecWo9bB5KKgFGSCQy4sNgCv68tShABOy1ErQf3Y7h98vgbwcGAPx8rfOasRP0Ag
 f95C4h/3fITK5EETbs6cXVNYx9X71ivQimHKMtX6HVuHJDroyhhgWds5ZjnH0iyzgmfCFd+tMdl
 4hmiN1Lmqk2Tw+Pq50GeAI3uqt3X5UQ8Fi3n7sQuWZi8Af/Nqwpfaf+Tx8AVRp+5du4xwz15a28
 GCQlhNX3pI8eakQKcSYNvAoUYW6XwZJU3Q2DN3YLWyrZFiqv2O3RXbF1Bvgrl96yJWWeuqR/3lX
 SfR+4XP9XV3NO7/yfRJFD0LMM+bcxvuURPKZ1pZkPAPzngl4tk++ZTkdSTmb7V5JgV4Su03H1zv
 ncmPIoP/ovprjSuVwUXChOH7po207qzNQF+yTkKAcvVOXRrA==
X-Received: by 2002:ac8:5749:0:b0:50f:c36a:3828 with SMTP id
 d75a77b69052e-50fc36a3c77mr44950761cf.58.1776883942681; 
 Wed, 22 Apr 2026 11:52:22 -0700 (PDT)
X-Received: by 2002:ac8:5749:0:b0:50f:c36a:3828 with SMTP id
 d75a77b69052e-50fc36a3c77mr44950111cf.58.1776883942194; 
 Wed, 22 Apr 2026 11:52:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7dfesm4584470e87.71.2026.04.22.11.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:52:21 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:52:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
Message-ID: <cdhqirgdwr6mfwqlhyq7apem4tfuu45adejqg5hse5bvte3vqe@i4uoqa5rpfv2>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
 <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
 <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
 <077a99c2-c954-c5e6-3699-cd0360e8b9f6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077a99c2-c954-c5e6-3699-cd0360e8b9f6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e918e7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Dnkel8P2kxSv_apQI-kA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MyBTYWx0ZWRfX4RXLQsDIRE8y
 UUPxxuHfpufpDilrkAecFxADf8APGqGs/X3PUu4EVEZmxINMKufxp4JuMPtbE6sKjFU4GC/3qJS
 FDSOAcRwtGFPt/YmukGV4tDbKtQ746gxFQU0281k3ARtmpnjA4rD5SzWCSYpQcrXv8IU8NSDJJJ
 1zcqsVQiXH7KbLKhbY/OPlD6S29Q4syFnYNDaR2vit16Rfy/BtugK8SxNFEwxcM7X8kG76rcCXs
 gflya7HlxLqIcbmUOH0cQd/4fjO8xPoxdpz6sOcdVDdPak2cieRhR8pWIjrUVIo7Mp2TxqMZszO
 +ePYJeUbBfkK+7bwFW14lWuDDSvmfc0wPh0yF3kgm2+6polQGWe4U9kS6yMCHal29QzXQlgFRZ4
 qRH/hrLAZ6Ao3UN9WwM7zTu+Ayc4WAn0wMmfV9FUUdhSvFj7blBgcXSf/OuIN4QYq5IGvNmdLZ1
 KTGV8emKYWJZCWW5zuA==
X-Proofpoint-GUID: U1SXGod5mR58PZZ-jiSYVCLYKoEq43ZE
X-Proofpoint-ORIG-GUID: U1SXGod5mR58PZZ-jiSYVCLYKoEq43ZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220183
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

On Wed, Apr 22, 2026 at 12:31:18PM +0530, Vishnu Reddy wrote:
> 
> On 4/19/2026 5:46 AM, Dmitry Baryshkov wrote:
> > On Wed, Apr 15, 2026 at 09:35:47PM +0530, Vishnu Reddy wrote:
> >>
> >> On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> >>> Replace the platform driver approach for compute bank (CB) devices
> >>> with the generic context_device_bus_type. Compute bank devices are
> >>> synthetic IOMMU context banks, not real platform devices, so using
> >>> the context device bus provides a more accurate representation in
> >>> the device model.
> >>>
> >>> Currently, fastrpc used of_platform_populate() to create platform
> >>> devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
> >>> driver (fastrpc_cb_driver) to handle probe/remove. This approach
> >>> had a race condition: device nodes were created before channel
> >>> resources (like spin_lock) were initialized, and probe was async,
> >>> so applications could open the device before sessions were available.
> >>>
> >>> This patch addresses the race by manually creating and configuring
> >>> CB devices synchronously during fastrpc_rpmsg_probe(), after all
> >>> channel resources are initialized. The approach follows the pattern
> >>> used in host1x_memory_context_list_init().
> >>>
> >>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>> ---
> >>>   drivers/misc/Kconfig   |   1 +
> >>>   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
> >>>   2 files changed, 125 insertions(+), 56 deletions(-)
> >>>
> >>>   	}
> >>>   	dma_bits = cctx->soc_data->dma_addr_bits_default;
> >>> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
> >>> +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> >>> +
> >>>   	sess = &cctx->session[cctx->sesscount++];
> >>>   	sess->used = false;
> >>>   	sess->valid = true;
> >>> -	sess->dev = dev;
> >>> -	dev_set_drvdata(dev, sess);
> >>> +	sess->sid = sid;
> >>> +	spin_unlock_irqrestore(&cctx->lock, flags);
> >>> -	if (cctx->domain_id == CDSP_DOMAIN_ID)
> >>> -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> >>> +	cb_dev = kzalloc_obj(*cb_dev);
> >>> +	if (!cb_dev)
> >>> +		return -ENOMEM;
> >>> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> >>> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> >>> +	cb_dev->sess = sess;
> >>> -	if (sessions > 0) {
> >>> -		struct fastrpc_session_ctx *dup_sess;
> >>> +	device_initialize(&cb_dev->dev);
> >>> +	cb_dev->dev.parent = parent;
> >>> +	cb_dev->dev.bus = &context_device_bus_type;
> >>> +	cb_dev->dev.release = fastrpc_cb_dev_release;
> >>> +	cb_dev->dev.of_node = of_node_get(cb_node);
> >>> +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
> >>> +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> >>> +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
> >>> +	rc = device_add(&cb_dev->dev);
> >> device_initialize() and device_add() can be replaced with single
> >> device_register() call. You can refer the below patch,
> > Keep in mind that for several arches device_initialize() sets the
> > coherent_dma_mask. So one should set coherent_dma_mask (as it's done
> > here) after calling device_initialize().
> 
> I can see that device_initialize() sets dma_coherent flag for several arches,
> not the coherent_dma_mask. The final dma_coherent flag value is updated later
> in of_dma_configure_id() based on the dt dma-coherent property.
> 
> Setting the coherent_dma_mask here and calling device_register() which will
> call the device_initialize() won't change the coherent_dma_mask value.
> Please correct me if I'm wrong?

I should get better glasses. I agree with you here.

> 
> >> https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/
> >>

-- 
With best wishes
Dmitry
