Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A6606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PNhAbmy9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B5610FCDF;
	Wed, 21 Oct 2026 08:53:02 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C5110E0FB
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:57:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so20653265e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792486648; x=1793091448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yRgxxPfGJY8DFWCh/QAVbioiWlq3zShp/hCewrsxoHY=;
 b=PNhAbmy9JOP1ThAYMcxwz2pHFGoel9MyLDiNJ+vsbZViFBiccHxPktw7A9oEwvOOuv
 lR6cjfkQZVJnpbpvIe1APmchRppNqL7AtrXkEsZRUJPuDbg88xJNWV1cF8HSjIs5Ls1I
 KQ6yQ4s2CTD3iXXU5pAgvYzFCezf3v8N5eNI354wZz9dGyF5R8GWonPeDUDE3L2pWKJ6
 NzCTC22a/JHcvNRj0a2PnbtBPdpCMWAk75/AuIHcp6tnoXlNqf33t79nKt15kJCLb8Cj
 njZuHfX8OZ9c2ZEwhRJH2Kdj+OsaaoHuvpZKlYhjRAhNbgMCDCsITyk968cL0zVhiJW0
 ImMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486648; x=1793091448;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yRgxxPfGJY8DFWCh/QAVbioiWlq3zShp/hCewrsxoHY=;
 b=jme7hZo0zOHhMWxv8nRosSN9BAUzEKhbviR0oRAnvJuA1I8G/vJWC3bQpsv804Mf8v
 WTBrm64hZJtCYQWgnO875TtMAlVr3pIfNrjgD+wb1I5O55o1Hq7ed5DMAcwWqB6VCyHz
 wD6AKGbHr90ZVpRTVkq+EI13g0zp/4Jye0nF3jPq7CDmyEu84/SLy4eCxysWXZ2F5DvF
 S+E9tNlhWzn5u7xpiAz/YGAet5XnoFkxYo2zQeZuSj6rD2pkBFE7t3TlVMyT2ESPBYS+
 QXDEw3DwcqrE8SfCa1ivuOQGUm2OcsDohJ5WMHov8QrOBsnTZ4yaKQg6qLC7fK8hid6C
 pjOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrp4j8rxDQJxZrPldiIJvzCm4gK/l187M1Z91XtG/qo8gyiym6jy9x9YMAnz+GRLDG0V4htBvxi/o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtljK7G1n6yUYhZd6B4jUId5/VrazClozzsFrMkq2PwI61ak4H
 J+CR5yT8IqNctq4dKVtbOaBl5jdwxveZV0FIUhCVqwSp5LZkSsmSIJLf
X-Gm-Gg: AYBFou3uaufg69LqRIck25y1F3MixOO776JkKKEkla9UVUJ56trGXYd20W5VopqGCOb
 ShqyYFa7SjREAy+MMSerq7HCJoKldwmiaywFNxPh3vEjyQgbmcv5yflaUTFJltTgTOAGhhpHuzT
 51yp+HTZO/ZMJTixIOzTRgctmBC5csY8alFdK+JHUvpmoTvWdp5x7U8fyBZevK5uNzIn0N+/u+9
 TQLl9U48f4Gc4Ec/ezYgvbQGC3ODGrGx41RoaFe6Q7pDN/qexpnbbAw3urJcXGJrwmZx6rHBddb
 9Wl7sb7xsjURJBR2vT3iiMm8m5VeB7RvhoykJ+dUSnwXf8uNIqmKQgNPVcwb/WDZvh1bbFgIEFc
 ewOjdoSPxqiFx3gKdfz0BGcOwr2i9ljZNUoG+L5PrVRitof7cc8Sx6j+Syptfy1F62GH6tE7BON
 RvpchV+lb4DlD36fl96F4PwZqw8AuPsCTC842nBIDb/8tJmlGET6Xhx7m0zZdTVzP4+FLf+TyJb
 CEI14fR
X-Received: by 2002:a05:600c:8883:b0:4a1:80d8:aed0 with SMTP id
 5b1f17b1804b1-4a1d75fe793mr166287925e9.15.1792486648186; 
 Tue, 20 Oct 2026 01:57:28 -0700 (PDT)
Received: from localhost.localdomain ([94.252.74.55])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2e8daffsm57580335e9.4.2026.10.20.01.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 01:57:27 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
Date: Tue, 20 Oct 2026 10:57:18 +0200
Message-ID: <179248663855.32151.9955864156939592299@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACSVV00x091i7BKW+bj0RUnkd4rOrHXbhZ4zF6SuTU1NAqsFTA@mail.gmail.com>
References: <CACSVV00x091i7BKW+bj0RUnkd4rOrHXbhZ4zF6SuTU1NAqsFTA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I guess this should be investigated further. Yoga Slim 7x Gen 11, no modules,
firmware built in, so the GMU comes up at 0.6 s.

It's rpmhpd. Before its sync_state, rpmhpd_aggregate_corner() pushes every
vote to the highest corner. The gxclkctl probe does a runtime resume/suspend
of its GFX and GMXC domains at 0.18 s (qcom_cc_probe -> pm_runtime -> genpd
-> rpmhpd_power_on), and from that point both rails are stuck at max until
rpmhpd syncs, which is at 2.8 s here. The GMU then does its CLX DCVS
calibration on a rail that won't move.

The GMU log buffer (fw v5.2.38) agrees: the calibration trace of the bad
boot matches the first good one step for step up to the ninth level. There
it stops, and the firmware puts HFI_F2H_MSG_ERROR 0x007306c7
"ResMgrCalibrateDcvsLvl" on the debug queue. The GX_BW_PERF_VOTE timeout is
simply the next message we send.

With gfx and gmxc taken out of the clamp (hack below) the first GPU init at
0.6 s just works, CLX tables included. Three boots so far.

The wedged GMU after a failed attempt is a different story. Retries after
rpmhpd's sync_state still die with "GMU firmware initialization timed out"
until gpucc's sync_state (fw_devlink timeout, 13 s) collapses CX. That's
what the gpu_cc_cx_gdsc/NO_STAY_ON thing in my earlier mail was about: the
recovery, not the cause.

The RSC side is not it. On A8xx the GMU firmware loads the RSC sequencer
code and TCS slots on its own; preloading them before the first boot made
no difference.

Abel's CRD failing even with msm loaded at 90 s doesn't match this, unless
something keeps gfx.lvl high on the CRD after sync_state. Could be a second
problem.

--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -1009,7 +1009,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
-	if (pd->state_synced) {
+	if (pd->state_synced || pd == &gfx || pd == &gmxc) {
 		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
 	} else {
 		/* Clamp to highest corner if sync_state hasn't happened */

Oleg
