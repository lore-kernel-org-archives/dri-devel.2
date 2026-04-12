Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EF7E937E4
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 15:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C9E10E037;
	Sun, 12 Apr 2026 15:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nwI4XqQB";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998EB10E032
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:08:01 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so6341054eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 07:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776002881; cv=none;
 d=google.com; s=arc-20240605;
 b=jnVwVu9xzKd2yZXf1ClkXBvvDunG+9ksOJEYPvYgN581czuVzr5d7qTnKu6kfeKYG7
 +AYpkzM+zFX0BIQVJsuw3dP80AVEkkqMTMbMG3K0McauTeFXg8QEecIBBxYPKCnftu+w
 7jrpVq/CKW3mgas+F1YAmi7aTkahDo4BHZWzfjpGBb+fsz68WsklKCwAeeLcSuO6bpBP
 F4tui4YC9LYADslpPBCDMRiDb3w0lwUdpxV+J6ZtNoVX9Lxm8/nkWzlYd0TB5T6c9HTe
 AsrhOnfPLdIn3DIXS460sUPxSA3ipgC53TOZFHr0f6meVaF8YKNuXUhIfPvjn9aJBY0w
 gmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=2nzl8XY5Hjw/o0gS9rgnutjUWE5xk7uVp0qz36DLq4E=;
 fh=i1qJzFu+Mg3jYaPW0FqIwdK/yztPxwbx4CC+HehzjSw=;
 b=KJcIcnk+UhiuX8lCALLoWXJS8wGRE6ZcEf8aGWZ9m1+3dsqZmMrYrsgI7XoKXQy1s2
 +97V7mJL2huDyNUhKFVX1jGwtCrIBa/8ypxVNXbvIV+rrSfByCS8FRXug/1/agsOBmch
 lmhxKT+WzUuRtEF0LbJ+xtrvq1+oX7uCqKizY/j4a9/So/bcV3FVD0pDP/U6fCNLTu6Z
 Bo567MNCtrhacWWNOTZ9FWXrByEL/hNegMLAOSui9UnRZ03tccbtqdwSWDk/lxrYCvVK
 yQ8SZXF2VafMrk4c+7m9xtiH04PogSL1eVuU/dllkNjq2+sqmYaS/DC7jIoUUPtxXT5F
 TEkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776002881; x=1776607681; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2nzl8XY5Hjw/o0gS9rgnutjUWE5xk7uVp0qz36DLq4E=;
 b=nwI4XqQBrGVNkyaaLftU5ZrFvZlcRbEn7wAJ0wI1w6npa1zCDupeBP5zOC4C0AmnB0
 XcSiIxN/RUjf79MiwYNqq+gLpM2XOaQa+6stKu6xfNsCgDdmfCPfkIscH+n8IhxyK+hb
 jdiTid6GMPgS2K2CBK3wbvEz7+cr+Hci4hX1VZbJYOFdY2mdL/PXIWNsi3u20Tf+gAug
 jNS2NKdgMQidqz+qJDgLeH0d/kqqaISz2TDIMndJ6u5hvOTQXyXyLM36zfsyS1Fra1LB
 SoZG6vbwagr5EwsZWvpnbpofpDPBztfwR650MKd1Y+1YRRCyJ1uN+pYxDWyRb7db7bGH
 rKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776002881; x=1776607681;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nzl8XY5Hjw/o0gS9rgnutjUWE5xk7uVp0qz36DLq4E=;
 b=hZb/WrflN09KyhsfaXsUMsX7n10XPfDLFMZw+54qWvl323FS8MTRCk3FrMNJ4wPiKR
 Z+7xb2yQ9xvBLjF4Wv8rHzUY5xrj2i9Hib9Nu11qTLqr6FNRqg7POQe0P9aW1izR1BGx
 TljOnkeVMjOjq45zFYgNh/+dbMP4pnRpuWAdVB48RIPb4ZXo1knNWH97GkbpB7yvXWoG
 9i7cbN2FeZi2MaxFGRpNBYSUKnH5gtVA8Cpt1E+C/T2Y+uGo/I4YMooRUBXRSE6zDJ2E
 ITTUVAqjIeSLeY2ECbjc9zlr0ltAuhONCUvPzRA4kzS1bGaEVMVZdzBquRkKezTxxxRw
 9JqQ==
X-Gm-Message-State: AOJu0YyHi+KYyjuyITsK3zDzAuHrQ8Y+G2noqLtpazvOOBmmF5zmgrdR
 z+2TH4/EeohCb/jk+bplJ7WYlsGof0mCbG7jasOAhfssFv1s0q8iKT9274rDJsODocPxx8kCNaP
 Z8RXS1f4bUVHAO96d1Bv1xlHVyJNOXHk=
