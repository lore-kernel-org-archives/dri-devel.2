Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C3C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F99710E2D6;
	Tue,  7 Jul 2026 11:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHpQ2wBx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Js9W0QsT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40EB10E2D6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:21:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DcSu3076610
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 11:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nq1QLoA0VSvOC8P3D7v4RJn736LoYibRkgnYt4FncB8=; b=bHpQ2wBxXoD70CUH
 /Pnbk+IatHQNXB1+7Rl0nbAo3o9SF6FtiXPp5oePUlfdMLNfB5j1ZVVQaIEM7Q2p
 nTkFH8fOEE9VaeuD/+Jo3GZym4t/tCpxO34CV9ZmZF+/obVCoOhCOCZKSyb6w09f
 Zo/h0bx1kueLdh8a3PUNM+zFLbKqJiIWjaSuVhHqUvcxNJkptFQt6WLgITJNRD7v
 kRJfUtUq8+vJ104T0XqU4FBDsPIYo4UTm+/NQRbn3SyYmBx7z4M8V6ZaNTNVBkEf
 0lm2WJKDz1/ifQwxMsEqkcSXKKtsRUc9bmN4AendxR++BFrTK4MnHp0fBt+ZBaxR
 Gv0BLg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun0yy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 11:21:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8478a1ec69fso6096462b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783423262; x=1784028062;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nq1QLoA0VSvOC8P3D7v4RJn736LoYibRkgnYt4FncB8=;
 b=Js9W0QsTT3fa0IwED/FfdlhjWyx07cSjkkQ1BYnCxE3Hy3eq912zBP3GEp+1eqT5HV
 P7QB4vemipagsTn2nqawsqwrnNtR0gPPBLtYLrmIK1UpSC+BLCTygo2c6NCC11+ONEaY
 Z7TaeOtDDVxRMRIFgXviSSP85o9briEYL5TE316BY4znzUxaCPbV3cbmpmXvAMSKx96p
 6PilsNK6IyVhy5XWqJBNIJCU/EgAQQcuS524dsI91ZUt5KVYDKIaVhqD9+/kPjNzNOc2
 fLKQZRP1skTudRBE0LgK59P+KTSnTd6rsfC/hesZs9rEuXocjXScXrz+nRcV09JZsrlT
 UdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783423262; x=1784028062;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nq1QLoA0VSvOC8P3D7v4RJn736LoYibRkgnYt4FncB8=;
 b=idegLzq0b6F40zpr8tV14zQp5wd2o3ug6TjlcV1FcKVDX6kbTSmWrHbLz7m28BLfT7
 l1lWny/upwLjRoyHoET0FsnXS2GEfQ2HqajGy9YUseZg/CbPiEaqt+PUt7nW6x0PXDMt
 6jlIlisgsbhIAPLGdvO4bcTEFMJ1KvZQFFv5t/HeQgOQwv5kOTJJ19nWYPpVthCD1Yeg
 JIroXc1NmNs6hu2Kg7P1XaMLJT3KN+csoFRgp0JBttRA5DBTWnYgSiLKotdeT0E4vyQR
 DOwA3JKFPkir/91CiDvs4IUBbAcJPx29pAxqz97KGjf+so0D6M9YrXBaUNuvytnXbVm2
 sTGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfzkGBKv+PJXkW2KJsdwC+8kZfBMqvsGccs9uemv8dT2LSES9rLMl0qvrYmSBRDvyXxyfKO5TBL/M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgBOH+ktcmKrnXckBiGvz+dBbl0NszB2XgP6l9eDYyBz3hGMoP
 7pAQOnMWiwJ1x+IWbYb0jWWU6/M+T50IwDQBTKd+1M9suZDiBbne1Bx/BZZMSFQcUcSUILm13CU
 NaF01EVH5Nna+KAR+/sJHb+2iVfFw1U0xTTyFkLq9PGlbqBVqJrYpInLFKOfNAgUTumYOBjg=
X-Gm-Gg: AfdE7clOVAdP35Cezt2cftX1KJKuewS1bwhQWwo2JFZEE/S9hg01QQWNBRLUhDXTntD
 TqrrxctaQuXBAmbZW/E83EvcASuJyqUP52DG82+tpH7Tjq53480oH+cH3vn0tJf8uCnBlMDf78q
 I1kbVG9+Ke4fx+ZUYh9Njwzg2IEqFkqzaBRFjivb6dcc94AUVJbCSqbIacWwk61LxGsj+A4wypM
 7l7cnYD9x0dqYJHyP1EwiYcv4/0SBgBwOZd2zEQ9AcVRnGwiljuZveiTywFqSeOkvxiCEZzM+DO
 p/GcRbxzhqMDedM7oGOxUBTM1QXTawgmOt6IMzMZNimdYO20VAwcTPgyp1wbcUTrD9UcRgi0Ryz
 8AiP9h4ULJ228tu8TY/QmRsMB1aLV6QeGgTBJVuetwkcf5VnJba19N8d2OSQOVwhPB3WU8BtnuY
 hm/7x7rA==
