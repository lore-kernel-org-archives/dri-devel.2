Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B27C5DF6E
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 12:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AAE10E2A5;
	Sun, 16 Aug 2026 12:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ilbLh/nS";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA9B10E2A5
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=2/wA3tJOeiho4AP+RBoC3wsRG+aihxkN9Cdf0ORQd9o=; b=i
 lbLh/nSBKv7TXExQRUlC2n1NJnXoEs3S+0U9NjMkq72ORnInyksjYJvisKa5Ilb5
 9mp9SyZSAGJzos3hQvuFk9DWCtmlzxjNhYBWSERe6lh1WTB9Fic7MK5c8Cd5sztr
 ANDZrlvdNtaHnnWbw8qKpG1f1HepUbZqSQilLakjXU=
Received: from andyshrk$163.com ( [61.154.14.86] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Sun, 16 Aug 2026 20:37:21 +0800
 (CST)
X-Originating-IP: [61.154.14.86]
Date: Sun, 16 Aug 2026 20:37:21 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>,
 "Damon Ding" <damon.ding@rock-chips.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Alexey Charkov" <alchark@flipper.net>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re:[PATCH v11 01/21] drm/bridge: synopsys: dw-dp: Register DP AUX
 on bridge attach
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-1-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-1-0d508505f383@collabora.com>
X-NTES-SC: AL_Qu2TBPSTvEAv5yGQbekfmUgWjuw/WsG1v/Ul1YBSP556jCrp6yoHelRJMXX9zsmrEg+xlzSHfCNT0M9dRK11eZMXMP4vIuty++YsvMxEX20H8A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <39274bba.18a3.1a00a939caf.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZCgvCgDnjwsBr4FqKMcyAA--.25036W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbC7gHmRWqBrwFWqAAA33
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

SGVsbG8gU2ViYXN0aWFu77yMCgpBdCAyMDI2LTA4LTA3IDAxOjAyOjA3LCAiU2ViYXN0aWFuIFJl
aWNoZWwiIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPiB3cm90ZToKPlVucmVnaXN0
ZXIgdGhlIERQIEFVWCBkZXZpY2UgYXQgdGhlIHJpZ2h0IHNwb3QgYXMgZG9jdW1lbnRlZCBpbiB0
aGUKPmRybV9kcF9hdXhfcmVnaXN0ZXIoKSBmdW5jdGlvbiBkZXNjcmlwdGlvbi4gVGhpcyBoZWxw
cyB0aGF0IGl0IGlzCj5vbmx5IGFjY2Vzc2VkIHdoZW4gdGhlIERSTSBkZXZpY2UgaXMgcmVhZHkg
YW5kIHRoZSBicmlkZ2UgaXMgcG93ZXJlZAo+YW5kIGluaXRpYWxpemVkIChmdXJ0aGVyIGZpeGVz
IGFyZSByZXF1aXJlZCBmb3IgdGhhdCkuCj4KPkZpeGVzOiA4NmVlY2MzYTljMmUgKCJkcm0vYnJp
ZGdlOiBzeW5vcHN5czogQWRkIERXIERQVFggQ29udHJvbGxlciBzdXBwb3J0IGxpYnJhcnkiKQo+
UmVwb3J0ZWQtYnk6IFNhc2hpa28gPHNhc2hpa28tYm90QGtlcm5lbC5vcmc+Cj5TaWduZWQtb2Zm
LWJ5OiBTZWJhc3RpYW4gUmVpY2hlbCA8c2ViYXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT4K
Pi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYyB8IDU1ICsrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+IDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRp
b25zKCspLCAyMCBkZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9i
cmlkZ2Uvc3lub3BzeXMvZHctZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMv
ZHctZHAuYwo+aW5kZXggOGI4NTI5ZTE3MjNjLi42MGZlYjNkMWUxNGIgMTAwNjQ0Cj4tLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMKPisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYwo+QEAgLTE4MTMsNyArMTgxMywzNiBAQCBzdGF0
aWMgc3RydWN0IGRybV9icmlkZ2Vfc3RhdGUgKmR3X2RwX2JyaWRnZV9hdG9taWNfZHVwbGljYXRl
X3N0YXRlKHN0cnVjdCBkcm1fYgo+IAlyZXR1cm4gJnN0YXRlLT5iYXNlOwo+IH0KPiAKPitzdGF0
aWMgaW50IGR3X2RwX2JyaWRnZV9hdHRhY2goc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwKPisJ
CQkgICAgICAgc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyLAo+KwkJCSAgICAgICBlbnVtIGRy
bV9icmlkZ2VfYXR0YWNoX2ZsYWdzIGZsYWdzKQo+K3sKPisJc3RydWN0IGR3X2RwICpkcCA9IGJy
aWRnZV90b19kcChicmlkZ2UpOwo+KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBkcC0+ZGV2Owo+Kwlp
bnQgcmV0Owo+Kwo+KwlkcC0+YXV4LmRldiA9IGRldjsKPisJZHAtPmF1eC5kcm1fZGV2ID0gZW5j
b2Rlci0+ZGV2Owo+KwlkcC0+YXV4Lm5hbWUgPSBkZXZfbmFtZShkZXYpOwo+KwlkcC0+YXV4LnRy
YW5zZmVyID0gZHdfZHBfYXV4X3RyYW5zZmVyOwo+Kwo+KwlyZXQgPSBkcm1fZHBfYXV4X3JlZ2lz
dGVyKCZkcC0+YXV4KTsKPisJaWYgKHJldCkKPisJCWRldl9lcnIoZGV2LCAiQXV4IHJlZ2lzdGVy
IGZhaWxlZDogJWRcbiIsIHJldCk7Cj4rCj4rCXJldHVybiByZXQ7Cj4rfQo+Kwo+K3N0YXRpYyB2
b2lkIGR3X2RwX2JyaWRnZV9kZXRhY2goc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSkKPit7Cj4r
CXN0cnVjdCBkd19kcCAqZHAgPSBicmlkZ2VfdG9fZHAoYnJpZGdlKTsKPisKPisJZHJtX2RwX2F1
eF91bnJlZ2lzdGVyKCZkcC0+YXV4KTsKPit9Cj4rCj4gc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1f
YnJpZGdlX2Z1bmNzIGR3X2RwX2JyaWRnZV9mdW5jcyA9IHsKPisJLmF0dGFjaCA9IGR3X2RwX2Jy
aWRnZV9hdHRhY2gsCj4rCS5kZXRhY2ggPSBkd19kcF9icmlkZ2VfZGV0YWNoLAo+IAkuYXRvbWlj
X2R1cGxpY2F0ZV9zdGF0ZSA9IGR3X2RwX2JyaWRnZV9hdG9taWNfZHVwbGljYXRlX3N0YXRlLAo+
IAkuYXRvbWljX2Rlc3Ryb3lfc3RhdGUgPSBkcm1fYXRvbWljX2hlbHBlcl9icmlkZ2VfZGVzdHJv
eV9zdGF0ZSwKPiAJLmF0b21pY19jcmVhdGVfc3RhdGUgPSBkcm1fYXRvbWljX2hlbHBlcl9icmlk
Z2VfY3JlYXRlX3N0YXRlLAo+QEAgLTIwNDMsMjAgKzIwNzIsMTAgQEAgc3RydWN0IGR3X2RwICpk
d19kcF9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVy
LAo+IAlpZiAocmV0KQo+IAkJcmV0dXJuIEVSUl9QVFIocmV0KTsKPiAKPi0JZHAtPmF1eC5kZXYg
PSBkZXY7Cj4tCWRwLT5hdXguZHJtX2RldiA9IGVuY29kZXItPmRldjsKPi0JZHAtPmF1eC5uYW1l
ID0gZGV2X25hbWUoZGV2KTsKPi0JZHAtPmF1eC50cmFuc2ZlciA9IGR3X2RwX2F1eF90cmFuc2Zl
cjsKPi0JcmV0ID0gZHJtX2RwX2F1eF9yZWdpc3RlcigmZHAtPmF1eCk7Cj4tCWlmIChyZXQpIHsK
Pi0JCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJBdXggcmVnaXN0ZXIgZmFpbGVkXG4iKTsKPi0J
CXJldHVybiBFUlJfUFRSKHJldCk7Cj4tCX0KPi0KPiAJcmV0ID0gZHJtX2JyaWRnZV9hdHRhY2go
ZW5jb2RlciwgYnJpZGdlLCBOVUxMLCBEUk1fQlJJREdFX0FUVEFDSF9OT19DT05ORUNUT1IpOwo+
IAlpZiAocmV0KSB7Cj4gCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIGF0dGFj
aCBicmlkZ2VcbiIpOwo+LQkJZ290byB1bnJlZ2lzdGVyX2F1eDsKPisJCXJldHVybiBFUlJfUFRS
KHJldCk7Cj4gCX0KPiAKPiAJZHdfZHBfaW5pdF9odyhkcCk7Cj5AQCAtMjA2NCwzNyArMjA4Mywz
MyBAQCBzdHJ1Y3QgZHdfZHAgKmR3X2RwX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
ZHJtX2VuY29kZXIgKmVuY29kZXIsCj4gCXJldCA9IHBoeV9pbml0KGRwLT5waHkpOwo+IAlpZiAo
cmV0KSB7Cj4gCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAicGh5IGluaXQgZmFpbGVkXG4iKTsK
Pi0JCWdvdG8gdW5yZWdpc3Rlcl9hdXg7Cj4rCQlyZXR1cm4gRVJSX1BUUihyZXQpOwo+IAl9Cj4g
Cj4gCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIGR3X2RwX3BoeV9leGl0LCBk
cCk7Cj4gCWlmIChyZXQpCj4tCQlnb3RvIHVucmVnaXN0ZXJfYXV4Owo+KwkJcmV0dXJuIEVSUl9Q
VFIocmV0KTsKPiAKPiAJZHAtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7Cj4gCWlm
IChkcC0+aXJxIDwgMCkgewo+IAkJcmV0ID0gZHAtPmlycTsKPi0JCWdvdG8gdW5yZWdpc3Rlcl9h
dXg7Cj4rCQlyZXR1cm4gRVJSX1BUUihyZXQpOwo+IAl9Cj4gCj4gCXJldCA9IGRldm1fcmVxdWVz
dF90aHJlYWRlZF9pcnEoZGV2LCBkcC0+aXJxLCBOVUxMLCBkd19kcF9pcnEsCj4gCQkJCQlJUlFG
X09ORVNIT1QsIGRldl9uYW1lKGRldiksIGRwKTsKPiAJaWYgKHJldCkgewo+IAkJZGV2X2Vycl9w
cm9iZShkZXYsIHJldCwgImZhaWxlZCB0byByZXF1ZXN0IGlycVxuIik7CgoKICBBZnRlciB0aGlz
IHBhdGNoWzBdICBpcyBhcHBsaWVkLCB0aGVyZSB3aWxsIGJlIGEgY29uZmxpY3QgaGVyZS4KCiBb
MF1odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MjMxMzE2NDkuMTM0MTI3LTYtcGFu
Y2h1YW5nQHZpdm8uY29tLyN0CgoKPi0JCWdvdG8gdW5yZWdpc3Rlcl9hdXg7Cj4rCQlyZXR1cm4g
RVJSX1BUUihyZXQpOwo+IAl9CgoKCj4gCj4gCXJldHVybiBkcDsKPi0KPi11bnJlZ2lzdGVyX2F1
eDoKPi0JZHJtX2RwX2F1eF91bnJlZ2lzdGVyKCZkcC0+YXV4KTsKPi0JcmV0dXJuIEVSUl9QVFIo
cmV0KTsKPiB9Cj4gRVhQT1JUX1NZTUJPTF9HUEwoZHdfZHBfYmluZCk7Cj4gCj4gdm9pZCBkd19k
cF91bmJpbmQoc3RydWN0IGR3X2RwICpkcCkKPiB7Cj4tCWRybV9kcF9hdXhfdW5yZWdpc3Rlcigm
ZHAtPmF1eCk7Cj4rCS8qIG5vdGhpbmcgdG8gZG8gKi8KPiB9Cj4gRVhQT1JUX1NZTUJPTF9HUEwo
ZHdfZHBfdW5iaW5kKTsKPiAKPgo+LS0gCj4yLjUzLjAKPgo=
