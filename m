Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CADCCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71E710E677;
	Sun, 18 Oct 2026 14:53:20 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EA010E0A9;
 Sat, 17 Oct 2026 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=6RYg+QEhvrFWqlGi6rF11G5GgEjzUp69rAP5U33oLhw=; b=S
 Q+nEkmK+QY5qb0mvr8dF2lkhwxQN2H8q6f4APYXDy6ypX6TEkvtCnBqKJ615Ulm2
 mjJzZ2jqQL8hdza5H88SHjsgK7SEapnmbo3fRqdMPCQdu18b3ux3MnMLBgTzt1cG
 SaOKAMuXzT7JPaB4+0v2tLqVtRbajzO1oDxZIzTsh8=
Date: Sat, 17 Oct 2026 15:34:16 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Felix Kuehling" <Felix.Kuehling@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] drm/amdkfd: validate SRAT subtables before parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261016141504.2794541-1-yaojiale02@163.com>
References: <20261016141504.2794541-1-yaojiale02@163.com>
X-NTES-SC: AL_Qu2SAP6ZvUwu4CiaYukdnEkQgO0/WsS1vfQu2Y5Wc+wEgCbN4z0YdHxaDHHN8e6DOSarnDiOagNHzNRcb4JHTF6JEbgLzY2dD/mJw631Uw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <38b79a6a.187f.1a148c86c09.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZygvCgAnZyj4JNNqovtaAA--.126W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRjWEWrTJPgaKAAA3F
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

