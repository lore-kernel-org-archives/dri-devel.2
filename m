Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964C606A681
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=AZZTwj/S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=NHG3ADmw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=O5hz/+Lj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7BB10FA26;
	Wed, 25 Nov 2026 08:43:17 +0000 (UTC)
X-Greylist: delayed 344 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 12:26:25 UTC
Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5483B10E866
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
 s=2021; t=1795522837;
 bh=xIaQcj2s83xLPfozpMSbM0Bd40toJFIkUkAt/cxZJw4=;
 h=From:To:Cc:Subject:Date:From;
 b=AZZTwj/SegAMDFIzLSKSOBYvkpHYqGrHoiqyC8sLFh3W7SxaDzb5AtmiFktyCTu7d
 yRCKjdebTwaBqy+nsgg/ZLdrFat8SFbJKDwARZrijEJPfVOa/bXSPgDGR0JD5/+jyC
 DBQGyg+yT1pbwx1wE850JfxP2U5yRBFkKVIdX0wQ=
Received: from renesp.vps (renesp.com.br [127.0.0.1])
 by mail.renesp.com.br (Postfix) with ESMTP id 4jYhjK3hmlz3wvP
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:20:37 -0300 (-03)
Authentication-Results: renesp.vps (amavis); dkim=pass (1024-bit key)
 reason="pass (just generated, assumed good)" header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 tempos-project.org; h=content-transfer-encoding:content-type
 :mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
 t=1795522836; x=1798114837; bh=xIaQcj2s83xLPfozpMSbM0Bd40toJFIk
 UkAt/cxZJw4=; b=NHG3ADmwu3myom2yLsGk4b51EzT5juJ1h2tiX8ko9+s65JF6
 Srk2dBiI+hPYjtGVnEF+Ty1Yt28X5cajgT+DYrln4WqOViN3ZH/fN8UgDKVOwk9R
 NW+qFjYbW3PPl6ojDOp4KzNhG1DYRlbqV41EkporQUtjmCUvedcas9sgVI40HhJl
 CaqAO+OO/HC3EmOEUuQQdhDJCtzMb05VLWT8GxPYlg3s1q29/Wks/HLr7bwGFMIS
 w7xtOQHBLCVxOOUN0TNrCQkkkct6WLaLl1Qbes/pDHQCSUWE7QRTKcYKbsgRnA2u
 lEIfpOdKihegPKc8RshTSc1iQ9wxDMOu51VfHg==
X-Virus-Scanned: Debian amavis at renesp.vps
X-Spam-Score: 2.21
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: renesp.vps (amavis); dkim=fail (1024-bit key)
 reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
 by renesp.vps (renesp.vps [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 48pUEtcgNAIu for <dri-devel@lists.freedesktop.org>;
 Tue, 24 Nov 2026 09:20:36 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
 s=2021; t=1795522835;
 bh=U8jsuGQrWb3zRrhzqCiAgcfxcu/AgiSD/CP5GlnXhWg=;
 h=From:To:Cc:Subject:Date:From;
 b=O5hz/+Lj32FDvO9vBL3FIcFU2QDWsknO/elqQxp1g7TLhy3Zc64fxsVqTD2LQrh5H
 eR6x9+Y11Tx6Lf8sQAErXAHMAE0adNpIvLSRL1Lb6nx8xXbW1sWrTgBPj+dUhhFZMA
 o+dHWF0YwuUjKJ94liyR6M+OPoeK6pDaXlFxZsaQ=
Received: from rsp-x1 (unknown [178.20.90.158])
 by mail.renesp.com.br (Postfix) with ESMTPSA id 4jYhjF09RLz3wvJ;
 Tue, 24 Nov 2026 09:20:32 -0300 (-03)
From: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
To: srini@kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: ekansh.gupta@oss.qualcomm.com, anandu.e@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org,
 =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
Subject: [PATCH] misc: fastrpc: fix fastrpc_user leak on abnormal process exit
Date: Tue, 24 Nov 2026 13:20:11 +0100
Message-ID: <20261124122011.2912030-1-rene@renesp.com.br>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit e85eb5feca8e ("misc: fastrpc: fix use-after-free of
fastrpc_user in workqueue context"), each invoke context holds a
reference on its fastrpc_user, while contexts left on the pending list
(interrupted or timed out invocations) are only freed by
fastrpc_user_free(). When a process dies with invocations in flight,
this cycle leaks the user with all its maps and buffers. As the session
is given back at release, the next process can get the same SMMU
context bank with its IOVA space still in use and fail to map its
buffers.

No thread can be in an ioctl on the file at release time, so drop the
references of the pending contexts there. A context still waiting for
the DSP response is freed when it arrives.

Fixes: e85eb5feca8e ("misc: fastrpc: fix use-after-free of fastrpc_user i=
n workqueue context")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>
---
Tested on a Qualcomm IQ-8275 EVK (QCS8275) with a 6.18-based kernel:
a llama.cpp process using the CDSP was killed while invocations were in
flight. Without the fix its ~1.8 GB of buffers stayed attached to its
context bank, and the next process, given the same context bank, failed
to map its own ("failed to map buffer"), leaking more memory on every
retry. With the fix the buffers are released at close and the next
process works. On mainline this is only build-tested (arm64, W=3D1).

 drivers/misc/fastrpc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cdc2627bdaf2..09a2963d72f9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1725,7 +1725,9 @@ static int fastrpc_device_release(struct inode *ino=
de, struct file *file)
 {
 	struct fastrpc_user *fl =3D (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx =3D fl->cctx;
+	struct fastrpc_invoke_ctx *ctx, *n;
 	unsigned long flags;
+	LIST_HEAD(orphans);
=20
 	fastrpc_release_current_dsp_process(fl);
=20
@@ -1733,6 +1735,20 @@ static int fastrpc_device_release(struct inode *in=
ode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
=20
+	/*
+	 * Pending (interrupted or timed out) contexts can't be resumed anymore
+	 * and each holds a reference on the user: release them here to avoid
+	 * a cycle.
+	 */
+	spin_lock(&fl->lock);
+	list_splice_init(&fl->pending, &orphans);
+	spin_unlock(&fl->lock);
+
+	list_for_each_entry_safe(ctx, n, &orphans, node) {
+		list_del_init(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
 	fastrpc_session_free(cctx, fl->sctx);
 	file->private_data =3D NULL;
 	/* Release the reference taken in fastrpc_device_open */
--=20
2.53.0

