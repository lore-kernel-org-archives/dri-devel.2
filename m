Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174B606A33F
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Kpr5Rdgp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xKaqqu4H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5084310ED24;
	Sat, 14 Nov 2026 03:06:38 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6EE10ED1A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:06:26 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id CBAFC1381A41
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:06:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 22:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625585; x=
 1794632785; bh=wtL8onRsQa4FKNucUOeBmROB3ML/t6UwjP7ZuXv3/oI=; b=K
 pr5RdgpKbzBMcCWa/EymVsCyNVmFzFNIGSxDEIUjO3sWa+wYwYBmkEzxCezijKjK
 NRuDnFZN3PP0oVqFI2cobfIRhdkE16a/SuG6xPYl0Y+6rRZPaK0xH6XuSxX7ziK3
 ZWMpTjqxAMDpo/Ojqjog5R2dWRn4EfWYDTUVSIZTMfCjaXe2XApPJVzsnmE2ZZIk
 mGI4/7wReCmq2Btz7S4zcaMzdVdxGlhrSajZErQE19s5uyFnsZ1zSYqbxQb+rU9D
 y1Vcbk5JMwfd3P+/er0ouE1LHttYQRzTmp1Z8hXeUXcGestELBPWUrGqZzR3rNH7
 uTHUZPgtSiyf0BwC1pxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625585; x=1794632785; bh=w
 tL8onRsQa4FKNucUOeBmROB3ML/t6UwjP7ZuXv3/oI=; b=xKaqqu4HUQfaSG592
 DsVGXsZG3rhjQQxnZ6eXRFR/+SnU/FOQGcLD1sUWMT45FX354IXAiddRrDW7k1y0
 HnW8PiFh1QTIeJ2Ac6IrD2QG3rWTo0940/hPl1NHqgAvUVTgkPDS/5V/4n0sYwlU
 2FFDb4GmPDCiPClGZ4iJcK+esnTNUfrH60n0V7W1d+maCIj7F5ok9yclsMTz7os1
 chIlpOqDlSw4o4FqBZp14Y0mAzDU0CcoofR2iNHZ3wKLZVMSe8qoYF1nPhYiYJc9
 vf5ZQHc1dJWTlQ5nLoZjjGwGW1LN2p7NOdKNoVmZDKXVR9Bneh2JaT70yujXC3Yp
 6nvvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625585; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:AtHGo4MLBiGrHb28uOX6NYIBS/glYurQHW+IrdGASB6zuss
 TD8tcusi2awcK/XNVw/A9pyNMp/b+Zm9MMEXHxhequXP5q4LKzhuhE12QZOZ9kal
 F+JYhH51T1DmYVo9pGgDl9qCo6Kps3bCg7reaB7kUkiId8O+iR172p7VsLXjzyYk
 Fn32bE2924SQAwaoHKhGgsrHtxp3CT0KQmZBKAWaboFkGSSuXUHlOfT6HNsXMZec
 /zdYKYfIi6IN3ti+KY9RvuEXNWGraF0B6F0wvcGBv2nIYn2MabD96V5tn11ZsHhI
 buiIbKrAfVBxavXjjnnt0OKCsqkp8FnTMX8mleQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:INdvg0qswqI5TQqb/MaDFU5u4GadFo5mddg+YZCPnvU=:Iw4QifsNe1TTda7rjuxndWE+FvFi121RwnltSrgn99Q=;
X-ME-Sender: <xms:MdD3aqiDAVNw7OwBvdrVzryE-MKMGEtUOpKhgVj_tIGgY2Hj126lTA>
 <xme:MdD3anJJrM3pGx9wyYqOco2Wx6QLofz4C_n5o1vT_WmgNAl5Azb1d_uF_k4FDGD5l
 3kQJwYo3rrQtMGy1w1WRPZb_az1fhnENw08H87s_J7eqpeegLE6MxrZ>
