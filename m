Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01A7C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3702210E078;
	Mon, 24 Aug 2026 08:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rd9Vd8Ch";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="blPkwqW/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D1510E078
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:49:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5Qxcu2041215
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mvB5ND5UEE5e0p7bPL7obO5M
 sjMOTjW7DGKTLybttYk=; b=Rd9Vd8Ch1V6wuFfVk9b9midbcdTUGG53DbB+41Kn
 PAgx2WkatxSNIrAT5YpGMC2Xcow5MAIR0Vo95lIfFmxiFnAhpjt+R5YokGj+meNF
 bFO3w97gPC0B80ZftRaSgqGL+LPsIJr7uFxEJx2R5EJLHDZvrzAbye9mKuASCQHU
 bkWYU+xyY6htJle659Ecrr4ASbRhoUDlzHF+NsrRN45ezt7oBfHi5otZbkltNzHt
 eYUT7F6wLx3XUEs42kG1cYfxAkr75o3ND2Vx4DHYhFR8HXInrqrdJvmi9H87oyjS
 cr0R5aP2b3cRMLhLIHDCfeF9fV6x7tastikknFh8ne2TNg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7hr0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:49:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3950b1371a7so4961496a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787561385; x=1788166185;
 darn=lists.freedesktop.org; 
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mvB5ND5UEE5e0p7bPL7obO5MsjMOTjW7DGKTLybttYk=;
 b=blPkwqW/4DHpkC8nYnMI83L2EGrYhc5hXbgPfRZXYS+WSTWyxK0ahXc4b6GoiqIpvC
 40JpoFX1nKMgEn//DCgZA0Dcl8/IIYHxzbCZFl+Ve0W+guTaAp4r7Fjnjv0L07hmpJq6
 TVAgo/bvgfmn27u/bpls6hZzAUQHiL31lqJ2mEqrel+6CLsCkkZeAyGV6z4QcX42Ef53
 wgLrUenEbC7oZpoqxv/TicsUHQmJFhFUXAD5DhjWwIMxzY9ANwS9euxRuxsnMR7wKbee
 Elpms6hZbNUZeR8JA7Cjzn1oURGHzMgUCvtk6SkBXG+gYvCpnWBNGotpcLr4Ww3Rs163
 8Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561385; x=1788166185;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvB5ND5UEE5e0p7bPL7obO5MsjMOTjW7DGKTLybttYk=;
 b=YgOwT4XjGyOklCZx2MSwgQYHWPdlJgdEClIV+4x69VfAjMTWaqdotPG0j/EMqpLwoT
 riwvj1E4ArVH6TgctMmI4KYWtAo8DvWwhHPpsRuZz8QTJHhNtWr+twwBKvyGKP3pvfTS
 U1Pyw8kJo5wxjQeop+MFRNvuZNFNmt4y4l4J7HxmDl6csHDBuu4GIPR2qsDvHHSE4/gu
 MNmLXy9ZQg6vizbPn/H2h7Gn1RBa9lH95ECJs5kUYymNRtC4SobPe+Y0L7UYDyOux4Ej
 7PhnVmRrX4koBCOpJGlLIgym5tZJfWjuisC7H7PreJls9EF1jn7oG86f3V7mAMvY/8QK
 Ir8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrf56BVihS5Ac7s338cuHnGGYeFnEEpExCakWXfHbrfFPF2ai6KpoHCYEl9vn4CdYFlvShZxLdU2Vs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7wHXG9y/K9dIGJwbxV03+8rWgd8kvnONuOAZ8Ho5/XTNKpWTm
 eXbcxrpClaAt/wEB5BKQRSB0XRWMmdPCxeMMxCJecW9LsnbSLD7w8Ga25rRgKW5rCyxFZuS98KP
 JBMX6D7A6PIOAfYyK0FeUQd9Cy+JnzRI8wyu838LSOgiY2UFDOoNlJvCV5389Ay8+hkphatg=