QXQgMjAyNi0xMC0xNiAyMjoxNTowNCwgIkppYWxlIFlhbyIgPHlhb2ppYWxlMDJAMTYzLmNvbT4g
d3JvdGU6Cj5UaGUgS0ZEIFNSQVQgd2Fsa2VyIHJlYWRzIHRoZSBmaXJzdCBzdWJ0YWJsZSBsZW5n
dGggd2l0aG91dCBjaGVja2luZwo+dGhhdCBhIGhlYWRlciBpcyBwcmVzZW50IGFuZCB0cnVzdHMg
c3Vic2VxdWVudCBsZW5ndGhzIHdoZW4gYWNjZXNzaW5nCj5DUFUgYW5kIGdlbmVyaWMgYWZmaW5p
dHkgcmVjb3Jkcy4gSW52YWxpZCBmaXJtd2FyZSBsZW5ndGhzIGNhbiB0aGVyZWZvcmUKPmNhdXNl
IG91dC1vZi1ib3VuZHMgcmVhZHMuCj4KPlZhbGlkYXRlIHRoZSB0YWJsZSBoZWFkZXIsIGV2ZXJ5
IGdlbmVyaWMgc3VidGFibGUgcmFuZ2UsIGFuZCBlYWNoCj5zdXBwb3J0ZWQgdHlwZWQgcmVjb3Jk
IGJlZm9yZSByZWFkaW5nIGl0cyBmaWVsZHMuCj4KCkZpeGVzOiBkZGVjOGQzYmUwZjggKCJkcm0v
YW1ka2ZkOiBhZGQgQUNQSSBTUkFUIHBhcnNpbmcgZm9yIHRvcG9sb2d5IikKCj5TaWduZWQtb2Zm
LWJ5OiBKaWFsZSBZYW8gPHlhb2ppYWxlMDJAMTYzLmNvbT4KPi0tLQo+IGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgfCAzNSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0K
PiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+aW5kZXggNmUwZGY2ODU1MDNkLi4zMmQ3
NTczZGZmYzkgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3Jh
dC5jCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj5AQCAtMjA1
NiwyNyArMjA1NiwzMyBAQCBzdGF0aWMgdm9pZCBrZmRfZmluZF9udW1hX25vZGVfaW5fc3JhdChz
dHJ1Y3Qga2ZkX25vZGUgKmtkZXYpCj4gCQlyZXR1cm47Cj4gCX0KPiAKPisJaWYgKHRhYmxlX2hl
YWRlci0+bGVuZ3RoIDwgc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX3NyYXQpKQo+KwkJZ290byBp
bnZhbGlkX3NyYXQ7Cj4rCj4gCXRhYmxlX2VuZCA9ICh1bnNpZ25lZCBsb25nKXRhYmxlX2hlYWRl
ciArIHRhYmxlX2hlYWRlci0+bGVuZ3RoOwo+IAo+IAkvKiBQYXJzZSBhbGwgZW50cmllcyBsb29r
aW5nIGZvciBhIG1hdGNoLiAqLwo+IAlzdWJfaGVhZGVyID0gKHN0cnVjdCBhY3BpX3N1YnRhYmxl
X2hlYWRlciAqKQo+IAkJCSgodW5zaWduZWQgbG9uZyl0YWJsZV9oZWFkZXIgKwo+IAkJCXNpemVv
ZihzdHJ1Y3QgYWNwaV90YWJsZV9zcmF0KSk7Cj4tCXN1YnRhYmxlX2xlbiA9IHN1Yl9oZWFkZXIt
Pmxlbmd0aDsKPiAKPi0Jd2hpbGUgKCgodW5zaWduZWQgbG9uZylzdWJfaGVhZGVyKSArIHN1YnRh
YmxlX2xlbiAgPCB0YWJsZV9lbmQpIHsKPi0JCS8qCj4tCQkgKiBJZiBsZW5ndGggaXMgMCwgYnJl
YWsgZnJvbSB0aGlzIGxvb3AgdG8gYXZvaWQKPi0JCSAqIGluZmluaXRlIGxvb3AuCj4tCQkgKi8K
Pi0JCWlmIChzdWJ0YWJsZV9sZW4gPT0gMCkgewo+LQkJCXByX2VycigiU1JBVCBpbnZhbGlkIHpl
cm8gbGVuZ3RoXG4iKTsKPi0JCQlicmVhazsKPi0JCX0KPisJd2hpbGUgKCh1bnNpZ25lZCBsb25n
KXN1Yl9oZWFkZXIgPCB0YWJsZV9lbmQpIHsKPisJCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSAodW5z
aWduZWQgbG9uZylzdWJfaGVhZGVyOwo+Kwo+KwkJaWYgKHRhYmxlX2VuZCAtIHN0YXJ0IDwgc2l6
ZW9mKCpzdWJfaGVhZGVyKSkKPisJCQlnb3RvIGludmFsaWRfc3JhdDsKPisKPisJCXN1YnRhYmxl
X2xlbiA9IHN1Yl9oZWFkZXItPmxlbmd0aDsKPisJCWlmIChzdWJ0YWJsZV9sZW4gPCBzaXplb2Yo
KnN1Yl9oZWFkZXIpIHx8Cj4rCQkgICAgc3VidGFibGVfbGVuID4gdGFibGVfZW5kIC0gc3RhcnQp
Cj4rCQkJZ290byBpbnZhbGlkX3NyYXQ7Cj4gCj4gCQlzd2l0Y2ggKHN1Yl9oZWFkZXItPnR5cGUp
IHsKPiAJCWNhc2UgQUNQSV9TUkFUX1RZUEVfQ1BVX0FGRklOSVRZOgo+IAkJCWNwdSA9IChzdHJ1
Y3QgYWNwaV9zcmF0X2NwdV9hZmZpbml0eSAqKXN1Yl9oZWFkZXI7Cj4rCQkJaWYgKHN1YnRhYmxl
X2xlbiA8IHNpemVvZigqY3B1KSkKPisJCQkJZ290byBpbnZhbGlkX3NyYXQ7Cj4rCj4gCQkJcHht
ID0gKigodTMyICopY3B1LT5wcm94aW1pdHlfZG9tYWluX2hpKSA8PCA4IHwKPiAJCQkJCWNwdS0+
cHJveGltaXR5X2RvbWFpbl9sbzsKPiAJCQlpZiAocHhtID4gbWF4X3B4bSkKPkBAIC0yMDg0LDYg
KzIwOTAsOSBAQCBzdGF0aWMgdm9pZCBrZmRfZmluZF9udW1hX25vZGVfaW5fc3JhdChzdHJ1Y3Qg
a2ZkX25vZGUgKmtkZXYpCj4gCQkJYnJlYWs7Cj4gCQljYXNlIEFDUElfU1JBVF9UWVBFX0dFTkVS
SUNfQUZGSU5JVFk6Cj4gCQkJZ3B1ID0gKHN0cnVjdCBhY3BpX3NyYXRfZ2VuZXJpY19hZmZpbml0
eSAqKXN1Yl9oZWFkZXI7Cj4rCQkJaWYgKHN1YnRhYmxlX2xlbiA8IHNpemVvZigqZ3B1KSkKPisJ
CQkJZ290byBpbnZhbGlkX3NyYXQ7Cj4rCj4gCQkJYmRmID0gKigodTE2ICopKCZncHUtPmRldmlj
ZV9oYW5kbGVbMF0pKSA8PCAxNiB8Cj4gCQkJCQkqKCh1MTYgKikoJmdwdS0+ZGV2aWNlX2hhbmRs
ZVsyXSkpOwo+IAkJCWlmIChiZGYgPT0gcGNpX2lkKSB7Cj5AQCAtMjEwMCw5ICsyMTA5LDEzIEBA
IHN0YXRpYyB2b2lkIGtmZF9maW5kX251bWFfbm9kZV9pbl9zcmF0KHN0cnVjdCBrZmRfbm9kZSAq
a2RldikKPiAKPiAJCXN1Yl9oZWFkZXIgPSAoc3RydWN0IGFjcGlfc3VidGFibGVfaGVhZGVyICop
Cj4gCQkJCSgodW5zaWduZWQgbG9uZylzdWJfaGVhZGVyICsgc3VidGFibGVfbGVuKTsKPi0JCXN1
YnRhYmxlX2xlbiA9IHN1Yl9oZWFkZXItPmxlbmd0aDsKPiAJfQo+IAo+Kwlnb3RvIG91dDsKPisK
PitpbnZhbGlkX3NyYXQ6Cj4rCXByX2VycigiU1JBVCBjb250YWlucyBhbiBpbnZhbGlkIHN1YnRh
YmxlXG4iKTsKPitvdXQ6Cj4gCWFjcGlfcHV0X3RhYmxlKHRhYmxlX2hlYWRlcik7Cj4gCj4gCS8q
IFdvcmthcm91bmQgYmFkIGNwdS1ncHUgYmluZGluZyBjYXNlICovCj4tLSAKPjIuMzQuMQo=
