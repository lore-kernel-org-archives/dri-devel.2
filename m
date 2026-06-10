Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20950CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8353810E83D;
	Wed, 10 Jun 2026 09:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0B0/CSr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wo/OGlvm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4C910E840
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:38:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7iZT5989190
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fLahizlXX21JZl8j3A8UCWqbtcmXHv2dftjEyU0Kt2U=; b=G0B0/CSrpQkuFS4s
 a7qfxcN0hGzlTeeLtQn7ZxFbd7BJ44iouWigMU3FyRBO5CvV1leqGfgXIUANKPfB
 H4xA2PZ6Ph27nOAOBeI6Gp0IJQTBNxPiETVcGtpyuajkdnaPDkDI/F2KfuGeibzF
 SA3afuC617MKr6lpneo8IA/cbIktCcR/Sf1Na5b0GXr4K7ZbQs9oIg9sO40UmLDx
 FF3AJHxPjixGeBZEh2wAe9m1gp0j0KWoi2HI3JHFnwjAgccj9onPjDHJ9sZ4Tem/
 9GeJ3U5d7ipAXOZRQf33GQ5yVUTaCTtNJTZybBwguakynoj35oJn2vN8xSIficxU
 bcOB6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq2segq76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:38:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36bc02d28b6so4968355a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781084308; x=1781689108;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLahizlXX21JZl8j3A8UCWqbtcmXHv2dftjEyU0Kt2U=;
 b=Wo/OGlvm1EeqXGitPnK4qICVZNx27MzAbVS2Z3rA8O6IBuP/+UnLVY7op4suXGuu/B
 C1CCzCRgJA7o0arNMaSsT9BW4Sji4IQIYPC6cqapEkDcewrDX6gkQ49J/Bn1T8ih+CIF
 9HgMnInvXfb3mZad1OWuLBz86NcMrdoSuvbVrhVODRdgHZd6NBBblZJaLmXR6yo8k3XW
 QtmlhlMplvtfKbRgLkpOpIPh4qAS8ylMTPSDqfwQnqjw8gAZmLAJSsCi4izy0YOOayBs
 uWUEKM/fqoZroaBvDDN39LEm4KhrZ/B7jgqlBl+YsePw0xFRkG3WhIgpo9T68f1BgphX
 S6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781084308; x=1781689108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLahizlXX21JZl8j3A8UCWqbtcmXHv2dftjEyU0Kt2U=;
 b=ZbBuaCVrobyY9fOd/hNae33f92VgUMr+1uwxbWSaBWYowp9HFBthgQ129RcKY9iwL7
 QHzVnUklAN0z+CpwZsqS59M68XBu6UBH5gvQjC0/SvLG7+fbm1xinZoDQvtLP+q+QF65
 zykqMCGTOr8uUXd44MrvTJf3Qf0fiOVb5MmLCQ64pQfGbOwT4C8BMoLjadl8dKk7hQHk
 Vn2nGD9/fXLbyQYaNJeKTks9O9F7zu/tVCSa9NmosqZw+3sU3qFS1FTxVrPUWO3QF8AC
 cyrRdQ0oB1FMEsBfeQc+XWZZiUPYywvEY56mRRlPARWVwKtsmH2vLDGPVUXV5xQUV9iH
 PBJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80NqY5mjAzMyYPLeFqtAb04V7qfOKHEvB+dglTBnlG4Z2bsdXjy4qCcSvQvVzJlWnz+neE/89Zh5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFMzylzcAkU8fXvuI4LxkjNRi37swNyTo9u0oQh0V7v8StYg40
 sGlVyXwHnw3yjb/GYgbYzk/j8hiAavGkOFPBeKTm53ETzUdShh/m3gxSUM/bVOwnaYNPfb4B4TG
 w5Uf/7nauDZ/W7vKp6pEgJfoumAqoK2MLP+3fXFToacyPNHGdu0DtWaOF+cVaqKoYFn2gMc8=