X-Gm-Gg: AR+sD13KGJSwLjiJ48/4rbkvint6psmN8bTNwSnxomoBG2jZafM1nvaMEpXegdtvr4/
 aViT2cFqiQXi7Df2dHujTWNJuc80mn/HiBADodPTpd7RvOQk/+e1Pdu0vUAEZb7aPu24L/zS1dF
 yRWUmkP5Bljj9+9xOXjvI/ncPAZj3D5TA0oLQOnWOzrq7B3deMU4sBtFWG5jofO1M4gH45agi6B
 z6YgDQkmh1IifSy3WxK9shSECV+AjyMGU31FKzahSwLzk9SeCBusEHYaVcHGlfZ8lps414QNWCW
 XWh88Bq6OQpp6aABNnzBPEBrrF/Cb8UtaTW/Uiitbm2Cstk3PSKhj1/N63l3xtlqrPRG2M+zYcq
 Ksjxig2vsUN9FTufQ5Mh/LKufpA/2XycUMfWWkcM52GQ2RvYZc0V+I+Hi45myxmDDdAHBcw==
X-Received: by 2002:a17:90b:520c:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-395c3867ac5mr46662610a91.14.1787561384782; 
 Mon, 24 Aug 2026 01:49:44 -0700 (PDT)
X-Received: by 2002:a17:90b:520c:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-395c3867ac5mr46662479a91.14.1787561383901; 
 Mon, 24 Aug 2026 01:49:43 -0700 (PDT)
Received: from [10.249.11.93] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d67675f3f6sm15735945ad.10.2026.08.24.01.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 01:49:43 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------SzWFdw2I1iH1JqLFwQNlgPCO"
Message-ID: <9176dda0-ba46-47aa-a642-390dc0b01228@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:49:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20260814101955.234238-1-jianping.li@oss.qualcomm.com>
 <57185025-de92-43c4-a300-fa2682993d15@oss.qualcomm.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <57185025-de92-43c4-a300-fa2682993d15@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c05a9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cU64Vy8aRm7zh7syVn4A:9 a=QEXdDO2ut3YA:10
 a=1D97j8aAK20nWj_7C5gA:9 a=Kf36ZmFW4aUABqfx:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfXx/cvDWyiCMYu
 +kAl0xr9u2/gGW/RJyoot0YknNhhRfA26EoJ/ELzUYD+qkpF6/zsgWnMmoSWJWydPIlWbsgGlHZ
 WwQ21Q5THVA2RgjlBM0EwjaQHRDqO2Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX/IOZWw/g0Kgs
 /GQJrNU0WA+Nw/UTfvPuHzR/ElF74/pDPDwdONZNbU8C7JiRSPMBTEB3zU2n1W1cmBFCxPtwyal
 tw/uXW+aUH60ySMtDQxkOfzPnW3S7ADfHrrHlAfAdrbMPiuzVWPgygN+OuzFF023tdf7drxkoBe
 jWHpl+pPLN+f7OdKIE+rthw1n1FLqbZvBcBL1DoFn0i8fFZ3lDFMAr7e0+CFRIZ0sPCvsTtlJfJ
 S711SAtaMjzMilq9CQDThnoF07/9MGOFN4u0Us+MJCo7YSZVvXzALBa0tjqH967NGg7A6XcNxGO
 hXLFvqTADxOVrewAZzCf9D6p19SfpxBUodKPVV8eaWmFdsSHuh9VURRHH1TrdLUaogPEaODINRo
 qw9OSF3UmukxMRjQHZkgGG39TUlPXl6UWHVA+wvC//ZR5NNLPJijFv5dFvX0KzJOIgpZzOCKtXe
 s6AbWti2AzNL/RPSO2g==
X-Proofpoint-ORIG-GUID: jhHuDzahFb4kwGy-Bfwmt0PAwqQ27ppv
X-Proofpoint-GUID: jhHuDzahFb4kwGy-Bfwmt0PAwqQ27ppv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240077
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

