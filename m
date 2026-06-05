Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C08CCD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 06:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0179C11A488;
	Fri,  5 Jun 2026 06:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="fDFAxgqZ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A08611A488
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 06:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=ZiFtKQZZSzaa6La/dIlsHqg4rVW+JmWCuMSQ5VwN9HU=; b=f
 DFAxgqZHY/kfSehR3hoVmCDc7zg91YBtJTjZryLn4RrQYnSxeLAoin2r3RxiGxhS
 xoVfgzI1u/q9BoONAXk5j58A1qzRc0CJsLMcjlmt9/bxm9ddzanxWIAFfH1FtKBH
 xgRNI+arPfH3uN0PGwAnSvgx7wpnhIPhsgUuqeNjXk=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Fri, 5 Jun 2026 14:41:26 +0800 (CST)
X-Originating-IP: [113.200.174.80]
Date: Fri, 5 Jun 2026 14:41:26 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:[PATCH v2] drm/vblank: Reject 0-period timers to prevent hrtimer
 storm
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260523025447.581709-1-w15303746062@163.com>
References: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
 <20260523025447.581709-1-w15303746062@163.com>
X-NTES-SC: AL_Qu2TAvqfvk4j4CWfbOkfmU0Qguw9Xcq5uPkj34FWN5t8jDrp5QodX0JFHVfbys6/Dy2ItRqsex1+1f9nQoZgZZ0Jt3we5vz6boNvjzdYaiQPEw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <33239270.5344.19e9683e439.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cSgvCgDXf0yWbyJqdkoDAA--.27889W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xYkCGoib5bOVQAA3v
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

