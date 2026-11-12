Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66C606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVWA6cCj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9ED10FECA;
	Thu, 12 Nov 2026 00:42:20 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A925110E0AE
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:42:13 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so583052366b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:42:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794444132; cv=none;
 d=google.com; s=arc-20260327;
 b=UA81jRLtTv2B0F+lrOsjE/UNGEJuhxrq6njVzwXud+QYHn6qn8N2dLOXkg2ruCubzT
 /fTFukJnT4Xku1VrhRxnQAyZEga+Td8hA3pbPmpl2zNqhNW5pift1SvyKEJ+6G/zSQrq
 huq497+pRKno4Qhtkvct90K08guAIcI2q+V4oeQ8OBhzs3zcUL/0msLHbDZabcKVyA+A
 hthSggkqkJ2G4bw0PsWDg7T1bpRzWKHKoReap3toCUpmQUb5k1mzJFCt+cU5NywId1Zj
 AKA4hgyAj5SO0+7pb7xewbqGe4XuPp+2+fwYwxU5VjIEvDblmILNLqWGcrYCTl5BLkGA
 iCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kq3NSWfOyC3uG3oyFoGrHxCSmni+j7sv5zmuFro8G2s=;
 fh=NPwQ53/P0mMeP6OySNqRUQ2IUbcUtK/Nu/8O5UsGcuo=;
 b=e7pUl2bb+yPAPh/y8rZiICRXSVOVTuIKwTcCFNxPxIUYSwfL1ECwBQMXljXDZ5Oi+H
 S6z4MXdbNrhm96Fm9cAzfDk10/2ryr5lcl30Ty8JeVWuQXu8NCi2WO6KfZ2QXfRqcmjx
 ZlaBy+djkU3LQiw2FcV7NvSXXJ26+dTkxlYA80U/aC9Pmfr7LSoumuZo2C0cPmNti6r6
 uoCbkW367NMWG3R2MKwHdEAISLgN65Kq+6Mdv/2XtWfKCh27id2km39tiJzxAxeYJ/pQ
 XsLofvcxHZmjGcYnIltL/u4Lhcsrgu0PA2AXmRb/VaSdo7jf1T/4UZZfonTYgdn3vJiO
 dJAw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794444132; x=1795048932; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kq3NSWfOyC3uG3oyFoGrHxCSmni+j7sv5zmuFro8G2s=;
 b=YVWA6cCjgWReZgeRUT6kHLynwi8trfs//gdGy5ZVxdpRNNQqzeacUPElxHT+FIdP2s
 cllYRgWh/T5mCiATQNfBQJO8cDTNUYPy3o7KYrb6tngoHIwRtC2DVWKHZUTHPQaF4K//
 A/7NAdbAWQHF40sOSNo6/B1/HXwyeNqBzVZ9/XgXvdPkB+JPnkyuLyBkneFf42fc92vP
 xPHPoIekbJdjScEKWaT/Hoal0Xtd39ZNqHMAB/U7Ck8hn6nVEe1FM1JLDYkOu1xV4ozx
 c5uGm4vfOUeBmj0qYVu/LBl1O2T77y9wQP7A5MRxNKgw21d2FS1EVgFS0BQlXdi54yUD
 DIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794444132; x=1795048932;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kq3NSWfOyC3uG3oyFoGrHxCSmni+j7sv5zmuFro8G2s=;
 b=ymAPG63cDIn5HJ7hzbDzrOTPm/zLOy8o0JFKGv0kBnWYSSH+BksOGWzxuYEXjzn4s8
 tZhJktaDF0ut3gjR2z3yHf2xOlnCPG8rVmXFO3t85oIaulCFNd5qG9Ofz+79qZdW2meI
 8lV5+77eYHpoD5YRiv6GkbCdA22FgJx1Fjlrqv+bRwHSgYSKxtgXblCTWwLB4WxoUnZb
 jtmius0Y8JBeXdaK3TZSWHKFuacPX4dCLFte5Vh6jAkIOYEO3+61Rk4C6fLUvf1D1aEi
 KdLm02v6pZyaiJLl9SHPVs/02UWyFouDR3h2rGlTb3htiirQqUqrB41V3OHglJWcTg/j
 WMvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGwp/jDJApysZ0NxPClqVL0Mn89ut1hG0kzcVwoZa5RjLpzRSrWOnmHCZAG9Ri+847RRwFFM4xACHQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dtryzjIgvauGtUass39PrwL1Fv+Z6KT/3h2EELER8pvoDr4rC
 24uJXlEm5et+xRXFFicrPFA454kkNxwGuDA8ipA0yVZHJePBuWFmt0fg66y4/RHuc/jrUhDJz9l
 brffjwWOYQtb7aqRDNFk9Y+BiR9NWxJVp9flc0GU2ww==
X-Gm-Gg: AYBFou0GZOiWee1YFWtPuPkpnC8Kply+tM0mO/UmZk5x92axMXxlUKqlSM4XaGAA6z1
 Qt/OTTSxc5tjbXHFayLHOCdrd5xqfTWCRXGNEr98Htw2ffmxilAKXKe3PHtcNhChHTf0bwagYvv
 oUFhnQkUdPzifTgJF+DMNpnET9cbm5GvZyVWjWNjx2uy2DSD3MqoiHTPdj7MoYozpYrYa9/LGuZ
 pCHl78Ge4AJbmyH7/6eA2gjJLGOaILntX6+tfJ0gwZLkjyGyoaaVooNUP1e9AOZEUHmr4RNbot/
 w+QErgDRHbgHCVuOFKlZiM9c11U/23zTTK9tWo0sr2bapDFH761D/5Gl/+VDNAh0ppLY6S8VWuX
 /7Kg/ni1HU3deR9dNuZ7yLdep19HeoqO5ZsHry0Q=
X-Received: by 2002:a17:907:da2:b0:c4d:167d:dcee with SMTP id
 a640c23a62f3a-c5066b7cdb6mr299079666b.40.1794444131884; Wed, 11 Nov 2026
 16:42:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
 <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
 <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
 <CAFGNeahpZCnGHy8iC0FS_oALcsU7YrW6afxOe=xJi+407Q0MVQ@mail.gmail.com>
 <CAMeQTsbJ3UimZVpY7NO3deNrvc5uHE0qCaUHJ9j=XK99PBhsJA@mail.gmail.com>
 <CAFGNeag2+SXcYtYDBcLw_F35j1gTNdjLHc96sab0RRA9zY9OaQ@mail.gmail.com>
In-Reply-To: <CAFGNeag2+SXcYtYDBcLw_F35j1gTNdjLHc96sab0RRA9zY9OaQ@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Wed, 11 Nov 2026 21:42:00 -0300
X-Gm-Features: AclHuK_-YwRCmX2__9S_jSLIPgfO5XRr0Nn9Ce1WiPaGFRR5j4oTmtZTQJrPijc
Message-ID: <CAFGNeah7oj4scrBXh6fB2OPfZMsqhO96TkPzjNHpRLiOoC-cfA@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I'm finishing up the first reMESA beta and have been thinking about
compatibility with other Poulsbo machines

So far, I've only tested the SGX535 rendering path on my Dell Mini 12,
since it's the only Poulsbo machine I have

Since I'm keeping it inside gma500, I'm assuming most of the BIOS and
display differences between machines are already handled by the
existing driver

Is there anything platform-specific I should watch out for when
enabling SGX rendering on other Poulsbo systems?

I'd rather catch any obvious issues before releasing the beta

ty,
Gabriel
