Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F0FCD0C4
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3670010E004;
	Wed, 18 Mar 2026 13:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nfraprado@collabora.com header.b="SMnUv4+7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CF410E004
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773839085; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QdhKA/uwxwLkGuRCO26XaKrktL5qSjrfN4h/dG5o2QPOtE3AdJUObaUgUdXN9FPhiCAi/YCLFUlaYCbfh6O4U6PR2kSo1uUAqkU2TnFjB2rGCJrgn0L5+5xw8z4p9+SPQlmKpgQmKaUmUBNfPWTWtxQ9j4awqOixcJlmiwme7TI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773839085;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HTj9TTGgzjponYmtaKAG6DTPjji6MMbjO97+6wRmeD0=; 
 b=fsz8FoHbPlpaRUk6xkgcsz/vkKf0EVKF0cjc3oNxLjgJAfQZ/o6oXmCzNGbYW0wRBhcOgOBYQOe5ccbkPs1pbBYSVa/zpG+0cp2ZDNr9s69iHP1LBGevZGzBINdXNztYFQL9v6V+GNM7YN+CmFWkDx38t2itq7B+q4SJq9N9uu4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nfraprado@collabora.com;
 dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773839085; 
 s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=HTj9TTGgzjponYmtaKAG6DTPjji6MMbjO97+6wRmeD0=;
 b=SMnUv4+7/yFqYEvh2OIk+wX8rVUVB795nPSRRObo/LynpWSCP5ICJ6CgtqH3xS7q
 Az0nvLeIf3IR2cAqB3Cx09hVGmIlvOlj2WvK2xIyvA11ufDxlxoTk9cCTJO0LE+8lNW
 lzwiA0iBJlrJBrqOrnJVthYX6SWlqrGyJxjdYSZE=
Received: by mx.zohomail.com with SMTPS id 1773839082696573.6539031246534;
 Wed, 18 Mar 2026 06:04:42 -0700 (PDT)
Message-ID: <c4abafcb370fda06dc36338b451ddabd3de9eda3.camel@collabora.com>
Subject: Re: [PATCH 08/11] drm/mediatek: ovl: Implement support for Gamma
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?=
 <ck.hu@mediatek.com>,  "tzimmermann@suse.de"	 <tzimmermann@suse.de>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,  "simona@ffwll.ch"	
 <simona@ffwll.ch>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"	
 <airlied@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
 "maarten.lankhorst@linux.intel.com"	 <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,  "matthias.bgg@gmail.com"	
 <matthias.bgg@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-mediatek@lists.infradead.org"	 <linux-mediatek@lists.infradead.org>,
 Daniel Stone <daniels@collabora.com>, 
 "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, Ariel D'Alessandro	
 <ariel.dalessandro@collabora.com>, "kernel@collabora.com"
 <kernel@collabora.com>
Date: Wed, 18 Mar 2026 09:04:39 -0400
In-Reply-To: <6f0e1de2043f03bd3e00a31210af50e06aef7205.camel@mediatek.com>
References: <20251223-mtk-ovl-pre-blend-colorops-v1-0-0cb99bd0ab33@collabora.com>
 <20251223-mtk-ovl-pre-blend-colorops-v1-8-0cb99bd0ab33@collabora.com>
 <6f0e1de2043f03bd3e00a31210af50e06aef7205.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-8 
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