This is a multi-part message in MIME format.
--------------SzWFdw2I1iH1JqLFwQNlgPCO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/20/2026 1:10 PM, Ekansh Gupta wrote:
> On 14-08-2026 15:49, Jianping Li wrote:
>> Allocating and freeing Audio PD memory from userspace is unsafe because
>> the kernel cannot reliably determine when the DSP has finished using the
>> memory. Userspace may free buffers while they are still in use by the DSP,
>> and remote free requests cannot be safely trusted.
>>
>> Additionally, the current implementation allows userspace to repeatedly
>> grow the Audio PD heap, but does not support shrinking it. This can lead
>> to unbounded memory usage over time, effectively causing a memory leak.
>>
>> Fix this by allocating the entire Audio PD reserved-memory region during
>> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
>> userspace-controlled alloc/free and ensures that memory is reclaimed only
>> when the DSP process is torn down.
>>
>> The reserved-memory region is now mandatory for the Audio PD domain.
>> Rather than failing rpmsg probe when it is missing, validate it in
>> fastrpc_init_create_static_process() and reject only the static-process
>> creation. This keeps the fastrpc device probing for all other domains
>> even on a misconfigured device tree.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc:stable@kernel.org
>> Signed-off-by: Jianping Li<jianping.li@oss.qualcomm.com>
>> ---
>> Patch [v11]:https://lore.kernel.org/all/20260731093210.473-1-jianping.li@oss.qualcomm.com/
>>
>> Changes in v12:
>>   - Do not fail rpmsg probe when the reserved-memory region is missing,
>>     validate the region in fastrpc_init_create_static_process() instead,
>>     so probe keeps working for all domains.
>>   - Add fastrpc_domain_has_reserved_heap() / fastrpc_domain_uses_static_heap()
>>     helpers to replace the open-coded ADSP/SDSP domain checks.
>>
>> Changes in v11:
>>   - Replace the remote_heap fastrpc_buf pointer with dedicated
>>     remote_heap_addr and remote_heap_size fields in
>>     fastrpc_channel_ctx to avoid leaving a partially
>>     initialized fastrpc_buf.
>>
>>   - Drop ADSP_MMAP_REMOTE_HEAP_ADDR support from
>>     fastrpc_req_mmap() since the user process should no longer
>>     grow or shrink the Audio PD remote heap.
>>
>> Changes in v10:
>>   - Move Audio PD remote heap validation into
>>     fastrpc_rpmsg_probe().
>>
>>   - Treat Audio PD remote heap as a mandatory
>>     resource and fail probe if the reserved
>>     memory region is missing.
>>
>> Changes in v9:
>>   - Make sure fastrpc_init_create_static_process()
>>     only sets audio_init_mem to false when the sent
>>     address is actually invalid.
>> ---
>>   drivers/misc/fastrpc.c | 150 +++++++++++++++++++++--------------------
>>   1 file changed, 76 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 90fd669636ec..3f14a4673698 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -70,8 +70,6 @@
>>   #define ADSP_MMAP_HEAP_ADDR  4
>>   /* MAP static DMA buffer on DSP User PD */
>>   #define ADSP_MMAP_DMA_BUFFER  6
>> -/* Add memory to static PD pool protection thru hypervisor */
>> -#define ADSP_MMAP_REMOTE_HEAP_ADDR  8
>>   /* Add memory to userPD pool, for user heap */
>>   #define ADSP_MMAP_ADD_PAGES 0x1000
>>   /* Add memory to userPD pool, for LLC heap */
>> @@ -314,10 +312,14 @@ struct fastrpc_channel_ctx {
>>   	struct kref refcount;
>>   	/* Flag if dsp attributes are cached */
>>   	bool valid_attributes;
>> +	/* Flag if audio PD init mem was allocated */
>> +	bool audio_init_mem;
>> +	/* Audio PD reserved remote heap region */
>> +	phys_addr_t remote_heap_addr;
>> +	u64 remote_heap_size;
>>   	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>   	struct fastrpc_device *secure_fdevice;
>>   	struct fastrpc_device *fdevice;
>> -	struct fastrpc_buf *remote_heap;
>>   	struct list_head invoke_interrupted_mmaps;
>>   	bool secure;
>>   	bool unsigned_support;
>> @@ -1454,15 +1456,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	struct fastrpc_init_create_static init;
>>   	struct fastrpc_invoke_args *args;
>>   	struct fastrpc_phy_page pages[1];
>> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
>>   	char *name;
>>   	int err;
>> -	bool scm_done = false;
>>   	struct {
>>   		int client_id;
>>   		u32 namelen;
>>   		u32 pageslen;
>>   	} inbuf;
>>   	u32 sc;
>> +	unsigned long flags;
>> +	bool sent_heap = false;
>> +
>> +	if (!cctx->remote_heap_addr || !cctx->remote_heap_size) {
>> +		err = -ENOMEM;
>> +		dev_err(fl->sctx->dev,
>> +			"remote heap memory region is not added\n");
>> +		return err;
>> +	}
>>   
>>   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>   	if (!args)
>> @@ -1486,31 +1497,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	inbuf.client_id = fl->client_id;
>>   	inbuf.namelen = init.namelen;
>>   	inbuf.pageslen = 0;
>> -	if (!fl->cctx->remote_heap) {
>> -		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
>> -						&fl->cctx->remote_heap);
>> -		if (err)
>> -			goto err_name;
>> -
>> -		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>> -		if (fl->cctx->vmcount) {
>> -			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>> -
>> -			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>> -							(u64)fl->cctx->remote_heap->size,
>> -							&src_perms,
>> -							fl->cctx->vmperms, fl->cctx->vmcount);
>> -			if (err) {
>> -				dev_err(fl->sctx->dev,
>> -					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
>> -					&fl->cctx->remote_heap->dma_addr,
>> -					fl->cctx->remote_heap->size, err);
>> -				goto err_map;
>> -			}
>> -			scm_done = true;
>> -			inbuf.pageslen = 1;
>> -		}
>> -	}
>>   
>>   	fl->pd = USER_PD;
>>   
>> @@ -1522,8 +1508,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	args[1].length = inbuf.namelen;
>>   	args[1].fd = -1;
>>   
>> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>> -	pages[0].size = fl->cctx->remote_heap->size;
>> +	/*
>> +	 * Audio PD is a static PD and retains the remote heap
>> +	 * information across daemon restarts. Therefore only
>> +	 * the first attach should provide heap information to
>> +	 * DSP. Subsequent attaches reuse the previously
>> +	 * initialized memory pool.
>> +	 */
>> +	spin_lock_irqsave(&cctx->lock, flags);
>> +	if (!cctx->audio_init_mem) {
>> +		pages[0].addr = cctx->remote_heap_addr;
>> +		pages[0].size = cctx->remote_heap_size;
>> +		cctx->audio_init_mem = true;
>> +		inbuf.pageslen = 1;
>> +		sent_heap = true;
>> +	} else {
>> +		pages[0].addr = 0;
>> +		pages[0].size = 0;
>> +	}
>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>   
>>   	args[2].ptr = (u64)(uintptr_t) pages;
>>   	args[2].length = sizeof(*pages);
>> @@ -1541,27 +1544,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   
>>   	return 0;
>>   err_invoke:
>> -	if (fl->cctx->vmcount && scm_done) {
>> -		u64 src_perms = 0;
>> -		struct qcom_scm_vmperm dst_perms;
>> -		u32 i;
>> -
>> -		for (i = 0; i < fl->cctx->vmcount; i++)
>> -			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
>> -
>> -		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> -		dst_perms.perm = QCOM_SCM_PERM_RWX;
>> -		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>> -						(u64)fl->cctx->remote_heap->size,
>> -						&src_perms, &dst_perms, 1);
>> -		if (err)
>> -			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
>> -				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
>> +	if (sent_heap) {
>> +		spin_lock_irqsave(&cctx->lock, flags);
>> +		cctx->audio_init_mem = false;
>> +		spin_unlock_irqrestore(&cctx->lock, flags);
>>   	}
>> -err_map:
>> -	fastrpc_buf_free(fl->cctx->remote_heap);
>> -	fl->cctx->remote_heap = NULL;
>> -err_name:
>>   	kfree(name);
>>   err:
>>   	kfree(args);
>> @@ -2090,7 +2077,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>>   	if (copy_from_user(&req, argp, sizeof(req)))
>>   		return -EFAULT;
>>   
>> -	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
>> +	if (req.flags != ADSP_MMAP_ADD_PAGES) {
>>   		dev_err(dev, "flag not supported 0x%x\n", req.flags); return -EINVAL; @@ -2101,10 +2088,7 @@ static int 
>> fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp) return 
>> -EINVAL; } - if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) - err = 
>> fastrpc_remote_heap_alloc(fl, dev, req.size, &buf); - else - err = 
>> fastrpc_buf_alloc(fl, dev, req.size, &buf); + err = 
>> fastrpc_buf_alloc(fl, dev, req.size, &buf); if (err) { dev_err(dev, "failed to allocate buffer\n");
>> @@ -2143,20 +2127,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>>   	/* let the client know the address to use */
>>   	req.vaddrout = rsp_msg.vaddr;
>>   
>> -	/* Add memory to static PD pool, protection thru hypervisor */
>> -	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
>> -		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>> -
>> -		err = qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
>> -			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
>> -		if (err) {
>> -			dev_err(fl->sctx->dev,
>> -				"Failed to assign memory dma_addr %pad size 0x%llx err %d",
>> -				&buf->dma_addr, buf->size, err);
>> -			goto err_assign;
>> -		}
>> -	}
>> -
>>   	spin_lock(&fl->lock);
>>   	list_add_tail(&buf->node, &fl->mmaps);
>>   	spin_unlock(&fl->lock);
>> @@ -2537,6 +2507,16 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
>>   	{},
>>   };
>>   
>> +static bool fastrpc_domain_has_reserved_heap(u32 domain_id)
>> +{
>> +	return domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID;
>> +}
>> +
>> +static bool fastrpc_domain_uses_static_heap(u32 domain_id)
>> +{
>> +	return domain_id == ADSP_DOMAIN_ID;
>> +}
> any reason to have functions for one time used checks?> +

