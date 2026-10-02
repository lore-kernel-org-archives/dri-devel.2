Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3187CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B6510EAF0;
	Sun,  4 Oct 2026 17:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KW1j1IFO";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE0F10E636
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 18:29:30 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so151120f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790965768; x=1791570568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+rrH8jPIjco9vZfHT3xe2ptHn3BuOpvxKbC3e4I9zuk=;
 b=KW1j1IFO3zdo7iEqP2t/F48xDslEDU7NWGDiJzTXUTW9RJNi7GiQIljfwW+lwV5UhA
 t6NpuAVPDaj07pSCQgeAO9WIkTQ+sOgpwmYfbRhb+ZX3S4PBjla07WxbpuVOuJ+nL29G
 xA760DYA4QlqX1A8Of3+1rb9QQsJ/Mj9upXIgRHdJPMs+mcAMashaBLjG4aAIo0cFhfW
 abVdW45KYnDfoiTzwMMB0ie7hcQaU2Kc6byNWy0E/Z5Xfne7Dg45OECQLPkGppt1gKL6
 1+AZn+wWXxOIPVGZDvMHgzebS/dSm2s87V4y9WBi8k4SgyreOtlkJt9s8rB7uonwkhXa
 PiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790965768; x=1791570568;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+rrH8jPIjco9vZfHT3xe2ptHn3BuOpvxKbC3e4I9zuk=;
 b=QW/M0JlCs0xdj993uGABNL48fTjMEpiAsdMtPaUY/faTuLHpDoIPUAfGtPE4UW0T1y
 Yf2CtV96TRGu2TVAQIj51/J2OKvaaJYn/11xyKwM1b95oAgSbGPnVGReaaybFr18vsQd
 2w4NU6MiFeVBsKYvswda3Myuu5cN0o52ExBSXIOZ0/VWUMwLz8uFyGMlrAvnEi4VlHlq
 P8+76Sk0dt+fbyd6rGZnN6MwegD4GpsHg9ctC8arRrKKJBsZjo2dnDXEOd4ORpshm4Mr
 OhuBcbCt0U0Td4VYvN491zAz401t6/7VhZdF6X1KwS/ez1DNmZP+lA3g4xz0RgCKwDbE
 MvKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1vJ5lqD2x2dpkc3egYeu5ibYG5cBBytg7/GhneuhXWXcVJwbq/p8BpnFlHbTdTX4w39yy1Hujqh4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxOu/+FNMeFEfUQQCgvrkPcaBXi2KlBqWQ3g8iNKBtYlt+2w7y
 i/fEFY5kajGqNKAOZ3pD7eN0PdY+f58gM0R6s1LxEhEIqAohK2tUrVmj
X-Gm-Gg: AYBFou2R+P6bAg56cr6erOxsmgU4if5hMP4t321N9MNYkK2xCw+9rmW5BMohvW2weqK
 jeeNmo3OyYJw4zfKwmBd4HD8YkHNRKS1Ew6hepDxJxlu6TjqUZcqUyHQy6PEdQDFEPi7siY3hOw
 6hPjjeO6zGSEmZZsjQaUsUU4UxAbmEd08GPS2IhCVcs0EJ5u3LTxAgKOcaA/Ffo8q5gvHEE0Ck0
 0c9SvYjmZG9jIhjgkwhs/GrsKRV0B6VcV3Fyn9JRNfu7AOt8CA9hLTtUKAdJrev7FmO5Z+H7dDe
 VnaVYDygN6JbvlaVLtO7NV0I6PiCZkgMCziDhaM5e8lINx5ZXDSZbUyOFTzANyAmCeiwhpT2w5J
 awNEc/VBAJR60sNqMl8HWn4llxJ35GGOsZvRJX21o4TfNStqJD4KrnvETe6n7GxEt42ATwmpxOR
 HYgy3WxZHClqRU1Vp085sRwno7webzwH/LY6QQWuMHW4Y2ESb/lGmjPqT1hqR1CmSvS6xrexfgn
 POu7w==
X-Received: by 2002:a5d:64e2:0:b0:48b:508:1cb9 with SMTP id
 ffacd0b85a97d-48b126f1568mr6613899f8f.4.1790965768312; 
 Fri, 02 Oct 2026 11:29:28 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.11])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48b380faaf9sm7429656f8f.22.2026.10.02.11.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 11:29:27 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
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
Date: Fri,  2 Oct 2026 20:29:18 +0200
Message-ID: <179096555582.4050.16689195326008531646@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACSVV00GwWvMFDR5QC7h8gonC-9qYbaG958nZHSxtUdWXGG_sg@mail.gmail.com>
References: <CACSVV00GwWvMFDR5QC7h8gonC-9qYbaG958nZHSxtUdWXGG_sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On Fri, Oct 02, 2026, Rob Clark wrote:
> Can you share `dmesg | grep drm`?  In my case the initrd is missing fw
> so gpu is initialized later, I guess when the compositor starts.

Here it is. The kernel is built without modules and with the firmware
built in, so the GPU is brought up right at boot. The GMU firmware is
gen80100_gmu.bin from linux-firmware (v5.2.38).

[    0.620358] msm_dpu ae01000.display-controller: [drm] Using Transparent Hugepage
[    0.621120] [drm:dpu_kms_hw_init:1168] dpu hardware revision:0xc0020000
[    0.625910] [drm] Initialized msm 1.13.0 for ae01000.display-controller on minor 0
[    0.626015] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/gen80100_sqe.fw from new location
[    0.626115] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/gen80100_gmu.bin from new location
[    0.626994] [drm] Loaded GMU firmware v5.2.38
[    1.632277] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
[    1.642345] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
[    1.642360] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* gpu hw init failed: -110
[    1.652389] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
[    1.652401] platform 3d6c000.gmu: [drm:a6xx_hfi_stop] *ERROR* HFI queue 2 is not empty
[    1.858322] msm_dpu ae01000.display-controller: [drm] fb0: msmdrmfb frame buffer device
[    8.053367] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU firmware initialization timed out
[    8.053584] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* Couldn't power up the GPU: -110
[    8.187443] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU firmware initialization timed out
[    8.187650] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* Couldn't power up the GPU: -110

Oleg
