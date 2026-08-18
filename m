Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D525BC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1950810E36F;
	Tue, 18 Aug 2026 06:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2sYxbLV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eD0kAt9x";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7F910E36F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:26:03 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I4OM3Y3566540
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QpMSnfPhODIl1ejhgbQgYJBMEXQkyaJTdofbzdBjnW8=; b=f2sYxbLVVxHHE8ah
 BLL2hEOs11e8uGfhMGoJwcmplrDhvwX33dAV0qiWRM2gDpjxJVPos/JU02gMW9FC
 LXwzVEPGU7rJi5TIK5da9CVzvzkcJVuj6EHpmZzzxojPfowe4uWJw1vE56Kh38vH
 PpjZDe3+yq0qUA2tUIqzPDgLNB+qvDT0CvDtc8kuiXB875zbfvrZ0HBTaer95ILn
 iFiq1bXLOsrZHIspu9HOdT/hDYdagYLCnHuJc6s7BLHeQiteNQ8b7Dv4wzHpIzVF
 NbRytfgkQu+PFQ5J28BanMviMap2OBU3khIdZ3UoRxyndp/8zj7rcQHuopvzHk/C
 giU5Xw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0t8k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:26:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso7023878a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787034361; x=1787639161;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QpMSnfPhODIl1ejhgbQgYJBMEXQkyaJTdofbzdBjnW8=;
 b=eD0kAt9xQME7PCW0fCvZJ6FArTDBpfq6w4ml6Hq/ukGF1PB+M8JJ21t2PaEEKETBdb
 dLAHP8oND9Hov/V10/+ZDUaRsb2HFjq5FKZ1xIma4zE6OfmbYVu2EvDiUGEcZ2KVAxn0
 aCrELF7tF5nTjPksE1uED84T1tv0kLA/SEfzCSDS14wlMbxuk1wWr4/5eIRnWgF+nqI5
 Zb6uzmlHpYemZ2X71KJjbzX+T0XL1tBC8Lby669YZt4KMECE4C99JU5O+wCTqL404H+E
 8xfyQmPKTGEnpLG1EdRZyOQ2tWQhN7OG6Wp/4u+yK46mcB2fTwER96Ilx9g9ixtkScEG
 CZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787034361; x=1787639161;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QpMSnfPhODIl1ejhgbQgYJBMEXQkyaJTdofbzdBjnW8=;
 b=W9VJrMTU3mY/hmHMU5/z6s+4LhXdsaJUbkkS26BHHzsRe53ODg4IZoWeGHz811MT5v
 sVk2binei6fLzVLPlYsa96cTTrPiPHPGqRmpmd5YWK9JNULKjqDKE1pJsR6kcKP9YHzt
 CbjeqLIrXWFMcML+2x9CGTEzwCNlmebjGxdLPT81vFaOED0Yzcctf6Hk84lZCR7bcTUj
 Bmz0wS9LKn5HwpxtP9tlJcixPl2EiL4yZkQc4LA8HQBzb0OU2pJAy+p/VZISd+S+jxdZ
 06cmoIWFNN/1PEs9kJslRoeo3vmy85fTUqWzrlqQus2c54V8tkTx2oxe5Ws7Ix4TNAH9
 dlhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCgxrYEbzQupnzMOhwkRb0C8EgoMSJJCNargz82kRC3bBLT9jLFp1GOqWSNlZX3+IxrztleeDeZHI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqZIJjmelI+qxil3S+SjWNEz5Xds1OROcjlFY+fSxF5/VWT1Ks
 RImF1RlWctsnZPlFGj8omebVv7L1WJp6wmSQTUzIB0T81ARrM4jV3FSMiBcoEP1p14cnoFSomrX
 rQ9rzVpcB5dOjN+wvvJqWWLUL7BRnuy9nzaoeMAu8MDpFCvk3ROIvLGAsn5VDobrmXl4SSc0=
X-Gm-Gg: AR+sD10YBeIl5VlDiYdMx9A6iWxkHriyC2MtC6nuJaYmGiRocyqWZDxujgFjGMbU2UO
 OA1vzDEyLioRLVxiFqr9t92O5ISjXWA5bOMKagKiIip3QbuSPx6g4foPXz5wFVIcCGUXFsD1ppz
 MgUKM/cy/hVUpRuZNs2biIv8feTR6NJTIU0wEmtECCU9Q554ixRnHZIyHW33wZHODLUXc1kI1hA
 E9gOOJLnWmqSw/nZNjKZrwvqSRj3QtWh3EaDUosIKok+SKi+prrJfDi8WMQCqLE9RpnEgENvrP0
 z03BbnRTsN7Cb5+ezOMGeE5hrZFB8IsMglQ0xj0+rY/3d052tEVhvVpXMgDGc60EmbgRcfdcRCy
 cjcZS2XLnfAyjCflqiHOR9y0hjPOdHw==
X-Received: by 2002:a17:90b:48c1:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-3933b792c20mr35951563a91.9.1787034361270; 
 Mon, 17 Aug 2026 23:26:01 -0700 (PDT)
X-Received: by 2002:a17:90b:48c1:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-3933b792c20mr35951459a91.9.1787034360780; 
 Mon, 17 Aug 2026 23:26:00 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531ff679fsm7486482a91.14.2026.08.17.23.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 23:26:00 -0700 (PDT)