CkhpIE1hYXJ0ZW4sIE1heGltZSwgVGhvbWFzLCBhbmQgYWxsLAoKQSBnZW50bGUgcGluZyBvbiB0
aGlzIHYyIHBhdGNoLgoKSXQgaGFzIGJlZW4gYWJvdXQgdHdvIHdlZWtzIHNpbmNlIHN1Ym1pc3Np
b24uIEFzIGEgcXVpY2sgcmVtaW5kZXIsIHRoaXMgdjIgCmFkZHJlc3NlcyB0aGUgcHJldmlvdXMg
ZmVlZGJhY2sgYnkgbW92aW5nIHRoZSB6ZXJvLXBlcmlvZCB2YWxpZGF0aW9uIApkaXJlY3RseSBp
bnRvIHRoZSBEUk0gY29yZSAoYGRybV92YmxhbmsuY2ApLiBUaGlzIHByb3RlY3RzIGFsbCB2aXJ0
dWFsIApkcml2ZXJzIHJlbHlpbmcgb24gdGhlIHNvZnR3YXJlIHZibGFuayB0aW1lciBmcm9tIHRo
ZSBocnRpbWVyIHN0b3JtIERvUy4gCkl0IGFsc28gZHJvcHMgdGhlIFdBUk5fT05fT05DRSgpIHRv
IHByZXZlbnQgdW5wcml2aWxlZ2VkIHVzZXJzcGFjZSBmcm9tIAp0cmlnZ2VyaW5nIHBhbmljcy4K
CkNvdWxkIGFueW9uZSBwbGVhc2UgdGFrZSBhIGxvb2sgd2hlbiB5b3UgaGF2ZSBhIG1vbWVudCwg
b3IgbGV0IG1lIGtub3cgCmlmIGFueSBmdXJ0aGVyIGFkanVzdG1lbnRzIGFyZSBuZWVkZWQ/CgpC
ZXN0IHJlZ2FyZHMsCk1pbmd5dQoKQXQgMjAyNi0wNS0yMyAxMDo1NDo0NywgdzE1MzAzNzQ2MDYy
QDE2My5jb20gd3JvdGU6Cj5Gcm9tOiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlh
bi5lZHUuY24+Cj4KPkZ1enplcnMgbGlrZSBTeXprYWxsZXIgY2FuIHN1Ym1pdCBleHRyZW1lbHkg
bWFsaWNpb3VzIGRpc3BsYXkgbW9kZXMKPnRocm91Z2ggRFJNX0lPQ1RMX01PREVfU0VUQ1JUQy4g
SWYgdXNlcnNwYWNlIHBhc3NlcyBhIG1vZGUgd2l0aCBhCj5tYXNzaXZlIHBpeGVsIGNsb2NrIChj
cnRjX2Nsb2NrKSBhbmQgc21hbGwgcmVzb2x1dGlvbiAoaHRvdGFsL3Z0b3RhbCksCj50aGUgaW50
ZWdlciBkaXZpc2lvbiBpbiBkcm1fY2FsY190aW1lc3RhbXBpbmdfY29uc3RhbnRzKCkgdHJ1bmNh
dGVzCj50aGUgcmVzdWx0aW5nIGZyYW1lIGR1cmF0aW9uICh2YmxhbmstPmZyYW1lZHVyX25zKSB0
byAwLgo+Cj5XaGVuIHZpcnR1YWwgZGlzcGxheSBkcml2ZXJzIChzdWNoIGFzIHZtd2dmeCBvciB2
a21zKSByZWx5IG9uIHRoZSBEUk0KPmNvcmUncyBzb2Z0d2FyZSB2Ymxhbmsgc2ltdWxhdGlvbiwg
ZHJtX2NydGNfdmJsYW5rX3N0YXJ0X3RpbWVyKCkgaXMKPmNhbGxlZC4gSXQgYmxpbmRseSBjb252
ZXJ0cyB0aGlzIDAtbnMgZnJhbWVkdXJfbnMgaW50byBhIGt0aW1lIGludGVydmFsCj5hbmQgc3Rh
cnRzIHRoZSBocnRpbWVyLiBBbiBocnRpbWVyIHdpdGggYSAwLXBlcmlvZCBmaXJlcyBpbnN0YW50
bHkgYW5kCj5jb250aW51b3VzbHkuIFNpbmNlIGhydGltZXJfZm9yd2FyZF9ub3coKSBjYW5ub3Qg
YWR2YW5jZSB0aW1lIGZvciBhCj4wLXBlcmlvZCwgdGhlIENQVSBnZXRzIGxvY2tlZCBpbiBhbiBp
bmZpbml0ZSBoYXJkLUlSUSBsb29wLCBzdGFydmluZwo+dGhlIHN5c3RlbSBhbmQgY2F1c2luZyBt
YXNzaXZlIFJDVSBzdGFsbHMuCj4KPkZpeCB0aGlzIERvUyB2dWxuZXJhYmlsaXR5IGJ5IGFkZGlu
ZyBhIGRlZmVuc2l2ZSBzYW5pdHkgY2hlY2sgaW4KPmRybV9jcnRjX3ZibGFua19zdGFydF90aW1l
cigpIHRvIHJlamVjdCBhIDAtbnMgZnJhbWUgZHVyYXRpb24sIGFsbG93aW5nCj50aGUgRFJNIGNv
cmUgdG8gZ3JhY2VmdWxseSByZWplY3QgdGhlIG1hbGljaW91cyBtb2RlLgo+Cj5TaWduZWQtb2Zm
LWJ5OiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+Cj4tLS0KPkNo
YW5nZXMgaW4gdjI6Cj4tIE1vdmVkIHRoZSBkZWZlbnNpdmUgY2hlY2sgZnJvbSB2bXdnZnggdG8g
ZHJtX3ZibGFuay5jLiBUaGUgdGltZXIKPiAgbG9naWMgd2FzIHJlZmFjdG9yZWQgaW50byB0aGUg
RFJNIGNvcmUsIHNvIHBsYWNpbmcgdGhlIGNoZWNrIGhlcmUKPiAgcHJvdGVjdHMgYWxsIGRyaXZl
cnMgcmVseWluZyBvbiB0aGUgY29yZSBzb2Z0d2FyZSB2YmxhbmsgdGltZXIuCj4tIERyb3BwZWQg
V0FSTl9PTl9PTkNFKCkgdG8gcHJldmVudCB1bnByaXZpbGVnZWQgdXNlcnNwYWNlIGZyb20gZWFz
aWx5Cj4gIHRyaWdnZXJpbmcga2VybmVsIHBhbmljcyBvbiBzeXN0ZW1zIHdpdGggcGFuaWNfb25f
d2FybiBlbmFibGVkLgo+Cj4gZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYyB8IDEwICsrKysr
KysrKysKPiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Cj5kaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5r
LmMKPmluZGV4IGY5MGZiMmQxM2U0Mi4uYjM4ZDBiMzBhNjUxIDEwMDY0NAo+LS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2RybV92YmxhbmsuYwo+KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV92Ymxhbmsu
Ywo+QEAgLTIyNDEsNiArMjI0MSwxNiBAQCBpbnQgZHJtX2NydGNfdmJsYW5rX3N0YXJ0X3RpbWVy
KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPiAKPiAJZHJtX2NhbGNfdGltZXN0YW1waW5nX2NvbnN0
YW50cyhjcnRjLCAmY3J0Yy0+bW9kZSk7Cj4gCj4rCS8qCj4rCSAqIERFRkVOU0lWRSBDSEVDSzoK
PisJICogZHJtX2NhbGNfdGltZXN0YW1waW5nX2NvbnN0YW50cygpIHRydW5jYXRlcyBmcmFtZWR1
cl9ucyB0byAwIGlmCj4rCSAqIHVzZXJzcGFjZSBwcm92aWRlcyBhIG1hbGljaW91cyBtb2RlIHdp
dGggYSBodWdlIGNydGNfY2xvY2sgYW5kCj4rCSAqIHNtYWxsIGh0b3RhbC92dG90YWwuIFByZXZl
bnQgYW4gaW5maW5pdGUgaGFyZC1JUlEgbG9vcCBmcm9tIGEKPisJICogMC1wZXJpb2QgaHJ0aW1l
ciBieSByZWplY3Rpbmcgc3VjaCBtb2Rlcy4KPisJICovCj4rCWlmICh1bmxpa2VseSh2Ymxhbmst
PmZyYW1lZHVyX25zID09IDApKQo+KwkJcmV0dXJuIC1FSU5WQUw7Cj4rCj4gCXNwaW5fbG9ja19p
cnFzYXZlKCZ2dGltZXItPmludGVydmFsX2xvY2ssIGZsYWdzKTsKPiAJdnRpbWVyLT5pbnRlcnZh
bCA9IG5zX3RvX2t0aW1lKHZibGFuay0+ZnJhbWVkdXJfbnMpOwo+IAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZ2dGltZXItPmludGVydmFsX2xvY2ssIGZsYWdzKTsKPi0tIAo+Mi4zNC4xCg==
