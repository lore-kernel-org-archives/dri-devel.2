Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E786CD13DE
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD4E10E8DE;
	Thu, 30 Apr 2026 17:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="VmzmDuLo";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D6C10E3A5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 16:47:56 +0000 (UTC)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UDAj0X066232
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:47:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=CXvj6rmLtU+yqG7K5nb8uAhPCFMrTB1Lg0tTO/8UY38=; b=VmzmDuLofwCN
 XcDBoa+sLJlHhfy6vjpvEjX9zOHYSohipMJKuWABb0/tFAgCYvUKYRmq1VYJYrm+
 YyffbepmXjCagGPySLIrmaJ5SWJEIM+OBHitW/S1gBzRFsRT6oc2SxOGzvzDzjUw
 92vNwrtouQ3cYeinUfudEAWZWLyl6zwoda8rflkF4cjAWAFZesr61T3Px2BTqwDf
 hF6OXYCAbJd2TYHTf+LHNX+8OiYQxHtTHKnZa33UUllCmQi1/95LKvMZ1J2xd6Ve
 2O6g8ywmcBylHs0F9CFe3Ys6hZVRNSwGu5ttT4tnlutyOtT7x9qVVAEtvsvTkoVC
 pXi+P7srPw==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drtqgu5kg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:47:55 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a5c837c44so8268735e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777567674; x=1778172474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXvj6rmLtU+yqG7K5nb8uAhPCFMrTB1Lg0tTO/8UY38=;
 b=XR1EDA1TD26AJfZtwnUMwKo6AAfWPmEWtxSYh4bEIMHnSGpRWu9P5Q121I+r2FrniT
 aJG7thRw7DsXprgg8tGfr/1dHN5dXJzzyOV8eHXFv9pnreFP/5j7e0ztyjltGnBsd2FA
 eCUDua9gfg/XqTs/qfxOBztAgmNAvVHu/OPHcdtvum3ynEYuevRplDLEDjk3A0zWD55t
 IH1Ti6SYmOBKtD0vBBXaOy8lGnGueoStVDfnbBxFH9dIKn24hbYSPd46wQhed/O1Ges6
 0c8XVBDM2sWhMIKbz5ZX+TNro7LtOfr9IHdAtReKFIB2zQR/4TTuWF3aDB60r0unY8P4
 P71Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QxD6LIWVieVdI/1BB4YmbgQGUXhOxc2I1fcYJsQryRCPPiM9mV2aRqH7v0dXQ3nK95W/bnCwfwck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmV0c13D87fZNK6CGBWSkGQ4bOBrJ3I3NImFG/KQcZBsTNTi8v
 8RVUWXLTS0w6R4rGiH65wEmraGrQNrFRxG8JTV4C2NcAawcdatHLxbqJ/lgjSP5hHdUXhYZFBEC
 6cCVk9DOnRXAtHGg9E1dtXpNujesz5oPRLRg3f3WJvsBUtA/3PHxV2TKPc/crNTVqeaNn