Message-ID: <c1da4243-36d1-4b65-a5da-f660ab8c63b3@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:55:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] accel/qda: Add PRIME DMA-BUF import support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
 <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfX3s7llJY+fvD1
 kgQxeW2qR5IdLMvTHZr7RzWPKzKeBR6avpsdTf/zhcfmB5BAKOfI/VTpjWkXl4R/mhlkeRpnrIp
 Pq5rgxt7pB/ifMfcmm9cXKXXNXVeyoI=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a83fafa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BHqhARD1X7WWxJJUoOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: g18oz6NnxWGDzz16ar1H9Cj6g7b7-33s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfX0C09LGq9q8YY
 cmUaKh0Z1FsG+X7tnQp3hWbif7YIY1vF4S4op4U6JdW/p3Jx01J9NYp63LkRSv9/J6O/RTc7Cg3
 pIhINRF3cJ2DbaUNHEwUPHkYuv9JWLigcLT7B6ByfWj6e7B3ekvIdt3JMvEQAhjC4AFwCr5F7BV
 OaHuPnlZ1ASO9uf53yeuA+59CDYCIGRrkrOuG3UmXFQKm01hD2ic3spNTGCWCu2dbhiMxzaUvQw
 v3OXvTj/8u2bV6DVsnR9ecNoS17qikTqGzspVo8bjRgMt2xBtc/JsFG9Cvt4nZb3SshI4y0K200
 7w9cUDai4wpDMinmPZvkI7I96iJDgn/fyUmqiZDRMvLTG1mHIqty8ArhIORPgo5zYi/z/fF4IVJ
 DDJjmKgTCDYh3jYAm+fnfKBXQoJ+jk2r+BFXTK5uHf8A/RspwReLTBAd1LZAr34cU5d0Ut2nqSj
 Ma8tbu8L+MB4Dtm514w==
X-Proofpoint-ORIG-GUID: g18oz6NnxWGDzz16ar1H9Cj6g7b7-33s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180046
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

On 18-08-2026 09:25, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:46AM +0530, Ekansh Gupta wrote:
>> Allow user-space to import DMA-BUF file descriptors from other
>> subsystems (GPU, camera, video) into the QDA driver via the standard
>> DRM PRIME interface.
>>
>> qda_prime.c
>>   Implements qda_gem_prime_import(), which is set as the driver's
>>   .gem_prime_import callback. On import it:
>>   1. Short-circuits self-import: if the dma_buf was exported by this
>>      device and is not itself an import, the existing GEM object is
>>      returned with an incremented reference count.
>>   2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
>>      dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
>>      DMA addresses are IOMMU virtual addresses in the CB device's
>>      address space.
>>   3. Calls qda_memory_manager_alloc() to record the mapping and encode
>>      the SID in the upper bits of the DMA address, matching the
>>      convention used for natively allocated buffers.
>>
>>   qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
>>   qdev->import_lock, storing the calling file_priv in
> 
> Why do you need a separate lock?
Will add details in commit message,
The lock serialises the `fd_to_handle → gem_prime_import` call so that
`current_import_file_priv` is valid for the duration of the import.
Without it, two concurrent imports could race and each see the other's
`file_priv`.
> 
>>   qdev->current_import_file_priv so that qda_gem_prime_import() can
>>   retrieve it (the .gem_prime_import callback does not receive
>>   file_priv directly, but the context bank to attach to is per-process).
>>
>> qda_gem.c
>>   qda_gem_free_object() is extended to handle the imported-buffer
>>   teardown path: unmap the sg_table, detach from the dma_buf, and
>>   release the dma_buf reference.
>>   qda_gem_mmap_obj() rejects mmap requests on imported objects, which
>>   must be mapped through the exporter instead.
>>
>> qda_memory_manager.c
>>   The DSP is given a single base address per buffer, so only buffers
>>   that are mapped as one contiguous range can be described to it.
> 
> Is there no IOMMU in front of the DSP? Can we remap the buffer to a
> linear are inside the DSP map?
The DSP firmware's buffer descriptor format carries a single
{base_address, size} pair per buffer and it does not support
scatter-gather or multi-entry page tables on its side. This is a
firmware interface constraint that we cannot change from the kernel. So
imported buffers must present as one contiguous IOVA range, and
non-contiguous ones are rejected.

Will add this information in commit message and during the check.>
>>   qda_memory_manager_map_imported() therefore walks the imported
>>   buffer's scatterlist and rejects any buffer whose entries are not
>>   contiguous; contiguous imports (for example from the CMA DMA-buf
>>   heap) are accepted. Whether an exporter or IOMMU coalesces a buffer
>>   into a single range is not guaranteed, so this is verified rather
>>   than assumed.
>>   qda_memory_manager_free() skips the DMA free path for imported
>>   buffers since the memory is owned by the exporter.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Do not assume the exporter or IOMMU maps an imported buffer as a
>>   single contiguous range; walk the scatterlist and cleanly reject
>>   non-contiguous imports instead (Christian König)
>> - Document that only contiguous imports (e.g. CMA DMA-buf heap) are
>>   supported
>> - Return -EBUSY rather than -ENODEV when no context bank is available
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  }
>>  
>> +static int qda_memory_manager_map_imported(struct qda_gem_obj *gem_obj,
>> +					   struct qda_iommu_device *iommu_dev)
>> +{
>> +	dma_addr_t dma_addr, expected_addr = 0;
>> +	struct scatterlist *sg, *s;
>> +	int i;
>> +
>> +	sg = gem_obj->sgt->sgl;
>> +
>> +	/*
>> +	 * Verify that the imported DMA-BUF is contiguous. While some platforms
> 
> Which "some platforms"?
I'll rewrite the comment to be precise.>
>> +	 * or IOMMUs might map buffers as a single range, we must not silently
>> +	 * assume this is always the case. We loop through the scatterlist
>> +	 * entries and reject any that are non-contiguous.
>> +	 */
> 

