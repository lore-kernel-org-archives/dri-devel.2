Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC29DCD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDD810EF35;
	Wed, 20 May 2026 07:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+pzgvd6";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E9910EE76
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:55:12 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5a88de2b52eso5628289e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779224111; x=1779828911; darn=lists.freedesktop.org;
 h=cc:to:from:subject:content-transfer-encoding:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Lt/k2Ud5dJ2NnlKJ9OANVMav9CeJNFfw28nFfLeRsqA=;
 b=U+pzgvd6zOq2Hb8WQm455mm1dEG3HzeGC3lTkuDKX+0p/FKl7wBhG35rQSBx61tDd9
 AjDLkCnc/ZCJRv6dvGjs//08aZuXYRRHro5seSJbzcIRVgMMxF0MF0oeUcOHPa3CV4fC
 eF+nogEzIc++GZEWKw/Zby9nRE/XlBDczjfiVYOGDwI7rlXk1iEE9twaxqIduJVOhsBe
 W84+3fqC0LWadPnX1VvQO2UDLS3yNiVapd462wOax/ZcVV4OwLShMHqVW/9MZsK5wqzJ
 Vbni5r/sFttjRhlUG6LL6aTakRxv7ulV/PGWXlUZPOfF8EfMWvfk70SPtprowBT+DPDW
 4lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779224111; x=1779828911;
 h=cc:to:from:subject:content-transfer-encoding:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt/k2Ud5dJ2NnlKJ9OANVMav9CeJNFfw28nFfLeRsqA=;
 b=M2j71R3nqNg/JitfKwSoREVrG1dSCW/5a35PCo4JqeV50110n3T6Qa/OfBKL7DHElM
 qAPiFc2KiaoNyDLkDts8SREWC1ZStXPZkZn1dbpAhFaKkPd2hDjIhtfVi0mVQ3+T8g3n
 TqD6uwM88b4JAszEyF9n+FOe/HktTgutx6wvPtfRtbxeYl8MTDQqKoKoC5ljy2DG2CVU
 KOcEfwJR+nMmqHSHK+1SiotGByuJrhMnMCkx7I/JvDtt3LpTH050R+EHkQkWhA2PLC4D
 XDj5qUzMK/uNZ5lCwauBFfw/7m8FyMQaPm/c9zDZcfBPlo6fDMlWAgZp/rKlxZDvCXVC
 32Lw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Uf9QCID4yeXEeT6OtZcXserQxG674Epb/rMWDEtAEnjJWJ/C5fFL0idxP4/mrFK3N9ol8NybBWv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwCGXX90F9plQ3Gk+65XGI2/gaJHak73ImIL6lExS4jOaIi1vH
 wHpIQ6O3JFQcMxKgOpty1QyeIGq8pDtr2NP+l5HKLSp1yb9zzKIKoKdX
X-Gm-Gg: Acq92OF5DQcHMP8vD5tiPBdb53AqVW57C3fGx6rND2Nlz0jCIcnwEqcnC7dH97kyS31
 yqfGv0rustsdl/BqDVI5J6Z+Nom04LLik3ipJ8mshwCglAb5xMGMI1l9TXQVHcivznvjKZAY6YN
 q434S5SGxP1zp1mgfi/wQOqLJOttT1StrPeq7ZnxG0lDZYKULZAedJf7rP2W4XX6UalW3kG70tT
 G226+cfHHEz0/hfvZNIkzXyTD40hUmvMWHHBkrszeoQNNN5C80CEhK9zZCjCM/2NXoql+kGyxMV
 UhSk6UQhoWlqpSud164gDyI8W5pnn6LqQlQjtYFjHsdSJ0z/sqb2Vs8HQzSPdg1G1gVFN3Wwk7l
 WlXbSrPPSH79Xb4Bd5hPj9n/5ROxVRRJzxNkQvbeOAOW7W+Oej/wwd4VeXYJ2p2VImowfupNMol
 7/YqIHOLipX2FPP8gbYEXLyQLrJGomum1lsW/IZCCGFHoVItjc0eLNTtO2YzICuv4nLA==
