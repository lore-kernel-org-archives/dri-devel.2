Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D7EC88E42
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BDB10F411;
	Thu, 10 Sep 2026 10:06:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B99C8994A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:42:10 +0000 (UTC)
X-UUID: 198dd5c6ac3b11f19a56ed5b684f684d-20260909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:96be5b24-559b-471a-a709-41308b3f524f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:7fbbb0f849b9254f6c5f92ebe1516e05,
 BulkI
 D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 198dd5c6ac3b11f19a56ed5b684f684d-20260909
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <liwang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 1215083401; Wed, 09 Sep 2026 18:42:05 +0800
Message-ID: <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
Date: Wed, 9 Sep 2026 18:42:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <2026090913-landline-encroach-c544@gregkh>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <2026090913-landline-encroach-c544@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

Hi Greg,
  Thanks for the review!

> 
> That's not really needed in a changelog text, it could be in the 0/X
> patch :)
> 
Sorry for the clutter. I will move most of them into the 0/X patch in v2.

> Anyway, you didn't cc: the io_uring list, why?
> 
`scripts/get_maintainer.pl` didn't output the io_uring mailing list, likely 
because this patch doesn't directly touch the io_uring codebase itself. It only 
enables remapping GPU memory buffers to CPU virtual addresses, which can then be 
consumed via standard io_uring APIs.

I've added io-uring@vger.kernel.org to CC for this reply and will keep it in v2.

> 
> Nor why "fgds" is the name, that's going to be hard to remember, does it
> stand for something?
> 
"FGDS" stands for Fast GPUDirect Storage. GPUDirect Storage (GDS) is NVIDIA's 
technology enabling direct I/O between GPU memory and files on NVMe, 
widely used in LLM workloads to bypass CPU overhead.

If "FGDS" feels unintuitive, please let us know if you have a better alternative.

We will address the rest of the code comments in the v2 patch series soon.

Thanks,
Li Wang
