Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B54C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F9910E172;
	Thu, 24 Sep 2026 13:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yDYJdmx7";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6761010E172
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:59:29 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso9652705e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790258368; x=1790863168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LRDlFyxUk3KppsRNFoYPmaT40+fQeOq7faNwXvSK4kA=;
 b=yDYJdmx7lFfinPqplj9gcYQJZAuCkwoTVYWfjwsDsIt9SqzSUjy/JKdm4vvRpQPRek
 XnSGMlUIAj87RoEEQrLORAUGvnRD2mNydk/FJdMToHYlPVb4NGWV0vFY3TlOQyxpsZ06
 enQk4xNz6Zuz6czTEpsmYcsdW3Tyc+N52KE2TJTy5M72LCqWzu56PgFB2WKM/sd23+Iv
 yPyb9/x78lm3FHit/4Tk2aJjOWBC8Z06794bbG/d6M2QJ2euCDLtm5nikShFSJ0AWHh/
 OGhLnuPUUcpOmreKuTGqyssJTmlCMHH0W0Dm3R3GzgrohwSrSyXB0tKjV3I6xxoWUPm2
 PSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258368; x=1790863168;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LRDlFyxUk3KppsRNFoYPmaT40+fQeOq7faNwXvSK4kA=;
 b=nF16RD4Sn0CucHJe76kVHzOHEHTjaOtU2+mv1VswLMw+3Tp0EbJO6hcVlg0yTWVT/T
 dr2GOSCwgJg0HHu1kWjdP7yQato3f0PnI0TmIjzvlYjd3bByZH45sMiyMZr9zahrnTpV
 m7Q1DR9OJYV05NzY3LxtgJr10HhwJWG9SyM9KetN51LFVVaB5XJGc9BCxpK4g9DWitfU
 oo0O3EAUvhLymOs63R0YPln2BYd6tZ1OzAI1KV3YCSvD1yBSpIoZVSboQtsr8CdNKUWY
 elvTWLjHp+x/T+BYkgaciQjV3Rdj5LdCAvex1xMZbBXbRGMDkfUL6gNRCkGa5h4dula3
 mxuQ==
X-Gm-Message-State: AFuF++nE9I/ClVBizMpsdyfzjLSB3GJLsZGIXzQTa5kwcEQ/G/LWWPJx
 i0jbQ838Q5zrMXBS3CjvCf95Z/zVOne7u32jXCubqeDpB1aumQWi39uiFLr9XkalwMg=
X-Gm-Gg: AYBFou2Np9IC1XWxJU3hQ28B1H5l8Jy0JrrhVWSJ2YKtzzixZN/iRPmvs9uyK2U7olB
 54xMCYdK5g3zoclzoldYW2E3CQ3CQPTDqcMYCFYIguph6F+r5zj8DQzWC/uN0na8NHio0K0Ht8f
 DXn/XTrcpIgRYD/XrIoguSquINPbrsRT7DmPF+5srKO+uaqHyMQd3Y5Yky0KpFaUkcZ+LVFcsNP
 7K47fF1mbj5DZW3tJJ5CEtLbsUnJ1nFFpS3ql0smk32977iQCTnMq+leqDwkx386ZXnp5mxy3lf
 KqdjzpePZKQUp0emIQFyXW2qgwP0dUIJ62SebAaCwGX81WM7iLzjtk3JvwKCrQj01wMD77OUnBp
 QEC/Ym1TMR2zpjnfCn21BZo+VV4l2i/Uv90LEUEgxcmMCybNaNiEVEsccZs3TfJgmW+W9ng6q48
 sfM0CDJjhzuOnqZz9NtXj5PABgq73mpkg4uNYbDcJVjmP9ktFEdtGHKN0/wY4u2QPNQw8HOKL8X
 rCE9ZN0OPzBMvRCxYld
X-Received: by 2002:a05:600c:a00d:b0:49f:ce73:7ab with SMTP id
 5b1f17b1804b1-49fe6708b23mr50754095e9.34.1790258367671; 
 Thu, 24 Sep 2026 06:59:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c500sm15799213f8f.19.2026.09.24.06.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:59:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Joel Selvaraj <foss@joelselvaraj.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
Subject: Re: [PATCH v2 0/3] Xiaomi Poco F1 (ebbg display variant) fixes
Message-Id: <179025836659.3234093.17562514637378483936.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:59:26 +0200
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

On Tue, 08 Sep 2026 14:45:01 +0200, David Heidelberg wrote:
> Been broken in mainline for some time.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c
[2/3] drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b1885bd1c985999b8a5393f2e23eea8dde3109a9
[3/3] drm/panel: ebbg-ft8719: Split initialization into enable/disable fn
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/012dc8a8e5b6bca57ef7bb62d6015faff7690e0a

-- 
Neil

