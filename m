Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49E9ED7B9A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 10:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A62210E2E9;
	Tue, 14 Apr 2026 10:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="eOW/ObIH";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707F510E2E9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:18:39 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b9c1da7ac63so823136366b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1776161918; x=1776766718; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKsGUuq/AWrW0/a76gvihKykHQHBCYzLpfiJNxSSm1Y=;
 b=eOW/ObIHP+iim1/+1BlMDrw/PcNFUz6JKJKRwXRStRPfGcf6wOoeLYd2RqF4ff71oH
 qtjxL3MKFCnZPdId1wB82GourcQmxky5F2pmV6Vw92qwiEbU3ZhZR+yHC4v220clBm41
 57I4bit9oVaiiqCPpGFf4+H0iEGNXivOl27Xcs8oTDoO0Z6leQY9LoweSy7Rk5a2G5H+
 N7pXvWO3HNhkC4fKwfWjQHi7zh6yDsP4TVCNUKgAFQssQd/wSBcz+xMmKt7PyfekHy+j
 q06tO3CxI94VYbA6sx/Cf6/8V/EdAJdOZQEgh0SWWZb9JT2n8goEw5z78HVCFfmP+WNf
 ixWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776161918; x=1776766718;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YKsGUuq/AWrW0/a76gvihKykHQHBCYzLpfiJNxSSm1Y=;
 b=MeNWR4kGXOPUyM9w5ULGAXvreJ9umWT+X8BKhn0w8bWvjOEtQO3vrEtob37KVLGFLO
 4peY4Mqx12VKXoWc4BWJluEyHIPOA7/xnNkNfqGl+3VJvCzDZBgdA22zlLiyb1EF3kpq
 aKIyxDN20Xqe3o/m3KUu8nQDZaY/Lm4NzNW07OW5HBa6QzOgkMfEvU+7iMBVDmlm42fr
 yYAtSSx3m2UMrOtiUjlhKUxhVUlHtq328y68ecLRYQGzKOouc9dw+iCISAVPfOrX/I7y
 54o/G3B9eTehL8lVeHr+cW1R0jwKKz1kPPJ8tvAa4ZkMQokQ+gF0d/p4RDyAdYAfm6iB
 WZ9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d0+G4S5OY/d460ejM0tm4pjPr73c2Bm9NBVgICVrZVdXKiNX5VDotpSZhHGVXATRUg/U3PM47bPE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKcw+OaxfjB4aLPOnqZDu+q8Fh2VUxibaDcZXPzj9F9LD8wbE0
 c74lLYO54KbdtFqSxkRujHXvZlFiWwkg4GnAGUpiH6cBhQzgs/F5wyJiO4w+cT4gQ+w=
X-Gm-Gg: AeBDiet2gs4c3cxwfR6OsEmpsZ8ZHiOZJZtX9USwGBdHin0dbJrCnliZq1dBsjBvtqH
 Fd0jy+vHWCfm2xKYPsbKMF7K5oJ53/UCSXHCAZaJvrxrp+TzTbED31NUgQ8zrRcBk94CMjWlwoe
 0mU6oqYjZdAe5hvE4N6MNnh29ywSpW28lNUGqJrL0XwA2qRg9ZADwgX/beH0pJxxw//UyzhMxDF
 7osPzEQYW7egW7R3aVQsgSoHUPn8KUNnoo+gYIF3s5gNuzJGJ5lWF5dnIR1zyqCyjas+YGSMRJJ
 0oULjBNKARBG4oOj1NKfdIp53Y+L78G79oGgx+gBw+fS09lfwbsLXBXIRgzWecuh65mLdFtAYFl
 HjYd65b8hYE3Km5QdFCI5i0pABMJFZOkVLqIe5ISpmsjI4iI1RUZFgOa5gITbpQDqlHSp2BBZlw
 +HFOyVnKHoFbW3zl/4yVyY6nrEOqtnrbZGM/a0ci2VDv6qhUoeNMW3ZUKjsMuHqxstErto
X-Received: by 2002:a17:907:981:b0:b9c:9dcb:36e8 with SMTP id
 a640c23a62f3a-b9d7294f263mr933612066b.53.1776161917740; 
 Tue, 14 Apr 2026 03:18:37 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d6dfd77dfsm387242166b.18.2026.04.14.03.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 03:18:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 12:18:36 +0200
Message-Id: <DHSSUO5USR6B.1767MF8GNTUEL@fairphone.com>
Cc: "Xilin Wu" <sophon@radxa.com>, "Abhinav Kumar"
 <quic_abhinavk@quicinc.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Mark Brown" <broonie@kernel.org>,
 "Maxime Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Jianfeng Liu"
 <liujianfeng1994@gmail.com>, <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <DD8RLVPWQQ7O.1B3E1P6VNMWV1@fairphone.com>
In-Reply-To: <DD8RLVPWQQ7O.1B3E1P6VNMWV1@fairphone.com>
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

Hi all,

On Fri Oct 3, 2025 at 4:42 PM CEST, Luca Weiss wrote:
> Hi Jianfeng Liu,
>
> On Thu Sep 25, 2025 at 6:05 AM CEST, Jianfeng Liu wrote:
>> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
>> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
>> use msm_dp_audio_prepare instead. While userspace is still calling
>> hw_params to do audio initialization, and we get the following errors:
>>
>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6a=
pm_lpass_dai_prepare() started
>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6a=
pm_lpass_dai_prepare() started
>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6a=
pm_lpass_dai_prepare() started
>> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6a=
pm_lpass_dai_prepare() started
>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
>> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Fai=
led to start APM port 104
>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASo=
C error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
>> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on =
MultiMedia2 Playback
>>
>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
>> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
>> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
>> hdmi-codec driver can work with userspace alsa.
>
> This also fixes DP audio regression on qcm6490-fairphone-fp5 (using
> Elite audio architecture)
>
> [  133.986865] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x6020 =
failed -110
> [  133.986878] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais=
: fail to start AFE port 68
> [  133.986881] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais=
: ASoC error (-110): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> [  134.045112] qcom-q6afe aprsvc:service:4:4: cmd =3D 0x100e5 returned er=
ror =3D 0x9
> [  134.045192] qcom-q6afe aprsvc:service:4:4: DSP returned error[9]
> [  134.045214] qcom-q6afe aprsvc:service:4:4: AFE enable for port 0x6020 =
failed -22
> [  134.045231] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais=
: fail to start AFE port 68
> [  134.045243] q6afe-dai 3700000.remoteproc:glink-edge:apr:service@4:dais=
: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5
>
> And I guess, even though I reported it after this patch was sent:
>
> Closes: https://lore.kernel.org/linux-arm-msm/DD8PK8AI24P7.YK0OGVYC0QFM@f=
airphone.com/

Is there any progress on resolving this issue? I'm still carrying this
patch in my tree.

Shall I send a revert of "drm/msm/dp: reuse generic HDMI codec
implementation" to at least temporarily get this working again until a
more proper fix can be made?

Regards
Luca
