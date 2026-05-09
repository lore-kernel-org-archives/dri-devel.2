Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20694CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B671A10E602;
	Sun, 10 May 2026 10:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="VNBDnMKA";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D186410E35D
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 04:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=Mbl+x1W7P7FyK/cziWr1i5ksKRIVvTwpS2LBhPZA0IM=;
 b=VNBDnMKAv1+YEsQjx5EgqNFwXHR4P+s3WzIhllJAAYJwBtFGjBvRRrxZPNQuT/
 ss6ufoqhL1H3gBHmtyeJ1oqMmgfIuJfkDRaTiR4PN/cwAcOGJ61yJ2lQyG8ILDoe
 myDC8yhoQlQN6zC5c4B/NHdxSPAdpr/NenviT8xw+4lnc=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wAXvjBMtf5prINJAQ--.2777S2; 
 Sat, 09 May 2026 12:17:17 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] drm/rockchip: Fix dangling crtc->state in
 vop2_crtc_reset()
Message-ID: <177830023497.246051.17896876640798272304@openclaw.local>
Date: Sat, 09 May 2026 12:17:14 +0800
In-Reply-To: <177830021804.246051.8309807801406217751@openclaw.local>
References: <177830021804.246051.8309807801406217751@openclaw.local>
X-CM-TRANSID: _____wAXvjBMtf5prINJAQ--.2777S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xGFykGw4kCF4DWF4rKrg_yoW8Jw4fpr
 s7Cryj9r4UKrWjqrnrJr1xursak3ZFyayxGr97Gw13u3Wjqwn8CrnI9ryqv3y7ArWfA3yj
 yrs7Jw45ZF4qyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U39N-UUUUU=
X-Originating-IP: [43.248.8.92]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbC8A2a7Wn+tU3LKQAA3H
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

SW4gdm9wMl9jcnRjX3Jlc2V0KCksIGlmIGt6YWxsb2MoKSBmYWlscyB0byBhbGxvY2F0ZSBhIG5l
dwpyb2NrY2hpcF9jcnRjX3N0YXRlLCB0aGUgZnVuY3Rpb24gcmV0dXJucyBlYXJseSB3aXRob3V0
IHNldHRpbmcKY3J0Yy0+c3RhdGUgdG8gTlVMTC4gSG93ZXZlciwgdGhlIG9sZCBzdGF0ZSBoYXMg
YWxyZWFkeSBiZWVuIGRlc3Ryb3llZAphbmQgZnJlZWQgYnkgX19kcm1fYXRvbWljX2hlbHBlcl9j
cnRjX2Rlc3Ryb3lfc3RhdGUoKSBhbmQga2ZyZWUoKS4KClRoaXMgbGVhdmVzIGNydGMtPnN0YXRl
IGFzIGEgZGFuZ2xpbmcgcG9pbnRlci4gQW55IHN1YnNlcXVlbnQgYWNjZXNzIHRvCmNydGMtPnN0
YXRlIChlLmcuLCB0aHJvdWdoIHRvX3JvY2tjaGlwX2NydGNfc3RhdGUoKSkgd2lsbCByZXN1bHQg
aW4gYQp1c2UtYWZ0ZXItZnJlZSBvciBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGxlYWRpbmcg
dG8gYSBrZXJuZWwgY3Jhc2guCgpGaXggYnkgc2V0dGluZyBjcnRjLT5zdGF0ZSA9IE5VTEwgd2hl
biBremFsbG9jKCkgZmFpbHMsIGVuc3VyaW5nIHRoZQpwb2ludGVyIGlzIGluIGEgd2VsbC1kZWZp
bmVkIHN0YXRlLgoKU2lnbmVkLW9mZi1ieTogSmlhcWkgPHNoaWppYXFpX2RldmVsb3BAMTYzLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYyB8IDQg
KysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jIGIv
ZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMKaW5kZXggOGFmYWJl
MjExOGE5Li4xMjM0NTY3ODkwYWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hp
cC9yb2NrY2hpcF9kcm1fdm9wMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2Nr
Y2hpcF9kcm1fdm9wMi5jCkBAIC0yMDgyLDggKzIwODIsMTAgQEAgc3RhdGljIHZvaWQgdm9wMl9j
cnRjX3Jlc2V0KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKIAl9CgogCXZjc3RhdGUgPSBremFsbG9j
KHNpemVvZigqdmNzdGF0ZSksIEdGUF9LRVJORUwpOwotCWlmICghdmNzdGF0ZSkKKwlpZiAoIXZj
c3RhdGUpIHsKKwkJY3J0Yy0+c3RhdGUgPSBOVUxMOwogCQlyZXR1cm47CisJfQoKIAljcnRjLT5z
dGF0ZSA9ICZ2Y3N0YXRlLT5iYXNlOwogCWNydGMtPnN0YXRlLT5jcnRjID0gY3J0YzsKLS0KMi40
MC4wCg==

