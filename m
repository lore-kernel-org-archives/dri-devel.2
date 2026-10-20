Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B074606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YbW8622A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B5310FCE1;
	Wed, 21 Oct 2026 08:53:02 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3228610E9C5
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:24:29 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e915887d9dso17713835ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792502669; x=1793107469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=98Oxvm3jikEXsJUM/zp3eKNHFF44g7Q5zCxMHJr/tPw=;
 b=YbW8622AwHfRyPFmsvkv0GJZ5zAv4/J/5zhD0kFeb0N8qQ8gm5iz09yDccGwouOlQ4
 LFrfgifFOrWLdRG59Bh4cs4z/hAJyZp025cQamREzXt6Pwn83iKjVuykkgXtSQlkImrB
 pCCG5q6Bz+iYHwrfo5JiwIQ4PnqTDgoWOMR49iJOVcD73PFM8PBnof2t3+ZnLnL1VT0q
 U62EVGK+9bazfmCxZ8qbax8RURGoSmbIJtvfb3nbyRyFAH4hEBYEmN8PCcrgNMzviofN
 bNrE9mNQ4t9Bt3XN7C6vgjvBBbT/RKLw4efAPOR18aIGC1W8GPzdLyVMgeG2OiXyOMqi
 XVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792502669; x=1793107469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=98Oxvm3jikEXsJUM/zp3eKNHFF44g7Q5zCxMHJr/tPw=;
 b=VkDtQX7pLmoHRDMyvYFsiOvMevJyN/bdsY1JmUzUcqDjiyiEPHn7hy86M9Doj7GmCw
 xtmiA9nMEGwoyNTy1Y3NQHixk+c53E4bDuMxjVjoVRbqutJNKulfBrQYhX9Cd/qnqvOc
 lP2UyiftqRYyn+H2YSspoBWceNyjA0DwEusx3OCjLaEQ9f4bkiW8EmUdEkvMMdFfU6X6
 er0oC5a+L8PAEbkf2A9BFyWz3PAOTYSD95VyZqCpMolOrnUz8hM/aZCKjAK7v4orMT/7
 q4vPfJp41Oy6qP1nvWhY+MG3XfQGscKLt2XGaphUqgE/I80alYBN66ab0EaljKnssxm/
 huhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTH8Wf3jztXq8lV0kjpk+6/h//UHcY8T+dWQixS/jqkdk/Gx48RUZc+RUHcRSihM2A3++bKByU+NQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTZMbiUgvMOYM/dmo/PR8GX7TvsvC4Gsjj4P67fofdbPjjPFYS
 L+XvoK3XtzmUrP6CkbE6Fnfx/zv+vkjHvm6M5c/A6L9sNb0QDFAT3z+j
X-Gm-Gg: AYBFou377KjamG2QZFqJZaMMtSkU9NTQ85af1bQvJoKU6zRsa51srnJS4P5Ncg80OK9
 NmxWWsa4FCyEb0SxWE27zllp7n0YxaE4Mw5vIE06JDq6uiVs7DGgZc8Vhy3XFqdaet4AffqMvKb
 +7953OWPJeo1nVowFRGVhvgP6v2awu1ES9Onpe3jZWfAzmZOztttMu6NfpFaKYlV4KHm31Yd9wK
 yD99+OMP5+Vm/bGuo6nZaqTteAj9dlMTu04vXwJvzf4n+rnXN7uO+Xmc3qwOMCoyfP0SMb4mTAL
 U+lY7z9EzwtFGJecz8o04ld/QTfx7freME06LtVuHZBNTM023xyGmcCKzPLEO66VteEas7nN0Rk
 RhIOmPA4mlEyBXJLduelrfu4guojj0SAINyONAencIU6Uq2Rx6b4WVzKjIV4Ngdq0K8LHxbZnO4
 uY00naTkjXAXbg0j92cSGjWioOyH3V6jaZmQ8aI+0MM0OrMkXb8YMIfgHGBEYsFxHiIP/K4pzPV
 i0uyOGiZ9WakfRUTlLlYg8f
X-Received: by 2002:a17:903:3585:b0:2e2:e0f8:e57c with SMTP id
 d9443c01a7336-2e9a6d2b9a8mr88276605ad.70.1792502668600; 
 Tue, 20 Oct 2026 06:24:28 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea1fd8a55asm7010935ad.29.2026.10.20.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:24:27 -0700 (PDT)
From: joonhoekim <26rote@gmail.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Joonhoe Kim <26rote@gmail.com>, Arpit Saini <arpit.saini@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
Date: Tue, 20 Oct 2026 22:24:14 +0900
Message-ID: <20261020132424.983-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179241542813.315541.11037007061803544238@mail.ustc.edu.cn>
References: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
 <20261016125036.1069-1-26rote@gmail.com>
 <179241542813.315541.11037007061803544238@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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

From: Joonhoe Kim <26rote@gmail.com>

On Mon, Oct 19, 2026 at 09:10:28PM +0800, Qianhui Xu wrote:
> Question: with your runtime-callback variant, does dispcc end up suspended
> after DPMS off, and does the panel still come back on DPMS on?

Yes to both, on SM8850 with v7.3-rc4. With the display off and the
system awake:

  current code and Arpit's patch: disp_cc_mdss_ahb_clk prepared twice,
                                  dispcc runtime active, MMCX on
  prepare only in the PHY runtime callbacks: prepare count 0,
                                  dispcc runtime suspended, MMCX off

The panel came back on every one of 30 DPMS off/on cycles with that
variant. I repeated it today with the same variant on v7.3-rc4,
blanking both outputs from the compositor, with nothing on
DisplayPort and with four different sinks (a 4K TV and monitors at
5120x2160, 2560x1600 and 1920x2400):

  nothing on DP: DPU, both DSI and their PHYs, the DP controller, MDSS
                 and dispcc all runtime suspended,
                 disp_cc_mdss_ahb_clk enable=0 prepare=0
  sink on DP:    DPU, DSI and PHYs suspended, but the DP controller,
                 MDSS and dispcc stay runtime active,
                 disp_cc_mdss_ahb_clk enable=2 prepare=2

So here the remaining dispcc reference comes from the DP side while a
sink is connected, and the display controller does not keep the MDP
clock when blanked. This tree carries my DP patch that holds one
runtime PM reference per plugged sink, so the DP part may differ from
mainline.

Arpit, thanks for confirming it is prepare=1 with enable=0 on your
board during s2idle; that matches what I see. I could not measure a
difference from it in s2idle (CX collapse counts were the same in all
three cases), only in the display-off, system-awake case above.

Thanks,
Joonhoe Kim
