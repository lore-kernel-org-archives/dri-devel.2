Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EC7CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE4110E366;
	Tue, 19 May 2026 07:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FsM0tYTd";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D79A10E593
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:32:27 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7bdaa68cf81so17556247b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779118346; cv=none;
 d=google.com; s=arc-20240605;
 b=Mrft9XycyMoxWP40M5pvoyB0CddAHGLDbs0Q5Fh120Le8QKg58UX1qzvDPTDU3IkTS
 eaQpfmiG1FYoEszzbGyuTF6m9JnIIilqCS/EEOC4hDkgw7QRh/ilEoHubgk1q2K9flE3
 PS3il02+4YYilpLK0/imx/kuQYSfHqoJCQ91C1OrjV7tGeGM8VxP49JtmC4yGE/lM0VG
 uij2/zkkDpU7lRibNL9TcNKyftcaJfqsZSNJOSERTz1IxFKSkWT0coyyTSB2cJ3vYk/y
 ZjU3q3ORbHMhGshaNMOBzJcMQdlcOMr24wCwRyvCHCNel6QsrQ/tMkABZ0cz1yJPkQQ6
 f5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=jAobYI2Elfv1JM9JrAZc5dFbU3SUriC72Zl5ToKxafU=;
 fh=CjuDPUYbo5y3oxEYpXv6gBjlRiE82BOvY0XwqmL7Yr8=;
 b=OGDu+yvbFBcq4YswygH4RAFyvGmlmyfS4cSrbRwThY7PTRsZky0jw6x82BWAJX1rZm
 7bPDfupvn3P6QRelnbrQp+xqodA/fb4yAyqT2i9fYI1N1yfzYR1aL5ucQqbOwXFHxxFb
 dOY4KVw3imtw1P4Td63jTfoiMa7dZ+rvsWfACd5cRkPWorBoZWla+i2aoboKd7UV1lMS
 TOQv/xJLcjJvcbcNcv3QvCFO0t8+RNvaDdozMhItw7HZ60tl5GHg5WQgS/EIxsdin4JS
 e+A12nsb1+L6d8qwcEzH+JPI3JjpUA03bToTZDJ/fqK8wNjbjcn3PO1T7BoRuMHiT7vx
 +EQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779118346; x=1779723146; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jAobYI2Elfv1JM9JrAZc5dFbU3SUriC72Zl5ToKxafU=;
 b=FsM0tYTdAC6ec2rPLIuByARQJkf/ui0TAsjTW5KJG/pUTqUpU9StuVczVA8DXo2wJt
 x48jpZ8nvp31XbUFB2vdc79jYnetph+SxXRYEUta74KMgOpEPr8IXBOsYNlNeOBbBk02
 IxHsb+0DTTG2iooDeqQDp3pQDFQl7A0PaQESRaTGjxI4b0b0aqmeIYm4vtm0ymIjzYjz
 Pn/ndRzmaWrnxAUjD3r1h3Erq62H7czXXOnL2JV7AC+JsLgxJ/qN5/nJwmlX1S+l3VXc
 A+hE6p0K9wTcG6OJYR8y/gZDjsuIoO2dsH63agY/fFO2KXzGKA3nLx8K1+R+mi26JZLh
 Hn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779118346; x=1779723146;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jAobYI2Elfv1JM9JrAZc5dFbU3SUriC72Zl5ToKxafU=;
 b=kZ4T8rkWuZYzO2pQoYksECemvPgZtYQegvNbqZus0lA941gO4K7UQZg6f56JSEsYaY
 +0hRASOTuEUNfkB3Hw5B2UkIC33y2m5OcsMEl+ZZNWuzdlHYxyFecwRVItGC06yOyiMU
 opSs/dfkR94Blb5DZMH5RMNstLmBXzSBTsBRpE3OE6JH7CUI4MY+6lh/BNEY96eC9Bk7
 2/xYt3+TaK9B1Rv2Cva4koqV7mmGuvM+nSi1DBbsvL1eFkI8k44r5g68Csxntak/9tkM
 3E++4qbqhuo1HzS0+E8LURP0cBZN9r28o5VD1033hiri20CLdgf5p4OGN21U6R57gpF2
 UVsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Yp20C+pETaojXnyCAsQLdtonTBPboUaQyOG5bggWv2mAjr93ABo44zFxQ8iW3ocXZYXHBLH9BYlg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGBxniYbV+BH0kwbEbG2zjHjVGZRs+aoEKsevoTWO1cO8y+alD
 qdF5PO0Qy4A2zPpe9TYNU3eSklrTV/oGfXMoJEKfmfHdgLuO8qMS5F3TRmed+m+SdWRDDjgH3RZ
 JpgcPnofdAX8oVyCtiyCva+3jObo/4f0=