T24gVHVlLCAyMDI2LTAzLTAzIGF0IDA2OjUzICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToKPiBPbiBUdWUsIDIwMjUtMTItMjMgYXQgMTY6NDQgLTAzMDAsIE7DrWNvbGFzIEYuIFIuIEEu
IFByYWRvIHdyb3RlOgo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMKPiA+IHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuCj4gPiAKPiA+IAo+ID4gVGhlIE9WTCBoYXJkd2FyZSBhbGxv
d3Mgc2VsZWN0aW5nIGJldHdlZW4gZGlmZmVyZW50IGZpeGVkIHRyYW5zZmVyCj4gPiBmdW5jdGlv
bnMgZm9yIGVhY2ggbGF5ZXIgdGhyb3VnaCB0aGUgR2FtbWEgc2V0dGluZy4gQXZhaWxhYmxlCj4g
PiBmdW5jdGlvbnMgYXJlIHNjUkdCLCBCVC43MDksIEJULjIwMjAgYW5kIEhMRy4gSW1wbGVtZW50
IHN1cHBvcnQgZm9yCj4gPiBpdAo+ID4gYW5kIGV4cG9zZSBpdCBhcyBhIGNvbG9yb3AgdGhyb3Vn
aCB0aGUgRFJNIHBsYW5lIGNvbG9yIHBpcGVsaW5lCj4gPiB1QVBJLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+
Cj4gPiAtLS0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwg
NjcKPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYwo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMKPiA+IGluZGV4IDRlYWEzMTU0MWNjYy4u
YTcwMDkyYzc5MmE5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bC5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsLmMKPiA+IEBAIC01MiwxMCArNTIsMTYgQEAKPiA+IMKgI2RlZmluZSBPVkxfQ09OX0NMUkZN
VF8xMF9CSVTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAoMSkKPiA+IMKgI2RlZmluZSBESVNQX1JFR19PVkxfV0NHX0NGRzHCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDB4MmQ4Cj4gPiDCoCNkZWZpbmUgSUdBTU1BX0VOKGxheWVyKcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBCSVQoMCArIDQgKgo+ID4gKGxheWVyKSkKPiA+ICsjZGVmaW5lIEdBTU1BX0VOKGxheWVyKcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gQklUKDIgKyA0ICogKGxheWVyKSkKPiA+IMKgI2RlZmlu
ZSBESVNQX1JFR19PVkxfV0NHX0NGRzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDB4MmRjCj4gPiDCoCNkZWZpbmUgSUdBTU1BX01BU0sobGF5ZXIpwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IEdFTk1BU0soKGxheWVy
KSAqIDQgKyAxLCAobGF5ZXIpICogNCkKPiA+IMKgI2RlZmluZSBJR0FNTUFfU0NSR0LCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAwCj4gPiDCoCNkZWZpbmUgSUdBTU1BX0JUNzA5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMQo+ID4gKyNkZWZp
bmUgR0FNTUFfTUFTSyhsYXllcinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiBHRU5NQVNLKChsYXllcikgKiA0ICsgMywgKGxheWVy
KSAqIDQgKyAyKQo+ID4gKyNkZWZpbmUgR0FNTUFfU0NSR0LCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAKPiA+ICsj
ZGVmaW5lIEdBTU1BX0JUNzA5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxCj4gPiArI2RlZmluZSBHQU1NQV9CVDIw
MjDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAyCj4gPiArI2RlZmluZSBHQU1NQV9ITEfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAz
Cj4gPiDCoCNkZWZpbmUgRElTUF9SRUdfT1ZMX0FERFJfTVQ4MTczwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAweDBmNDAKPiA+IMKgI2RlZmluZSBESVNQX1JFR19PVkxfQUREUihvdmwsIG4p
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKChvdmwpLT5kYXRhLT5hZGRyCj4gPiArIDB4MjAg
KiAobikpCj4gPiDCoCNkZWZpbmUgRElTUF9SRUdfT1ZMX0hEUl9BRERSKG92bCwgbinCoMKgwqDC
oMKgwqDCoMKgwqAgKChvdmwpLT5kYXRhLT5hZGRyCj4gPiArIDB4MjAgKiAobikgKyAweDA0KQo+
ID4gQEAgLTUwOCwxMSArNTE0LDQxIEBAIHN0YXRpYyBpbnQKPiA+IG10a19vdmxfY29sb3JvcF9j
dXJ2ZV90b19yZWdfdmFsKGVudW0gZHJtX2NvbG9yb3BfY3VydmVfMWRfdHlwZQo+ID4gY3VydmUK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSUdBTU1BX1NDUkdCOwo+
ID4gwqDCoMKgwqDCoMKgwqAgY2FzZSBEUk1fQ09MT1JPUF8xRF9DVVJWRV9CVDIwMjBfT0VURjoK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSUdBTU1BX0JUNzA5Owo+
ID4gK8KgwqDCoMKgwqDCoCBjYXNlIERSTV9DT0xPUk9QXzFEX0NVUlZFX1NSR0JfRU9URjoKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBHQU1NQV9TQ1JHQjsKPiA+ICvC
oMKgwqDCoMKgwqAgY2FzZSBEUk1fQ09MT1JPUF8xRF9DVVJWRV9CVDIwMjBfSU5WX09FVEY6Cj4g
Cj4gTWF5YmUgRFJNX0NPTE9ST1BfMURfQ1VSVkVfQlQyMDIwX09FVEY/CgpUaGF0IGlzIHRoZSBr
aW5kIG9mIHRoaW5nIHRoYXQgaXMganVzdCBndWVzc2luZyB1bmxlc3Mgd2UgY2FuIHZlcmlmeQp0
aHJvdWdoIHdyaXRlYmFjayBvciB0aHJvdWdoIG9mZmljaWFsIGRvY3VtZW50YXRpb24gb2YgdGhl
IGhhcmR3YXJlLgpKdXN0IGJlY2F1c2UgYSBibG9jayBpcyBjYWxsZWQgIkludmVyc2UgR2FtbWEi
IGl0IGRvZXNuJ3QgZ3VhcmFudGVlCnRoYXQgYWxsIGN1cnZlcyBzaG91bGQgaGF2ZSBpbnZlcnNl
IGluIHRoZWlyIG5hbWVzLiBTb21lIHNwZWNpZmljYXRpb25zCmRlZmluZSBFT1RGIGN1cnZlcywg
b3RoZXJzIGRlZmluZSBPRVRGIGN1cnZlcy4gVGhlIGludmVyc2UgY3VydmVzIGFyZQp0aGUgaW52
ZXJzZSBmdW5jdGlvbnMgb2YgYSBnaXZlbiBFT1RGIG9yIE9FVEYgY3VydmUsIHdoaWNoIGFyZSBv
ZnRlbgptYXRoZW1hdGljYWxseSBkZXJpdmVkIGFuZCBub3QgZXhwbGljaXRseSBtZW50aW9uZWQg
aW4gdGhlIHNwZWNzLgoKQXMgZm9yIHRoZSBvdGhlciBjb21tZW50cyBJJ2xsIGFkZHJlc3MgdGhl
bSBpbiBhIGZvbGxvd2luZyB2ZXJzaW9uLgoKVGhhbmtzLApOw61jb2xhcwo+IAo=

