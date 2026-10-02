Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE97CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD9710EB02;
	Sun,  4 Oct 2026 17:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbxA9AFa";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615FD10E38E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:07:45 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so4513561b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790946465; x=1791551265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rxlktV5QmP9O8gmeTAM7mahiIUPXqUp0GbzhOcDZy1M=;
 b=SbxA9AFa2HsKSBCi5Xn5OPKrAXO3B6V5/xeVkkb4rlheP6t85mbbvcaLhlYwtpP7WS
 t1ourdkCa4DF8OuUm12CxQbVgjkFdG8XMjAFZsocT3qMRRwnuw5vcLlulkkiZkYWE6rj
 I5dWJHuBcIioj1Rd4Mu5cMoYJo5hYGD0dJHNadkAqIY4sVAXOIFKnG3Ovc1cKquirH26
 7WVaZYmXOAUZTMZx+m0AgJZvb4tmSK9AI0rFbSP1ituzLlfn5T54zCfB6M1bSjl/z5Jl
 +1zvFHnak92XJvLrQbo8XaNdTU6t2BKnmZ/XZCynUASGDpg3MnTZmIRsMk79pT3U7sQ8
 AHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790946465; x=1791551265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rxlktV5QmP9O8gmeTAM7mahiIUPXqUp0GbzhOcDZy1M=;
 b=UwoAsgXpHiO9IdslGU+bQaAeNICpTaCQ9r/8tZCYWBncEov4sjVoiNoybCZVCCh0wk
 9QhmZ1tgGI3DS21ntmdiboflQtgonX4KIzYCDGvK4MVJ6JUpyzgTApzbIxj7YNeZwYkW
 khUeUzGEnIpwjobv0s7U/IBOVDOoOcNyaeG/ugFGmCUGsIZC231GcMQhNqKo/4C50ET0
 msPsWkh2mo8Akn5TynYcx9u9CC91WuAkSX8OOf6HlY+3nldQPxJE6tn6VNdW5g3qPGZF
 +XUreEC0I8O6vuyxA9vjRSHpwCVHvSLU6/2rk+059QopXqPeozxqQGzwiOw/7S716mox
 45PA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYcdabc5L5iERVw2yd7uXJTHddBZAdoaH2zRuoHDhOOc38nwRiKIIqHKCf8wuSBx7nBvmxqaDJ0i4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBxpc0WbV02JIsFNIVRHwtQR7MZI4G49CB4tCw7gvag/beuckb
 knMMhqsVhAqE4lcRNCGMn6SMerEAgxGWEpumsHlMC1cwQGY3cXwQ3LFg
X-Gm-Gg: AYBFou3aLEteHYsTC8iaSm63UsftQDC5L38J0lPVQpsy0gf4Hqo9BP+nZwqgyhfX4IJ
 fec8iH4U2HprWQjff1BdLGuxscLY2Tvov91kPSeTSWCwMuYSDIKoUtkbvZPBSDPZll2IhWQoXQH
 HvRDPoB54Un56idhG8/aDHistj3QVwV09zHqUL52gwkEifEJ7kBbm4n2fwMdR2r+VnrL8zqmZr2
 VIdtvsExiMdpSa29dP1QdXRwCzav8d/NROeTlhEE0mLor+ZUDBQ4gy9skaFAZuLhKpBMB/R5/fX
 kzGY+u18djqA4ubuetEoXq+XsMsYJEP+5paQGoG8bH0He/3JExGAzNFy6fqbNnEjYccWSTDqA8b
 jxfuk91JsSDGWg19PpViOWsGtPw2C7Lse16xZZw5SrLr0FSrO5rCN66+YVOAiUEgi5O0//cYHHK
 5im9tSFdB6FOq7xXQPXi5bbxXFG8c0BF70s/7L/ONxPQkzWdAJidphL50pon/Mr0YUvvHGS0lmY
 08VOPKkeDEBpjc=
X-Received: by 2002:a05:6a00:9285:b0:874:706d:856a with SMTP id
 d2e1a72fcca58-88af7aade2bmr2356719b3a.27.1790946464816; 
 Fri, 02 Oct 2026 06:07:44 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0c3a4862sm853157b3a.32.2026.10.02.06.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:07:44 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Joonhoe Kim <26rote@gmail.com>, dri-devel@lists.freedesktop.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: stop all video interfaces before cleaning up
 a split encoder
Date: Fri,  2 Oct 2026 22:07:41 +0900
Message-ID: <20261002130741.50757-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260929131840.DF20C1F0089E@smtp.kernel.org>
References: <20260929130621.943-1-26rote@gmail.com>
 <20260929131840.DF20C1F0089E@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On Tue, 29 Sep 2026 13:18:40 +0000, sashiko-bot@kernel.org wrote:
> Could this result in the vsync being permanently missed, causing the wait
> to timeout?

Yes, the window is real; I did not hit it in 13 cycles, but nothing
prevents it. v2 stopped only the slave interfaces up front, and v3
follows Dmitry's suggestion and disables the slave before the master,
so no timing engine is stopped outside its own disable path:
https://lore.kernel.org/all/20261002130712.50612-1-26rote@gmail.com/

Thanks,
Joonhoe
