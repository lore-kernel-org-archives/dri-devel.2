Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB117E99068
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F5610E919;
	Fri, 10 Apr 2026 10:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="B9wqX4l5";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68BFF10E919
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775816156; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mEe3laSAdu8R0WhTDRru8ZPSczrMqQrxUOnM6HYPvcg0wSuRDjqvqUfhpOsdXGPfNejuNkjBuPyL/9Qa6m0qeAvM5jSzEuYNinnYLVxrlpu082Y25DGNTlCpNJa46oznn6MSfFaYr3vB6lQf3aUAhRY6q3MWmrQdiukXr3Xbs1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775816156;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=G6AnCneEdMxNqnTVUSaf/YvUtOIJ206a3KqvNRA76I4=; 
 b=izRyZFI+O0lWlYIMBb6H3lBR27yBLkGLIWTnfhBIpHxXWeBbgPaTomJO+N1f2jtDStLjH60BiQgVJo5MuSXU+UIlJdqv7rMEAbR5HHTgHSlSb1ySM56mz9MMD85elJ7fKtJ4FRTtNWoRUbquXjolsEmHAqOnIwwKaO/wR3D5Cxs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775816156; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=G6AnCneEdMxNqnTVUSaf/YvUtOIJ206a3KqvNRA76I4=;
 b=B9wqX4l52SLtm4BM8+n2dRwOtxV8JsqR+Hvdgi0NQEzLnKJ98u5KpFUvD6L2XRHi
 sN3MVK0DkctVoSFaVa00BONCaj31tShfx04a+ivHusAxI9KuSFUyr8SDkx4pDJoakv0
 1GX/REeS+0H7X+bVRruYAatVqZ8EUzkgKytOltLi9H9lxN74aAV1vqy0rffHgECDg0w
 C4afYO8iMISHDay4zbBk6TW1IEeVmOuDQHYg4Dp7yyV7S7i3Da932n+4ImhqLq2ApZc
 kobgahx4GM84CYk0MMcBAE9vh6BJFiVuefigOX9pRM4FQ+I6x5Jj9aGoIXRXwUFX8Wp
 VFbjIVsCEQ==
Received: by mx.zohomail.com with SMTPS id 1775816154386446.00739810195216;
 Fri, 10 Apr 2026 03:15:54 -0700 (PDT)
Message-ID: <8d32576c481acee56530fa4846be88e0ee51d747.camel@icenowy.me>
Subject: Re: [bug report] drm/bridge: add a driver for T-Head TH1520 HDMI
 controller
From: Icenowy Zheng <uwu@icenowy.me>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org
Date: Fri, 10 Apr 2026 18:15:46 +0800
In-Reply-To: <adjM7-DcN_6KvbE7@stanley.mountain>
References: <adjM7-DcN_6KvbE7@stanley.mountain>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

5ZyoIDIwMjYtMDQtMTDkupTnmoQgMTM6MTEgKzAzMDDvvIxEYW4gQ2FycGVudGVy5YaZ6YGT77ya
Cj4gSGVsbG8gSWNlbm93eSBaaGVuZywKPiAKPiBDb21taXQgOTZmMzBlZTBmYjlkICgiZHJtL2Jy
aWRnZTogYWRkIGEgZHJpdmVyIGZvciBULUhlYWQgVEgxNTIwIEhETUkKPiBjb250cm9sbGVyIikg
ZnJvbSBKYW4gMjksIDIwMjYgKGxpbnV4LW5leHQpLCBsZWFkcyB0byB0aGUgZm9sbG93aW5nCj4g
U21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6Cj4gCj4gCWRyaXZlcnMvZ3B1L2RybS9icmlk
Z2UvdGgxNTIwLWR3LWhkbWkuYzoxMzkKPiB0aDE1MjBfZHdfaGRtaV9wcm9iZSgpCj4gCXdhcm46
ICdoZG1pJyBpc24ndCBhbiBFUlJfUFRSCj4gCj4gZHJpdmVycy9ncHUvZHJtL2JyaWRnZS90aDE1
MjAtZHctaGRtaS5jCj4gwqDCoMKgIDEzM8KgwqDCoMKgwqDCoMKgwqAgcGxhdF9kYXRhLT5vdXRw
dXRfcG9ydCA9IDE7Cj4gwqDCoMKgIDEzNMKgwqDCoMKgwqDCoMKgwqAgcGxhdF9kYXRhLT5tb2Rl
X3ZhbGlkID0gdGgxNTIwX2hkbWlfbW9kZV92YWxpZDsKPiDCoMKgwqAgMTM1wqDCoMKgwqDCoMKg
wqDCoCBwbGF0X2RhdGEtPmNvbmZpZ3VyZV9waHkgPSB0aDE1MjBfaGRtaV9waHlfY29uZmlndXJl
Owo+IMKgwqDCoCAxMzbCoMKgwqDCoMKgwqDCoMKgIHBsYXRfZGF0YS0+cHJpdl9kYXRhID0gaGRt
aTsKPiDCoMKgwqAgMTM3IAo+IMKgwqDCoCAxMzjCoMKgwqDCoMKgwqDCoMKgIGhkbWktPmR3X2hk
bWkgPSBkd19oZG1pX3Byb2JlKHBkZXYsIHBsYXRfZGF0YSk7Cj4gLS0+IDEzOcKgwqDCoMKgwqDC
oMKgwqAgaWYgKElTX0VSUihoZG1pKSkKPiDCoMKgwqAgMTQwwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIoaGRtaSk7Cj4gCj4gcy9oZG1pL2hkbWktPmR3X2hk
bWkvCgpUaGFua3MgZm9yIHRoZSByZXBvcnQuCgpBIHBlbmRpbmcgZml4IGlzIGF0IFsxXS4KClsx
XQpodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyNjAzMjEtdGgxNTIwLXYxLTAt
ZWM4NzcxOTc3NzBkQGdtYWlsLmNvbS8KCgpUaGFua3MsCkljZW5vd3kKCj4gCj4gwqDCoMKgIDE0
MSAKPiDCoMKgwqAgMTQywqDCoMKgwqDCoMKgwqDCoCBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBoZG1pKTsKPiDCoMKgwqAgMTQzIAo+IMKgwqDCoCAxNDTCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+IMKgwqDCoCAxNDUgfQo+IAo+IFRoaXMgZW1haWwgaXMgYSBmcmVlIHNlcnZpY2UgZnJv
bSB0aGUgU21hdGNoLUNJIHByb2plY3QKPiBbc21hdGNoLnNmLm5ldF0uCj4gCj4gcmVnYXJkcywK
PiBkYW4gY2FycGVudGVyCg==

