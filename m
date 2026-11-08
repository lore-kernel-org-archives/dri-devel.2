Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1106082BD0
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eGGNkyC4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D4510E882;
	Mon,  9 Nov 2026 09:31:15 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1081D10E707
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 01:15:03 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-170135e43c7so113174c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 17:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794100502; x=1794705302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u9X20r2n586k0YtBJ9MVy2V2Dt8dvj2V/QpRqyWFCCU=;
 b=eGGNkyC4O0pLoha1yK1rbKZKJyfAX7hdCxBkPbqRmmZhghs4fb8dgwmn3OnbGfbwev
 Uvy7Mulv2j4T8LeNtx7suF+DpLopss7Ko0/xfGQI7AwTh6SRypDH2PPTRWkyhdnbkAJz
 Yjjtu4xr3fyTTI3JxbA/LGIrl3bwdL4xvVzdlrE0rQFMlmeFtecQBvsmJdNedawqY27j
 0Pa8insRbhsKum2GJKWbp8QcUFcpmoL/R+3RXcgyHehClYFFR2qbnALn8k6k5O4vZhEW
 B5SnClZfknG+VL2yc0I4Fvm8GTCI7e9Koo0rYjPqawpg2+qP8tltFDmnGgYyFvsBHCRL
 vYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794100502; x=1794705302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9X20r2n586k0YtBJ9MVy2V2Dt8dvj2V/QpRqyWFCCU=;
 b=mqXclQ4dtBZDkKoauNSdhOhjgr40G7GRdl/qOejEQW3Ra60h40tE6KFqvh1kfkK+sU
 JVz8bQUJJrA7BmIXh0IDUQwu7TLgsFRXMrBZm+CukFd8jeU4X8wDyQvXn00gTc9Bk5db
 xZkU2X5gZoo0L0H1jZCyOdrZrQzIU4ZWytzPkyZKZl98hIpg3D4RqnWL+OQDLNUuIq8B
 z0zfmaGvow5ga8Gpd0UXCU6LC0T8tB3pnDDjiLR8dzv16pjIqriKJnLC0mUYmaxsIf7L
 AYPD/myhegSLhdp+7euqQUSQljd5Vcw6N3MnbgIG4F59/nsegsPL3TBXqdW5I9Ximjdj
 uXtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOCwxzW1HSjOhzh04TCi8cM4we8GfERtjfuhWMpJn52C9D+hXKXTxGzKgeHaR/C4TQG0nS1YS5eA0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NCa9JLu1ZD/vrc08xrdXfhqiDLm1ZYnachlCsmJlxWsQxgPLT
 LAkeybnU7DmyfLhArRy/Q27MYzRe8qfaQ9x2/8wvSsWOIgLdvOghQ8iJkNRRT8EDgNhZPQ==
X-Gm-Gg: AYBFou39W+jR43kO5k8ROcX2ut3BpM+zFaCiLozW+9U7SceLKeQNMo96t7tZGlbi9Or
 8MBN6PteipTT7jmG39mHyAVRC4QExCUselYG7c7YExA/o6VHBiQoPlg7y/xMsv7lADv1kH+oZCX
 hD5ghqLg3mqLkqoF8mQa+50c97N6KajWQfPeypyIr10RuCXOmLYOdyi5PkzNlO9tEezxrj+U+IP
 LkgbYrAUuIlA3DTez/8SPgjJiXXggBaKoNUSUUm8eifIm0IIkfm5+IL5ty8Mf94ohb/+ZL0Fkea
 UGQ52qwv54+Exwo5y9t/1x1O0KUQO7c4Ug90pfwTd2yHiHlBUGwW3TKkfEx1wu7KQTKZOAHwNIJ
 hUEEnzmnSPYFUkQRat1tO5tkECJ1gE/9X6llFbswB9fSKYkL5UG8SA6WsKmJ3VjyjK5F65NP2w5
 c7eEB9rqclxQ5mR7BFvVHPUDBO0HTdjLv5QuRIiB6S7oTvIo/tMHK0MKY8h8yF5x9mM+d8ByPnF
 DEoLn1aAp5FpdzCt9J2ThRM2ri81fUfVB/uJtf9qSdq1GVsNhrSkuS8h6fhMJKInU4Hni8wTF/u
 uF5rdFJPtjUO3SsPgq0KN3AL93/kf27uk3Hm/MkfQ9U59GGh2kZfiDjBZ1kvPhgWrg==
