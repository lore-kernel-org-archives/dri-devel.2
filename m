Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7CCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D8E10E1ED;
	Mon, 28 Sep 2026 18:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fb.com header.i=@fb.com header.b="kAUaIAMl";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494E510E1ED
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:00:20 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHwukK3561556; Mon, 28 Sep 2026 10:59:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps82601-s2048-2026-q3; bh=pEF+FSbGC0I
 yV+m+oO1hZz2RvMreBEf6ik/hQ9tP7DA=; b=kAUaIAMlccHRfXvCHNx9HLLgSvS
 zUzXCppBo+HK8nIQev08VJ7mlkiwJOEAcPTfsYzBN9RLvoTu2Xa+Ae9hDz4riYAi
 M4973+1KiZJOsPV8xEmrqIiege4V4D7UrEEKIYWiAepty/5n5O7KZX/133LwhcVf
 QgnaxN4pqXyGz5gh0YbxVnYzi6Ik4wD0nDpA20s7CkHfC2TH0enbggx2LA5Pq7hX
 Gg3K9R9fD4YfYlw9OVoHQl2pd90I6DX2ru/4DCzqXM72aJvgYJnXRbQa7rKud2N2
 QGfT5GnzUUQNoalo6bif1GZHDKTvCN0XIAzJgHAiWktYCHfG9bG3eae8hmQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gxymj8skw-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Sep 2026 10:59:49 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 28 Sep 2026 17:59:10 +0000
Date: Mon, 28 Sep 2026 10:59:05 -0700
From: Alex Mastro <amastro@fb.com>
To: Matt Evans <matt@ozlabs.org>
CC: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 6/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <arqq6VXW8Rif59BL@devgpu015.cco6.facebook.com>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-7-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260924152159.49702-7-matt@ozlabs.org>
X-Originating-IP: [2620:10d:c0a8:1b::2d]
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MSBTYWx0ZWRfXwkixo5mFwJL+
 3HxVttVUw+QY1JoVP6q/63ZuKC1iNj+c/kiuAoI/m0mErc4e+ALmZ+sdLPtiu5xXfpLVL1H5sw1
 KoQeyUON47ZXxYfTn/Brx09PCPtLkJk=
X-Proofpoint-GUID: wtQ7mSHJGALMv_7s4tdWeER5WmOUv9o1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MSBTYWx0ZWRfXz7SjoAw7WbsZ
 0rw1WR/kQSLSd+1v8o5N+oHGO7nv54+PqYN6mxhHQ/CwrRq+y7emYcDWXrwym0zCeMMMa2FCMCr
 BgTsqJWofCMKDD/BC1iVgqGdG8iuKaxUQlHgXPSVhLmVjo32uo4XDVPvOfkAJsE6l0QuDm3w6VE
 r31kXYppLEsgTWVzeJAaNWssShBQ9jlnBI+0vZyyvl2QIQ+D5ATJFvqVcgq0h20cR4TvBkYmq0M
 M8o2mx94ripun1SkUw+MKHWcBV2azAbayTjK4wGG4TjCpk2vdsJr4a0jBMRq3F91qr0MejGDxNu
 av0w7LR5mviJeRXJ1g0VKYHCFm6bp9VnvAoCaFbTm6XDRiJ562qJsky0FcUzLFfpQxNh9IICMTx
 xnF9zDKglBN9URMpMjFlJYCN+0uNXYvcUvUqCn0+YjDXn6PkNL2MQsovuF2qwuRx9WWfFbGbhyz
 obwvwrEB9L0mFhnvAZQ==
X-Authority-Analysis: v=2.4 cv=Hp3jiETS c=1 sm=1 tr=0 ts=6abaab15 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=NEAV23lmAAAA:8
 a=wdxqxBYYAAAA:20 a=FOH2dFAWAAAA:8 a=RDIsNprFJan8OBN3x1YA:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: wtQ7mSHJGALMv_7s4tdWeER5WmOUv9o1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
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

I used [1] to validate that the problematic sequence that deadlocks
in v5 is resolved by this v7 series.

The test stands up a spoofed nvgrace device [2] in QEMU and runs a test [3]
which:

1. Launch reader thread: pread() from vfio device fd into a userfaultfd-managed
   page.
2. Wait until the uffd fires, but do not resolve the fault. Now pread()
   from 1. is blocked, holding memory_lock(R) inside nvgrace_gpu_read_mem().
3. Launch writer thread: pwrite() the PCI command word, queuing for
   memory_lock(W) inside vfio_basic_config_write().
4. Launch mmap thread: mmap() on the vfio device fd, taking mmap_lock(W)
   and triggering the internal dma-buf export that backs the mapping.
5. Resolve the uffd fault.
6. Join the threads.

On v5 the dma-buf export in step 4 takes memory_lock(W) and blocks behind the
reader and the queued writer. The reader's fault path nests mmap_lock(R) inside
memory_lock(R), while the mapper holds mmap_lock(W) across the mmap handler and
waits on memory_lock (lockdep reports the cycle).

On v7 the export takes only the new dmabuf_lock, which neither the reader nor
the writer holds, so step 4 completes while the uffd fault is unresolved.

Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Alex Mastro <amastro@fb.com>

[1] https://github.com/opsound/vfio-dmabuf-lab.git
[2] https://github.com/opsound/qemu/commit/349f0b12ca633fc42532aeda33273079b2b8e5d4
[3] https://github.com/opsound/vfio-dmabuf-lab/blob/cfe762123076c4543fdc4e8d5e9b62ad6bf998d9/tests/nvgrace_uaccess_test.c#L309

Alex

