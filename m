Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7417CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E4110FDCF;
	Wed,  3 Jun 2026 13:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="LQ2qGwyO";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECF510FDCF
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=mg6FJchwfJ8zN6I2FUJoXfv9OwhuxxtuYrxZSgqZMwo=; b=L
 Q2qGwyOgZHlMBoHwj51br7LRUPRuIlEK2+0caJH5WEC8C8CwxMbXQQIC9w1oDR9M
 ESrxyKEG07ydC/0aCmG06FgwOsKpiuxkSBkBIlgsJyi0TmkZsjDrnRyjKaxq7YKF
 MsScrXgC36cvFtbzACKhF8exzBx4tKPhPZaD5Ebd44=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Wed, 3 Jun 2026 21:11:05 +0800 (CST)
X-Originating-IP: [58.22.7.114]
Date: Wed, 3 Jun 2026 21:11:05 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Alexey Charkov" <alchark@flipper.net>
Cc: "Sandy Huang" <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 2/2] drm/rockchip: dw_hdmi_qp: expose "overscan" property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260602-hdmi-overscan-v1-2-31f71b817c80@flipper.net>
References: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
 <20260602-hdmi-overscan-v1-2-31f71b817c80@flipper.net>
X-CM-CTRLMSGS: p6ycunBsdXM9MTc4MDQ5MjI2NDk2Ml80Yjg5M2U0ZTNiMzFmOGE0M2VmYWJkZ
 Tk1ZTQ2YTYyYQ==
X-NTES-SC: AL_Qu2TAviSvUot4yKQZOkfmUgWjuw/WsG1v/Ul1YBSP556jDLp4yQsdlhFB13k6v+RMTGlqAieVTxg0OFXWa1WfaYttWbhLTOOMg6JwleuQaNBCQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6f7ae6e2.a68c.19e8d9be74d.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: eCgvCgDnD_XpJyBqUMUBAA--.17783W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbC7QmmBWogJ+mj0wAA3z
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

