Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCCACD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B48110E976;
	Fri, 12 Jun 2026 08:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDOwR+76";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d9lenbX6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0033210E976
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:21:37 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C39fC02497006
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HQSvJWozo4ByAuo+APRH9am+
 q1ybhhdQDuPWL95pSvc=; b=TDOwR+76aMONq5/L6/TcMugCXl67/20ZSYDrIBbG
 ZamJQqkEC6yMVNdAJa2oTlXhL99/EoSZivfwgBGWEgFttNIIyFAOoYPdunjw8CLJ
 REEpMO7kyDe5314HVldSoOpUIc7JEU5yBTQECCR1NIbSTgcaI5l0/3dSez2kZKf7
 CjWpKvchZhPzTYBZQp+pLsvIhvDN9LW2ODnEiZPE1XqR8g5WVcMqpI6PXqLyq6DM
 DgWAX0sTL5qX4/StgTt17ztlB+Nt/r8PcB33GawgxM4kKC+dNNaOiAos/e9Rzcwz
 wH0tCloOKEhjGOxS+ylTTlVa7blhj72JETiKP2XdYjNKFQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7jsd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:21:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5179e5ba14cso9871291cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781252496; x=1781857296;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HQSvJWozo4ByAuo+APRH9am+q1ybhhdQDuPWL95pSvc=;
 b=d9lenbX6ejL/CLulLODt3DGbE7IXQXmePbZ8KLD6Q7xPfBe3ecCZykg1UKmN5NyLYR
 Cw/MSUwq8ojMSlw9Rv2QZOvYfYQHBdfFiq7cTGYhYccD83GEBDrn2TfkZJD3N74FH967
 kQ2fgd/IDT5yffT0f5WQ4cGOmUoWHyMIeVQq7K18mGgIc7KRXLayySptC903hnypRfvG
 Vgcz9vL5LJ8uHo2WeRRApwjoHweI3HjZcnfFWGUdC1OgWHk6CxJlB6O1+B4ZN/iHGVOT
 VvSI9bCxrE3CbrI2iUGQMs1z0R0LaeF4lsyG1iXtDVvlTZ7N/1s5eA7zFvFydv76gQak
 3i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781252496; x=1781857296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQSvJWozo4ByAuo+APRH9am+q1ybhhdQDuPWL95pSvc=;
 b=kRFUxOoCVptYF7EohbRBENDAEdrioLOPCcFjjxd79b/HVTbHAoAuvLuKl9Zoh32f5B
 fxzxD0EDrha0NTsDvKm5/D59nSSvpPC2sX5nFv3/CmhSNIko8IcDOJraonNWo0DZjMet
 6T72B0t2R5WoWHBc615D3m7IRSUCSwOOp50c815JnzxgYWIQ8905WH8GCpZi+BJhyx4n
 iBW5hWMVpVObM/JgVVmikrjMzsMFErjpeSapVh7qBykHqbvTY+J1J/zfOcEr885jDD+o
 dETfJuEvumtHkWE/XXmmXPkiCmO9oFiRcN3mj0zWNhdtJ92c209S/N+5CicoH5oxhsTX
 r3vA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zgDA3myYVGu/43D4eklW7MFfjYUnfDB0GBVfzitLMATxInFz1DLLSo8zU2UoX3ABq3I80RBeL3oc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlCU96m+0UxRif+Zy4wgYMqxATQch3eewiXXR2wWILNtgkWBhd
 M7GiViX1TQpGJgqSXj3/uTGLHZlT8l/ECyffoWMMXjvZd+RE3Q8NcCIwxcY7o/KT9iqxxuSoyLJ
 oWAkIB+Jgyqtm+p/RZzVo6e/1qGv6Z24bRNveaHZ2EWL2Sh0Pot4y1XkONWAskJLwRJO/w/Y=
X-Gm-Gg: Acq92OFy35EyLam+aDC+SSUJtf6Mje8J6/j9vS1Tg2LvDAQTtUX993yV8lSiGHYNV1x
 tZ+5a6LONLFgnfm80m8Ddb7QGvQrr9HHvbKalNjS8Sw9VogJZrtRHYdq1AgzM8hprESXuBB7g5s
 RhIPleufNuqNeBGOYGym6vhJoyp/i3T3N1FR6bDXeMISTXk3WLhvoRV3hxay36gqYZIyF5BsRpV
 oyJsPrKylBtgFE3JdUtJ04o1mGMI/tEG8MWcIWm5jKoDbAmuC6NlhoVSibHcM015CwVdgRTfezI
 XWkeSErAUl75FtrPiwdZ7kcVb+cEGe3/Tlt8b7DTcdwNIESmJVIXoj8oU+hCj5270LX72rfwnhS
 AQi1RB0cKIMs41XFui+AWLSUTjH8r5/ZH6PgrGQAlWQ04ESeWEXA5B6G3pSLIP2VfJe3s5/trvz
 G31S2EW72PcJyYq8M7g4k31SfuOCie2TG9B7c=
