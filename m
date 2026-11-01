Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EE606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=huhlWvmh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lcKskV9l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C0A10E36B;
	Sun,  1 Nov 2026 08:31:31 +0000 (UTC)
X-Greylist: delayed 479 seconds by postgrey-1.36 at gabe;
 Sun, 01 Nov 2026 08:31:19 UTC
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C417610E1F8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:31:19 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id D50CAEC069C
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 03:24:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 03:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1793521440; x=
 1793607840; bh=BkTcONOVgxmiHpWbrh6se8CO85l9DSVApCi2YbLZEQs=; b=h
 uhlWvmhRJhX5eLt8XYFpPqMTdBVLHZxhWZldXJIVEncgaJwdsC/D/xVxNWrXeu+a
 8PQuduVHG1h/YJjlaLowIg/zjf9SfBRWZJXTiEf+P32x10kY9aQ5HChPAXsINsxA
 oIZMxCnmR2U5fo66FaxOu6UnvKLCu/mm1NHIilMv2Z7XRiaIb2Lc2bsWSjZrRPy7
 7rY2bu7VYC3bY7OeVcI3kn6690utCGmD6E42SFhypZ0Xf1ovJ92UFQuv0Mv0kvS0
 OTv3OPDPiXb9PxpkgSkRGhU+HKD1Xeg0Eh/2WEw6eU6eSJ8HbenzMKerLi9GlfxK
 jdruRuAk2H/LfP1cThEtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1793521440; x=1793607840; bh=B
 kTcONOVgxmiHpWbrh6se8CO85l9DSVApCi2YbLZEQs=; b=lcKskV9lM8QelbYdC
 35YS6c92EMZcgJmfQWOxvWjnVgnfNI+a7DWpxLJk2rtEAt+cFFCdsy+UlLjit+L4
 Lfp4zvUhse4oQdSVwzAPzre3L6Eannl+zUCHI8WB6moIgAVtJKjgjlGZ51vfL6yy
 gyB14QnQ0baMqI6TTXHjbId8jugzbrxCQBcGQsf3ylld34U2h2xu6MLZGJpRSSWS
 DoP0bBYs1kX6iroN7H2mwNZUwqeF9+1pBgIfvOV5mK3OO0CLMg/wj0aWFJaA2Flc
 tkEG6GzlnI5j4UR4a35rwBFQENwkCkXurzXrHw0osMiRRyrg6R+el4MN57a3zXzc
 49xOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521440; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:VjJbvbQJwNZLWeiYdX4BekBkPGpPHVDJzdbSM0FpUxx1gbt
 f1TE/QUQXQSFZoM/AQTYYCfiEGwux2MnxEiZqO/ue561sZbGZ7mb39gQooPBAOmK
 JjoVyxkKcjYkgTbTLarEcjrAnt1QES58j8L8LDsNch7lwfj82iS5JDROYy5ZGu8V
 JrpklzKB32iHRxmyZZla8IyTbxAeaH1grGbbwbwLOri2rwwevw9ImpqJ9N5y/6Ok
 erfIZa1HS9LHtL/OntrCnXEt8XlwZYOgXn3OeYM4xxSoIAPj8f7WQvaH9Y7T0bjp
 N1MR0QvDeLZO6+UM2PXWrw08z29ZbrmjXubtjzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:iWYj6ENj7Pnjcr0pBXQxpbajj8XjUbkAvxHLmyetk2s=:PvsT+Qa1KcEvQd1vRhQoegnNpYbcA51YPv70V/wY8/w=;
X-ME-Sender: <xms:IPfmaiKoiUAtaeoL1gyBqsZfZvYOn70vOIZP7MooOezwbuwm9M8whw>
 <xme:IPfmasfG_D-wSqw119qIHq8OWV6NPFxLVLtDLv0LLxyAXlxQl3pjXYv3wZ2-l1tXF
 oklr9m74xgizt_q1k9J7WGzKwltNSLGhdO1sB6qOLeIs9wG4eiDMQ>
