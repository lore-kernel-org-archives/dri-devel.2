Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51175FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1A610E62A;
	Tue,  5 May 2026 13:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HT78Vfb0";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95EC10E162
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:39:59 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3215273f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777988398; x=1778593198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic3/Ut9PRh6YAfezY9pX7mJyG2OtWSaWHyyfum789Og=;
 b=HT78Vfb0nom9Gg/r+I79RtUGcb70NZnZOWKLUId960c0u4bRgofKmdCik3PghyDWfE
 NS/hZASVRXyhjfdICn7Dvpzw/9jfATxb78ShLRHPTLEws3FVB3bnwm+Gf1rFTQxan9xb
 1UozE6rfT6j977XsVg2tYyfvOI4ZdB9MVYn/qIm8G159Fwm+gHZClqgsc0YRunVlsMA5
 F6ffVF6oKKPzAfyv0j4YUCEWfmJhkG6+9K0q8wY6XaWaGZQtZUSagFI5ER3xedzYZOcN
 Igh0TZQG2T4L5/jhGTqMh6h3GwdxoKE8Dyk9ZgEpvGOF0/YM7YqtC7fCXJRW/jn6mgRy
 VvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988398; x=1778593198;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ic3/Ut9PRh6YAfezY9pX7mJyG2OtWSaWHyyfum789Og=;
 b=fTpDswfSnuytmyYwdknudXgxrOrywL//KaBi7FsmS6YnjerBsVRdB4lgZASygnjF0m
 i/nuBrZqRqjlQHC6dYShC1ewYGD4aRYybikcJBsqm02nbP7Zr0Omf6QRwn8866DOYz28
 xwH9dK7PiDDQdQ1D0Ti2tsz0EBL/iqrmDSJSL2RFDlKKJQZMePKUIh15VFWlUrwcBupq
 XpCYSXO5Djm90pkF7abjZ7PWYl4QBFvTFB/iNQjYJUbkV9YF6fv8hoJzgXfKref7453b
 A6ghf5U7klK29rGmbmum9r0iNZqGJDMUNeLZO3AbRE2y/P+PUF3VY23O5r3P5vix8bzV
 mp+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fbvlG+ixE2394VPN98Lz9hYD+eIMFcvZzwge/OHQ6cvIYjDQttcqaC3Hlor+C4y+2UA0MPVl6/TY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo2axYs4f4niNswE3Zy/FQFblad+mMptPDSK9RqymejRbQ2jhC
 xnjuG/0hhScmOEW9f1LQxX47hmy1mCVKywiqAzqykAcri4E/WZEbS/UZ5St4NwwHbLk=
X-Gm-Gg: AeBDiesW3K64Xn/mMkqKOeWuH5d+GvEdbDeUHLe1aqruCOn8SriHREyrR02nsz4GR4d
 tpyR8/XhniU8gVYOSDDDNH+eoCHH7SlYtkAmEqpLCuqg8Lw5Q3E4bi1bav8u4yWHBxiRcyOdPEE
 Ki4H/Nvnrsf0nX2BIZFwjY+jib2qYzle0oRL51Nhix5asz8yBs5Op7ysqtVCEcyoqkATr2xL5lC
 PA8v9pd3WI86jG0VyRRli6Y5nlTruo0Hli6Iult3B4pAwcRtbiPYHGqnDhpvOwlqttuhUpf3mPh
 E50AVd620du8MrFIbXD4eKc8DPm67epjapKtk4mmGTKadlpARokUu932SYfC8+xuJywOmvKWw7e
 8g+zIF7rEI1Y7M2Uq6TQoKF0i3vcZwa9r7Eay918pE9dFwWuahyIQSix50JFdkOJvAHJo9IF6jz
 VXmUaF8ATyhtqDlQ94MbsZMLDvUhjupf8zy4MdM7ZPRFRSNH5PtquNxXE=
X-Received: by 2002:a05:600c:6097:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48d188d5da9mr50431745e9.12.1777988398122; 
 Tue, 05 May 2026 06:39:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82301b7bsm474114715e9.11.2026.05.05.06.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:39:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@edgeble.ai>, Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260429024954.697411-1-ethantidmore06@gmail.com>
References: <20260429024954.697411-1-ethantidmore06@gmail.com>
Subject: Re: [PATCH] drm/panel: jadard-jd9365da-h3: Fix signedness bug
Message-Id: <177798839730.721826.16088399937997913056.b4-ty@b4>
Date: Tue, 05 May 2026 15:39:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Tue, 28 Apr 2026 21:49:54 -0500, Ethan Tidmore wrote:
> The function drm_of_get_data_lanes_count_remote() returns negative error
> codes and dsi->lanes is an unsigned integer, so the check (dsi->lanes <
> 0) is always impossible.
> 
> Detected by Smatch:
> drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c:2959 jadard_dsi_probe()
> warn: unsigned 'dsi->lanes' is never less than zero.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: jadard-jd9365da-h3: Fix signedness bug
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/faddee87a933898139f5aa9e76bdca345936b538

-- 
Neil

