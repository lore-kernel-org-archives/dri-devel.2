Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B343CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A723A10F570;
	Tue, 13 Oct 2026 07:53:00 +0000 (UTC)
Received: from host3.o27bbn.ondsl.gr (host3.o27bbn.ondsl.gr [79.129.74.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F332B10E72F;
 Tue, 13 Oct 2026 05:39:32 +0000 (UTC)
Received: from mail.e-psn.eu (cluster-localnode [10.200.210.1])
 by mail.e-psn.eu (Postfix) with ESMTPA id 8D800384259D;
 Tue, 13 Oct 2026 05:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e-psn.eu; s=default;
 t=1791869970; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type; bh=2NpAp98+aDTsJD73ZxUrmQmFtE8jXYR7xPbn+CrA0qw=;
 b=MxNgZ6NhpYABr0qVEcxcUSBwTXDQUsg9MK4umy7LHTu6i/7L19Vggs7ji+v3QR5XL5vsqz
 5CsWoM1lN76WPlQ4POpRtHNaqTHTcTAQaO52OuauvUZMygv1gH/hWJU9lbUevntcJ9z8ZT
 U68fBbZmWJlb6+gzq1cvkHyiQNB/eGbasuGLSxbM/lcO66EZlMGV5Dj707jZ2iJvJPxoPF
 9lkQefvmmaZS6Q8KS+41oWuWzG0dJOeLQGYZ47KUxxsICnRTceaPr9TZf+2MWfjmYqyl+Q
 fMrkH80j163VAG6LmtEJZMJ4n5FMTOQKikK8IygxkP2Zwx7JKqHmfVnTdef0dQ==
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 08:39:30 +0300
From: Constantinos Chalkias <cch@e-psn.eu>
To: simon.richter@hogyros.de
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
Mail-Reply-To: cch@e-psn.eu
Message-ID: <5b9625f2276630e1c8822c89c8f6288b@e-psn.eu>
X-Sender: cch@e-psn.eu
Organization: E-PSN
Content-Type: multipart/alternative;
 boundary="=_d5617720cf2e4688614326fcf48dd5cf"
X-Rspamd-Flag-Threshold: 6
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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
Reply-To: cch@e-psn.eu
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--=_d5617720cf2e4688614326fcf48dd5cf
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi Simon,

For some context, I started investigating this because my Maxsun Arc Pro 
B70 would latch the blower at very high speed after a long inference 
workload and leave it there even when the node was otherwise idle. I had 
previously dealt with a separate idle-power issue where continuous Intel 
Level Zero Sysman/XPUM monitoring kept the card at elevated power with a 
model resident; after removing that polling, the card could return to 
low idle power normally. The persistent blower latch was the remaining 
reproducible problem.

I did some more targeted testing based on your comments.

I restricted the workaround to CHANNEL_PKG only and disabled both hwmon 
pollers so no other sensor reads could interfere.

With a 500-1000 us settling interval, the package-only workaround was 
not reliable. The physical blower could remain latched at high speed for 
several minutes after the workload ended.

I then repeated the test with a package-only 3000-3500 us settling 
interval. With monitoring disabled, the blower remained latched high for 
more than five minutes after inference stopped. A single temp2_input 
package-temperature read then immediately caused the blower to drop; the 
read returned 36 C.

So the workaround does not need to cover VRAM or individual VRAM-channel 
reads. A package-only force-wake appears sufficient, provided the 
settling interval is long enough.

I also confirmed that fan1_input is a separate issue: it can report 
implausibly low values while the physical blower is still running at 
high speed.

This makes the v1 patch broader than necessary. I'll narrow v2 to the 
package-temperature path and document the delay as an empirical 
workaround rather than an architectural timing requirement.

Thanks,
Constantinos
--=_d5617720cf2e4688614326fcf48dd5cf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8" /></head><body style=3D'font-size: 10pt; font-family: Verdana,Gen=
eva,sans-serif'>
<p><span>Hi Simon,</span></p>
<p><span>For some context, I started investigating this because my Maxsun A=
rc Pro B70 would latch the blower at very high speed after a long inference=
 workload and leave it there even when the node was otherwise idle. I had p=
reviously dealt with a separate idle-power issue where continuous Intel Lev=
el Zero Sysman/XPUM monitoring kept the card at elevated power with a model=
 resident; after removing that polling, the card could return to low idle p=
ower normally. The persistent blower latch was the remaining reproducible p=
roblem.</span></p>
<p><br /></p>
<p><span>I did some more targeted testing based on your comments.</span></p>
<p><span>I restricted the workaround to </span><code dir=3D"ltr">CHANNEL_PK=
G</code><span> only and disabled both hwmon pollers so no other sensor read=
s could interfere.</span></p>
<p><span>With a 500-1000 us settling interval, the package-only workaround =
was not reliable. The physical blower could remain latched at high speed fo=
r several minutes after the workload ended.</span></p>
<p><span>I then repeated the test with a package-only 3000-3500 us settling=
 interval. With monitoring disabled, the blower remained latched high for m=
ore than five minutes after inference stopped. A single </span><code dir=3D=
"ltr">temp2_input</code><span> package-temperature read then immediately ca=
used the blower to drop; the read returned 36 C.</span></p>
<p><span>So the workaround does not need to cover VRAM or individual VRAM-c=
hannel reads. A package-only force-wake appears sufficient, provided the se=
ttling interval is long enough.</span></p>
<p><span>I also confirmed that </span><code dir=3D"ltr">fan1_input</code><s=
pan> is a separate issue: it can report implausibly low values while the ph=
ysical blower is still running at high speed.</span></p>
<p><span>This makes the v1 patch broader than necessary. I&rsquo;ll narrow =
v2 to the package-temperature path and document the delay as an empirical w=
orkaround rather than an architectural timing requirement.</span></p>
<p><span>Thanks,</span><br /><span>Constantinos</span></p>
</body></html>

--=_d5617720cf2e4688614326fcf48dd5cf--
