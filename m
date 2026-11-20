Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01684606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=jnjkTacX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FAE10E1B8;
	Fri, 20 Nov 2026 14:12:58 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFE610E1B8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:12:52 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3866a784546so409481eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795183971; x=1795788771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NRsPqc1sWk3utVGhpgkPro0yilWSwaU21f7Ua9Mar54=;
 b=jnjkTacXFpLRtcJHEDQWLmHWnoBl0fo2J8uhTAAjtvOO6ZlMNm7iR+AiqX54faxBv7
 u7fmWKNzMP8FklJVpxWH0aYRqeW43RWb6NZrbI0dzZ+7iH9fN6RvTTQyuhN+qdcRa3tC
 YNrA8wrhGVSsR18ZN0qYfJDSVypfJx3QOzslI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183971; x=1795788771;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NRsPqc1sWk3utVGhpgkPro0yilWSwaU21f7Ua9Mar54=;
 b=JLmWQT1C0e4OkIIZgjNlKBdisP4DFInlOi9u71xfxvQCbyoGX9y62SirndNMFebG5K
 200Uk7LFO32KJtp2kPcI5AT8CisVxTsSvineoTv8ZwOwyfIbTO6hQ7I/39Ew+UdrcKqi
 44zLhvjvbFdugsOl5iTSCkIcQDgPU2/mX6nsV2tyjWhpBac+/baM5MjilM6qERDeswPL
 Qmk3ngvGJ9KmwqHXaRkXNHAXGQKTEopt1rynPr+6J90CSDX3yhI8EQ/3hXDB21VZF/02
 7l8Pk+SGCY+CGPmtTfrI5HxelT2e7cMUeWtcGQLLDHCYRniliM4hb3uxSWnz5S6INBnJ
 X8+w==
X-Forwarded-Encrypted: i=1;
 AL+hErF1TJNns4Ahh4M51KnGEDufS3IABtHBL/2AlK6om5nqhgMLCod+pRxiKzI7UiYqxCeahO3hj1adVKY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+VcWC+PK/LqJqxJ/z4YynKmv9bieAubFfrJJ+xGnK585F5xjzi
 +VjnVInIfeGY2tNJ1cvrUxhIsSrCKjQRaBpBE8gp/yS1koUJAx/XtspLjEpqnXvAYpc=
X-Gm-Gg: AZFdTZfF2E5nouKvMO2RKtcZV79HwabaXQaygvIHxg6TFQZ8Y5S1YQpJriD+sREOwZr
 NlJCFivSxRmFdWck6WhdQaWPqFYkO/nzf2d6xzKUz91Nd8rsyhrni5xA3gvCm12sKiTV825WqX1
 Uefgs/nlrRXDy2avFQyzPLaBABOiXYmqhe8dMxd9oDYw+xJlMHcll8pPBHoOOesvzHTqlp8g9uY
 rWSyQLzIhAAZivX2jVY8NCAkkY5y/QMbTObsosJoVGy3k5NBVjiitI2hMkZfVHSVRhZiEYWafuv
 XWfiE4L0dCgEW5x3Oes8rKrDrP8+wOSlIYUI2TCE5EOTqzfsyQ2TsqpDaDL4MgKfmI3gwPD9FTj
 NNP1eSdvjqNmANZ0TefQW5p7fxiYhsVjXHY4OnWIq5XydnFlicVvPdza1gPqmr6AaBR8XyaVdor
 /0X5+o5ygsau4o6Nu7+eHKNrXfe+Fma3rzYjc2zHWdjY6y8qJNxiGHoi/f+5KQS2SKUo/dN5F3H
 qtVOn+DoQUPwqljpzG/wql98Jw/lMVPmlei0Wnei8IfR6qwMUfZ+NTjBG2+wikiX4UJOPZKbmZW
 BhIQpnRS4c4dg+s/mLX6OPihc8HKROwhveIbdWECrdkbxDruoMN9Xmkd0/xWIfV9cVRIyE/ZCT5
 EcT/JPwfnYgUB
X-Received: by 2002:a05:693c:60d4:b0:369:fe81:a575 with SMTP id
 5a478bee46e88-3857111f203mr3507628eec.35.1795183971339; 
 Fri, 20 Nov 2026 06:12:51 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm11244434eec.5.2026.11.20.06.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 06:12:50 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH v6 0/2] accel/rocket: Report NPU usage through fdinfo
Date: Fri, 20 Nov 2026 23:12:23 +0900
Message-ID: <20261120141225.789350-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report how much of the NPU each client uses through fdinfo. Patch 1
exports the runtime the scheduler already accounts per entity, and patch
2 uses it for rocket's drm-engine-npu key.

v6: Rename the getter to drm_sched_entity_get_runtime_ns() (Maíra
    Canal). Report rdev->num_cores, the cores that are bound, as the
    capacity instead of rdev->max_cores, and skip the key once no core
    is left as a capacity of zero is not allowed (Maíra Canal). Add
    tags.
v5: Use the entity runtime from the new drm_sched_entity_get_runtime()
    instead of a counter in rocket (Tvrtko Ursulin). Reviewed-by tags
    are not carried as the accounting changed. Based on drm-misc-next.
v4: Single drm-engine-npu key with drm-engine-capacity-npu, and
    documentation (Tomeu Vizoso).
v3: Add a rocket_engine_usage_create() helper (Gyeyoung Baek).
v2: Size the per-core counters by rdev->max_cores.

Link to v5: https://lore.kernel.org/all/20261112171144.3151554-1-sidong.yang@furiosa.ai/
Link to v4: https://lore.kernel.org/all/20261103155338.1949294-1-sidong.yang@furiosa.ai/
Link to v3: https://lore.kernel.org/all/20261103104804.1887489-1-sidong.yang@furiosa.ai/
Link to v2: https://lore.kernel.org/all/20261101152723.1430312-1-sidong.yang@furiosa.ai/
Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1-sidong.yang@furiosa.ai/

Sidong Yang (2):
  drm/sched: Add drm_sched_entity_get_runtime_ns()
  accel/rocket: Report NPU usage through fdinfo

 Documentation/accel/rocket/index.rst     | 29 ++++++++++++++++++++++++
 Documentation/gpu/drm-usage-stats.rst    |  1 +
 drivers/accel/rocket/rocket_drv.c        | 25 +++++++++++++++++++-
 drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  1 +
 5 files changed, 80 insertions(+), 1 deletion(-)


base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
-- 
2.53.0

