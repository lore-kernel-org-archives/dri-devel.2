Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5F6082BDD
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlIB3j3o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AAE710F06F;
	Mon,  9 Nov 2026 09:31:35 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7768210E054
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 01:14:51 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36e99cf7bb3so234076eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 17:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794100491; x=1794705291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=axwt+uxCb6RU8443n13TL3SuB1RoRoLly/8X+nI0FOg=;
 b=HlIB3j3oTnffLZrvcxfGoQqKQfpUo2x3czjNW88ot+OVMeAtMyle8vuLL1YZg6Byrp
 Q3ICnSvFdNpgU0InsqEelvpg6wBvRhhdB88rkG/f1UW+G91jcaALXi3C4FWSit8wAtL2
 8XMvr4Sx6MGiy1feoiQdzfNqbndM7/slE6QOSpNmulKjUdypVTY9dgBSfezyoSpsW/Rp
 oJ12g9HGJNTy/NJgILrVGstGoapthevXFGwWp6l83YJ/3urtzbY7/YOP8XhNZ4wYGU8Q
 oxyy1ViD7+h8wzeQFrfTFaGWxzavjPwMYXuvOjmG4L/I7j06W9OoePI8g7FNZuUMdiBI
 lVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794100491; x=1794705291;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=axwt+uxCb6RU8443n13TL3SuB1RoRoLly/8X+nI0FOg=;
 b=PYS4MdWpK8co2icPSoOlPKIobM1MUpvL+OMXNCFzQ3xVilTjRNKwg6FPPUH1cqdIS+
 O/kZDFHYhy6gadoB4Sx84wTuKowAHe3DNB5dWkdTdNZm/jxMpuriKFceon8rwH9RBE8T
 66ebBzR/6Vcv9dq5kiu73vA/EZfEmTD6mogcKBFfI/qzHV9hkJGUkozIrTo0eSPY1Ghc
 GtzfaCw+v/9BEgGhlEw59nEHjqsFS06Nq4oam0tZgXUYY+Rf+CvUashZnDAjQouKUsqZ
 8aBjYzRG4Le8DsHhAHC5bUyT8JJ14uQzrVdwZJXDZyv9KY6dssPhA7gTWL7FL1Vfw4NT
 P2IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiM4lQeGVXukCt3NfaiPS7po7UXxC8Ru4ZzjW6kEumIsGqJTAO0ypH67Pvu6uq+hIyh1oog8RttQY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Dobfj9CCtBn09GLpY49TaZiLywnCAZFYUrzv+mVAWDPStp5aL
 vp/pezBt3mqVucDO/hiuHpCQM/SUaCy0Fr/oOFdGsbOMqjPecBZQUsqL
X-Gm-Gg: AYBFou1F5WGa1z0bhEhzV0beT8Fv2UYA7oHdhMgiqy09n/LUjva0wc4qdSvQAEQNNE5
 UGwlUuAP9gfJRgdm+p59/SuGfkPA2wlJxnd9dhrdpZbC80IIHkM229jVMpvRqVpheiGACyEh8y3
 alnpwF2rWjPPZakI6wh4R8dZBsp9qxaTvB7nE09rhd3lwpfXM6vXj2Exm7MzjH2OpmE+oad3lrv
 twRDCOgRQGCAKK3pmC/aLCm5N1UoRgSnkJHp1lat/aeCawNFjkri6MqtTA+kl9LzSrz/l9CK0yI
 cvU+QT08cC9UltkWiSX2+7v1UOG4LNs+Of0XqHAu3eBXQ0vFdp+aTF50LF4EIq6pq97DUy4paVu
 zJzGL2kTJWfzWDrbDi8OEvaw3Mp608xeNst+aq/YjpMzTEgt0nRQcOyrM5ybov+Tc7T6ZhkU6iY
 6xxRNLVpRw/J4NZTa3Lqc9I7CHIjPfhJOrgr6WZW6HM1cnUUPECKiftbv/Tu22c9wQIiVoGvqT6
 AuoMU5cBeYE4nqVQJNjgM5cYkKTtUMPJJqtAYSyEVkedjOnhv18d8F1shbClFajCIdZVZWmFOJR
 ULDMOEmQw3EcpzoQ8nZWRKU8NtJTFpT6ETqrdWSwpLAZMAdDGSSeGuoZgV8GftRrnA==
X-Received: by 2002:a05:693c:62da:b0:36f:4615:9747 with SMTP id
 5a478bee46e88-3724ff5a59dmr908439eec.0.1794100490242; 
 Sat, 07 Nov 2026 17:14:50 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372656187f8sm1335220eec.5.2026.11.07.17.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 17:14:49 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Date: Sun,  8 Nov 2026 10:14:50 +0900
