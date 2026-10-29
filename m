Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF8606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0e4NsD1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5641122F3;
	Thu, 29 Oct 2026 13:37:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F34B1122E2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8978543CC0;
 Thu, 29 Oct 2026 13:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BD21F01828;
 Thu, 29 Oct 2026 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281015;
 bh=XWixsvkjfQoDzoGkXjo8KZzGPvcGFb954ro+EZFcpJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=e0e4NsD1lGvKyqrV3VnfNphHmz5FpKLiKO4BIxxKiZ21nSsM6gLVmal7MUiHhR5gU
 TbZzpATqrufvycnq3jqqkpxkgRuulWOSFdPxSvepnZh7pBTGYL5vGB4uPpM4qBf8F6
 1otU3j1YSFuHKHylmHFHaZdrGjZKBcCf10DhwvoxqRsVdi+8F2omHx0Mv14mFdP+Oq
 hlQqQakwTNO5FoJhSNxs3dMUVGlCExEDlLScNKDkpCw/JXEFOfoYU2lARuoDvNG46j
 B6kT4+tnOTpcgLdhql5f463Cij9jN44vFQnzH/9xLdGyWp+u3bEcToxFTqW23mcW4L
 hHB5JgBtKTo7g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:12 -0500
Subject: [PATCH v4 25/31] accel: ethosu: Restrict dynamic IFM2 weights
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-25-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The validator bounds dynamic IFM2 weights as a 1x1 weight matrix, but
did not enforce the corresponding kernel shape. A larger crafted kernel
could make the NPU access beyond the validated IFM2 feature map.

Reject dynamic-weight convolutions whose kernel is not 1x1.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 406e1c07246d..117046e5a61f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -598,6 +598,9 @@ static int calc_sizes(struct drm_device *ddev,
 		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_RIGHT) ||
 		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_BOTTOM))
 			return -EINVAL;
+		/* Dynamic IFM2 weights are only supported for 1x1 convolutions. */
+		if (ifm2 && (st->ifm.width || st->ifm.height[2]))
+			return -EINVAL;
 		u32 stride_y = ((st->ifm.stride_kernel >> 8) & 0x2) +
 			((st->ifm.stride_kernel >> 1) & 0x1) + 1;
 		u32 stride_x = ((st->ifm.stride_kernel >> 5) & 0x2) +

-- 
2.53.0