X-Received: by 2002:ac8:6548:0:b0:516:e10f:b1ec with SMTP id
 d75a77b69052e-517fe4de93amr20605321cf.11.1781252496197; 
 Fri, 12 Jun 2026 01:21:36 -0700 (PDT)
X-Received: by 2002:ac8:6548:0:b0:516:e10f:b1ec with SMTP id
 d75a77b69052e-517fe4de93amr20604961cf.11.1781252495595; 
 Fri, 12 Jun 2026 01:21:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e162013sm346082e87.10.2026.06.12.01.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:21:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:21:32 +0300
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
Message-ID: <vczsxrfn63j6cvqpnkaxb62yojblwo6st6jebhmi5tqxy4vhll@uj77wxirshyu>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-12-b2d984c297f8@oss.qualcomm.com>
 <43a7laqb7mnrvleunnmbxwhvzr6w3au4ofjri4r4ap7clsx6mc@jxqlr4a2lw56>
 <ba003d7d-03f5-4572-8321-3d1f666c8c27@oss.qualcomm.com>
 <q2q6tfnas3kikapwehbp6q7mykvk2wbuvn6ypbzc5ta7azh65w@wdwphde7gcxc>
 <b22703d3-03f2-4835-9eee-c3d1fa50a5ce@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22703d3-03f2-4835-9eee-c3d1fa50a5ce@oss.qualcomm.com>
X-Proofpoint-GUID: CcuxOAbolJ2s1YOR5KqVKc3cr2v-oYlr
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2bc191 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=CsBeXAGliFsQHFSCfIMA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3NCBTYWx0ZWRfXypA+AO8kLoe3
 mGhAVNCtgx8obm+lKdHRUsk9AybRTco9mDdnmkLyVBXSMliqg7dQfeAIhL/HhvHS8IV4ZKfQGSh
 lR0WvsciXB/BxMb+bnLAoAV+D0Nr83k7Dl+YOLPjblt/vkpQXfWNvCu6iZ0ufFKQKzeAzMQ7ESp
 V48xT0sKxEip6CA7RwCvqj5VTKVrFxOQDr96LRVS9HIMYpYEhvEylSFPYuY9wDyMXUI+gSJQ1QG
 R2SfFcHlGHNm0IMu5jawkoHA6WFo3MgguTOCAW3S+hzFlWRX6u7xwCrYfnDa3YskT68hhc6C4/2
 X17o/4R5cjMXXWqvZy2Ee8XalT25/ZqB1s3kmmqqmjCLvBUw88iPMdL/BpGfQ++GNf/vcX3j82J
 Zflfoee4rsNpH5taU0ulsey92IlzAC+uAMxqmK58kMwzyxGURW0ycBQRyZLD00Guoi+YJumtaks
 fEscpZ15SwFyOw0SjhQ==
X-Proofpoint-ORIG-GUID: CcuxOAbolJ2s1YOR5KqVKc3cr2v-oYlr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3NCBTYWx0ZWRfXy3VWZtDc32NW
 LiNYHfV22HDAk1oZAueAbJKKAPhb3tRSLRVqjp8RpvY4bcLId9cZ2G73V3APdJn8zMKo2vRNObm
 FUvhta6P+Uqhnl1hnTnZ2KZajlBTPjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120074
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

