Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F6606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zpn6K/8S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B5710E033;
	Sun,  1 Nov 2026 02:32:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F48B10E033;
 Sun,  1 Nov 2026 02:32:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFC3C41FA3;
 Sun,  1 Nov 2026 02:32:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793500371;
 b=xn1FV7MiehZpwUApWvOUa+SQDrKUvW8mPeV2vL8wBhwxYn1vcoVUa7pvJNL/Xq7Y2iHo
 5pNQytemzvHyqrVgSTGF8oOIW2FcmNsvJole97v7++GRt+FcOH+ueMt7doSgb1sneDnrc
 c96RxqYYFzoo03pYCwJcjDAH/HR9n1ayu0XRcll8/Rz/pGM25Mf1bDAxw+pmJZWz/vddL
 R0hESDkG/f4v+Mnh/QH5B+uVzoF+d9ubpJq2rvlZAETZ/HaRUrPMi2QqpR+onRsr/6Y4y
 172XujMoeWcG0V7ONqqGSJ4Ghw4lm4/HSTSxoTt47sxXIjt7uJEzpa4DCzcL06i8Dkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793500371;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=dxO7duc0RtbS33vU3by5Q9o+zqFbexYfZ1nKW3dj+zE=;
 b=IH8D6AjifVF+FbXTLn8vduWa2ZxRNqAEpxmTeagIwOV+/G2nwacf2BYAT1OtNNb9j/DR
 zKM/4dmmkV7QD25ZJmkzeBYo8yPdTlGCM78Dk+ioQ3iBegoTjbjmgT9qxsKXyuxhfCy5C
 2xVIJzRuGE3CXg14igamJ33MIdqYiqrWcYlF8QTxIf7jC4GtgnJK4q1D6qsI2tUhgjilF
 JBlQQkQI8jbBUSAVwnz8c/ES4mcVI9Wt8Yyfh7KkYbx8fuG03dXssskeaIUyynWCNxK3i
 b/rJ0mpIl8p0SrwRifjVMB91Srwj+tChNG+DVC08Tj5Cvjf5KYMho9RKYcDSyextUIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4CBA81F000C1;
 Sun,  1 Nov 2026 02:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793500371;
 bh=dxO7duc0RtbS33vU3by5Q9o+zqFbexYfZ1nKW3dj+zE=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=Zpn6K/8SZwTrXYvI+xF1Xne+9VYeVfgOG3hh2OnSDCmpfkyRn21q7keilsmZM4aMi
 6VmXhDiHfPWtrm/5c3QnFcz960gDAs2DiO84lE+FifYpJeZc97yQz/eW0AtvZhgN3D
 eF4WXrYmHn3/Mtf2ZujoXEliitcWI134ep7hnM/1yJFcpIxWkPDyA3imlWZEShLLnp
 BzPGt5o/VS4DDhs7YVN59GjQPKNOBbfPUtbwoE7xF6cTgwFGoiDZnXnmrpFHpwZx72
 2qI2k5/i/YkJjR7xk8Y8OiOmTCF9e7kdafW2vDhdGyxg7TPl7VIIpqUwsEENbzcQ4o
 8nrlcu/SJ6j7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CC35146054;
 Sun,  1 Nov 2026 02:32:50 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Subject: [PATCH 0/2] drm/msm: Per-submission GPU time on A5xx
Date: Sat, 31 Oct 2026 23:32:49 -0300
Message-Id: <20261031-a5xx-submit-stats-v1-0-16a67ac96edd@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auEWTuQxBqqV5Eu0nSiIxglk0qg5
 O6NuvzgvX8DocwkcFEbZPqw8Ct1mIOCcPfpRshLN1htndFHg/5UK8o6P7mgFF8EYzB6dONwttZ
 D/70zRa6/5nX6u+8fFMo3BK3tgJl58XUAAAA=
X-Change-ID: 20261031-a5xx-submit-stats-fc108684922a
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793500370; l=1367;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=FIfxXWiFD0YIv3SO2+3QXWoICX9owaYVS7SChP2aNT4=;
 b=IIm+EseArzjRGMLKA2hIomTqh4OxcVfh7EFqozoGolMBZe01X5fdBfXHooOUDOdtFcAOEsJDw
 D7wHTb4letUBmAaPSU7xu/4cNPG5gMF0kzn6I0z31hgwSk9nrX2qmiP
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

The GPU time and cycles msm records for each submission, reported in
the msm_gpu_submit_retired trace event and added to fdinfo, read zero
on A5xx, whose submit path never copies the counters they come from.
The second patch adds those copies, as a6xx has them.

The first fixes what is recorded for a submit killed by hangcheck, on
every generation that has these counters: its end stamps may never
have been written, and about three years of GPU time is then added to
the process's fdinfo. With the second patch alone, A5xx would start
reporting that.

Tested on a Motorola Moto X4 (SDM630, A508), whose board file is not
in mainline yet, on sdm660-mainline's 7.2 kernel with commit
b303e1d52811 ("drm/msm: Recover HW before retire hung submit"), which
the first patch needs. Its code is shared with a6xx and later, not
tested there.

---
Fabricio Akio (2):
      drm/msm: Report no GPU time for a submit killed by hangcheck
      drm/msm/a5xx: Record per-submission GPU time and cycles

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.c         | 15 ++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261031-a5xx-submit-stats-fc108684922a

Best regards,
--  
Fabricio Akio <fabricioakio@gmail.com>


