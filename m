Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053DECD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AAB10E126;
	Sun, 10 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="cTkOwYEu";
	dkim-atps=neutral
X-Greylist: delayed 6898 seconds by postgrey-1.36 at gabe;
 Sat, 09 May 2026 04:17:18 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C4C10E35D
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 04:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=7v8CJ0e4//stA9Xc55Ta1qaFTlw77C4x6BLM2ypR4Sc=;
 b=cTkOwYEuDPOmRwQDnTHTI/b8/Ku67m2OgeDs3W+aKb9u7EANzQmS0sNatZXJAu
 HSnO4qDFFhrMpQd+xy51aekMhR3JbniSpsMlqPj1gvGvohuVKiaZyEaiuI8evtrU
 mTVUHy4GgQ7JcG+qNPw1S2Hoh+/NwznHfdi69sMSLQlZA=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wA3yVtEtf5pswxQAQ--.31859S2; 
 Sat, 09 May 2026 12:17:09 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drm/rockchip: Fix of_node reference leak in
 rockchip_drm_encoder_set_crtc_endpoint_id()
Message-ID: <177830022712.246051.4119979110908560490@openclaw.local>
Date: Sat, 09 May 2026 12:17:07 +0800
In-Reply-To: <177830021804.246051.8309807801406217751@openclaw.local>
References: <177830021804.246051.8309807801406217751@openclaw.local>
X-CM-TRANSID: _____wA3yVtEtf5pswxQAQ--.31859S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4UWr18Xry5ZFW3Zw17trb_yoW8Ar13pa
 n3Gr9Yvr48GrWfWr10yr47ArySkws2va17CF97C3W3Zan3ArnYyw1fKF1vgr15ArWxuFyj
 yrs7Ga4j9F17urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE4EiUUUUU=
X-Originating-IP: [43.248.8.92]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbCzQaY62n+tUaJPgAA3r
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

VGhlIGZ1bmN0aW9uIHJvY2tjaGlwX2RybV9lbmNvZGVyX3NldF9jcnRjX2VuZHBvaW50X2lkKCkg
YWNxdWlyZXMgZGV2aWNlCnRyZWUgbm9kZSByZWZlcmVuY2VzIHZpYSBvZl9ncmFwaF9nZXRfZW5k
cG9pbnRfYnlfcmVncygpIGFuZApvZl9ncmFwaF9nZXRfcmVtb3RlX2VuZHBvaW50KCksIGJ1dCBu
ZXZlciByZWxlYXNlcyB0aGVtLiBUaGlzIGhhcHBlbnMgb24KYWxsIGV4aXQgcGF0aHMsIGluY2x1
ZGluZyB0aGUgc3VjY2VzcyBwYXRoLgoKVGhpcyBsZWFkcyB0byByZWZlcmVuY2UgY291bnQgbGVh
a3MgdGhhdCBhY2N1bXVsYXRlIGR1cmluZyBlbmNvZGVyIHByb2JlLgpJbiBkZWZlcnJlZCBwcm9i
ZSBzY2VuYXJpb3Mgb3IgbW9kdWxlIHJlbG9hZCwgdGhlIGxlYWtlZCByZWZlcmVuY2VzIGNhbgpj
YXVzZSBvZl9ub2RlX2dldCgpIHRvIGV2ZW50dWFsbHkgcmV0dXJuIC1FTk9NRU0sIGJyZWFraW5n
IHN1YnNlcXVlbnQKZGV2aWNlIHRyZWUgcGFyc2luZy4KCkZpeCBieSBhZGRpbmcgdGhlIGNvcnJl
c3BvbmRpbmcgb2Zfbm9kZV9wdXQoKSBjYWxscyBmb3IgYm90aCAnZW4nIGFuZAoncmVuJywgYW5k
IHVzZSBhIHVuaWZpZWQgZXJyb3IgcGF0aCB0byBhdm9pZCBkdXBsaWNhdGlvbi4KClNpZ25lZC1v
ZmYtYnk6IEppYXFpIDxzaGlqaWFxaV9kZXZlbG9wQDE2My5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9kcnYuYyB8IDE0ICsrKysrKysrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9kcnYuYyBiL2RyaXZlcnMvZ3B1
L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmMKaW5kZXggOGFmYWJlMjExOGE5Li4xMjM0
NTY3ODkwYWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9k
cm1fZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9kcnYu
YwpAQCAtMjc4LDE4ICsyNzgsMjIgQEAgaW50IHJvY2tjaGlwX2RybV9lbmNvZGVyX3NldF9jcnRj
X2VuZHBvaW50X2lkKHN0cnVjdCByb2NrY2hpcF9lbmNvZGVyICpya2VuY29kZXIsCiB7CiAJc3Ry
dWN0IG9mX2VuZHBvaW50IGVwOwogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqZW4sICpyZW47CiAJaW50
IHJldDsKCiAJZW4gPSBvZl9ncmFwaF9nZXRfZW5kcG9pbnRfYnlfcmVncyhucCwgcG9ydCwgcmVn
KTsKIAlpZiAoIWVuKQogCQlyZXR1cm4gLUVOT0VOVDsKCiAJcmVuID0gb2ZfZ3JhcGhfZ2V0X3Jl
bW90ZV9lbmRwb2ludChlbik7CiAJaWYgKCFyZW4pCi0JCXJldHVybiAtRU5PRU5UOworCQlnb3Rv
IGVycl9wdXRfZW47CgogCXJldCA9IG9mX2dyYXBoX3BhcnNlX2VuZHBvaW50KHJlbiwgJmVwKTsK
IAlpZiAocmV0KQotCQlyZXR1cm4gcmV0OworCQlnb3RvIGVycl9wdXRfcmVuOwoKIAlya2VuY29k
ZXItPmNydGNfZW5kcG9pbnRfaWQgPSBlcC5pZDsKCi0JcmV0dXJuIDA7CitlcnJfcHV0X3JlbjoK
KwlvZl9ub2RlX3B1dChyZW4pOworZXJyX3B1dF9lbjoKKwlvZl9ub2RlX3B1dChlbik7CisJcmV0
dXJuIHJldDsKIH0KCiAvKgotLQoyLjQwLjAK