On Wed, Jun 10, 2026 at 03:08:17PM +0530, Ekansh Gupta wrote:
> On 08-06-2026 02:44, Dmitry Baryshkov wrote:
> > On Thu, Jun 04, 2026 at 10:39:14AM +0530, Ekansh Gupta wrote:
> >> On 20-05-2026 19:26, Dmitry Baryshkov wrote:
> >>> On Tue, May 19, 2026 at 11:46:02AM +0530, Ekansh Gupta via B4 Relay wrote:
> >>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>>>
> >>>> Implement the FastRPC remote procedure call path, allowing user-space
> >>>> to invoke methods on the DSP via DRM_IOCTL_QDA_REMOTE_INVOKE.
> >>>>
> >>>> qda_fastrpc.c / qda_fastrpc.h
> >>>>   Implements the FastRPC protocol layer: argument marshalling
> >>>>   (qda_fastrpc_invoke_pack), response unmarshalling
> >>>>   (qda_fastrpc_invoke_unpack), and invocation context lifecycle
> >>>>   management. Each invocation allocates a fastrpc_invoke_context
> >>>>   which tracks buffer descriptors, GEM objects, and the completion
> >>>>   used to synchronise with the DSP response.
> >>>>
> >>>>   Buffer arguments are handled in three ways:
> >>>>   - DMA-BUF fd: imported via PRIME, IOMMU-mapped dma_addr used
> >>>>   - Direct (inline): copied into the GEM-backed message buffer
> >>>>   - DMA handle: fd forwarded to DSP, physical page descriptor computed
> >>>
> >>> No. This needs to go away. The QDA should support only one way to pass
> >>> data - via the GEM buffers. Everything else should be handled by the
> >>> shim layer, etc.
> >> each FD passed here is a GEM buffer. The reason to pass fd is that there
> >> are some APIs on DSP side which takes fd as an argument and the user
> >> might use the same on their skel implementation. So in this case the
> >> remote call will take fd to DSP and the skel implementation will use the
> >> FD.>
> > 
> > Then handle it all on the userspace side. In the end, bad library API is
> > not a reason to complicate kernel API and kernel driver.
> The problem is that the user passes the fd as an argument to the remote
> call which the fastrpc library cannot decrypt. So basically the user can
> allocate some fd buffer(say with FD1) and then call some remote method
> passing FD1 as an int argument to call HAP_mmap on the same at DSP side,
> this int argument cannot be differentiated by fastrpc library as
> FD/non-FD argument.

How does it make the difference _now_? I hope it doesn't accept u64
value, bruteforcing if it is an FD, address or something else.

> > 
> >>>> +#define FASTRPC_SCALARS(method, in, out) \
> >>>> +		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
> >>>> +
> >>>> +/**
> >>>> + * struct fastrpc_buf_overlap - Buffer overlap tracking structure
> >>>> + *
> >>>> + * Tracks overlapping buffer regions to optimise memory mapping and avoid
> >>>> + * redundant mappings of the same physical memory.
> >>>
> >>> WHat for? Even if this is a valid optimization, implement it as a
> >>> subsequent patch. The first goal should be very simple - get GEM buffers
> >>> from the app, pass them to the DSP, read the results.
> >> yes, this implementation is mimicking the existing fastrpc design where
> >> non-FD buffers are also supported. I am currently evaluating the
> >> maintainance of such buffers from userspace side and trying to
> >> understand the impacts of the same. I am planning to bring it as a
> >> future enhancement if there is no regression.>
> > 
> > Other way around. Drop it for now and bring it back if it has any
> > positive impact.
> We did evaluation and don't see userspace side handling being feasible
> for non-FD buffers, I'll try to summarize the current design and the
> problem:
> 
> Currently a remote call can take up to 255 arguments and in many cases
> the user passes the buffers as non-FD arguments which is then copied to
> meta data and sent to DSP. Before copy there is an operation to identify
> if the buffers are overlapped so that it can be maintained efficiently.
> 
> DSP understands this based on offset and maps it accordingly, so for
> multiple small sized arguments, there is a possibility that a single
> page is used. Now if we allocate GEM buffers for each of these small
> arguments, it would lead to creation of multiple pages(can go up to 255)
> and all these pages then are required to be mapped onto DSP which could
> also lead to DSP address space exhaustion. So the limitation is too many
> pages and that DSP cannot handling this as efficiently as overlapped
> copy buffers.>

We started to discuss it during the call. Pretty much like you use a
single page (or single buffer) for small buffers in the kernel, your
userspace should be able to create the same single-BO-multiple-data
argument and then pass it to the kernel.

I think, you are mixing several different problems into a single bucket.
One is how to pass and map data buffers to the DSP, the other one is
how to pass arguments via the uAPI.

I think, for the second question we have an answer. Each argument is
located in a buffer at a certain offset provided by the userspace. All
the buffers are identified by the GEM handles. It should not matter for
the kernel driver if the buffer has been allocated from the QDA device
or if it was imported from another DMA-BUF provider. It should not
matter (again, for the kernel), if the user wants to pass all arguments
in a single BO or if each argument is a separate BO. The kernel must
collect GEM handles used by the call, make sure that they are mapped to
the DSP address space, covert them to the addresses for the DSP side and
then pass those addresses to the DSP. All the overlapping calculations,
packing, strategy belong to the userspace.

> >>>> +	/** @handle: Handle of the remote method being invoked */
> >>>> +	u32 handle;
> >>>> +	/** @crc: Pointer to CRC values for data integrity checking */
> >>>> +	u32 *crc;
> >>>
> >>> Add it later. It's unused. Drop all unused fields.
> >> ack.>
> >>>> +	/** @fdlist: Pointer to array of DMA-BUF file descriptors */
> >>>> +	u64 *fdlist;
> >>>
> >>> Why do you need DMA-BUFs in the invocation context? They all should be
> >>> GEM buffers.
> >> the reason is that the users are dependent on FDs as they can import
> >> buffers allocated from anywhere and there are DSP APIs which takes fd as
> >> an argument, so they might end up using the same in there skel
> >> implementation.>
> > 
> > No, DSP API can't take FD, they don't quite cross the OS and IOMMU
> > boundary. It's the userspace library API. Which might be improved,
> > rewritten, implemented underneath, etc. For the kernel side please,
> > pass _only_ GEM handles + offsets.
> Yes, but with the current DSP design, DSP APIs take FD just because of
> client/user design. On fastrpc, users could bring FD from any source,
> register it with fastrpc and pass it on to DSP.