CkhlbGxvIEFsZXh577yMCgpBdCAyMDI2LTA2LTAzIDAxOjAwOjQwLCAiQWxleGV5IENoYXJrb3Yi
IDxhbGNoYXJrQGZsaXBwZXIubmV0PiB3cm90ZToKPkV4cG9zZSB0aGUgIm92ZXJzY2FuIiBjb25u
ZWN0b3IgcHJvcGVydHkgYXMgcmVjb2duaXplZCBieSBLV2luIGFuZCB0aGUKPmxpa2VzIHRvIGNv
bXBlbnNhdGUgZm9yIFRWIG92ZXJzY2FuIGNyb3BwaW5nLgo+Cj5UaGUgQ1JUQyB3aWxsIHVzZSB0
aGUgbWFyZ2luIHZhbHVlcyBkZXJpdmVkIGZyb20gdGhpcyBvdmVyc2NhbiBwZXJjZW50YWdlCj5p
biBpdHMgcG9zdC1jb21wb3NpdGlvbiBzY2FsZXIgdG8gYWRkIGFwcHJvcHJpYXRlIGJsYW5rIG1h
cmdpbnMgb24gYWxsCj5zaWRlcyBvZiB0aGUgb3V0cHV0IGltYWdlIHNvIHRoYXQgdGhlIFRWIGRv
ZXNuJ3QgZWF0IHVwIHZpc2libGUgY29udGVudC4KPgo+U2lnbmVkLW9mZi1ieTogQWxleGV5IENo
YXJrb3YgPGFsY2hhcmtAZmxpcHBlci5uZXQ+Cj4tLS0KPiBkcml2ZXJzL2dwdS9kcm0vcm9ja2No
aXAvZHdfaGRtaV9xcC1yb2NrY2hpcC5jIHwgMTYgKysrKysrKysrKysrKysrKwo+IDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cm9ja2NoaXAvZHdfaGRtaV9xcC1yb2NrY2hpcC5jIGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlw
L2R3X2hkbWlfcXAtcm9ja2NoaXAuYwo+aW5kZXggZjM1NDg0NzE1YzJkLi5mYWU0NGQxMWRiZWYg
MTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvZHdfaGRtaV9xcC1yb2NrY2hp
cC5jCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvZHdfaGRtaV9xcC1yb2NrY2hpcC5j
Cj5AQCAtMTM3LDEwICsxMzcsMTggQEAgZHdfaGRtaV9xcF9yb2NrY2hpcF9lbmNvZGVyX2F0b21p
Y19jaGVjayhzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsCj4gCQkJCQkgc3RydWN0IGRybV9j
b25uZWN0b3Jfc3RhdGUgKmNvbm5fc3RhdGUpCj4gewo+IAlzdHJ1Y3Qgcm9ja2NoaXBfaGRtaV9x
cCAqaGRtaSA9IHRvX3JvY2tjaGlwX2hkbWlfcXAoZW5jb2Rlcik7Cj4rCWNvbnN0IHN0cnVjdCBk
cm1fZGlzcGxheV9tb2RlICphZGpfbW9kZSA9ICZjcnRjX3N0YXRlLT5hZGp1c3RlZF9tb2RlOwo+
IAlzdHJ1Y3Qgcm9ja2NoaXBfY3J0Y19zdGF0ZSAqcyA9IHRvX3JvY2tjaGlwX2NydGNfc3RhdGUo
Y3J0Y19zdGF0ZSk7Cj4gCXVuaW9uIHBoeV9jb25maWd1cmVfb3B0cyBwaHlfY2ZnID0ge307Cj4r
CXVuc2lnbmVkIGludCBvdmVyc2NhbjsKPiAJaW50IHJldDsKPiAKPisJb3ZlcnNjYW4gPSBtaW4o
Y29ubl9zdGF0ZS0+dHYub3ZlcnNjYW4sIDEwMHUpOwo+KwlzLT50dl9tYXJnaW5zLmxlZnQgICA9
IGFkal9tb2RlLT5oZGlzcGxheSAqIG92ZXJzY2FuIC8gMjAwOwo+KwlzLT50dl9tYXJnaW5zLnJp
Z2h0ICA9IHMtPnR2X21hcmdpbnMubGVmdDsKPisJcy0+dHZfbWFyZ2lucy50b3AgICAgPSBhZGpf
bW9kZS0+dmRpc3BsYXkgKiBvdmVyc2NhbiAvIDIwMDsKPisJcy0+dHZfbWFyZ2lucy5ib3R0b20g
PSBzLT50dl9tYXJnaW5zLnRvcDsKPisKPiAJaWYgKGhkbWktPnRtZHNfY2hhcl9yYXRlID09IGNv
bm5fc3RhdGUtPmhkbWkudG1kc19jaGFyX3JhdGUgJiYKPiAJICAgIHMtPm91dHB1dF9icGMgPT0g
Y29ubl9zdGF0ZS0+aGRtaS5vdXRwdXRfYnBjKQo+IAkJcmV0dXJuIDA7Cj5AQCAtNjAzLDYgKzYx
MSwxNCBAQCBzdGF0aWMgaW50IGR3X2hkbWlfcXBfcm9ja2NoaXBfYmluZChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3RlciwKPiAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGhk
bWktPmRldiwgUFRSX0VSUihjb25uZWN0b3IpLAo+IAkJCQkgICAgICJGYWlsZWQgdG8gaW5pdCBi
cmlkZ2UgY29ubmVjdG9yXG4iKTsKPiAKPisJcmV0ID0gZHJtX21vZGVfY3JlYXRlX3R2X3Byb3Bl
cnRpZXNfbGVnYWN5KGRybSwgMCwgTlVMTCk7Cj4rCWlmIChyZXQpCj4rCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwKPisJCQkJICAgICAiRmFpbGVkIHRvIGNyZWF0ZSBUViBjb25uZWN0
b3IgcHJvcGVydGllc1xuIik7CgogICAgICBJIHN1Z2dlc3QgY2FsbGluZyBhIHNpbWlsYXIgQVBJ
IHdpdGhpbiByb2NrY2hpcF9kcm1fYmluZCwgYW5kIHRoZW4gYXR0YWNoaW5nIHRoaXMgcHJvcGVy
dHkgaW4KdGhlIGNvbm5lY3RvciBkcml2ZXJzIHRoYXQgbmVlZCB0byBleHBvc2UgaXQuIFRoaXMg
YXBwcm9hY2ggYXZvaWRzIGludm9raW5nIHRoZSBBUEkgbXVsdGlwbGUgdGltZXMgaW4gbXVsdGlw
bGUgZHJpdmVyc+OAggoKPisKPisJZHJtX29iamVjdF9hdHRhY2hfcHJvcGVydHkoJmNvbm5lY3Rv
ci0+YmFzZSwKPisJCQkJICAgZHJtLT5tb2RlX2NvbmZpZy50dl9vdmVyc2Nhbl9wcm9wZXJ0eSwg
MCk7Cj4rCj4gCXJldHVybiAwOwo+IH0KPiAKPgo+LS0gCj4yLjUyLjAKPgo+Cj5fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+TGludXgtcm9ja2NoaXAgbWFp
bGluZyBsaXN0Cj5MaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnCj5odHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
