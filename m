Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C35C982E0
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B683710F37F;
	Fri, 18 Sep 2026 13:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qeOWKC06";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E825710F377
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:16:29 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so360462f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789737388; x=1790342188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jQCO1lrXpdk3Cfzx3wIoTrVcbxEHs1oQDclhX0KurhE=;
 b=qeOWKC06zNvHxkzSTuNCYUZtoH5F1Q6bPg+SR7mhh4XbLmAxH6uFLcriXgB0j1VmCp
 tC0S6poJb8WG0yJta0khqf8xMge66go4p9OnSfa2i0D2jzuEHFkB1JFcpcFW2bqIHiAu
 36KZqMkiHrlVU6/ftYTzwuftfhkuuuKBehJ1peYKiL25xHNQqCu7x8U57c5K9kFFmelm
 7+JibNUIatWKQb+gHU3FgSvduJhCKWQR2nB+XQUnNxUpYeB5E0iufzOdEVB/XnvlT3NY
 g06M+o2ZbZsePUaxzMCjo1g8DJ653hOIYKC0noy8koASCEa8E51Xr2KNXnSKsfS+e+ZZ
 aHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789737388; x=1790342188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jQCO1lrXpdk3Cfzx3wIoTrVcbxEHs1oQDclhX0KurhE=;
 b=tg7eFoGqCiLHTHGlBeVsKmnppapKNuiIS/0QPDzda46m7hi1Tq70F5yv72XuNqBRQ8
 ceuRfcWjMt1q1eZj6V+JawnHA8da5dxX+t2frYTlhoBwG3mCKTIJDav6nTkjb0igRMj8
 1UfkN0gHaoPH0Cq+2xMdRqzdShcpY3hHywaJQDaLIht2cCEkSCCCDLKnzihR9vSKxX9j
 liYMYXZqx02J+l0Ri2IuoTn/GiU82YJjL0679bKAB6bdEYId6VlM2gqOMO8gEyEoU4UH
 CfjONt35IC8Ay0ch+PzBGDBl37LG4DbEuT/FMwD9Iw8nvuscnaV+gJPcJ8YyvvO5fP1z
 Tfpw==
X-Gm-Message-State: AFuF++mMjULJOw4gF2c5W+jVEPmwhI/bjZ8QjvY8a/pj+MY1Q2sAbFux
 tVL7pFVlaFjxQm9/d7auP/L534SjU2qoZcqxaDqsl23yC4EJ4lGkqLdc
X-Gm-Gg: AYBFou32u+sYoEnQ8v1shuNtIanL+Y+v8zg429z1VGxifBtENc2ktwDP2mz7PKx2EoD
 zsTGFWRgRA0wZQeacGzZt178DAHsD+JMz5NmvDnICgicZfxcFJjZFBHC5Andklg45RqKTnUFcR8
 RNFZUDV6myhvobxWAlES4FS5qKTDPMVjFm0VlBas+Sx4a3NTfWEHo/H9h4gjIMA2sW1IZNAJd3B
 ZaI/tEeIQ01PUsHaoJdCso8ek7PKCBfBo9uIfvVY+LUpS+KbjTW/Jq2HvwqYX/xxsG3QZmOeUa0
 fpcgbNt+gHybOp4r1OG3AsTchUpOyHblDovJg665faIiyYaob91dzbZCAskT/+uLnSr0OiRxeIw
 cIwqpW7bm6b5nvjKfCw6ah6NPntexIYYP8YGJrx6sTTPcTkTB7KXOcNQ5KD5YYyYPW4sGbeovts
 Z0TOf0yCT5o4iiyVwzCxb6QVuGqZr7A6i01ED1YoilEw68+X/lqiPHwLi8UL7w3lgy7Xsw/bdfZ
 qKjM473ZWw=
X-Received: by 2002:a05:6000:2312:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-4871e269e92mr3590006f8f.37.1789737387367; 
 Fri, 18 Sep 2026 06:16:27 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.209.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm4487572f8f.34.2026.09.18.06.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:16:26 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v3 4/4] drm/nouveau/clk: don't clobber reclock status when
 restoring volt/fan
Date: Fri, 18 Sep 2026 15:16:20 +0200
Message-ID: <20260918131620.405133-5-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131620.405133-1-postadelmaga@gmail.com>
References: <20260918131620.405133-1-postadelmaga@gmail.com>
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

nvkm_cstate_prog() reuses 'ret' for the voltage and fan-speed restore
calls it makes after reprogramming the clocks.  Those calls almost always
succeed, so the status of the reclock itself is overwritten and the
function reports success even when clk->func->calc() or clk->func->prog()
failed.  The converse is also true: a successful reclock is reported as an
error if the final restore call fails, even though that failure is only
logged and otherwise ignored.

The only consumer of the return value is the error message in
nvkm_pstate_work(), so in practice a failing reclock is simply never
reported.  Nothing else changes, but a function that returns success on
failure is a trap for the next caller.

Keep the calc/prog status in 'ret' and use a separate local for the
restore calls.

Fixes: 3eca809b3c05 ("drm/nouveau/clk: cosmetic changes")
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index a43246ae6..1cb83edc7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -199,16 +199,18 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct nvkm_pstate *pstate, int cstatei)
 	}
 
 	if (volt) {
-		ret = nvkm_volt_set_id(volt, cstate->voltage,
-				       pstate->base.voltage, clk->temp, -1);
-		if (ret && ret != -ENODEV)
-			nvkm_error(subdev, "failed to lower voltage: %d\n", ret);
+		int err = nvkm_volt_set_id(volt, cstate->voltage,
+					   pstate->base.voltage, clk->temp, -1);
+
+		if (err && err != -ENODEV)
+			nvkm_error(subdev, "failed to lower voltage: %d\n", err);
 	}
 
 	if (therm) {
-		ret = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
-		if (ret && ret != -ENODEV)
-			nvkm_error(subdev, "failed to lower fan speed: %d\n", ret);
+		int err = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
+
+		if (err && err != -ENODEV)
+			nvkm_error(subdev, "failed to lower fan speed: %d\n", err);
 	}
 
 	return ret;
-- 
2.55.0

