Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB660A3816
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKllHen3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035BF112B6B;
	Fri, 20 Nov 2026 14:58:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3693E112B68
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E31A46C14;
 Fri, 20 Nov 2026 14:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD02A1F000C6;
 Fri, 20 Nov 2026 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186717;
 bh=tm1WIg0O1FFv6Tly0Qt5Lzt9aOxoUsNmPJ767y2Zuf0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OKllHen3/BRHO8tIIFT0wGvq/Upr6By1pPTklhPNrfJ12T2gemm8kkrymzNRt64H1
 hH32b775X3zTl3PwiHhrqzdo0Eg2RE6F800dAFIZF/WIfXJLi/HEBuJrd22JBGZE8H
 n9Ok7WEXdgH5xkv5q2dSJeHgah/7cdLNa5i6MRcLAt+XFxLtvPe8Ze20Kmgu+YgRTW
 Nro44ibddHnCLy7vj/Llb2rKKRUMLIbHhnmNi5oxwE6UenpCXR6Y6qiXOaNB2ad2fn
 OCpbwcW/zTSsAhaRykm7fq/X90z+LMLFIMYN83RGOo/QGHYvV/MDYljGx2SvxnzR0K
 JfVJ0gNbqXD1w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:40 -0600
Subject: [PATCH v5 16/19] accel: ethosu: Ensure cmd stream is multiple of 4
 bytes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-16-52d459acdb84@kernel.org>
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

The command-stream validator consumes 32-bit words, so reject empty or
unaligned streams at that boundary. This also prevents QSIZE from
receiving an unvalidated trailing byte.

Check that the second word of a CMD1 command is within the declared
stream before reading it from userspace. A word-aligned stream can still
end with the first word of a two-word command. The old ordering read
beyond the supplied size and could return -EFAULT instead of rejecting
the truncated command with -EINVAL.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - Also check length before get_user() access

v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index ff89cfdb4772..fc31372a2c08 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -977,6 +977,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 
 	if (!info)
 		return -ENOMEM;
+	if (!size || size & 3)
+		return -EINVAL;
 	info->cmd_size = size;
 
 	cmd_state_init(&st);
@@ -997,12 +999,11 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		param = cmds[0] >> 16;
 
 		if (cmd & NPU_CMD_CTRL_CMD1) {
+			if (++i >= size / 4)
+				return -EINVAL;
 			if (get_user(cmds[1], ucmds++))
 				return -EFAULT;
 
-			i++;
-			if (i >= size / 4)
-				return -EINVAL;
 			bocmds[i] = cmds[1];
 			addr = cmd_to_addr(cmds);
 		}

-- 
2.53.0

