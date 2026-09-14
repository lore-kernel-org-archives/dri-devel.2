Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA577C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B54310F07D;
	Mon, 14 Sep 2026 18:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ftfk5wwq";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29B510E0EB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:27:45 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4858303de5dso3708279f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789410464; x=1790015264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mwRvzG4BggeeZAyOCJrpDH7mtfHbO/g8nfKHTJvLmaw=;
 b=ftfk5wwqrfyNgjAaubMQLW5RyWDDw20aAGtGQJAvWeHslF7givXi9YtTVv0utrdU6X
 DXQZITdt0ZBKjQvEJn604c2c97aAd2XW6oT0z6lmCITVkqyJ6JBNQEeTvEzG2+i/jW6v
 tHeMqAOn9BzDcqcRvT2LowQ5tnSFRjj/0wEeZF1N09M0WjOdCa+FVRk7DDKBZ2MyvJAT
 IVZ/rDl7CxrKlHeVE37cowovwfIYCR3Ix4mUUIE90boq+g7rUgHFwxuJkn5Q2yw/YRCC
 2+TLvfOklu4ez9TA8/ez4jrAWoNjP+FaklQalQ3Jq0jbsL7h7MYjhYbFZAU+7vK84rgP
 QPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789410464; x=1790015264;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mwRvzG4BggeeZAyOCJrpDH7mtfHbO/g8nfKHTJvLmaw=;
 b=qIgMkBhXHO0rZ1bcaXsiyFBM2IrH1z++EMZxU8R18UbU9lgf9YY1AIWIMHDic9gmjo
 OMHCaUvjESAOelzokkX/Hx6HXtlezgAmk6njlnVffJf9gX06qB0vRsSpJz+cs8+DoAfb
 wcpqp59Gnkm/IZ++RmCP734h+W5n1BLN1DU1OwJB+70LfW7EbGHvMRivJ49cq+TvFgb3
 F/pH2I5512JpvTdqg6l85FI8vV18n7ucZy4X64CBTbhSEiVBFZyvQpZBFKW6mpyZY01N
 Fr0YCRBO1C/sSIXCkNAc2ZdUsv4IHBe7+2tCDbBhPSH+qP2kIu+fRK7AueXxUljFUzqP
 J7FQ==
X-Gm-Message-State: AFuF++mR3fY+61Xtvm9kb+BaGh45e6BZZ/qQjpbNzFmWq9rDSYeEghYs
 Iu3QTjG1BECnUT3F9TdSsR5O8DYfEITvlCHXdZ6OR2u2UsQvCmDMQTmT
X-Gm-Gg: AYBFou1DpotjvPtQ5ag6RPdGgssPU3UzjwAOi1z+20h9hGaK+eIoRURVzipoDAoDrcY
 wLCO76Q6ZJt5WD0wa16DpWCSlS1MJsl6pnHRgtzFzA0jaoAnEK5JHS/Z/XTuzKHo0EOF09npNfG
 5xWVbzMf5bYCC9j0oW1U/IaRjWyVBnOeW0hQYzYLgDLMrx8hmtnbfPZYTkTO5RkDmSRYHsgEqj6
 dxvKZI4ub+B+sIDHxKI54WoQwUl/Im4gO2VuqcyfeMO5t/AESaYmoV6m35ti7RPZcoMhdHhnata
 FTTPfnfnw7agsxhuZlJVRlLGPYjD8gb8Fv4DrHJD3crlsIOV2q5Hf6x7tGitmkA5opvNHLwO807
 y56XgHbIqhQe+NLcFVS+3CzyFi7NczDzu9x9bXKAaI/L7bI67i6qIFYPA04/iHsaCLSZYSaezDt
 efj5taTc9mKU5mWRZuBTH4uz1EcEji7bYpA2/QGZnTxD7GiBZeprdVNPw1zBQMSHfIrUO6XS2An
 WL3Uv6GqQ4=
X-Received: by 2002:a5d:6f1c:0:b0:487:7d:4e77 with SMTP id
 ffacd0b85a97d-48702b3dc21mr4168772f8f.40.1789410463848; 
 Mon, 14 Sep 2026 11:27:43 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15de:500:7152:15ad:a382:94fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f0403125sm25397683f8f.8.2026.09.14.11.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 11:27:43 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, malhyuk97@gmail.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: [PATCH 2/2] drm/sched: document the RCU dependency
Date: Mon, 14 Sep 2026 20:27:40 +0200
Message-ID: <20260914182740.1587-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914182740.1587-1-christian.koenig@amd.com>
References: <20260914182740.1587-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Tvrkos patches added RCU protection to the returned strings from
get_timeline_name()/get_driver_name() callbacks of the dma_fence
backends.

This fixed use after free problems for a couple of drivers, but we never
documented the consequences for the drm_sched_fence.

Add a few words on the function documentation to note that we need an
RCU grace period between signaling the last scheduler fence and
scheduler teardown.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 6cb6f95464938..f73c5141b4e5c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1203,6 +1203,11 @@ static void drm_sched_cancel_remaining_jobs(struct drm_gpu_scheduler *sched)
  * is implemented, all jobs will be canceled through it and afterwards cleaned
  * up through &struct drm_sched_backend_ops.free_job. If cancel_job is not
  * implemented, memory could leak.
+ *
+ * The user must wait one RCU grace period between signaling the last hardware-
+ * fence and calling this function because the timeline name returned by
+ * scheduler fences must stay valid until all readers have exited their RCU read
+ * side critical section.
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
-- 
2.43.0