The users can bring FD from any source, import it to the QDA's GEM and
then receive the handle. 

> The major problem is
> what I mentioned above, where the user application passes the FD as an
> integer argument and the fastrpc library not able to identify if that
> int is an fd or some other data.>

Please provide an example: the API and the ways to pass the data via the
FD or 'other data'. Explain, how _currently_ it is handled.

But, anyway, a bad userspace design is not a reason to complicate uAPI.
Library API is not written in stone, there are SOVERSIONs, wrappers and
all other ways to provide phase out, deprecation and backwards
compatibility. The uAPI, on the other hand, is written in stone.

> >>>> +	/** @pkt_size: Total payload size in bytes */
> >>>> +	u64 pkt_size;
> >>>> +	/** @aligned_pkt_size: Page-aligned payload size for GEM allocation */
> >>>> +	u64 aligned_pkt_size;
> >>>> +	/** @list: Array of invoke buffer descriptors */
> >>>> +	struct fastrpc_invoke_buf *list;
> >>>> +	/** @pages: Array of physical page descriptors for all arguments */
> >>>> +	struct fastrpc_phy_page *pages;
> >>>> +	/** @input_pages: Array of physical page descriptors for input buffers */
> >>>> +	struct fastrpc_phy_page *input_pages;
> >>>
> >>> I think you are trying to bring all the complexity from the old driver
> >>> with no added benefit. Please don't. Use the existing memory manager.
> >>> Let it handle all the gory details. If someting is not there, we should
> >>> consider extending GEM instead.
> >> I'm not changing the metadata format as the DSP might not understand the
> >> messages if we modify it.
> > 
> > Well, it's up to you to know if DSP will understand the message or not.
> > The probability ("might not") is not suitable here. Anyway, let's get
> > rid of the various data formats first, then maybe some of the items will
> > go away on their own.
> ack>
> >> Also, the fd is still being used because of
> >> the client dependency on it. I'll check if there is any other logic that
> >> needs alteration here.>
> > 
> > If the client keeps on passing FD to the library calls, you can map
> > FD to GEM handles in the library code.
> I hope the int argument part mentioned above answers this.>

NO. You are still telling me that you allow users to shove random data
to the kernel and then make the kernel decipher what kind of data it
received. This is a very bad interface. Fix it.

> >>>> +
> >>>> +static int fastrpc_context_get_id(struct fastrpc_invoke_context *ctx, struct qda_dev *qdev)
> >>>> +{
> >>>> +	int ret;
> >>>> +	u32 id;
> >>>> +
> >>>> +	if (!qdev)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	ret = xa_alloc(&qdev->ctx_xa, &id, ctx, xa_limit_32b, GFP_KERNEL);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	ctx->ctxid = id << 4;
> >>>
> >>> Why is it being shifted?
> >> this is to accomodate PD type>
> > 
> > Not really an answer.
> Okay, let me bring the ctxid layout that DSP expects:
> 
> [11:4] = CCCCCCCC (context ID)
> [3:0]  = PPPP (PD type)
> 
> Based on this PD type, DSP will decide where to queue the message.

And what does it mean?

> > 
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>
> >>
> > 
> 

-- 
With best wishes
Dmitry
