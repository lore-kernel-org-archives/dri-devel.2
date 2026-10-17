Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B6BCCF2CF
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B952F10E69C;
	Sun, 18 Oct 2026 14:54:01 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EF410E3E1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 10:03:56 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49e73611928so10553005e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792231434; x=1792836234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fVgSD0Xq5YBvEBtVW7e3rRpcg9mWVhgCoVE9HSYJhNk=;
 b=DSdMmM1B1LGU0GvwVDjj+4hbgOo8HhCU2qHt8rlY1y2ImDey6jaL9E2hihUfPbXTsL
 NV0gVNaP7ea+ydbku7Jw38BT3SCqzRfl1AGzNaroz6la8AYDNChiKpkNk/HAjMbB7QEN
 vjO3PCt68v5TjrMhaKyF6EROF/VKDoTg11Bcr4B+7aCabs/b5GFrYjqBqBBKno6p9r7N
 1PZDMRazGKSsWy6OEHcHiPyiBP/ifOq0GKEj71kjN31gLepZFnOP9qkTSscGLMrYN8TE
 ka/DtvsS5bHFBKfuibqEvR5hBPtwzuAqlh1cz6u1mI/uWl7zgdFhdnNS3qAaHFYR48eD
 cUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792231434; x=1792836234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fVgSD0Xq5YBvEBtVW7e3rRpcg9mWVhgCoVE9HSYJhNk=;
 b=zp/d3Md8u+PoVg4yqPtp62/lUY7vgp37YfgWnau9kpGpS4ZenGvAb7+ZkvfpOtIfef
 ibIgq6fGWVLQoEIg7eiXcJXWZMGO/AB+qM008wqKrQbtGoLV3/2feXPVXMY4JhNObbus
 OggTOPqY75lI7OaUm7l2bja5vZ3YgOS/o9Mzo9fF0W81Z0WR1+hj8nGGqUY8Q5NRT+OS
 Rjg2aaLbHxSmCzx9SuEC1McE/6CYUycdovsjlU67nLPrmwOAXx+qH/cylja5CshH4ZYz
 aXWHRWR/Lqnr4PXe/Ruqrb8gymQ2DyATT4EJ0xpCE0YU8w+rl9cWftmlSh2VFocOdXVl
 sCjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9L/Fbf0IXkFRyUgXeTR+O9PpnL+uZxJ2BeSzwoZLKTbRyzqT/QFPnb7Yladj3vpWhJK7R45jzbOo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK8v+QPTOqyQoDPYuSCgXAr8bzw8XPcQkxmA3lTnMC0ST93vQmp
 xSmpUrMKbov0StTPIRezY/PFw4MfpESoTAPtbIPuqVjcL4KdHRalC9H8
X-Gm-Gg: AYBFou35/pMlPffH98ttDQ6Jw7IMhtfmcIVkgTnvnv6J04OJOEkPO+WfKuvg9IhSVGf
 ImlcQiVSGWzghNMwUGL/I/EpDO/Ruga1QWiXAAL7+d/6M4hmL8lHVLlImv0c6qPQK8XUOux0eGY
 Cjv/iXXXybkc7CRR6N+U+JQeSghbzTB2pzFa2S0Eds11ddLaICvW7FPCyMXz+tXNh/7ZIxYnHWE
 wJK/xCiZutxQ70oPnaOLLe9nswj6FEjtBpB05svewujJS9p1yO3WzPbUfwY4CnujxtwPXqAJhNd
 Q0pGajfaUj944H3wXXAHp/Od20zA0onXCS7GfMEwo007ANbmLMP1USO6dOy7kVMTYungnTDXlI4
 dJz9VDD/OGwbBiFs1PrMxfH5CLl0XOKrn//6SgVrKigKU0/1ALNiIaEORy8MWowmCtLbD3jSkUJ
 XuwM1F2ISbmSCtR6idmXpNGVdwkTtW7txYn+De7AaOyhuuUrD7mfGBE53nP5t8t5XYM8O+BzQWW
 SZhjTuR6vuO4A/mGmY20rZ9TA==
X-Received: by 2002:a05:600c:1910:b0:4a1:7a1e:6910 with SMTP id
 5b1f17b1804b1-4a1d75f2afbmr50724785e9.4.1792231434278; 
 Sat, 17 Oct 2026 03:03:54 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dc952d63sm36984135e9.2.2026.10.17.03.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 03:03:53 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>, Val Packett <val@packett.cool>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 0/5] drm/msm: Attach a driver to GMU
Date: Sat, 17 Oct 2026 13:03:24 +0300
Message-ID: <20261017100324.1104-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <bc2ed82d-0d91-4683-b9ae-cb4299636c2e@oss.qualcomm.com>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <1118d9c2-4efd-48fc-8a3e-c2cc3eddc940@packett.cool>
 <bc2ed82d-0d91-4683-b9ae-cb4299636c2e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

Hi Akhil,

On Sun, 26 Jul 2026 21:35:35 +0530, Akhil P Oommen wrote:
> I didn't get a chance to revisit this series after my vacation. I am too
> not aware of any impact outside of those dmesg warnings. Any chance this
> recent rpmh related fix is helping with the deep sleep instead of this
> series:
>
> https://lore.kernel.org/lkml/20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com/

A data point from SM8750 (OnePlus Pad 3; the board DT is still local).
My tree is v7.3-rc5 plus board patches, so that fix is already in it
as d9108bfdb746 ("drm/msm/a6xx: Fix stale rpmh votes after suspend").
Without this series the clock controllers still wait for the GMU:

  gxclkctl-kaanapali 3d64000.clock-controller: sync_state() pending due to 3d6c000.gmu
  gcc-sm8750 100000.clock-controller: sync_state() pending due to 3d6c000.gmu
  sm8750-gpucc 3d90000.clock-controller: sync_state() pending due to 3d6c000.gmu

With the series applied these lines are gone, adreno_gmu binds
3d6c000.gmu, the GMU firmware loads, and KWin runs with OpenGL
compositing. I saw no new adreno or GMU errors, including across two
s2idle cycles.

I can't say what the series alone does for suspend on this board: the
interconnect providers here are also held by 1dfa000.crypto (QCE is
BROKEN, the issue Konrad raised in the "crypto: qce - Remove driver"
thread), and I only measured with both resolved.

One note for v2: 5/5 did not apply to a6xx_gpu.c on v7.3-rc5, because
a6xx_gpu_init() there already holds the GMU node with
__free(device_node). I ported that hunk by hand and dropped the
of_node_put().

For the series:

Tested-by: Vladyslav Tymoshchuk <tvlad744@gmail.com> # sm8750-oneplus-erhai

Thanks,
Vladyslav

(I used an AI assistant, Claude, for the analysis and to draft this
mail; the tests ran on my device.)