X-Gm-Gg: Acq92OFN9/KI0gGV5TnhAegpEcgsp5V9nPmk+uybRLkaDrFqQCfpnvEUvRvswsJEuIw
 pWaShmt8bef779EhrIa5mFcEec3OMcGw1C4wqUorcPAWnIUwkDSJnoxETSodS/ilGYKzAGOCZ5R
 1WtZRLtscvVCVRHTi/nSnlGL6eI6+HYl3bMjg4GdoONKzsLsIB053tB77ZNrqfVV2nV1pCgpX0W
 YX/sDARVeomddcBHk5klWN+H0oZAeUeeJeq2x4+sANGoPg93506bHwj1morq8gDaXX4EzLaRG/s
 /ovLBTwqf8EE0egVx/CgRY/QI2dQE+BfGuiyNciZJGYw2NTdN90MZFagABtzbe/23CL0+mTF
X-Received: by 2002:a05:690c:8d0c:b0:79a:7ff5:93ee with SMTP id
 00721157ae682-7c95a37c569mr162101727b3.22.1779118346187; Mon, 18 May 2026
 08:32:26 -0700 (PDT)
MIME-Version: 1.0
From: D D <dhabal123@gmail.com>
Date: Mon, 18 May 2026 21:02:18 +0530
X-Gm-Features: AVHnY4K9ElAWlWdHbVAK9Rwhr2p0P34Bpg62xJReYqrfhXCv-jSv8_pbSS-q8lE
Message-ID: <CA+g3TbsDGcsmdPn-p70OO3DwS2Fsq0NN9v1FVYqSa13JCPvFXQ@mail.gmail.com>
Subject: [PATCH] accel/ethosu: fix integer overflow in cmd_to_addr() address
 computation
To: security@kernel.org
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000009b8c206521945a4"
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

--00000000000009b8c206521945a4
Content-Type: text/plain; charset="UTF-8"

In cmd_to_addr(), the expression (cmd[0] & 0xff0000) << 16 performs the
left-shift in 32-bit arithmetic because cmd[0] is u32 and the intermediate
result of the AND is also u32. The meaningful bits (positions 16-23) need
to land in positions 32-39 of the result, but these positions exceed the
32-bit width, so they are silently discarded before the cast to u64.

This causes cmd_to_addr() to always return an address with a zeroed upper
half, producing an incorrect DMA address for the Ethos-U NPU. The device
may then read from or write to the wrong physical memory region, leading
to kernel memory corruption or information disclosure.

Fix by casting to u64 before the shift so the operation is performed in
64-bit arithmetic and no bits are lost.

Found by manual source code audit of Linux kernel v6.19
(drivers/accel/ethosu/ethosu_gem.c, line 157).
Affected versions: v6.19+ (since initial Ethos-U driver merge).

Signed-off-by: Dhabaleshwar Das (dhabal123@gmail.com)
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c
b/drivers/accel/ethosu/ethosu_gem.c
index abcdef1..1234567 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -155,7 +155,7 @@ static u64 cmd_to_addr(u32 *cmd)
 static u64 cmd_to_addr(u32 *cmd)
 {
- return ((u64)((cmd[0] & 0xff0000) << 16)) | cmd[1];
+ return (((u64)(cmd[0] & 0xff0000)) << 16) | cmd[1];
 }

--00000000000009b8c206521945a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In cmd_to_addr(), the expression (cmd[0] &amp; 0xff0000) &=
lt;&lt; 16 performs the<br>left-shift in 32-bit arithmetic because cmd[0] i=
s u32 and the intermediate<br>result of the AND is also u32. The meaningful=
 bits (positions 16-23) need<br>to land in positions 32-39 of the result, b=
ut these positions exceed the<br>32-bit width, so they are silently discard=
ed before the cast to u64.<br><br>This causes cmd_to_addr() to always retur=
n an address with a zeroed upper<br>half, producing an incorrect DMA addres=
s for the Ethos-U NPU. The device<br>may then read from or write to the wro=
ng physical memory region, leading<br>to kernel memory corruption or inform=
ation disclosure.<br><br>Fix by casting to u64 before the shift so the oper=
ation is performed in<br>64-bit arithmetic and no bits are lost.<br><br>Fou=
nd by manual source code audit of Linux kernel v6.19<br>(drivers/accel/etho=
su/ethosu_gem.c, line 157).<br>Affected versions: v6.19+ (since initial Eth=
os-U driver merge).<br><br>Signed-off-by: Dhabaleshwar Das (<a href=3D"mail=
to:dhabal123@gmail.com">dhabal123@gmail.com</a>)<br>---<br>=C2=A0drivers/ac=
cel/ethosu/ethosu_gem.c | 2 +-<br>=C2=A01 file changed, 1 insertion(+), 1 d=
eletion(-)<br><br>diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/=
accel/ethosu/ethosu_gem.c<br>index abcdef1..1234567 100644<br>--- a/drivers=
/accel/ethosu/ethosu_gem.c<br>+++ b/drivers/accel/ethosu/ethosu_gem.c<br>@@=
 -155,7 +155,7 @@ static u64 cmd_to_addr(u32 *cmd)<br>=C2=A0static u64 cmd_=
to_addr(u32 *cmd)<br>=C2=A0{<br>-	return ((u64)((cmd[0] &amp; 0xff0000) &lt=
;&lt; 16)) | cmd[1];<br>+	return (((u64)(cmd[0] &amp; 0xff0000)) &lt;&lt; 1=
6) | cmd[1];<br>=C2=A0}</div>

--00000000000009b8c206521945a4--
