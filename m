Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC44CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C08110E749;
	Wed, 10 Jun 2026 19:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="HkPDy4E9";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2BC10E749
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:57:54 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJcSFK2243655
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:57:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=KEQGIb3xKN2RiIsccMVUCd6vHp285MKd+W+/k0aQgEc=; b=HkPDy4E9m50v
 7DMoV1oAatNOvS2vn3PPgOXGy0cgGHAlWtOF5lP4AvYObNX5e/6YozPI04wX7Dbi
 bw61c26FViIxOfpq9sOOVwjYZ4zxZv0hULeDd15UhVtWpmSVAlgi8GjUwx1ChgWn
 npojgC0zmdYa7yzBtdLAFWVPyi84NtQowZ/HJSst85IUsV1b2ezUGemVQBop4D/E
 CKhfWiG6iAu6VeDvina+4QzO5rytiLA8P/JXRNv+Oslh4iOpI6q3scOQ9sDc1Hik
 eVSA7O/QP/u23TpRYEQac2H6uK+lhHHKowDZXigz6gtgzBMbrkdVZo63WWHxZr1C
 0fMe35ZfEQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81g463-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:57:54 -0700 (PDT)
Received: from twshared14383.01.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 10 Jun 2026 19:57:52 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 24EE53D7AB5CA; Wed, 10 Jun 2026 12:32:03 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
Date: Wed, 10 Jun 2026 12:31:50 -0700
Message-ID: <20260610193158.2614209-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610193158.2614209-1-zhipingz@meta.com>
References: <20260610193158.2614209-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=d8nFDxjE c=1 sm=1 tr=0 ts=6a29c1c2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=6RAPK-_vliJErzSYU6QA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: y0-vgQc_fKQdhA82zTx0sPiU22jJLdeg
X-Proofpoint-ORIG-GUID: y0-vgQc_fKQdhA82zTx0sPiU22jJLdeg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDE4OSBTYWx0ZWRfX5o8xGhJqNxLZ
 pjccADPSiRXHOvac1WsO2O+gkQZJdi1v2aJpRkEwXY6bsBrJnsoGA6V8LeMBN1vh+BoSFb7gF3Q
 mVhA/vc8+UIwF8ldXmcxXXnGyGJJkh4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4OSBTYWx0ZWRfX/wqodLGcmc/y
 9chj1fOQqiJk51Yb1cYMB+V/cmnm6MAYhYHflsWbRqyuDbLDc2Oc3AHK3tJ90StI4uYNCWPBdc1
 hdjMR2EmA8qCUweJD3rrGOEQlNKD7zB7K4yevzaIDqaZ/5VoAQ9d/L/kPPo+xDFswAmpkIVPTNJ
 jju2VdkwCriGPdXf0LYJQLGpsiV/8yQyfYZf2GSAB8WJqVlIBBRZQcbHtukEGgUaZt46RTodssJ
 7RkhArpwh3OccdmIfgc1k+wVIx2K+rwTnGmdWh98qJIJyVNF8pdIRICqD6PXcHVxBtDhwxg62Z5
 DhsIVIgKUO3YligXJvHJs2MwReYKfrr+ym/+XhWmLtH/LMH3O3tansHKIOSuUDz7AyQ83nw6R78
 pCiN1LrQUIC1RdxtBREEWtEpVmLN3l7rBOntC+3RKimrHkr8elGcNNYmtEM6ztrv4Xkf9PRCv3x
 zqwAgimydSv/rXoHE7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
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

When the last reference to an ST table entry is dropped,
mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
therefore accumulate one struct mlx5_st_idx_data per cycle.

Free idx_data after the xa_erase() so the lifetime of the bookkeeping
struct matches the lifetime of the ST entry it tracks.

Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..7cedc348790d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, =
u16 st_index)
=20
 	if (refcount_dec_and_test(&idx_data->usecount)) {
 		xa_erase(&st->idx_xa, st_index);
+		kfree(idx_data);
 		/* We leave PCI config space as was before, no mkey will refer to it *=
/
 	}
=20
--=20
2.53.0-Meta

