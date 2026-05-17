Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C576CCD4F25
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 06:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF98F10E077;
	Sun, 17 May 2026 06:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="iEjyGUN7";
	dkim-atps=neutral
X-Greylist: delayed 503 seconds by postgrey-1.36 at gabe;
 Sun, 17 May 2026 06:46:02 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421B610E077
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 06:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=nBx/PhWWty6Uo9YVo+AZwiZD0REBcNh1blWq7agacdE=; b=i
 EjyGUN7Zm5z/6CCA3csB4E+mXd62Myy6j99qUPCMFpYZy/FGgMRQSjfr4E+QRNyM
 rjomWEBLgRU/megPpzyOHMNgUDC2BvYI9sfYlt8uGRvUbVW/mOOYrSiuCn9BIzN6
 jTHC/RfVrt0QEGuHEKVdGEYuL42Qw6Ptf8g/df90hM=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Sun, 17 May 2026 14:39:40 +0800
 (CST)
X-Originating-IP: [58.22.7.114]
Date: Sun, 17 May 2026 14:39:40 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Bob ynn" <yanlonglong@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, andy.yan@rock-chips.com,
 dmitry.baryshkov@linaro.org
Subject: Re:[PATCH] drm/bridge: synopsys: dw-dp: fix bool function returning
 negative error code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260511063941.2070-1-yanlonglong@kylinos.cn>
References: <20260511063941.2070-1-yanlonglong@kylinos.cn>
X-CM-CTRLMSGS: ofW2n3BsdXM9MTc3ODk5OTk3OTQ0NF8xN2MzNGExYzA5ZjUxOWM0MmNiMTEzM
 2QzYzFjN2EzYg==
X-NTES-SC: AL_Qu2cCvWStkEj5iKcbekfmUgWjuw/WsG1v/Ul1YBSP556jAzp9gwwfH56PFTL2cSiLi6LrRuQdCVL+M9jQ5RxTrMBDmIzLME08+aecWncs8Z5UQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3b50eeba.e35.19e34a970e4.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: fSgvCgDnz0ysYglqDbikAA--.1067W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/
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

CkhlbGxvIEJvYiwKCkF0IDIwMjYtMDUtMTMgMTU6NTQ6MzUsICJCb2IgeW5uIiA8eWFubG9uZ2xv
bmdAa3lsaW5vcy5jbj4gd3JvdGU6Cj5Gcm9tOiB5YW5sb25nbG9uZyA8eWFubG9uZ2xvbmdAa3ls
aW5vcy5jbj4KPgo+VGhlIGZ1bmN0aW9uIGR3X2RwX3ZpZGVvX25lZWRfdnNjX3NkcCgpIGlzIGRl
Y2xhcmVkIHRvIHJldHVybiBib29sLCBidXQKPml0IHJldHVybnMgLUVJTlZBTCB3aGVuIGR3X2Rw
X2dldF9icmlkZ2Vfc3RhdGUoKSBmYWlscy4gU2luY2UgLUVJTlZBTCBpcwo+YSBub24temVybyB2
YWx1ZSAoLTIyKSwgaXQgaXMgaW1wbGljaXRseSBjb252ZXJ0ZWQgdG8gdHJ1ZSwgd2hpY2ggaXMg
dGhlCj5vcHBvc2l0ZSBvZiB0aGUgaW50ZW5kZWQgYmVoYXZpb3IKPgo+Rml4ZXM6IDg2ZWVjYzNh
OWMyZSgiZHJtL2JyaWRnZTogc3lub3BzeXM6IEFkZCBEVyBEUFRYIENvbnRyb2xsZXIgc3VwcG9y
dCBsaWJyYXJ5IikKPlNpZ25lZC1vZmYtYnk6IHlhbmxvbmdsb25nIDx5YW5sb25nbG9uZ0BreWxp
bm9zLmNuPgoKClJldmlld2VkLWJ5OiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4KClRoYW5r
cwoKPi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYyB8IDIgKy0K
PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYwo+aW5kZXggMjE1NDFiZTA5NGM0Li43Yjk5
ZDkxYjM0NTYgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3
LWRwLmMKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYwo+QEAg
LTExNDMsNyArMTE0Myw3IEBAIHN0YXRpYyBib29sIGR3X2RwX3ZpZGVvX25lZWRfdnNjX3NkcChz
dHJ1Y3QgZHdfZHAgKmRwKQo+IAo+IAlzdGF0ZSA9IGR3X2RwX2dldF9icmlkZ2Vfc3RhdGUoZHAp
Owo+IAlpZiAoIXN0YXRlKQo+LQkJcmV0dXJuIC1FSU5WQUw7Cj4rCQlyZXR1cm4gZmFsc2U7Cj4g
Cj4gCWlmICghbGluay0+dnNjX3NkcF9zdXBwb3J0ZWQpCj4gCQlyZXR1cm4gZmFsc2U7Cj4tLSAK
PjIuNDMuMAo=
