Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D36CD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C928010E147;
	Wed, 20 May 2026 07:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+7kTM84";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A25210E3E2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:47:24 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5aa2691db86so150638e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779223643; x=1779828443; darn=lists.freedesktop.org;
 h=cc:to:from:subject:content-transfer-encoding:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LR89Bh05We7HFvg+mnAf2BUA0RHCXBN6u6SdoMhxs8Y=;
 b=R+7kTM84kHkkhG0zFSfCN004yAiq3eDGMsgmfxHJ+969CT8vJC9l5QNMyGTcrrgrab
 5WtVVafHP5ukyEdZV5FYudX/2ZbrjLr9GLH8zOaJvHvy+1HlRZ21EVnrcD2p0ZrX2cB0
 BoSpH151K0yVjEMSiurLMgvIpj3XoVM7NJr3taoDX20fNCjL5GZSgq/GCow9G9CraTk3
 MGV/5OxnuEhbx1uuXu2XMhEIVt80HiTBWe+6ka/HPTigtxRcO/obGy774oneJurG1haB
 KVwbjuvNwkjRAbOL14RmSDxGbrAr8j5qWP8fWH3pjf8HzRDoy7e2J+44YwH1mBhGyU1a
 cNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223643; x=1779828443;
 h=cc:to:from:subject:content-transfer-encoding:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LR89Bh05We7HFvg+mnAf2BUA0RHCXBN6u6SdoMhxs8Y=;
 b=Np4Sbt9fPakpHU3yV7IgRYJsfTnN6gOQvlw9M7urZ+oYx8loSigpHQott4ME1d52rg
 MH5LtY+U1OBNIDRsXJgTitB/qY3ks0Wh4xzZCFEkucjLL41N5hdQKYjVFbriu0GIyMO1
 7PJg5i4szn2IvwXjEdjwgqazQhsf0mQu+cTe1WVfvwnCPCq1cPj08wftabfYw64q6ij1
 xfbPfsSzFoAoSxfWIdiLr0wYGwpGlp9kW4xQMS+f//i/HaPcxP44GGoXs8Kw7jLfayZp
 SWLebamkAmFffE5fiVZ0SySCCeZYeio5u4JBa03P21OS5OykJwjB8vZre28R7Lk5F0xB
 0d7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nD/5mmT+YwVsr2Lb3LZqYrYdoKkHwYAeBZ6y7ZolmVLvqcmnjKyhHFj8KStCUK/Czfk9/gI7zmV4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkPdG2oht/d/qXPmZV9/geH7SL/721lUa0f/cGPGN45kfiRJSj
 KgMZSzGVyult+5fjj2OjQpaCRfwqZ1XV/ThzbdFPAxAolXYpIOXsocJFGdXyQf8R
X-Gm-Gg: Acq92OE3JOnr6UTfpxRJ7dUDK17ASquNUBleSJJPOH139MFfg1wFlNTkXGPtA3VYWyU
 Po7DS+3yM8YVIV4R7o1cQOnvsOI4bX1V5/50bQlXCQ/vCfTivD/hu5hDzRfRa6hcbJ2xLQonC/x
 s8UBfTqB1+3lPmft7OfLqik4AzpDLWoxjp5m5pzTz2S4v5U7pf9ycYQS6YZU22sJFfdMSXPWAa3
 K6jcengqf/cxRIrMEuGHoRVUFFCAIBqMGU8qJiasUWUl+e/fRl04Qy/3b51AWk6Ta32XYZwaVRN
 kZPZlrOowU41DGT1mK2+h34NzMrnVVvq0fOL+mxf21PtXMYxufAVVgGq9UZIhAYawEvsIY6LxH6
 HJ7jk8T4EO0FY0nW0eRSwGzdLRrMsy76bngjFzH9Lo9u690T/auAZHqg/oNf02EslMAyAChtKUJ
 3Azeufa/EjnUs4tOEQl4j7NupmR4N/F/1UhUcTYP+PcowqNpdJl8sFkw+0nf+SMZsD9A==
X-Received: by 2002:a05:6512:3e14:b0:5a8:73c2:c906 with SMTP id
 2adb3069b0e04-5aa0e73f4a8mr6406633e87.8.1779223642568; 
 Tue, 19 May 2026 13:47:22 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-218-151.rev.dnainternet.fi.
 [87.92.218.151]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164c4b73sm4363775e87.55.2026.05.19.13.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:47:22 -0700 (PDT)
Message-ID: <6a0ccc5a.1f370a67.11b6d4.de1b@mx.google.com>
Date: Tue, 19 May 2026 13:47:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: [PATCH RFC] accel/ivpu: set IPC data_size to per-message payload size
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: maciej.falkowski@linux.intel.com
Cc: karol.wachowski@linux.intel.com, dri-devel@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

SGkgTWFjaWVqLCBLYXJvbCwKCkkgbm90aWNlZCB0aGUgVE9ETyBhdCBpdnB1X2lwYy5jOjEwMCBy
ZWdhcmRpbmcgc2V0dGluZyBkYXRhX3NpemUgdG8gdGhlCmFjdHVhbCBKU00gbWVzc2FnZSBzaXpl
IHJhdGhlciB0aGFuIHNpemVvZihmdWxsIHVuaW9uKS4gSSdkIGxpa2UgdG8gd29yawpvbiB0aGlz
LgoKTXkgcHJvcG9zZWQgYXBwcm9hY2g6IGFkZCBhIHUzMiBtc2dfc2l6ZSBwYXJhbWV0ZXIgdG8g
aXZwdV9pcGNfc2VuZCgpIGFuZAppdnB1X2lwY190eF9wcmVwYXJlKCksIHBhc3Npbmcgb2Zmc2V0
b2Yoc3RydWN0IHZwdV9qc21fbXNnLCBwYXlsb2FkKSArCnNpemVvZigpIG9mIHRoZSBzcGVjaWZp
YyBwYXlsb2FkIGZyb20gZWFjaCBjYWxsIHNpdGUgaW4gaXZwdV9qc21fbXNnLmMuCgpCZWZvcmUg
cHJvY2VlZGluZyAtLSBpcyB0aGVyZSBhIGZpcm13YXJlIGNvbXBhdGliaWxpdHkgY29uc3RyYWlu
dCB0aGF0CmludGVudGlvbmFsbHkga2VwdCB0aGlzIGF0IHNpemVvZihzdHJ1Y3QgdnB1X2pzbV9t
c2cpPyBBbmQgaXMgdGhpcyB0aGUKcmlnaHQgdHJlZSAoZHJtL21pc2Mva2VybmVsKSBmb3IgdGhp
cyBjaGFuZ2U/CgpCYWNrZ3JvdW5kOiBJJ20gYSBMaW51eCBrZXJuZWwgY29udHJpYnV0b3IgKElJ
Ty9BU29DL1NDU0kgcGF0Y2hlcwp1cHN0cmVhbSkgaW50ZXJlc3RlZCBpbiB0aGUgYWNjZWwvTlBV
IHN1YnN5c3RlbS4KClJlZ2FyZHMsCk1kIFNob2ZpcXVsIElzbGFtCg==
