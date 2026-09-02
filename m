Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DFAC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2B410EFBB;
	Wed,  2 Sep 2026 03:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kojIV2Vm";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E974A10EFBB
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 03:20:39 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-66f78cba2e1so632568d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 20:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788319239; cv=none;
 d=google.com; s=arc-20260327;
 b=Nd1r6ZTSqaNBE8v3XryMla/X4macSCMnB/t1inLHIrWg0Oos9mwqOuhFTmKWh9qqkw
 X5NiX+/qBD/M3VA1F7G60lzmMwbE6tQKqeMYaju4JskXNzGk8dPnYsRpI4qf/DAe6ESi
 75crTnPZaBq2FjTwA7ct2IJcVf75aR/wBn6zmhw0zxZ4fl3ddHDT0Lt+C/cWzmN51fPN
 RfLTB9ObRT7+1qz3XplkJwARdx2R0cBussR0MFTBqfmDKfty/l30tpTFqObVflaZVmm8
 Zi99LcBuiaKbF+mYu8e7Tfb0nnOZixP2FQRogC2CipH0vu6ATS0vff4lCjF9piwFppgO
 9pWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Uzv5ZOutoGMcYzpdmAuuzSMSJjkqPNjX/lcdxHqeAuk=;
 fh=2lKtLbOSba6L0E/HViRGNDh1oIf9LjAnmDZeyV8Vs14=;
 b=f7Gfesp7Zg81lqhKu14FymJaNEK53xb4SyIpySj/g7mz5qy1u1S5T2G9GTq2EcNedg
 PKieswtn3bq9M5YrcTa+Ww65vSCAhtg/qxK3+X8l6WUsLJXNotmAC0VFxqcorhtQ4X+T
 3j6O/PgV4jWFsSv78OGAUrTbrdh+LhTFokW+eyF9wWrHuepBDAxdpMGR9Tj4yV9kY6Ug
 0OEwzakgWZbKknffHoYrKLkHI/T/m+s3qxI2hEQP4dQ8Bun++u+gy5Az5ms+99ElKOqc
 berpviB4l0t78ngqK2td/sWPiARoX93j60HoY6b+1xM44nJ4X2iFJOw3T29P389tYtIP
 7klg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788319239; x=1788924039; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uzv5ZOutoGMcYzpdmAuuzSMSJjkqPNjX/lcdxHqeAuk=;
 b=kojIV2VmEMAZrQ5Z6uFVPmSN9DABUSDbvgI62csVp/0XPnyVGVv90j8bLGJwVsP92r
 6d/BWPag5Q/G+PFG74BYyLStpXCgTTSX+gRBmveDCHNcr9PrknDXKZ8utpa7qOMTrxpq
 O0FBmlqBojgooGGYmLslMBVqnFYC8A8xBgCgWLDdx/gjOHit/YK/ew7OeGL3LzTfhhcp
 C91WrdvkjzPiByMiCi67yC2fpmA0liVYmbmJGHGLpGQfPSkjw/AA3dqoYYUralafKOWV
 dk0dwKWLAKaeT5NpDFLl5IciRKT481C88eC+5LHDQQwUj/c0lWQ6PDQVrZDoK4ZgYF+5
 ZXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788319239; x=1788924039;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Uzv5ZOutoGMcYzpdmAuuzSMSJjkqPNjX/lcdxHqeAuk=;
 b=LJYQcfNiOv9mesy40WUiFe1FORP4B1pWnPuxB59K6aSswQ/F8QyKpsa6tv2fJHW41c
 yhwi2KRvCDXE+qXehB+LWpN9jcGBkt27Vqigka1tbU1utDD0gwkKZyILE7PCv0Vja9Ql
 4/X+h4Zk6OChLPayXmXdPkhqw6fKspdnZ3OWq/RJa8+GQDjHUnKx9c+cPeQON6i4BpT6
 Ec8Kv3VhcQUpU1zfq9i33yUqYld5VMFjgXBhhuyvR8T55BU5pROJL4XwAYjHzOauS2mv
 1aIPVQ9G0ASMWUzetE1oGatuDodJf4BS3rDvgUDfYEeOofbVsAJiYqR1sjAV71Z6hJXF
 AtWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1sCQ0XWPwd/DHrsYjXpR1X/LelPghaY8Tn0KCFE1JxAETjdpOr62KjAp9ufLwFgWtOHVNrXNN5Po=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mvudLV9pcgYVpDgJII+cTyM4SevGKBX9r/tYN9ZLZU7PbQe7bw
 hJVJo/Mkd+t2QT/xKnvtCUjz+ztsnTDpD31moQ2ageaEDxabkth+LNb2Dd2/Pbx8KjhL8nmgCcz
 bjasVS9UrEymE8HaGI1mg6esaWWawp7tCajatNi9oxQ==
X-Gm-Gg: AYBFou1vRa4YV2/YcRK9oICFEykhg1EV0pGgj6uBKPmHNnWJ6DyJtwdi3VQsOzSngQZ
 Jcbn7AufOi8vXwA57qWKY4nyzMZ2r7xWnBBjg6a1JB3dpL5e2EeyljvTjTcgIR/H+hPRY3hGxXk
 wf23ofILuFQ49kNXX1fxEtJh7NHXXtcYQTw0o5bymHnQ3DaXrZ7HAGcY9Pt2mIETClYB0RL79Aj
 TG82D2EM5rVBGZsuwfdIv8WWlI17zCJMrsZpXZgFC6yTF9eSJrJdt+xJY6Ij4akf2nG+6AJeAQ7
 XU7sCxlBTw/c+wwgjvw0g4eVrTtGn6jDWDCuTbBiX12VK7LmtgqXNqp+UA==
X-Received: by 2002:a53:de12:0:b0:66d:151a:8390 with SMTP id
 956f58d0204a3-66f9ba447acmr526157d50.3.1788319238504; Tue, 01 Sep 2026
 20:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
In-Reply-To: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 2 Sep 2026 11:20:27 +0800
X-Gm-Features: AcwNN1W4J5dkjR_DtUCGe6FED1QpsI5DSrYSJEiFhZPubNDnqUDs68CxVjgIcz0
Message-ID: <CABymUCPO4zDFniBNqicyq20m3NptU3AHB2it2fS8-7zvreZmug@mail.gmail.com>
Subject: Re: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
To: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Dmitry,

Any comments on this patch?

Thanks!
Jun
