Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908E5CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5AF10E538;
	Sun,  4 Oct 2026 09:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdYP6UcO";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136B810E541
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 09:49:05 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-34bb8b31647so1577291eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791107344; x=1791712144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mb/xR5eRFy3O59ezfi15bus74aOTFozmcjdhnt60XY=;
 b=MdYP6UcOVx7+ELipUh+6YlkBZzSjrp8iiY0AkzbrYk2F+APGIz7GDVbjxx8CQaYMSp
 25CYPDdWbDf3CN+Il2lTewYSEdufLSYQ5DgP9/1H64Gm45NJC18OXG+4S7UMN0x91Avd
 SgzzcWlmXxBF61fR6bSA/J6vM98QEsWsj/b/1EX7BKINdOwNlw05azKLsAMSUDvAgviZ
 v0oaBUB7Gr27Nde3xA80XUJDiNkMJNfp8/j7u0PrVCpvalc8CIa4eDWema2Vwgcgsr6O
 pVZKjOJQ7gfKsQ10Sr8mrPnQ+MGIJNrZIr0Gq12RnM/K0Nkpghx9RbWKf6CT3y6Mkubr
 UeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791107344; x=1791712144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0mb/xR5eRFy3O59ezfi15bus74aOTFozmcjdhnt60XY=;
 b=HFV4VTswgCCFqvuLLrjuhhYwdMrlYGmeWM0dpbclaqmVMz2I6hdzXO3z6Z7oe5QDgO
 qfVCpSSbvVY5s2ggjvLeVOkxpzZugBXb5scOHCzIcG44N4YnWZgjP80AR9OBVcPmE3U+
 rGlzDGvS4WFWjlgG2zeGjcKNqTyjwC1EDxLodf88jv1Cc8cdd+0Oj/xSR0l2RlC+VX5z
 2NUCygqDCicN97+9KfM+dqDoIH0Qe9T5RLRTMcn+thZXerQ2PXzU879yqsPG3hb2wqsW
 TJVZLYqconNZ5+nvXiIxS4dafe4TpKj1K0LQpaoIvAdBiMuMTYN35GqN2c5BQkgp1T/R
 oK+w==
X-Gm-Message-State: AFuF++no58dcWmXOVCSLCHBJtjZaekqEsWLI6DvHJ0P/jIITeASSXlwP
 kgKjGjFQSFZmrEs9p8hM5+KQ6/lt6sHT6AAoS70yHOLrlpkzYAGtyT37
X-Gm-Gg: AYBFou0EtIYKoJ7huCNo028t7p5gLpbBV957/CROKHst5tFWvrL3LhO69dcFSzhcMyy
 UlgROemsjtvaM+MqT0beUFKPYMR53Q01tWx9DOGg+NhwWDZr4EpPKH+lMIMYIkhC013C6ojH0rh
 L6uChbStvU1E1nx2MuYnaJb7zblot3hldfaOO/tP9AQaYYCML0b1B0HERCmcnvpbp2L1uE6berK
 tj07UdhdWWPg0Q4lFoJl07fN9uqwqe1TE1OziecaQuMrqzTh0fSvsOohQ5/uH5utXrtqUmQ5JzH
 0y7LNhIcLlx9B59DR5VzCv9+U6KAbAMpF0V8lPTc1oT6vaZdfE1/3kdR8M3UedSCIHoed0xVcAP
 yYM2LixytaXWTKS01foRDUTTbmB69jWjwQhIoj1oJXRTkY2hrvqK/Pfj1cK0t/V4E9a1t/HI7uf
 GAuFZadAbiEdBuQP6hM9oN+YuqadexVW1kDwE3Ta59Md6D1y5AF/XQCUkm1IOA29JOQOnlWniNt
 L7ZB9cVflWHbnRyVjXy6Wo+VfEk6g4bb4ZrBZLhJ7mZTfpXfxN3LNMYCrHQm6tDB3z8NU26qRw1
 xBiKB5/e9VjPih9uUtvpHVWzIng5H1q0SHEs00qSl7XFOhWX6712UMCCNYg=
X-Received: by 2002:a05:701b:4552:10b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-151be1472c2mr5904637c88.0.1791107343946; 
 Sun, 04 Oct 2026 02:49:03 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fc39a7d1sm11321647c88.3.2026.10.04.02.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:49:03 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: look up shmem folios by index for writeback
Date: Sun,  4 Oct 2026 17:49:00 +0800
Message-ID: <20261004094900.174818-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002091439.59C611F00899@smtp.kernel.org>
References: <20261002073107.2209644-1-matthias.goergens@gmail.com>
 <20261002091439.59C611F00899@smtp.kernel.org>
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

Thanks, good catch.  v2 looks the folios up in batches with
filemap_get_folios() and calls cond_resched() between batches:
https://lore.kernel.org/all/20261004094827.174193-1-matthias.goergens@gmail.com/
