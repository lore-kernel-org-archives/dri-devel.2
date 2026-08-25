Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B4C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D01D10EA36;
	Tue, 25 Aug 2026 12:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dv2NO1IL";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA2A10EA36
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:45:40 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so48570966b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787661939; x=1788266739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
 b=Dv2NO1ILh6zwXjCL4k3VInKL8PIF8lN+uqALDWu7Phq7F7Gxnry7uWFUMCrJkT7x/u
 8hX53MsUkzD9UnSuRklgn8qQSCPJLt6p1ahlsWjw9XJp07njEYFrgUgR/cyUEyVMgSDF
 DPKcIqiVMgKosYy5Roz50kx7U22Jizf3TPBnSKfb8J+g7sAalN7Ze2eyGwxvbSNobWLT
 UWWeVznmNow0v/It6iQJZcmtYZtqBxn1izbDnUPfovTkA0WgfgeKGfBktlIV0oYaY2aE
 IZIJLAOTvwhEFvTKcj00ZOgE+aoz5cyYcySVfhHbDYBdq6eQoYYCUJHo8Ue80UlnOhpm
 SIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661939; x=1788266739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
 b=Ci+2XApocBxK//w97sZMmfrpWg3xd62mFWUoQOmm1zr8rAwKhvRYPkWiJ6MmwTGrJs
 qtKvJNEEfNbo4O0UL+AEMbolke56R4u1Gj96T3xZmUFICTCNfx3DQOlintPijgxojdmi
 IQM5HvtZYFWjJwKy9/bdDCL6V9Hqwilm5t9eXpBgZIsuI1y0cZn4Mn90sPmNEI9Ie1Ne
 xSIhE8BRDY41y16YmMYTKe0vPsRvEvs/6HwXuNDop7HJ/wM/IVZdQgXsFEnbhKTasTEY
 X7ck4/dJpKah60vjNjYsV8es1K5RkHKb0K4tKzPxLjeSOddUtraQckwn6R2HEsqNcHQP
 hqkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0Xjvy3wL+K3uI+41b3Bi1X0IHbNmkC+JGBpXLicKt/zli9DkmYIEnGdPLYE9AyHoE3VFshQRlMVQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNWcK+rku2JW3N3BxXMGe/jdaB4MaRujaHWSQVo2AYovDZLl8j
 AU1FmFLFiSI3Decl99yVoKMwmYk04mAKcq9eSysWtq8ssS+7JD90CTBB
X-Gm-Gg: AR+sD10nZAvUFhdOTeT5RirYCCbgg6Dns6nD9Rq/ciLxzMScMJy9HW3BoalNJPg6o8n
 hmBuG3woi+XS1HQe8EPFxSLxS0VxG2dpL2G8ihSux6IMhJNrKi2Wn35puOH+ICum+u6j0wVpkxl
 SxqgKxZEsT/DXPr0kPzBN20NBJnKCWxuIICIaeUTQkz2du7ve8lw/xVwzIuBwH3VZJKJe+262OS
 sE88IXPf1zFWMFJd85tebi4K3ttBDWvfoOOmekdIUAHv5CT/abBrroAltoHHotFJB7T/vZSkEmY
 7rk4O1tsdPyPPiJ3JG84wowvO0MtK+Z/YmjuyqPojXvp0H7sdPyFwjKkCuLqFKrHrbALi7FLyaL
 i5XcSDJ2MU+eCVczHOm9//BRg+J2CCwrUYvbxXSjJhmEA02antmq8vMIo/MVLbpvo907w9Xbqlv
 FT62tVt9sjyTvsSY45D+iCoGDdKmL0PLn9hmGzRQCd8p7TobGJQdT+GV8MtEeyXEgEAQf+UH2Tb
 LpeamBHxkcbqBd15gK078N7IGvtVtmkyiqcvbEIW2FfXWE=
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c2469f96e84mr1943665966b.0.1787661938300; 
 Tue, 25 Aug 2026 05:45:38 -0700 (PDT)
Received: from OrangePi5-Plus (178-223-53-162.dynamic.isp.telekom.rs.
 [178.223.53.162]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249673d43bsm1646329666b.47.2026.08.25.05.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:45:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 02/13] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Tue, 25 Aug 2026 14:45:05 +0200
Message-ID: <20260825124509.11657-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
References: <cover.1787568658.git.gahing@gahingwoo.com>
 <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com>
 <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

My mail client wrapped the tag comment in the previous mail, which
would truncate the disclosure when the trailer is collected. Here it
is again, on one line:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, differential base, JOB_TIMEOUT_MS=2

Sorry for the noise.

Igor
