Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818ED606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMaTP7Yj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98F110E4B2;
	Wed,  4 Nov 2026 08:58:10 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC0A10F5A5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:51:45 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-14fc585291cso3309085c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793713904; x=1794318704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eZFocSGQWUyjjZwOU15rPwT7Iy8HDoBofRSNVrSiUk4=;
 b=uMaTP7YjXk7J8HDVKfYilMTZSYMZL+aiyl8ygE7+TEOBTJ8NGquQka391yUHtI4286
 lRWdnVnCXW7n7f4OifD4spbFAZqZEbURKCaFmprqKpbUZHLOqyY0DEoK+wdGuNUE0yvH
 kTiyepir4RxTHS448bWRcAY5y7ljUTn6fvZNLjYPPqGNEvCGPoZrJ8cSeEfNOM88EH+F
 kyYfbBUOrzZZapvO5Cg5pHO7jiVH28FtRz18NjD1VXTDtgGikZ+nKdq8WSrlKcG2qGh1
 AKc/OTMwmOD2NuNK2FES2XpU+z+IKvXAL/uUFO/k+qM/PWFZH+pL/7Y9NRSXYJWPMkGA
 D9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713904; x=1794318704;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eZFocSGQWUyjjZwOU15rPwT7Iy8HDoBofRSNVrSiUk4=;
 b=PjTjY+/7D60d/3VPTQ3B6RL44KwPl+0E/d6qAijqwTYNx+g0t2lNxOvS37HPMYXsP6
 euR5WKDY0xQEMu65hxUgRYWHrr9Dj/wVpfQwkBY7lni6KhF7k2WEACLlolzHu+k9Iraf
 a3u+xdF813jJpJBPdpWwjzPEn0vzNdIrrmd0LIVlH5v3QqfdRdtRLM0s/Pktsm7F1M5o
 LqAcyDt6TY/HmvCKcd+wJRrcsKhENLxBvTaw8/+lqD4AVXBXFXfLIqI1s3/8UonvSx6x
 4Br3ZyHxyaXouB6wQH0uW5BsW8SJPEz+WvopQRXHNyqnF7+UvWvWXwdRB6VPLYdDoLhg
 EggA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwNWVs+oqkDUuAuaVN/TrHu+gmKV5lvTcu8uz56eAeq5gpAJy83gKixSVcqTx9zWPher44cE9hN14=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/hLEu4L2RSrgQbATkmr+1G0EfjkghOknKIyPq0j0IpoMEHh9Nc
 8/vBnyWxLWm3m5Lin1WurSm089rCC3RUEsrbX+MMX2OtE6dua2T6IpzO
X-Gm-Gg: AYBFou0qtE5Ev0UE9VINIEqkmjTGYqdWwfbW9ZDHMdANe9EA5/gOMeeCIxqfrrd+PHG
 GZQdu6714sU14PSw0e6mSx142VBSUFliP4oOnHDlbooorG1//NIY9Mq5Bu3yeaFglryBttjYQSX
 4eEUSKoqWgDdjRGlU4fApUPtyOXm1jM4VyzM98Uf5dKdQCOTJYDHUfEOGmP14YbhveoIlfLlUuS
 sPpf/h8unULQm2op7UkCAm/DrVYHbmJDhlTduJSvHjT57BCQ8dKedNMUeK5jxqyAxlb65NUtvd+
 zPc1Co80rG+AarLrcmga3t8JUj52TvmJzaxvW3UA9oVNklLL1R2ODtLRNAqC3p5AEdW2XQEyx5Q
 /Y/V4zMlQFMFoiMo88M5KlIkX2Os/tIJ304ZLesLRi0pWRO38ndax+1N1Y7hvlhnZfzUU4I3T5c
 Oc735p+ppEkGKSXWanh+NnnZUQz7+u/MFWwhllK1Iq4UWi/uTpcbCAiuagJIEihsLYtzZ67qBDv
 QRV5Y5t1js6vP2nqVHIqW3LxQHmGPTz+y7zW91k/2hgBGq6iIbSC76dxZDRXKSO2IY0fh8m9XWg
 YCk9e5JVdWrpSDY/BCIHK8dSHlHnCJf4Fino4SIsr4n8JwEvBvzwTHDepDxr1xWKUw==
X-Received: by 2002:a05:7022:4392:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1ac5de53bc8mr32355285c88.29.1793713904238; 
 Tue, 03 Nov 2026 05:51:44 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm46918499c88.12.2026.11.03.05.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:51:43 -0800 (PST)
From: joonhoekim <26rote@gmail.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Joonhoe Kim <26rote@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/20] drm/msm/dp: Unwind resources when enabling a
 stream fails
Date: Tue,  3 Nov 2026 22:51:40 +0900
Message-ID: <20261103135141.1993-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

From: Joonhoe Kim <26rote@gmail.com>

On Fri, 09 Oct 2026 11:16:01 +0800, Xilin Wu wrote:
> Stream enable can fail after acquiring a runtime PM reference or
> starting the link. Returning directly leaks those resources, while a
> later disable can release a reference that was never acquired.

This leak breaks USB on a Lenovo Y700 Gen 5 (TB323FU, Kaanapali). I
tried parts of 08/20 and this patch as a fix for it. The result was
worse.

The sequence, seen with kprobes on v7.3 with out-of-tree board
support:

- A USB-C monitor is unplugged during s2idle. On resume, the stream
  enable trains the link to the gone sink and fails. Nothing releases
  the DP PHY init taken for it.

- At the next suspend entry (booted with no_console_suspend, so fbcon
  restores the old mode), an enable on the disconnected connector
  powers the DP PHY on, and msm_dp_ctrl_enable_mainlink_clocks() fails
  with -EBUSY. The PHY power is not released either.

- The DP side now holds the QMP combo PHY. On the next resume,
  qmp_combo_usb_init() skips the common block init, and
  qmp_combo_usb_power_on() times out waiting for PHYSTATUS. The dwc3
  resume fails with -110, and USB stays down until reboot.

On top of v7.3 I applied only the PHY power tracking from 08/20, the
power-off on the link clock failure from this patch, and a backport of
1bda647ce61b ("drm/msm/dp: move link-level teardown from
display_disable to display_unprepare") from msm-next. Then the same
unplug during s2idle crashed the SoC:

  [drm:msm_dp_ctrl_link_train_1_2] *ERROR* link training #1 on phy 0 failed. ret=-110
  ...
  [drm:msm_dp_display_atomic_enable] *ERROR* DP display prepare failed, rc=-104
  [drm:dpu_encoder_phys_vid_wait_for_commit_done:583] [dpu error]vblank timeout: a0820302
  [drm:dpu_encoder_phys_vid_disable] *ERROR* wait disable failed: id:37 intf:0 ret:-110

The device then reset into its crash dump mode. It crashed the same way
once more, after a failed link training during repeated VT switches
with the monitor attached. There the log went on 10 ms later with:

  qcom_q6v5_pas d00000.remoteproc: fatal error received: sys_m_smsm.c:503:TZ force stop

Without these changes I saw the same failed enable and "wait disable
failed" three times, with no crash.

My guess is that the DP PHY, which clocks the DPU video interface, is
now turned off while that interface is still enabled. I have not
confirmed it. So I can't give a Tested-by. The PHY leak is still open
here.

Thanks,
Joonhoe Kim
