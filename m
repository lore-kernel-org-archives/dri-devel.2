Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DED6CDB466
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 02:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEAD10E2D0;
	Sun, 21 Jun 2026 02:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="jO1I4s29";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF3910E2D0
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 02:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=EgRJOTybVvPE2KfhdJd/R/090bJfPCuA9Fkd4GB5M2w=; b=j
 O1I4s29QA44n828i9Yy04JN8zOammskvS5wj4pu41EimeF9UmSilRDdCMzGfF1l2
 38F+G5S2JzRk/61jb7frcVjjND5Wp3GshAcw1FOT3tjacv1VBiSemaTw4buuyc7+
 6zAefWduwBtW/L1LBjrMrckKKoEg2iSR032YBk8dnU=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Sun, 21 Jun 2026 10:17:25 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Sun, 21 Jun 2026 10:17:25 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:[PATCH v2] drm/gem: fix signed integer overflow in idr_alloc end
 parameter
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260605142644.1205922-1-w15303746062@163.com>
References: <20260605142644.1205922-1-w15303746062@163.com>
X-NTES-SC: AL_Qu2TAPybt0ov4ymabOkfmU0Qguw9Xcq5uPkj34FWN5t8jADpwzI7RW1pP0r96smPBi2roia6Vihk6/hcX6hdeo4W6yId/nHf6IwD6eP5ulejZw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <201b9524.566.19ee7f7eeb3.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: gSgvCgD3Fxm2STdqKQQNAA--.342W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5Bbny2o3Sba8WgAA3a
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

