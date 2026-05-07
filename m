Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C01CD37AC
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28E910F3C1;
	Fri,  8 May 2026 07:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="sC/HxRbj";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202C610E2A7
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 16:10:04 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646MX9nb3763922
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:10:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=eFG1vBkuGjV5WqwCWdKJSFjXXoeKLNuaVc0SsnohSl0=; b=sC/HxRbj/khP
 lauwqZ9En1m3PiufFWhk2MVi8NnVzUAemf9bI6F5CBdj1cHPIggkaXe2/+EQOCEU
 Qfst0vpp73IxZdukxzFpSLZ/U+7vQBDU5pepEIqV/Iud44cWwJgw12gI1g58sTtM
 KksXYFPHQ8h6CUL6YKHLFFteuLAoXy3X/XAZiCtRuXtKlenAOWQS4xrDbUZ67XKR
 BAi7ALQLC2NtDOk9eMoLHqLiIEvmiSJgtKCAHe7XRwq5NbKpCcUkRb+O1q4FcLKp
 jMlfnYMVmysh10DkwwgF9TodXhraCJ5gFNKqgDPilbYYJj3L3jdHUXWSyilWfZwb
 YMz6VepcRw==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx2we5fyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:10:03 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44696b11265so1128243f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170202; x=1778775002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eFG1vBkuGjV5WqwCWdKJSFjXXoeKLNuaVc0SsnohSl0=;
 b=Fo/dGGyCdx1kbg+WXqIymyjBAkN07kMQvsLgODtO6h5x7g4jm6Ea5s8e+B1TBsdeRx
 5P3xBmWdusV8K1oBakU41wvxB/K/OuUsWQr1V8UElZs8M1Gh50aNODtPmE8VkMygHrCV
 C9hUFXVnexYFN3/zg6BJjiBmjx31bxLpcmNt5rzm6oYgaS8Hr2VozIEs9buyamLarkim
 nJC24KrqzMeqO07kVDDKSgANzwWGQRZJpZjO6grNEAe+nYk9Ii4zuxMxx+PDdhPCRiud
 0mBHrJw8wavcfXS/sAc7nav2CGpZbd+NVIf84tM8qgl6b+M+39m8iEOHdp8WAd9TwibF
 PFJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8MnZxs/oxH1/8ih53WKES7mHZY6Lxk1QykstVJvG4vET5z5+3Tty/ieQN/WQT83qCBmMdMsphrwQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJRbZV2/9t64kaKm7iG25aordosjzSAYIlxqJqIxB0Ibq4SNip
 BrL+tGp4C86qvy7CKzk0ySUYzJpjOTVlu67+23pm2rlyi/JwNgSuFPnhoYiaqrT3LFQd2L+Ag+m
 RwkZ4zdDuCOCQMu6jibzVJ8YnqdoynI3fSDPmvSr2bOOu49OwKWlgs91+RBx8gf9Il4R9
X-Gm-Gg: AeBDieuOQIwa8x+UZBRlhwCGFAuu0fXkJbZKuDQY9uCo4tXAHDR5L0p+LN5nMVCj2J1
 JjhQUP8anWTbERnyIOp3W+tqDR6dUrZnBeNR9Cm9szm7/L6ktCbJro11obXQGcQtDwxLHSlZhGe
 SYZ9fYkULx492EuKJSB/ppCPaTpOxEDzGMfWSCa467IQirLmawO8/lpCCsWSckTrqXOkN88Cx2m
 fRwymSeVN53ZTk73cCjW+UI7hsIlpb+3wpECwGL6LTrkO2iwQdklmFqTvs9TI7OhVC3NY0VgXuP
 KbgPkLmN6axSZmX5gp15ggOPnfgFMVsaoy2uYtV7Je5n7Io4hYVdBCzIAxcpTVH+PX+CwizloFH
 Co+5Z8wZzwtSL7pDc2N3YmSjMVQb/PUZHkdrv+kJmseri2HVy7q6cxuWUD7Bq5aOlH6uDHsmrel
 M5m2uiIM7N6sz6Sq/8VPE/RNwOCQ1P7do43CTxV5utvFXOUEBGMLGjjZ5jikyREM+FZKvSJWTrp
 OjhFA25f2UdiNbY50829Tc=
