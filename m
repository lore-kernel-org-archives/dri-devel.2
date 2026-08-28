Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C6C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9442310F29A;
	Fri, 28 Aug 2026 07:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Zht+oxJl";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFB510E2D9
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 02:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=zeEXKB11IQKraGF0D95j0/2Zl9bdIDGUBg59LFSr2pg=; b=Z
 ht+oxJl6SUlPpwBN17A7/Bd5vUcwAJAvxQztvB8wJNfgG9MsUOJXQAqWw2PjfBSs
 bEmoyPq4yluNKVzMC8MIhsp9FBUESKOay1n+DCyO5nUgMGhwUmmFlLyKZT+o3CGU
 sg71Ufm/kPl1DUbuRRHqXr4sTaN1UbI9EG/mEwfjGU=
Received: from fuqingshuang$kylinos.cn ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Fri, 28 Aug 2026 10:54:09 +0800
 (CST)
X-Originating-IP: [116.128.244.169]
Date: Fri, 28 Aug 2026 10:54:09 +0800 (CST)
From: "Qingshuang Fu" <fuqingshuang@kylinos.cn>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re:Re: [PATCH] drm/logicvc: fix device_node refcount leak in
 logicvc_layers_init()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260826070953.C65021F000E9@smtp.kernel.org>
References: <20260826065408.617148-1-fffsqian@163.com>
 <20260826070953.C65021F000E9@smtp.kernel.org>
X-NTES-SC: AL_Qu2TBfSTuk4v7yCeYekckk4Vhu49Xcq2vvQv34Fec+MGvTLS8R0Ge2FaP3Dw0MODIguooDuacBRP0OVXT4BFYNPsrurlmeCN0vMMrqftuw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4062ba64.2589.1a04649fcb3.Coremail.fuqingshuang@kylinos.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lSgvCgD3n+dS+JBqGZs6AA--.11498W
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6hIR22qQ+FLJSAAA3j
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

