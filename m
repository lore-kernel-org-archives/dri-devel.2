Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3769ECA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A3510F578;
	Thu,  1 Oct 2026 06:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUTtK8xp";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E40010F2E1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:39:12 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e5eso2837051a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790793552; x=1791398352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFAHzsauXPIyCr3E+dyQQ6Cgg9yLC/fJTOD1fB8VlVE=;
 b=bUTtK8xpaK3W8ZYS2htxPxDN+oi0hotWeX3WjAJpfhrCRtij5A+849fpFfG0KDNncy
 em8p/iY/YU/ya4q0g4gZMpxe9hftVtcfAtyyFwi+ujuCKKHU8c35UM1KFtMWoVHf+IS0
 F3SqqwKhCBirKU3flMi+GYeYkOQ2gNyCNnO6n6juX6t1uMBTM+hVlsbpwFNAO3PaW9Cz
 HZNkIySmHaIiWbrCEdtvPGFLmi24P45o5CCvLAyk+F3D6TVIPmF7dBqraMKjfC69PErn
 OAMChhXd91Qg6Mpo8sUh2pLBnOJJ4CrQg2EAFUrFJ2kyJ1lunjnoz80nFYpuikalxHbC
 59Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793552; x=1791398352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFAHzsauXPIyCr3E+dyQQ6Cgg9yLC/fJTOD1fB8VlVE=;
 b=0K3AC+ZNK9Ni+LOEgl9kzWXiF2/VcFXlOBt05cR6s/evf22KoyTI/iDp8L9vboID7R
 ltXUSv6Yna7ytq/fQY0fHkyWF4kYWVmAyjzEMvtv8iENORYnyQzLXzLx2hbWU5g+32q1
 l/j5YJi15dtLjajDLhU2dcM5ZthcHrzF24Ma25Edf1Hcma17kC2CZtKOmEwK+XXsXPtH
 Fkry7F6OnumjNjD3O0O8gjXdvo0aH2GpFifeXeZQtw9SzagtSBer+TbceTyfRdm/Wxdd
 f9OXenEY77ESQAiNwbMERujtqjDwZDI4fWEmLWY+iyeI8xraZgAE/358dWqW5JbM9MoP
 B7Rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5/UPFoXyDwLtBUWRYgu5DLZ0O5Mio3WsbIx73sYL0b3V5MhEwd1RKMcAPtb6ZMAlnxOO4uH1k51E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLEtM4nChaBm1Hc4iKyEhltYmaCg8weM9oCVyys7ujg9heC5RQB
 JfDB8iFEx3Qu32qeJ77bxDpAaWMlE70v1HcTH6PJ6G5uMuaiSDItVUN2
X-Gm-Gg: AYBFou3y/BiBbrh4pajsu1aw1Bz5+UVSKne+YXddzDu11G0CT8+glsNpTF64MXgozFk
 vfbZfYZpy9mr0CE8yMU6rZry8vrauFdhV2m2jaCRCWcIW6/ftoFqOPXVoUyjyd4TMSiI7RzJSDC
 6JiXmVaQu47+JOptwuYeLiIMjp9ioEG5/h5bKu43JsWrN0texCSeZiTxoDEnaqKfOptWodZLfWe
 NLG/oysH1HBjDkRYfdQtfzaiNt166+lXlx0C6GwMCsXZtZWrlF+SIjBjjk0l8w6lsb+I22VhsKU
 81N1kW/vgDdaa8dMPUclv60s/rcGLT/TZS7KwUadEB2iOEftvFV2tnbEZ0HZ7KHA7g5TXLy3v54
 mbp17F6a7hsWRbCaWZImmRi1hm6wASxaX/NfX0WomECFgY9Knl1IFxVyCdeIAofKo3hEgDRWNPr
 ls+581+Iu7qjSn6dqCC716tfqA52kL4RYXLQnKsFy712lbOyZKzA2nTzVrmSU34nzlKBh4qBqoG
 JubB0/R37wkM3pYXBrIZMDdKOBCQ35z6eUo4W/7MOWGcxYGDj4hwGU0932lD/g2N8m6T1vZuEkQ
 TtrJ1vV2RW4HOmK/EawnrS3c2HBegZpHIrsv
X-Received: by 2002:a17:90b:48cc:b0:3a4:c18c:b894 with SMTP id
 98e67ed59e1d1-3a4d18f52d7mr1859734a91.52.1790793551779; 
 Wed, 30 Sep 2026 11:39:11 -0700 (PDT)
Received: from rahuls-x2elite ([157.51.37.69])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4419ff9sm532916a91.9.2026.09.30.11.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:39:11 -0700 (PDT)
From: Rahul Pon <theflyingrahul@gmail.com>
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
Date: Thu,  1 Oct 2026 00:08:54 +0530
Message-ID: <20260930183855.1184-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:52:04 +0000
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

On 9/25/2026 2:44 AM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
>
> Add support for Adreno X2-85 GPU present in Mahua SoC. This GPU is a
> smaller version of Glymur GPU with fewer slices and smaller internal
> memories, but shares the same register layout.

Tested with this patch and patch 5 on an HP OmniBook 5 16 (Snapdragon
X2 Elite X2E-84-100): the GPU comes up as chip ID 0x44060030 with
15.75 MB of GMEM and the GMU firmware loaded, and with Mesa main GNOME
Shell and glmark2 render on the GPU without corruption.

On qcom-next the a8xx_gpu.c hunk needs a one-line rebase:
a8xx_set_hwcg() there also checks adreno_is_a830().

Tested-by: Rahul Pon <theflyingrahul@gmail.com> # HP OmniBook 5 16 (X2E-84-100)

Thanks,
Rahul
