Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37984C88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DAB10EE6E;
	Mon, 14 Sep 2026 13:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiubkqiY";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1325310EE6E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:34:59 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b93204449so1064425e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789392897; x=1789997697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N1I/WhP3GLzQG1Kmy9w756cHt+cWsHO36KxPWZULwGQ=;
 b=UiubkqiYBLQF2SmorQ/IGCv1mybZHF0J+7iHr7FFTWfmyY6SkawKyAIcoohh80dxht
 Oz6h8WpQ/1vrkDnruMhYJONzleZGBC7J4JdV9UJc/mQCEMHMsEl+AqX1Iwsc0fROG6z+
 xJidwz3blUy6a+MnEmRvtnlACoEgB1oQFych6jpqI/b7HJHtmi+84G1R3g+6EocqNZ+o
 +zNdeQi6BJVs2zibdSOHnke7Y8jevgY2+LmN1bMRyp8AxIBn6uQKyvmK3W2s+Gn9DULL
 EF+0y0IFh6vCtEJJQbCj1QfH6kqVQiXBi392dkuslzPyA1oJjfrssygDMU93E+xtIPOS
 RBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392897; x=1789997697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N1I/WhP3GLzQG1Kmy9w756cHt+cWsHO36KxPWZULwGQ=;
 b=YrNVge/kasZNIdx734crUdAOgpXZedPd63dFONqNM7WUaryW837ltMovKuVnMWSYzv
 I+89mtWFTJpkXHF3mlnAL8R/DGkDiD1yqxqFQzKJUro48VPW+c46tko5oCQTgkutcJ6t
 ZuhElifLd4mgcsV4Q3bxsjIIAes3bsNWq5MLWeix1GA2axYqyL56yNO+jTTOaCIpCDaO
 A9icXCeNbR+1YD+A1PXp2AWYhhvPO5HaUbD8FPmXGV3a2oLVz5eH7tVZt2Ovc3OPBfUo
 AiOozEsXnnJEB3oCdHSI+foSo7GKNYwQyS7/ZZY7Z3AXkb7qqS7OYw4+6icJ9yucDJBZ
 bbeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7y62PCWSlT73eRdZPw8N/Zj23viSHWNcxN4KHKHsiEZss6+0IQDl3mDUONCFk+2nhOIQHtrOUf4I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++maAZHZdb0ecu1dPwv/T3Tanz0t0LqFzljnGHmDlr2opdearSmH
 NCpdEmXQvzW1aOFGDpwOhtl/FkQyewA2f9aoYKYq/kge1nvgK+bZZJOL
X-Gm-Gg: AYBFou1QbU7ucATtiwb0Cqbs5XhD3YqXRfLOlZzJHJOqI2WK582TqkrkBkZGfuPO9I9
 27JFMegacvYN/CHOtFqFYThg+K0dbL79hhRqbS/VSwMckUf+YIO0qeW9+IPYzDxBuyKlxk6xpmx
 UkpT0biGHhaE0G8+ZZxD6ZtrvLikJzqLVBcUkudIz0+Pxvr7lHCG7D3Dt3gtQtW7ytt5eu0UjLT
 peR12YbdHuxLMcEmyyrZoSU121LeQO1i6qoUQRBFFw4qqqleNz3tS4O0NWqrsadl/yvZxOokVYy
 Q+emxshhvoo7KK8zg5m7y+cMB4EDpiXEi6UKUmNghhnPd20+GyaekdoMfgC+AtX/pICRP9f9XGx
 a7V2b/iJkLbsjAtksl80ajHwKChpYiWsZQDFZTNZ7Nfvq/n2ONPQGsT8YmnFhvy4Fw0MTE1TaCi
 0yyAj8gcwSz8moI8wVvsRfuSTPk111OQrqSfiVJ0NOKP2aZeO0sMlR216M79FluTG6K4QF+rzcM
 ZxC9Ko2YMDl157Zf6WrC25hpCDGneq4Td2felftih7CrdfAa1P/Vl9WoUa/F/sIxBfqCtOp8qrn
 5jE=
X-Received: by 2002:a05:600c:19c8:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49e7a68a919mr33411185e9.2.1789392897309; 
 Mon, 14 Sep 2026 06:34:57 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B85A6000F50888CB3F3FDEE.dsl.pool.telekom.hu.
 [2001:4c4e:1b85:a600:f50:888c:b3f3:fdee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6576122bsm419054155e9.2.2026.09.14.06.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:34:57 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v6 1/2] accel/rocket: Check allocations before use
Date: Mon, 14 Sep 2026 15:34:36 +0200
Message-ID: <20260914133436.8198-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914045605.381933-2-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
 <20260914045605.381933-2-triet.hoang.dev@gmail.com>
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

Hi Triet,

Re-ran v6 as posted, on its drm-misc-next base (5052ea2e6bfc), on
RK3588 (Orange Pi 5 Plus, three cores) with PROVE_LOCKING and
DEBUG_ATOMIC_SLEEP: 30 sequential clients, 10 pairs of concurrent
clients and 5 after runtime suspend, 55 inferences all bit-correct
against the reference, no warning or lockdep report, cores back in
runtime suspend afterwards. Same limit as on v5: the allocation
failure branches were reviewed, not fault-injected. The tag stands
for v6; please keep its comment:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, no fault injection

Regards,
Igor
