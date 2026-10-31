Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A27606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P57kzwwE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC7310E2B2;
	Sat, 31 Oct 2026 07:53:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC1310E106;
 Sat, 31 Oct 2026 07:53:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B765C4321E;
 Sat, 31 Oct 2026 07:53:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793433221;
 b=AgvQ//6fYiDIpnyzWvL4DqGnaVhUt2H851adlvCGHKKDmUlaAcTiOgGDXabTphKVxP24
 Ozy6n34izyb8CR1AB1cU5oAYRs0IYA/RhaQP6bq+VOQLmwtgxem5yOaSEm856y+SAOvJj
 0XSr+gmjCLEyrcYnl5Ai4uXicn24XLbGkl5duDRfBpfp37clbxFZ6pLsCgLxaPzfD0+TJ
 RDNCkNNUu09k2VkoMgzN7+qL7tNoszkewpu7nIYRrYN8VAKbLqSXz4fLT3Plm3rewm5G3
 lxhRGB8q30AcNx7vd8kvSLZ1nCjnflra4+aMEiv6mEDX7IuVOjJYTWWz7MZlYQcQJQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793433221;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=MVniiJysOIFVs1zaeWA3DYdUuigiKHmMs2A8x+/ifcc=;
 b=gY3QxzY+Dru2WfxvfoHSFoUQLwZ7kLu57g0k9j4QS70NLYo3jWQklNPLtR1PptoDNPuz
 064n1Hxgea/AP3VncJcDb7Q57eYG1lJHdGA4IDPDsGnWL/e9Ua5DaxYH2wYGkUDi5lUb7
 uuBOkgUAG9dogt0qW/e7JfLH6848oYJfrxUFRikUtbJ1tkf2QjE2irVsfnniDgL5zHG8P
 IOcIuJOQwBzGBITIh/7Y1vMadTAVw5DqtzYRwNYNJXQzfOFgsUOppglWqNMzPSd9QRyEk
 PJ0iLzNIQjblmReiXWaJgH5/Tat7b2UALIYsgIXWBarQQBhadqXLJAjQKvbQuCvW9Og==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 2015B1F000C1;
 Sat, 31 Oct 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793433221;
 bh=MVniiJysOIFVs1zaeWA3DYdUuigiKHmMs2A8x+/ifcc=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=P57kzwwE0IVOXrFAnds8QvdmsdZOfuePt0EFrgbML9FJDz4c5WsD9PNka23qAOBhl
 PuXtvcZffNblzeZak1BF9FgtWGZi7KQ17HEfv3hEz1ImsYnIJ/dzbv+6F+Sw+Hn6cX
 Aw/W5stnDG4poMMmsYA6jC5ysxvef96/fxZT3bDgqYTbHFvISYznO31cauWJ4v8+eF
 P62kyv5BzeN1Q/L2DOgbo5+0Ls81S0x21bKNM225bTesHucM1Nppd848IyD1oNzNIX
 NpMYSEkbU0g0ld+BbPl0qzHfi1O5DFR/JUcpTMTU1/eUEOsjg3Un4bbnf7ifpmf+e7
 t2fSk1Dm3Db3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A34B2443AA;
 Sat, 31 Oct 2026 07:53:40 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH 0/5] drm/msm/dpu: Add SM7250 display support
Date: Sat, 31 Oct 2026 13:23:36 +0530
Message-Id: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQqAMAxA0atI1hbaOoFXERfRRo3gQKMiiHe36
 vIt/r9AyDMJlNEFng4WXuYAE0fQDjj3pNgFg9U2N9omyq27kqmwmVaoDWLmyDhMIQSrp47Pb1b
 Vv2VvRmq39wD3/QD5iH8ObgAAAA==
X-Change-ID: 20261023-dpu-sm7250-a01aa5de1da4
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793433218; l=1402;
 i=patches@brar.si; h=from:subject:message-id;
 bh=lImhQg5lCjPx2m766k1nCRU11627wdRxlLCIAzvpVMA=;
 b=lQgVyB1vnmMuNuCV0/N5dynx72wt6JHJiLqq2+O7zd9XMMBeTd6sEzgP+h6ktTOI91k+9E8R5
 BvsyNfCt69xDF3skqFW8/RWvZuSEcXgt94xWVqfbAEcFTUdeEW3Pptm
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add display support for the SM7250 (Snapdragon 765/765G/768G), which
has a DPU 6.1. The DPU node matches the SM8150/SM8250 schema, so only
its compatible is added there; the MDSS gets its own binding, modeled
on the SM8250 one.

The MDSS driver needs the SM7250 UBWC entry from:
https://lore.kernel.org/all/20261027-ubwc-sm7250-v1-1-e766b1e264cf@brar.si/

Tested on a OnePlus Nord (a 7.3 based tree).

---
Ishu Brar (5):
      dt-bindings: display/msm: dsi-controller-main: Add SM7250
      dt-bindings: display/msm: dpu: Document SM7250
      dt-bindings: display/msm: Add SM7250 MDSS
      drm/msm/dpu: Add SM7250 support
      drm/msm: mdss: Add SM7250 support

 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +
 .../bindings/display/msm/qcom,sm7250-mdss.yaml     | 351 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |   1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_1_sm7250.h | 311 ++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 8 files changed, 669 insertions(+)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20261023-dpu-sm7250-a01aa5de1da4

Best regards,
--  
Ishu Brar <patches@brar.si>


