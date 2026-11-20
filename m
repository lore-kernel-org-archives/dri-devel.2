Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1C606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kQtGrPZo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44077112BC8;
	Fri, 20 Nov 2026 16:18:35 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A958810E861
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:19:21 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-537548b811aso3662011cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795144760; x=1795749560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e3wD7sDYHdJ5IM8Gjq16wv20BB8zD8yiMJqTnDWRVYE=;
 b=kQtGrPZo4lKTiEBE/y2i+wBx2dDYOG82R8orkrWpsXwImicYM0F+nDyWeFkf8RjFfr
 J/YbnzK37n1Gfxoy6oeBTHlZWRtfetNs75i9Ck6vAWoBEe8DYcVVZdjkPlMssyELWMZr
 V1TtXrXdoOwgD4PsSaT//1ucINZyh0WMY0UvLBlAH51ENWQ7k2MZ8DP1cJqgsGef3yvR
 tI3l1r7iRUGWN0Ud3siV3x5vFuoUUrU12U12/2GyBlZzomzEYRGTyJnNYNAY6RvC/wMq
 UwjOekIhpMaM8MOYAjfI4IArDKk3Rx++0L5WY0fwigh0yqWMRgaGk+xk/6rW/L52C3XD
 8jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795144760; x=1795749560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e3wD7sDYHdJ5IM8Gjq16wv20BB8zD8yiMJqTnDWRVYE=;
 b=SHTMHDPD4aX5T5UCEf14FUW7rWD0aF8mKVxdf3uLYt1zMF8tB+u2rukwk2MLIw2fAT
 VptiaYj3SZrHGu9JCSKbA5u4w3dFnJblzAJsSb6FwHQYnEiCaieZjPQqjDko0wSDtCam
 +BwuP0D8rjNdSYjYsOjm8qHpDHdxTiPq0FwLOwIwzdZZyle3nJyhiAe9An7ACZ2SVKPt
 a2dura4m3NhJM208Tt66+ZnfZe7wuJw19mw6PLBT5WiypHHJPSVyFUMdTWKxgSsq22QX
 Jl0OfILrHBTTB+00XfyGn4ewXxyBR0ksIlkwwk2E3PjqdBAgm2/H/2QETa8spmOlSTDu
 jEFw==
X-Forwarded-Encrypted: i=1;
 AL+hErH3sgzcPB180rKd6qC/t3mjulOYcf7zlutT/BWYBMOuml3YQAqrDrI1iZPvWQqIyIHDV/wPpm2yfQs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PvwjUcZg2o9dPu0CDecFyTE11vTXE+AFeRthXLCsiOctyksaA
 pPBDPAFRAstgR3MIFW44tF6BWJ7d08bnpd1mGIASC7nHoPTpAJ8h59fc
X-Gm-Gg: AYBFou0NvxJBJnpyQDv2OTqVMu/oRIGkj3cpObPXUHKSyxx4TB9BBe/PS741uY3sUNW
 9iivBtcFpJVDNvCfeECCmGIiEjp/3vIBKegwyVfO7RZcaWjxonYeyVwSnpfZdmot7hHrYq4siHh
 YSsNu8atOs2md6jNtqZ9U2d+attgQuEF3r9L6xUtGWGikqWgmWWhnhRE/PUmj6N52tHQcdrLXPZ
 x+lp0AOvhhms3C7mOH1W7I6VP75WXTKFNsVFD6JSBH3IxrHKsn2xCfJuoz6sLHSfNCqgn5YfDap
 /tBnD0DwTS3tSOUyjWqlZJTp0od/OyLRUPSAzFTCpN5oyaqGSNLBXPXONHZgefKmZvGVoIfJeKN
 kiyVgJnjfCaayrjOVsMJUMGC9QmlbR+lq3SmrOio7faZ/5Vl7OEjKP4tNcg/je90C07pZv3SqZT
 37G0JdAUJt0G2sh6BuRm4CrdNtpD0tcw8jSPg4oDapp2mC6ziFEF1F9PKxhBqCzEXFLMsmjhG18
 Ho+D3ipgMV5qnFFCKZgMadmUA9x5v7VtXjdA94A8RORQKzR9pF9vLEkkf8aAbCElR6lfQA1Yetm
 ga/PFXG8xU5PlB2CB3N4/RSqtaCHbeY1u+vS1OslHlmxsM0GzaqLDGTPT7aCnUA4XhpJl1yK2sM
 =
X-Received: by 2002:a05:622a:5c1b:b0:55c:abad:a72c with SMTP id
 d75a77b69052e-55d76a6260dmr33689941cf.56.1795144760510; 
 Thu, 19 Nov 2026 19:19:20 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349f6959sm14377356d6.31.2026.11.19.19.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:19:20 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/amdkfd: lock event_mutex while counting events for CRIU
Date: Thu, 19 Nov 2026 22:19:17 -0500
Message-ID: <20261120031917.1708024-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

criu_get_process_object_info() holds p->mutex while counting events
in p->event_idr. Event creation and destruction use p->event_mutex,
so the event IDR can change during the walk. If an event is removed,
the walk can access a freed IDR node.

Hold p->event_mutex while counting events.
kfd_criu_checkpoint_events() uses the same lock when walking the
event IDR. Event creation and destruction do not acquire p->mutex,
so taking p->event_mutex while holding p->mutex preserves the lock
order.

Fixes: 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus DRM_AMDGPU, HSA_AMD
and W=1.

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..20e3bbd073a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2234,7 +2234,9 @@ static int criu_get_process_object_info(struct kfd_process *p,
 	if (ret)
 		return ret;
 
+	mutex_lock(&p->event_mutex);
 	num_events = kfd_get_num_events(p);
+	mutex_unlock(&p->event_mutex);
 
 	svm_range_get_info(p, &num_svm_ranges, &svm_priv_data_size);
 

base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
-- 
2.43.0

