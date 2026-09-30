Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394ABCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF86E10E309;
	Thu,  1 Oct 2026 06:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWGrg5cm";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA8310F2A8
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:39:32 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso2948433a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790793572; x=1791398372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XsKp8bokv5KQkAjgiygtz+XbYJSoI6gq4xMZGzbAlEU=;
 b=gWGrg5cmZ3gN8+71EzLDyMB4wWUV9hBOkkod3+HvYTWARu4EFlL3uNNyEBpR6wXcm+
 BHAgxwdmbFCQ7zEEMX6jc0YLde1rp7+usF8aEjqRIaiKTrc/tbEHyPg80Th/HBLAtNOz
 qoNL5aAdMd2a9ryGFh6iag1LQGUkdCURsICDgS8HVfb+LqcdHgScQvus0C5+nfeEsn0k
 GIzR7JyUpiUWCsc7UXEzxZUaKXZuGZovqDuK13Wy4a8ydMfiyAr+UvaxrEMHM510f6bN
 fpgNhyY+UqmHcId/NMS3XMGAMaPESSwTMQxeybP34E/MA5nbozFnAglAYBOOwu2iRTty
 Sfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793572; x=1791398372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XsKp8bokv5KQkAjgiygtz+XbYJSoI6gq4xMZGzbAlEU=;
 b=orPAKasoHroG5DJKV3WosvOAi3baxaBi7YCdCUurWhzirNDqM2BLtBjkuo4rETi/ne
 NMo0JymjB+ujS3DZmfFZ+QufUiWATMJ0TCIGJQzhh6estB/V/h0PqbAcRAmnxt0553sz
 GrAKAfqwImRpywqn2t7A0t/89h0kV3vANwpnlsuhkkEVqI3vccKzAI8/vcQn6N2YSrB3
 px6I+lvDLtFkIHbV7A35pFVrVx4hEjPnl/HslN6Za3x7ECJzo7dsxyCYP20RDgGBIElC
 U8xo+rXqZe5mG/vi6CeiMpUgNN9mVHms3kTf/9LDEPKhLnZpgyLEdvwyHi6Rb/p2EdFw
 z7ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjvnKnio2dlkE1KGjpnYb7eDgUWriPshvDER0wjaiyjjX11fV7lhDvs0MnSV3DwydlaU2EXFTphGg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLbCdA3R1Gx9mp8oazVS2ryJVlyPB0GAzH4tcLrme+25M9lK6CD
 OtU5Gy9zWlTWLjssZFxtoIxUZ0kPDZZMMocRN0jpJZkArHiXwymJQ6qm
X-Gm-Gg: AYBFou03HNquP7bKN20qbviuGT7BpY78ijwQFGdVY9+YKPDaHL4kxGxB6VUbGsuD1YX
 LQWG05/kjVoFcpsYqkRTi7NKUTvoL3f3f9iTCKLQAWhzm4THB3ecVSRoIy2gwx9um5dmpz5TXDm
 ENyKWjS5SbbmAXOlbbAn+lD/rzjeMlnRAbGiBGK1ytZFSq7f19p9OUiZZoyA1VUvcIXLM7Wd1Rm
 QYfL8dK/phl/AzeCvj6YKYKihALR3/Ckfy4zHZhaVmGaVXbAn6RF7gzEJac7lBcJaADjnyn6M/Y
 Gt7QwMWjef3lzDZn1FYFgW9z2ztH0LnxqvMnUY2AxWG0XcSj2TUnlfCJw7l2P1lofCjSabJNZeU
 wcaJr8eqOnEf7ADOwnsGDy5fnc8B4zwN72ewVvcfuMeLwQByDlRcqk/KEsdqxg4XNZG4KDgGk89
 lsKGzPcVlFuf7puxwtPliBwyEcFcpWzp9nTmv6C9SWVqhNIpNjQWsQ2WpnDXajlxzC9TrTBWrXD
 gP0x2rgja4GNXQEge6rfZAkzQV8c6swbFz9WURXGLYP472SBNvQARN5+eNg93RfEm7jbBWHBSQ1
 fzBs8ptIeoOcagZ6OKcONpZIvHZ9/aEJU0ktSQ==
X-Received: by 2002:a17:90b:48c7:b0:39e:6a7e:ee18 with SMTP id
 98e67ed59e1d1-3a4f71d6442mr81998a91.36.1790793572062; 
 Wed, 30 Sep 2026 11:39:32 -0700 (PDT)
Received: from rahuls-x2elite ([157.51.37.69])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f75019b6sm49026a91.3.2026.09.30.11.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:39:31 -0700 (PDT)
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
Subject: Re: [PATCH 5/5] arm64: dts: qcom: mahua: Support GPU and GMU
Date: Thu,  1 Oct 2026 00:09:16 +0530
Message-ID: <20260930183916.1197-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
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
> Mahua SoC has a new GPU called Adreno X2-85, a slightly smaller variant
> of the Adreno X2-90 found on glymur. Override the compatible strings to
> correctly support it's GPU and GMU.

Tested with patch 3 on an HP OmniBook 5 16 (Snapdragon X2 Elite
X2E-84-100): the GPU and GMU bind with these compatibles, the GPU comes
up as chip ID 0x44060030, and GNOME Shell renders on it with Mesa main.

Tested-by: Rahul Pon <theflyingrahul@gmail.com> # HP OmniBook 5 16 (X2E-84-100)

Thanks,
Rahul