X-Received: by 2002:a5d:5f47:0:b0:43d:613:33de with SMTP id
 ffacd0b85a97d-4515cf11d94mr13854420f8f.20.1778170201775; 
 Thu, 07 May 2026 09:10:01 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:43d:613:33de with SMTP id
 ffacd0b85a97d-4515cf11d94mr13854369f8f.20.1778170201226; 
 Thu, 07 May 2026 09:10:01 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45412820454sm149530f8f.6.2026.05.07.09.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 09:10:00 -0700 (PDT)
Message-ID: <2a75c858-5dfe-4b93-98fc-909a2ee5558d@meta.com>
Date: Thu, 7 May 2026 17:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-8-mattev@meta.com>
 <20260424183006.GI3444440@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424183006.GI3444440@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fLsJG5ae c=1 sm=1 tr=0 ts=69fcb95b cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=bfFL6uTa8VbwhnMIod8A:9 a=QEXdDO2ut3YA:10
 a=F7q00xkr9EfWfQvbdVXI:22
X-Proofpoint-GUID: HHOHaD2gQyHnDkTjceNmdaoiZVbW9sC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2MSBTYWx0ZWRfXwkkUntf3R7Qo
 3VOD8u54AxDL3s4y6vtiB+31esLc/6RGoAuM8K2qr8WB3CTMlDbjIB3YNE7In9+ziymEbP987WU
 yq2vEd0lGQ9ZTzxYHnrgT7w/86rXyXzi2kOL/8jJlfRHZkwnl/FS3Z4lwLhBqBsz+QNze9EknSN
 pBhCsyoqKgO3laWEaI2dIA/hTGIDOOD2kTtJbiXZNDqgIEkgesUeZ1c7pyocJP7KD2VR5v8N+Qr
 FGDvjsZyQhyVu6va5JlYVkyQTWTp6erfMd/Lzs8adPox/ptrn1zjXmqutqSZWSgHP0FEi8GyWy2
 XYO+KiRLddLKzDRqOEuYwER42a/2nuBWVZS+dTh4sQs9sETdY4wfU5aJtklALi2GcjVwaVJhHEy
 iUwDySv07LPZURm96WXxCL+rXYuM6CsMmHLjtDna0ikhOLhzRomugeSvCez/mZAUXIvwVZEw6Xk
 X8tbJHN7MctxASHxGUg==
X-Proofpoint-ORIG-GUID: HHOHaD2gQyHnDkTjceNmdaoiZVbW9sC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Mailman-Approved-At: Fri, 08 May 2026 07:55:51 +0000
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

Hi Jason,

On 24/04/2026 19:30, Jason Gunthorpe wrote:
> 
> On Thu, Apr 16, 2026 at 06:17:50AM -0700, Matt Evans wrote:
>> +
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>>   	vdev = READ_ONCE(priv->vdev);
>>
>> +	if (READ_ONCE(priv->revoked) || !vdev) {
> 
> Why is this read once? It is inside the resv lock so it is stable?
> 
>> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
>> +				     __func__, vmf->address, vma->vm_pgoff);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	/* vdev is usable */
>> +
>> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> +		/*
>> +		 * If vdev != NULL (above), the registration should
>> +		 * already be >0 and so this try_get should never
>> +		 * fail.
>> +		 */
>> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
>> +			 __func__);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +
>>   	scoped_guard(rwsem_read, &vdev->memory_lock) {
>> -		if (!priv->revoked) {
>> +		if (!READ_ONCE(priv->revoked)) {
> 
> Same here, it is not read once since you hold the memory_lock it is
> stable.

I used them more as an 'eyecatcher' to complement the comment.  Although 
they're not strictly required (compiler barriers at the lock/unlocks), 
they stand out to say "something's going on here".

Revoked/status is read first holding resv, and _must be read a second 
time_ once that's released and after memory_lock is taken, so two 
READ_ONCEs seemed appropriate to show this.

But if you feel strongly, sure, I can remove it (though I'd add, say, a 
/* Re-read status value */ comment).


Matt
