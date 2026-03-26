Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88424106F30C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D254210EA13;
	Thu, 26 Mar 2026 09:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eMDd+GrL";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF75E10E973
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:43 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso100998366b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515762; x=1775120562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciegcXOIit1AEV4ZS9nQ2Q9CJRZMEatvl932dtTg+XE=;
 b=eMDd+GrL1GyhcQlsCYcsgOY2Yz16D8pp/viqTaXMXmGscZ+sLz2yPiz5U6hTe/g+rP
 5jNOrHnGbBtrF45ETw+vwXUOqegD7bd7VfJjyUa/SYdmUln1CLD/f/RSNz9tcNFTtYfO
 gg0cupcfMQvXMG5dlU4k9sAHErLJ1hkQSXXOVl3wtGlDv4bTq7WjlmKlSw8mEh8UF4Pd
 vhfNmkMbdINQ+1ewXU9Nok1A0Vz5ghD8IVoo03/AdFcNqpyPbycxV018Zu+2kZT++7QS
 JAmpnVCwHk3SUpQS0sohlRATaAks0NIsVNe28h7G203UhaW1EpKldv6cwBBtwmbcFVqJ
 R4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515762; x=1775120562;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ciegcXOIit1AEV4ZS9nQ2Q9CJRZMEatvl932dtTg+XE=;
 b=dpFhwRU8Phulj1qWGzrtlnEdxNDf2WIDfvKuAOVw5CFad3+9XsXqY9kabk8Z2/Zlbz
 moma0X8LTqxcRYywuPmINOJIZHIOIsGf8KaQPStKOpJ5nqfSEdXHtsQ16HyVTJ8XxvpP
 0T0Mt/JSf3ZqlL8eoZ1E7eYXBns9M94jd7Rbst9Li+bZc9kqefQnsvcy5uI9lM98r7a6
 B8jTRqMBd+bOzyiZbdWl6qSvEobLS5+2HuDxaBm3axtKvg4PPsN9Ib25uQT/dRq2zEMv
 Ag2lLll8jmLLuqPW9/OmmoAuPaoT7TG2NsOYVt3yf6cbZHnqhWIJATRW2U+umcLl0zu7
 TJVw==
X-Gm-Message-State: AOJu0YyzDDH0IjsCjwA23tIu5/8ziYSXfQJViKNljwbinFx3oh9Y82K2
 URuFXfc+jD3Vk8dhJPxrym2IuU21GaPNDV3CsdwNlpeYYPHyplNNwXBp6xzeQ2pMSwA=
X-Gm-Gg: ATEYQzyOM62tcBg/wAyYB0LseYsVHmSTcuRaIDccQFU9D81AvLqlkrHUOJsAhTPaQuv
 pmVPyLb5xLjg247SDitVJp3AMNaq4inJcRVRSKRrmk17kZc7XkLgnYoxR4jcOdhlVvdFcZV/Ni3
 CCMsqW3z3PCmohO15hisSM7307JxXxvwr2EpY1/sdzGodXAV73DNdljbeTc8UOcS2Nzl7FDBcUC
 ERLwufG0w2nzkDzwnKouONKBiBHg+OGnZlTOG2YnrBlksSXivaz+WPLYBmgyk6osvgHADFLUtLB
 Ldq861JjwHm1hzogvjNvAQ7eYtgkizUgHHxJNQLyLRFbN1E01o/v0RciThhEPJX+4SslSvuH8lJ
 +68ocK5UsJ5Xp1Bo/yhGLNGddnf4TGs9H30Fz6GK3A4lu/TsMB+yH4RxRyHrUdv6AqwKF/cd0wx
 EReH6mC1FNpDdC8OQxVBImHrtP5H0eosDxTox9MsaZYtWR
X-Received: by 2002:a17:906:ee8e:b0:b97:c5e2:d7c9 with SMTP id
 a640c23a62f3a-b9a542694ebmr449738566b.44.1774515762050; 
 Thu, 26 Mar 2026 02:02:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Ian Ray <ian.ray@gehealthcare.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260217142528.68613-1-ian.ray@gehealthcare.com>
References: <20260217142528.68613-1-ian.ray@gehealthcare.com>
Subject: Re: [PATCH] drm/panel: simple: Correct G190EAN01 prepare timing
Message-Id: <177451576124.103892.15429121150089304884.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 17 Feb 2026 16:25:26 +0200, Ian Ray wrote:
> The prepare timing specified by the G190EAN01 datasheet should be
> between 30 and 50 ms. Considering it might take some time for the
> LVDS encoder to enable the signal, we should only wait the min.
> required time in the panel driver and not the max. allowed time.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: simple: Correct G190EAN01 prepare timing
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f1080f82570b797598c1ba7e9c800ae9e94aafc6

-- 
Neil