CkhpIG1haW50YWluZXJzLAoKR2VudGxlIHBpbmcgb24gdGhpcyB2MiBwYXRjaC4gCgpBcyBhIHF1
aWNrIG5vdGUgcmVnYXJkaW5nIHRoZSBhdXRvbWF0ZWQgcmV2aWV3IGZyb20gU2FzaGlrbyBBSTog
aXQgY29ycmVjdGx5IGZsYWdnZWQgdHdvIHByZS1leGlzdGluZyBpc3N1ZXMgaW4gdGhpcyBmdW5j
dGlvbiAoYSBtaXNzaW5nIGlkcl9wcmVsb2FkIGFuZCBhIGNyaXRpY2FsIFVBRiByYWNlIGNvbmRp
dGlvbiBkdXJpbmcgRFJNX0lPQ1RMX0dFTV9DTE9TRSkuIAoKSSB3YW50IHRvIGNsYXJpZnkgdGhh
dCB0aG9zZSBhcmUgb3J0aG9nb25hbCB0byB0aGUgaW50ZWdlciBvdmVyZmxvdyBmaXhlZCBpbiB0
aGlzIHYyIHBhdGNoLiBJIGFtIGtlZXBpbmcgdGhpcyBwYXRjaCBwdXJlbHkgZm9jdXNlZCBvbiB0
aGUgc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cgaXNzdWUgc28gaXQgY2FuIGJlIGV2YWx1YXRlZCBv
biBpdHMgb3duIG1lcml0cy4gCgpJIGFtIGN1cnJlbnRseSBpbnZlc3RpZ2F0aW5nIHRoZSBVQUYg
cmFjZSBjb25kaXRpb24gc2VwYXJhdGVseSBhbmQgd2lsbCBzdWJtaXQgYSBuZXcgcGF0Y2ggc2Vy
aWVzIHRvIGFkZHJlc3MgdGhlIHByZS1leGlzdGluZyBidWdzIGZsYWdnZWQgYnkgdGhlIGJvdC4K
ClBsZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgZnVydGhlciByZXZpc2lvbnMgYXJlIG5lZWRlZCBm
b3IgdGhpcyB2MiBvdmVyZmxvdyBmaXguCgpUaGFua3MsCk1pbmd5dQoKQXQgMjAyNi0wNi0wNSAy
MjoyNjo0NCwgdzE1MzAzNzQ2MDYyQDE2My5jb20gd3JvdGU6Cj5Gcm9tOiBNaW5neXUgV2FuZyA8
MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+Cj4KPkR1cmluZyBjb2RlIHJldmlldyBvZiBk
cm1fZ2VtX2NoYW5nZV9oYW5kbGVfaW9jdGwoKSwgYSBzaWduZWQgaW50ZWdlcgo+b3ZlcmZsb3cg
dnVsbmVyYWJpbGl0eSB3YXMgaWRlbnRpZmllZC4KPgo+VGhlIGZ1bmN0aW9uIGN1cnJlbnRseSBj
aGVja3MgaWYgYXJncy0+bmV3X2hhbmRsZSBpcyBzdHJpY3RseSBncmVhdGVyCj50aGFuIElOVF9N
QVguIEhvd2V2ZXIsIGlmIGFyZ3MtPm5ld19oYW5kbGUgaXMgZXhhY3RseSBJTlRfTUFYLCB0aGUK
PnN1YnNlcXVlbnQgY2FsbCB0byBpZHJfYWxsb2MoKSB1c2VzICdoYW5kbGUgKyAxJyBhcyB0aGUg
ZW5kIGxpbWl0Lgo+Cj5TaW5jZSAnaGFuZGxlJyBpcyBhIHNpZ25lZCBpbnQsIHBhc3NpbmcgSU5U
X01BWCByZXN1bHRzIGluIGEgc2lnbmVkCj5pbnRlZ2VyIG92ZXJmbG93IChJTlRfTUFYICsgMSA9
IC0yMTQ3NDgzNjQ4KS4gV2hpbGUgaWRyX2FsbG9jKCkgaGFuZGxlcwo+bmVnYXRpdmUgZW5kIHZh
bHVlcyBieSBncmFjZWZ1bGx5IGZhbGxpbmcgYmFjayB0byBJTlRfTUFYLCB0aGlzIGJyZWFrcwo+
dGhlIGV4YWN0LUlEIGFsbG9jYXRpb24gc2VtYW50aWNzIGludGVuZGVkIGJ5IHRoZSBjYWxsZXIg
YW5kIHJlbGllcyBvbgo+dW5kZWZpbmVkIGJlaGF2aW9yLgo+Cj5BZGRpdGlvbmFsbHksIGV4cGxp
Y2l0bHkgcmVqZWN0IGFyZ3MtPm5ld19oYW5kbGUgPT0gMC4gSW4gdGhlIERSTQo+c3Vic3lzdGVt
LCAwIGlzIHVuaXZlcnNhbGx5IHRyZWF0ZWQgYXMgYW4gaW52YWxpZCBoYW5kbGUuIEFsbG93aW5n
IGFuCj5vYmplY3QgdG8gYmUgYWxpYXNlZCB0byBoYW5kbGUgMCBicmVha3MgY29yZSBEUk0gYXNz
dW1wdGlvbnMgKGUuZy4sCj5kcm1fZ2VtX29iamVjdF9sb29rdXAgcmV0dXJucyBOVUxMIGZvciAw
KS4KPgo+Rml4IHRoaXMgYnkgdGlnaHRlbmluZyB0aGUgbGltaXQgY2hlY2sgdG8gPj0gSU5UX01B
WCB0byBwcmV2ZW50IHRoZQo+b3ZlcmZsb3csIGFuZCBleHBsaWNpdGx5IHJlamVjdCAwLgo+Cj5T
aWduZWQtb2ZmLWJ5OiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+
Cj4tLS0KPnYyOgo+IC0gQWRkIGV4cGxpY2l0IGNoZWNrIHRvIHJlamVjdCBoYW5kbGUgMCwgd2hp
Y2ggaXMgaW52YWxpZCBpbiBEUk0uCj4gLSBSZW1vdmUgcmVkdW5kYW50ICh1MzIpIGNhc3Q7IHJl
bHkgb24gc3RhbmRhcmQgQyBpbnRlZ2VyIHByb21vdGlvbi4KPiAtIFNoaWZ0IGZvY3VzIGVudGly
ZWx5IHRvIGZpeGluZyB0aGUgaGFuZGxlICsgMSBzaWduZWQgaW50ZWdlciBvdmVyZmxvdyAoVGhv
bWFzIFppbW1lcm1hbm4pLgo+Cj4gZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyB8IDggKysrKysr
LS0KPiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj5k
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9k
cm1fZ2VtLmMKPmluZGV4IGUxMmNkZjkxZjRkYy4uMWFkMzBhNzAwMDY4IDEwMDY0NAo+LS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0u
Ywo+QEAgLTEwMjUsOCArMTAyNSwxMiBAQCBpbnQgZHJtX2dlbV9jaGFuZ2VfaGFuZGxlX2lvY3Rs
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4gCWlmICghZHJtX2NvcmVfY2hl
Y2tfZmVhdHVyZShkZXYsIERSSVZFUl9HRU0pKQo+IAkJcmV0dXJuIC1FT1BOT1RTVVBQOwo+IAo+
LQkvKiBpZHJfYWxsb2MoKSBsaW1pdGF0aW9uLiAqLwo+LQlpZiAoYXJncy0+bmV3X2hhbmRsZSA+
IElOVF9NQVgpCj4rCS8qCj4rCSAqIGlkcl9hbGxvYygpIGxpbWl0YXRpb24uCj4rCSAqIFJlamVj
dCBoYW5kbGUgMCAoaW52YWxpZCBpbiBEUk0pIGFuZCBzdHJpY3RseSBib3VuZAo+KwkgKiB0byA8
IElOVF9NQVggdG8gYXZvaWQgc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cgaW4gaGFuZGxlICsgMS4K
PisJICovCj4rCWlmIChhcmdzLT5uZXdfaGFuZGxlID09IDAgfHwgYXJncy0+bmV3X2hhbmRsZSA+
PSBJTlRfTUFYKQo+IAkJcmV0dXJuIC1FSU5WQUw7Cj4gCWhhbmRsZSA9IGFyZ3MtPm5ld19oYW5k
bGU7Cj4gCj4tLSAKPjIuMzQuMQo=