X-Received: by 2002:a05:6512:1044:b0:5a8:fbe0:bc6d with SMTP id
 2adb3069b0e04-5aa0e613414mr6934263e87.14.1779224110916; 
 Tue, 19 May 2026 13:55:10 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-218-151.rev.dnainternet.fi.
 [87.92.218.151]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f11a682sm4363495e87.31.2026.05.19.13.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:55:09 -0700 (PDT)
Message-ID: <6a0cce2d.1abec865.8b8c7.cb2a@mx.google.com>
Date: Tue, 19 May 2026 13:55:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: Re: [PATCH] drm/accel/amdxdna: add debugfs support -- follow-up
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: mamin506@gmail.com
Cc: lizhi.hou@amd.com, dri-devel@lists.freedesktop.org
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

SGkgTWluLCBMaXpoaSwKCkkganVzdCBzZW50IGEgcGF0Y2ggdG8gZHJpLWRldmVsIGFkZGluZyBk
ZWJ1Z2ZzIHN1cHBvcnQgdG8gdGhlIGFtZHhkbmEKZHJpdmVyIChzdWJqZWN0OiAiZHJtL2FjY2Vs
L2FtZHhkbmE6IGFkZCBkZWJ1Z2ZzIHN1cHBvcnQiKS4gSXQgcmVzb2x2ZXMKdGhlIFRPRE8gaXRl
bSBpbiBkcml2ZXJzL2FjY2VsL2FtZHhkbmEvVE9ETyBhbmQgYWRkcyB0aHJlZSByZWFkLW9ubHkK
ZW50cmllczogZndfdmVyc2lvbiwgZGV2aWNlX2luZm8sIGFuZCBjbGllbnRzLgoKSSdtIGEgTGlu
dXgga2VybmVsIGNvbnRyaWJ1dG9yIHdpdGggdXBzdHJlYW0gcGF0Y2hlcyBpbiBJSU8sIEFTb0Ms
IFNDU0ksClNDVFAsIFhGUywgYW5kIHBvd2VyIHN1cHBseSBzdWJzeXN0ZW1zLCBhbmQgSSdtIGlu
dGVyZXN0ZWQgaW4gc3BlbmRpbmcKbW9yZSB0aW1lIGluIHRoZSBhY2NlbC9OUFUgc3BhY2UuCgpB
IGZldyBxdWVzdGlvbnMgaWYgeW91IGhhdmUgYSBtb21lbnQ6CgoxLiBJcyB0aGUgZGVidWdmcyBw
YXRjaCBoZWFkaW5nIGluIHRoZSByaWdodCBkaXJlY3Rpb24sIG9yIGFyZSB0aGVyZQogICBjb252
ZW50aW9ucyBpbiBhbWR4ZG5hIEkgc2hvdWxkIGZvbGxvdyBtb3JlIGNsb3NlbHk/CgoyLiBBcmUg
dGhlcmUgb3RoZXIga25vd24gZ2FwcyBvciBUT0RPIGl0ZW1zIGluIHRoZSBkcml2ZXIgdGhhdCB3
b3VsZCBiZQogICBnb29kIG5leHQgY29udHJpYnV0aW9ucz8KCjMuIElzIGRybS9taXNjL2tlcm5l
bCB0aGUgY29ycmVjdCB0cmVlIGZvciBhbWR4ZG5hIHBhdGNoZXM/CgpIYXBweSB0byB0YWtlIG9u
IG1vcmUgd29yayBpbiB0aGlzIGRyaXZlci4KClJlZ2FyZHMsCk1kIFNob2ZpcXVsIElzbGFtCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8/cT1NZCtTaG9maXF1bCtJc2xhbQo=
