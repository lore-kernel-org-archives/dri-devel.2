Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D947CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307C810EBA8;
	Sun,  7 Jun 2026 21:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWryxAUI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="coqzT6df";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8404010EBA8
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:14:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657EjsFd440307
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bVcqkhgaJSPD6A1e5VhyvGpy
 bYdJrSVM+2Bo77SiPkk=; b=ZWryxAUIOTOp6rfwOhdKZBk+CQzQ6VsRmUz1XzC5
 8RSgEsq/Ta0ZNlJ9UosaUKDUX3QJGyQfcB/QkOwozfF/wTLsUnsSLI/j8EDS1Hna
 JIdloOCxU+03Z8Kaync5G/qGsYj9UAdOnUn/kSX5fMzm10vt+rsGPZFWTjjRrtls
 q3s1WnzxmkO+WSaQT9LQHsZXj5M3tdPbCYkIfuWjDCyX3ts5bHj771OJQ16HzpjB
 Nx0dpheSf+Of+5+Fm0dnYvqDtUH08i6XTM+v5Nk53ylSPDoS+wlAK7CaJUGGMXqC
 Vl6/7lCtq9My06VETGlPcFoSnGxMpwKyUAqOiUAevwU8og==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cw9be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:14:16 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6cc5ae9b959so4401298137.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780866855; x=1781471655;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bVcqkhgaJSPD6A1e5VhyvGpybYdJrSVM+2Bo77SiPkk=;
 b=coqzT6dfgsMuE4UutYJ6NejDAhcmoOW7zTBS/Bi3v5hKvHZdYKsTzMqLmz0cgxTgt4
 46Xl1SnlBk9LNk4wTBc27YQmDwzDx+1ibMOr2OXLV4bcu2vpAJ+ImHgwx6us8ymy9RQA
 MzLVlKz6l18pgISgjqs+vAy5d0KuIdKgDR6Utdg8T8V72A1twQhYT+rZVYCb//Aix6y1
 c+f8n1mU61rS+JMTUcKADgSODCrx9NPRe6a4yFewtQcKzMhkSEZqKXHnJeN++YiKPRQQ
 YhkEpDOM5V++pAF9ISvWhO8q+yZlTx68WLv2D/NRHqRWJj9qikyomSt899JWldqE2BVG
 XmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780866855; x=1781471655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVcqkhgaJSPD6A1e5VhyvGpybYdJrSVM+2Bo77SiPkk=;
 b=gzuwiHv4iFgvWZb26jto+v0wnzYG57X6bhyK0Xme4rF0W+O0uSR4nFCl3mrYgbl8Oi
 Tx2MehBvsUgqM9uEcBvTlEljX8rHa9xbsB5v9LQvD/nYCe6Qz4sQe9ic8bsITpjmChWp
 ClBdwGRMKM/IUfuLnJ9G8q8iviEIuLwbWKry683a8WMnuIFkBhXvpaWVZ7HDnZ7OEAUi
 L0X4PFJOUFNI4eOSv+cCq7cuHTjxWpLRF7pzE50ZJfe2NOiKxD4idIONKjV7O0uFTiWD
 /RR2F9DhElUAE+Zhrk1Jn/yzdEqjvKPwCCN7xiwWn/wqN69DyXzmjL0ie/laHvKqZIMM
 Ruuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VK09btRV1AixRI0ScuJLoQp8mNaZXH9PXbHY/smtwPywTztC50ySc/yc+B8m/X2f0+TvxBtOayvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywz6xNnaC60Rnk20Y7aR28fjJfRfEYM9otE8zFFUCiv1sn7QofD
 Hpa41V9c0wvRel8uj5ZggCll3lokob0RBSopNhbvyRF6XxN+446/xMixbLPjhedwYIx2aH6WutI
 qzm1paOkRTFKYBzWgtaxqh/BJwcJxlC4jokwuLwWIccn9/BgzkzkDx+pEJtMRaeEe8uSKEGs=
