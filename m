Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698C6CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 15:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6B510F5D3;
	Fri, 22 May 2026 15:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBiNARLh";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B8710E262
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 15:51:35 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso56816945e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779465094; x=1780069894; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CmsULhgzdpYks2pjKVsx1r2w1Y1WKpYU4+YB5dkEfOM=;
 b=WBiNARLhnBHtUL541q08lxXNR3NNYW3SGtbUUvb61qYcRlvrcP0X5P+9jCyr6WPqXO
 nnLh6N8cQLO+J8nk/BX9tjPYWjQxSPAKg7t9Eth5GnI0aEvLBKt+d8qJ819KF460kj/7
 L0hpuE3K5PZT6BXNfqxp0xZxcNTHwk8wWCxLMxsLRat+Du96tyDNfFceHmJJlkxUPxNj
 UEGQO4FYdcYcyP60/11fvsO/Vk6XnDhKzsZEP91fT2t0Jax+2SiVeU18UIhkaOcrNNrY
 PVQAsYQ3Sjjm/pPenSUWo0Z1fGlsX3Y9coHiZVu8QXwHlYW3HFIDU82Ehj8b/16vYqQu
 3y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779465094; x=1780069894;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmsULhgzdpYks2pjKVsx1r2w1Y1WKpYU4+YB5dkEfOM=;
 b=LhHrcwzb5XmL0zSI/4wxNp6jN1RtRM/uJzOYe4fhXcyepZC19xoSus5tuPp757UF7F
 z8DfSr8XX1Br/EHRoUi8Y3pzyLB6Per51c05FFdmy1dgXEecW0ocxrIL43vISVfDOvk9
 VRThJuVbnwAr0VFHZegsdyfMlnxt+mAFgCHGgULPfJQyHQMjYxgIs/HPevazubTPWdQG
 +3i6m0mxJNJFCav5SBzJFX3HWNF80TIVi3Yp+f1JDjGaUSUKvlqyVNVPmqKWIUUz8RUG
 Cm4jxdfW7+zCZAGAwTTas4Nn6wIXvSSiNdisgs0OzU8bl5/WG39vNXPOSqhdMbwVICid
 HqBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wTpr044eV4fNxHwMkqAFz258TU4MOIkmAsSBRpXr+smA1xnbMR+WPkIQjjE2mk/ztQsY2mrepGB0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyByzbNKu15RrMGzAytcQQX3NcxmQFKPvvlt5ykhXU3DZK+7kNU
 3cPPqYh3JXGBHONGERH0P/Xcnf9QdcRlSEwwlMZeeOtLexbLVj8ZFlmD
X-Gm-Gg: Acq92OGm5jRhiM/P9CP+Fr/A+vl8FrzVvMRGZu94lUSs1l0FATfBMDHAYkExm89aFKX
 423LQ8tdT6yqJBC8VJaaq7LCuiXj/hsGoVlUPKfkZxcjyx/PX3xVOSmrRqOMeyTBdYZmS44r8pk
 9N1mrABuhl2Bv/WCIfr6cpyU4JoMmY/5nK2jGm4evyf3cBeUx+JeB2NQqkpjaEkCsOpCefOS/fj
 Xqy8p0plYzCQXPfELYpwAREJfvQEqusXbkav/Ft9qp86hwYzIFK2NdnmYM6V21mOU4TM+Rsc6Wl
 Klmo9cjpBSWqVXWaQNShcwcysKPRltkl7SrBma7YXYm4we8huvqkZnbxhtj2APKXnKS5adwgO7/
 yzwDAYiOKDC26BwbSkxKclds8AxOm2ZY7kduhmIoAxL/6T5ITcbgVlUxN3aqwA4jsqf5Moak1J5
 oMad2UVSjr2r5JErcAZ12cjfnmldgOCnDnrBBjAel9REvZ6B3J
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id
 5b1f17b1804b1-490426cefe0mr46813985e9.18.1779465093265; 
 Fri, 22 May 2026 08:51:33 -0700 (PDT)
