Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA654FB44C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB42410F38B;
	Fri, 24 Apr 2026 07:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H40+2r2K";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD79B10F139
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:42:57 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so86113285e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776951776; x=1777556576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rxz9NU02O++FzynrCeAoVbLT1PUkMktzynAKMZKwViY=;
 b=H40+2r2KtTDnaThhKTbTf/Jkj9uiaqpcqsFQ6iW1KvewwFe5nkWD0kRnHnnXDHBG1X
 VqAqrWwOaN0mUBAdUwEjmPylHGS5SxIOP26YWVc/8g19rgoYilBq+RFUtkrCBeZPlZYx
 0/szXL6IGC20BaR6GXRTk23Rv78XkgRGiru1PqYZnD/ivv/ZDu17h9eiAbCNpqos/hIe
 kimWu4auXplFQHve14THxNugqnDh/7MWrjw6Yz06lX9qH4c4pvP3BwXoPc/0i76+2Yax
 QtUWD7Yp0cWYR0OIisH2vsXTCNDmFptihahSMYL9ockd0APSTAQRAA3WMT1jFh3miXsX
 /3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951776; x=1777556576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rxz9NU02O++FzynrCeAoVbLT1PUkMktzynAKMZKwViY=;
 b=RRkEnG7ENCdPH2s9C2SlucH3BMRTeUA364TtVkxKZeDYuc3Dwis8sejQOGH2zkVCId
 9Ur71OepyB6x0pIDSwRrB+HgE+YnAcwhm/H3mlREFsLK0oDUZ37mh4m47H935ZKA6CCp
 5JECsmT4LFXLQUPqhajXXi62yWqBDw0N7h61xSe0sYlqza6kUP9I+keEgqzD75WJctiq
 nnYU+mnd7YQLB7ze8zr1yFezrw0L3LTPjfz9V7grh1bSf7/dH8/TkLnLx9l8mAnlj+nO
 gnRtYAet5PkEWhQnjLwKLxfiypFBd7JYkwfrvg10nTt8mlFOuc5XGeAGySkqC07PC8aC
 eIeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FEemircL4lVbZskRYF74oLCZsdJWsAqBeyNwXzBHPX8TACVzI3xzyEiiZwEeNwD6Rl3A0zcxe/vs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznsp7fIYDnGmqEEReJy5GWFDKFcNe9K6BDn8BsSmArqykOaaw2
 344zBAyPPTG10WEhKg5Mqt9O5YYdyOCRk5GdftOV2AHAbtBEbCMQPGZe
X-Gm-Gg: AeBDies1+WtBg2L6ARBVlo7J281pnvfhGG6xvGQbRNE2X5R4DpDEsm8lwz9Kqnwd6Zj
 57p2ZCd0RqeOd9jI/BptryDdsTdAo3lMm8EqYpnJpfi+fj5UExu/2QsgZgBTWaxPtRxcpMMOxqE
 d7mrzC6Oh3IDG3EJtlQ5ADlRKHb+mOP71UDYIdpDMEyDhtpE4XhrqJr8bCXL/K0jnL2x/pMk65Z
 FugSSe70BVDnn9pMaNkQB54GtgQPOZlV+f+tbBsBMbJlaB5wm+JhTh8FgxbcMRuTNE2en6cVNzf
 OmdH9Or3IPDvx/5XWnin9groSeOKsfAndgJITpOy2Y1zgqoHHsgV+28ctSHRd1eOo3emt5OTL6q
 bLt7arjwgfgzwpEkdbOx5QZCl39HYQmnjOhspYwylfizUGjonhnIn7NrF45C6nJ7WLxPdmmLGYe
 TerggNmUPN7grBU7PCyZYxNPuFgx7oYZ2eFDZKeFhr
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id
 ffacd0b85a97d-43fe3dc8152mr43015263f8f.15.1776951775662; 
 Thu, 23 Apr 2026 06:42:55 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm55764812f8f.25.2026.04.23.06.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:42:55 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: geert@linux-m68k.org
Cc: amit.barzilai22@gmail.com, deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, thomas.zimmermann@suse.de
Subject: Re: [PATCH 0/3] fbdev: Request memory regions in platform drivers
Date: Thu, 23 Apr 2026 16:42:35 +0300
Message-ID: <20260423134235.230024-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
References: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Hi Geert,

> This file does not seem to exist?
> Was it hallucinated by Claude:claude-sonnet-4-6?

You are right, I apologize. The correct path is Documentation/gpu/todo.rst.
I will double-check all references before submitting next time.

> Have you tested this series?  I have to ask, because adding
> seemingly-innocent request_mem_region() calls without testing the
> result is a recurring source of broken drivers.

I cross-compiled cobalt_lcdfb against cobalt_defconfig (MIPS) and
clps711x-fb against clps711x_defconfig (ARM). Neither platform has a
QEMU machine available, so I was not able to do runtime testing.

I understand that is not ideal. The changes replace ioremap() with
devm_platform_get_and_ioremap_resource(), which is already widely used
across the tree and handles failure cleanly, but I can understand that 
compile-only testing is not a substitute for hardware validation on
resource-sensitive paths.

I have not been able to find a suitable runtime environment for either
platform. If you know of one, I have no problem validating these changes
properly before they go further.

Thanks,
Amit
