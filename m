Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9978AF4613D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044A510E6AD;
	Tue, 24 Mar 2026 12:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LW/m78co";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E81E10E6A9
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:58:12 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so37158065e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774357091; x=1774961891;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EJ9KhFxElQQZSu9ghWXCoeiyYOoUrbSYY15jZoKWOCg=;
 b=LW/m78co05A7wC6Q4uuJx1UOlLMGFh5s3KZLH0GASU0ez57h3q6Yv3fW6ErNwmt5o9
 78HDZYW0HaDtLGi/KTZl3cSdV5YgRMCJ09/77IdlBGNXnrg/Qg650lumEXgj9lUmTsoS
 SYUK/ikGiy4FuRQTs9mdR4IPBXCZFJ6lsjNNp6O8q7XkJR1xHygI9rmRD3rm/CC/D8N/
 1oD2VK2lbuUlpKD8zVCYrKRmi6nY25ftGjJCGO82tEtAG3Y3hLuUWMmgUB30sdkEbss/
 OQHCpFkf4f6P+eQuYa+x5g3NiynmJjZ/fpw1pZvgDr9mC1A9h1kkrBOfKRgdFtR2YmiX
 HP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357091; x=1774961891;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ9KhFxElQQZSu9ghWXCoeiyYOoUrbSYY15jZoKWOCg=;
 b=RaLVS5wUzrkx6F7MnkEOeyazIAVPnPuVLh1RgOOkPiEZNbTh5k1amf9xv2Xm52ZlXb
 ladBAoV8nNZrgqPAjfr6Ww9newdB2E9lpxYz1ZiMBhbdYRRDdkX5BfW49idbsbGAUJKh
 FjiB9njDT1+LdI9JKxfF3Pq1+gok6tfEdR4mWaCzLf46e8hhGP6iKvnfOYzlwzL2QMju
 qkE56bKGE4UytO+h1XEqTBfU/hjcyTdOISGJvhJB+IYq0A0HwLIuqJ/q6qfb9Fe7pr9W
 Tu398PTx6Que4ldUFEP9NNdvre3rdYVAfSAzSDHFy26Q30sa5gYQcXLZHHKr5MllG6Qg
 6rvA==
X-Gm-Message-State: AOJu0Yw1+T1YnBbHOvZydxXIXMQfHMuczl+DsmkXRIZ4RStTyJBilMYA
 GAfv3TxLfMSyuML/x5b4JPOR+A2rhib7uCGZAA20+a+fjHTZ24d+xConPtMOPzwAlVI=
X-Gm-Gg: ATEYQzxjz6kbSZOvojVTJ3k35369w1bjUWuHUkjkqL7D75Xd6SSl7FkhNd6AzL0LTkE
 52v42btTl+E9tzw7BzCGO9j5UDT2L0nz/xS08EYoaALgZ6tLstO3Q55v064vNJ3cqfNirWf2w3o
 gPUpA5/AjWuS5b9dOx+G8AdgPdtpMHgHFUnlPCGn9fW5o4KpKeBF+1N+Qltd7yfh48w1hBapeSE
 jubussUcbmMRYYEO0VhsG7JUuTtjTq72Th5+nEVUHg0MbX/z9nkRqdv/249rJVpgXgPykjOhYQn
 +Lg03SLPzp4WuTPfw4Vdm6U04/6UDORpUgtf6Y841ghcgLgcw8enBFsUuFsY6ZyMaYhw6CFMxiX
 EKIx0ibTP0W4SBgl3KrvJmBDF2eHLksJ+TLxZbkysLpBfIpdb+S4gxv/MD7N+ag0UBjfC0r8qIB
 1rXjqEw2okanTsu9qhDKpqvKOsV5tPsHTGYO4=
X-Received: by 2002:a05:600c:3b07:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-486febb59acmr211442975e9.5.1774357091334; 
 Tue, 24 Mar 2026 05:58:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871109e659sm17440195e9.23.2026.03.24.05.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 05:58:10 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:58:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, 
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 2/2] dma-buf: heaps: system: add system_cc_decrypted
 heap for explicitly decrypted memory
Message-ID: <vflgbxlfg4pzj3yrnkz7g5dwncnod6uenwpwgs5z2qflbrjucv@coqj6fmjkyye>
References: <20260316125857.617836-1-jiri@resnulli.us>
 <20260316125857.617836-3-jiri@resnulli.us>
 <CABdmKX0Ux2HMTTuOnvZryBBRwCjH0zUe-EMvL9k1VxZtz+BWiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0Ux2HMTTuOnvZryBBRwCjH0zUe-EMvL9k1VxZtz+BWiA@mail.gmail.com>
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

Tue, Mar 24, 2026 at 12:25:46AM +0100, tjmercier@google.com wrote:
>On Mon, Mar 16, 2026 at 5:59 AM Jiri Pirko <jiri@resnulli.us> wrote:

[..]


>> --- a/drivers/dma-buf/heaps/system_heap.c
>> +++ b/drivers/dma-buf/heaps/system_heap.c
>> @@ -10,17 +10,25 @@
>>   *     Andrew F. Davis <afd@ti.com>
>>   */
>>
>> +#include <linux/cc_platform.h>
>>  #include <linux/dma-buf.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dma-heap.h>
>>  #include <linux/err.h>
>>  #include <linux/highmem.h>
>> +#include <linux/mem_encrypt.h>
>>  #include <linux/mm.h>
>> +#include <linux/set_memory.h>
>>  #include <linux/module.h>
>> +#include <linux/pgtable.h>
>>  #include <linux/scatterlist.h>
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>
>> +struct system_heap_priv {
>> +       bool decrypted;
>> +};
>
>Hi Jiri,
>
>I wonder if it'd better to call this cc_decrypted (or I guess
>cc_shared based on Robin's comment in the previous patch) like the DMA
>attr? There's a separate effort for "restricted" heaps with TEE for
>(encrypted) video playback, which doesn't involve VMs or RDMA. I think
>the cc_ prefix might help avoid any confusion between the usecase here
>and restricted heaps.

Sure. I'll rename this.

Thanks!

[..]
