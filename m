Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B4CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7D010E491;
	Mon, 22 Jun 2026 04:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hg+MtQwM";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4F310E492
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:47:01 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-9157b94a07aso411905185a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 21:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782103620; cv=none;
 d=google.com; s=arc-20240605;
 b=kuvThHgxkQoTPGSjZMq3YYe1hWvff3qfU3mzpzWjaOXCqZgqqbhmcnxJxjCA9/zecC
 ARhrC3PVDOKQVVguDBCDem3EcZ8RZlOcS66YW6livaxkcekj3hslOhXj9XQ8uwNLMhGZ
 K6b/XqctCnfhGoOXTk9MyQk6rrIzuH+iAHytLQt9v0zizi5knA7hJPJF5AUMAwGfMAxd
 hEj+oppcucETD3u/UBegmAOrDr5tHnoXneZkYQ4BqZXp80i7zUVPQXcDz6c1LrxYNsm7
 SZrf2fc3tjkbVIah5l9C2CQbUVBDEo7LkrNaefiZajzsmHV2koh+vENpFz53YhLbyUzV
 f59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=8g3hqqz068tHp9tVo2PYj7hm9aO3fiSU+NWoJElXV4Y=;
 fh=IWBpSp3bPltG+kMtbte35VU6L0O2FhvwhS4fLstqXcY=;
 b=MLelmKi/K2LeUcAIILpM5wytq2/zCrJI9pu/uJJRIk1Kj7KW/zGfACbiwTV1oyMirZ
 aSBSTcEHXhIWVEQcvmMXYTp6/uGZeGxNpnVfmYSTDSQGd84fpfvCCSMt9v4Xrk6Z2q3I
 TyMtmAULDtRUhrsPjTwQo/VUXixIwjP3yCsLgBP4Qsg6WvFRLYUpAewTKCzj0/19HuOB
 PoWv4cyZwyIkO4vniGvG7VWRjy4Fm9NNiTYxjFhL0hQetlIkJv0DyZG+XxNiHvndW40G
 /TnX5Rd7UjnjR4GS3AMmaa/V28r+rO2JG0XF3XNrqkhwR8XIynn2XETpBsxixatX2gS2
 qzmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782103620; x=1782708420; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8g3hqqz068tHp9tVo2PYj7hm9aO3fiSU+NWoJElXV4Y=;
 b=Hg+MtQwMLFmyJLhZz8/NSF1mz5OQ9WWwD0KIiIG9tV5X/6Sv02ylIp5LgZnsP6kXBa
 yyT0hlm63U550paNVQStwxn+Ooxj2wNKv0yW4fIf9lIFA2kj8C6oR9Q6OGbaUrZhEB3i
 FZruh8Te7Z33JYycO/dFlOdcQDQqNY/FOLE1NHrkJNS0YrOctRds/3kOu2b1Kg4O/hh0
 kl3hcEYbmxoa5qDKQDcOJbcnpefSIJ3FF8eD6842HPaks+H5v3RMLCdxN4K/6HF4qjxX
 EGmE4gKriKv6lcIE6bfMZoQPS4ugIlZ5nuAK/eGWG5+rlbNLlHAd7kzGkUcFmoC2RYJY
 hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782103620; x=1782708420;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8g3hqqz068tHp9tVo2PYj7hm9aO3fiSU+NWoJElXV4Y=;
 b=Uosl9CSdzCSM6pig6Z//xxFujmn/Us1TeMGx90GFpX6L5ObKr4mqnb9Xmqfbta2Q2U
 1dRizntfxKYNQQXd3i/qwp5mSILS/ayq6Mp4NGV8WnY7EXpzhJFESoClMZY8i81ERXdz
 lLR78hMPE6i7td8gDy4TXMEZcXcuowzV+dFBubr+VbemI0RDyfPENk0IH1sNOCP3ebEx
 h9W2DtDmUVSMNGiR/Akv/xt4EBZ8j04h4+b+kNp40ruMxxXpgB5v8CNY42hIt4PNwx8M
 OMeXetZ0DPip4NKhi4P5KRxcMrow7JqnhHHkd15dGLusjiko6pKfOFJJFrPESvJi8C7a
 uWkA==
X-Gm-Message-State: AOJu0YxPNCEYj3Iypt3CU7nBbZgNsN7+ML+Duoe5LWwh2uxbruXrIYbF
 sBmCNWFPmV40GR2phhYND8grJDpRGkI59wtQ67DvmfUlJXAi69jXp6xvcFzrOMggdDFy/PSHJtl
 QyLE6zQi2y4QnD+2oPAhV7WwnYrjvviI=
X-Gm-Gg: AfdE7cmajszdn94k+4SenNVtJMcMA9ieB9EPv4OhVTAzZJMt61YezF82lffECsrS87A
 CnrtQa6bPBm6wdTiItAXmp4sWjUyNGUCtY08N1Ii75wtjluSxBC1DHa3ZoItoR+tzSdGmS4Swpb
 5Cm15smj7W64dMJj4s0e3tlIlR6brpeGWICgxkbjpYON8IbxdHHKgOcn2vwQbZrjU4BJcZOYtil
 IuRZnOD7BgpZTnO8HZvxxSPwIrpCi5hXSXFNXz4CDiNaOU55hW/WJ6hAn3ZX0UIh89gbNe1EKC3
 o6CLKHPZIT7lRCGpoko3WAK7HU6uuGE9u+9vBvPszmp7bpk0zLSZnq8RGw==
X-Received: by 2002:a05:620a:290c:b0:915:b9f6:71a2 with SMTP id
 af79cd13be357-920d4fec71amr1839799585a.48.1782103620280; Sun, 21 Jun 2026
 21:47:00 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 22 Jun 2026 14:46:48 +1000
X-Gm-Features: AVVi8Ce2wb8elBNaTluaukjjB1Q3YO-s0ZlkjhsbMmTV2qjA0IBiwLBBoyLdiMk
Message-ID: <CAPM=9txxjsBdQA6HBmUgkT31bNzMizkEzqksA5GJq=n9j+txOA@mail.gmail.com>
Subject: kfd conflict in drm-tip needs proper solution
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Yongqiang Sun <Yongqiang.Sun@amd.com>, 
 Andrew Martin <andrew.martin@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

I merged branches this morning and hit a conflict between

commit 1142738572ef3fcf8b169f1c48d94b4a71cc2d97
Author: Andrew Martin <andrew.martin@amd.com>
Date:   Thu May 28 10:32:52 2026 -0400

    drm/amdkfd: Fix SMI event PID reporting for containers

and

3b347d011773d147b62f84ec60a7824629148be2
Author: Yongqiang Sun <Yongqiang.Sun@amd.com>
Date:   Wed May 27 09:50:47 2026 -0400

    drm/amdkfd: fix SMI event cross-process information leak

In drm-tip right now I've had to effectively revert the latter as it
is not possible to pass a pid/tgid to kfd_smi_event_add anymore.

Please figure this out so we can resolve it in drm-tip properly.

Thanks,
Dave.