Just to give some context: I added these helpers based on the v11
review, which requested replacing the open-coded ADSP/SDSP checks
with functions describing the per-domain capabilities.

In this patch, they currently have a single caller each.
Therefore, if you feel it's unnecessary, I can revert
to the version without helpers.

>>   static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   {
>>   	struct device *rdev = &rpdev->dev;
>> @@ -2584,20 +2564,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		}
>>   	}
>>   
>> -	if (domain_id == SDSP_DOMAIN_ID) {
>> +	if (fastrpc_domain_has_reserved_heap(domain_id)) {
>>   		struct resource res;
>>   		u64 src_perms;
>>   
>>   		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>>   		if (!err) {
>> +			if (fastrpc_domain_uses_static_heap(domain_id)) {
>> +				data->remote_heap_addr = res.start;
>> +				data->remote_heap_size = resource_size(&res);
>> +			}
>>   			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>   
>>   			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>>   				    data->vmperms, data->vmcount);
> better to check vmcount before calling this>  			if (err)

Agreed. I'll wrap the qcom_scm_assign_mem() call in if (data->vmcount) in v13.

>>   				goto err_free_data;
>> +		} else {
>> +			err = 0;
>>   		}
>> -
>>   	}
>>   
>>   	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>> @@ -2681,6 +2666,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>   	struct fastrpc_buf *buf, *b;
>>   	struct fastrpc_user *user;
>>   	unsigned long flags;
>> +	int err, i;
>>   
>>   	/* No invocations past this point */
>>   	spin_lock_irqsave(&cctx->lock, flags);
>> @@ -2698,8 +2684,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>   	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>>   		list_del(&buf->node);
>>   
>> -	if (cctx->remote_heap)
>> -		fastrpc_buf_free(cctx->remote_heap);
>> +	if (cctx->remote_heap_size && cctx->vmcount) {
>> +		u64 src_perms = 0;
>> +		struct qcom_scm_vmperm dst_perms;
>> +
>> +		for (i = 0; i < cctx->vmcount; i++)
>> +			src_perms |= BIT(cctx->vmperms[i].vmid);
>> +
>> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
>> +
>> +		err = qcom_scm_assign_mem(cctx->remote_heap_addr,
>> +					  cctx->remote_heap_size, &src_perms,
>> +					  &dst_perms, 1);
>> +		if (err)
>> +			dev_err(&rpdev->dev,
>> +				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
>> +				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
>> +	}
>>   
>>   	of_platform_depopulate(&rpdev->dev);
>>   
--------------SzWFdw2I1iH1JqLFwQNlgPCO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/20/2026 1:10 PM, Ekansh Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:57185025-de92-43c4-a300-fa2682993d15@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">On 14-08-2026 15:49, Jianping Li wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Allocating and freeing Audio PD memory from userspace is unsafe because
the kernel cannot reliably determine when the DSP has finished using the
memory. Userspace may free buffers while they are still in use by the DSP,
and remote free requests cannot be safely trusted.

Additionally, the current implementation allows userspace to repeatedly
grow the Audio PD heap, but does not support shrinking it. This can lead
to unbounded memory usage over time, effectively causing a memory leak.

Fix this by allocating the entire Audio PD reserved-memory region during
rpmsg probe and tying its lifetime to the rpmsg channel. This removes
userspace-controlled alloc/free and ensures that memory is reclaimed only
when the DSP process is torn down.

The reserved-memory region is now mandatory for the Audio PD domain.
Rather than failing rpmsg probe when it is missing, validate it in
fastrpc_init_create_static_process() and reject only the static-process
creation. This keeps the fastrpc device probing for all other domains
even on a misconfigured device tree.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@kernel.org">stable@kernel.org</a>
Signed-off-by: Jianping Li <a class="moz-txt-link-rfc2396E" href="mailto:jianping.li@oss.qualcomm.com">&lt;jianping.li@oss.qualcomm.com&gt;</a>
---
Patch [v11]: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260731093210.473-1-jianping.li@oss.qualcomm.com/">https://lore.kernel.org/all/20260731093210.473-1-jianping.li@oss.qualcomm.com/</a>

Changes in v12:
 - Do not fail rpmsg probe when the reserved-memory region is missing,
   validate the region in fastrpc_init_create_static_process() instead,
   so probe keeps working for all domains.
 - Add fastrpc_domain_has_reserved_heap() / fastrpc_domain_uses_static_heap()
   helpers to replace the open-coded ADSP/SDSP domain checks.

Changes in v11:
 - Replace the remote_heap fastrpc_buf pointer with dedicated
   remote_heap_addr and remote_heap_size fields in
   fastrpc_channel_ctx to avoid leaving a partially
   initialized fastrpc_buf.

 - Drop ADSP_MMAP_REMOTE_HEAP_ADDR support from
   fastrpc_req_mmap() since the user process should no longer
   grow or shrink the Audio PD remote heap.

Changes in v10:
 - Move Audio PD remote heap validation into
   fastrpc_rpmsg_probe().

 - Treat Audio PD remote heap as a mandatory
   resource and fail probe if the reserved
   memory region is missing.

Changes in v9:
 - Make sure fastrpc_init_create_static_process()
   only sets audio_init_mem to false when the sent
   address is actually invalid.
---
 drivers/misc/fastrpc.c | 150 +++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 74 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec..3f14a4673698 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -70,8 +70,6 @@
 #define ADSP_MMAP_HEAP_ADDR  4
 /* MAP static DMA buffer on DSP User PD */
 #define ADSP_MMAP_DMA_BUFFER  6
-/* Add memory to static PD pool protection thru hypervisor */
-#define ADSP_MMAP_REMOTE_HEAP_ADDR  8
 /* Add memory to userPD pool, for user heap */
 #define ADSP_MMAP_ADD_PAGES 0x1000
 /* Add memory to userPD pool, for LLC heap */
@@ -314,10 +312,14 @@ struct fastrpc_channel_ctx {
 	struct kref refcount;
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
+	/* Flag if audio PD init mem was allocated */
+	bool audio_init_mem;
+	/* Audio PD reserved remote heap region */
+	phys_addr_t remote_heap_addr;
+	u64 remote_heap_size;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct fastrpc_buf *remote_heap;
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
@@ -1454,15 +1456,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
+	struct fastrpc_channel_ctx *cctx = fl-&gt;cctx;
 	char *name;
 	int err;
-	bool scm_done = false;
 	struct {
 		int client_id;
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
 	u32 sc;
+	unsigned long flags;
+	bool sent_heap = false;
+
+	if (!cctx-&gt;remote_heap_addr || !cctx-&gt;remote_heap_size) {
+		err = -ENOMEM;
+		dev_err(fl-&gt;sctx-&gt;dev,
+			"remote heap memory region is not added\n");
+		return err;
+	}
 
 	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
 	if (!args)
@@ -1486,31 +1497,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	inbuf.client_id = fl-&gt;client_id;
 	inbuf.namelen = init.namelen;
 	inbuf.pageslen = 0;
-	if (!fl-&gt;cctx-&gt;remote_heap) {
-		err = fastrpc_remote_heap_alloc(fl, fl-&gt;sctx-&gt;dev, init.memlen,
-						&amp;fl-&gt;cctx-&gt;remote_heap);
-		if (err)
-			goto err_name;
-
-		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
-		if (fl-&gt;cctx-&gt;vmcount) {
-			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-			err = qcom_scm_assign_mem(fl-&gt;cctx-&gt;remote_heap-&gt;dma_addr,
-							(u64)fl-&gt;cctx-&gt;remote_heap-&gt;size,
-							&amp;src_perms,
-							fl-&gt;cctx-&gt;vmperms, fl-&gt;cctx-&gt;vmcount);
-			if (err) {
-				dev_err(fl-&gt;sctx-&gt;dev,
-					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
-					&amp;fl-&gt;cctx-&gt;remote_heap-&gt;dma_addr,
-					fl-&gt;cctx-&gt;remote_heap-&gt;size, err);
-				goto err_map;
-			}
-			scm_done = true;
-			inbuf.pageslen = 1;
-		}
-	}
 
 	fl-&gt;pd = USER_PD;
 
@@ -1522,8 +1508,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl-&gt;cctx-&gt;remote_heap-&gt;dma_addr;
-	pages[0].size = fl-&gt;cctx-&gt;remote_heap-&gt;size;
+	/*
+	 * Audio PD is a static PD and retains the remote heap
+	 * information across daemon restarts. Therefore only
+	 * the first attach should provide heap information to
+	 * DSP. Subsequent attaches reuse the previously
+	 * initialized memory pool.
+	 */
+	spin_lock_irqsave(&amp;cctx-&gt;lock, flags);
+	if (!cctx-&gt;audio_init_mem) {
+		pages[0].addr = cctx-&gt;remote_heap_addr;
+		pages[0].size = cctx-&gt;remote_heap_size;
+		cctx-&gt;audio_init_mem = true;
+		inbuf.pageslen = 1;
+		sent_heap = true;
+	} else {
+		pages[0].addr = 0;
+		pages[0].size = 0;
+	}
+	spin_unlock_irqrestore(&amp;cctx-&gt;lock, flags);
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1541,27 +1544,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	return 0;
 err_invoke:
-	if (fl-&gt;cctx-&gt;vmcount &amp;&amp; scm_done) {
-		u64 src_perms = 0;
-		struct qcom_scm_vmperm dst_perms;
-		u32 i;
-
-		for (i = 0; i &lt; fl-&gt;cctx-&gt;vmcount; i++)
-			src_perms |= BIT(fl-&gt;cctx-&gt;vmperms[i].vmid);
-
-		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
-		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl-&gt;cctx-&gt;remote_heap-&gt;dma_addr,
-						(u64)fl-&gt;cctx-&gt;remote_heap-&gt;size,
-						&amp;src_perms, &amp;dst_perms, 1);
-		if (err)
-			dev_err(fl-&gt;sctx-&gt;dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
-				&amp;fl-&gt;cctx-&gt;remote_heap-&gt;dma_addr, fl-&gt;cctx-&gt;remote_heap-&gt;size, err);
+	if (sent_heap) {
+		spin_lock_irqsave(&amp;cctx-&gt;lock, flags);
+		cctx-&gt;audio_init_mem = false;
+		spin_unlock_irqrestore(&amp;cctx-&gt;lock, flags);
 	}
-err_map:
-	fastrpc_buf_free(fl-&gt;cctx-&gt;remote_heap);
-	fl-&gt;cctx-&gt;remote_heap = NULL;
-err_name:
 	kfree(name);
 err:
 	kfree(args);
@@ -2090,7 +2077,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&amp;req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES &amp;&amp; req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES) {
 		dev_err(dev, "flag not supported 0x%x\n<a class="moz-txt-link-rfc2396E" href="mailto:,req.flags);return-EINVAL;@@-2101,10+2088,7@@staticintfastrpc_req_mmap(structfastrpc_user*fl,char__user*argp)return-EINVAL;}-if(req.flags==ADSP_MMAP_REMOTE_HEAP_ADDR)-err=fastrpc_remote_heap_alloc(fl,dev,req.size,&amp;buf);-else-err=fastrpc_buf_alloc(fl,dev,req.size,&amp;buf);+err=fastrpc_buf_alloc(fl,dev,req.size,&amp;buf);if(err){dev_err(dev,">", req.flags);
 
 		return -EINVAL;
@@ -2101,10 +2088,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
-		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &amp;buf);
-	else
-		err = fastrpc_buf_alloc(fl, dev, req.size, &amp;buf);
+	err = fastrpc_buf_alloc(fl, dev, req.size, &amp;buf);
 
 	if (err) {
 		dev_err(dev, "</a>failed to allocate buffer\n");
@@ -2143,20 +2127,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
 
-	/* Add memory to static PD pool, protection thru hypervisor */
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR &amp;&amp; fl-&gt;cctx-&gt;vmcount) {
-		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-		err = qcom_scm_assign_mem(buf-&gt;dma_addr, (u64)buf-&gt;size,
-			&amp;src_perms, fl-&gt;cctx-&gt;vmperms, fl-&gt;cctx-&gt;vmcount);
-		if (err) {
-			dev_err(fl-&gt;sctx-&gt;dev,
-				"Failed to assign memory dma_addr %pad size 0x%llx err %d",
-				&amp;buf-&gt;dma_addr, buf-&gt;size, err);
-			goto err_assign;
-		}
-	}
-
 	spin_lock(&amp;fl-&gt;lock);
 	list_add_tail(&amp;buf-&gt;node, &amp;fl-&gt;mmaps);
 	spin_unlock(&amp;fl-&gt;lock);
@@ -2537,6 +2507,16 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
 	{},
 };
 
+static bool fastrpc_domain_has_reserved_heap(u32 domain_id)
+{
+	return domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID;
+}
+
+static bool fastrpc_domain_uses_static_heap(u32 domain_id)
+{
+	return domain_id == ADSP_DOMAIN_ID;
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">any reason to have functions for one time used checks?&gt; +</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Just to give some context: I added these helpers based on the v11
review, which requested replacing the open-coded ADSP/SDSP checks
with functions describing the per-domain capabilities.

In this patch, they currently have a single caller each.
Therefore, if you feel it's unnecessary, I can revert
to the version without helpers.</pre>
    <blockquote type="cite"
      cite="mid:57185025-de92-43c4-a300-fa2682993d15@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &amp;rpdev-&gt;dev;
@@ -2584,20 +2564,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
+	if (fastrpc_domain_has_reserved_heap(domain_id)) {
 		struct resource res;
 		u64 src_perms;
 
 		err = of_reserved_mem_region_to_resource(rdev-&gt;of_node, 0, &amp;res);
 		if (!err) {
+			if (fastrpc_domain_uses_static_heap(domain_id)) {
+				data-&gt;remote_heap_addr = res.start;
+				data-&gt;remote_heap_size = resource_size(&amp;res);
+			}
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&amp;res), &amp;src_perms,
 				    data-&gt;vmperms, data-&gt;vmcount);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">better to check vmcount before calling this&gt;  			if (err)</pre>
    </blockquote>
    <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
    <div
style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
      <pre wrap="" class="moz-quote-pre">Agreed. I'll wrap the qcom_scm_assign_mem() call in if (data-&gt;vmcount) in v13.</pre>
    </div>
    <blockquote type="cite"
      cite="mid:57185025-de92-43c4-a300-fa2682993d15@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 				goto err_free_data;
+		} else {
+			err = 0;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev-&gt;of_node, "qcom,non-secure-domain"));
@@ -2681,6 +2666,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err, i;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&amp;cctx-&gt;lock, flags);
@@ -2698,8 +2684,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &amp;cctx-&gt;invoke_interrupted_mmaps, node)
 		list_del(&amp;buf-&gt;node);
 
-	if (cctx-&gt;remote_heap)
-		fastrpc_buf_free(cctx-&gt;remote_heap);
+	if (cctx-&gt;remote_heap_size &amp;&amp; cctx-&gt;vmcount) {
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+
+		for (i = 0; i &lt; cctx-&gt;vmcount; i++)
+			src_perms |= BIT(cctx-&gt;vmperms[i].vmid);
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+		err = qcom_scm_assign_mem(cctx-&gt;remote_heap_addr,
+					  cctx-&gt;remote_heap_size, &amp;src_perms,
+					  &amp;dst_perms, 1);
+		if (err)
+			dev_err(&amp;rpdev-&gt;dev,
+				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
+				&amp;cctx-&gt;remote_heap_addr, cctx-&gt;remote_heap_size, err);
+	}
 
 	of_platform_depopulate(&amp;rpdev-&gt;dev);
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------SzWFdw2I1iH1JqLFwQNlgPCO--
