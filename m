Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF5CC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E497210E83E;
	Wed, 19 Aug 2026 07:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gfXHxNO1";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C1E10E83E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:35:52 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4994d41ceb9so763525e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787124951; x=1787729751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EEZZ7jCpPzgYTO9oedvXx8uW0QuKMwnxpLd54iUvN+g=;
 b=gfXHxNO1Hg3hsVnrSIev505+sKKtJQzm7nLVrtCeqf2XBuU3TlcNaKPvnyltczGe+D
 SbaeWy5StxfnFvfqSOkY1TLYxPI9rSe75Ys1GN5y9FX3zDWJdQly/eaXMHe9tsGwbs9C
 yX+fNUCpHIIp94ljACvtqegqD9SI4aFFuvsz25ewPDNeWrPGXkGgd+6PgxrQSGRxtHTW
 /xaL+vIxDAoXQfJ0uBZPh8iBHoq9bdIcZgMcMplAAYkSdP32vanYWacqnXd15Yyr7eCx
 qTMxtCXSdWxFPpT0OcrV3yaUqnncsnP7aIqJrwfQFyG//ucDEz7RQ5c9zwKRVeERnmTl
 pzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787124951; x=1787729751;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EEZZ7jCpPzgYTO9oedvXx8uW0QuKMwnxpLd54iUvN+g=;
 b=E/6YaAMls9xnE6oqWaF4HGhKusBKD+r3GNImjypnXAQjoWpCcH/sW+U4lnUe3+xB0H
 OyKnGnqtCW5Dp1YZW2rdQOOZnGD4Sc03ELnsIEgETz4JLVZY5u+qvo04vp2X3dITJwJ0
 ozfDhm+9NiKiuTKGHJd9OBfnMe7+IuHO55Occ3xI4QslL+Ab3pEmwXefevWxShSgpjC7
 pJxa1HxrSnKeu4HA/i1D3P/0OB/Br7N6usGH2ioPRkp+2kN3DWj1yq8jVHreIjXe+N9h
 trYyAAVo1ZpFqdOJENTQGR7alslnGhkhOOHUM+IKt0X0UIfDei6p0wDJcb+6k/WpMa70
 Fsrg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8Rz3PTO4iEKL3OcGUt7MAdTojjmaHcd0sZxE9lO3fHSGR+Jsb6dt/Xvwuz6W2dVQgnIBOhglKPMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBTInXO8zQ9wN8sd61t141Wcj1IoptKcY8bbkAB3HQCOp/6hev
 +qmq7wXNYx5WEBYd1dzeYHtRQU0gmBLSN5+PLCZbttON94xayu0+rSH5
X-Gm-Gg: AR+sD12DAejbj2MMLcr//AOOXoYsBZsytmpVWlX9ouWrOETQqIEsuMun2LCqw7Nox8j
 mLzepFfjQSRgzCWa6qs9uq5TXlQgALZ2m8nH9g9h8BloxLeVeNmDhblFKYTNPC2/pLTqCMV6xSC
 o+f88QV5CeJX5gpQrBA1zhB77UEixBTJMHJMt+kGRuVjtuC40emvDJiA8Un1lJfI7Duxb9TiDkb
 AuCf5c94LSZpDJCGuSj6vD1008oloIFIvZ7/ndgFbnSYmrq5mQ9Nq4scx+aLhAH1oAqJ+/XOsIo
 T9tOXXW6tFx3XvIxL0R2MlDQR+Mzuece4gFiJxeuU2NsWQBS/M+PQCPXLTp+roiYgv0hyXdhmVZ
 Sx/bWjI0OoD7uTBVe7vRMKo2CSHzWSmF2wUwbohYHLy0sz6MBkxA6lbKJ9jGqjGbnFo+ajoWVwd
 q06UUvuJcKtP1QAUYo0b8rJglzqYYH4uOOX9fkigIznfdvxANkYJ3/60suIuuezCUrDlT12YXLp
 qlGrt45s6FS7g+GNEws3DouuviMjoAFYeuOJ0L8dJ41Y3B26eSQGci3vXu/zLY4HFBP0w==
X-Received: by 2002:a05:600c:6206:b0:495:71ff:598d with SMTP id
 5b1f17b1804b1-499aa1997d8mr24560625e9.1.1787124950666; 
 Wed, 19 Aug 2026 00:35:50 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B92960062A31D8DDD4EA0DC.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:62a3:1d8d:dd4e:a0dc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd3c9sm40653805e9.12.2026.08.19.00.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 00:35:50 -0700 (PDT)
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
Subject: Re: [PATCH v8 02/12] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Wed, 19 Aug 2026 09:35:27 +0200
Message-ID: <20260819073530.6087-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819072420.1780708-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-3-gahing@gahingwoo.com>
 <20260819013609.1613919-1-gahing@gahingwoo.com>
 <20260819065146.5904-1-royalnet026@gmail.com>
 <20260819072420.1780708-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Jiaxing,

The three-run design with the deterministic third arm is exactly the
de-confounding you promised, and declaring the fourth run void instead
of letting it pad the table is the kind of honesty that makes the rest
easy to trust. Glad the third bullet closed on silicon - one line, as
you say - and thank you for the Reported-by.

Meanwhile the differential finished here. The base build existed as a
pair with the patched one from the start, so this is the same machine,
same morning, same session.

Base kernel: identical tree and config, same JOB_TIMEOUT_MS=2 local
patch, with 1/12 and 2/12 not applied. Same protocol, two passes per
kernel at console_loglevel 8 and 4:

              loglevel 8   loglevel 4   recovery   oracle
  with 1+2/12     12            8        all clean  48/48 both passes
  without         12           13        all clean  48/48 both passes

Zero MMU_DTE_ADDR, zero "Error during raw reset", zero lockdep or
atomic-sleep hits on either kernel; the domain dropped and all three
cores returned to runtime-suspended between rounds on both.

Your distinction between the two tests deserves my numbers next to it:
all 45 of my resets hit a healthy block crossing a 2 ms timeout, and
the domain dropped every single time, on both kernels. Whether a
genuinely hung block would keep an RK3588 domain up the way your
failing runs stay up on RK3576, this protocol cannot say - I do not
yet know how to manufacture a real hang deliberately. So the honest
summary of that difference: the step your failing runs are missing
simply never goes missing here under my conditions, and I cannot
reproduce yours.

The race itself did not manifest in the 45 resets on either kernel.
Timeouts are easy to induce; a completion racing the reset inside a
microseconds-wide window is not, so the justification for the pair
remains the source analysis. The tag attests what was actually tested:
recovery and absence of regressions on the patched kernel, against a
differential base.

For 1/12 my v7 Tested-by carries to the v8 shape as re-run here. For
2/12:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores,
                                                 # induced reset, differential
                                                 # base, JOB_TIMEOUT_MS=2

I understand the v9 sync patch will carry the interrupt mask and so
change shape; the harness here is standing, so say the word when v9 is
posted and I will re-run the protocol on it as-is.

Regards,
Igor
