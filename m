Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8A4CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0EA10FEFD;
	Wed,  3 Jun 2026 14:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="srLuqfx+";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C3110FEFD
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:22:30 +0000 (UTC)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6536mjwA1487689
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 07:22:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=YNScBoT6fWRdM9NkrxjASUlxGuUaN5ox/szwoVCoD/M=; b=srLuqfx+FXuC
 bzE9LkokrAimE5iY6tNN+9tUNfEUn2ef7Lf+87pai3WStxYfRanSdrRxchFrsRaa
 hVp4NgdWnzJDmE0szjBwoM0UI8p/Oe1nmi8cfpFlZ72sJ6MKjrvWVKWCW7EgqGZU
 WY5n4wx/L7mDEsXGDKTFRggrDyDhnviCYwZR1mFhx23XQN1Hossmfj02lNA97hnq
 tldmWLaYSlQaubMvRXFHZmLKUM4/IZrzYGEXU+A7/okfjXt0q6FEFIPesfkDIXRX
 kiDV5EiNC27PctqlfT0z16mTfJF9Zn8GQkNgtJFwMsBAzv/dJKpmMRbazdFqdpR2
 coUlXhATAA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by m0089730.ppops.net (PPS) with ESMTPS id 4ehxr4rdy5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 07:22:29 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e4636205so16045875eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 07:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780496548; x=1781101348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YNScBoT6fWRdM9NkrxjASUlxGuUaN5ox/szwoVCoD/M=;
 b=QHcqsahVtpBMq+id1FV9XSNmH9gkKIG5VjQAldV8BsfIbHHs49YN1Hh2MYQpuiDUIy
 vsED7aXqSIuhQwLzK/k8xyc+zdGrQ6HUUnnn/juowVFvA4W0yMA6A80Kg+ZeMj4Jg/dM
 NEZurUml9G7b7PKIPNQv/mNspVLCQX059zwCLkp91TywUVDijaMkiZRQSYCxtxJv9Q6R
 BC7Y+2qsKxNNOlnK8QPZZmbRwi/KvgKmRdoqD09lQGW/HNzraNjMLshXjRY8QM4JEGfu
 kQrP7E3A9ITNsE080DxUPtjslnqHcX0zbvXWbVj6OQw2t/5hrFyFAerATzr/IchlB+VB
 dT9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WU10yMwCkt7rBCKttPRetL9cgiAp6RoXWaQTLI+BLNwS7KeJyAcLd/jA+gihOQKOwnqk2oItRjg4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydjzLzGi1akvv0f1xCX4NCyaaBbM99+kIz6MX3+FTPmuRgXR80
 klXBLA/c/TAw0t76lSy3B4Lko3bg5HTwovuuCdiv9gA7KIsGjZ+zeKsHzV4RQSvHBaxnwPhGt++
 Ou0h32K1HV8SaRoflS3yfpWYxUoCF1n5f7b94IuNfjOXCWx2/dvNJ0cZEsqeAuJTd9iNR
X-Gm-Gg: Acq92OFC6Z/+NyTb29dTxsv2nJsfD4y3aW0A/qlWPf6MPlP9Mc1xv/4y9Jyd1zGgjwm
 UHCNMf+1937G2p2xfXa+B8PoQXdM5+TzGYV1b745jUWhQ/6Lpb3X4d8KdchowOJctvcb4pAdMRw
 i+Gpm1aduQ2Z7VKUPV/SQBTK4zySFZ7dulGdwEngSd53vRltw5tRPKueXDhB185trMOfEO6eXA1
 B25YG5beMi1OcUf/RNouwEB9YGMBCWOdh02T/Nc3/f2h0GPNQQ4MLHle5BnrEcXlhaGyB3ZNN2d
 bAqDISkQrVlW3yyr84seaNtcLRXHDFKohyZlFYio/szR/ohYT10ynGhx9jdIAQfcjRASu5X1yoU
 8AClkGGVUvOPJanuS9QqMkv1ykoXmHKQy4TouV+ZB
