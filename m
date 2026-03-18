Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0202C103E177
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6533A10E21A;
	Wed, 18 Mar 2026 13:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nfraprado@collabora.com header.b="Bcv4TD5v";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D2F10E21A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773839912; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YhujDzt/e0NjTtUyUXuzSY/Le6GvVrWdWeqnIEUxUBJVDHHqOaXNw/LA0j4X+MGOYYy1XcJU+TP0kHv5ptgGHGk2d5PJE+mgFzbWbVe0jPsqKfANd706ZoFimCYvPcRe8fl9dVKRoYd4xyhg1CrohfmvsTXdSjmVDpDONAB7Zv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773839912;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=F+UN9HIXOUxuFgcjf3rxpjrFOJaR3ROfCMIjHMDcM48=; 
 b=Xa/Osxjanr0Rbjzg0qLHSn0A5Kb3hT9Ks8/RM0xcqlD2QIbcG4+rAxu0K/Xy6hjBicA2WOyDwh0jBg7x06sNIguz2hrsi6s9k2MDhuEWBlcBGlQkdkcZYWwTItStCnoAXKs5/E8ukEjnuul8/FKbxhQhwkHNB5SgAd2CHego3wQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nfraprado@collabora.com;
 dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773839912; 
 s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=F+UN9HIXOUxuFgcjf3rxpjrFOJaR3ROfCMIjHMDcM48=;
 b=Bcv4TD5vTib4Vxi8AEOmlIrchwN8fxpCPAoBQ1/RGsAy8nFU3t1zZD98A+p69tPp
 bUPND2gv/kXWT/VMfIMlEUxSpWeUmXon7kTsuI8JYtIGs08U6EQ6hMNZBQ+8JFPMxzZ
 ZdNFMmPC6JGK/Df8lZYjKX1FuS7oQf8h3opycaPA=
Received: by mx.zohomail.com with SMTPS id 1773839909989805.2310598881032;
 Wed, 18 Mar 2026 06:18:29 -0700 (PDT)
Message-ID: <698d1d3f41d7931e6447545394757f71b9ebc597.camel@collabora.com>
Subject: Re: [PATCH 10/11] drm/mediatek: ovl: Enable support for R2R Color
 Space Conversion
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
Date: Wed, 18 Mar 2026 09:18:28 -0400
In-Reply-To: <2ce1ed408fd87366d3abc1e79bc3d1dc055af91b.camel@mediatek.com>
References: <20251223-mtk-ovl-pre-blend-colorops-v1-0-0cb99bd0ab33@collabora.com>
 <20251223-mtk-ovl-pre-blend-colorops-v1-10-0cb99bd0ab33@collabora.com>
 <2ce1ed408fd87366d3abc1e79bc3d1dc055af91b.camel@mediatek.com>
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

