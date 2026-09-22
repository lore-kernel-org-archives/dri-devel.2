Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13567C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487E210E06E;
	Wed, 23 Sep 2026 07:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="C/1PHKYu";
	dkim-atps=neutral
Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com
 [74.125.229.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E5010E976
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:01:32 +0000 (UTC)
Received: by mail-dl2-f43.google.com with SMTP id
 a92af1059eb24-14373bcc010so269181c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790107291; x=1790712091;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7z70TQXn4poqOPaKrCAHTGIhbFu9qXKNqmozdXBkBPA=;
 b=C/1PHKYuYru5K5nv7I1y/xrCNrZU3r0fspIQk/wrvJshDjk4vZIw0GFQCpBKToBr1b
 Ft2rzXkaQUR2i7UbGyT/7NYlQTgzlbPKAWrwOqMol8CzBDWgGHWPiyH9Pw+VayZSJh8H
 /GFDgac0AxHXCUHRL5Ww/S/ayF7ECUfkirtAEZ+QqPZDNr3dHcgg38wrEO4ktH6pckTu
 rnVJd9LJMjzA/M9PNRB8DR0BtahjO72j/aaw8KD7Nh8WiF2ZrgkDorOO+ZO+yQsCuJmx
 2u3ZZtrfBknUah6JefiLUAbkcnmMVSXe4Ab+5OZaTgl7Yah+G8bEab1fj7gtPCGX3WuD
 hMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790107291; x=1790712091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7z70TQXn4poqOPaKrCAHTGIhbFu9qXKNqmozdXBkBPA=;
 b=ZK1FVofOVYgtxiIFjlgWSDgqs12+/tLjH1zT9ZFf4yrTVDGxxmW55Q0yVfHFGveoxJ
 GTw/QVRDBy4h4BS34gQ2zszm6fuEMTo1wtdO2yJ8mWEh9kfLiW7o19FzPsW8Wrmn4stH
 atJiCGvdeS02bPAw767Ov4x0ZJcAjjG1mNp4ZqKGwJwIyZDehpUCoZ4a6/ANzn9+8EuL
 bM1kPUu9oNIE0OlXOQzvApg7DhpGHAAYQxTNOrkHNhyCXIDyHNRLqtmgmJRGeUZqKDoD
 XKBltNoL9k7hhLMgsrqLc12HV0Pq3dyPIwidzzJ1qq5xny25BGwo3jfIIPpUCK+WqA6S
 AWtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf+ZvwrHl4AoI6TWDtVcECj8DZGHNO6fl7A9ZUWBb6kydBcN8HCdXc2hfiZReYLR1QMYTgSmjKvxQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kSkdrfVgc22txrYBu4p9UKWgGynJ5ZRRLutm0F8xQaB/ZTp35/
 xrF7+kb/uu5wrkI1/ZzxSt23LT/BBGhSBdJKiDB36ZM4A+zAQvcO9+ZLpakcwvL4nzA=
X-Gm-Gg: AYBFou0lAz6v29EhZC8qrLDaEYPz5NraSzzsS+CwltnEzXmprRag7QD0WaFO0jb/nni
 5VbORPJrLkudtXelrz6rrq6ro6ZwI0q0euxwj3UNZbvfVozcXaQZIAiixXVvi2zUyrPsl9jDYcc
 c4rdrO6C7eXqgy7ofHQwezjEnhtyd3b5tYOZdRIWVRpAiNK+8a0Dg0Y+NwZ75/ChmjiCyVpLvDw
 981lqEKQ8WwGUIcWnVIg6odVVPvx/jgb2YnAGZj1bacVnS33MoAFfcBYjl1bGjoadFbnsanOQDC
 n+0OPMGPiG1Fqg0lHbnciG96sFSOHqq+DqmizexdbJAB/YtMvSw+k7n7yyZ3lpczYWFBur3DMFb
 880u/hW44ZtPNoKn/gmH/3q6bt+lXLMom7vJLnYN6wtiqvOkvmWUD228/CDkZUtH3qfRoyzsT8Z
 ulEhuyJ1FNJcqCGXGimZHoAUe/6j68sqyScj6O+qY3pOzZrRAN8yV8+IEToUzzJI79U4HAJMF4f
 SUrW+VqqozJtluRPEE8EZhDUIeLMLmBOg3LqnpK4Di74PheMCy77vlaBv1ggldIiQIcGVg=
X-Received: by 2002:a05:701b:4247:20b0:143:297c:82e1 with SMTP id
 a92af1059eb24-144f931bbf3mr446013c88.33.1790107291150; 
 Tue, 22 Sep 2026 13:01:31 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f982089fsm602138c88.5.2026.09.22.13.01.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 13:01:30 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Johan Hovold <johan+linaro@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 6.1.y] drm/msm/dp: Drop aux devices together with DP controller
Date: Tue, 22 Sep 2026 16:01:26 -0400
Message-ID: <20260922200127.27433-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit a7bfb2ad2184a1fba78be35209b6019aa8cc8d4d ]

Using devres to depopulate the aux bus made sure that upon a probe
deferral the EDP panel device would be destroyed and recreated upon next
attempt.

But the struct device which the devres is tied to is the DPUs
(drm_dev->dev), which may be happen after the DP controller is torn
down.

Indications of this can be seen in the commonly seen EDID-hexdump full
of zeros in the log, or the occasional/rare KASAN fault where the
panel's attempt to read the EDID information causes a use after free on
DP resources.

It's tempting to move the devres to the DP controller's struct device,
but the resources used by the device(s) on the aux bus are explicitly
torn down in the error path. The KASAN-reported use-after-free also
remains, as the DP aux "module" explicitly frees its devres-allocated
memory in this code path.

As such, explicitly depopulate the aux bus in the error path, and in the
component unbind path, to avoid these issues.

Fixes: 2b57f726611e ("drm/msm/dp: fix aux-bus EP lifetime")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/542163/
Link: https://lore.kernel.org/r/20230612220106.1884039-1-quic_bjorande@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Backport to 6.1.y: the source change is unchanged; refresh context
  around the older DP bridge layout. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and MSM DRM maintainers,

I am continuing backporting CVEs still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53851

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 drivers/gpu/drm/msm/dp/dp_display.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5beb727f8437f9..ddd0279bc8963a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -322,6 +322,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 
 	kthread_stop(dp->ev_tsk);
 
+	of_dp_aux_depopulate_bus(dp->aux);
+
 	dp_power_client_deinit(dp->power);
 	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
@@ -1535,11 +1537,6 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	}
 }
 
-static void of_dp_aux_depopulate_bus_void(void *data)
-{
-	of_dp_aux_depopulate_bus(data);
-}
-
 static int dp_display_get_next_bridge(struct msm_dp *dp)
 {
 	int rc;
@@ -1568,12 +1565,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 		of_node_put(aux_bus);
 		if (rc)
 			goto error;
-
-		rc = devm_add_action_or_reset(dp->drm_dev->dev,
-						of_dp_aux_depopulate_bus_void,
-						dp_priv->aux);
-		if (rc)
-			goto error;
 	} else if (dp->is_edp) {
 		DRM_ERROR("eDP aux_bus not found\n");
 		return -ENODEV;
@@ -1597,6 +1588,7 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 
 error:
 	if (dp->is_edp) {
+		of_dp_aux_depopulate_bus(dp_priv->aux);
 		disable_irq(dp_priv->irq);
 		dp_display_host_phy_exit(dp_priv);
 		dp_display_host_deinit(dp_priv);
-- 
2.39.5

