Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BC606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ot1W3rqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26DB10E25D;
	Mon, 26 Oct 2026 19:17:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC44C10F0DF;
 Mon, 26 Oct 2026 19:17:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 724C344518;
 Mon, 26 Oct 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793042240;
 b=2sUkj69HqBdLnhfEyj3veYEKJvzUIr/lVvu4lpPhLY3yGgbmNIukt38cgCueKZCKN1Qz
 hP3G91hNWiFt70z5fiLsbU5ZdCulJHkv6D18VX14JOssbVsQrdZX1B1h+hYhsAuVFhma+
 k12r1Vhnwaq2uv5uF5R470cyYA0ruphu/yNpE0ClwMxiiMI8zEzh+s1fV6qwZJrJBqG7Q
 MICpSseJa8EI/3ui4QCBWgJIkptvSYcHAfr2n+PaFECu9X4rZ2chjbEKLt1pJB7SAj5ds
 xkEJnhzBBfWPjINvlCpW7SItRcq94h7bVxWVGXU29kmBqpEDzKnR8+YApZaaiVttV4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042240;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Fj09/jauXkz5U9D12Z3ZmVr1su41ljj6T2mjBFgcV/8=;
 b=LqooaBIEIHvmhl9oR+hKs67c0+bJ8ilsTV0Lb2eD1ORPnjx+D3BI6bRXADwViHIrkaA/
 TKoW/NnpKvVoRu0PZ3aqGdq9hR2zt63KBb5B9fXUejL21voQYixBkLCMk0vAqW4bl1bNx
 nbFQi0tLZCRVWJmjvTI/r3X8ahAchZ2hZ2zT0VNZBrjpzTJtjvSl6kFs3gSOwpyrSVKc9
 45hZkWe67altKnIc1o+4rYpAYuchm9CBBUzQsuldAiyv+2/j0e+qYlXklOYDG58xZJfHy
 w5xC7ePA47iJo+Em2SWJTEFPZ3aW/VHF8BkNzO60iLQw5fyqORtuYwgQn0v9rBbnfzw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DA1771F031EA;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042240;
 bh=Fj09/jauXkz5U9D12Z3ZmVr1su41ljj6T2mjBFgcV/8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Ot1W3rqUAVz2AMW37Ple26UIaN0B8z8U9SaUc4OnN+9JE7VPKaU2Ofv8h67GVP6ZP
 yYrKNqecuuNLQQrFOfx+YHHkyOzIqxhqoeUl43lpsere0QaM4+oG1zZoWFZS54/LRk
 VJTeCxemaVFG0TrvYA8MpfhIj697cAzow10OZmWlR6z1DO5g75y3dDLR2WCHOMvoAx
 Kf29DJ43MkPq5xMZ8fPf15KqTWMfU7UFLB2QRVOGvN2EumHUyFtdzbVoKfbxLA87mX
 uJhSxOUoxk90caF/jTCsjsvdaxT8gEMKEq2BGhZm924hoAHJowhoNNKy68YiNiOlg3
 V2KtkSsu7pqFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F3DCE44E60;
 Mon, 26 Oct 2026 19:17:16 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 16:16:56 -0300
Subject: [PATCH 8/8] drm/msm/dpu: reset DSC_CMN_MAIN_CNF in dsc disable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v1-8-f46130a8a717@gmail.com>
References: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
In-Reply-To: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Xi Zhang <xz.ca.cn@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793042236; l=1211;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=wGiN+gugp5FNldO/Kg3sFcSJT75myNdU6h5lxozuNKM=;
 b=nZsMcnqOnHbzY5XUKzRyVEOuXUJzxph+ChWqkFDxajHQLKX7ODGcxSaWtu3dJ/g1DTLbZ35fj
 Bk/lg76NhylDt2yhCP9gqPDgJf7pbvrQ9fVMgbXzok2zcQP0f1LC/fE
X-Developer-Key: i=xz.ca.cn@gmail.com; a=ed25519;
 pk=aRUll5L3eJbwG8Y4BO9uySKGzm+Uy+Ccei9prnRVZRs=
X-Endpoint-Received: by B4 Relay for xz.ca.cn@gmail.com/20261026 with
 auth_id=1328
X-Original-From: Xi Zhang <xz.ca.cn@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: xz.ca.cn@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xi Zhang <xz.ca.cn@gmail.com>

From observation, DSC_CMN_MAIN_CNF has hardware restriction on
differing values between paired even/odd dsc.

Reset it to 0 when dsc disable to avoid issues when a dsc pair
is later used individually for each of its dsc.

Note that currently dpu always assigns dsc in pairs if possible
for power saving. In the future, it may be desired to assign
singular dsc if possible to support high display count. e.g.
when dsc for DisplayPort support is added.

Tested on Ayaneo Pocket DS (SM8550 Kalama)

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
index b3395e9c34a1..b8a330d813e6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
@@ -78,6 +78,7 @@ static void dpu_hw_dsc_disable_1_2(struct dpu_hw_dsc *hw_dsc)
 
 	hw = &hw_dsc->hw;
 	sblk = hw_dsc->caps->sblk;
+	DPU_REG_WRITE(hw, DSC_CMN_MAIN_CNF, 0);
 	DPU_REG_WRITE(hw, sblk->ctl.base + DSC_CFG, 0);
 
 	DPU_REG_WRITE(hw, sblk->enc.base + ENC_DF_CTRL, 0);

-- 
2.55.0