CkF0IDIwMjYtMDgtMjYgMTU6MDk6NTMsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6Cj5U
aGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAx
IHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPgo+UHJlLWV4aXN0aW5nIGlzc3VlczoK
Pi0gW0hpZ2hdIE1peGluZyBkZXZtX2t6YWxsb2MgZm9yIERSTSBvYmplY3RzIChsaWtlIHBsYW5l
cyBhbmQgQ1JUQ3MpIHdpdGggZHJtbV9tb2RlX2NvbmZpZ19pbml0IGNhdXNlcyBhIGd1YXJhbnRl
ZWQgVXNlLUFmdGVyLUZyZWUgZHVyaW5nIGRyaXZlciB1bmJpbmQgb3IgcHJvYmUgZmFpbHVyZS4K
Pi0tCj4KPmNvbW1pdCA2ZTU4MjAxNzNkMDIzN2EwN2RkMTA0YjY0MDE3MTE5N2JlNDM2ZjQ5Cj5B
dXRob3I6IFFpbmdzaHVhbmcgRnUgPGZ1cWluZ3NodWFuZ0BreWxpbm9zLmNuPgo+Cj5kcm0vbG9n
aWN2YzogZml4IGRldmljZV9ub2RlIHJlZmNvdW50IGxlYWsgaW4gbG9naWN2Y19sYXllcnNfaW5p
dCgpCj4KPlRoaXMgY29tbWl0IGZpeGVzIGEgZGV2aWNlIG5vZGUgcmVmZXJlbmNlIGxlYWsgaW4g
bG9naWN2Y19sYXllcnNfaW5pdCgpLiBJdAo+YWRkcyBhIG1pc3Npbmcgb2Zfbm9kZV9wdXQoKSBv
biB0aGUgZXJyb3IgcGF0aCB0byBlbnN1cmUgdGhlIHJlZmVyZW5jZQo+YWNxdWlyZWQgYnkgZm9y
X2VhY2hfY2hpbGRfb2Zfbm9kZSgpIGlzIHByb3Blcmx5IHJlbGVhc2VkIHdoZW4KPmxvZ2ljdmNf
bGF5ZXJfaW5pdCgpIGZhaWxzLgo+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbG9n
aWN2Yy9sb2dpY3ZjX2xheWVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vbG9naWN2Yy9sb2dpY3ZjX2xh
eWVyLmMKPj4gaW5kZXggN2Y1YmEwMDAxODhhYi4uZTgzYTJhYWZlZDc3OSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2xvZ2ljdmMvbG9naWN2Y19sYXllci5jCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9sb2dpY3ZjL2xvZ2ljdmNfbGF5ZXIuYwo+PiBAQCAtNjEzLDYgKzYxMyw3IEBA
IGludCBsb2dpY3ZjX2xheWVyc19pbml0KHN0cnVjdCBsb2dpY3ZjX2RybSAqbG9naWN2YykKPj4g
IAo+PiAgCQlyZXQgPSBsb2dpY3ZjX2xheWVyX2luaXQobG9naWN2YywgbGF5ZXJfbm9kZSwgaW5k
ZXgpOwo+PiAgCQlpZiAocmV0KSB7Cj4+ICsJCQlvZl9ub2RlX3B1dChsYXllcl9ub2RlKTsKPj4g
IAkJCW9mX25vZGVfcHV0KGxheWVyc19ub2RlKTsKPj4gIAkJCWdvdG8gZXJyb3I7Cj4KPltTZXZl
cml0eTogSGlnaF0KPlRoaXMgaXNuJ3QgYSBidWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBi
dXQgY291bGQgdGhpcyBlcnJvciBwYXRoIGxlYWQgdG8gYQo+dXNlLWFmdGVyLWZyZWUgZHVyaW5n
IG1vZGUgY29uZmlnIGNsZWFudXA/Cj4KPldoZW4gbG9naWN2Y19sYXllcl9pbml0KCkgZmFpbHMg
YW5kIHRoZSBjb2RlIGp1bXBzIHRvIHRoZSBlcnJvciBsYWJlbCwKPmxvZ2ljdmNfbGF5ZXJzX2lu
aXQoKSBjbGVhbnMgdXAgcHJldmlvdXNseSBpbml0aWFsaXplZCBsYXllcnMgYnkgY2FsbGluZwo+
bG9naWN2Y19sYXllcl9maW5pKCkuIFRoaXMgZnVuY3Rpb24gY2FsbHMgZGV2bV9rZnJlZShkZXYs
IGxheWVyKSB3aXRob3V0Cj5maXJzdCBjYWxsaW5nIGRybV9wbGFuZV9jbGVhbnVwKCksIGxlYXZp
bmcgZGFuZ2xpbmcgcG9pbnRlcnMgaW4gdGhlIGRybV9kZXYKPnBsYW5lX2xpc3QuCj4KPkFkZGl0
aW9uYWxseSwgYmVjYXVzZSBsb2dpY3ZjX2RybV9wcm9iZSgpIHNldHMgdXAgbW9kZSBjb25maWcg
dmlhCj5kcm1tX21vZGVfY29uZmlnX2luaXQoKSwgdGhlIG1vZGUgY29uZmlnIGNsZWFudXAgaXMg
cmVnaXN0ZXJlZCBhcyBhIERSTSBtYW5hZ2VkCj5hY3Rpb24uIFRoZSBsYXllciBhbmQgQ1JUQyBz
dHJ1Y3R1cmVzIGFyZSBhbGxvY2F0ZWQgd2l0aCBkZXZyZXMgKGRldm1fa3phbGxvYygpCj5pbiBs
b2dpY3ZjX2xheWVyX2luaXQoKSBhbmQgbG9naWN2Y19jcnRjX2luaXQoKSkuCj4KPkR1cmluZyBh
IHByb2JlIGZhaWx1cmUgb3IgZHJpdmVyIHVuYmluZCwgZGV2cmVzIHJ1bnMgaW4gTElGTyBvcmRl
ciBhbmQgZnJlZXMKPnRoZSBsYXllcnMgYW5kIENSVEMgYmVmb3JlIHJlbGVhc2luZyB0aGUgZHJt
X2Rldi4gV2hlbiB0aGUgZHJtX2RldiBpcyBmaW5hbGx5Cj5yZWxlYXNlZCwgZHJtbV9tb2RlX2Nv
bmZpZ19jbGVhbnVwKCkgaXRlcmF0ZXMgb3ZlciBtb2RlX2NvbmZpZy5wbGFuZV9saXN0IGFuZAo+
Y3J0Y19saXN0IHRvIGNhbGwgdGhlaXIgZGVzdHJveSBob29rcywgZGVyZWZlcmVuY2luZyB0aGUg
YWxyZWFkeSBmcmVlZCBtZW1vcnkuCj4KPj4gIAkJfQo+Pgo+Cj4tLSAKPlNhc2hpa28gQUkgcmV2
aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDgyNjA2NTQwOC42MTcx
NDgtMS1mZmZzcWlhbkAxNjMuY29tP3BhcnQ9MQoKCgpUaGFua3MgU2FzaGlrbyBBSSBmb3IgdGhl
IGNhcmVmdWwgcmV2aWV3IGFuZCByYWlzaW5nIHRoaXMgaW1wb3J0YW50IHByZeKAkWV4aXN0aW5n
IHVzZeKAkWFmdGVy4oCRZnJlZSBjb25jZXJuLgpUaGlzIGNoYW5nZSBvbmx5IGFkZHMgYSBtaXNz
aW5nIG9mX25vZGVfcHV0KGxheWVyX25vZGUpIHRvIGZpeCBhIGRldmljZeKAkXRyZWUgcmVmZXJl
bmNlIGxlYWsgb24gdGhlCmVycm9y4oCRcGF0aCBpbnNpZGUgbG9naWN2Y19sYXllcnNfaW5pdCgp
LiBObyBwbGFuZSwgQ1JUQywgZGV2cmVzIG9yIGRybW1fbW9kZV9jb25maWdfaW5pdOKAkXJlbGF0
ZWQKYWxsb2NhdGlvbiBvciBjbGVhbnVwIGxvZ2ljIGhhcyBiZWVuIGFsdGVyZWQgYnkgdGhpcyBj
b21taXQuCgpUaGUgZGV2cmVzIHZzIGRybW0gY2xlYW51cOKAkW9yZGVyIFVBRiBkZWZlY3QgaXMg
YW4gaW5kZXBlbmRlbnQgcHJl4oCRZXhpc3RpbmcgYnVnLCBjb21wbGV0ZWx5IHVucmVsYXRlZAp0
byB0aGUgcmVmY291bnQgbGVhayBiZWluZyBmaXhlZCBoZXJlLiBBcyBzdWNoLCBpdCBmYWxscyBv
dXRzaWRlIHRoZSBzY29wZSBvZiB0aGlzIHBhdGNoLgoKUWluZ3NodWFuZyBGdQo=
