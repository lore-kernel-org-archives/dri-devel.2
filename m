Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB80CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA671133FB;
	Mon,  1 Jun 2026 14:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="US+RD4Zs";
	dkim-atps=neutral
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C341133FB
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780323858; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=uHeUbRGlmYQBavxHAxujAJq3w1Q+nd5Jm3OCZfsoI90=;
 b=US+RD4ZsogfH2pXd8xPQ8KLaw5NsZF0GkSGVP5fsoqhc0UGJz/tbM//Pjf07q81DlLDSHMaVGd0aaP/OisxvN4AJpR+nxx1VDGKG+aHlIf8m9RvT7oK6+RJQRF35kCC+NngMv8L43lEYGPZhaASInz45uEat6yBNlfIW1T7sRQc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R221e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X40EdtR_1780323855; 
Received: from 30.221.133.117(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X40EdtR_1780323855 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 01 Jun 2026 22:24:16 +0800
Content-Type: multipart/alternative;
 boundary="------------38Jnrj7nWdLjTc0MKDjIqaP0"
Message-ID: <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>
Date: Mon, 1 Jun 2026 22:24:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com,
 alikernel-developer <alikernel-developer@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260531235421.GW2487554@ziepe.ca>
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
--------------38Jnrj7nWdLjTc0MKDjIqaP0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/6/1 7:54, Jason Gunthorpe 写道:
> On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
>> @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>>   	case PT_ENTRY_TABLE:
>>   		return pt_descend(&pts, arg, descend_fn);
>>   	case PT_ENTRY_OA:
>> -		*res = pt_entry_oa_exact(&pts);
>> +		data->phys = pt_entry_oa_exact(&pts);
>> +		data->length = BIT(pt_entry_oa_lg2sz(&pts));
> BIT is the wrong function, it uses the wrong type. log2_to_int() is
> type'd properly
>
> This also needs to keep walking and accumulating length for
> consecutive PTEs until it reaches a non-contiguity.
>
> The other drivers don't need to have that complexity.
>
> Jason

Intel, AMD, and SMMU implement continuous PTEs differently. Furthermore,

if the range covered by returning all adjacent continuous PTEs exceeds the

scope of the query operation, more safety checks and judgments are needed

(e.g., distinguishing between partial unmapped PTEs and multiple consecutive

continuous PTEs that can be safely partially unmapped). More modifications

and judgments are required.

Therefore, currently only the PTE mapping size of the iova is returned.

The current commit has a large number of changes; this issue will be fixed

in a subsequent series patch.

--------------38Jnrj7nWdLjTc0MKDjIqaP0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2026/6/1 7:54, Jason Gunthorpe 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:20260531235421.GW2487554@ziepe.ca">
      <pre wrap="" class="moz-quote-pre">On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">@@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 	case PT_ENTRY_TABLE:
 		return pt_descend(&amp;pts, arg, descend_fn);
 	case PT_ENTRY_OA:
-		*res = pt_entry_oa_exact(&amp;pts);
+		data-&gt;phys = pt_entry_oa_exact(&amp;pts);
+		data-&gt;length = BIT(pt_entry_oa_lg2sz(&amp;pts));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
BIT is the wrong function, it uses the wrong type. log2_to_int() is
type'd properly

This also needs to keep walking and accumulating length for
consecutive PTEs until it reaches a non-contiguity.

The other drivers don't need to have that complexity.

Jason</pre>
    </blockquote>
    <p>Intel, AMD, and SMMU implement continuous PTEs differently.
      Furthermore,</p>
    <p>if the range covered by returning all adjacent continuous PTEs
      exceeds the</p>
    <p>scope of the query operation, more safety checks and judgments
      are needed</p>
    <p>(e.g., distinguishing between partial unmapped PTEs and multiple
      consecutive</p>
    <p>continuous PTEs that can be safely partially unmapped). More
      modifications</p>
    <p>and judgments are required.<br>
      <br>
    </p>
    <p><span class="HwtZe" lang="en"><span class="jCAhz ChMk0b"><span
            class="ryNqvb">Therefore, currently only the PTE mapping
            size of the iova is returned.</span></span></span><br>
      <br>
    </p>
    <p>The current commit has a large number of changes; this issue will
      be fixed</p>
    <p>in a subsequent series patch.</p>
    <blockquote type="cite" cite="mid:20260531235421.GW2487554@ziepe.ca">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------38Jnrj7nWdLjTc0MKDjIqaP0--
