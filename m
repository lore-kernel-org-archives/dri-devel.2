Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A866CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C076910F8FA;
	Mon,  8 Jun 2026 19:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="ac3dI1gN";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991C210F8FA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:17:16 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6581Q9S12719431
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 12:17:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=dfx+I7Zh9CT7AUzx1cYaDwJvz1UNAxtJcpUgNxo6+M4=; b=ac3dI1gNoa6V
 irYUMYWelM+MS0L6NYzgHkzcYVnYMIjyS27s2jS72w2khX47JRGnZxi7Xdabs07x
 mxaLQiPirpsuYmREVw9s1vO+901lXEV2Aro9oP6M/K24KoCoIFjPjC3fCjJPD86v
 c7/WkkTIeRFTPFpL7QyYM6RClAkrJd1ZZh95qxrXXYFoMxDFZ2W+Jw1oIVmlmjtA
 3LDFxgj/d5sxNfJJIwrH1ORFv+vMC0SnJoIEAhxg14TaxW+443u2GrLNLK65LTow
 eokaqrZOjl78oWkf7vGMrHsJ25siAKMthSNGXkaP5RquXO+SmefWcZFBsSR4YZkF
 oahxIk2qaA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en54jydfv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:17:15 -0700 (PDT)
Received: from twshared37075.31.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 19:17:14 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 310D13CC1012F; Mon,  8 Jun 2026 11:56:47 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v6 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
Date: Mon, 8 Jun 2026 11:56:38 -0700
Message-ID: <20260608185646.4085127-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608185646.4085127-1-zhipingz@meta.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _G_saeWEeeXGEKmzpZsblL25k97r0-yb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3OCBTYWx0ZWRfX5q2ibKp98If3
 nd5wW1a45xZbpo/36fAbYfba3cXnQlI96HFoGV3tfJ/uEGw0wmllrxFn8Z5OGQJGsK6ywkQShtZ
 yw88DntZ7RuUF37PT8LuqPuC0rz+HeXp0h5U+VyCspAEfI/IYhXotJUOuxsfQb6ZAPkR1zvx0JK
 v68JtP3MgD4lAxlwcVmQakPfdpkuEw7srVs2bBpQzXt/kvMn3sCr94YGvVwdHMevJ7DDjANxPZr
 EUodApYAAKzhCV0z3Wda3cRgTFGdekk4tSFAqKWLnbuA8pXaz2s8Gg+s4AkkLKw9JKNGNAnxGvj
 XfWI+kg8RiN8CxlsEwbT3AlAQqKNrbnb5/0bGQUsmVZl/iuTbbF6ADzGB7Yo1YJWX3ho3GfyPOv
 0HV2BXJxoH+AwtsHCGD06ygJs/Zlz0eZAj20fCSkHK2HqgyQgsoBSPytQe2KtbLbPnPqU1zX1s9
 0B9MUZl3fIMaiNL1Qhw==
X-Authority-Analysis: v=2.4 cv=RvD16imK c=1 sm=1 tr=0 ts=6a27153b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=6RAPK-_vliJErzSYU6QA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: _G_saeWEeeXGEKmzpZsblL25k97r0-yb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
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

