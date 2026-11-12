Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD3B606D574
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PMJdQsUZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14AA310E50A;
	Thu, 12 Nov 2026 20:44:21 +0000 (UTC)
X-Greylist: delayed 445 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 20:44:15 UTC
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A98410E50A
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 20:44:15 +0000 (UTC)
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACJcaXd3548768; Thu, 12 Nov 2026 12:35:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps82601-s2048-2026-q3; bh=yS4jNiYhRfG
 b5QojFYxrTDAoccyphd8P5VhC9esgLP8=; b=PMJdQsUZ9wFmcb1iynmoB69a2S9
 /l6vcpkudJukcwnCYNVACZN0krn+ykO5/TIt8+EpvIbWXk/Thx5k4vZ5cgmq7W4p
 YSdoLkzwG6uHSIzCdV+IylJorKuexJKBqUwpNz3SZ4B9WPoALoDExWQnCKXWDPRb
 Z5/DS8vaRFuKSuzPHSYrcPHcAb99myPDRsf03Szq3cieanayPemOCovBQW9GdIeV
 9RbFNayyQojAeuUGrtEiXtaos06zx2p1BuqvueNs74kFdqg74AT6KnsJC9/MrARK
 c41Qbapm0737503MSI6RRWeUhYCOy69L1IbLs7qa5UjksU0IawyoORjMH9A==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5h7ms-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 12 Nov 2026 12:35:41 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 12 Nov 2026 20:35:37 +0000
Date: Thu, 12 Nov 2026 12:35:33 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian
 <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe
 <logang@deltatee.com>, Matt Evans <mattev@meta.com>, Matt Evans
 <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Proofpoint-ORIG-GUID: gTZbwHAPJUHvcNcTQXZoaWTbiDqc3U-y
X-Proofpoint-GUID: gTZbwHAPJUHvcNcTQXZoaWTbiDqc3U-y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA4MSBTYWx0ZWRfX8+QGQcJzlVZg
 k4Zo3bVBz7pmfN3Sfd/laKYuJjmFQTltox9bHgb+vFKdRZxfPn2n0Byt7bGXetEoyIWHw2/XxUZ
 RUghY+S0CRIP/9z9WKscp43wNcr8TSs=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af6231d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8
 a=3j4BkbkPAAAA:8 a=qjNXR0RCjIH4vnWDDyQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA4MSBTYWx0ZWRfX2wWt7WUyZDf5
 D7DqzOxzzAGKashRIAA/XPJs2s1+E5sQcsUHgQu8DNi/oAjPAVl+TFoYcfJpmKo1T+SifLgmnGv
 xX0gaGGyBdj3zBqzNmmH3Fd2JXAsfCEBPaGKMBfVskS8la626Xp/5xsN8j14N+BhVitHcuQFAnY
 /j/Hlo5VFXrSGrLA77e8dj3bzmtM7o9GzgI7nxcQFOvkHBp5VB2jhDeyzOtxhG7DsNjj8S9xSJV
 MQ4mjkW2fHOlYI05MAevUaRZ040NaOb9hNIRBhKLWfydQKtRmj56asgGGtHpbJU1G8GkZR5UxQW
 bQY9UIQoU9xJOkxyJhU0roi0DoxJZwWPF6pauZPOYebzxrW256aN69ysBxfjbUieqTqqTSS6C8z
 XUMjB16+VToOfr8zogSJU1k1HQxxg5xUIVI3PTQqSWHTIJIPK5qkJp79XjeEwbm0r/sW+xVS/9w
 FzxCuMNv0O5AhSkJmzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey David,

On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
 
>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>     uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
>     target device also bracket the reset with
>     vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
>     false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
>     device's BAR even though PCI_COMMAND_MEMORY remains enabled when
>     VFIO_DEVICE_RESET returns.

There was some discussion about this in the thread below. My understanding of
Jason's point is that the current behavior, and differences between what
revoking and move-capable importers see in regards to vfio-exported dma-buf is
somewhat incidental and not necessarily desirable.

https://lore.kernel.org/all/arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com/

>   - Physical target devices and P2P topology checks: mem_bar_descs[]
>     currently only matches QEMU's pci-testdev, and
>     vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
>     verify that P2P traffic can flow between two physical endpoints.
> 
>     Suggestions on physical target BARs to add to mem_bar_descs[] and on
>     checking P2P reachability from userspace are welcome.

FWIW, you can also exercise the "P2P" path with just a single device if you
IOMMU map a device's BAR into it's own IOAS, and have the device DMA itself. For
eventually validating aspects of Live Update, maybe you don't necessarily care
if an actual peer device is being DMA'd?

Alex 