X-Gm-Gg: Acq92OFjk5YT4TTGv/Hx91O1FDhIPvbUqJIL8zuDZnfYIO90Zv2joVsMJAmftbtK6Gu
 rDnvvClrMZAYzqiMK3hwRwcX8BlV4oxzyIYPcVxWHPldsZgkbK7UaCEhvSO85aoT5p3Ir7zrqsx
 WRy4hI+4RNIL596GBb9yCCS7tV85JUHgxDqUiIupmx16ea6QxCg+aUajC+Zn+9su3jj8uvhmtGv
 sIIRpIRSfwoF/Qf/4EeRn6pIGlo2Z0GHB3kH9ppTs0eMoYdKZNje2vXTYE3+GcugxW99rJ6FLHG
 2re5B9CKQy8S9U4UO3i1F5MJvwZE0dSrb5R7lEu1k9chhGontrmCHVwyAAoVEuZBZPYNpQ85QY/
 1vvS9Il50Z2fFYWmmgCMNJfPtG7uZjm0sSh+Qf/xvXeR/4YtlJjVHlOP5LkmFRA==
X-Received: by 2002:a17:90b:5145:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-370eed0b63bmr26327680a91.7.1781084308239; 
 Wed, 10 Jun 2026 02:38:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5145:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-370eed0b63bmr26327640a91.7.1781084307708; 
 Wed, 10 Jun 2026 02:38:27 -0700 (PDT)
Received: from [10.204.78.173] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37624a8e76csm2773910a91.15.2026.06.10.02.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 02:38:26 -0700 (PDT)
Message-ID: <b22703d3-03f2-4835-9eee-c3d1fa50a5ce@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 15:08:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] accel/qda: Add FastRPC invocation support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-12-b2d984c297f8@oss.qualcomm.com>
 <43a7laqb7mnrvleunnmbxwhvzr6w3au4ofjri4r4ap7clsx6mc@jxqlr4a2lw56>
 <ba003d7d-03f5-4572-8321-3d1f666c8c27@oss.qualcomm.com>
 <q2q6tfnas3kikapwehbp6q7mykvk2wbuvn6ypbzc5ta7azh65w@wdwphde7gcxc>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <q2q6tfnas3kikapwehbp6q7mykvk2wbuvn6ypbzc5ta7azh65w@wdwphde7gcxc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uiJqRtAPG74xcZiMtGD-oY9riW2HTl-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA5MSBTYWx0ZWRfXxArt8glsbZKl
 CQKySSvXTOQYjQTd2qvqTw6sI1ct1OdAcZeZvU6OWzIxi0O+U6+L+Ft+lAwmKXzRIG0Y56KsuB2
 O3hHhrEcWi1jGPSxSmnCSv/go+D7zF4z6Soq6p51vRBAZ9AwCYxo7J2nP/bN8HQ5BGlFDgNnBi3
 ufwkTdM0mJAK+0q+LY42PU1AYLl+IjRhCwDoL8+4bOBSnwbEvqNAI9NBzq2zT0hYE8dUcfW9PnJ
 kAqCkz8ZfEXdWleAuKgz8SRJcBgx+pRf2BUAZGiiQTUToO1L1fV5DFI6IRbRNyVHlSJpKKVWCeh
 L8UhbnIhzSTbpPZiKb7wtddy7OiK+SfL5og+feSfVuGmi43KCxYi1IQuaCu1pIXzQBHIa2hhT7x
 0h4CGt7XwUvheB1hHbErWWV89YDByzR8P9f74idE/Hc25Ad1QRKpdN7Hi60yzZtYHgplZW85vx/
 Vg12EoL+YWH0HTHoO2A==
X-Proofpoint-ORIG-GUID: uiJqRtAPG74xcZiMtGD-oY9riW2HTl-Q
X-Authority-Analysis: v=2.4 cv=Md1cfZ/f c=1 sm=1 tr=0 ts=6a293095 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0tHIOXy_Vfvaqy0H-swA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100091
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

