Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D11C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428010E6DA;
	Mon, 24 Aug 2026 10:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+ujSlq+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUqYMvkO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C0C10E6DA
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:39:44 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99Lga2900997
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EH+CuZjP4cDRfKOg/gisXTBEt3tpjz6voXrCTk5GOxo=; b=a+ujSlq+jQ5yxo4p
 zQ+RyLbY/Qw7RhEzmxJ2ItxbfABdgVGf9KwB/g5xTdsuyQedXSs1wq30zzLEDnPN
 wGpR1j2fHGf5KW4tWUHQH4ZXt7hi5175DAduB61DDwnB7eZQ3lTs3MXUd9BkBBb3
 55svgnXiJmER7LWUShXr3KO5CI/nZJxPMXFFS3URDSAPN9o8+iotNoYgL0r921sk
 0F03EIFkAeBITk8/LYXk9OTo5ufHFN84w/lW8OsJzw7ofN/f4vqTWho48zrnE4Sc
 DPyJe6ET+fNhkYaHLac4WyJyJvA8c3Dae8jWMJ6uedkQjNrOzm3jRnWlXkjsYZHZ
 I2uoqg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgru5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:39:43 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4488f192768so5427638fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787567982; x=1788172782;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EH+CuZjP4cDRfKOg/gisXTBEt3tpjz6voXrCTk5GOxo=;
 b=FUqYMvkOpuqVB8a3pSiekAAwUAVRR0mTqZRwlolAIsxupgPhWpckIG92zJBn/jr9j7
 S1WZ534FmqKtz47XpFW5H3BV+421zAWj8V/dVgPkKXbMKkgn5ephFOQMTQphTi26w53Z
 3/d1WN7hjMRO5ztFSfKsPsZdRYiFFElvmd16TgER8sML/zXVzHXyAdGS4tVNtgDQKSuj
 F3XN1654Vitb2TCBcuOvikv8G8Hia9IgOGrsgyXnGz4+DRYW6nRjW01XgBvWUk1FgU8e
 FXObCZuP923iWkchHao/L9NgsCnRHjIUtysfieUdRj9VHYm/j4fgD52y/aRUL0d/06WH
 evUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567982; x=1788172782;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EH+CuZjP4cDRfKOg/gisXTBEt3tpjz6voXrCTk5GOxo=;
 b=JAQpDD4BBr8P1TLi7fincE0sCRXl9huRw20cztcSZpwhoAvEjSRvH18c1Sz58cCvCC
 ws2ao0UZFDUqY35H/fBy6pGWIRynxi9Hyj/kowyS9tTOclTQf4x39RlUyzmPi4YDQLmT
 DLr4qjcIEdftc1dJTp71xyLx0WamOXUnEwWo5+VpGFQAhGnGar/9dAZgpGW7mrHzG3gT
 GGkvYrDn+sHOIS1H+EJiaVChs21HgwnStlohmtls4qOZXPMkTZMiGt/VnxFlFS6rG3Pb
 E8yPHgtGV7+kUEvo6cryNSq8ktym8DUAng5HohVo0cL2CUm/DjhqAbCgqpWhu1Akwjdu
 XEuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSSqckRxzjPJ13HvVQdD6g6vpLlIUpHAF82ef3mljAV30b9/dGHYiNHpwOszpLK/kAtLsSAX3QAI8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvAzvLQqLDplXaEdNePziPgqkjh6ot+XdvzZ/KdvvfbaVmoSEv
 R+HZUNHwlpEOuhA656Lc7Bho5C3HvwCyEGeaycALCLTGLRUQ2Sbk1IdMYEVil12EDR6CUIewPxG
 TTfjXLiJ/816PY7NMtSrKAnKkebFXjThBGNpMrUaRRZwTn1d5ZsmvaMDGWhwhmQuJJ0Ligws=