X-Gm-Gg: Acq92OEGwMzp34zG7oIP+3LOX74kncchwJ0JXXwFs0XhZVSTWwk1dBroygqYlNcoobQ
 K7OmOjgKKafSz6gtD46toYL6Fq/suGkWyjZCfN34FC4+QuwO0mXXf6zsiLudJrtsZ30ioRWqMf0
 RcIf4xJsCQIFHm4wTM6yz/dOWPZz+edbWRbHJEiRDLOQ2xGlCnI0FNSKhZAJnH/qwSqFpAzA6Bl
 1BnCx28bTsQdvklc7/Zt3iXx+706ATG/Bh7+xu+JtsbIcVFu8L4t6MOi57SazypomvALOxgB2tP
 XERIRl7byo1no1GgnWoyvHWEsg0RwZJL5u+XCPztN7PWZCeCvOEUqePmqRGZnfHUNVWtqw9EqhE
 I8bOzFKUcI1VNVkmYgft9DxpPURWvi6D2MCT4lyz2s4PVd4YmStSLd/tyVHw8revkbxef+MVIxP
 kr9QS10aJ4sP0hIKlXa6PEMTQxoGEysEdrNRv/N7lKkS0DYg==
X-Received: by 2002:a05:6102:c91:b0:6cc:16d2:3100 with SMTP id
 ada2fe7eead31-6fef1098102mr6567921137.13.1780866855331; 
 Sun, 07 Jun 2026 14:14:15 -0700 (PDT)
X-Received: by 2002:a05:6102:c91:b0:6cc:16d2:3100 with SMTP id
 ada2fe7eead31-6fef1098102mr6567897137.13.1780866854873; 
 Sun, 07 Jun 2026 14:14:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8edf4fsm3319707e87.16.2026.06.07.14.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:14:13 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:14:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 12/15] accel/qda: Add FastRPC invocation support
Message-ID: <q2q6tfnas3kikapwehbp6q7mykvk2wbuvn6ypbzc5ta7azh65w@wdwphde7gcxc>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-12-b2d984c297f8@oss.qualcomm.com>
 <43a7laqb7mnrvleunnmbxwhvzr6w3au4ofjri4r4ap7clsx6mc@jxqlr4a2lw56>
 <ba003d7d-03f5-4572-8321-3d1f666c8c27@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba003d7d-03f5-4572-8321-3d1f666c8c27@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNCBTYWx0ZWRfX4laHAtnEIGwf
 vwbjr7OQ1P/0iIony2XPFUWKJtLGqPYA1aUAxouGhZ+ud643FH64+ArXNsb/bhV+xZFqb80Lyeh
 vi6kKx8sOqBPk+PO2pB4+QFPopFCzYQafZExDkkXyW0GKDi6zj7W4N0WQFsOk2i5ZCQaPg3BVjC
 vXIfFGcOJDWNmplKIj+uBZrbM7w+FUjwLbTKc6QFb5krB676azchHKmoJP97I/gP2TLL+88HIUz
 wPu2GwHQ4O3HMjAPZUnl/hna+GKWOIzNSa0Bp9KmgBLiM6f2U5DHaHehuWTeoy5wXNgPlSUSfim
 FPUF89BYS0ClWCqban7pTwKnxnSAZlaDfThHbsUTmqq/JIsKD8ihGRcY6xeJ96E7pkt0t54sBpE
 0vmobQY8iPryxoXcioc8pKNIzkVG371FOwzVz81A4g++Dm/BvWt9sLisU4em5NLXdUY1uZtOiox
 iiNqJMgtZ++Z04//vBQ==
X-Proofpoint-ORIG-GUID: wBoR6r6nLWHTTL3qig-kc8XTcuDWXV8X
X-Proofpoint-GUID: wBoR6r6nLWHTTL3qig-kc8XTcuDWXV8X
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a25df28 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=SKmDr6HH6J8_EXO89VAA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070214
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

