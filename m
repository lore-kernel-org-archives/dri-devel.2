Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E32CD37B5
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19F010E40E;
	Sun, 10 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="WOjjt65R";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9095810E35D
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 04:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=AtLlE8BZecYSdlr9Dxuoyv1YHpTPgMWAv1Fu9o0Wbig=;
 b=WOjjt65Rz/Qd5CN7oYpV8FjxlaB81wsSDPGpIHNOupNOoQyx85p83jAcSZQn9j
 GKxOuTJI7rpWRgWcy2YeHjoCAq0HQx03m0BD2h54RUcjtTEBTYC89vv98zbjRxFd
 VKeaeBXzw9QJ/2eeiuPnV8ntiFgqeR8s6y2oz9op69Pdw=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wDXZNs6tf5p6HVGAQ--.38867S2; 
 Sat, 09 May 2026 12:17:01 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] drm/rockchip: Fix error handling and resource leaks in
 Rockchip DRM drivers
Message-ID: <177830021804.246051.8309807801406217751@openclaw.local>
Date: Sat, 09 May 2026 12:16:58 +0800
X-CM-TRANSID: _____wDXZNs6tf5p6HVGAQ--.38867S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw17Ar43ZFW5WrW8uw13XFb_yoW5JF1rpr
 s5W390vr45GrWj9rs7AF4xAr1F9wsFvayIgF97K343ZF15Cr17J34S9w1kuF17Jr93A3W7
 trnrJrWrZw4jvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUpnQUUUUU=
X-Originating-IP: [43.248.8.92]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbC7x6W6Wn+tT7DJQAA30
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