X-Gm-Gg: AeBDiesQkCMBYx8sL5+Rz23q+/cMFYFU3Pa15oISieFLKvJ6vGGBALIlDzr+gk8g78p
 eyyBfueUBy1T3lgY2PO/DPrdHTe9ohnLwvbMztUkt0jBLjRrWAVWTJsNzPaW4nz80Ym6w7OxTb+
 ydZb4rqAyjW/TNU1pb9hddsCkjM05yqqIn43dj35neoMnJPTjFzYo0aSqMbYyQI3fejo/5T+qWk
 Kqz5V9HKRchv+OzFHFsO4SGJi85IBNQm0ZUCFgDlF7/jYNflDiyYJNwH1RfCxjme9zmwfmdoucJ
 3hLOKBNyOoBFuDpr5IuEEdCOYNRWIJ9X6ZGQcOvk8g==
X-Received: by 2002:a05:693c:3104:b0:2ce:f3d7:20c with SMTP id
 5a478bee46e88-2d589cb573amr6422802eec.29.1776002880393; Sun, 12 Apr 2026
 07:08:00 -0700 (PDT)
MIME-Version: 1.0
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Sun, 12 Apr 2026 14:07:49 +0300
X-Gm-Features: AQROBzCM8n5NDCUu-vN3CE4lvJO7rB58UBsSAT8sCEoFNzKGCvnBXP1ZsAyx04o
Message-ID: <CAOEgbEpEahQVtQxZT-WgT+Wzc8c1qtK1Oh+ZQVhy60Muo2FYXg@mail.gmail.com>
Subject: [RFC] Adding request_mem_region() to fbdev drivers (TODO #23)
To: thomas.zimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000ce5495064f43e477"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:30:50 +0000
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

--000000000000ce5495064f43e477
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

I'm planning to work on TODO #23
<https://dri.freedesktop.org/docs/drm/gpu/todo.html#request-memory-regions-=
in-all-fbdev-drivers>
-
adding devm_request_mem_region() calls to fbdev drivers that currently call
ioremap() without first claiming the MMIO region.

From a survey of drivers/video/fbdev/, I count roughly 67 drivers that are
missing the call. I plan to skip the obvious non-hardware cases (vfb.c,
smscufx.c, udlfb.c, xen-fbfront.c), but wanted to check with you before
starting:

  1. Are there other drivers in the set I should skip or treat specially?
(I wasn't sure about ps3fb.c.)
  2. Do you have a preference on patch series size =E2=80=94 one driver per=
 patch,
or grouped by similarity (e.g. all PCI drivers together)?
  3. While touching these files, should I also convert existing
*request_mem_region()* callers to the *devm_* variant, or leave those alone
to keep the series focused?

I'll use *devm_request_mem_region()* as the preferred pattern throughout.
Happy to send a single pilot patch first if that makes review easier.

Thanks,
Amit

--000000000000ce5495064f43e477
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Thomas,<br><br><div>I&#39;m planning t=
o work on <a href=3D"https://dri.freedesktop.org/docs/drm/gpu/todo.html#req=
uest-memory-regions-in-all-fbdev-drivers" target=3D"_blank">TODO #23</a>=C2=
=A0- adding devm_request_mem_region() calls to fbdev drivers that currently=
 call ioremap() without first claiming the MMIO region.<br><br>From a surve=
y of drivers/video/fbdev/, I count roughly 67 drivers that are missing the =
call. I plan to skip the obvious non-hardware cases (vfb.c, smscufx.c, udlf=
b.c, xen-fbfront.c), but wanted to check with you before starting:<br><br>=
=C2=A0 1. Are there other drivers in the set I should skip or treat special=
ly? (I wasn&#39;t sure about ps3fb.c.)<br>=C2=A0 2. Do you have a preferenc=
e on patch series size =E2=80=94 one driver per patch, or grouped by simila=
rity (e.g. all PCI drivers together)?<br>=C2=A0 3. While touching these fil=
es, should I also convert existing <i>request_mem_region()</i> callers to t=
he <i>devm_</i> variant, or leave those alone to keep the series focused?<b=
r><br>I&#39;ll use <i>devm_request_mem_region()</i> as the preferred patter=
n throughout. Happy to send a single pilot patch first if that makes review=
 easier.<br><br></div><div>Thanks,<br>Amit</div></div>
</div>

--000000000000ce5495064f43e477--