Received: from vitor-nb.Home (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042af026esm17298825e9.30.2026.05.22.08.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 08:51:32 -0700 (PDT)
Message-ID: <a6d42b33eaf5dd1e0fcfb3d4854968a081a212b1.camel@gmail.com>
Subject: Re: [PATCH v2 01/11] arm64: dts: ti: k3-am62-verdin: Add Toradex
 DSI to LVDS adapter with 10.1" display
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>,  Tero Kristo <kristo@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thierry Reding
 <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Date: Fri, 22 May 2026 16:51:31 +0100
In-Reply-To: <20260522132014.226721-14-ivitro@gmail.com>
References: <20260522132014.226721-13-ivitro@gmail.com>
 <20260522132014.226721-14-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
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

SGksCgpPbiBGcmksIDIwMjYtMDUtMjIgYXQgMTQ6MjAgKzAxMDAsIFZpdG9yIFNvYXJlcyB3cm90
ZToKPiBGcm9tOiBWaXRvciBTb2FyZXMgPHZpdG9yLnNvYXJlc0B0b3JhZGV4LmNvbT4KPiAKPiBB
ZGQgYSBkZXZpY2UgdHJlZSBvdmVybGF5IGZvciB0aGUgVG9yYWRleCBEU0kgdG8gTFZEUyBBZGFw
dGVyIHdpdGggdGhlCj4gVG9yYWRleCBDYXBhY2l0aXZlIFRvdWNoIERpc3BsYXkgMTAuMSIgTFZE
Uy4gVGhlIGFkYXB0ZXIgY29ubmVjdHMgdG8gdGhlCj4gVmVyZGluIERTSV8xIGludGVyZmFjZS4g
SXQgaXMgYmFzZWQgb24gdGhlIFRleGFzIEluc3RydW1lbnRzIFNONjVEU0k4NAo+IERTSS10by1M
VkRTIGJyaWRnZSBhbmQgZHJpdmVzIGEgTG9naWNUZWNobm8gTFQxNzA0MTAtMldIQyAxMC4xIiBX
WEdBIExWRFMKPiBwYW5lbC4gVG91Y2ggaW5wdXQgaXMgcHJvdmlkZWQgYnkgYW4gQXRtZWwgTWF4
VG91Y2ggY2FwYWNpdGl2ZSB0b3VjaAo+IGNvbnRyb2xsZXIuCj4gCj4gTGluazoKPiBodHRwczov
L2RldmVsb3Blci50b3JhZGV4LmNvbS9oYXJkd2FyZS9hY2Nlc3Nvcmllcy9hZGQtb25zL2RzaS1s
dmRzLWFkYXB0ZXIKPiBMaW5rOgo+IGh0dHBzOi8vZGV2ZWxvcGVyLnRvcmFkZXguY29tL2hhcmR3
YXJlL2FjY2Vzc29yaWVzL2Rpc3BsYXlzL2NhcGFjaXRpdmUtdG91Y2gtZGlzcGxheS0xMDFpbmNo
LWx2ZHMKPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1zb25uZXQtNC42Cj4gU2lnbmVkLW9m
Zi1ieTogVml0b3IgU29hcmVzIDx2aXRvci5zb2FyZXNAdG9yYWRleC5jb20+Cj4gClsuLi5dCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02MjUtdmVyZGluLWRzaS10
by1sdmRzLXBhbmVsLWNhcC0KPiB0b3VjaC0xMGluY2guZHRzbyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvdGkvazMtYW02MjUtdmVyZGluLWRzaS10by1sdmRzLXBhbmVsLQo+IGNhcC10b3VjaC0xMGlu
Y2guZHRzbwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi4wZTg3
M2YyY2NmNjUKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9r
My1hbTYyNS12ZXJkaW4tZHNpLXRvLWx2ZHMtcGFuZWwtY2FwLXRvdWNoLQo+IDEwaW5jaC5kdHNv
Cj4gClsuLi5dCj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJlZ18zdjNfbHZkc19icmlkZ2U6IHJlZ3Vs
YXRvci0zdjMtbHZkcy1icmlkZ2Ugewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
b21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Owo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsK
ClNhc2hpa28gZmxhZ2dlZCB0aGUgbWlzc2luZyAncmVndWxhdG9yLW5hbWUnIHByb3BlcnR5IGhl
cmUsIAoKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICt9Owo+ICsKPiAKClsuLi5dCj4gKwo+ICvCoMKg
wqDCoMKgwqDCoHRvdWNoQDRhIHsKCmFuZCB0byB1c2UgdGhlIGdlbmVyaWMgbm9kZSBuYW1lICd0
b3VjaHNjcmVlbkA0YScgaGVyZSBpbnN0ZWFkIG9mCid0b3VjaEA0YScuCgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImF0bWVsLG1heHRvdWNoIjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4NGE+Owo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZHNpMV9pbnQ+LCA8JnBp
bmN0cmxfaTJzXzJfYmNsa19ncGlvPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LyogVmVyZGluIEdQSU9fOV9EU0kgKFNPRElNTSAxNykgLSBUT1VDSF9JTlQjICovCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdC1wYXJlbnQgPSA8Jm1haW5fZ3BpbzE+
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRzID0gPDQ5IElSUV9U
WVBFX0VER0VfRkFMTElORz47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFZl
cmRpbiBJMlNfMl9CQ0xLIChTT0RJTU0gNDIpIC0gVE9VQ0hfUkVTRVQjICovCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc2V0LWdwaW9zID0gPCZtYWluX2dwaW8wIDM1IEdQSU9f
QUNUSVZFX0xPVz47Cj4gK8KgwqDCoMKgwqDCoMKgfTsKPiArfTsKCkkgd2lsbCBzZW5kIGEgdjMg
YWRkcmVzc2luZyB0aGVzZSBpc3N1ZXMgaGVyZSBhbmQgd2hlcmUgaXQgYXBwbGllcy4KClRoYW5r
cywKVml0b3IgU29hcmVzCg==