X-Gm-Gg: AR+sD12WjB0SVfOIqWf83TsXTDrWjBWD9v4Sp9jlc+bcba1n8IUltwjeURD7QLSWcHf
 MUmdKgR14CQ8RZPsQA14an9bEQoAtmD2SYUr3rvlJfV7T73sF6m/Nj8vKoMOBAX5xVBrEc9C9HR
 hC1nKowqHFBDAdkhGM+w4NZrEbjRLcQvUiW4uCK4TiyjIoSgiOTqwH5VI/DqRTr1wzgh61xSS2j
 FeNg+ZtxCAg2fTI2/TxuXXw8AYTbp1rzybX8yY/Afiwn8thrC/mt5q1w1s21XhZWWeyrNhyjDko
 8Xs8XjeratDQ7D41Tna4UIo3NaHWSpgf4oFFKOPLeC1ZssBDKrIAInnYgpMAjAPrkfhA2HA+hW1
 b9IRbruNxT5uoQE3sQf83yvK9XNB9tw==
X-Received: by 2002:a05:6820:205:b0:6b1:4fe1:9464 with SMTP id
 006d021491bc7-6b1593ad824mr24135567eaf.22.1787567982430; 
 Mon, 24 Aug 2026 03:39:42 -0700 (PDT)
X-Received: by 2002:a05:6820:205:b0:6b1:4fe1:9464 with SMTP id
 006d021491bc7-6b1593ad824mr24135534eaf.22.1787567981917; 
 Mon, 24 Aug 2026 03:39:41 -0700 (PDT)
Received: from [10.219.56.151] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46383499862sm5295493fac.9.2026.08.24.03.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 03:39:41 -0700 (PDT)
Message-ID: <75858cb3-5490-4e11-81fd-d6b73cbc28eb@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:09:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260814101955.234238-1-jianping.li@oss.qualcomm.com>
 <57185025-de92-43c4-a300-fa2682993d15@oss.qualcomm.com>
 <9176dda0-ba46-47aa-a642-390dc0b01228@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <9176dda0-ba46-47aa-a642-390dc0b01228@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4OCBTYWx0ZWRfX4+uAhTVR3Q3v
 H7iv7FUHiOl2dheCBqZ5MBLK2+54iLp/rhkSIzHumwedQf6nMTfldIJQASSpC9vNHcjZuMno+X0
 bpZWyudLYKutgEAI17pfNxM1AEHAYOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4OCBTYWx0ZWRfXxkMhWOPPqqFt
 fZedUild+syaWNOvXHSYEQs2WI9OrkYCLHWCaVnrhDQhOY+PZpaJ13rkFlbC4BobuVmd8qX2als
 Ww4F/nuFSumgG59BrfG9AG0Fn1rxI9dLTyMfVABmUMR6R73M3SjlegMsTaxij4vcbn1pTaW3Dk/
 br4iqmGSBiJqyWcckvvMNo8uWxOjc6CTjB8k9FQO52fYteC+sdreZPRDYo2lVlo4fxrZMgDx9my
 p3iUvS7+YYmbMVpB7XAv2bpedP/GjmJ5ctutaI9+e74bQd8fZb8XXOB+HlTC8IOR8EeB7vxuJj9
 DsK7mzxDtoxFYgOijRHI/17y/xjVtESdQWgEXwkIJwOtQ1UmCSkFbpan4Ip7SbdmnztJIkbWdsD
 Un2AX8gQ/ghYzHHXtriGADo279b4LlqB3OTm9g8tK70W0iZyXSZqN0d9cSq+IyhMGO4vpigHjSe
 KHCp00+tlHGSKWzAzuA==
X-Proofpoint-ORIG-GUID: zRpbnTMVx3FjeVJeVSjCeJatgu1_j61O
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c1f6f cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Tn-M0EgaeUShJGCi6KMA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-GUID: zRpbnTMVx3FjeVJeVSjCeJatgu1_j61O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240088
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

