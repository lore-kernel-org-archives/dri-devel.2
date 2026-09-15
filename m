Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EF1C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD92110F418;
	Tue, 15 Sep 2026 10:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="s+msqHx8";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjnHBMwd";
	dkim-atps=neutral
Received: from flow-b6-smtp.messagingengine.com
 (flow-b6-smtp.messagingengine.com [202.12.124.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A2C10F418
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:44:30 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.stl.internal (Postfix) with ESMTP id 39E6B130050A;
 Tue, 15 Sep 2026 06:44:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Tue, 15 Sep 2026 06:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1789469069; x=
 1789476269; bh=ogiWiCQ3bNIbKL3gCXgpDZdn7OpFJCd90E8FcpUzIl4=; b=s
 +msqHx8wYt7BuCOFl3j9MsX9w5GJ8YE6oc4CkgbByOEn3NOMqoBjIiawV+IulPFL
 9AwkeEoZGKzkdkerOj5nHQoZLp+mYaw8d7zEuSrN+boTRolFsnQqAqSn1L1m74tc
 1aP3xbI1s96UbU3b9VKj8uDgq2C1nPSXcpZgQw7dMB6wZSwXkfYNqISMSEJaDa9E
 lE7qZbMNZ17/L/eyVyqR/tRbDsdaTmV9va9m/8B6OUdQYKXoJbM9yHvIYeh7kkDn
 G3v7iHZDDMA1MYSw5rvDL+dVN9ON+bp0r0lYSpOkTNhLC1SLIgl3xiwjnMo/ieAq
 hJLOPpSBPCkmTeeL2wtcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789469069; x=1789476269; bh=o
 giWiCQ3bNIbKL3gCXgpDZdn7OpFJCd90E8FcpUzIl4=; b=WjnHBMwdVgj4BAee9
 m/OgXvi+1kHFNoqgxNDz5qtHh2Q6iKnukLSZugVEwP4ARgDqBjjL52fM3RJCJLvs
 AIWtIp7Mv8TZ3JlAQaJjAlifBWSmrE3hdDfZLQZG3TejVjh5pFg6fhmDg1opvX2H
 TtwXoN23Vvp72wrI19uXcNXY8q+BxBGYIgV9ItX4VtoVuux++RNjjUuohNTGv8vn
 hwu5lB289sy8ikWyDgnxg4asa2/6/nnB80K5x7d7VpQllED2rwH+UpMeU8gKAS9r
 dTEkt+PGCkhYN7Ee3W7DYs8rM7KwoAhHQ53ERW9q2I5lF13cq52f5ZbJYOFxhim4
 0zshA==
X-ME-Sender: <xms:jCGpaqoVmFGDTOC5qaEmAH6V7NsjhF1GKP0AQTS-Q81WWEyDfvW-GQ>
 <xme:jCGpaozV9zNQwn1qABCtp3Y5ojQvDXyjXvIvakdmYpuG1yX3QCJs5fpSuVxXqzcCK
 E1X_kab3-yt8SAeO_PlZ1871ocNdSM7WHXTomwIO3XqBb27LDi9FAZj>
X-ME-Received: <xmr:jCGpatASSAozexkJ7pFWahd05CWLLiPLSM0v2oZoOTEFxUFqtRKMEyOtcZzSwMZ5IjeufI9SFg>
X-ME-Proxy-Cause: dmFkZTE+OOtKqCgoTSrVlWQquKDyDOihaRAkbxrETzU46WPYI4xRZhEiyJhifUIK7wOXWw
 wVB9SQ/RAi7MrJDFDtBnx7Pb+n0YwQkRdmArbygP/oxZoxHW8LIKLQIL2L7jzJ+dDFOc0i
 zgJzZNFATjdf2+j0asWJSTUnqqtG7PFp8Vs3eFHmviT3HEJrjWQLemcS9TcZGgU54P+FV5
 4Pm9j2o7pLtOaGphBt5Uxmdvehz8zGy65174LdzdOvWQ05shZHdK5O0prBfSV/v5pCB4Ev
 utsMlLRk0S0Gt2QFQEaEqPdSBGLc8kXC99b8ea4ToJp+YO5u/c8PUKkTZ3pOeCnaAxuGdJ
 /BT8K/nh0P2FrQdFEYE10UTIUcJu1LBR0D58cwa6sA7yRrw8n3uAEOF9WPqwtcDwa042iz
 mhczxIDOr1uQ4NzgmUNuf7i05ePBq49Vg54C/SPO7k7KbGPcvm6e3rQTKt4k5jlFlVIX9e
 wBFEYsWLJpoqkNgf6E+q6bXxB3tH/w09nozAW55tQU40NUhjLbj3etpz4hy/OzwnbNWZK1
 bXAj4gQwE6OfDnkkv1yfUSmhhdvWNDGhi66omzFpzZkhm9Hjd+xxjJKmjo8eczfSA6tPeL
 B/iZ54o49qMTeRC3U05fb0n3Pg1n8Cgw4GricS8ygP1+0Y1iEQFNmKcZi3ig
X-ME-Proxy: <xmx:jCGpauIhTG36Kp2V-obtlQSpqdHi-H9xP_-4IBOrznHVyM7xBCUufw>
 <xmx:jCGpaoEnTYIq2e-X814_FvcLEASVzZG_gPZtkQaSINKJORBD-Jr6pg>
 <xmx:jCGpapGrycSu2DFz6QVxyQQ-qVHz6FJN4yc3giSTeRR6n6V2PiwOAA>
 <xmx:jCGpagt5IMWVnNcX2ARVIRybhgbA2lCYz7MWYpFUSpGlqPUdjChS2g>
 <xmx:jSGpascosawkquzodOiMEvFO_cgJHLhL3eHT9rwMBX_PwJ3J5Y5UM3iU>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:44:20 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v13 04/14] accel/rocket: let the core suspend after a reset
Date: Tue, 15 Sep 2026 22:43:18 +1200
Message-ID: <20260915104328.45901-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
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

rocket_reset() drops the in-flight job's runtime PM reference with
pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
is left at usage_count 0 but still runtime-active with no idle request
pending, so it does not suspend until something else asks, and on a
platform whose power domain does work on power-on that work never happens.

On RK3576 that work is a bus interface reset the domain cycles when it
comes up. Without it the NPU's IOMMU stops answering, and the job after a
timeout returns a surface of the output zero point with rk_iommu reporting
that MMU_DTE_ADDR is not functioning.

Measured on a ROCK 4D in one boot, three runs, one variable between them.
With the bare put the core reads runtime-active with its rail still up
after the reset, the IOMMU reports the failure on the next attach and the
inference returns 0 of 128 channels. With the reference put back through
pm_runtime_put_autosuspend() the core reads suspended with the rail down,
there is no IOMMU message, and the same inference returns 128 of 128. A
third run repeating the first failed the same way.

It also matches the put in the completion path a few lines away, so the
reset path no longer leaves the device in a state the rest of the driver
never produces. The remaining put, on the error path in rocket_job_run(),
is a plain pm_runtime_put() and is left alone here: it unwinds a
pm_runtime_resume_and_get() that never reached the hardware, and changing
it belongs in its own patch.

Igor Paunovic ran the differential on RK3588: 45 induced resets, all of
them on core 0 with the other two cores bound but idle in his single
client protocol, with and without the two preceding patches, and the
domain dropped every single time with no MMU message on either kernel. So
this is not rocket-wide. His conditions cross a healthy block with a lowered
timeout rather than a hung one, which he was careful to say his protocol
cannot settle, but it is what scopes the change to RK3576.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index dfe9135d8..2a0b8af6f 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -437,12 +437,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
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