X-ME-Received: <xmr:MdD3arXNxKpnggKwMXLc1mPZxR6hhKcu93CVedzm67ZKaC9aYrH_ksA2sQi_vzy7NISm6_SY>
X-ME-Proxy-Cause: dmFkZTFN5n0M1sV6hjRMacCSKdAr6N3pS+YE/TAdgAdeT3jNjadOVj8g7xjlVeELRx26FA
 0G0s/13un4dx2MLumLLnXw/bDau5lHSXUFFcLd8xXzubqCUqxYW0eIugGDBbsbMXcrdwNs
 DCDuOlbXPQ6dLCdPvHAzxuhqdFHhqq5Ji+odz2rHSfwVnpXQwQ1U+XtJQ8keYfCbYGYg4j
 vcn9bmBN/0vZ1vtPpoUx/4lGsjr+cPNQKgUdgU73aancAkK88dELEBioTJzSpO0HE/6gQs
 fg3JNPMD10vRZQ/dYub4Kqo7W/dVZJu0mN8v4TxzqUqDx+ytDhdOnQ6y0whNCoF+vNdRIW
 2o8EGYd38qa+8FmZmEf5zeAhwPdOhVaRGDaPgduPu0uKLwhXo6ySbm+pWYSKdrgu/od7FE
 u74gd3ecTxTxaVXgg3wTw7fODuGenl7/ZQlIm89BYUREUKRPFlxar48WlpGYct9R7TLtIH
 iHi8GLK+e+lhpn0WNZAaLwc/EPbRl1nc9fY40DHK5bBFpx0mR/th/1lZBtBPSNfHRPr/a9
 czscFtip1n9UwtOn303d6hsu7Az+eIQqqwgSc/vSnvjnflpefNJrBG+weXFjsyUM0I7v5+
 dVAa9AOr19qqponHvgOHzvAaIBxoHrAsXawq6+j6ToDPKTUv7kdMt6cBeK9g
X-ME-Proxy: <xmx:MdD3aiWZW3NEY51NfPicUrFbM0IBCH8wmybu7z1hokHxgW5Qw3AJnQ>
 <xmx:MdD3ar9pMwSrkzGOZz219xqIvwEeB6FSeVrpTf1vUExlxBxoTKJLyw>
 <xmx:MdD3aiaV2-2ydPz-j4nRn3n06yrSR9JK2PU0w88WcBxGNx4Fi12f1g>
 <xmx:MdD3atAnUaOKWqKm0nECuEhdxyzgR5hI8IehJEmP4trfIBlddvG1pw>
 <xmx:MdD3arYtnfe_jCpUYVN81Z8aJ1GnK1Mm4wfm-8Z_Ds3vx4RJ29R6O-je>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:06:17 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 04/12] accel/rocket: let the core suspend after a reset
Date: Sat, 14 Nov 2026 16:05:21 +1300
Message-ID: <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The reset path drops the runtime PM reference with
pm_runtime_put_noidle(), which does not let the device suspend, so the
power domain is never switched off and on again.

On the RK3576, powering the domain on resets the NPU bus interface. If
that does not happen after a reset, the IOMMU may not respond and the
next job after a timeout fails.

Use pm_runtime_put_autosuspend() instead, so the reset path handles
runtime PM the same way as a normal job completion.

Also drop the runtime PM reference after rocket_core_reset(), so the NPU
core stays powered during the reset.

The earlier test on the ROCK 4D was done on the v15 code: the job after a
timeout went from all 128 channels wrong to all 128 correct.

Repeated resets were triggered with a 2 ms job timeout.

v15 (put, then reset): tested twice; both times the board hung within the
same second as the first batch of job timeouts, with nothing printed.

v16 (reset, then put): tested four times; the board never hung.

So moving pm_runtime_put_autosuspend() after rocket_core_reset() avoids
the board hanging during a reset.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 8b4ad028bc9b..41c723238b2b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -397,6 +397,8 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 static void
 rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 {
+	bool put_job_ref;
+
 	if (!atomic_read(&core->reset.pending))
 		return;
 
@@ -415,11 +417,10 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	/*
 	 * Remaining interrupts have been handled, but we might still have
 	 * stuck jobs. Let's make sure the PM counters stay balanced by
-	 * manually calling pm_runtime_put_noidle().
+	 * dropping the job's reference once the core has been reset.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
-		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+		put_job_ref = core->in_flight_job;
 
 		iommu_detach_group(NULL, core->iommu_group);
 
@@ -429,6 +430,9 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	/* Proceed with reset now. */
 	rocket_core_reset(core);
 
+	if (put_job_ref)
+		pm_runtime_put_autosuspend(core->dev);
+
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.43.0