X-ME-Received: <xmr:IPfmahbKfkf-CSfVAZXLrrCDZcVtF297xkbbTFQPP7_mvWiZ5AGyDVRblmoQD5syk0KauiD0>
X-ME-Proxy-Cause: dmFkZTG1f5xhzVY1+tDVA2GDAZsCkJLH07r+Yy8eDDwJ6JOhttyoXjIFNLHdIMBXenkhJx
 GYNu1BmhoCEfkR9grTKkLuIJN+OzTEGtgz44pzE7hxNJDyINE2djZDhuIxWCGbyrBAg8N4
 go07QXa3FbJDHoqbVIkh+YewIyKzezBgmEguYHIs5iblTpD6uKFVhdzvoEpK9WyO9LZQh2
 oZjSmXf8essUkIouu3K9xMlLp9+lzsrzT9OlAkrndhtRVZ+s7Dbtf/1n46loyb7XK1/pPJ
 EZkemaWOJwxsmDm91Iwy20kA5um10TciIZ30X1rMTa5jzi7bDygiLl3spCruOgxPW+4DdG
 v5K2N+sz+B3MGZwvQ34inZ/3irz3OTjJ6lCXKH5N0Ml92muuLTNBr9/rAHMJtBAC4X3OpM
 jj4z4XwPKfyKvMTBUCCVuNtPDijsZPFFavu2iWyFEJaO9aBkzWHvKa+MIwNl9gMVQNfJ4j
 dgywX0zidVpz4aRWyH0iJHC0r/oHDj/0CmOr/Q8RYvPwmus9hNm/qZ8vUBpuCKmMaydeQ/
 +qoJ5s3IGwg2k8Sf0dgFjgBHWiZOEbtV6qolABl865M2drbL6pDckvvRFGFeT/5dkUtr/0
 fgahdpJv78H3VudMDwBzdZk0wfO1181/ateMJKD9i7Ah8CgsfFOaBmJXu2fg
X-ME-Proxy: <xmx:IPfmakXlADSana7q_O4dJ4uUgvXtQAD76Rb5cJ1HNsmf94TmZwgeqw>
 <xmx:IPfmanC5isFGb33eQnILVzN01Ptddqnv0Qqda0YcEAY-dWycrQ19WA>
 <xmx:IPfmarBEu01zRM76mo5HufQMQNjNeUS8agBTkxt98B_ohfOjDZ4rCg>
 <xmx:IPfmaup0J1Xv_HPxs4_0kXTyywxb2DpJod3dS3wyE_MFrih3XW08yg>
 <xmx:IPfmaqWsUjij__DlLA_N5qB9v1HTxqq6WxOOHe27UeCE3bKAljjMvAxl>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:23:52 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 04/15] accel/rocket: let the core suspend after a reset
Date: Sun,  1 Nov 2026 21:22:56 +1300
Message-ID: <20261101082307.151957-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
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

rocket_reset() drops the in-flight job's runtime PM reference with
pm_runtime_put_noidle(), which requests nothing, so the core does not
suspend until something else asks and its power domain does not cycle. On
RK3576 the domain's power-on resets the NPU bus interface; without it the
IOMMU stops answering and the job after a timeout fails.

Use pm_runtime_put_autosuspend(), as the completion path does. On a ROCK 4D
the job after a timeout goes from 0 to 128 of 128 channels correct.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 5b2abf40b618..152a9098634b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -467,12 +467,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	/*
 	 * No handler is running now, but we might still have stuck jobs. Let's
-	 * make sure the PM counters stay balanced by manually calling
-	 * pm_runtime_put_noidle().
+	 * make sure the PM counters stay balanced by putting the reference the
+	 * job took, and request idle while doing it so the core can suspend.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
 		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+			pm_runtime_put_autosuspend(core->dev);
 
 		iommu_detach_group(NULL, core->iommu_group);
 
-- 
2.43.0

