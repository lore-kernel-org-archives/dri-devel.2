Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79754C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8BE10E39F;
	Mon, 21 Sep 2026 07:01:19 +0000 (UTC)
Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A4F10E22A
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 04:13:46 +0000 (UTC)
Received: by mail-yx2-f5.google.com with SMTP id
 956f58d0204a3-66f2399323dso566111d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 21:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789877625; x=1790482425;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0OVzIh+vsvtVC8UGyCseiAR3iEUCTny2s5Sp70SRs7E=;
 b=KSydcv/wc63HIE67B2gTaAwIXH5kYHDG2t6FNrPRrZ80g/3JfEKzzw4szhfdJHscYO
 zDm6QL4r6dJu03fDwVBSP6DdnARa86MZUpTqUMHEZreIaN6SajGh09HhSo8982xI4PdC
 EV0hog+9DhGH9lsBsdj8m6ucaJptqmCf/6lAz8Mhn7YtHl89pNb+0zO8w9DaHmTUmGlC
 uGmbiEjRAq554bF7u5dGUnAZ0vO4TanEhdzF9vHu7ccq96nBexaV78XpsVIrRHoNbfPM
 wSBN0eCzlutXI8JR2y96hIvJqPMsXIcO+Jny2/L08XNjSKtvYI26hGEFmDXKBv+U1W4X
 bszQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByz5qyuTCW0V9wmTzqnqLbFFZLVkFB7IGiucwtdpvMDVQDmm/sQY4/SWeNRw82ZZYeJJrb6lT3AOA0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIJPN7lrAvhVy/PuTXOhpGV8fjOLFh7izDTg5gd7G43UsEJsln
 4nLGt8SV0SAVHKUmV9xGKhW45eBdSX9BvuEJ5Aye/RLbU0t5loY1gXiK5Nf2W8ChZMFBCw==
X-Gm-Gg: AYBFou2k1Y6iFBerKazpVECFgK1VH/vy5boX4wrbBLo2CG6RC+da+iM9HW6iktoOYxB
 MAKTSCq7//1cmL55jYCcviuGAY8x6vaGxvbpGYAf/ehBYyVc1NQTHizWEpRy66QeaBYq6T3ELGI
 AxXOmoKapoZWFmNSO88iNniZX/m+Tdrb5HPnikta5nzCPnVfAICVcQhM6DdRYjsjviR+UJe96iL
 5oH/Tjx1Nb4l9y2j7RCl2oArJE58LPGtCclH3+IGxTFKj0rd2OiHwDwLzdgrbPiQWqRLm8rvf50
 tyi56u/rioJjFdgJzcRWXhUMGROHdB8N+48vR5IPbFnSCAXzi+bEKew9U2ooSblbJs1zLsT208y
 p0Z4cATRzCLVyyAhmCARFDKSRYa2nAmt5F326XAERwksvlf4bYcLmuQHQ/yuEQd3hp6I5W0tm8n
 kP3VGzOqRHjl4FNOtcp7V7lDB5olyBjuWAbt9iIt4ouz2K58uFJpo+RCqMQzA/0ItIqmFW8RXeY
 mn5bfpDNOiw5kPgeyALFyL/kw==
X-Received: by 2002:a05:690e:4504:10b0:672:99e1:11e9 with SMTP id
 956f58d0204a3-67299e11839mr639517d50.134.1789877624796; 
 Sat, 19 Sep 2026 21:13:44 -0700 (PDT)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com.
 [74.125.224.141]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-89a48d9fa98sm13650497b3.49.2026.09.19.21.13.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 21:13:44 -0700 (PDT)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4ab2029eso1780511d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 21:13:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBy29uS+lqacJsCOorvKWHCddaydvrnqNxhpFXbRmUDjy7DV04v/jIVsdr7UvHpMpMN2FRgcOH3b81Q=@lists.freedesktop.org
X-Received: by 2002:a05:690e:4881:20b0:66f:c1bc:87f5 with SMTP id
 956f58d0204a3-6717fdf309emr1366552d50.78.1789877624271; Sat, 19 Sep 2026
 21:13:44 -0700 (PDT)
MIME-Version: 1.0
From: Hsing-hao Li <me@lizi.moe>
Date: Sun, 20 Sep 2026 12:13:33 +0800
X-Gmail-Original-Message-ID: <CAGFxjKKqxxmtkqEhPzQJg=XWTpom1RuwLQ7-OBCbuX7BynxVkA@mail.gmail.com>
X-Gm-Features: AcwNN1WdMdMhoKnEx_xLS2HGH0J4NT-96FKmTioQVZ9YXcH-svEmLRcrvRu3R5A
Message-ID: <CAGFxjKKqxxmtkqEhPzQJg=XWTpom1RuwLQ7-OBCbuX7BynxVkA@mail.gmail.com>
Subject: drm/msm/dp: d858770e86e7 backport to 6.12 on SC7180
To: kumar.singh@oss.qualcomm.com, lumag@kernel.org, srini@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Hi,

I am investigating whether d858770e86e75bf78429b9f5210b7556ef431033
("drm/msm/dp: return 0 from audio_prepare when cable is disconnected")
should be backported to 6.12, and which adaptation is appropriate for
the older hw_params callback.

On my Lenovo Chromebook Duet 5 (Homestar, SC7180), running Debian
kernel 6.12.107+deb13-arm64 (Debian package 6.12.107-1), with
PipeWire 1.4.2 and WirePlumber 0.5.8, restarting
WirePlumber with DP disconnected reproducibly produces 20 failures
per restart. Four restarts were tested. Kprobes identify
the caller as WirePlumber and show -EINVAL returned by
dp_audio_hw_params and propagated through hdmi_codec_hw_params.
An instruction-offset probe, checked against the loaded module
build ID, confirms the !power_on branch in all 20 calls during
the final restart.

The observed impact here is failed disconnected-DP parameter probing
and repeated ASoC error messages. Internal speakers remain usable;
I have not reproduced the dummy-sink symptom described upstream.

In 6.12 the callback is hdmi_codec_ops.hw_params, before the LPASS CPU
DAI and component hw_params callbacks. Returning success therefore
allows those subsequent callbacks to run. In current upstream the
check is in the DRM bridge audio prepare path, following the generic
HDMI codec conversion in 98a8920e7b07.

Would an adaptation retaining the power_on early exit but
removing the EINVAL assignment be appropriate for the old callback,
or is any additional change needed for SC7180 LPASS?

I haven't yet built or booted a candidate backport. DP audio
playback and hotplug testing are also outstanding. The results above
describe reproduction on the unmodified kernel, not validation
of a fix.

AI assistance is involved in the source review, analysis and
polishing the message.
