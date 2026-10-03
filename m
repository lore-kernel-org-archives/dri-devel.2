Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB80DCA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA5510EACD;
	Sun,  4 Oct 2026 17:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D/wgO1Nb";
	dkim-atps=neutral
Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com
 [74.125.229.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6946910E954
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 19:45:56 +0000 (UTC)
Received: by mail-dl2-f40.google.com with SMTP id
 a92af1059eb24-14c96a4b7c7so67221c88.2
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791056755; x=1791661555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ISE+mo7r1uUwttxvds437VY6sRXQ56bmLHvCs31sIMg=;
 b=D/wgO1Nb4Skfse6GPaEDtj1hjVqiVHC7pJ0royTAFEBTKs67tDwV7ZVxwlRPbU2o8H
 6X0r1tAapIOlrDzh2fC/n08TMOJHxupZFe14RaQZMOrXTFqjVLz28DqhZfEaeXgYjvps
 +x3wCLqAin8LGlhuM6e0VPmagFD0lyALsEn1cDzrZ0HnpYOdexO8a6dyzpudWndKl6Y9
 94LE8WKe0abR/uQgZPkBo06LekaWUBS+2pPh1eF5jp5pQ8bwwXhgt/tigQrNO2956rUn
 on5DpzzGWbrw0hOAftWOM8IBblGEfDOHcrGEwyEzRpJt+SzTVJLWjYUNyeIzu3JzlYni
 CerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791056755; x=1791661555;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ISE+mo7r1uUwttxvds437VY6sRXQ56bmLHvCs31sIMg=;
 b=jMu3DJRIzUXBPO99M7Lhyj8mRmuJgyWxbOyAcbKKZIvnI0JZAIpPr47bD8D+upkoZy
 oVApOTxtdroePcp67Lo4FW7by58Uno621VqCnZxJySnvy3jaaNaAdFQiAFp5hmLvwgVU
 lAxlmA+K8YoFAfaK2HP31Z2Q1QjrPvepHjtVtbfgyPlszcjsnV4C5m/0U8EBFOLV1tbi
 CsyEdgmak+3eyKxyb6Lx6jKOXe5SMrphbS4QCztqdJ/XgsZ6/ClB19N9ALYyuggIxj8k
 nuXnRFw2ywxwZh2vh9ZT67eZSphhrEOrFDw+yapSQgJnb3GhzMSflnX57pt6gyNkoua6
 6zXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcvOBGQanwHe32KnqdSSW89xEPVG7iCjZT6Fs06pJ1iAA7HKQpUI6MzwPCZ9+whtVPQBNR7R8sykU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mLpzdqfVmGTUVtp6vBvkS19n8BugK2v3XyzOW9pw4lj4/ZP6K1
 9PlU8bYpE50MyvphYoRXjCKkatagHcyl4QNR3gW0PHAFiYtF0nMKhz9G
X-Gm-Gg: AYBFou12oG7szzSOMGT6B6Aa3KxR+/hKx6Huv+V5RB2l4C5xY6m9NcpdywS4TmgAUjJ
 QD7QrAdmOEoMQ1lP5746uvg+LL3RLoQ6yz6qQaefGove/kS6EMOP49yxUmgI2QRdfjMjdzzkHUz
 wSWKhIMIg2uzhQUiJmW6UpyjbwiHATIBnwawn4EBnJz1enIJ4IFHKcExqKtlwBN5FhpbX4/4mlh
 p5QG0+xWpyH3RFnkfHi43YcS6xehknOY05MrzwFVpd9nSkD6pScDCYfG6huM0mdWJJZAbY2umAa
 vyWxBtjuyrxXBBOtzxt7OBQDO6K1Oey4/rziRTdZ20oPwuXTQD6ExR2hHnKLhuMGJL40VVItap3
 VICTBi8mVq/JlX1WV6nB0IcU7uwFD+uJcP+Mz84SSq4EoJd5rtUHF4bfy5BAmJm68iAnloObJOG
 pLOb7vc5gxrsyem229HFLi5oQt11zdsaTj3p9XNdEMHxMRfUrs24h0UfuHxwTiypY3XKtOkQyix
 UMq+TsSBA4Sk8uxdYO6rKDpQaC14ILGI8cCrKqG7Be+yfmzAmzHsTT5NcW13kGztMB2CUPDGja8
 tePcu8dT6phLuXsuhRA=
X-Received: by 2002:a05:7022:6896:b0:147:d430:7322 with SMTP id
 a92af1059eb24-14f5a646964mr15623345c88.1.1791056755448; 
 Sat, 03 Oct 2026 12:45:55 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f660f1sm17840932eec.13.2026.10.03.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 12:45:54 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v1 2/4] drm/xe/mcr: Sanitize steering semaphore on GT
 resume
Date: Sun,  4 Oct 2026 01:15:48 +0530
Message-ID: <20261003194548.14603-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260722004654.744249-3-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-3-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 21 Jul 2026 21:46:52 -0300, Tales A. Mendonça wrote:
> Port that to xe: release the steering semaphore at the start of
> xe_gt_resume(), before the first MCR access performed by
> do_gt_restart().

Tested on an ARL-H 7d51 (Lenovo Yoga Pro 7 14IAH10). Without this
patch, 7.2.8 hits the drm_WARN_ON_ONCE in mcr_lock() on the first
s2idle resume of every boot, lid open or closed.

With this patch on the same 7.2.8 build, without 1/4, the first
resume no longer warns. Later resumes can't show the _ONCE WARN
anyway, but a debug read of STEER_SEMAPHORE just before the release
found GT1's semaphore held on both resumes of that boot and GT0's
free, so the release is what fixes it. xe_gt_resume() already holds
XE_FORCEWAKE_ALL at that point, so the forcewake in 1/4 isn't needed
for this WARN.

Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