Message-ID: <20261108011450.4428-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I tested this series on the Lenovo Y700 Gen 5 (TB323FU, Kaanapali):
DP0 over USB-C (pmic_glink altmode) to a dual-screen monitor with a
built-in Realtek MST hub (two 1920x1200@60 sinks), with the built-in
dual-DSI 1904x3040 panel also on. The base is Linux v7.3, not
linux-next, with Dmitry's "drm: handle IRQ_HPD events correctly" v8
[1] (the cover letter lists v5) and this series. A few hunks were
adapted to other patches I carry. On hpd v8 the second hunk of 34/35 is
not needed, because msm_dp_bridge_hpd_notify() already handles the
plug before IRQ_HPD.

With three local changes, both screens show separate desktops next to
the built-in panel and come back after s2idle.

1. The plugged_lock / mode_config.mutex deadlock that Sashiko reported
   on 32/35 happens at boot with the monitor attached. The stacks are
   in my reply there [2]. I dropped 32/35.

From the cover letter:

> With 4x4K monitors, due to lack of layer mixers that combination will not
> work but this can be supported as well after some rework on the DPU side.

2. With all three displays on, the commit for the second MST screen
   fails:

   [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_4, invalid DSPP_-1
   [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_5, invalid DSPP_-1
   [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_6, invalid DSPP_-1
   [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu error]LM_7, invalid DSPP_-1
   [drm:_dpu_rm_make_reservation] [dpu error]unable to find appropriate mixers
   [drm:dpu_rm_reserve] [dpu error]failed to reserve hw resources: -119

   The compositor sets a CTM on every CRTC, identity when unused
   (adding or removing a CTM later forces a modeset that reassigns
   resources), so each CRTC asks for one DSPP per LM. Kaanapali has
   DSPPs only on LM 0-3. The built-in panel takes LM 0-1, and the
   first MST screen takes LM 2-3 because 1920 > MAX_HDISPLAY_SPLIT
   (1080), which leaves no DSPP for the second MST screen.

   This is a DPU topology issue rather than an MST one; MST just makes
   three active CRTCs easy to reach. Locally, a CRTC that needs DSPPs
   uses one LM up to max_mixer_width (2560) instead of
   MAX_HDISPLAY_SPLIT, and the two MST screens then get LM 2 and LM 3.
   This touches the same decision as Mahadevan's LM rework [3], which
   drops max_mixer_width, so I have not sent it as a patch.

   Mahadevan, should a CRTC that needs DSPPs prefer a single LM
   whenever the mode fits in one, on top of your rework?

3. s2idle with both MST screens active hangs in resume. The console is
   suspended; the printk ring in the RAM dump shows devices resuming,
   nothing from DRM, and then "watchdog0: pretimeout event". The
   rtcwake task is stuck in an AUX transfer in resume, while the MST
   stream is re-enabled:

    wait_for_completion_timeout
    msm_dp_aux_cmd_fifo_tx
    msm_dp_aux_transfer
    drm_dp_dpcd_access
    drm_dp_dpcd_write
    drm_dp_dpcd_write_data
    drm_dp_dpcd_write_payload
    drm_dp_create_payload_at_dfp
    drm_dp_add_payload_part1
    msm_dp_mst_stream_enable
    dpu_encoder_mst_atomic_enable
    drm_atomic_helper_commit_encoder_bridge_enable
    drm_atomic_helper_commit_modeset_enables
    ...
    drm_atomic_helper_resume
    drm_mode_config_helper_resume
    msm_kms_pm_complete
    dpm_complete

   Several kworkers wait for a modeset lock in
   drm_self_refresh_helper_entry_work().

   At the hang active_stream_cnt is 0 but link_ready is 1, so
   msm_dp_display_prepare_link() returns early and the payload write
   goes over a link that system suspend has powered down
   (aux->retry_cnt, the count of consecutive AUX failures, was 107).
   While mst_active is set,
   msm_dp_mst_stream_post_disable() does not unprepare the link after
   the last stream, so nothing tears it down for system suspend.

   The series also does not call drm_dp_mst_topology_mgr_suspend() or
   drm_dp_mst_topology_mgr_resume(); i915, nouveau and amdgpu call
   them around their atomic suspend and resume.

   Locally, the DP system-suspend callback calls
   drm_dp_mst_topology_mgr_suspend() and, when MST is active, tears
   the link down through the unprepare path (clearing link_ready)
   before pm_runtime_force_suspend(). On resume, after
   pm_runtime_force_resume(), it re-inits the PHY and AUX and calls
   drm_dp_mst_topology_mgr_resume(mgr, true); if that fails, it turns
   MST off and sends a hotplug event. With that, 3 of 3 RTC-woken
   s2idle cycles resumed with both screens on. After the third the
   topology was rebuilt (the MST connectors came back under new
   names). I can send this as a patch on top of the next version of
   this series if you want it.

Unplug and replug mostly works. When it failed (3 of 6 sequences),
the hub had dropped HPD or stopped answering AUX right after the
plug, and one or both screens stayed dark; the stock Android kernel
shows similar failures with this monitor.

Not tested: daisy chain, 4K, audio over MST (no audio sink here).
If it helps, I can test the next version of this series on this
device.

[1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20261108010724.4061-1-26rote@gmail.com/
[3] https://lore.kernel.org/all/20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com/

Thanks,
Joonhoe Kim
