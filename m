Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072E606A33E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M3JoNKJB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D45F10EE67;
	Mon,  2 Nov 2026 13:40:51 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BEA10EE4B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:44 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2091930f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626842; x=1794231642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oCuAPCpAXOO6RuODfwfptklGCvaTyAJZnsj2ANQ9dHM=;
 b=M3JoNKJBd8IKXtiRbYbYkT48vG2nU39DE7nFn4fg5dqMnZEagam0G/ycwxDrlgpFXL
 QhDkwUkWJGx47vPsEgwjdKB8OxyoXYi9AEd9GX4GSRDU5blAmxXt0CGvzDdp9Xig8A3O
 2gqQb1ZFqWiBAypzZQrPABi8DsrWcBUfjdZ1lEOAkfg8WqfB1CxNFxkywzqKdGA8TdMK
 4k142XehKImkVX8vZfdHyi59pryvGQO7/p+3itJj+8N81U+fMwOby6UFhZBPs2sFYDA3
 FqqmEOE4k/oNaBJ3Lt7ieUmXZhtln5iokD1sIh8JoWWQWf8KpXCcEPp6wreNieYh8IMF
 YHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626842; x=1794231642;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oCuAPCpAXOO6RuODfwfptklGCvaTyAJZnsj2ANQ9dHM=;
 b=LnLrYH/aE+ayjaORfqvgCdyO2rq/8ThVJvtn+qtieBH8pgWsZWYVNGF2sNDAKOAFhi
 AsR4XiVFncBEX/vuU/Oa7SIgNPl3veyxIoC5PeNVq/UGZVEoKuVX0OawFd+oCwzVq3kx
 Zwnt2uxMzRaWzEbPA7sbda+XK3NBFqwitYqxYOmXadcZOvovwhcZpR/0Y77qTGD+7GDg
 rQPUQy0BmyOUPw5Hn9v1txGBKDofPu1M1UIcqm5B5KYAeWsj5ZDjSsgd54ZiyLDtBnDy
 4CX16lWSrA4n1MhgXc/DJFXkmqcCP1L8D5UmP1EzqaMt0u3Am1iILca4NO/pvEKZmkqq
 ANjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYR+BMuSUUEONcrfFZiCsKkA452vdHZYssQNBToSpJ/kfz1AYIaq/RsTiILApo4t+bPHHfaA5yeE8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLl0vVdlPT7kepnalaVJCVSn3foK2peRbsTotUPDIMcW2FynWX0
 tNHLQLZm//qJtkrxRxGJM09lI0Qig6gACq//IRBnUursqaereWqftUdmeMTgIgrispw=
X-Gm-Gg: AYBFou2I8JGglLdjKHOykbnBJBRT+1WAr3ZlUJBNIj+FoY8QnbaF3Fb1RpA5aQ7VwgR
 nmrn9MGDJ+BNxPQdDewRTk5mru8HrZGBB9HptHcB0kE85HPWO1lOgMfjZuJMxJW3iLH2GWD7gE5
 WhD66+JZedMpCr7pggDvVCDsmZXUHUG/kOPii72nWiGZngeUmvBbOdl7Ad1hFZiuSeFK+uufcIq
 mhc7VHiqhwEOxsr9iyhgp4BbTozqQyN/52sL/tZiCMvLCP+nYfZRI43lb4EMjHMBptO/aw4xphC
 P9dQ+d1EReEQUdYBniSbAuyla0A8FGazDblUwS/x9ojJqr48Rboc52sEoKf4PNE3IGM1w20LeqI
 K5FX29kIMU/pNfYKaPkjJ4GMkHwy/xHLviI6VbMVYD+iHiIJ8mvd9Rfem+YDX3IJO1+HWdnZqiM
 sWTz1f0LNe8jBT/kXwtc9oiWMV7nW1ph56GDLY+KUpchXrBwtoyFj6vYxIGxLnkM4nZrBsbSTSm
 U369yZEe8jkvGj5EWqSr06WQax0zOAfevDFumNRheY0KaxHFvV+gORJDjM00q28F/Tv1NWuohzD
 QPBAnlvn37jnvhzK+g5mLsF7nuYL1ponxcIMydxOiRaNr6eCVdhjc/+ETI0TM9uJLu9I3/w=
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id
 5b1f17b1804b1-4ac182dca99mr253947035e9.15.1793626842344; 
 Mon, 02 Nov 2026 05:40:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:41 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Asif Ikbal <asif.ikbal@amd.com>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 thierry.reding@gmail.com, sam@ravnborg.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com, 
 michal.simek@amd.com, naveen.gaddipati@amd.com
In-Reply-To: <20261016094638.2958431-1-asif.ikbal@amd.com>
References: <20261016094638.2958431-1-asif.ikbal@amd.com>
Subject: Re: [PATCH 0/2] drm/panel: simple: Add AUO B101UAN01 panel support
Message-Id: <179362684137.3310106.8150068163787237277.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 16 Oct 2026 15:16:36 +0530, Asif Ikbal wrote:
> Add support for the AU Optronics B101UAN01 1920x1200 10.1" WUXGA
> MIPI-DSI TFT LCD panel. The panel needs no initialisation sequence and
> uses a single power supply, so it is added to panel-simple and
> documented in panel-simple-dsi.yaml.
> 
> The mode is taken from the MIPI interface timing section of the
> B101UAN01.7 (H/W 1A) datasheet and gives a 60 Hz refresh rate.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: panel-simple-dsi: Add AUO B101UAN01
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8f900e88c5450a40ef205f8e07ad32253a4ff7d5
[2/2] drm/panel: simple: Add AUO B101UAN01 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/21a19944ab649cfbba0c5feca21f5a000b36dd6f

-- 
Neil