X-Received: by 2002:a05:7300:2142:b0:304:630d:e4c4 with SMTP id
 5a478bee46e88-3074fab7663mr1925013eec.10.1780496548234; 
 Wed, 03 Jun 2026 07:22:28 -0700 (PDT)
X-Received: by 2002:a05:7300:2142:b0:304:630d:e4c4 with SMTP id
 5a478bee46e88-3074fab7663mr1924977eec.10.1780496547695; 
 Wed, 03 Jun 2026 07:22:27 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea8e8csm2504082eec.16.2026.06.03.07.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 07:22:27 -0700 (PDT)
Message-ID: <b7635ebb-c746-48e6-bce3-a10bd288e0c7@meta.com>
Date: Wed, 3 Jun 2026 15:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-10-mattev@meta.com>
 <20260528171432.771a1a30@shazbot.org>
 <8854824e-06c2-43b3-86c2-8c2c28f9ad63@meta.com>
 <20260602131417.41366391@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260602131417.41366391@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Oq1eSx9KEfzIBDrET0nW-IzYLebSGATV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzOCBTYWx0ZWRfX1iLXp18enket
 gPsilgNtpaqBOA+VbsgOh7uioEMxvYTL013lTofyexayXaxRe249JFinSxL+n2Ekna6f1jal82Z
 dBrFUMUdaeqTMahYfSdZSMtPUbMfSRGepuVLnQ44vReiByQGfRsa5eUa8j4J+cuyERJzDZDgi2b
 secDR5hogNVQsrkTct1MpK9ilDBZgd0Df1cHokPQ0QuFCoeuqXKhKKum/38RlZ5AsO4trwlvZKm
 RdzBIJy3a3H50zeEeXMZdjg6FBEz/g2lLztvL+DwYy2qV/yQIRw6asFkvhkeuPuVXYQH+PqV9S2
 8eJsuUlp24szQOa7oMrwfjf7bx7+tAvabclP52x59ugJCco4KCujGrYSlCCFjsgW/R9dU+CJpLx
 K6ApwjBYKqKlxzM+2lg+4VNRmM72/XvX0gszgODjf7yEx53ZRzusUSidNhg7b0Umgcu56focQMj
 SJAsGv9ZZVcB5gte4Mw==
X-Authority-Analysis: v=2.4 cv=dsbrzVg4 c=1 sm=1 tr=0 ts=6a2038a5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8
 a=AWNa1KPf0UDjnrnzYgsA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Oq1eSx9KEfzIBDrET0nW-IzYLebSGATV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
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

Hi Alex,

On 02/06/2026 20:14, Alex Williamson wrote:
> 
> On Tue, 2 Jun 2026 17:50:04 +0100
> Matt Evans <mattev@meta.com> wrote:
>> On 29/05/2026 00:14, Alex Williamson wrote:
>>> On Wed, 27 May 2026 03:23:12 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>> +		uint32_t old_attr = priv->memattr;
>>>> +
>>>> +		if (flags & VFIO_DEVICE_FEATURE_SET) {
>>>> +			switch(db_attr.memattr) {
>>>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
>>>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
>>>> +				priv->memattr = db_attr.memattr;
>>>> +				break;
>>>> +
>>>> +			default:
>>>> +				ret = -ENOTSUPP;
>>>
>>> -EINVAL
>>
>> I'd like to push back on this one; ENOTSUPP distinguishes trying to use
>> a wild attribute value from all manner of other screwups such as
>> trying to GET (with it no longer supported), passing an fd that isn't a
>> DMABUF, etc.
>>
>> I'm not wed to the value ENOTSUPP, just something distinctive versus the
>> other errors userspace might see, and that value seems appropriate.
> 
> It needs to be a uAPI errno though, aiui ENOTSUPP is an internal NFS
> errno.  How about EOPNOTSUPP?  Thanks,

Ew, right!  TIL, and it's caught by checkpatch too (which I fastidiously 
run but still missed this somehow...) :(  "ENOTSUPP is not a standard 
error code and should be avoided in new patches.  EOPNOTSUPP should be 
used instead."

Fixed.

Thanks,


Matt

