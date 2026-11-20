Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499B6074D1B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePsBgp5F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F39112B76;
	Fri, 20 Nov 2026 14:59:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830EA112B68
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69FB745EAF;
 Fri, 20 Nov 2026 14:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0AC1F00A3E;
 Fri, 20 Nov 2026 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186723;
 bh=zeppE7LVFpT4ixREhQAvnAo9EaUcYJOvEQxsnRwbRJA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ePsBgp5FAUdj2/X6RI3OZ6IrmPekwJ7PGtNkTO//lFReLTwWN0kEzheSMu0uzJeyw
 JDja3r7Nh3LQc1cch7dLxKQmaPLRXxFONjCexpktIo5PxF8RTNfY0az2H30FFmmi8V
 DW+4qqkw43bpnt+Syl327/rM27r2qcGidgKmZfqr6J4ANihcaNPP6oUDvFe7c3hCPN
 4VK1BJ5L9OxtK6Jdct5Ov5gWMGPe3SCnXgxUlY/ZtBDmVetdt///ESap9iHE/gdO05
 NydSw69opcKBIicvb4bzIInRKeVarWvt+1FbN8iAjC3Ovj8H46gqyNtjFcusQyM3h5
 tYjeEgEJpSr2w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:43 -0600
Subject: [PATCH v5 19/19] accel: ethosu: Reject IFM broadcast on U65
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-19-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
In-Reply-To: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IFM broadcasting is only supported by U85. Recording IFM_BROADCAST on
U65 lets a command stream reduce the dimensions used for IFM bounds
validation, or skip IFM validation entirely with scalar broadcasting.
The hardware does not implement that broadcast configuration.

Reject NPU_SET_IFM_BROADCAST on U65 rather than using an unsupported
register command to determine the memory accessed by an operation.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Closes: https://sashiko.dev/#/bug/linux-c74c700c-c823-4b8d-8c90-14842935cdf0
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - New patch.
---
 drivers/accel/ethosu/ethosu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index b4544298742f..928764de2e2c 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -1255,6 +1255,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.ifm_upscale = param;
 			break;
 		case NPU_SET_IFM_BROADCAST:
+			if (ethosu_is_u65(edev))
+				return -EINVAL;
 			st.ifm.broadcast = param;
 			break;
 		case NPU_SET_IFM_REGION:

-- 
2.53.0