X-Received: by 2002:a05:7022:b045:20b0:1ac:9da7:e881 with SMTP id
 a92af1059eb24-1b39ff16e06mr339869c88.36.1794100501891; 
 Sat, 07 Nov 2026 17:15:01 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b375603ee8sm1916788c88.9.2026.11.07.17.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 17:15:01 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/9] drm/msm/dp: handle the IRQ_HPD events reported by
 USB-C
Date: Sun,  8 Nov 2026 10:15:01 +0900
Message-ID: <20261108011501.4466-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261024-hpd-irq-events-v8-7-6ee949e7a384@oss.qualcomm.com>
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
 <20261024-hpd-irq-events-v8-7-6ee949e7a384@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 03:35:23 +0300, Dmitry Baryshkov wrote:
> +		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
> +		    event == DRM_CONNECTOR_DP_IRQ_HPD)
> +			msm_dp_irq_hpd_handle(dp);

With this, an IRQ_HPD that arrives while the link is down hangs the
board. I hit it on the Lenovo Y700 Gen 5 (TB323FU, Kaanapali), DP over
USB-C (pmic_glink altmode), when booting with a 5120x2160 SST monitor
attached. The tree is Linux v7.3 with this series (6/9 replaced by an
equivalent local change), the MST v7 series [1] and a few local fixes
outside this path.

The path itself is not new: the native HPD block can reach it through
ISR_IRQ_HPD_PULSE_COUNT. This patch makes it reachable from USB-C,
where every IRQ_HPD now goes there.

When the boot-time mode is disabled for the first modeset from
userspace, the monitor loses the link and sends an IRQ_HPD with
LINK_STATUS_UPDATED (DPCD 0x204 = 0x80). From a boot with the
active_stream_cnt check described below and drm.debug=0x100
(msm_dp_irq_hpd_handle() is inlined into msm_dp_bridge_hpd_notify()):

 [    4.572532] [drm:msm_dp_ctrl_off_link] disable
 [    4.573756] [drm:msm_dp_ctrl_link_clk_disable] disabled link clocks
 [    4.608443] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] type=10 link hpd_link_status=0x0, status=1
 ...
 [    4.823192] [drm:msm_dp_link_process_link_status_update] channel_eq_done = 0, clock_recovery_done = 0
 [    4.823194] [drm:msm_dp_link_process_request] sink request=0x80
 [    4.823197] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] sink_request=128
 [    4.823199] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] 128
 [    4.823201] msm_dpu 9801000.display-controller: [drm:msm_dp_bridge_hpd_notify] After, type=10, sink_count=1

Without the check, msm_dp_display_handle_irq_hpd() calls
msm_dp_ctrl_handle_sink_request(), and msm_dp_ctrl_link_maintenance()
starts with msm_dp_ctrl_push_idle(), which writes REG_DP_STATE_CTRL
while the link clocks are off. The board hung on 3 of 3 boots with the
monitor attached. On the one hung boot with drm.debug, the printk ring
ends at the "128" line, the drm_dbg_dp() just before
msm_dp_ctrl_handle_sink_request(). In the two RAM dumps I could
analyse, CPU0 is still running pmic_glink_altmode_worker, which holds
the encoder's bridge_chain_mutex taken in
drm_bridge_connector_hpd_notify(), and ctrl->link_clks_on is false.

Locally I skip sink requests while the link is down. On this series
alone the check would be on power_on:

--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -400,3 +400,6 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
 
+	if (!dp->msm_dp_display.power_on)
+		return 0;
+
 	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel);

This matches the !power_on check that already guards
msm_dp_ctrl_push_idle() in msm_dp_display_atomic_disable().

In my tree the MST series replaces power_on with active_stream_cnt.
With the same check on active_stream_cnt, 2 of 2 boots came up on the
monitor; the link is retrained about 1.2 s later, when the stream is
enabled.

A check on ctrl->link_clks_on in msm_dp_ctrl_handle_sink_request()
should also work.

[1] https://lore.kernel.org/all/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com/

Thanks,
Joonhoe Kim