On Thu, Jun 04, 2026 at 10:39:14AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:26, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:46:02AM +0530, Ekansh Gupta via B4 Relay wrote:
> >> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>
> >> Implement the FastRPC remote procedure call path, allowing user-space
> >> to invoke methods on the DSP via DRM_IOCTL_QDA_REMOTE_INVOKE.
> >>
> >> qda_fastrpc.c / qda_fastrpc.h
> >>   Implements the FastRPC protocol layer: argument marshalling
> >>   (qda_fastrpc_invoke_pack), response unmarshalling
> >>   (qda_fastrpc_invoke_unpack), and invocation context lifecycle
> >>   management. Each invocation allocates a fastrpc_invoke_context
> >>   which tracks buffer descriptors, GEM objects, and the completion
> >>   used to synchronise with the DSP response.
> >>
> >>   Buffer arguments are handled in three ways:
> >>   - DMA-BUF fd: imported via PRIME, IOMMU-mapped dma_addr used
> >>   - Direct (inline): copied into the GEM-backed message buffer
> >>   - DMA handle: fd forwarded to DSP, physical page descriptor computed
> > 
> > No. This needs to go away. The QDA should support only one way to pass
> > data - via the GEM buffers. Everything else should be handled by the
> > shim layer, etc.
> each FD passed here is a GEM buffer. The reason to pass fd is that there
> are some APIs on DSP side which takes fd as an argument and the user
> might use the same on their skel implementation. So in this case the
> remote call will take fd to DSP and the skel implementation will use the
> FD.>

Then handle it all on the userspace side. In the end, bad library API is
not a reason to complicate kernel API and kernel driver.