X-Received: by 2002:a05:6a00:12d3:b0:845:bcf0:118 with SMTP id
 d2e1a72fcca58-84826d6944fmr4511771b3a.41.1783423262272; 
 Tue, 07 Jul 2026 04:21:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d3:b0:845:bcf0:118 with SMTP id
 d2e1a72fcca58-84826d6944fmr4511737b3a.41.1783423261662; 
 Tue, 07 Jul 2026 04:21:01 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b609b8sm5301243b3a.5.2026.07.07.04.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 04:21:01 -0700 (PDT)
Message-ID: <b1aac20f-0f12-4870-b224-eb6dea43df96@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 19:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
References: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
 <6de7ec43-5757-43f0-b8d8-34a692a36d1b@kernel.org>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <6de7ec43-5757-43f0-b8d8-34a692a36d1b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwOSBTYWx0ZWRfX6ZifvhjODXj+
 TPdRzLw5o1ZvPV4sM6LteeNaBj+PLzfwzQbr4HPCQYkUWnaRxr20pLE9//9HZl+fDlR1yva8875
 CU0gfpZd7m2jOGuU8TA88tiLkDZARdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwOSBTYWx0ZWRfX+B3yKRAmfayy
 bPPDyuSEZJfqgZY/ZIHAMZfW6HChioSG5YB0mdkK2xm12+MUNiZ+vF4Uob9awFFsQ4C227/HQlk
 PrFcl4tAYIhVebAJQvV7dIwJnZAj0BfvPoxIhfdpkbH0CGy0SDLaIitzfHjE04hB8FQ7HMFUwcG
 QN9M1R+EEjJ5985+w5qBhmQcCbi/pDguCw3aYLFZ12DsOVVQzg+ToYBlJWIk1rr5yka3N+kjJ63
 sldbw9kQp1sGb0tvED8lTyLUp/I1GLF1J3X0v35TyUMEETIfHTyBI4BOeW1iiNzxVyMWFQz/SYw
 iv5Jz7uo+mptO/xH2ZneGSzSZ1a0Qwjro3j62DdrBEcHb/QzCEffgt5joxUyNdggTOq7f9YCPdh
 Z44j/YQNT4vzO89xoVall/ZwCkLjMPaoZYns75Adl6FDXAaduskzW7+amre+qfol45zHv2plMRL
 Ee+kirJN3F7Sn7p5mAg==
X-Proofpoint-GUID: FlvPMFHgKYQUIbr-YRrXB2JeMe7tHoQe
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4ce11f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TyUosIf-LwrC6SAVHe0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: FlvPMFHgKYQUIbr-YRrXB2JeMe7tHoQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070109
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


On 7/7/2026 3:23 PM, Srinivas Kandagatla wrote:
>
> On 7/7/26 7:17 AM, Jianping Li wrote:
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
>> Add explicit validation for remote_heap presence and size before sending
>> the memory to DSP, and fail early if the reserved-memory region is
>> missing or incomplete.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 119 +++++++++++++++++++++++------------------
>>   1 file changed, 66 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index d86e79134c68..1ec37e6c68a2 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>>   	struct kref refcount;
>>   	/* Flag if dsp attributes are cached */
>>   	bool valid_attributes;
>> +	/* Flag if audio PD init mem was allocated */
>> +	bool audio_init_mem;
>>   	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>   	struct fastrpc_device *secure_fdevice;
>>   	struct fastrpc_device *fdevice;
>> @@ -1344,15 +1346,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
>> +
>> +	if (!cctx->remote_heap || !cctx->remote_heap->dma_addr ||
>> +	    !cctx->remote_heap->size) {
> if remote heap is a mandatory for ADSP or SDSP then this should be
> enforced at binding level and even at driver probe level.

Agreed. In v10 I will:

   - Move the enforcement into fastrpc_rpmsg_probe(): if
     of_reserved_mem_region_to_resource() fails for an ADSP
     node, probe fails up-front instead of deferring the error to the
     user-space attach path.
   - Drop this runtime check in fastrpc_init_create_static_process()
     entirely, since the invariant is now established at probe time.

>
>> +		err = -ENOMEM;
>> +		dev_err(fl->sctx->dev,
>> +			"remote heap memory region is not added\n");
>> +		return err;
>> +	}
>>   
>>   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>   	if (!args)
>> @@ -1376,31 +1387,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
>> @@ -1412,8 +1398,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
>> +		pages[0].addr = cctx->remote_heap->dma_addr;
>> +		pages[0].size = cctx->remote_heap->size;
>> +		cctx->audio_init_mem = true;
>> +		inbuf.pageslen = 1;
>> +	} else {
>> +		pages[0].addr = 0;
>> +		pages[0].size = 0;
>> +	}
>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>   
>>   	args[2].ptr = (u64)(uintptr_t) pages;
>>   	args[2].length = sizeof(*pages);
>> @@ -1431,27 +1433,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
>> -	}
>> -err_map:
>> -	fastrpc_buf_free(fl->cctx->remote_heap);
>> -	fl->cctx->remote_heap = NULL;
>> -err_name:
>> +	cctx->audio_init_mem = false;
> You are ignoring my comments that I have provided in the last version.

