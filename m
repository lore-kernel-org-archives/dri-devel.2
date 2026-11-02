Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A4606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URC6m0sl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5544F10EBB0;
	Mon,  2 Nov 2026 08:06:37 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFD810EBB0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:06:17 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso1823939a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793606777; x=1794211577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ChYiWXtgGQBl/u4nMCQKXDJCoRvRajQXYwkXLNTCVQ=;
 b=URC6m0slNGxAGU7J+75kv+fnXe9K8oP5YcBoR2Cb+z0fYPXPKQdc9t2AkmfESL07C3
 E1iUflFje4PARohtCED6H1TH87b1YeHSQz5DwvciLQ7xp+somr2oXoYma7Ei4erfqM6l
 l1cY8YVB3swxbObBP7ettD9P0EOU8A1XEqEg/VneLMoNoYUFddSp14p4BE0Ewm4RH4oC
 Qiq2C3X1874uXGKoG6GVzmL4VEwskTdMIa8O7BsU8/4GyKFFFIUCBqM7bW3F5ZFCt3lE
 xWjXSxTv6Ks9oWg/1I173lDX3+WfnZKpIff4g2W4GAg+MDI8IRp8gtJJoiDpLSvYAxyj
 q4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606777; x=1794211577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ChYiWXtgGQBl/u4nMCQKXDJCoRvRajQXYwkXLNTCVQ=;
 b=eB7DcccQDf2djRIHp36Vp1BI9qDHcEuwACcmaG+b/r1e/USXh1XGZskeBdmFPps/YS
 rD4syzaV8ALGqZrQtH0e4AVEMrENjKk0H6yMpVzMxvFoj9XYkal4QJC8PDfyPbsQ7C/0
 4gDIpWca2fGhjEnypTl/V+hzd5PbAlwG27Si3AqbtVsPIx/JSkhdnuL7rhj0XmQYuqR6
 TmhCQkkiyG4D9N5CCXDWJ1DW3nlWgWyT/i/UYge6upegBPSa3E2Cc8DBoVMjBGFDESwk
 87L+o1Hi3+naF37osN1/6fzXbzRF/KlMHHH2O2swzTHV/BtigAeOpPkBiq6H0U0IVjBl
 hwHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfmcJHxksRQ/fuC+hoQqFeDBjHHQVa+tX2qkg7PAlAob7z60Irr8xyXWp/6q6NcBBos3smbVJfm84=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8S38T97z0A3oyw7kTLldFu7xnIHvc4nDh+p3BIGGMaaBdyR1po
 QTAN9zOcbQcms8E+h49J7fon1+VoxS1xL1BX95RNH2ghhlXs9ikGNP2J
X-Gm-Gg: AYBFou02mcH5MmtJoUpl7UQIiiUSlos9v/sQjksKh2E9muSDUN2k/SmEDRNqxlNy0t5
 5trb2Pm8URdsQSogj8cLJJ2b5vGZcK4V6DgD536+/lAwK6xHM6d2+k1zHWAi5rwkEw5fvmZbnqL
 3GmpNYiL+VxZVNcfUZ1WYrTrGbe5ArWxX/JQJpqpgePWxutrTqrswEk8CsFDUzY6KWcMW2l1c8w
 CaV++1F+MAJGDENscEDCixYc3wVvWHrRCZSa+o0bjIYfVGNhbJ+yCNnseOLPeBPbRcXLYTMSP/R
 QeUHb89kccB/S/ybEeSVacPNuWrgEBxFV35X7ElaoRjKXi4E18MmjJDa+/u1HZ1zum3EHsa1aNY
 Jw71HeszHD2tWktDx+f7TsI9+bgWtMT1CPRlynZfQpyxwgT5NnS65nS7N7MXmfFgOUHmugNgzEW
 UlLmcqyQbbT4xGmxR2mt+JH2vICVbrV6z5zazOoxcCRYOhch8p3xIb72l4OuskUeVXvOZ7JW/nx
 /J5tcrKtnQuiftqx13goRUqBKEN6hWwEkJ5G9XV6sfwO1RQhvwKk1cqFxGMCt5yWjGLFldwDc0y
 daZS4vpLfv9tCiI/4XrXhOnOm8Ft57P8sevaMLB27EQ2mG7l1gVFEnJIJskC46DsEGkMJGM29PD
 P5TK+G0cWsDgp4M1wuaFtDdXiw1VmVK77163esSfHMHeVxzysN3ZPWJUqrb5xACwOFO2hSVCWz5
 cOAQe0qo2aM2AbNA==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae897585bamr5292232a91.26.1793606776740; 
 Mon, 02 Nov 2026 00:06:16 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8441a6f0sm13214894a91.1.2026.11.02.00.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:06:16 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev: pxafb: initialize IRQ completions before
 requesting IRQ
Date: Mon,  2 Nov 2026 16:06:12 +0800
Message-ID: <20261102080612.1469981-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2fbbd0fc-3f5a-4bee-9a46-1c313a96fa6d@web.de>
References: <20261031003424.1796478-1-matthias.goergens@gmail.com>
 <2fbbd0fc-3f5a-4bee-9a46-1c313a96fa6d@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> What did hinder to add any known tags accordingly?
> * Fixes
> * Cc
> * Signed-off-by

Nothing; v1 should have had them.  v2 adds Signed-off-by and Fixes, and
sends this patch in a series with the other pxafb fixes:
https://lore.kernel.org/all/20261102080332.1466689-1-matthias.goergens@gmail.com/
Whether it goes to stable I leave to the maintainers.

Matthias
