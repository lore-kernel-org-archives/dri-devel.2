Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D26606A334
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF7p+rEC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D05A10E0CB;
	Sat,  7 Nov 2026 20:26:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D58C10E0FE;
 Sat,  7 Nov 2026 20:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F464438B9;
 Sat,  7 Nov 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794083172;
 b=qSFMev/Kn3CHGOGCZLKbAHXQb59wmdDcxcpxu9xXr0Gnybi3NtGqOsNxmJyj6ZA8x1Et
 Z0TqAe1aXI8uk0hBgBlpsSApV20AxdIZj7QvR3IMCfFI9z3CzstYyvww5Dj/fisJnEJX4
 In9ZVTH2SEmlxFWLib2pYE2oH2uQphjOFJvkhmziInG3Omf43xMCL9LIxqAJ+zx627WpN
 NMbwODFxr+eIMennTw2yEVIJEfzpCo6svnFbi0+Gqn1DCZyOIf9hvluK4+32Ut6myJdFj
 X4qbXknIOtDGMJpUWuanFtRz1kcBTPxpyArQz74K1AGXfAiouirbk0Najya5T9YKRpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794083172;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=mInX5ql1Y8hdSL2dSS1wss4rucEdjqMvUx60BAydYlk=;
 b=c2+D/Ml+0ML9Yggw93zKSWxQ4XbEuwPatfzJAlC6Zq87Rif5hcUDO9Wh5UQqyCwjCVy4
 9oeFM9LV2KxNPCz9uoWhkkFvsp+hh5xVGfvlsu3j+3zQHpxER13M5wfPeyGXYdY5aDvds
 iUNxEDYYyQPwekV/7rVyVvcw83MDscO11xJbbDaegJYWyxrXgd723cjFDAW+FPANpIvrA
 4/a4iQ4Mot8LaK4z+3KuFANgib+sYCx2ux/OGzlcMzO3+GqqfiHJaqlZ9oOiOIUlpaV1e
 WyKO6sEMKebxW9oM1ygZBlkPjmMirgDUz6Cpg14GorGCC6KYh2Um+9WRbu6gzhVjShg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0D5581F008A1;
 Sat,  7 Nov 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794083172;
 bh=mInX5ql1Y8hdSL2dSS1wss4rucEdjqMvUx60BAydYlk=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=YF7p+rECqsUm6EyfcXq5TlJoyN+ExZIsblKODD92vFrF1mT3+xKTVZ1XTrZHRPmYt
 jcOsEDYPBdtYLA9EqdRuYfvzone3uMrK6BU/X9i3b0LL8XHb5ad+q9Tlv9E0y35zCp
 AX+4StjfipfNDRahEEqWLsbw62aiS98Y5Gj1AaBjPPjzkZj2JO+u7Fwp554JNfGyRP
 MJtwqVbv0IOyhmqLOTnMtxPotF5r4hGzyc3lE4K9Ua7jsgW0oMdqMjTmH41XSzdhyZ
 qpRWUMyMQSvBaZAuzupxsLD/VVhQnRuvHvO+AQ+plGCCBDjlIjtbHMTLKM5NICdVxx
 qq/77qKgSfymQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 6040447CF7;
 Sat,  7 Nov 2026 20:26:10 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Subject: [PATCH v3 0/4] drm/msm/a5xx: Fix GPU stalls on A508, A509 and A512
Date: Sat, 07 Nov 2026 17:26:06 -0300
Message-Id: <20261107-a5xx-gpu-pm-v3-0-e2480408abea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBQFr0K6tqa/BUFX3sO4aMsHaoSSFhoM4
 e62uHFhXE7yZt5KPDqDnlyylTgMxhs7RBCHjOhODi1SU0cmnPETMDhTWSwLbceZjj1tikrpHJG
 LqiTRGB02Ztlrt/uH/aweqKeUSIvO+Mm6134XIO1+lwNQRqFmWoCQkAO/tr00z6O2PUnlwP+4P
 Lp5UUrZKMWrWn6727a9AZjV/KP0AAAA
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
 Fabricio Akio <fabricioakio@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794083169; l=3229;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=zOocD9OAKC3L83jqC67Z507icBwIJgZhFceeOcw6S5A=;
 b=cY1LOcQELddWUz203MSFnaz4UExS8C9q9xOC4CNgUatrCxYlHrIi9TxA5q7soOudPMxPi/5wA
 w0XJfQrp2t2BAECVe5wwqXko/m2PhlGMV6X0WiYUM2E8TowNGmuHEhd
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes to how the A508, A509 and A512 power up and down, found running
a phone shell on an SDM630 phone.

The second resets the GPU on every resume: on SDM630, SDM660 and
MSM8998 the device tree attaches the GPU's GX power domain to its SMMU,
so a GPU resumed soon after suspending keeps its state, and its CP runs
stale ringbuffer contents and hangs. The reset clears the busy counter
devfreq samples, so the first lets each GPU resume devfreq from its own
resume callback, and the second resumes it after the reset.

The third holds a CPU latency request while the GPU is powered, as the
downstream driver does: on SDM630 the GPU stops executing while the SoC
is in system-level power collapse, so a submission overlapping such a
state would stall and trip the hang detector. Mainline does not
describe that state yet, so the request blocks nothing until it does.
The fourth powers these GPUs down after downstream's 80 ms idle instead
of the A530's 250 ms, so the request is released when downstream
releases it.

Each patch builds on the one before it.

Tested on a Motorola Moto X4 (SDM630, A508), whose board file is not
in mainline yet, on sdm660-mainline's 7.2 kernel. The stall the third
patch prevents was measured with SDM630's system-level idle state from
a series not yet sent.

---
Changes in v3:
- New patch 1: resume devfreq from each GPU's resume callback (Akhil)
- Patch 2: say that the device tree attaches GX to the SMMU, whose own
  domain is CX (Konrad, Akhil); resume devfreq after the reset instead
  of taking its baseline again (Akhil); dropped Dmitry's Tested-by
- Patch 3: take 2336 us, which leaves every CPU and cluster idle state
  available, instead of downstream's 424 and 518 us, which also kept
  every CPU out of power collapse (Dmitry); drop the request on destroy
  after adreno_gpu_cleanup(), which stops runtime PM and the GPU
  worker, so nothing can take it again before it is freed (Sashiko)
- Link to v2: https://patch.msgid.link/20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com

Changes in v2:
- Patch 1: take devfreq's busy-cycle baseline again after the reset,
  which clears the busy counter (Sashiko)
- Link to v1: https://patch.msgid.link/20261019-a5xx-gpu-pm-v1-0-1d0c313a1412@gmail.com

---
Fabricio Akio (4):
      drm/msm: Resume devfreq from each GPU's resume callback
      drm/msm/a5xx: Reset the GPU when resuming it
      drm/msm/a5xx: Hold a CPU latency request while the GPU is powered
      drm/msm/a5xx: Use the downstream GPU idle timeout on A508, A509 and A512

 drivers/gpu/drm/msm/adreno/a3xx_gpu.c     | 15 ++++++++++++++-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c     |  2 ++
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c | 21 ++++++---------------
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 +++++
 drivers/gpu/drm/msm/msm_gpu.c             |  2 --
 7 files changed, 60 insertions(+), 18 deletions(-)
---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261019-a5xx-gpu-pm-f58bc4ee2387

Best regards,
--  
Fabricio Akio <fabricioakio@gmail.com>


