Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CA108E1DC
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6741E10E925;
	Thu, 19 Mar 2026 10:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VpJEgsM0";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292AB10E952
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:26:50 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so102027066b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773916009; x=1774520809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/RHux1c5L1Wyqd7M+sBZICQ1QO1m5oMRORUdGOoQ7BM=;
 b=VpJEgsM01FSGF9y2zBG+kUXwbEzE+N+nJcojqxnhPNTTbu1jAVn1yOpaSl+pert5r1
 C8E17+x3uHVGNtptpxW3KRQz7MsMhb0aTVQ7lCvACJiv/EFwTU3IidJE0pptKNBb66tL
 xRYYHofKnnMhPgHjL2o7jl9zz2fBLq+gqFc7eTMuT5WwWUrZVLzGJGRp89FhkAdi4UNT
 ZVDmA9jLEopoyt9Ulmfl4R3d68uim8HwfNtXAGd9OU7yRy6PwsvgvbPgrDDuJq4yapr0
 ubTBTojQefmXO5r456TNjCI58Jled4gtsL9TLGtv5hVGCal1k7v7cvLXnST7/Qtfpwcy
 xG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773916009; x=1774520809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RHux1c5L1Wyqd7M+sBZICQ1QO1m5oMRORUdGOoQ7BM=;
 b=o8L6CcgNlzQHNuqM8ZNpkdAoShpX1XrSBew/VnOOoQiP/NY4pc7AqemODzTXh71Nnb
 WFZg2TTJQoNpAk5M7ki84FeX8sl4KVNl87WKZ7qcLCYSTSDz8QdbyXDlHLu5qcbotEAI
 i4KBupKe09MeEoGTbwBy6RvHnnotcZdijMHyE3JejvMuUHrF/zwfgigG5HMEcsnENKwb
 yxw9TCEviKcGdws+2tulJi2wL2KcQCneXC9wHpZAvSXmKQil1mZFUAQjuGutp++KFrZc
 8JOMpHnWoAq0bXnlnsgG1AUJKnBGd3t4MBqJWZ2d08rz5HIu8f9Axz/t/0wbAaFnZtj2
 oT/Q==
X-Gm-Message-State: AOJu0Yxc78RgRkZyz0ChV03LfPfePoAdXqtLWt4tFDRcXgj2uHjAYngG
 WNBrPnq3c57Fy4rA4EYFJHP+A0wtCY8cuWJo2VK8QqXQeYUCz6ndpSyP
X-Gm-Gg: ATEYQzyrP4b7Z0E7IsTS+PVqKpaR8XgvrAL/Q1GrTp4MnIO0bUHg50tiD14hd3Sqyou
 VMomj/wLkcqhW/mFk4VWVeeGMSkJGGazdhP9lNlUor+c5oM8ssUosOw4+ekbJ30BhTUE4P16MHc
 Z2PIruoP1+G6/rkxvv8q1W9gjQhxmnp+2NeUEy8E2Fya/ajrYmFoIlB7STT5X++ImppD6o5qgfp
 keLYWYr0cBosD5B0oW6IWi3UUuRTrVSrNL1qifKkQYAYf/IBvSxu3oeeqp1sZh5NiorXEYvgVHX
 W3vn1zoWhRr2BoU3056Pgk7Np8EfU9qM2WoWHPJ8lzcVofNy7LAr2u9OceubIdU2SlF/s2PKuQo
 A723jLe4yMR4+VOpqdEQ4IlAn2niQMcEzePb6Mh2nLXNOEmHbNNRN7u+Mgl7Kxyt8nQ2kmK4t1A
 coMjpHJK3NAY9I9Ifv6hNCUSSTZGsTFCllu1jOQ2XShGmeqcF/UDdgGqn7Sq+bBjub9H/3
X-Received: by 2002:a17:907:6eac:b0:b98:cb6:e896 with SMTP id
 a640c23a62f3a-b980cb6e921mr228034066b.38.1773916008159; 
 Thu, 19 Mar 2026 03:26:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f172bcc9sm422008166b.57.2026.03.19.03.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:26:47 -0700 (PDT)
Message-ID: <b56abd7c-1fc0-4627-aae5-06ec8c47ff15@gmail.com>
Date: Thu, 19 Mar 2026 11:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jonathan Marek <jonathan@marek.ca>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-2-0a1b316f8250@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v2-2-0a1b316f8250@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/18/26 10:54 AM, Alexander Koskovich wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Some panels support multiple slice to be sent in a single DSC packet and
> this feature is a must for specific panels, such as the JDI LPM026M648C.
> 
> Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_pkt
> from slice_count, note that most panels are expected to just work with
> just one slice per packet.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Matches various formulas in the docs

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
