Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F06082BC1
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mx24uPX7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468D910E518;
	Mon,  9 Nov 2026 09:31:10 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C49A10E6FD
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 01:07:25 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-3700ed8dbe3so366075eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794100045; x=1794704845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B6NBC44oLa95X1aY0aLFRnK9SzAu0klmdILnt2Ypptw=;
 b=Mx24uPX7fdzw2XDSBZDgM4hIUjacr4cJlzGIszLNy4urYYiFPaJqXf3++cXOPjB3m6
 R4W+LzNb5YUjWFH+I/4UdYx49vUD832vnnFVazObD41yq/L52FtDZjz+IH0j+WXe8PKM
 AaOqzBAsKBgFwFph78NFvY6PI6tBPF+8m3kpk0Tf60hdgfeyboWCTQ6bPApD1+EOsiZh
 IJt6tjUh9p0MzzsiiVUFjVYPRALV0WAebb1tqjDSQnHs/G8A7c5Kd1pEpROnxK1ngAJd
 13Q4BYxP/cizdgAhZ8gURXwqWu+JJ7YRQe6lo1nzNWMHkIDiN8NZ6aT6JIY7pcLDNnEJ
 Vo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794100045; x=1794704845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B6NBC44oLa95X1aY0aLFRnK9SzAu0klmdILnt2Ypptw=;
 b=jPgJeQQ6YdVMvda8OgOES5d7Zm4yPQgVlAuq2kg3LF2j3BomOedbo4Gz5hP6LeJVg6
 Odr1wEMH1jXyHNSa8r2Gks7GJD/+e4UUdCAGpMbvlgsJNNw8s0UbwtJtBnOm/MZpWKAC
 aK4loCzLyXwcD9TIYm+CdVmZvYwf1SEMARc947/vCaAUY1/d3Jlgtbvq8BT95hsyycr4
 JM+tJymrwSRyohM5odrZyrri3qSi6OSLNzL/Q7vqkamP8k08hshA7Xn4m69jVL3nXKZT
 MeLhw//OtmxmQTmxFjLfkgqc39lDDjDXOwnMA0Y8Ba0Q2XPdA0cind2Re9AczDPPDVHV
 BkSA==
X-Forwarded-Encrypted: i=1;
 AL+hErEC4HEdXFZgyorRa7Z87ptJNjEevEMdG/P5IGXaTnIz7Kh4iuE/xJnqX7aYZs7a9Ms/veN6w7xhGJY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UFPDM2G9++dbZn6c8Y+emyfuFBBko/R+TzXip2DjLBGpAResD
 /lw60zoD5uh8eIOoEeO+OFLo42shMHosFR7kE42EUP1z4FG/eo4ZImHj
X-Gm-Gg: AYBFou3T8CKNJK+2/PNVha1ECMaB7d/c+k7hPMoSv6sXbJMvr75/iIE8n6eSiGgM9cU
 d8z53i9BnNbXZ0w5reTGqFAiUzlBBUFkgK2CTUk1P287/WA1gdI+7CqkuJqr3QgjAVV6oSjLzYW
 8uqs8Hz4laTiOGhK/Pc3f7kSJ7axq+u1NoWAN4XT795+NMdcQoXQSf+YwUjPUNuew31Cy52jRLh
 5QxGiWtYtaH60qNlAYPPU6e/GnbGI7XwXwzRQkN/zYJl2/mudcDdoAFdNXqlM9aFTccLEFy2d7b
 LSxQfT3vW4uR2N+KzJiLnIfIQjfizEeIhFEDotY0gjsmWdcmw7T/jV64pQ6bZB4zCRp33brMccH
 K6yIZrG7v+yfa8OcxVyjq+E7tMpjzR+ply3a3mHT1XAgW6mTdahzJxwp64uKCmSa20vST9APMNv
 EhhfN/eLiiChb9pRPE1horABnoFXG4M0wblhHIbdBkhYgxq9SbdI9zSQREkJnNyMrBxnVF+sQR0
 c/8w1sH366oUDNPU+y+rBjRY5kFfz/HpWNFG7LDGt3Qxf3Qpo/KmcWbbWbpvjD9DR4RfPg3muJg
 bkV3ecSPrjrWgqPg8cySXNjgTZ2XAZcwuiMRZyEQF2kF
X-Received: by 2002:a05:7300:e920:b0:36d:25e:1961 with SMTP id
 5a478bee46e88-3725e240abfmr839498eec.22.1794100044508; 
 Sat, 07 Nov 2026 17:07:24 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265c06c61sm1344623eec.14.2026.11.07.17.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 17:07:24 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 32/35] drm/msm/dp: mark the SST connector disconnected
 when MST is enabled
Date: Sun,  8 Nov 2026 10:07:24 +0900
Message-ID: <20261108010724.4061-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260929045429.A51801F00893@smtp.kernel.org>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-32-4b81473185e7@oss.qualcomm.com>
 <20260929045429.A51801F00893@smtp.kernel.org>
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

On Tue, 29 Sep 2026 04:54:29 +0000, sashiko-bot@kernel.org wrote:
> Does this introduce an AB-BA deadlock between mode_config.mutex and
> plugged_lock?

Yes, I hit it on the Lenovo Y700 Gen 5 (TB323FU, Kaanapali) when
booting with an MST monitor on the USB-C port (Linux v7.3 with Dmitry's
"drm: handle IRQ_HPD events correctly" v8 [1] and this series). The
lock order is the same in v7 as posted; nothing in my tree changes it.
The HPD worker holds plugged_lock and waits for mode_config.mutex
(msm_dp_display_mst_enable() is inlined into
msm_dp_display_process_hpd_high()), and the compositor's GETCONNECTOR
holds mode_config.mutex and waits for plugged_lock:

 INFO: task kworker/0:0:9 is blocked on a mutex likely owned by task <compositor>:2439.
 INFO: task <compositor>:2439 is blocked on a mutex likely owned by task kworker/0:0:9.

 Workqueue: events_freezable pmic_glink_altmode_worker
  mutex_lock+0x30/0x70
  msm_dp_display_process_hpd_high+0x23c/0x2c8
  msm_dp_hpd_plug_handle+0xf4/0x208
  msm_dp_bridge_hpd_notify+0x118/0x290
  drm_bridge_connector_hpd_notify+0x7c/0xf0
  drm_bridge_connector_handle_hpd+0x5c/0xc0
  drm_bridge_connector_hpd_cb+0x1c/0x30
  drm_bridge_hpd_notify_extra+0x4c/0x70
  drm_aux_hpd_bridge_notify_extra+0x4c/0x70
  pmic_glink_altmode_worker+0x274/0x520

 <compositor>:
  mutex_lock+0x30/0x70
  msm_dp_bridge_detect+0x54/0x338
  drm_bridge_connector_detect+0x40/0xc8
  drm_helper_probe_single_connector_modes+0x158/0x608
  drm_mode_getconnector+0x19c/0x448

32/35 is there to avoid a transient connected -> disconnected change
seen by polling. With 25/35, drm_bridge_connector_handle_hpd() stores
the result of detect() in connector->status right after hpd_notify()
returns, and detect() returns disconnected once mst_active is set
(29/35), so I wonder whether the write is still needed. If it is, it
could be done without holding plugged_lock.

To get past the deadlock I dropped 32/35 locally. Since then, booting
with the monitor attached has not hung (4 boots), and over 3 plugs of
the monitor with drm.debug=0x4 the SST connector never showed a status
change in the probe helper; it stays disconnected while MST is active.

[1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/

Thanks,
Joonhoe Kim
