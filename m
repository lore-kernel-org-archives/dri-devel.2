Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA5FC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F8510E239;
	Thu, 13 Aug 2026 09:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ev1SR+/B";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B893810F264
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:57:34 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fe45db360so227860f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786615053; x=1787219853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EtA2EaJrfUAL10NvnwAbetKX7hEHz7uIdxdgCc4AGbQ=;
 b=ev1SR+/BEqUMIO5/OpX3RMFdS0rVupq4//RFQ7IT91Dh6xKti6TA1H+oCtW3GLawhE
 RbhgQM4hYBxMus6IZqCWJvhdcNPHtePxOuKv7r3ysTSnw4ED1zCDUInZdPP3UFu4Z/Ar
 fVqnlgElzlHGExqWWwYNmjjIxFEOLrXjdslvPSbhdS2RLPN6VCmbrCUQjSW1aMvDaD/W
 RlkuPtWJzGRcEFbqAfOxw1LXmFaDUQypzmVxCYEok1AvmrFjEg4ISIqlYCLc9XE6X2fG
 ROhZkFOOCBZ00yAT7LDERN/qJKRg7hmUI4NpKW0FIuURsgEIpz2llYZ+Wn+C1W/ZqNT/
 Lv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786615053; x=1787219853;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EtA2EaJrfUAL10NvnwAbetKX7hEHz7uIdxdgCc4AGbQ=;
 b=D4sVJWw3N2Jn9J4BQJ1iPHBOqVdrcMQdauVMqL5faQ88LLXlV+QgWEy7NgpzOYAECm
 /glI8yIHYe8hk0fZo3jCUA9tX5d4A70DHLCFVaGn7X1DXKa81aQ4AF1AfnCwf1agJjoU
 QJucH/f9IRsnjycXgnagopAkNg6IwDetMxEsNUCoqHmRtm26GAdH2VwG1IvWIegoCnzp
 AWB/AKmP/VVVKuZU8SLy+UHkQP6poM3nWkWntTEv5oJGg+5CZaZfQy5Un3ranxLLEaPm
 mhlb3Ss2GuNUlALOcUMwsKQiM0bBjxbfePhEPISy7J+/f0q+ZxX2/Qr6Qa0+X2wZwqYl
 PHRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrevfk31rYpkFdk9YrY0QpZydt7Sm7Cd793VpJQ2fumDZcNZJqaZ8LqnQnKdN6hWtK4xFhL4WsEYyU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmU8Zd+mI2qEdChr4wfMs+a4UsMwUygdD567gz8YYmmraF1nsQ
 eN5PVm3oaceailoCyOqRKUdzTfwBJso7V6e3zxPMTWrddCbTny0kzLt9
X-Gm-Gg: AR+sD12PQo6S9H0ft8VVeRu1KPClnGx4CZ5obWFdWu77MO9B6UJvq+drovgvAWfVAZa
 1cLhurkyl82vjO70mDVaXolSCbxTjfp2qOjEGoodasf923xALaKzCpjctQnyqNC/Xxk3712bnn+
 Es/escnExpO+Ztv8o/i69ybJBMgsvqKFVUQqm5e8EWyxHgG+L/BZQAwSVFcgT29IWPzCdx6iSwk
 5JCTD9R6qI+WpcNsDZ7gsNZuNMJQZQX2lzZfviePLm568/GbZUeDAQ02ZPcBLzJmA5x7sTxlh+k
 S+zystGPNOFqysdG4hyZeWFdy0rtHGq08g6QtlN2zDNiWZPQCaPZKgY0nQRArvSoOxes5oQgWhI
 ZDMA5552ncgABASK9MigiyDpoP/iTovxyUYXB4zpA2lgKfWUpTbG0No3dzG1pg4xaQmfG3V6sxT
 X1frNuOplI7HFTCbPFwGpZRJTybX/dhTBF7BWL9rh+1jfLcfxbrEznkqPFEk2ucs54EmDjSE/kX
 85JPtTyJgyTmVyAowy3XIuWdFfWoCotMfdsawgN+DOKqzFTf6Cf8coxpYoqkHAxDPqcmA==
X-Received: by 2002:a05:6000:41c6:b0:47f:9256:52c0 with SMTP id
 ffacd0b85a97d-4815ae93ab7mr2388748f8f.3.1786615053053; 
 Thu, 13 Aug 2026 02:57:33 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C009377EE8DF6D0A1C2.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:9377:ee8d:f6d0:a1c2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5b6b9bsm4760430f8f.29.2026.08.13.02.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 02:57:32 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, chaoyi.chen@rock-chips.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu, 13 Aug 2026 11:56:57 +0200
Message-ID: <20260813095718.9747-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813092656.2568538-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
 <20260813092656.2568538-1-gahing@gahingwoo.com>
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

Two short things.

On synchronize_irq(): your placement is right and my question was not
thought through that far. Inside the guard it would wait for a handler
that is itself waiting for job_lock, which is a deadlock rather than a
fence. Before it, with nothing held and both callers in process
context, is the only place it works. I had the window right and the
location wrong.

I will run v8 on the three cores here when it is out, and I will drive
the reset path deliberately rather than wait for a timeout to happen on
its own, since that is the path the two changes are there for.

On MobileNet: 995 of 1001 within one count is a different kind of
number from what this series has been reporting, and it took four Mesa
faults to get there. That is worth saying out loud.

If it would help to know whether the remaining six are RK3576 specific
or common to the stack, I can run the same comparison on RK3588. I
already run MobileNet V1 through the Teflon delegate here, but my
oracle is bit-exactness across repeated runs rather than a per-output
comparison against the CPU, so it would not have noticed six outputs
being off by more than a count. Say the word and I will point it at the
CPU reference the way you did.

Igor