Apologies for the delay in addressing this — you're right, the 
unconditional reset is buggy. The concrete failure mode is: 1. First 
invoke sends pages=(phys, size) and succeeds. DSP now owns the heap, 
audio_init_mem = true. 2. Second invoke sees the flag set, sends 
pages=(0, 0), and fails. Because no pages were added in this call, the 
DSP does not drop the region on its side. 3. Current code resets 
audio_init_mem to false unconditionally, so the third invoke re-sends 
(phys, size) and the same region gets registered with the DSP twice. 
Fixed in v10 by only clearing the flag when this invocation was the one 
that actually carried the heap information: err_invoke: if 
(pages[0].addr) cctx->audio_init_mem = false; That is: - first invoke 
failed -> pages[0].addr != 0 -> clear the flag, allow a retry to re-send 
the region. - later invoke failed with (0, 0) -> pages[0].addr == 0 -> 
leave the flag as-is, so we don't re-register the same region. Please 
let me know if you'd prefer a stronger scheme.

>
>>   	kfree(name);
>>   err:
>>   	kfree(args);
>> @@ -2418,12 +2400,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		}
>>   	}
>>   
>> -	if (domain_id == SDSP_DOMAIN_ID) {
>> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>>   		struct resource res;
>>   		u64 src_perms;
>>   
>>   		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>>   		if (!err) {
>> +			if (domain_id == ADSP_DOMAIN_ID) {
>> +				data->remote_heap =
>> +					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
>> +				if (!data->remote_heap) {
>> +					err = -ENOMEM;
>> +					goto err_free_data;
>> +				}
>> +
>> +				data->remote_heap->dma_addr = res.start;
>> +				data->remote_heap->size = resource_size(&res);
>> +			}
>>   			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>   
>>   			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>> @@ -2431,7 +2424,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   			if (err)
>>   				goto err_free_data;
>>   		}
>> -
>>   	}
>>   
>>   	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>> @@ -2490,6 +2482,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		misc_deregister(&data->secure_fdevice->miscdev);
>>   
>>   err_free_data:
>> +	kfree(data->remote_heap);
>>   	kfree(data);
>>   	return err;
>>   }
>> @@ -2512,6 +2505,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>   	struct fastrpc_buf *buf, *b;
>>   	struct fastrpc_user *user;
>>   	unsigned long flags;
>> +	int err;
>>   
>>   	/* No invocations past this point */
>>   	spin_lock_irqsave(&cctx->lock, flags);
>> @@ -2529,8 +2523,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>   	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>>   		list_del(&buf->node);
>>   
>> -	if (cctx->remote_heap)
>> -		fastrpc_buf_free(cctx->remote_heap);
>> +	if (cctx->remote_heap && cctx->vmcount) {
>> +		u64 src_perms = 0;
>> +		struct qcom_scm_vmperm dst_perms;
>> +
>> +		for (u32 i = 0; i < cctx->vmcount; i++)
>> +			src_perms |= BIT(cctx->vmperms[i].vmid);
>> +
>> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
>> +
>> +		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
>> +					  cctx->remote_heap->size, &src_perms,
>> +					  &dst_perms, 1);
>> +		if (err)
>> +			dev_err(&rpdev->dev,
>> +				"Failed to assign memory back to HLOS: dma_addr %pad size %#llx err %d\n",
>> +				&cctx->remote_heap->dma_addr, cctx->remote_heap->size, err);
>> +	}
>> +
>> +	kfree(cctx->remote_heap);
>> +	cctx->remote_heap = NULL;
>>   
>>   	of_platform_depopulate(&rpdev->dev);
>>   
