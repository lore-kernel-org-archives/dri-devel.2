Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D533C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F4410EE86;
	Wed,  5 Aug 2026 14:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QyZEkpjs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0C010E231;
 Wed,  5 Aug 2026 14:02:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3563C60A75;
 Wed,  5 Aug 2026 14:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0FD1F00A3D;
 Wed,  5 Aug 2026 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785938551;
 bh=XRWb5KOEVWDmj5XvuNebEun46fEu4tFzPd9o5ylH/60=;
 h=From:To:Cc:Subject:Date;
 b=QyZEkpjsxpr2YCaxgQqR5NWoEfyHbZJxScOtLPPp7eRjwCmkd3k0Brz7k4Zz6YuI0
 6RUz1/MdItBOCUgsM0s5jGAdU0+Qj50Ao+Bi6fpN9LcApF9n7OypTQCFjpooaHeREY
 54GLQHgC2I4Z+8En3jmbyfzR2taHvq9yvM5B54qJNYesygL4SYtVHT6FwvAnjhQvcM
 5GbDMyYoYgWidBeZ3GzkMMkkIg7gV8ov3QHQ2iuWddf9Xk/VAsr0wOG+0YjWhPYX/N
 clBVQeX+1ruLsPq9q6CpMVEwRFxBJXznry38lmVmSQ33mPe0+FWw6DDbnhzgz/7Tqj
 xBl6ihwoyVY8Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 7CECCF40066;
 Wed,  5 Aug 2026 10:02:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 10:02:30 -0400
X-ME-Sender: <xms:dkJzau4kz14AEHEXjYpAdT0osBQG4fTK3PxOvngTzGlJ7By4ZwXhVg>
 <xme:dkJzatfse5xkoE5xnievQ4G8RcxJdQThBBTShA_ytC6BxbCrYUetcVTKhVdpuKA7-
 vm6Kx5clCqGnmzAL10bdeh8os_zkab8gabNB_aqywV94o9bkBT2vkU>
X-ME-Received: <xmr:dkJzanCJEtSjnuDFQ4jvyLVWMW5Ncz15tOGJCMQ1mvIE9glLa71TgkNPm0DgV_QHfQYRn5CZCwSgyGlVVVIZBDUxaIKkV0SQ>
X-ME-Proxy-Cause: dmFkZTGRtrYNZhF5JTvsGTULw+IUY/287ZkyrdsJTMA43wyXDuUUdrHB1Jr4B1EpgXztPA
 bGqSq+xQYNExBYBIlpmDi/vCofWluj4tPrdHN8TuaiLfiOjkZtBEupEh7uWywWVf3lgCsz
 8dndqHaz+h0+jaVMH1l1+RR1vf1lLJCOMhxtZNwbCy17lkoUyDmsFsTGfhA5h9abwZrWIX
 jt54JnDcdlwZ7fGWPCMBMTqY79Da/HgQ6dLFTf/j7dLOc0ZFZIn0DwiGGVndev6yt90ZY3
 9YbidWxHc2qRIYu6LWbkLCfZn9BGng5qCwdYjLuv9i/TpljCo3XuozHKbmd38y1/ivXGMo
 CbCesWkux3qM4m87XUG8TsksWyUKhGmQX/QJjbriw/npW7ZE0pksR5PP6VOWoHY4sEEPQ/
 gJzQx+Jon5fz1A5ohM1ySeeKjSvuxf7lKaHnwtp/s+YXlSfuhIsC2gSJYFp+yybpOXgkRL
 VJcCa76/Aa/QJJHsYmtzFM9KkpL2weU1mvDnMOo7ugaG9ZRPbZ07mUl6P63Xzr04OuqlAG
 4E0LjMag1b1jx8xuyfWizzvx+kToCjLc7k8XXFz4ie0m9B6oOwo+YtfcOTFCdEtPlJsz2a
 kJbduhsIv7CSdmgXWfaHFdJ+LXsFYPfoz5LowliIqI/4wfLQ61x5x6XrAgcQ
X-ME-Proxy: <xmx:dkJzasBiJaYqOqrCxs_zE3I7eNiKszFDI1EKzElMEDxNnWKNC_HRtg>
 <xmx:dkJzapann1NaW3zNMRZ2Zk-sCv5tBB49-_pbPiubEAxTfHr_ijOn8w>
 <xmx:dkJzapxqOW8Lkr1jaAfsbKHrIY8ot4QqzonvKUIHetJ_rKl3qKPLhQ>
 <xmx:dkJzakfKCVH5xjgsrT6-gmVCQ2cx8F7Ys-PzVVL-TAKyxDJQftY-cw>
 <xmx:dkJzanJok5Q2S6Jlu2a7M4AC8U_PMpijjhTrnJ_6CwjmHbj21NNBvpqd>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 10:02:29 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Boqun Feng <boqun@kernel.org>, Mark Janes <mjanes@netflix.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, Priya Hosur <Priya.Hosur@amd.com>,
 mythilam <mythilam@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in gpu_metrics
Date: Wed,  5 Aug 2026 07:02:21 -0700
Message-ID: <20260805140227.44868-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics can
be observed by running the following command:

    ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
    ~/sample-10s.mp4 -vf hwupload,scale_vappi=format=nv12 -c:v \
    h264_vappi /tmp/output.mp4

This is incorrect because the value is supposed to be in [0-100] range.

The cause of the issue is that the metrics.VcnActivity reported by
smu_cmn_get_metrics_table() is a permyriad value instead of a percentage
value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 100 to
report the vcn_busy_percent). Therefore fix this by applying the same
division in smu_v14_0_0_get_gpu_metrics().

Reported-by: Mark Janes <mjanes@netflix.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 568665265a13..1058338344b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->temperature_skin = metrics.SkinTemp;
 
 	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
-	gpu_metrics->average_vcn_activity = metrics.VcnActivity;
+	/* metrics.VcnActivity is permyriad, convert it to percentage. */
+	gpu_metrics->average_vcn_activity = metrics.VcnActivity / 100;
 	memcpy(&gpu_metrics->average_ipu_activity[0],
 		&metrics.IpuBusy[0],
 		sizeof(uint16_t) * 8);
-- 
2.50.1 (Apple Git-155)

