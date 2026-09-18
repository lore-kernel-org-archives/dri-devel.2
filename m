Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04C9C982D6
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4316D10E69E;
	Fri, 18 Sep 2026 10:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDTGyZah";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F414510E69E
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:49:55 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b30c94so67878f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789728594; x=1790333394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VDT0gosUKlKyUP/LqVdpjlvegUJ6Vvc/r6oZAzPMHB4=;
 b=HDTGyZahx49k0H1xkzd/lubOlEnlkwJZ9n7Ejk0FMjhbr9wi3PEYm9y73pkdgGOYwj
 zCkJkBgau+cnAdpuktFkh2GsPxkIJ9784HegiqFKhXlnwTTDt7x8Xoh42QvTX+1WIM+c
 2K3yTjDRhY5QBe6GcdbceR+BBQsrTAhwgGCwWW/oZH0diBf69zSmQZHlYEQ/aGX7ZJo/
 M7jk/4DWg1UWBQE7KA2s79sRuFWx76/bqx7B2sWriWnsEiLDcXxZVYNgFROVE8O/Nm91
 EIa5XJytg7jH2zxszr1vuFPlsFxtcmMgcVTQnYj1XiiiqeZircS/NiV26iFxu2LdC45D
 e4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728594; x=1790333394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VDT0gosUKlKyUP/LqVdpjlvegUJ6Vvc/r6oZAzPMHB4=;
 b=te4Zo1wCTsPL3T488NbVXjb98EnmstC7T/+98Mk7IXpg4uowdr5b8T8/FqYK15zN0e
 PuKi11YcGUg9zZlh8EWVnjSxXl1O7AoUpoT4HBeXzR2WmXN6wZbUi8wG2r+kgurWNp0W
 zUHKBe2s61BEIe/Uyh8mkgpYXl6BhV5uFryuGC7NzFVX7JTKoFDa0VjypSfCJGZVOoW5
 rzFmokPiV+oUFXv+KDTOUZOPbjQLPCO5wRA1ZNQKzB3hdSL6oETb4kx4V2XbDhLvdgzP
 wbZ5xKvefPP0NU5HiqsBNiMC2il3txDjoj4EgTvu1xOXxqSIO3VmrMVa6m2iNqEbO/l2
 faCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS4a/ioydwmuKEig3SkTaPmmtyqdQAwkiOMRTmz2gZYKb9RfzIKJkFatWa527nxjKMDzjOy5Slfgk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpLBM3I2++hlrrIQbH2hyby10z+8k6yWd8SA+wrd0RjzS93wBk
 oAtk+yZnFtcr1YVDKlOPi72XuhdjZgq9BrW27S4bduqLUCD2IOVcKNHv
X-Gm-Gg: AYBFou0MlRucM5B/cKhhx/j1PIWS62sKUBkajPiiVNeDeruvGi/W9fy8eMcYfMScZWF
 5G9NyCyht3t8L4MMtTdT5re/JJ01lCMNPUEfVSh5vRPQmJy5kg9ELJbWk6hB8rv4RolG3MsCvBH
 9NyXeVGRd6xcYnc9CjEdMdh1LWl2G7MwHfku+ex1IyabFLFGNtHhIynO8YsI9qDoMEzdFboq0QD
 0fytvQQRr1FGO87k67E8BMkdmoYWkNl6Zf3/I/dKGDEx1VUs2qaSdaHKY2QJ0oQru8iGpDDB6FH
 vvQXlO8PxwDbqnaVNuqvoFfHNgW2JJ8mJf3v95cGV1/5kVA5TowsNU2dkzLHRzbRpXQkhWisRgl
 F/cr0hWZk+hIVn6wbrhn7n89Pqu1wGEFZkFDiyKoU6epF3mjcG7Mw++YRomuoXIeqWSu2mojTxH
 RKcnteZx5llPmDfObb9lPnknyf4UKCZBtkcktDG3acPcXTRXrRC1QPJxnLOrpjkOe9d140aZEOA
 zcQYL5hJxVknEDMXtI/5N4Cp6qm1CHBb5Im1JxVWsF1h9zNIGk57du+TPwD8BGYJadnlty8zuxx
 tmQ=
X-Received: by 2002:a05:600c:a00a:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49fc7b83237mr20725205e9.0.1789728594305; 
 Fri, 18 Sep 2026 03:49:54 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B829B006E521A2A508563A3.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:9b00:6e52:1a2a:5085:63a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3ae1fsm2975686f8f.8.2026.09.18.03.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:49:53 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Lu Yao <yaolu@kylinos.cn>
Cc: Igor Paunovic <royalnet026@gmail.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND] drm/amd/display: fix audio playing speed up on POLARIS12
Date: Fri, 18 Sep 2026 12:49:25 +0200
Message-ID: <20260918104925.33904-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251205074344.143063-1-yaolu@kylinos.cn>
References: <20251205074344.143063-1-yaolu@kylinos.cn>
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

Hi Lu Yao,

I hit the same bug on a Polaris10 (RX 580) with a TV at 3840x2160@60
in YCbCr 4:2:0, and your patch was the only fix I could find, thank
you for posting it.

I have sent a patch that fixes the DTO0 module for HDMI 4:2:0 on
DCE 11.2, 11.22 and 12.x, which should cover POLARIS12 too, and
leaves ACR (N/CTS) as it is:

https://lore.kernel.org/r/20260918100443.23694-1-royalnet026@gmail.com

I could only test Polaris10. If you still have the RX550, a test of
that patch on a tree without yours would help a lot.

An LLM helped me draft this mail.

Thanks,
Igor