> >> +#define FASTRPC_SCALARS(method, in, out) \
> >> +		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
> >> +
> >> +/**
> >> + * struct fastrpc_buf_overlap - Buffer overlap tracking structure
> >> + *
> >> + * Tracks overlapping buffer regions to optimise memory mapping and avoid
> >> + * redundant mappings of the same physical memory.
> > 
> > WHat for? Even if this is a valid optimization, implement it as a
> > subsequent patch. The first goal should be very simple - get GEM buffers
> > from the app, pass them to the DSP, read the results.
> yes, this implementation is mimicking the existing fastrpc design where
> non-FD buffers are also supported. I am currently evaluating the
> maintainance of such buffers from userspace side and trying to
> understand the impacts of the same. I am planning to bring it as a
> future enhancement if there is no regression.>

Other way around. Drop it for now and bring it back if it has any
positive impact.

> >> + */
> >> +struct fastrpc_buf_overlap {
> > 
> > Stop clashing the names with the existing fastrpc driver.
> ack.>
> >> +	/** @start: Start address of the buffer in user virtual address space */
> >> +	u64 start;
> >> +	/** @end: End address of the buffer in user virtual address space */
> >> +	u64 end;
> >> +	/** @raix: Remote argument index associated with this overlap */
> >> +	int raix;
> >> +	/** @mstart: Start address of the mapped region */
> >> +	u64 mstart;
> >> +	/** @mend: End address of the mapped region */
> >> +	u64 mend;
> >> +	/** @offset: Offset within the mapped region */
> >> +	u64 offset;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_remote_dmahandle - Remote DMA handle descriptor
> >> + */
> >> +struct fastrpc_remote_dmahandle {
> >> +	/** @fd: DMA-BUF file descriptor */
> >> +	s32 fd;
> >> +	/** @offset: Byte offset within the DMA-BUF */
> >> +	u32 offset;
> >> +	/** @len: Length of the region in bytes */
> >> +	u32 len;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_remote_buf - Remote buffer descriptor
> >> + */
> >> +struct fastrpc_remote_buf {
> >> +	/** @pv: Buffer pointer (user virtual address) */
> >> +	u64 pv;
> >> +	/** @len: Length of the buffer in bytes */
> >> +	u64 len;
> >> +};
> >> +
> >> +/**
> >> + * union fastrpc_remote_arg - Remote argument (buffer or DMA handle)
> >> + */
> >> +union fastrpc_remote_arg {
> >> +	/** @buf: Inline buffer descriptor */
> >> +	struct fastrpc_remote_buf buf;
> >> +	/** @dma: DMA-BUF handle descriptor */
> >> +	struct fastrpc_remote_dmahandle dma;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_phy_page - Physical page descriptor
> >> + */
> >> +struct fastrpc_phy_page {
> >> +	/** @addr: Physical (IOMMU) address of the page */
> >> +	u64 addr;
> >> +	/** @size: Size of the contiguous region in bytes */
> >> +	u64 size;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_invoke_buf - Invoke buffer descriptor
> >> + */
> >> +struct fastrpc_invoke_buf {
> >> +	/** @num: Number of contiguous physical regions */
> >> +	u32 num;
> >> +	/** @pgidx: Index into the physical page array */
> >> +	u32 pgidx;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_msg - FastRPC wire message for remote invocations
> >> + *
> >> + * Sent to the remote processor via RPMsg. This is the exact layout
> >> + * the DSP expects; do not reorder or add fields without DSP firmware
> >> + * coordination.
> >> + */
> >> +struct fastrpc_msg {
> >> +	/** @remote_session_id: Session identifier on the remote processor */
> >> +	int remote_session_id;
> >> +	/** @tid: Thread ID of the invoking thread */
> >> +	int tid;
> >> +	/** @ctx: Context identifier for matching request/response */
> >> +	u64 ctx;
> >> +	/** @handle: Handle of the remote method to invoke */
> >> +	u32 handle;
> >> +	/** @sc: Scalars value encoding in/out buffer counts */
> >> +	u32 sc;
> >> +	/** @addr: Physical address of the message payload buffer */
> >> +	u64 addr;
> >> +	/** @size: Size of the message payload in bytes */
> >> +	u64 size;
> >> +};
> >> +
> >> +/**
> >> + * struct qda_msg - FastRPC message with kernel-internal bookkeeping
> >> + *
> >> + * The wire-format portion is kept in the embedded @fastrpc member (must
> >> + * be first) so that &qda_msg->fastrpc can be passed directly to
> >> + * rpmsg_send() without a copy.
> >> + */
> >> +struct qda_msg {
> >> +	/**
> >> +	 * @fastrpc: Wire-format message sent to the DSP via RPMsg.
> >> +	 * Must be the first member.
> >> +	 */
> >> +	struct fastrpc_msg fastrpc;
> >> +	/** @buf: Kernel virtual address of the payload buffer */
> >> +	void *buf;
> >> +	/** @phys: Physical/DMA address of the payload buffer */
> >> +	u64 phys;
> >> +	/** @ret: Return value from the remote processor */
> >> +	int ret;
> >> +	/** @fastrpc_ctx: Back-pointer to the owning invocation context */
> >> +	struct fastrpc_invoke_context *fastrpc_ctx;
> >> +	/** @file_priv: DRM file private data for GEM object lookup */
> >> +	struct drm_file *file_priv;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_invoke_context - Remote procedure call invocation context
> >> + *
> >> + * Maintains all state for a single remote procedure call, including buffer
> >> + * management, synchronisation, and result handling.
> >> + */
> >> +struct fastrpc_invoke_context {
> >> +	/** @node: List node for linking contexts in a queue */
> >> +	struct list_head node;
> >> +	/** @ctxid: Unique context identifier (XArray key shifted left by 4) */
> >> +	u64 ctxid;
> >> +	/** @inbufs: Number of input buffers */
> >> +	int inbufs;
> >> +	/** @outbufs: Number of output buffers */
> >> +	int outbufs;
> >> +	/** @handles: Number of DMA-BUF handle arguments */
> >> +	int handles;
> >> +	/** @nscalars: Total number of scalar arguments */
> >> +	int nscalars;
> >> +	/** @nbufs: Total number of buffer arguments (inbufs + outbufs) */
> >> +	int nbufs;
> > 
> > If it is inbufs + outbufs, why do you need it here?
> > 
> >> +	/** @pid: Process ID of the calling process */
> >> +	int pid;
> >> +	/** @retval: Return value from the remote invocation */
> >> +	int retval;
> >> +	/** @metalen: Length of the FastRPC metadata header in bytes */
> >> +	int metalen;
> > 
> > size_t, also why do you need it?
> > 
> >> +	/** @remote_session_id: Session identifier on the remote processor */
> >> +	int remote_session_id;
> >> +	/** @pd: Protection domain identifier encoded into the context ID */
> >> +	int pd;
> >> +	/** @type: Invocation type (e.g. FASTRPC_RMID_INVOKE_DYNAMIC) */
> >> +	int type;
> >> +	/** @sc: Scalars value encoding in/out buffer counts */
> >> +	u32 sc;
> > 
> > How is this different from the counts above?
> sc carries the method id and handle counts. The reason to maintain count
> separately is to avoid calculating it again and again.>

Is it just a sum of several values or something more complicated?

> >> +	/** @handle: Handle of the remote method being invoked */
> >> +	u32 handle;
> >> +	/** @crc: Pointer to CRC values for data integrity checking */
> >> +	u32 *crc;
> > 
> > Add it later. It's unused. Drop all unused fields.
> ack.>
> >> +	/** @fdlist: Pointer to array of DMA-BUF file descriptors */
> >> +	u64 *fdlist;
> > 
> > Why do you need DMA-BUFs in the invocation context? They all should be
> > GEM buffers.
> the reason is that the users are dependent on FDs as they can import
> buffers allocated from anywhere and there are DSP APIs which takes fd as
> an argument, so they might end up using the same in there skel
> implementation.>

No, DSP API can't take FD, they don't quite cross the OS and IOMMU
boundary. It's the userspace library API. Which might be improved,
rewritten, implemented underneath, etc. For the kernel side please,
pass _only_ GEM handles + offsets.

> >> +	/** @pkt_size: Total payload size in bytes */
> >> +	u64 pkt_size;
> >> +	/** @aligned_pkt_size: Page-aligned payload size for GEM allocation */
> >> +	u64 aligned_pkt_size;
> >> +	/** @list: Array of invoke buffer descriptors */
> >> +	struct fastrpc_invoke_buf *list;
> >> +	/** @pages: Array of physical page descriptors for all arguments */
> >> +	struct fastrpc_phy_page *pages;
> >> +	/** @input_pages: Array of physical page descriptors for input buffers */
> >> +	struct fastrpc_phy_page *input_pages;
> > 
> > I think you are trying to bring all the complexity from the old driver
> > with no added benefit. Please don't. Use the existing memory manager.
> > Let it handle all the gory details. If someting is not there, we should
> > consider extending GEM instead.
> I'm not changing the metadata format as the DSP might not understand the
> messages if we modify it.

Well, it's up to you to know if DSP will understand the message or not.
The probability ("might not") is not suitable here. Anyway, let's get
rid of the various data formats first, then maybe some of the items will
go away on their own.

> Also, the fd is still being used because of
> the client dependency on it. I'll check if there is any other logic that
> needs alteration here.>

If the client keeps on passing FD to the library calls, you can map
FD to GEM handles in the library code.

> >> +
> >> +static int fastrpc_context_get_id(struct fastrpc_invoke_context *ctx, struct qda_dev *qdev)
> >> +{
> >> +	int ret;
> >> +	u32 id;
> >> +
> >> +	if (!qdev)
> >> +		return -EINVAL;
> >> +
> >> +	ret = xa_alloc(&qdev->ctx_xa, &id, ctx, xa_limit_32b, GFP_KERNEL);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ctx->ctxid = id << 4;
> > 
> > Why is it being shifted?
> this is to accomodate PD type>

Not really an answer.

> >> +	return 0;
> >> +}
> >> +
> > 
> 

-- 
With best wishes
Dmitry