X-Gm-Gg: AeBDietD7r4C5X6RlMVy4dOm3dANQDTcLH8eBcP3lqyaRlHnGFGqKi5daklq7pux+kW
 zv77LFKiAZNKtg6m9Fg21nrbLGneh3ucM0Ewu1TwZrq/pjeKaM4M82IGzKI1qsmZfbSjYXM4UJj
 OSNmAc787bZ5c9Vg8NrrvfQdqxMxSbpTMrchJC+jhxqY6TKtq1eKFjX691JdHuFtitxNNO/XNYX
 kXQ88GLzp7xwHKAjNrbecZ6JJZgGljLuBhlLNs8okUMBO1AMXf9DZo+uHWUwQF88PLFi3DNH2wV
 BenSf5MrFGe/8N5Z9FuY6f/OI8oTIntC+KtjkKMcTLTFP+DqGxbHXtfSOziY5rtV1sVSbzZnYGq
 7tsHi+hgUneFmK9Na6oYtKx8IaUrYLd/mKIVRQftR2fguuh1R/a/VDxGuKynJS+VyIAmiVtNGxV
 Zl
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48a83d73324mr65498785e9.8.1777567673957; 
 Thu, 30 Apr 2026 09:47:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48a83d73324mr65498015e9.8.1777567673394; 
 Thu, 30 Apr 2026 09:47:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:10fb:be93:502f:b7be?
 ([2620:10d:c092:500::4:5cf3]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822c82f2sm75353315e9.11.2026.04.30.09.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 09:47:52 -0700 (PDT)
Message-ID: <c598a21e-ee50-42d9-98dc-2959e84ace50@meta.com>
Date: Thu, 30 Apr 2026 17:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
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
 <20260416131815.2729131-4-mattev@meta.com>
 <20260424182426.GG3444440@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424182426.GG3444440@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IOIyzAvG c=1 sm=1 tr=0 ts=69f387bb cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=Dv35txUGz5gI0hTa:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=nxdftAbHouV8PAc5HfQA:9
 a=QEXdDO2ut3YA:10 a=nJq5_VNI1X7IEIKzvdHs:22
X-Proofpoint-GUID: I9L4ugpUliUImpYOv6_uK5TR6HImJ4uG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE3MiBTYWx0ZWRfX5+NVe6wPw5hU
 CgmoCnU2jIw/4Xt63A5aZGJN3BzsbqRTo6N312n5yqtuwF/UQVxj86+ZBbZkDzvmNJB9v2z5lDl
 A0U13K+inFUSeB7EGCfcq25zD1CMUdx82fGn4KyoLKwrS+0JA8AOpTu7UBseW6Ffg4n+P67YA1x
 5Lry/DXLrNI0f6suydidxfovkXo2+cmhvsX/MXhh2n3WMHS6dhsx6D5yD+lSTH6Fzc1Wuo045Te
 m2+rCE6AwzdiUBRvTNlvaLzABONr8Q21SfKYbO4m4R4iDXvE/7rl3pGGFzFzj5IWct2ZMH5gNrR
 kZ2YSWM7iGN21qsCa16wqXpRHHShNQvRjq7hs334gIUr9eGhr6Kr6JcGZ1nUeF1rjPYGEeAW1CR
 gVL8vTj1y+GU2hXuM1UitWErS2aALwFpBsGlpESTG+3UEjSCr3zFab+ebXEGbZvDyLiHO3jzyyk
 pdYrFlDw44PPFrbZQVQ==
X-Proofpoint-ORIG-GUID: I9L4ugpUliUImpYOv6_uK5TR6HImJ4uG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

On 24/04/2026 19:24, Jason Gunthorpe wrote:
> 
> On Thu, Apr 16, 2026 at 06:17:46AM -0700, Matt Evans wrote:
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index)
>> +{
>> +	struct vfio_pci_dma_buf *priv;
>> +	const unsigned int nr_ranges = 1;
>> +	int ret;
>> +
>> +	priv = kzalloc_obj(*priv);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>> +	if (!priv->phys_vec) {
>> +		ret = -ENOMEM;
>> +		goto err_free_priv;
>> +	}
>> +
>> +	/*
>> +	 * The mmap() request's vma->vm_offs might be non-zero, but
>> +	 * the DMABUF is created from _offset zero_ of the BAR.  The
>> +	 * portion between zero and the vm_offs is inaccessible
>> +	 * through this VMA, but this approach keeps the
>> +	 * /proc/<pid>/maps offset somewhat consistent with the
>> +	 * pre-DMABUF code.  Size includes the offset portion.
> 
> I'm not sure I understand this comment?
> 
> For the old path vm_pgoff for byte 0 of the bar starts at some large
> offset
> 
> For the new path vm_pgoff for byte 0 of the first range starts at 0

Glad you asked.  :)

This is trying to achieve keeping /proc/<pid>/maps (or similar) somewhat
as informative as pre-DMABUF BAR mmap, in terms of keeping the VMA
vm_offs column useful.  Before this patch, say you mmap() two slices A
and B of the same BAR:

  struct vfio_region_info bar_region;

  vm_a = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0);
  vm_b = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0x4000);

...you'd see something like this in /proc/blah/maps:

fffff4000000-fffff4001000 rw-s 10000000000 00:07 148     /dev/vfio/devices/vfio0
fffff5000000-fffff5001000 rw-s 10000004000 00:07 148     /dev/vfio/devices/vfio0

It's nice being able to tell the actual BAR offset (within the
VFIO_PCI_OFFSET_MASK, i.e I _don't_ mean the synthetic region index
offset).

For vm_b, if we create the DMABUF to begin from the start of the
actually-mapped slice

   phys = pci_resource_start(pdev, index) + (vma->vm_pgoff << PAGE_SHIFT)

then the VMA's vm_offs would need to be thunked back down to 0 (since
the fault handler then treats vm_b + 0 as the first byte of the DMABUF).
That works/adds up, but then the vm_offs of both VMAs A & B both have
offset 0, and it's harder to differentiate in /proc/blah/maps.

An example from the later patch "vfio/pci: Provide a user-facing name
for BAR mappings" naming is:

ffffb8070000-ffffbc040000 rw-s 00030000 00:0b 5         /dmabuf:vfio0:0000:00:03.0/1
ffffbc140000-ffffbc240000 rw-s 00000000 00:0b 2         /dmabuf:vfio0:0000:00:03.0/0

We could possibly stash the original offset somewhere and then render it
in the name string, but the name's already about the max size and using
the existing vm_offs column is nicer IMO, doesn't need a new field, etc.

I need to work on this comment then!  What this is trying to say is that
the DMABUF is made artificially larger than the part that is visible
through the VMA.

I.e. the DMABUF starts at the beginning of the BAR and so an mmap for
offset +0x4000 for 0x1000 bytes starts at 0 and the VMA sees
0x4000-0x5000.

>> +	 * This differs from an mmap() of an explicitly-exported
>> +	 * DMABUF which is an arbitrary slice of the BAR, would be
>> +	 * created with the desired offset+size, and would usually be
>> +	 * mmap()ed with pgoff = 0.
>> +	 *
>> +	 * Both are equivalent and vfio_pci_dma_buf_find_pfn() finds
>> +	 * the same PFNs.
>> +	 */
>> +	priv->vdev = vdev;
>> +	priv->nr_ranges = nr_ranges;
>> +	priv->size = (vma->vm_pgoff << PAGE_SHIFT) + req_len;
> 
> And why is size being calculated from pgoff ?

This is the part that makes the size the requested size plus the
invisible portion before the VMA starts (equal to an extra 0x4000 in the
example above, distance from offset 0).


Thanks,


Matt

PS: Thanks also for the other reviews!
