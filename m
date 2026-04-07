Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0382FD5F82
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E7310E540;
	Wed,  8 Apr 2026 07:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arduino.cc header.i=@arduino.cc header.b="BPENZh8C";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338C310E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:53:41 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so2750616f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arduino.cc; s=google; t=1775566420; x=1776171220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9QJ1HBFAyhDaJiIDLuTd9AfbF3RQyrm1cC5fEoMDC4=;
 b=BPENZh8CjbDdC62oGYAcPwlgQxUy/bURYdTg9atsWDc8aBfVRW7+erqbrzHMN0Lkto
 M5KclmPHkoBwEK7ptAAzz+uV0qhyq/+iREwJDbtbr0Xtp3ZERz6l/k6UTg8aSZAXLQ7Q
 IJEZDttbE4cC8HD6vmA9N/mO8dfHmJm52Ydps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566420; x=1776171220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O9QJ1HBFAyhDaJiIDLuTd9AfbF3RQyrm1cC5fEoMDC4=;
 b=Hs9B858hKRlKwbHFRd2Dl3jMPCmAHTEt8nYXkXOWCgRupNytwZktAPbjKyCbWUs9la
 3ozhnc+FN8eeSq9/nQbs6KgpZUHBmZ1XQE/iEWXW09+gq42NOUJOKejijXxLiwAD7yCz
 eRwNQRoRSf1UAjUUqG1JqKrDPPb9ytk5XmQ90ncxQvJHqOG67ZGPxUn6oK2PGH1dCC8i
 zpSzL4PtByYf9vt1DBnv2HyWLIZs/z1TfiweKxHQWZ1PhF5bUpsDzIYbjZbJaHGT5F88
 1+1scUsilOB4BQZ2qUIvMSo33dQkL1bJyvwL6CGFXiXORbNCs9arXOR8idaDCG+4X0m2
 9gNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAk4jgo81e1tbQgE285CcPXvXEyDaHMnZ9lHZyuuFp5HbC1WD0ZSDXhlGiO38vMWObz97oRqI19Jk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJHk/830H1BQTCC+Ifb9NNp8ouXA5BRs1Fiuxacc0FGjcrQn6I
 lWfRmMKBycEUSQJPOLhpHkqfUBZmXk0XOLoHsOAF3uG0SbUKsrDljP0s1TbVeyFZV+w=
X-Gm-Gg: AeBDieuomz7EyxRjxZlkn5X6NV6JqShk4M9uAFM0gF1V6ej0fnDsYmfQLwFvh1qwbzO
 k6cI2zVDZsWAlcUb0CrkAws72bXoQoIu8+fg/EVqLKXJpXfysE7S0l55LnUq+8nT/KPopMm7UQq
 9FzKKcYnhCsspKYMs3I2I5umHBpB+Bq2luYZG4fSLxk8zlPRa+qFUT4Ybed2udHvuQ9i9HqfTM5
 HE0ImiuWQIoAJimLW56yD/XD5yTQ0rPhYh57ECEctg5drQURqr3fO/YQv9KMDDMpyhSUZc2ZeEe
 4Yhmww1g+b8cLwcrEz+kDO+jot9kpaRBK0lRV31CEvCYMTNVFhXvhLKxI9jrYFGibIi83vflr7H
 Rs+R6QOMYF7ZKygm094QIfMCS4w90i/oMdOmSh73gvDa+9bukOsZmMCIi1tNII905K3byJj2IAI
 NeOfCQISUxCQHWbSJvqXpFuMynjyIEpEzCdPrxG5OE2L9+F5HeHQu/2PrhWPrerL8yU0k=
X-Received: by 2002:a5d:5d08:0:b0:43b:60f7:2283 with SMTP id
 ffacd0b85a97d-43d292af08fmr23457243f8f.22.1775566419646; 
 Tue, 07 Apr 2026 05:53:39 -0700 (PDT)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a7223sm45923267f8f.5.2026.04.07.05.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 05:53:39 -0700 (PDT)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: airlied@gmail.com, brgl@kernel.org, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jagan@edgeble.ai, javierm@redhat.com,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, lgirdwood@gmail.com,
 linusw@kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 megi@xff.cz, mripard@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 yangcong5@huaqin.corp-partner.google.com,
 Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 19/19] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
Date: Tue,  7 Apr 2026 14:53:36 +0200
Message-ID: <20260407125336.282320-1-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-waveshare-dsi-touch-v1-19-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-19-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 07:09:52 +0000
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

On Wed, 01 Apr 2026 10:26:38 +0300 Dmitry Baryshkov wrote:
>From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>The Waveshare DSI TOUCH family of panels has separate on-board GPIO
>controller, which controls power supplies to the panel and the touch
>screen and provides reset pins for both the panel and the touchscreen.
>Also it provides a simple PWM controller for panel backlight. Add
>support for this GPIO controller.
>
>Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
