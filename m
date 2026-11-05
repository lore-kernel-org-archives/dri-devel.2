Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66A606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns4YtAbB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3AF4112445;
	Thu,  5 Nov 2026 13:30:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70479112406;
 Thu,  5 Nov 2026 13:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8C0F60F1F;
 Thu,  5 Nov 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793885424;
 b=VU/qOoITT+8IGp5aqrZGQkERLeu987mdrTNX6bMQb5jKkKeUXaqcqly6dEkfFxtn7Dcr
 Q+wVVIgRcOiIHadPaVnywTHAg8JhzJNwoL7Fyi9N1LECJKPPos3qV1d8ZlvDYNJyZ67Uc
 zirGGO7F7zwrcXSyajUCxnm540lmQRjY3Z+f0E6jUsNyQWU+GwYgjEGgRXIc/VvaCfGCm
 1L232oyhgNoBOVMBBLuYon+jHqFwZYeIGSCTCOqHNi3T678rHy7cOwx4y27E+SY016YvF
 lejnPRSOxoc5qpMhn0JH3CLxSpm62kK9UYHpR+n0LkcGXav7JbzhI8oXUocvCSUQPWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793885424;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9QftwU9ORp2x/ArLygafHmJy8jNXwbbSvrMnqe7Q60w=;
 b=f1SFt0lynDR660U6EynF+Bz2G1IfZof0KFGXJ6OvmvrJpQwEka78RBPjnvU+s03922Rw
 hnJZT4JEAO5ffaNHYp49nX80WTVefnSApRe1aSMGTCEsHmrqv4RIzUVumm5n6z5hXjSRW
 BFJveMBufdb//+18wouoSNsgHooSzTDWbcH/4hg5L2lrYHgzkKW6N4Em41BDmao7n21xJ
 cZw+1DkPNwaCem+CdOP4l1RU8lfGa5gg+J3elwsII8Mvg431ZbipKU4y/MXSEFTjvEaFP
 a3acbgS/TkKDEeYl3Bh2qfOBN2Zwi5RQTkEJzA5IDMIfCmpzgoKQpoCg9z0EI+hUAig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 52A541F00A1B;
 Thu,  5 Nov 2026 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793885424;
 bh=9QftwU9ORp2x/ArLygafHmJy8jNXwbbSvrMnqe7Q60w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ns4YtAbBO3OEc1Sn/ElT4zTIT66031XRUh0G4e9rVBsWnouwl572+ooF+a/Di9NoW
 MgtURyYWFsm30DC9l6Z3C3AHbv4I2itLaZbpeaYRlkJMPMv0iYu1uFfENcJwAfSAm/
 TK5nL9g/lUjytAQF+XM5zv0qJRJnhRMynkZdmfWfxVMys3d6HWLn2pcN+2Ft76AVJh
 VM5GbM4pp469jG/7VTmdjbRq0x5uIJ4C4lwTOpAaeWnc/v122adNEgtDok4SjVsZWi
 L7wl6B2GWDX3ahA0qEGkvZRdlOrwNiTdu7YJofClQETXOJjwG+5UsUz7Xq5cqA9vQM
 XcLfrI8VhRS0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D1C804728F;
 Thu,  5 Nov 2026 13:30:22 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Thu, 05 Nov 2026 13:30:02 +0000
Subject: [PATCH 3/5] nvmem: qfprom: Add the SM8350 keepout regions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-b4-sm8350-gpu-v1-3-a7175cdd6512@fromdisposition.org>
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
In-Reply-To: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Demeter Barna <me@fromdisposition.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793885419; l=1841;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=CDGO3hvRW7mymx++dDNgiaLDX/wtQ9qU8oYZYFNQPZ4=;
 b=fWovVqQLQJoPFa5Mc+441Nuesv3cWVgzRKAID6ngbH8CEfzc2VFXlf9TNCgPEeqS12fu0exvC
 beHxHlr/rgDBTDCVwwmp4H5SpWalxQsTkMBKlmQb3Ra/PQJiXiNoqs3
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
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
Reply-To: me@fromdisposition.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

Some SM8350 fuse ranges are protected by the XPU, so the AP cannot read
them: a read in 0x0-0x11f, 0x128-0x147, 0x640-0x8df or 0x2110-0x216f
resets the SoC. The nvmem file in sysfs is readable by every user, so
once the QFPROM is described, anyone who reads the whole file resets the
device.

Keep those regions out, as for SC7180 and SC7280, which share the
0x128-0x147 one; they read as zeros.

The regions were measured on a Razer Edge 5G one 32-bit word at a time,
and each boundary was checked from both sides.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/nvmem/qfprom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 1de3435df..24958ed79 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -124,6 +124,18 @@ static const struct qfprom_soc_compatible_data sc7280_qfprom = {
 	.nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
 };
 
+static const struct nvmem_keepout sm8350_qfprom_keepout[] = {
+	{.start = 0x0, .end = 0x120},
+	{.start = 0x128, .end = 0x148},
+	{.start = 0x640, .end = 0x8e0},
+	{.start = 0x2110, .end = 0x2170}
+};
+
+static const struct qfprom_soc_compatible_data sm8350_qfprom = {
+	.keepout = sm8350_qfprom_keepout,
+	.nkeepout = ARRAY_SIZE(sm8350_qfprom_keepout)
+};
+
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -460,6 +472,7 @@ static const struct of_device_id qfprom_of_match[] = {
 	{ .compatible = "qcom,qfprom",},
 	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
 	{ .compatible = "qcom,sc7280-qfprom", .data = &sc7280_qfprom},
+	{ .compatible = "qcom,sm8350-qfprom", .data = &sm8350_qfprom},
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, qfprom_of_match);

-- 
2.53.0


