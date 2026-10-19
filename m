Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EC606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlbW/zGR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD15E10F0D3;
	Mon, 19 Oct 2026 22:58:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B43210F0BD;
 Mon, 19 Oct 2026 22:58:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 648E843463;
 Mon, 19 Oct 2026 22:58:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792450717;
 b=pKTDPYMJ/ql56a/MtRYK11k2B4HhcehWb3Lkd5xQqbUGjzuJf2M1vmCc3JE04mOz24I3
 CNVIq+11U3evo82WhKWlNQE1/xxWU95JeHsZ2J94EJGrZ3mqyZIUQmh4d3qDhiSwYuZ1s
 89EEqsK4zNDGVWBPJri19NYt1u+0tZZrUov9rn1HcBD1BvrP9esZBCnQQyBqAJPzVk4wf
 lq4bZDLjy+NR5hKZhSDxyVp+w37397Wj5PSBr3FQaNADNMVCzkWUTp4FLsMzf7RCS3k5V
 SljNXGpE7FQuvM7/sT9nJPmShafvDuTsK1eD3hP9Vx05IR+iAbAeKr60uM5AXYb7Jlw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792450717;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=oF9kbE4FrJc4QoCAxoJUWmZExOmATfW1i/TN5X5k38o=;
 b=0Drl8Brxq3QDh3wDFm312EeetPzj7UWAdGyeKvSD1WbYVK0siGj/HQXdtQT5LNKPeXSX
 TFk6ldSdL+rdY/TrlQZm3oE4H7VgpTQ00JhiOofdDZ4NgXEs8QY6eCrJ9KVUspsiuGI0y
 VRBrTQ4rFQjzzxT4T1aPqntR+4ZDv42Wao8N/GTiMrxdhRIPsvVOIjpHtCMphlzPJTlvs
 6nzsBjEUx28NalnsS4xGHKUT78Ee9HzxwJv2PgjKP/SOtx6YAvAQ+eVGy7NbtuDvnaVrA
 /P9VQ9EU1h+XqeQPSV7ukflZerHXTnQajiQrdSz7c48QgQ5umCJVVhLr+BgTD0s6w3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AD0881F000C4;
 Mon, 19 Oct 2026 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792450717;
 bh=oF9kbE4FrJc4QoCAxoJUWmZExOmATfW1i/TN5X5k38o=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=XlbW/zGRmyihaPd/rTmlWRKzXbFwx/l98R9HmCdAy30LdiN/nTYOs9uOBTcUiz8/4
 V1lFDIs/fYsbbkFKQdMGhSTkr1pfDvlAdkczdRdSpSTPhKbHNI0JdcL27EtPHs/K/w
 0I9WlCyFZt4tYsMBimvchTNapwytZOEaszRDbbMWV0V4smsxnbHTBkB2iKJcd11RhS
 hzKsKMowCb0zCz8sqzhF0ePeb4mL/cZQoyMPCB3qOHWDkUQNwO9j1aD/dOdmnEpJg8
 v9yihi3NPbC1rqIe1bc/9hCXeGqLvzNIt7hYIrZLMsJLh8Y0CnGEysWRKL3m2ai5UE
 PZJhGMR8QvTjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 122684066C;
 Mon, 19 Oct 2026 22:58:35 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Subject: [PATCH 0/3] drm/msm/a5xx: Fix GPU stalls on A508, A509 and A512
Date: Mon, 19 Oct 2026 19:58:29 -0300
Message-Id: <20261019-a5xx-gpu-pm-v1-0-1d0c313a1412@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE2i9e8qYkENRoKmRZqIuyuW3
 +K9CywZJgtVcIGhky1vq4cIA1BTu46E3HuDjGQmIlFimzqHoz5QLzikRacSIhkXOfhCGxrYfbe
 6+W2Pbia1vwu47wdObs2ZbwAAAA==
X-Change-ID: 20261019-a5xx-gpu-pm-f58bc4ee2387
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792450714; l=1795;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=us9I1iHzLIQSmFdFtzb+mI4Kq6bVZAX/0wRFxM1gxEU=;
 b=yBtZ31JfvvOQiXGu0NMVYS4PaAwEKsTNMRr2L2tg0S3tDPCX9z2RvBfBUtFfF2lXzZEhnWkSA
 F4ysQyEpiWnAaEx6ZZTUVdmtUr7Tf9MB8Aj/FL3CtWzI3NrS+96Z+eT
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
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
Reply-To: fabricioakio@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three changes to how the A508, A509 and A512 power up and down, found
running a phone shell on an SDM630 phone. The first resets the GPU on
every resume: on SDM630, SDM660 and MSM8998 the GPU's GX power domain
belongs to its SMMU, so a GPU resumed soon after suspending keeps its
state, and its CP runs stale ringbuffer contents and hangs. The second
holds a CPU latency request while the GPU is powered, as the
downstream driver does: on SDM630 the GPU stops executing while the
SoC is in system-level power collapse, so a submission overlapping
such a state would stall and trip the hang detector. The third powers
these GPUs down after downstream's 80 ms idle instead of the A530's
250 ms, so the request is released when downstream releases it.

The second patch adds code next to the first's, and the third sits on
the second.

Tested on a Motorola Moto X4 (SDM630, A508), whose board file is not
in mainline yet, on sdm660-mainline's 7.2 kernel. The stall the second
patch prevents was measured with an SDM630 system-level idle state
that is not in mainline.

---
Fabricio Akio (3):
      drm/msm/a5xx: Reset the GPU when resuming it
      drm/msm/a5xx: Hold a CPU latency request while the GPU is powered
      drm/msm/a5xx: Use the downstream GPU idle timeout on A508, A509 and A512

 drivers/gpu/drm/msm/adreno/a5xx_catalog.c | 21 ++++++---------------
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 +++++
 4 files changed, 40 insertions(+), 15 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261019-a5xx-gpu-pm-f58bc4ee2387

Best regards,
--  
Fabricio Akio <fabricioakio@gmail.com>


