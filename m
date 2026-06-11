Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AC4CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F59710F01E;
	Thu, 11 Jun 2026 16:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="GOTr8Ol2";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45B910F02C
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:46:14 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BDxGLe2263096
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:46:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=KEQGIb3xKN2RiIsccMVUCd6vHp285MKd+W+/k0aQgEc=; b=GOTr8Ol2fdIU
 BLdFbT5Th1T4Bb+2Yixo1ptLj23bktDefCcnypTkeh+oYC8eEwtZFOE2wJ9Xwsla
 /j7zJrLJEjkM71UIVh/bM7XABFUAdatthatigE0iBfWc3rFRoGXJTwoNemAmysZn
 qvzHKBa+UWBmZ0Hksnx7pGEcIzv/DmAz5bEE8FL/I6hh/42eY4vM84c27o1nFTMZ
 wpy+x88JH30L1SukuVCklYTZnHZZMtdpU/4SkmKa23h6TrXy0Lo2GjRw+p7Ng2D3
 J3nZZCXubPa9u7Xa6RqvaNawSg9IlNKi2T4fBoPY0Rkht2E8b7cHu9hnK55ki5JE
 ohSzmtSv4Q==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7b6r0k-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:46:13 -0700 (PDT)
Received: from twshared88813.16.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:10 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 5CC913DD36084; Thu, 11 Jun 2026 09:23:26 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
Date: Thu, 11 Jun 2026 09:11:16 -0700
Message-ID: <20260611161546.4075580-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX0Oatu2ys7QJE
 1ZdqT+PJpkeEL26Aos/IybE5Md4Ejs6IigynnWwYvg3frc1uKm37Paf2cGgOixItVzmJ1J1unbH
 tIlQcWQ7LdmEKRwbAoboAQc+0af2fQU=
X-Proofpoint-GUID: ZAGx3vuMU4Fr06504EBHZTlizR1FzBIv
X-Proofpoint-ORIG-GUID: ZAGx3vuMU4Fr06504EBHZTlizR1FzBIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX4aMA7OGkVHbJ
 9jSOv3eN1l1GPhmi9rfpegqgB3zcj9JVnO3jmg1+vPkag2NpYIGGPW+WJ2qNAu+JlTDBQRrAL2L
 qJ/7y7ArcZz+JQkigMyGY0OF6dunkBecLE9fqeeXIwsCl+8BTTo4kD5YIziUfocrnQsRuYki318
 0VO1LP6E3SPPKwf1GG/J0BDKZPOUibhanM77UmI+Dlf8Ch6A+GM6TLGc2TpJAZxathjEHN265tX
 BtjzLi9R23qCPNOeSQEtqLQJFVU1phL9Pi+ZfQWyuwbYGzhFawn1FCUGkvADB5eQWudu20lG15a
 2n9jVth+8VWji1vgmUMGWxjE6FqQtrwCDncMp0ZlednOeWGqiqZ3DJl1BIoisDdABddVhCcxkjD
 H8mgKC56NbCHNriRD41m83TQTUZC9cmGo4jcXUoeLxr8dsygaKNAAq3NHK9NvsTB3eGNdBLPbXA
 pyj5GkQ5EsnCIhnc17A==
X-Authority-Analysis: v=2.4 cv=C8nZDwP+ c=1 sm=1 tr=0 ts=6a2ae655 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=6RAPK-_vliJErzSYU6QA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
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