On 24-08-2026 14:19, Jianping Li wrote:
> 
> On 8/20/2026 1:10 PM, Ekansh Gupta wrote:
>> On 14-08-2026 15:49, Jianping Li wrote:
>>> Allocating and freeing Audio PD memory from userspace is unsafe because
>>> the kernel cannot reliably determine when the DSP has finished using the
>>> memory. Userspace may free buffers while they are still in use by the DSP,
>>> and remote free requests cannot be safely trusted.
>>>
>>> Additionally, the current implementation allows userspace to repeatedly
>>> grow the Audio PD heap, but does not support shrinking it. This can lead
>>> to unbounded memory usage over time, effectively causing a memory leak.
>>>
>>> Fix this by allocating the entire Audio PD reserved-memory region during
>>> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
>>> userspace-controlled alloc/free and ensures that memory is reclaimed only
>>> when the DSP process is torn down.
>>>
>>> The reserved-memory region is now mandatory for the Audio PD domain.
>>> Rather than failing rpmsg probe when it is missing, validate it in
>>> fastrpc_init_create_static_process() and reject only the static-process
>>> creation. This keeps the fastrpc device probing for all other domains
>>> even on a misconfigured device tree.
>>>
>>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>>> Cc: stable@kernel.org
>>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>>> ---
>>> Patch [v11]: https://lore.kernel.org/all/20260731093210.473-1-
>>> jianping.li@oss.qualcomm.com/
>>>
>>> Changes in v12:
>>>  - Do not fail rpmsg probe when the reserved-memory region is missing,
>>>    validate the region in fastrpc_init_create_static_process() instead,
>>>    so probe keeps working for all domains.
>>>  - Add fastrpc_domain_has_reserved_heap() / fastrpc_domain_uses_static_heap()
>>>    helpers to replace the open-coded ADSP/SDSP domain checks.
>>>
>>> Changes in v11:
>>>  - Replace the remote_heap fastrpc_buf pointer with dedicated
>>>    remote_heap_addr and remote_heap_size fields in
>>>    fastrpc_channel_ctx to avoid leaving a partially
>>>    initialized fastrpc_buf.
>>>
>>>  - Drop ADSP_MMAP_REMOTE_HEAP_ADDR support from
>>>    fastrpc_req_mmap() since the user process should no longer
>>>    grow or shrink the Audio PD remote heap.
>>>
>>> Changes in v10:
>>>  - Move Audio PD remote heap validation into
>>>    fastrpc_rpmsg_probe().
>>>
>>>  - Treat Audio PD remote heap as a mandatory
>>>    resource and fail probe if the reserved
>>>    memory region is missing.
>>>
>>> Changes in v9:
>>>  - Make sure fastrpc_init_create_static_process()
>>>    only sets audio_init_mem to false when the sent
>>>    address is actually invalid.
>>> ---
>>>  drivers/misc/fastrpc.c | 150 +++++++++++++++++++++--------------------
>>>  1 file changed, 76 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 90fd669636ec..3f14a4673698 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -70,8 +70,6 @@
>>>  #define ADSP_MMAP_HEAP_ADDR  4
>>>  /* MAP static DMA buffer on DSP User PD */
>>>  #define ADSP_MMAP_DMA_BUFFER  6
>>> -/* Add memory to static PD pool protection thru hypervisor */
>>> -#define ADSP_MMAP_REMOTE_HEAP_ADDR  8
>>>  /* Add memory to userPD pool, for user heap */
>>>  #define ADSP_MMAP_ADD_PAGES 0x1000
>>>  /* Add memory to userPD pool, for LLC heap */
>>> @@ -314,10 +312,14 @@ struct fastrpc_channel_ctx {
>>>  	struct kref refcount;
>>>  	/* Flag if dsp attributes are cached */
>>>  	bool valid_attributes;
>>> +	/* Flag if audio PD init mem was allocated */
>>> +	bool audio_init_mem;
>>> +	/* Audio PD reserved remote heap region */
>>> +	phys_addr_t remote_heap_addr;
>>> +	u64 remote_heap_size;
>>>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>>  	struct fastrpc_device *secure_fdevice;
>>>  	struct fastrpc_device *fdevice;
>>> -	struct fastrpc_buf *remote_heap;
>>>  	struct list_head invoke_interrupted_mmaps;
>>>  	bool secure;
>>>  	bool unsigned_support;
>>> @@ -1454,15 +1456,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>  	struct fastrpc_init_create_static init;
>>>  	struct fastrpc_invoke_args *args;
>>>  	struct fastrpc_phy_page pages[1];
>>> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
>>>  	char *name;
>>>  	int err;
>>> -	bool scm_done = false;
>>>  	struct {
>>>  		int client_id;
>>>  		u32 namelen;
>>>  		u32 pageslen;
>>>  	} inbuf;
>>>  	u32 sc;
>>> +	unsigned long flags;
>>> +	bool sent_heap = false;
>>> +
>>> +	if (!cctx->remote_heap_addr || !cctx->remote_heap_size) {
>>> +		err = -ENOMEM;
>>> +		dev_err(fl->sctx->dev,
>>> +			"remote heap memory region is not added\n");
>>> +		return err;
>>> +	}
>>>  
>>>  	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>>  	if (!args)
>>> @@ -1486,31 +1497,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>  	inbuf.client_id = fl->client_id;
>>>  	inbuf.namelen = init.namelen;
>>>  	inbuf.pageslen = 0;
>>> -	if (!fl->cctx->remote_heap) {
>>> -		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
>>> -						&fl->cctx->remote_heap);
>>> -		if (err)
>>> -			goto err_name;
>>> -
>>> -		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>>> -		if (fl->cctx->vmcount) {
>>> -			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>> -
>>> -			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>>> -							(u64)fl->cctx->remote_heap->size,
>>> -							&src_perms,
>>> -							fl->cctx->vmperms, fl->cctx->vmcount);
>>> -			if (err) {
>>> -				dev_err(fl->sctx->dev,
>>> -					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
>>> -					&fl->cctx->remote_heap->dma_addr,
>>> -					fl->cctx->remote_heap->size, err);
>>> -				goto err_map;
>>> -			}
>>> -			scm_done = true;
>>> -			inbuf.pageslen = 1;
>>> -		}
>>> -	}
>>>  
>>>  	fl->pd = USER_PD;
>>>  
>>> @@ -1522,8 +1508,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>  	args[1].length = inbuf.namelen;
>>>  	args[1].fd = -1;
>>>  
>>> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>>> -	pages[0].size = fl->cctx->remote_heap->size;
>>> +	/*
>>> +	 * Audio PD is a static PD and retains the remote heap
>>> +	 * information across daemon restarts. Therefore only
>>> +	 * the first attach should provide heap information to
>>> +	 * DSP. Subsequent attaches reuse the previously
>>> +	 * initialized memory pool.
>>> +	 */
>>> +	spin_lock_irqsave(&cctx->lock, flags);
>>> +	if (!cctx->audio_init_mem) {
>>> +		pages[0].addr = cctx->remote_heap_addr;
>>> +		pages[0].size = cctx->remote_heap_size;
>>> +		cctx->audio_init_mem = true;
>>> +		inbuf.pageslen = 1;
>>> +		sent_heap = true;
>>> +	} else {
>>> +		pages[0].addr = 0;
>>> +		pages[0].size = 0;
>>> +	}
>>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>>  
>>>  	args[2].ptr = (u64)(uintptr_t) pages;
>>>  	args[2].length = sizeof(*pages);
>>> @@ -1541,27 +1544,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>  
>>>  	return 0;
>>>  err_invoke:
>>> -	if (fl->cctx->vmcount && scm_done) {
>>> -		u64 src_perms = 0;
>>> -		struct qcom_scm_vmperm dst_perms;
>>> -		u32 i;
>>> -
>>> -		for (i = 0; i < fl->cctx->vmcount; i++)
>>> -			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
>>> -
>>> -		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>>> -		dst_perms.perm = QCOM_SCM_PERM_RWX;
>>> -		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>>> -						(u64)fl->cctx->remote_heap->size,
>>> -						&src_perms, &dst_perms, 1);
>>> -		if (err)
>>> -			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
>>> -				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
>>> +	if (sent_heap) {
>>> +		spin_lock_irqsave(&cctx->lock, flags);
>>> +		cctx->audio_init_mem = false;
>>> +		spin_unlock_irqrestore(&cctx->lock, flags);
>>>  	}
>>> -err_map:
>>> -	fastrpc_buf_free(fl->cctx->remote_heap);
>>> -	fl->cctx->remote_heap = NULL;
>>> -err_name:
>>>  	kfree(name);
>>>  err:
>>>  	kfree(args);
>>> @@ -2090,7 +2077,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>>>  	if (copy_from_user(&req, argp, sizeof(req)))
>>>  		return -EFAULT;
>>>  
>>> -	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
>>> +	if (req.flags != ADSP_MMAP_ADD_PAGES) {
>>>  		dev_err(dev, "flag not supported 0x%x\n", req.flags); return -EINVAL; @@ -2101,10 +2088,7 @@ static int
>>> fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp) return -
>>> EINVAL; } - if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) - err =
>>> fastrpc_remote_heap_alloc(fl, dev, req.size, &buf); - else - err =
>>> fastrpc_buf_alloc(fl, dev, req.size, &buf); + err =
>>> fastrpc_buf_alloc(fl, dev, req.size, &buf); if (err) { dev_err(dev, "failed to allocate buffer\n");
>>> @@ -2143,20 +2127,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>>>  	/* let the client know the address to use */
>>>  	req.vaddrout = rsp_msg.vaddr;
>>>  
>>> -	/* Add memory to static PD pool, protection thru hypervisor */
>>> -	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
>>> -		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>> -
>>> -		err = qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
>>> -			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
>>> -		if (err) {
>>> -			dev_err(fl->sctx->dev,
>>> -				"Failed to assign memory dma_addr %pad size 0x%llx err %d",
>>> -				&buf->dma_addr, buf->size, err);
>>> -			goto err_assign;
>>> -		}
>>> -	}
>>> -
>>>  	spin_lock(&fl->lock);
>>>  	list_add_tail(&buf->node, &fl->mmaps);
>>>  	spin_unlock(&fl->lock);
>>> @@ -2537,6 +2507,16 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
>>>  	{},
>>>  };
>>>  
>>> +static bool fastrpc_domain_has_reserved_heap(u32 domain_id)
>>> +{
>>> +	return domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID;
>>> +}
>>> +
>>> +static bool fastrpc_domain_uses_static_heap(u32 domain_id)
>>> +{
>>> +	return domain_id == ADSP_DOMAIN_ID;
>>> +}
>> any reason to have functions for one time used checks?> +
> 
> Just to give some context: I added these helpers based on the v11
> review, which requested replacing the open-coded ADSP/SDSP checks
> with functions describing the per-domain capabilities.
> 
> In this patch, they currently have a single caller each.
> Therefore, if you feel it's unnecessary, I can revert
> to the version without helpers.
move the reserved memory initialization block to a new helper function,
something like fastrpc_init_reserved_mem()>
>>>  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>>  {
>>>  	struct device *rdev = &rpdev->dev;
>>> @@ -2584,20 +2564,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>>  		}
>>>  	}
>>>  
>>> -	if (domain_id == SDSP_DOMAIN_ID) {
>>> +	if (fastrpc_domain_has_reserved_heap(domain_id)) {
>>>  		struct resource res;
>>>  		u64 src_perms;
>>>  
>>>  		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>>>  		if (!err) {
>>> +			if (fastrpc_domain_uses_static_heap(domain_id)) {
>>> +				data->remote_heap_addr = res.start;
>>> +				data->remote_heap_size = resource_size(&res);
>>> +			}
>>>  			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>>  
>>>  			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>>>  				    data->vmperms, data->vmcount);
>> better to check vmcount before calling this>  			if (err)
> 
> Agreed. I'll wrap the qcom_scm_assign_mem() call in if (data->vmcount) in v13.
> 
>>>  				goto err_free_data;
>>> +		} else {
>>> +			err = 0;
>>>  		}
>>> -
>>>  	}
>>>  
>>>  	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>>> @@ -2681,6 +2666,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>>  	struct fastrpc_buf *buf, *b;
>>>  	struct fastrpc_user *user;
>>>  	unsigned long flags;
>>> +	int err, i;
>>>  
>>>  	/* No invocations past this point */
>>>  	spin_lock_irqsave(&cctx->lock, flags);
>>> @@ -2698,8 +2684,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>>>  		list_del(&buf->node);
>>>  
>>> -	if (cctx->remote_heap)
>>> -		fastrpc_buf_free(cctx->remote_heap);
>>> +	if (cctx->remote_heap_size && cctx->vmcount) {
>>> +		u64 src_perms = 0;
>>> +		struct qcom_scm_vmperm dst_perms;
>>> +
>>> +		for (i = 0; i < cctx->vmcount; i++)
>>> +			src_perms |= BIT(cctx->vmperms[i].vmid);
>>> +
>>> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>>> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
>>> +
>>> +		err = qcom_scm_assign_mem(cctx->remote_heap_addr,
>>> +					  cctx->remote_heap_size, &src_perms,
>>> +					  &dst_perms, 1);
>>> +		if (err)
>>> +			dev_err(&rpdev->dev,
>>> +				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
>>> +				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
>>> +	}
>>>  
>>>  	of_platform_depopulate(&rpdev->dev);
>>>  