VGhpcyBpcyB2MiBvZiB0aGUgcGF0Y2ggc2VyaWVzIHRoYXQgd2FzIHByZXZpb3VzbHkgd2l0aGRy
YXduIGR1ZSB0bwphIGNyaXRpY2FsIGJ1ZyBpbiBQYXRjaCAzLzYuCgpDaGFuZ2VzIGluIHYyOgog
IC0gUGF0Y2ggMy82OiBSZW1vdmVkIGluY29ycmVjdCBkZXZtX2ZyZWVfaXJxKCkgY2FsbCBpbiBl
cnJvciBwYXRoLgogICAgVGhlIElSUSByZWdpc3RlcmVkIHZpYSBkZXZtX3JlcXVlc3RfaXJxKCkg
aXMgbWFuYWdlZCBieSBkZXZyZXMgYW5kCiAgICBtdXN0IE5PVCBiZSBtYW51YWxseSBmcmVlZC4g
VGhlIGNvcnJlY3RlZCBwYXRjaCBzaW1wbHkganVtcHMgdG8KICAgIGVycl9jcnRjcyBsYWJlbCBm
b3IgcHJvcGVyIGNsZWFudXAgdmlhIHZvcDJfZGVzdHJveV9jcnRjcygpLgogIC0gUGF0Y2ggNS82
OiBGaXhlZCB0cmFpbGluZyBmb3JtYXQgaXNzdWUgdGhhdCBjYXVzZWQgY2hlY2twYXRjaCBFUlJP
Ui4KClRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIDYgYnVncyBpbiB0aGUgUm9ja2NoaXAgRFJNIGRy
aXZlciBzdWJzeXN0ZW0sCmlkZW50aWZpZWQgdGhyb3VnaCBzdGF0aWMgY29kZSBhbmFseXNpcyBh
bmQgY29uZmlybWVkIGJ5IHRlY2huaWNhbCByZXZpZXcuCgpUaGUgYnVncyByYW5nZSBmcm9tIENy
aXRpY2FsIChvZl9ub2RlIHJlZmVyZW5jZSBsZWFrcywgdXNlLWFmdGVyLWZyZWUpCnRvIE1lZGl1
bSAodW5jaGVja2VkIHJldHVybiB2YWx1ZXMpLCBhbmQgc3BhbiA1IGRpZmZlcmVudCBzb3VyY2Ug
ZmlsZXMuCkVhY2ggcGF0Y2ggYWRkcmVzc2VzIGV4YWN0bHkgb25lIGJ1ZyB0byBmYWNpbGl0YXRl
IHJldmlldyBhbmQgYmlzZWN0aW9uLgoKU3VtbWFyeSBvZiBmaXhlczoKCiAgUGF0Y2ggMS82IChD
cml0aWNhbCk6IEZpeCBvZl9ub2RlIHJlZmVyZW5jZSBsZWFrIGluCiAgICByb2NrY2hpcF9kcm1f
ZW5jb2Rlcl9zZXRfY3J0Y19lbmRwb2ludF9pZCgpLiBCb3RoIHN1Y2Nlc3MgYW5kIGVycm9yCiAg
ICBwYXRocyBsZWFrZWQgcmVmZXJlbmNlcyBhY3F1aXJlZCB2aWEgb2ZfZ3JhcGggaGVscGVycy4K
CiAgUGF0Y2ggMi82IChDcml0aWNhbCk6IEZpeCBkYW5nbGluZyBjcnRjLT5zdGF0ZSBpbiB2b3Ay
X2NydGNfcmVzZXQoKS4KICAgIGt6YWxsb2MoKSBmYWlsdXJlIGxlZnQgY3J0Yy0+c3RhdGUgYXMg
YSB1c2UtYWZ0ZXItZnJlZSBwb2ludGVyLgoKICBQYXRjaCAzLzYgKEhpZ2gpOiBGaXggdm9wMl9j
cmVhdGVfY3J0Y3MoKSBlcnJvciBwYXRoIGNsZWFudXAgaW4KICAgIHZvcDJfYmluZCgpLiBGYWls
dXJlcyByZXR1cm5lZCBkaXJlY3RseSB3aXRob3V0IGNhbGxpbmcKICAgIHZvcDJfZGVzdHJveV9j
cnRjcygpLCBsZWFraW5nIG9mX25vZGUgcmVmZXJlbmNlcy4gKHYyOiBmaXhlZAogICAgZG91Ymxl
LWZyZWUgYnkgcmVtb3ZpbmcgbWFudWFsIGRldm1fZnJlZV9pcnEoKSkKCiAgUGF0Y2ggNC82IChI
aWdoKTogRml4IHZtYXAgYWRkcmVzcyBjYWNoaW5nIGluCiAgICByb2NrY2hpcF9nZW1fcHJpbWVf
dm1hcCgpLiBOZXcgdm1hcCgpIHJlc3VsdHMgd2VyZSBub3Qgc2F2ZWQgdG8KICAgIHJrX29iai0+
a3ZhZGRyLCBjYXVzaW5nIHJlcGVhdGVkIG1hcHBpbmdzIGFuZCBwb3RlbnRpYWwgbGVha3MuCgog
IFBhdGNoIDUvNiAoSGlnaCk6IEZpeCBsZWFrZWQgdmJsYW5rIGV2ZW50IGluCiAgICB2b3BfY3J0
Y19hdG9taWNfZGlzYWJsZSgpLiBQZW5kaW5nIHZvcC0+ZXZlbnQgd2FzIHdhcm5lZCBidXQgbmV2
ZXIKICAgIHNlbnQsIGNhdXNpbmcgdXNlcnNwYWNlIGhhbmdzIGFuZCB2YmxhbmsgcmVmZXJlbmNl
IGxlYWtzLiAodjI6CiAgICBmaXhlZCBjaGVja3BhdGNoIGZvcm1hdCBlcnJvcikKCiAgUGF0Y2gg
Ni82IChNZWRpdW0pOiBDaGVjayByZXR1cm4gdmFsdWUgb2YgY2RuX2RwX2dyZl93cml0ZSgpIGlu
CiAgICBjZG5fZHBfZW5hYmxlX3BoeSgpIGVycm9yIHBhdGguIElnbm9yZWQgcmV0dXJuIHZhbHVl
IGNvdWxkIGxlYXZlCiAgICBHUkYgcmVnaXN0ZXJzIGluIGFuIGluY29uc2lzdGVudCBzdGF0ZS4K
CkFsbCBwYXRjaGVzIGhhdmUgYmVlbiB2ZXJpZmllZCBhZ2FpbnN0IGNoZWNrcGF0Y2gucGwgLS1z
dHJpY3QuCgpTaWduZWQtb2ZmLWJ5OiBKaWFxaSA8c2hpamlhcWlfZGV2ZWxvcEAxNjMuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9jZG4tZHAtY29yZS5jICAgICAgIHwgIDUgKysr
LS0KIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmMgIHwgMTQgKysr
KysrKysrLS0tLQogZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9nZW0uYyAg
fCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcC5jICB8IDEx
ICsrKysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIu
YyB8ICAyICstCiA1IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pCg==

