Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF82C61DD4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0032010EF73;
	Thu, 27 Aug 2026 09:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAK7KJz7";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC4A10EB88
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:25:55 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c252ff776efso38716366b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787768754; x=1788373554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2AANzETdmnhX2GAGuIhUsamI5Im+2Kfn2eShC6d5HLA=;
 b=QAK7KJz70xYSZ0ehyR0cfmrNe8U6P04BmiSOuhk0v4H7CwV0VDWEBYTJRa82WBD/U9
 pFkoLLOcJZ8lGnyxV5Zr22L9QW5sxj69E8SCcmaOlNfBewR7SySwqtZgoXuHNiCgNmZ7
 OTFdm3z3b6KwjBeYyUpmgDn5tOTldf+YEWJUq/T7oStKF47V20ZEJqXwdkXxsAbtlK1P
 jPJK4ipO0IIilGv5m4uKuXPtoUaLDvcnJVzLZQa8kq+0cKFCIa7x3Wvg34u9SrtlNmOa
 2r05wFEe+zrAxAffxVyyTrNPVrWMq2GdSaWemWpVRpp3zKjcq7eXEVmJzo0WifGXeg+T
 EaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768754; x=1788373554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2AANzETdmnhX2GAGuIhUsamI5Im+2Kfn2eShC6d5HLA=;
 b=c7dtCIHPzS5fDfV9jCEPCGmgKecGNFbVHydUw7o5lUV64xii1Vh/FrIahBP1Y7Scuz
 fG+vy3+T5zUwru3ZpTXdAD/yLfZDSdGo2AmFbIoPsOM9ayOzfp2bdlWX6Y7nV3mLu15r
 6MiAnUrs69SSwlu5N1tqQb5qakK0rW9lZfCQc6twU4RXtRt5fDIpz2/I3aONTHGOck8F
 smHD5XaXblLo+PxP0lv8kzHebJUpowJzbcNF4j6QMg5GySQIJ/TkrXlfo+I1bU35v7hb
 Dl0HJOZEGDjfy2Xe8bH+VUX/orGYfQODAGcCMLyi7lMb+noHHzn6C6iqfCd9rtzx8Oi0
 gsJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJJR+MnRjwU3zYWVn19f0VsOmpEq2TbcSmjyb9AjL2jVw38vmmEhuif3NEDPk5Yb0bZCFRs1DF20Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lzjvZ2Br1zovKz88jIvlI9ifjaRht+hLSgg1EZ29XiM5VaK8KO
 O5QPEtwKNbLD2/Zw6YcF6edTuZCa6Q05nMjtCMfYFQvej4n8UVLKNORd
X-Gm-Gg: AR+sD10+uAk6FCz6BIGR3OPvqsR2zgXh9VV6DmFNJKZJ2pbnSbSdZDvWCAItwsbphOS
 RFAchBCdJuxXjElHa9TxoGrJZOc5TgAwbwQV3vAVyG5OabY3c2vAkblZy1dmReU+DvtCy96WD7H
 xhPPeX70ldV5xZpb9a7FyKqqF9o26ynngCGz9minCMPiWR2tfu5gNTN04YoKHp5OMgB1FZ5EwAT
 v25Ae9/4NnlOAihhiXM2oTk57FgojYWoKMpxSz+wWA6C269Q86iB6kHseY7O++Al0962AXydr2J
 O9RSTWPYyIa1yfdHuyaxUhoRWcnJnOlho3G1oCjcVL/kaeMxWlaDm30G9Lr8y3DwKytOuYtrSrm
 r+J4Ci/Z4eEaQT9uMO5rVZMSOJv51NUvwSqoNqNNptWFWvMUUv7F4IqXYfPR/B6XIto4zukdy1n
 aF5RKpwPPs84ZHlG2WEEjxCD/ercC5yeHQDTUA7pv1io0LWcZtxr/jwgpok4KWdEIWuGM=
X-Received: by 2002:a17:906:4784:b0:c1c:49d9:4c34 with SMTP id
 a640c23a62f3a-c25360ae6f6mr120564366b.11.1787768753983; 
 Wed, 26 Aug 2026 11:25:53 -0700 (PDT)
Received: from fedora ([2404:3100:1006:efb1:8177:ae9d:629e:eab1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b43absm612769666b.51.2026.08.26.11.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:25:53 -0700 (PDT)
From: Saim Shujah <saimzst@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Saim Shujah <saimzst@gmail.com>
Subject: [PATCH] drm/msm/dpu: clear pending flush state before physical cleanup
Date: Wed, 26 Aug 2026 23:24:59 +0500
Message-ID: <20260826182459.1506522-1-saimzst@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

Hardware can consume an active-frame CTL flush while the cached software
pending-flush mask retains the submitted bits. Video-mode disable stops the
timing engine before physical cleanup, which then adds teardown bits to the
stale cached mask.

The teardown trigger can replay source-pipe bits after timing
stops, leaving one pending and preventing the first commit after re-enable.

Clear the cached pending-flush bookkeeping before constructing the teardown
state. clear_pending_flush() updates software bookkeeping only; it does not
write the hardware CTL_FLUSH register.

Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
Cc: stable@vger.kernel.org
Signed-off-by: Saim Shujah <saimzst@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 778e231..f3b1fdc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2264,6 +2264,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 
 	dpu_enc = to_dpu_encoder_virt(phys_enc->parent);
 
+	ctl->ops.clear_pending_flush(ctl);
 	ctl->ops.reset(ctl);
 
 	dpu_encoder_helper_reset_mixers(phys_enc);
-- 
2.55.0