T24gVHVlLCAyMDI2LTAzLTAzIGF0IDA3OjE2ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToKPiBPbiBUdWUsIDIwMjUtMTItMjMgYXQgMTY6NDQgLTAzMDAsIE7DrWNvbGFzIEYuIFIuIEEu
IFByYWRvIHdyb3RlOgo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMKPiA+IHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuCj4gPiAKPiA+IAo+ID4gVGhlIE9WTCBoYXJkd2FyZSBhbGxv
d3MgYXBwbHlpbmcgYSAzeDMgbWF0cml4IHRyYW5zZm9ybWF0aW9uIGZvcgo+ID4gZWFjaAo+ID4g
bGF5ZXIgdGhyb3VnaCB0aGUgJ1JHQiB0byBSR0IgQ29sb3IgU3BhY2UgQ29udmVyc2lvbicgKFIy
UiBDU0MpCj4gPiBzZXR0aW5nLgo+ID4gSW1wbGVtZW50IHN1cHBvcnQgZm9yIGl0IGFuZCBleHBv
c2UgaXQgYXMgYSBjb2xvcm9wIHRocm91Z2ggdGhlIERSTQo+ID4gcGxhbmUgY29sb3IgcGlwZWxp
bmUgdUFQSS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8g
PG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDU1Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYwo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMK
PiA+IGluZGV4IGE3MDA5MmM3OTJhOS4uYzhhMmIxYjEzMDM1IDEwMDY0NAo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMKPiA+IEBAIC00LDYgKzQsNyBAQAo+ID4gwqAg
Ki8KPiA+IAo+ID4gwqAjaW5jbHVkZSA8ZHJtL2RybV9ibGVuZC5oPgo+ID4gKyNpbmNsdWRlIDxk
cm0vZHJtX2NvbG9yX21nbXQuaD4KPiA+IMKgI2luY2x1ZGUgPGRybS9kcm1fY29sb3JvcC5oPgo+
ID4gwqAjaW5jbHVkZSA8ZHJtL2RybV9mb3VyY2MuaD4KPiA+IMKgI2luY2x1ZGUgPGRybS9kcm1f
ZnJhbWVidWZmZXIuaD4KPiA+IEBAIC01Miw2ICs1Myw3IEBACj4gPiDCoCNkZWZpbmUgT1ZMX0NP
Tl9DTFJGTVRfMTBfQklUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKDEpCj4gPiDCoCNkZWZpbmUgRElTUF9SRUdfT1ZMX1dDR19DRkcxwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDJkOAo+ID4gwqAjZGVmaW5lIElHQU1NQV9FTihs
YXllcinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgQklUKDAgKyA0ICoKPiA+IChsYXllcikpCj4gPiArI2RlZmluZSBDU0NfRU4obGF5
ZXIpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEJJVCgxICsgNCAqCj4gPiAobGF5ZXIpKQo+ID4gwqAjZGVmaW5lIEdBTU1B
X0VOKGxheWVyKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gQklUKDIgKyA0ICogKGxheWVyKSkK
PiA+IMKgI2RlZmluZSBESVNQX1JFR19PVkxfV0NHX0NGRzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDB4MmRjCj4gPiDCoCNkZWZpbmUgSUdBTU1BX01BU0sobGF5ZXIpwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IEdF
Tk1BU0soKGxheWVyKSAqIDQgKyAxLCAobGF5ZXIpICogNCkKPiA+IEBAIC02Miw2ICs2NCw3IEBA
Cj4gPiDCoCNkZWZpbmUgR0FNTUFfQlQ3MDnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEKPiA+IMKgI2RlZmluZSBH
QU1NQV9CVDIwMjDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyCj4gPiDCoCNkZWZpbmUgR0FNTUFfSExHwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMwo+ID4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX1IyUl9QQVJBKGxheWVyKcKgwqDC
oMKgwqDCoMKgwqDCoMKgICgweDUwMCArIChsYXllcikgKgo+ID4gMHg0MCkKPiA+IMKgI2RlZmlu
ZSBESVNQX1JFR19PVkxfQUREUl9NVDgxNzPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4
MGY0MAo+ID4gwqAjZGVmaW5lIERJU1BfUkVHX09WTF9BRERSKG92bCwgbinCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoKG92bCktPmRhdGEtPmFkZHIKPiA+ICsgMHgyMCAqIChuKSkKPiA+IMKg
I2RlZmluZSBESVNQX1JFR19PVkxfSERSX0FERFIob3ZsLCBuKcKgwqDCoMKgwqDCoMKgwqDCoCAo
KG92bCktPmRhdGEtPmFkZHIKPiA+ICsgMHgyMCAqIChuKSArIDB4MDQpCj4gPiBAQCAtNTc5LDEx
ICs1ODIsNDQgQEAgc3RhdGljIHZvaWQgbXRrX292bF9hcHBseV9pZ2FtbWEoc3RydWN0Cj4gPiBt
dGtfZGlzcF9vdmwgKm92bCwgdW5zaWduZWQgaW50IGlkeCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSUdBTU1BX0VOKGlkeCkpOwo+ID4g
wqB9Cj4gPiAKPiA+ICtzdGF0aWMgdm9pZCBtdGtfb3ZsX3dyaXRlX3Iycl9wYXJhKHN0cnVjdCBt
dGtfZGlzcF9vdmwgKm92bCwKPiA+IHVuc2lnbmVkIGludCBpZHgsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBkcm1fY29sb3JfY3RtICpjdG0sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjbWRxX3BrdCAq
Y21kcV9wa3QpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgaTsKPiA+ICvC
oMKgwqDCoMKgwqAgdTY0IHZhbDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoY3RtLT5tYXRyaXgpOyBpKyspIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHZhbCA9IGRybV9jb2xvcl9jdG1fczMxXzMyX3RvX3FtX24oY3RtLT5tYXRy
aXhbaV0sCj4gPiA1LCAxOCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdGtf
ZGRwX3dyaXRlKGNtZHFfcGt0LCB2YWwsICZvdmwtPmNtZHFfcmVnLCBvdmwtCj4gPiA+cmVncywK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBESVNQX1JFR19PVkxfUjJSX1BBUkEoaWR4KSArIGkgKiA0KTsKPiA+ICvCoMKgwqDCoMKg
wqAgfQo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBtdGtfb3ZsX2FwcGx5X3Iycl9jc2Mo
c3RydWN0IG10a19kaXNwX292bCAqb3ZsLAo+ID4gdW5zaWduZWQgaW50IGlkeCwKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBkcm1fY29sb3JvcCAqY29sb3JvcCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjbWRx
X3BrdCAqY21kcV9wa3QpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2NvbG9y
X2N0bSAqY3RtOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoY29sb3JvcC0+c3RhdGUtPmRh
dGEgJiYgY29sb3JvcC0+c3RhdGUtPmRhdGEtPmRhdGEpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGN0bSA9IChzdHJ1Y3QgZHJtX2NvbG9yX2N0bSAqKWNvbG9yb3AtPnN0YXRl
LT5kYXRhLQo+ID4gPmRhdGE7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdGtf
b3ZsX3dyaXRlX3Iycl9wYXJhKG92bCwgaWR4LCBjdG0sIGNtZHFfcGt0KTsKPiA+ICvCoMKgwqDC
oMKgwqAgfQo+ID4gKwo+IAo+IElmIGJ5cGFzcyBpbXBseSBjb2xvcm9wLT5zdGF0ZS0+ZGF0YS0+
ZGF0YSBpcyBOVUxMLCBub3RoaW5nIG5lZWQgdG8KPiBjaGFuZ2UuCj4gSWYgYnlwYXNzIGRvZXMg
bm90IGltcGx5IGNvbG9yb3AtPnN0YXRlLT5kYXRhLT5kYXRhIGlzIE5VTEwsIEkgd291bGQKPiBs
aWtlIHRvIGRpc2FibGUgQ1NDIGZpcnN0IHRoZW4gY2xlYXIgcjJyIHBhcmFtZXRlci4KCmJ5cGFz
cyBkb2VzIG5vdCBpbXBseSBOVUxMIGRhdGEuIEJ1dCBldmVuIHdoZW4gc2V0dGluZyB0aGUgQ1ND
IGJsb2NrIHRvCmJlIGJ5cGFzc2VkLCB3ZSBkb24ndCB3YW50IHRvIGNsZWFyIGl0cyBwYXJhbWV0
ZXJzLCB3ZSB3YW50IHRvIHNldCB0aGUKcGFyYW1ldGVycyBwYXNzZWQgYnkgdXNlcnNwYWNlIGlu
IHRoaXMgYXRvbWljIGNvbW1pdCwgaWYgYW55LCBhbmQgaWYKbm90IHdlIHdhbnQgdG8ga2VlcCB0
aGUgY3VycmVudCBwYXJhbWV0ZXJzLCBpbiBjYXNlIHRoZXkgaGF2ZSBiZWVuIHNldAppbiBhIHBy
ZXZpb3VzIGF0b21pYyBjb21taXQsIHNvIHRoYXQgYSBmdXR1cmUgY29tbWl0IHNldHRpbmcgYnlw
YXNzPTAKd2lsbCBoYXZlIHRoZSBwYXJhbWV0ZXJzIHByZXZpb3VzbHkgc2V0LCB3aXRob3V0IGhh
dmluZyB0byBwYXNzIHRoZW0KYWdhaW4uCgpUaGFua3MsCk7DrWNvbGFzCg==

