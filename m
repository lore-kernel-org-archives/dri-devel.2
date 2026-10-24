Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C5606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W2pdx+aj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D3410E561;
	Sat, 24 Oct 2026 22:59:08 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1E810E32F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:02:19 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6dd059478dcso959678eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792810939; x=1793415739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d42c0lsKAH/3dqQCFaUwqRJoKAQ44ktKOlAIQMH1hCY=;
 b=W2pdx+ajVaBaM9ksyW9/EnpltZ/+NvNhLn/6RSeRASCGZP+dzartwlw7PANe/TRUr9
 ertiIAvIykwJjVzsGiVcgSEwYQiunvWrOS4l2w7NN2Qlqyo5a3AIl/0vJph5tfMkJzUV
 4e4T7O+2YgsXlX0B6tEsqu84e5afKzJJeATmGrm1CbYdlVOR/YeeM8/mOPyQMhUaz7MX
 2yeqDjm+ffWzl1gxqnlcb6/Bt/WjB1WjxsePQRGVdCe+u7L62zndoRj7LLllgoJtDDcm
 KGED4spoOwhTwm3JuZiCx0wyp/Gp3YCYjbU57jJq7wqFD6owtzE0UWSBUUTewNdJwz8j
 SE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792810939; x=1793415739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d42c0lsKAH/3dqQCFaUwqRJoKAQ44ktKOlAIQMH1hCY=;
 b=fCRyAZIsRIKUad1DOQl5EaDXzjFiNdk4PvMkZPSWj+Po2a/WNliArJvOYLLOw3ckeW
 03kL4QE4ygHVU8mazGkk6mRVmmmVXb6CJDVQP6hd1TzHWq2pC39perMgfmO50IzZTFdP
 l69D3FPpsxPQVK1H/n733y/DPcK42IfRJ9pOc7T0LlTcyjfeUiudT9tnqcjE62izPIO5
 2ke/iPXKRr7QBwiIWwgM+d4vL8UOu4pLd3iyVzskLMq/KhJLhod7rpFO6IEldotjLLxl
 RDPnYqYarBuN/dfu4HaEgdqiKDDgZz1f16moosWfqpM9LxYGN75ofwsSR1s/st87ZfV+
 yFwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzVsYF5PfMKApM+asxJ/RIafI0MLx8VBP/3w+HHugF65DyfMW+4Y29bLqojAAYQUX+Q5zBCBKlcO8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJUIXYtds8SidXmXxHCPucsD0kNawPl8YIbzisuSgLpVxcPCBNn
 WUFhVihIDBJ7hZtBN/XitlVTnmVTSsAgDLlVC7VH9AoAUzc/c75+qbN1
X-Gm-Gg: AYBFou3DBYuLxI6KGT3WsOaEuExVi58d6gRAVDqGPShkrFci9FwhSuxELlqZ6PfQvbP
 glDktI6CZdti9sqvxiGhBb2PwyUPhaizJfXf5k1TqYK00WNjTM2GI6mlDd4yikWdHLYfWA8wzCk
 xmL5loeoYIjQzgMQJ/D7Db8W8sX5yQwQMGXk6pQ8XHOlsucvnhS+CM9mbJyeRZRiEMc0kJ7wbJy
 l5aEnUXznAurUPsPVL1h+uCSpahERzXBV7OjzVAmh99UUKwq4p6iQuBSRyCr7WBEA15YsiNvjiv
 ETYm7NssGftuv05PxZCB2SvFs5giOs5GyWerGfWq+zx/8/AaWIE1cfVRCv8VD2UToEI0U4sbpIJ
 /cgJBOXn8sl3gxznmb6SvjXiwEFiQupDffV/jrudfwr74EFmIH/jvjW8h8JBOwrO1Qrxm3spItf
 o1KykHWGeowhRmpYIkf4CFT55hi5MiqXmn3e3jGTBpT1zOAFnAqnnnFqaOLECQmbAISNmoGZLLs
 2CQwJMK2O88ASgy4kSzxqP0fBYuIxppESsDpIBh9NIYkvlCYEfQJZXTZqwn39mbG8KPxPCaCUKJ
 ftNf
X-Received: by 2002:a05:6820:a514:10b0:708:c97f:5542 with SMTP id
 006d021491bc7-70ba0f72e95mr238732eaf.76.1792810938704; 
 Fri, 23 Oct 2026 20:02:18 -0700 (PDT)
Received: from jeffmr (63-152-17-145.cdrr.qwest.net. [63.152.17.145])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e1fa334sm824552eaf.9.2026.10.23.20.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 20:02:18 -0700 (PDT)
From: Jeff Roach <jeff.roach0@gmail.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 3/5] drm/msm/a8xx: Add Mahua GPU support
Date: Fri, 23 Oct 2026 22:01:24 -0500
Message-ID: <20261024030142.13643-1-jeff.roach0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:00 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 25 Sep 2026 02:44:34 +0530, Akhil P Oommen wrote:
> Add support for Adreno X2-85 GPU present in Mahua SoC. This GPU is a
> smaller version of Glymur GPU with fewer slices and smaller internal
> memories, but shares the same register layout. Also, the GMU chipid is
> different when compared to Glymur's GPU. Add a new catalog entry to
> support this GPU.
> [...]

This fixes the rendering corruption on the HP OmniBook X 16 (X2 Elite,
Mahua): GMEM is now reported as 15.75 MiB, and GL, Vulkan and WebKit
render cleanly without the sysmem workaround.

Tested-by: Jeff Roach <jeff.roach0@gmail.com> # HP OmniBook X 16 (Mahua)