On 08-06-2026 02:44, Dmitry Baryshkov wrote:
> On Thu, Jun 04, 2026 at 10:39:14AM +0530, Ekansh Gupta wrote:
>> On 20-05-2026 19:26, Dmitry Baryshkov wrote:
>>> On Tue, May 19, 2026 at 11:46:02AM +0530, Ekansh Gupta via B4 Relay wrote:
>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>
>>>> Implement the FastRPC remote procedure call path, allowing user-space
>>>> to invoke methods on the DSP via DRM_IOCTL_QDA_REMOTE_INVOKE.
>>>>
>>>> qda_fastrpc.c / qda_fastrpc.h
>>>>   Implements the FastRPC protocol layer: argument marshalling
>>>>   (qda_fastrpc_invoke_pack), response unmarshalling
>>>>   (qda_fastrpc_invoke_unpack), and invocation context lifecycle
>>>>   management. Each invocation allocates a fastrpc_invoke_context
>>>>   which tracks buffer descriptors, GEM objects, and the completion
>>>>   used to synchronise with the DSP response.
>>>>
>>>>   Buffer arguments are handled in three ways:
>>>>   - DMA-BUF fd: imported via PRIME, IOMMU-mapped dma_addr used
>>>>   - Direct (inline): copied into the GEM-backed message buffer
>>>>   - DMA handle: fd forwarded to DSP, physical page descriptor computed
>>>
>>> No. This needs to go away. The QDA should support only one way to pass
>>> data - via the GEM buffers. Everything else should be handled by the
>>> shim layer, etc.
>> each FD passed here is a GEM buffer. The reason to pass fd is that there
>> are some APIs on DSP side which takes fd as an argument and the user
>> might use the same on their skel implementation. So in this case the
>> remote call will take fd to DSP and the skel implementation will use the
>> FD.>
> 
> Then handle it all on the userspace side. In the end, bad library API is
> not a reason to complicate kernel API and kernel driver.
The problem is that the user passes the fd as an argument to the remote
call which the fastrpc library cannot decrypt. So basically the user can
allocate some fd buffer(say with FD1) and then call some remote method
passing FD1 as an int argument to call HAP_mmap on the same at DSP side,
this int argument cannot be differentiated by fastrpc library as
FD/non-FD argument.
> 
>>>> +#define FASTRPC_SCALARS(method, in, out) \
>>>> +		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
>>>> +
>>>> +/**
>>>> + * struct fastrpc_buf_overlap - Buffer overlap tracking structure
>>>> + *
>>>> + * Tracks overlapping buffer regions to optimise memory mapping and avoid
>>>> + * redundant mappings of the same physical memory.
>>>
>>> WHat for? Even if this is a valid optimization, implement it as a
>>> subsequent patch. The first goal should be very simple - get GEM buffers
>>> from the app, pass them to the DSP, read the results.
>> yes, this implementation is mimicking the existing fastrpc design where
>> non-FD buffers are also supported. I am currently evaluating the
>> maintainance of such buffers from userspace side and trying to
>> understand the impacts of the same. I am planning to bring it as a
>> future enhancement if there is no regression.>
> 
> Other way around. Drop it for now and bring it back if it has any
> positive impact.
We did evaluation and don't see userspace side handling being feasible
for non-FD buffers, I'll try to summarize the current design and the
problem:

Currently a remote call can take up to 255 arguments and in many cases
the user passes the buffers as non-FD arguments which is then copied to
meta data and sent to DSP. Before copy there is an operation to identify
if the buffers are overlapped so that it can be maintained efficiently.

DSP understands this based on offset and maps it accordingly, so for
multiple small sized arguments, there is a possibility that a single
page is used. Now if we allocate GEM buffers for each of these small
arguments, it would lead to creation of multiple pages(can go up to 255)
and all these pages then are required to be mapped onto DSP which could
also lead to DSP address space exhaustion. So the limitation is too many
pages and that DSP cannot handling this as efficiently as overlapped
copy buffers.>
>>>> + */
>>>> +struct fastrpc_buf_overlap {
>>>
>>> Stop clashing the names with the existing fastrpc driver.
>> ack.>
>>>> +	/** @start: Start address of the buffer in user virtual address space */
>>>> +	u64 start;
>>>> +	/** @end: End address of the buffer in user virtual address space */
>>>> +	u64 end;
>>>> +	/** @raix: Remote argument index associated with this overlap */
>>>> +	int raix;
>>>> +	/** @mstart: Start address of the mapped region */
>>>> +	u64 mstart;
>>>> +	/** @mend: End address of the mapped region */
>>>> +	u64 mend;
>>>> +	/** @offset: Offset within the mapped region */
>>>> +	u64 offset;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct fastrpc_remote_dmahandle - Remote DMA handle descriptor
>>>> + */
>>>> +struct fastrpc_remote_dmahandle {
>>>> +	/** @fd: DMA-BUF file descriptor */
>>>> +	s32 fd;
>>>> +	/** @offset: Byte offset within the DMA-BUF */
>>>> +	u32 offset;
>>>> +	/** @len: Length of the region in bytes */
>>>> +	u32 len;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct fastrpc_remote_buf - Remote buffer descriptor
>>>> + */
>>>> +struct fastrpc_remote_buf {
>>>> +	/** @pv: Buffer pointer (user virtual address) */
>>>> +	u64 pv;
>>>> +	/** @len: Length of the buffer in bytes */
>>>> +	u64 len;
>>>> +};
>>>> +
>>>> +/**
>>>> + * union fastrpc_remote_arg - Remote argument (buffer or DMA handle)
>>>> + */
>>>> +union fastrpc_remote_arg {
>>>> +	/** @buf: Inline buffer descriptor */
>>>> +	struct fastrpc_remote_buf buf;
>>>> +	/** @dma: DMA-BUF handle descriptor */
>>>> +	struct fastrpc_remote_dmahandle dma;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct fastrpc_phy_page - Physical page descriptor
>>>> + */
>>>> +struct fastrpc_phy_page {
>>>> +	/** @addr: Physical (IOMMU) address of the page */
>>>> +	u64 addr;
>>>> +	/** @size: Size of the contiguous region in bytes */
>>>> +	u64 size;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct fastrpc_invoke_buf - Invoke buffer descriptor
>>>> + */
>>>> +struct fastrpc_invoke_buf {
>>>> +	/** @num: Number of contiguous physical regions */
>>>> +	u32 num;
>>>> +	/** @pgidx: Index into the physical page array */
>>>> +	u32 pgidx;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct fastrpc_msg - FastRPC wire message for remote invocations
>>>> + *
>>>> + * Sent to the remote processor via RPMsg. This is the exact layout
>>>> + * the DSP expects; do not reorder or add fields without DSP firmware
>>>> + * coordination.
>>>> + */
>>>> +struct fastrpc_msg {
>>>> +	/** @remote_session_id: Session identifier on the remote processor */
>>>> +	int remote_session_id;
>>>> +	/** @tid: Thread ID of the invoking thread */
>>>> +	int tid;
>>>> +	/** @ctx: Context identifier for matching request/response */
>>>> +	u64 ctx;
>>>> +	/** @handle: Handle of the remote method to invoke */
>>>> +	u32 handle;
>>>> +	/** @sc: Scalars value encoding in/out buffer counts */
>>>> +	u32 sc;
>>>> +	/** @addr: Physical address of the message payload buffer */
>>>> +	u64 addr;
>>>> +	/** @size: Size of the message payload in bytes */
>>>> +	u64 size;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct qda_msg - FastRPC message with kernel-internal bookkeeping
>>>> + *
>>>> + * The wire-format portion is kept in the embedded @fastrpc member (must
>>>> + * be first) so that &qda_msg->fastrpc can be passed directly to
>>>> + * rpmsg_send() without a copy.
>>>> + */
>>>> +struct qda_msg {
>>>> +	/**
>>>> +	 * @fastrpc: Wire-format message sent to the DSP via RPMsg.
>>>> +	 * Must be the first member.
>>>> +	 */
>>>> +	struct fastrpc_msg fastrpc;
>>>> +	/** @buf: Kernel virtual address of the payload buffer */
>>>> +	void *buf;
>>>> +	/** @phys: Physical/DMA address of the payload buffer */
>>>> +	u64 phys;
>>>> +	/** @ret: Return value from the remote processor */
>>>> +	int ret;
>>>> +	/** @fastrpc_ctx: Back-pointer to the owning invocation context */
>>>> +	struct fastrpc_invoke_context *fastrpc_ctx;
>>>> +	/** @file_priv: DRM file private data for GEM object lookup */
>>>> +	struct drm_file *file_priv;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct fastrpc_invoke_context - Remote procedure call invocation context
>>>> + *
>>>> + * Maintains all state for a single remote procedure call, including buffer
>>>> + * management, synchronisation, and result handling.
>>>> + */
>>>> +struct fastrpc_invoke_context {
>>>> +	/** @node: List node for linking contexts in a queue */
>>>> +	struct list_head node;
>>>> +	/** @ctxid: Unique context identifier (XArray key shifted left by 4) */
>>>> +	u64 ctxid;
>>>> +	/** @inbufs: Number of input buffers */
>>>> +	int inbufs;
>>>> +	/** @outbufs: Number of output buffers */
>>>> +	int outbufs;
>>>> +	/** @handles: Number of DMA-BUF handle arguments */
>>>> +	int handles;
>>>> +	/** @nscalars: Total number of scalar arguments */
>>>> +	int nscalars;
>>>> +	/** @nbufs: Total number of buffer arguments (inbufs + outbufs) */
>>>> +	int nbufs;
>>>
>>> If it is inbufs + outbufs, why do you need it here?
>>>
>>>> +	/** @pid: Process ID of the calling process */
>>>> +	int pid;
>>>> +	/** @retval: Return value from the remote invocation */
>>>> +	int retval;
>>>> +	/** @metalen: Length of the FastRPC metadata header in bytes */
>>>> +	int metalen;
>>>
>>> size_t, also why do you need it?
>>>
>>>> +	/** @remote_session_id: Session identifier on the remote processor */
>>>> +	int remote_session_id;
>>>> +	/** @pd: Protection domain identifier encoded into the context ID */
>>>> +	int pd;
>>>> +	/** @type: Invocation type (e.g. FASTRPC_RMID_INVOKE_DYNAMIC) */
>>>> +	int type;
>>>> +	/** @sc: Scalars value encoding in/out buffer counts */
>>>> +	u32 sc;
>>>
>>> How is this different from the counts above?
>> sc carries the method id and handle counts. The reason to maintain count
>> separately is to avoid calculating it again and again.>
> 
> Is it just a sum of several values or something more complicated?
just the sum, I'll drop it if it's not really useful.>
>>>> +	/** @handle: Handle of the remote method being invoked */
>>>> +	u32 handle;
>>>> +	/** @crc: Pointer to CRC values for data integrity checking */
>>>> +	u32 *crc;
>>>
>>> Add it later. It's unused. Drop all unused fields.
>> ack.>
>>>> +	/** @fdlist: Pointer to array of DMA-BUF file descriptors */
>>>> +	u64 *fdlist;
>>>
>>> Why do you need DMA-BUFs in the invocation context? They all should be
>>> GEM buffers.
>> the reason is that the users are dependent on FDs as they can import
>> buffers allocated from anywhere and there are DSP APIs which takes fd as
>> an argument, so they might end up using the same in there skel
>> implementation.>
> 
> No, DSP API can't take FD, they don't quite cross the OS and IOMMU
> boundary. It's the userspace library API. Which might be improved,
> rewritten, implemented underneath, etc. For the kernel side please,
> pass _only_ GEM handles + offsets.
Yes, but with the current DSP design, DSP APIs take FD just because of
client/user design. On fastrpc, users could bring FD from any source,
register it with fastrpc and pass it on to DSP. The major problem is
what I mentioned above, where the user application passes the FD as an
integer argument and the fastrpc library not able to identify if that
int is an fd or some other data.>
>>>> +	/** @pkt_size: Total payload size in bytes */
>>>> +	u64 pkt_size;
>>>> +	/** @aligned_pkt_size: Page-aligned payload size for GEM allocation */
>>>> +	u64 aligned_pkt_size;
>>>> +	/** @list: Array of invoke buffer descriptors */
>>>> +	struct fastrpc_invoke_buf *list;
>>>> +	/** @pages: Array of physical page descriptors for all arguments */
>>>> +	struct fastrpc_phy_page *pages;
>>>> +	/** @input_pages: Array of physical page descriptors for input buffers */
>>>> +	struct fastrpc_phy_page *input_pages;
>>>
>>> I think you are trying to bring all the complexity from the old driver
>>> with no added benefit. Please don't. Use the existing memory manager.
>>> Let it handle all the gory details. If someting is not there, we should
>>> consider extending GEM instead.
>> I'm not changing the metadata format as the DSP might not understand the
>> messages if we modify it.
> 
> Well, it's up to you to know if DSP will understand the message or not.
> The probability ("might not") is not suitable here. Anyway, let's get
> rid of the various data formats first, then maybe some of the items will
> go away on their own.
ack>
>> Also, the fd is still being used because of
>> the client dependency on it. I'll check if there is any other logic that
>> needs alteration here.>
> 
> If the client keeps on passing FD to the library calls, you can map
> FD to GEM handles in the library code.
I hope the int argument part mentioned above answers this.>
>>>> +
>>>> +static int fastrpc_context_get_id(struct fastrpc_invoke_context *ctx, struct qda_dev *qdev)
>>>> +{
>>>> +	int ret;
>>>> +	u32 id;
>>>> +
>>>> +	if (!qdev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = xa_alloc(&qdev->ctx_xa, &id, ctx, xa_limit_32b, GFP_KERNEL);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ctx->ctxid = id << 4;
>>>
>>> Why is it being shifted?
>> this is to accomodate PD type>
> 
> Not really an answer.
Okay, let me bring the ctxid layout that DSP expects:

[11:4] = CCCCCCCC (context ID)
[3:0]  = PPPP (PD type)

Based on this PD type, DSP will decide where to queue the message.
> 
>>>> +	return 0;
>>>> +}
>>>> +
>>>
>>
> 

